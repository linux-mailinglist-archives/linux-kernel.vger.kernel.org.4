Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AE968FB87
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 00:48:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjBHXsh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 18:48:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229968AbjBHXse (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 18:48:34 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C36D3585;
        Wed,  8 Feb 2023 15:48:31 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PBxX90k25z4xyF;
        Thu,  9 Feb 2023 10:48:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1675900107;
        bh=OIooutCJA1Q70yCjnC9AtUExRLTNO+0ZbhsYO4XSC6Y=;
        h=Date:From:To:Cc:Subject:From;
        b=REG5tXHmjoYIJKwl0hOHhHKQv4PMtaPP/gRTV4uSeGM6jPFuIOt8qplAirFK66rjk
         drMM+Gt0LMmQCPNBuTLtHidtBEQnyKrgpszsWVq/cLijWnfnKe38ahPKOzI6kgfLlq
         8wpvM/XrufHdgxjxcbKrMsVxDggdp+E9y59Epofmm2D92S3k6M+ipkBbEjHcvI8qbj
         h2w5CIcILKIiIEOrG43eFNOAkRbv6xgOvSZTodXbuE4ew8aFpZ0BDEGbk0lcgxj0v1
         CYgqm436iVy+vUGf4iLxLOjLBkuiboQXoab/KWrW9r8euML5zcFZrHQLlvCPiDHJq5
         mnh1ztZETPx6w==
Date:   Thu, 9 Feb 2023 10:48:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Takashi Iwai <tiwai@suse.de>
Cc:     Uwe =?UTF-8?B?S2xlaW5lLUvDtm5pZw==?= 
        <u.kleine-koenig@pengutronix.de>, Jaroslav Kysela <perex@perex.cz>,
        Takashi Sakamoto <o-takashi@sakamocchi.jp>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the sound tree
Message-ID: <20230209104823.45899e76@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ecmpR0Hvb8JznEhqyhrBHVm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ecmpR0Hvb8JznEhqyhrBHVm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the sound tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

sound/ppc/snd_ps3.c: In function 'snd_ps3_driver_remove':
sound/ppc/snd_ps3.c:1049:13: warning: unused variable 'ret' [-Wunused-varia=
ble]
 1049 |         int ret;
      |             ^~~

Introduced by commit

  25a5a77ae0bc ("ALSA: core: Make snd_card_free() return void")

--=20
Cheers,
Stephen Rothwell

--Sig_/ecmpR0Hvb8JznEhqyhrBHVm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmPkNMcACgkQAVBC80lX
0GxjBgf/dkGMDFyDjYgBS56TJ6xTfHoAVFANCQ7sJaBy8h4o09a2m9/1ji6WoB/0
ZHrjXAM6MBWhqRDdnVr+rcz2PI0cCTTtSZWy8mrn5sgXNCv4mh0xHThUuRfUVvV4
G8U5T0qbbMueslw6bkzXAC4BChcoVvDEuMfKaMfmzS7Rt0JZoOEHWxhkqRDGP5s/
UOgTEGdcVwQxiimOb548CEc4/FShbGFC7TjfO3taxuY1nsnsPP3UNgCbZYrqHMXC
S8xc2eS2bwdhvX+GUOIZ8cpR93ePmRO/9cHo2oypyvFsgU6zoj1m9DwnNMTBQbcf
lHPhy/TIjsVM9P76cv9igJFVyzV+9w==
=Cto+
-----END PGP SIGNATURE-----

--Sig_/ecmpR0Hvb8JznEhqyhrBHVm--
