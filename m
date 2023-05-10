Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 711BA6FE27A
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 18:29:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232394AbjEJQ3k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 12:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbjEJQ3h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 12:29:37 -0400
X-Greylist: delayed 561 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 10 May 2023 09:29:33 PDT
Received: from mail.icequake.net (64-251-151-187.fidnet.com [64.251.151.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F8F1993
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 09:29:33 -0700 (PDT)
Received: from mail.icequake.net (aurora [127.0.0.1])
        by mail.icequake.net (Postfix) with ESMTP id A571CD40D3;
        Wed, 10 May 2023 11:20:10 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icequake.net;
        s=mail-1; t=1683735610; x=1684340410;
        bh=6cS+j1VRYNpWo0Wuv7yVjob9ieRCBGEGS8tiLASM/To=;
        h=Date:From:To:Cc:Subject:Reply-To:Subject:From:To:Date;
        b=n6Ekn8bbIpwtx12UqCvx7E7uvT8FYn3NQ6yxhyq8EjFRcXbGFDEfwswf5uVt9xqH5
         /X4TwayNemtg4fB81SW3lqHKjSaPTQDOzpG59/X4Q/VgOBx9OKo0DKPTAjnDKV46uA
         mCzhlqA9qJpBy9mXmDTmjQ2ZOkiwI+o0dMDjMfow=
Received: from localhost (aurora [127.0.0.1])
        by mail.icequake.net (Postfix) with ESMTP id 7697ED42C7;
        Wed, 10 May 2023 11:20:10 -0500 (CDT)
X-Virus-Scanned: Debian amavisd-new at icequake.net
Received: from mail.icequake.net ([127.0.0.1])
        by localhost (aurora.icequake.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id O_wH484lYCTR; Wed, 10 May 2023 11:20:08 -0500 (CDT)
Received: from localhost (rrcs-71-42-125-220.sw.biz.rr.com [71.42.125.220])
        (Authenticated sender: nemesis@icequake.net)
        by mail.icequake.net (Postfix) with ESMTPSA id A0B2AD40D3;
        Wed, 10 May 2023 11:20:08 -0500 (CDT)
Date:   Wed, 10 May 2023 11:19:08 -0500
From:   "Ryan C. Underwood" <nemesis-lists@icequake.net>
To:     alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Meng Tang <tangmeng@uniontech.com>,
        Andy Chi <andy.chi@canonical.com>,
        "Luke D. Jones" <luke@ljones.dev>,
        Philipp Jungkamp <p.jungkamp@gmx.net>,
        Kacper =?utf-8?Q?Michaj=C5=82ow?= <kasper93@gmail.com>,
        Yuchi Yang <yangyuchi66@gmail.com>,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org
Subject: [PATCH] snd-hda-intel: Apply HP B&O top speaker profile to Pavilion
 15
Message-ID: <ZFvD/HwNPd6xuCMo@icequake.net>
Reply-To: nemesis@icequake.net
Mail-Followup-To: alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>, Takashi Iwai <tiwai@suse.com>,
        Stefan Binding <sbinding@opensource.cirrus.com>,
        Meng Tang <tangmeng@uniontech.com>,
        Andy Chi <andy.chi@canonical.com>,
        "Luke D. Jones" <luke@ljones.dev>,
        Philipp Jungkamp <p.jungkamp@gmx.net>,
        Kacper =?utf-8?Q?Michaj=C5=82ow?= <kasper93@gmail.com>,
        Yuchi Yang <yangyuchi66@gmail.com>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="90BXrl9KsEnGw98J"
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--90BXrl9KsEnGw98J
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


The Pavilion 15 line has B&O top speakers similar to the x360 and
applying the same profile produces good sound.  Without this, the sound
would be tinny and underpowered without either applying
model=3Dalc295-hp-x360 or booting another OS first.
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e103bb3693c0..7cb232a23a08 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9335,7 +9335,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] =
=3D {
 	SND_PCI_QUIRK(0x103c, 0x802f, "HP Z240", ALC221_FIXUP_HP_MIC_NO_PRESENCE),
 	SND_PCI_QUIRK(0x103c, 0x8077, "HP", ALC256_FIXUP_HP_HEADSET_MIC),
 	SND_PCI_QUIRK(0x103c, 0x8158, "HP", ALC256_FIXUP_HP_HEADSET_MIC),
-	SND_PCI_QUIRK(0x103c, 0x820d, "HP Pavilion 15", ALC269_FIXUP_HP_MUTE_LED_=
MIC3),
+	SND_PCI_QUIRK(0x103c, 0x820d, "HP Pavilion 15", ALC295_FIXUP_HP_X360),
 	SND_PCI_QUIRK(0x103c, 0x8256, "HP", ALC221_FIXUP_HP_FRONT_MIC),
 	SND_PCI_QUIRK(0x103c, 0x827e, "HP x360", ALC295_FIXUP_HP_X360),
 	SND_PCI_QUIRK(0x103c, 0x827f, "HP x360", ALC269_FIXUP_HP_MUTE_LED_MIC3),
--=20
2.39.2


--=20
Ryan C. Underwood, <nemesis@icequake.net>

--90BXrl9KsEnGw98J
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSqqegowG2kcGXAAAMiiceeH7ruOQUCZFvD+AAKCRAiiceeH7ru
OWuxAJ4/b/bKgxGdMv4EroO2HzeGV/b85gCdEgaJIiCFKUsShQnEFF+WBEBBYO4=
=jase
-----END PGP SIGNATURE-----

--90BXrl9KsEnGw98J--
