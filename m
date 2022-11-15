Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0462F6294C1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:47:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238158AbiKOJrg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:47:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238128AbiKOJr2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:47:28 -0500
Received: from mail-wr1-x42f.google.com (mail-wr1-x42f.google.com [IPv6:2a00:1450:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 577DF22B35
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:47:22 -0800 (PST)
Received: by mail-wr1-x42f.google.com with SMTP id y16so23258228wrt.12
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:47:22 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=q5gqNb4R3TCmsTjxL2pf0EsNhmAZirXSSDBycfH18cc=;
        b=pnOfBLrbaqy4Pei/HD4GII0nH2mTPlkFYJOvRSazXnHk1mc4QO6s3p0KAHQl145dFJ
         xdRDoMDbJ5PdjEXFJTkVGq9j7Rbzj720HaGuOVj4RWj2AuPElHK7SiBt7Cktu6icOH6P
         2qGhihtCr0xmSTxZQCQ3S63EF/2gJ/MmXK14Hhnbznr/6oVqySuBfXOV7PvUtbMk7LIm
         hrtwyzR0O6ZjxW62r0QMQcCWxz08WEtqi00l7+U0n6lj4Hb3cV3riG10Zdh95w9pYmJa
         2I8pQszre0vup7HsFkXjEzk/cPu583YIE/wsH2eFrrw8CgWSD7Y7kPw+zpvCqDh/Bf+0
         t7sQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=q5gqNb4R3TCmsTjxL2pf0EsNhmAZirXSSDBycfH18cc=;
        b=QJwKCdLtgGOd2sxKM1YWAC44TdO9idM1FxXHghRchjYXBLndCnQKlLoM4F849iGD5M
         vh4VQsWtdT4ae0L90qW1eHtJqVNy4NUNgme3aLZko3mjai3rs/RfVEqgpFSPDidaWAep
         9lqhCuzaWEqzWpwq/OgYxEAHTbYi1CCowAHvJJqXfoaNmKubiQqEbQMzRTL8oMg3D+ib
         mLw8mBHVO2wiKGXL5AbGX+lEo8RDjctZ/pleVnK8Dqv8Q3z699JT+PP8BqPkjD8sY2yt
         HLiu2CS7Ca+NkfKy+zibPdV5WHmW4bFfaOR2PKyhEhkwqRXdhNdpsDrxUtRghcYMnWI0
         SW7g==
X-Gm-Message-State: ANoB5pn1QRDE2oh3xphbDNDtRfNGsRqzx3bPVIKdUF19TVkgLDUrZ6mm
        OTOncYsqbqSXHlRdRl1aiow=
X-Google-Smtp-Source: AA0mqf5mHwLItJnYefRtBMCG9d/z/wpGZvNXqKkaXS07LEPLyOr9TLsrPxSB5pJMA6cA/lgWkW4URA==
X-Received: by 2002:adf:f5c5:0:b0:22e:597:8541 with SMTP id k5-20020adff5c5000000b0022e05978541mr10415093wrp.612.1668505640673;
        Tue, 15 Nov 2022 01:47:20 -0800 (PST)
Received: from arch.localdomain ([119.160.120.210])
        by smtp.gmail.com with ESMTPSA id p14-20020a5d458e000000b0022eafed36ebsm11904866wrq.73.2022.11.15.01.47.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 01:47:20 -0800 (PST)
From:   Mushahid Hussain <mushi.shar@gmail.com>
To:     samuel.thibault@ens-lyon.org
Cc:     okash.khawaja@gmail.com, speakup@linux-speakup.org,
        linux-kernel@vger.kernel.org,
        Mushahid Hussain <mushi.shar@gmail.com>
Subject: [PATCHv2 2/2] accessibility: speakup: phonetic spelling while arrowing letter by letter
Date:   Tue, 15 Nov 2022 14:48:12 +0500
Message-Id: <20221115094812.81632-3-mushi.shar@gmail.com>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221115094812.81632-1-mushi.shar@gmail.com>
References: <20221115094812.81632-1-mushi.shar@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch includes an enhancement requested frequently on the mailing
list.[1][2] It adds a variable, cur_phonetic in the spk_vars, which can
be set as a module parameter, as well as in /sys/speakup/cur_phonetic.
This patch also documents cur_phonetic as a sysfs attribute in
sysfs-driver-speakup.

When cur_phonetic=1, it causes speakup to speak letters phonetically if
paused on the character while arrowing through a word.

When a user does not set cur_phonetic to any value, the default value
for it would be 0.

[1]: https://github.com/linux-speakup/speakup/issues/6
[2]: https://github.com/linux-speakup/speakup/issues/5

since V1:
	- removed unnecessary lines

Signed-off-by: Mushahid Hussain<mushi.shar@gmail.com>
---
 Documentation/ABI/stable/sysfs-driver-speakup |  9 +++++++++
 drivers/accessibility/speakup/kobjects.c      |  3 +++
 drivers/accessibility/speakup/main.c          | 14 +++++++++++---
 drivers/accessibility/speakup/speakup.h       |  1 +
 drivers/accessibility/speakup/spk_types.h     |  2 +-
 drivers/accessibility/speakup/varhandlers.c   |  1 +
 6 files changed, 26 insertions(+), 4 deletions(-)

diff --git a/Documentation/ABI/stable/sysfs-driver-speakup b/Documentation/ABI/stable/sysfs-driver-speakup
index dc2a6ba1674b..bcb6831aa114 100644
--- a/Documentation/ABI/stable/sysfs-driver-speakup
+++ b/Documentation/ABI/stable/sysfs-driver-speakup
@@ -35,6 +35,15 @@ Description:	This controls cursor delay when using arrow keys. When a
 		characters. Set this to a higher value to adjust for the delay
 		and better synchronisation between cursor position and speech.

+What:		/sys/accessibility/speakup/cur_phonetic
+KernelVersion:	6.2
+Contact:	speakup@linux-speakup.org
+Description:	This allows speakup to speak letters phoneticaly when arrowing through
+		a word letter by letter. This doesn't affect the spelling when typing
+		the characters. When cur_phonetic=1, speakup will speak characters
+		phoneticaly when arrowing over a letter. When cur_phonetic=0, speakup
+		will speak letters as normally.
+
 What:		/sys/accessibility/speakup/delimiters
 KernelVersion:	2.6
 Contact:	speakup@linux-speakup.org
diff --git a/drivers/accessibility/speakup/kobjects.c b/drivers/accessibility/speakup/kobjects.c
index 41ae24ab5d08..a7522d409802 100644
--- a/drivers/accessibility/speakup/kobjects.c
+++ b/drivers/accessibility/speakup/kobjects.c
@@ -914,6 +914,8 @@ static struct kobj_attribute say_word_ctl_attribute =
 	__ATTR(say_word_ctl, 0644, spk_var_show, spk_var_store);
 static struct kobj_attribute spell_delay_attribute =
 	__ATTR(spell_delay, 0644, spk_var_show, spk_var_store);
+static struct kobj_attribute cur_phonetic_attribute =
+	__ATTR(cur_phonetic, 0644, spk_var_show, spk_var_store);

 /*
  * These attributes are i18n related.
@@ -967,6 +969,7 @@ static struct attribute *main_attrs[] = {
 	&say_control_attribute.attr,
 	&say_word_ctl_attribute.attr,
 	&spell_delay_attribute.attr,
+	&cur_phonetic_attribute.attr,
 	NULL,
 };

diff --git a/drivers/accessibility/speakup/main.c b/drivers/accessibility/speakup/main.c
index 2e6e0649fe90..987fd29b6786 100644
--- a/drivers/accessibility/speakup/main.c
+++ b/drivers/accessibility/speakup/main.c
@@ -65,6 +65,7 @@ int spk_key_echo, spk_say_word_ctl;
 int spk_say_ctrl, spk_bell_pos;
 short spk_punc_mask;
 int spk_punc_level, spk_reading_punc;
+int spk_cur_phonetic;
 char spk_str_caps_start[MAXVARLEN + 1] = "\0";
 char spk_str_caps_stop[MAXVARLEN + 1] = "\0";
 char spk_str_pause[MAXVARLEN + 1] = "\0";
@@ -1273,7 +1274,7 @@ enum spk_vars_id {
 	BLEEPS_ID, BLEEP_TIME_ID, PUNC_LEVEL_ID,
 	READING_PUNC_ID, CURSOR_TIME_ID, SAY_CONTROL_ID,
 	SAY_WORD_CTL_ID, NO_INTERRUPT_ID, KEY_ECHO_ID,
-	V_LAST_VAR_ID, NB_ID
+	CUR_PHONETIC_ID, V_LAST_VAR_ID, NB_ID
 };

 static struct var_t spk_vars[NB_ID] = {
@@ -1290,6 +1291,7 @@ static struct var_t spk_vars[NB_ID] = {
 	[SAY_WORD_CTL_ID] = {SAY_WORD_CTL, TOGGLE_0},
 	[NO_INTERRUPT_ID] = { NO_INTERRUPT, TOGGLE_0},
 	[KEY_ECHO_ID] = { KEY_ECHO, .u.n = {NULL, 1, 0, 2, 0, 0, NULL} },
+	[CUR_PHONETIC_ID] = { CUR_PHONETIC, .u.n = {NULL, 0, 0, 1, 0, 0, NULL} },
 	V_LAST_VAR
 };

@@ -1720,8 +1722,12 @@ static void cursor_done(struct timer_list *unused)
 		speakup_win_say(vc);
 	else if (is_cursor == 1 || is_cursor == 4)
 		say_line_from_to(vc, 0, vc->vc_cols, 0);
-	else
-		say_char(vc);
+	else {
+		if (spk_cur_phonetic == 1)
+			say_phonetic_char(vc);
+		else
+			say_char(vc);
+	}
 	spk_keydown = 0;
 	is_cursor = 0;
 out:
@@ -2473,6 +2479,7 @@ module_param_named(say_control, spk_vars[SAY_CONTROL_ID].u.n.default_val, int, 0
 module_param_named(say_word_ctl, spk_vars[SAY_WORD_CTL_ID].u.n.default_val, int, 0444);
 module_param_named(no_interrupt, spk_vars[NO_INTERRUPT_ID].u.n.default_val, int, 0444);
 module_param_named(key_echo, spk_vars[KEY_ECHO_ID].u.n.default_val, int, 0444);
+module_param_named(cur_phonetic, spk_vars[CUR_PHONETIC_ID].u.n.default_val, int, 0444);

 MODULE_PARM_DESC(bell_pos, "This works much like a typewriter bell. If for example 72 is echoed to bell_pos, it will beep the PC speaker when typing on a line past character 72.");
 MODULE_PARM_DESC(spell_delay, "This controls how fast a word is spelled when speakup's spell word review command is pressed.");
@@ -2486,6 +2493,7 @@ MODULE_PARM_DESC(say_control, "This controls if speakup speaks shift, alt and co
 MODULE_PARM_DESC(say_word_ctl, "Sets thw say_word_ctl  on load.");
 MODULE_PARM_DESC(no_interrupt, "Controls if typing interrupts output from speakup.");
 MODULE_PARM_DESC(key_echo, "Controls if speakup speaks keys when they are typed. One = on zero = off or don't echo keys.");
+MODULE_PARM_DESC(cur_phonetic, "Controls if speakup speaks letters phonetically during navigation. One = on zero = off or don't speak phonetically.");

 module_init(speakup_init);
 module_exit(speakup_exit);
diff --git a/drivers/accessibility/speakup/speakup.h b/drivers/accessibility/speakup/speakup.h
index 33594f5a7983..364fde99749e 100644
--- a/drivers/accessibility/speakup/speakup.h
+++ b/drivers/accessibility/speakup/speakup.h
@@ -105,6 +105,7 @@ extern int spk_no_intr, spk_say_ctrl, spk_say_word_ctl, spk_punc_level;
 extern int spk_reading_punc, spk_attrib_bleep, spk_bleeps;
 extern int spk_bleep_time, spk_bell_pos;
 extern int spk_spell_delay, spk_key_echo;
+extern int spk_cur_phonetic;
 extern short spk_punc_mask;
 extern short spk_pitch_shift, synth_flags;
 extern bool spk_quiet_boot;
diff --git a/drivers/accessibility/speakup/spk_types.h b/drivers/accessibility/speakup/spk_types.h
index 3a14d39bf896..08011518a28a 100644
--- a/drivers/accessibility/speakup/spk_types.h
+++ b/drivers/accessibility/speakup/spk_types.h
@@ -49,7 +49,7 @@ enum var_id_t {
 	RATE, PITCH, VOL, TONE, PUNCT, VOICE, FREQUENCY, LANG,
 	DIRECT, PAUSE,
 	CAPS_START, CAPS_STOP, CHARTAB, INFLECTION, FLUSH,
-	MAXVARS
+	CUR_PHONETIC, MAXVARS
 };

 typedef int (*special_func)(struct vc_data *vc, u_char type, u_char ch,
diff --git a/drivers/accessibility/speakup/varhandlers.c b/drivers/accessibility/speakup/varhandlers.c
index e1c9f42e39f0..462f8d879053 100644
--- a/drivers/accessibility/speakup/varhandlers.c
+++ b/drivers/accessibility/speakup/varhandlers.c
@@ -48,6 +48,7 @@ static struct st_var_header var_headers[] = {
 	{ "chartab", CHARTAB, VAR_PROC, NULL, NULL },
 	{ "direct", DIRECT, VAR_NUM, NULL, NULL },
 	{ "pause", PAUSE, VAR_STRING, spk_str_pause, NULL },
+	{ "cur_phonetic", CUR_PHONETIC, VAR_NUM, &spk_cur_phonetic, NULL },
 };

 static struct st_var_header *var_ptrs[MAXVARS] = { NULL, NULL, NULL };
--
2.38.1
