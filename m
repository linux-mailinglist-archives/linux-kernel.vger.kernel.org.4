Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E0B06FF94B
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 20:05:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239178AbjEKSFr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 14:05:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239148AbjEKSFe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 14:05:34 -0400
X-Greylist: delayed 925 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 11 May 2023 11:05:01 PDT
Received: from mail.icequake.net (64-251-151-187.fidnet.com [64.251.151.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D67B0A5EB
        for <linux-kernel@vger.kernel.org>; Thu, 11 May 2023 11:05:01 -0700 (PDT)
Received: from mail.icequake.net (aurora [127.0.0.1])
        by mail.icequake.net (Postfix) with ESMTP id 57CA8D4317;
        Thu, 11 May 2023 12:35:10 -0500 (CDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=icequake.net;
        s=mail-1; t=1683826510; x=1684431310;
        bh=DmLP6TBXhf4N5Mvc9+3GJ6/YeLZ5Yc9V31ycFmux+mU=;
        h=Date:From:To:Cc:Subject:Reply-To:Subject:From:To:Date;
        b=kUqky+WkGdDp4bHZdpOwEGkJRtgzBxLhcklleRlqGGR8uVRDaRxsRL5G4GnmJ6gQT
         YTTmPmdQktMIXC/5LxsQ0KqAmCsAp91+S3sSWXWR7BF2eZMRmPK3z+kYf3laHwD12H
         IM5yCM+4HLTO8kGXw5bdWQbGIZLabUP5QycjWlUU=
Received: from localhost (aurora [127.0.0.1])
        by mail.icequake.net (Postfix) with ESMTP id 3EE7BD4319;
        Thu, 11 May 2023 12:35:10 -0500 (CDT)
X-Virus-Scanned: Debian amavisd-new at icequake.net
Received: from mail.icequake.net ([127.0.0.1])
        by localhost (aurora.icequake.net [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id slBpBSYWsDK5; Thu, 11 May 2023 12:35:09 -0500 (CDT)
Received: from localhost (rrcs-71-42-125-220.sw.biz.rr.com [71.42.125.220])
        (Authenticated sender: nemesis@icequake.net)
        by mail.icequake.net (Postfix) with ESMTPSA id 9F7E7D4317;
        Thu, 11 May 2023 12:35:08 -0500 (CDT)
Date:   Thu, 11 May 2023 12:32:21 -0500
From:   "Ryan C. Underwood" <nemesis@icequake.net>
To:     alsa-devel@alsa-project.org
Cc:     Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
Subject: [PATCH] snd-hda-intel: Apply HP B&O top speaker profile to Pavilion
 15
Message-ID: <ZF0mpcMz3ezP9KQw@icequake.net>
Reply-To: nemesis@icequake.net
Mail-Followup-To: alsa-devel@alsa-project.org,
        Jaroslav Kysela <perex@perex.cz>, linux-kernel@vger.kernel.org
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha1;
        protocol="application/pgp-signature"; boundary="4X/VV/xht5l+DTIS"
Content-Disposition: inline
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--4X/VV/xht5l+DTIS
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable


The Pavilion 15 line has B&O top speakers similar to the x360 and
applying the same profile produces good sound.  Without this, the
sound would be tinny and underpowered without either applying
model=3Dalc295-hp-x360 or booting another OS first.

Signed-off-by: Ryan Underwood <nemesis@icequake.net>
---
 sound/pci/hda/patch_realtek.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/sound/pci/hda/patch_realtek.c b/sound/pci/hda/patch_realtek.c
index e103bb3693c0..7cb232a23a08 100644
--- a/sound/pci/hda/patch_realtek.c
+++ b/sound/pci/hda/patch_realtek.c
@@ -9335,7 +9335,7 @@ static const struct snd_pci_quirk alc269_fixup_tbl[] =
=3D {
        SND_PCI_QUIRK(0x103c, 0x802f, "HP Z240", ALC221_FIXUP_HP_MIC_NO_PRE=
SENCE),
        SND_PCI_QUIRK(0x103c, 0x8077, "HP", ALC256_FIXUP_HP_HEADSET_MIC),
        SND_PCI_QUIRK(0x103c, 0x8158, "HP", ALC256_FIXUP_HP_HEADSET_MIC),
-       SND_PCI_QUIRK(0x103c, 0x820d, "HP Pavilion 15", ALC269_FIXUP_HP_MUT=
E_LED_MIC3),
+       SND_PCI_QUIRK(0x103c, 0x820d, "HP Pavilion 15", ALC295_FIXUP_HP_X36=
0),
        SND_PCI_QUIRK(0x103c, 0x8256, "HP", ALC221_FIXUP_HP_FRONT_MIC),
        SND_PCI_QUIRK(0x103c, 0x827e, "HP x360", ALC295_FIXUP_HP_X360),
        SND_PCI_QUIRK(0x103c, 0x827f, "HP x360", ALC269_FIXUP_HP_MUTE_LED_M=
IC3),
--=20
2.39.2

--=20
Ryan C. Underwood, <nemesis@icequake.net>

--4X/VV/xht5l+DTIS
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iF0EABECAB0WIQSqqegowG2kcGXAAAMiiceeH7ruOQUCZF0mowAKCRAiiceeH7ru
OeeBAJ4pyw38iSUkPk3XVivjLES4ciD6PwCfdJBtyAefwhK5N8+vzabPhxLMuFg=
=/2WK
-----END PGP SIGNATURE-----

--4X/VV/xht5l+DTIS--
