Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5052B664D7F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 21:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234011AbjAJUdQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 15:33:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235428AbjAJUc0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 15:32:26 -0500
X-Greylist: delayed 304 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 10 Jan 2023 12:30:51 PST
Received: from mout.web.de (mout.web.de [212.227.15.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2EC0254
        for <linux-kernel@vger.kernel.org>; Tue, 10 Jan 2023 12:30:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=web.de; s=s29768273;
        t=1673382650; bh=MEejYbw8dcDa3DUGUZRzzPL8AkL59tjy8R6jRGsfjOY=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:Date;
        b=ZTVHezLYVcWvMFYAtqEdtmMUYDRtmCD9AbXijM+oSU965xmX69sHt3I9nCQ5SkbJQ
         OZ7vMx4HNGSpBqhY3djvUsE2JRoiM5tA9uxdAhC1ZnWQXQ1tcOGAqk2T9Z/NLmHD13
         m7yz2ItySPFmcugzjCHQHrDdoopC7jQDcmQD5z97Mp2jAzG/Oebiu0+vp8alB6RS/H
         3vDh/Ix/fVWVmEMEeoYDULfae4Bfi36si6oUbNWJ0T0XwobstjHlp5NtbAYirINb4P
         L1m0x9SMZiDUdwf9hpJ1Lwg5JO8hK/3np00LmMkJEDsWOW4b+Cge6AfZtxBShhliNu
         j+vRHqey7ymQw==
X-UI-Sender-Class: 814a7b36-bfc1-4dae-8640-3722d8ec6cd6
Received: from luka-spectre.fritz.box ([93.129.44.167]) by smtp.web.de
 (mrweb005 [213.165.67.108]) with ESMTPSA (Nemesis) id
 1MVJRb-1pNHnc0G4l-00SRYv; Tue, 10 Jan 2023 21:25:43 +0100
From:   Luka Guzenko <l.guzenko@web.de>
To:     tiwai@suse.com
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        Luka Guzenko <l.guzenko@web.de>
Subject: [PATCH v2] ALSA: hda/realtek: Enable mute/micmute LEDs on HP Spectre x360 13-aw0xxx
Date:   Tue, 10 Jan 2023 21:25:14 +0100
Message-Id: <20230110202514.2792-1-l.guzenko@web.de>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
X-Provags-ID: V03:K1:/szKTTJvCAPwW11ClrWP49WM+KH1T+Wcs9r+r+84lKyxX0LdTXO
 90IyXQGm0GYJeqnkDxdxpxozHnsD7+xNQzqndUF01e/WtN/qjDpbEAwESEOOW32GCcXUTeV
 31cOopdhgcwya7/U4cSjqR2YcML2grX5HXcMO0Kxqp5xXW2fEH4KP9iNcV2W0RP+qeozqrw
 4yhGmPQnD4ami7787DqnQ==
UI-OutboundReport: notjunk:1;M01:P0:DjfyAuGEteY=;QBlprupfP+Lk6sTAhnk8kqOen7A
 9sH6tsE7NzwNPe4O1v43Iiiy/81UvkehGmaXX2B5sfRNzr0+ospW5aOehE6ZgPzYYPSYTTo1j
 kxIV6wlqQDds+j+GPnPbVL+yjvEAiD1e+oa5dR4J+T52k73wa5V7fLC0ZIeDxwFgup43mhgCw
 OPvRAr0qRksMbX2CowcPVlKeAobRVmxgAi+muY/LNTHMXRdx3QBJb3RfXrqCI0iyg1VO179iC
 MlrQNMhJ6JQPbf7+QOQ+G8wS+MwHCioyBdw3okaCR0P4+meTe8CSq4J6ZL42OxzhqnzvAF/ae
 onmAoAipiiJY4y7EW42sF41oVhOPOTk0sJl8QdgWPnctADahpDTZk/A5CSs+kGEcN9OXMmws9
 JADpJCOOR/eVg4fS5rBgc6rC+QjPwTCu9cGj8BZ1fHTG4tFJxgQGVZ5XRh4dVmYFYrh1DSrDV
 xHCZQTE4yR5eDPGSkbh35eJIfHUyHQuQxWEsQ0DWIxYIsLUTa5rsopYCseMVeveiqyGVO0lOP
 FSU7Wngv27wtk5mBa2UsiLT+aRtqFV8+N5OnxF9WxJR5eoBUw2XA7c2CvvcoT2EeMKcq0sBSJ
 9UR92PKm/rSrBv1ISNwbxljBkqE/dy2Qeh8vFcuPG6js7cWlsdicB8bRsr11QEmz6+zYiVm7q
 UL+jj8wU2jFpToxQ0ndbdxs6VhGDxdhubw5c9nA0Zo0xytxsJgUF3qqmQh/LFkVT6MGiz/EYj
 IO2KFuozEUWc8vYepva/1jbVWilBNUUH3TLyd0Lb1FFuzC34EjWy1X+y9znunL5ZXTEfuTwN9
 uaYlzFajmY4HUYPYyFPehWMMHBRjPJgsB3Zvc2W69XJF3tgYXfueDMJVKhEVG/5ZXyEZiWE80
 oqitV2MDL+vJhnPQb1EPsy87W4A9s6KlRLrIXJcqsfVOFKzSeMma1vURC4NQ93vkgIZWVoJR6
 kfTeGk5LtRlGyNpzvMdS+AAtaUk=
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The HP Spectre x360 13-aw0xxx devices use the ALC285 codec with GPIO 0x04
controlling the micmute LED and COEF 0x0b index 8 controlling the mute LED=
.
A quirk was added to make these work as well as a fixup.

Signed-off-by: Luka Guzenko <l.guzenko@web.de>
=2D--
V1 -> V2: Inverted the conditional statement in
	  alc285_fixup_hp_gpio_micmute_led as suggested by Takashi Iwai

 sound/pci/hda/patch_realtek.c | 23 +++++++++++++++++++++++
 1 file changed, 23 insertions(+)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index 3794b522c222..dc4b07a0c240 100644
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
+	if (action =3D=3D HDA_FIXUP_ACT_PRE_PROBE)
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

