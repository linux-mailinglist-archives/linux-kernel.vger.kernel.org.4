Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 526536635EB
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 00:59:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235085AbjAIX7H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 18:59:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231358AbjAIX7E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 18:59:04 -0500
Received: from mout.web.de (mout.web.de [212.227.15.4])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E1E1B1D0
        for <linux-kernel@vger.kernel.org>; Mon,  9 Jan 2023 15:59:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1673308738; bh=FMcjA51wpzoraSDLjxsaLpmF0naPwUP70E0dsefK2kE=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=NbrIC3v4a9JK1+VGa/iF+OJMNNgwwbr5/9+6WqgaTSYBnndWJ1QraPOFr/KNPucw8
         WSqa6XlXlQfJ/Ozs2j0YXBWn43rpSeUVtotji1s3bVcvvvg91wvH1PdHoZEoDO3YoQ
         UBJ/QiBjEefElAcJuLUYfWHRVEXZOWrrdxNOEtQ+NLcjze47U69VnleNzn9qcy496c
         kTQmSQ1y48qinlUfm98mQGGh2Kzd1D9oO1Xy1Mr4cHg0vF1qFDRGl3Q5rh0J7HUI8b
         lTkHDMuvUg4vLcHPxtSxBhFILeNHBjtRY1EARUnXjNayua7CwALxfpPB4DzquYMxwn
         9WJ3hWfwHmLVg==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from luka-spectre.fritz.box ([77.180.184.175]) by smtp.web.de
 (mrweb006 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MxYXF-1or3992FVh-00xcIG; Tue, 10 Jan 2023 00:58:58 +0100
From:   Luka Guzenko <l.guzenko@web.de>
To:     tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Luka Guzenko <l.guzenko@web.de>
Subject: [PATCH] ALSA: hda/realtek: Enable mute/micmute LEDs on HP Spectre x360 13-aw0xxx
Date:   Tue, 10 Jan 2023 00:58:40 +0100
Message-Id: <20230109235840.26452-1-l.guzenko@web.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:XouvoeaEbNqWsNABGNhUZH/5qo2PXjBy/mxzbDIEJNW6259sGQg
 KSGr0Ds2MNYakBIeGzHn7hOdD79CoKopik/RnSF374hafAZGwP5U05njMd3x5PGbzf0kKSx
 au3xD3a2JTTmdoKWzZ4ilqh7cvoflxoHm4RwNhZYfRcgoCZLKGrfLjkzmY8OdDIKwpaGd/M
 L0+saHHyjiudMaIzMFvMQ==
UI-OutboundReport: notjunk:1;M01:P0:1jhPLbLZR4k=;CsQR9QSobUElphVxrW7w7TsPNx5
 LMo1MAkiKVCtl6fG1on8BaoMHDCuES4ge+kHT9KPiDBwX6CZQkiKWbaJLvmb7Eswc8M/bCOFj
 ma3Ru8mInsVOW16B6pbLpfvEo5T8LQOFnyxkSyhiLRGJbsSxUY47MEeGFlATlp/k4fSEGOjm+
 U46FYZuzCJ295yRHQ4ud48aee4asuxNnk5sw/tRNwFvvWGuduLeWyNO96yf24A9n074ZBxlM8
 mKbe+2iuJbaujMjuPx+U/GvAeqa2fJfPyTPfZQlWW5zguNAS5gNxXyLD1WoGsy6/5qVrCfZxp
 zqpYpBmvHmkNgFDQWdjqNC4r/MqHnqrzckQ7g0dKwPzlf4h/b0SGQpmHo/Q5UIPVwFWLTVqf8
 9swkv8M+fG4irmdiQFoqh5sMHtYCV8qxkrVkejg1kcGscqHsMr86CSKKyb7h37z75oy54o1ED
 3xb+tT+gIn9/QDOve6NvRH/cOAmxNDNRUg1iRJPjy5kWA8vKbLNvdSjbeJj/4zQcL7ssLMQbP
 1WqzO047Z7uZMG9Srw1UQtuwqGtb9HaS1wbtu1Dt2gnHh0bjOitajE2SGFf0Xaji4xSUXNXTX
 HpzgAoTrxObn9+8LJzLoKecQL1cM+wqtrwIeOQ/Cvy2WvvxL1MwUw1tfuv0Gu5HA//9aZ7PTF
 hgOkECqbQkt4VQ4WNpLyocedNfOfrQRyFaG5KmuOJ2KC+CL6ye/cHD5qyq5T9zYHd1GdEx9Kg
 LJHfmC3+xSx5x3B1L9wBYxfmFvu8LW1l6Y2SED9dGb2d8FzrTkrolmj4M/t1dsHKmlWcKW78R
 Cj5qx2u8SUKE6adH1Wa6ioHGto8ub1f/BajikPw3doz7gY0UFPB8zxPhojIvFMCbuLM/txjyH
 2IEmsAKp802hXHbdjOkpr2P799t4jSXWf0ygJgdAaahktYlDIW0NHKpMnZvHwze2BNo5/xoR6
 /dpydtvozCZ2VYXchV9ykvLq9ZQ=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HP Spectre x360 13-aw0xxx devices use the ALC285 codec with GPIO 0x04
controlling the micmute LED and COEF 0x0b index 8 controlling the mute LED=
.
A quirk was added to make these work as well as a fixup entry.

Signed-off-by: Luka Guzenko <l.guzenko@web.de>
=2D--
 sound/pci/hda/patch_realtek.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3794b522c222..6a76a2eddd3c 100644
=2D-- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -4644,6 +4644,16 @@ static void alc285_fixup_hp_coef_micmute_led(struct=
 hda_codec *codec,
 	}
 }

+static void alc285_fixup_hp_gpio_micmute_led(struct hda_codec *codec,
+				const struct hda_fixup *fix, int action)
+{
+	struct alc_spec *spec =3D codec->spec;
+
+	if (action !=3D HDA_FIXUP_ACT_PRE_PROBE)
+		spec->micmute_led_polarity =3D 1;
+	alc_fixup_hp_gpio_led(codec, action, 0, 0x04);
+}
+
 static void alc236_fixup_hp_coef_micmute_led(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -4665,6 +4675,13 @@ static void alc285_fixup_hp_mute_led(struct hda_cod=
ec *codec,
 	alc285_fixup_hp_coef_micmute_led(codec, fix, action);
 }

+static void alc285_fixup_hp_spectre_x360_mute_led(struct hda_codec *codec=
,
+				const struct hda_fixup *fix, int action)
+{
+	alc285_fixup_hp_mute_led_coefbit(codec, fix, action);
+	alc285_fixup_hp_gpio_micmute_led(codec, fix, action);
+}
+
 static void alc236_fixup_hp_mute_led(struct hda_codec *codec,
 				const struct hda_fixup *fix, int action)
 {
@@ -7106,6 +7123,7 @@ enum {
 	ALC285_FIXUP_ASUS_G533Z_PINS,
 	ALC285_FIXUP_HP_GPIO_LED,
 	ALC285_FIXUP_HP_MUTE_LED,
+	ALC285_FIXUP_HP_SPECTRE_X360_MUTE_LED,
 	ALC236_FIXUP_HP_GPIO_LED,
 	ALC236_FIXUP_HP_MUTE_LED,
 	ALC236_FIXUP_HP_MUTE_LED_MICMUTE_VREF,
@@ -8486,6 +8504,10 @@ static const struct hda_fixup alc269_fixups[] =3D {
 		.type =3D HDA_FIXUP_FUNC,
 		.v.func =3D alc285_fixup_hp_mute_led,
 	},
+	[ALC285_FIXUP_HP_SPECTRE_X360_MUTE_LED] =3D {
+		.type =3D HDA_FIXUP_FUNC,
+		.v.func =3D alc285_fixup_hp_spectre_x360_mute_led,
+	},
 	[ALC236_FIXUP_HP_GPIO_LED] =3D {
 		.type =3D HDA_FIXUP_FUNC,
 		.v.func =3D alc236_fixup_hp_gpio_led,
@@ -9327,6 +9349,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[]=
 =3D {
 	SND_PCI_QUIRK(0x103c, 0x86c7, "HP Envy AiO 32", ALC274_FIXUP_HP_ENVY_GPI=
O),
 	SND_PCI_QUIRK(0x103c, 0x86e7, "HP Spectre x360 15-eb0xxx", ALC285_FIXUP_=
HP_SPECTRE_X360_EB1),
 	SND_PCI_QUIRK(0x103c, 0x86e8, "HP Spectre x360 15-eb0xxx", ALC285_FIXUP_=
HP_SPECTRE_X360_EB1),
+	SND_PCI_QUIRK(0x103c, 0x86f9, "HP Spectre x360 13-aw0xxx", ALC285_FIXUP_=
HP_SPECTRE_X360_MUTE_LED),
 	SND_PCI_QUIRK(0x103c, 0x8716, "HP Elite Dragonfly G2 Notebook PC", ALC28=
5_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8720, "HP EliteBook x360 1040 G8 Notebook PC", A=
LC285_FIXUP_HP_GPIO_AMP_INIT),
 	SND_PCI_QUIRK(0x103c, 0x8724, "HP EliteBook 850 G7", ALC285_FIXUP_HP_GPI=
O_LED),
=2D-
2.39.0

