package de.develappers.switcher

import android.annotation.SuppressLint
import androidx.appcompat.app.AppCompatActivity
import android.os.Bundle
import android.widget.Button
import android.widget.EditText
import android.widget.LinearLayout
import android.widget.TextView
import androidx.appcompat.widget.SwitchCompat;
import de.develappers.switcher.bridge.HistoryEntry
import java.sql.Date
import java.text.SimpleDateFormat
import java.util.*

class MainActivity : AppCompatActivity() {
    private lateinit var editText: EditText
    private lateinit var tv: TextView
    private lateinit var histories: HistoryEntry

    @SuppressLint("MissingInflatedId")
    override fun onCreate(savedInstanceState: Bundle?) {
        super.onCreate(savedInstanceState)
        setContentView(R.layout.activity_main)
        editText = findViewById(R.id.editText)
        tv = findViewById(R.id.tv)

        val button = findViewById<Button>(R.id.button)
        button.setOnClickListener {
            startActivity(
                FlutterSwitcherActivity.withState(
                    this,
                    editText.text.toString()
                ) { state ->
                    addNewState(state)


                })
        }
    }

    private fun addNewState(entry: HistoryEntry) {
        entry.apply {
            tv.text =
                buildString {
                    append(state[DataKeys.TITLE].toString())
                    append(state[DataKeys.SUBTITLE])
                    append(state[DataKeys.TOKEN].toString())
                }
            val card = layoutInflater.inflate(R.layout.history_entry, null)
            card.findViewById<TextView>(R.id.state).text = state[DataKeys.TITLE].toString()
            card.findViewById<TextView>(R.id.at).text = state[DataKeys.SUBTITLE].toString()
            card.findViewById<TextView>(R.id.source).text = state[DataKeys.TOKEN].toString()
        }
    }

}