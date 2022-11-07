Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18CB161E9C5
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 04:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230369AbiKGDem (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 22:34:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiKGDej (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 22:34:39 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B123C762;
        Sun,  6 Nov 2022 19:34:39 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N5H0X3ySXz4x2c;
        Mon,  7 Nov 2022 14:34:36 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667792077;
        bh=7QswCPknYMQsyPr+9m1Gl5AC25USxTtQlaen++tznBc=;
        h=Date:From:To:Cc:Subject:From;
        b=bTf1G+O4QwiWZMGRGAtl1DT3gpo9KShSEaMhfZH8ATbFz3QCjrQsgmdl27WFhCl4J
         1iVjkq3OEj8CePqhfWDJ4M74UF/lH+SbcFv/U/CzyFZ7zWHCLffBa26H+tVvRPVBFJ
         CzW4FCKhIEtk94DWDcFgu1CU7JjtSR1R1Ajt9crXR8ZEw/xchpBeNTJSnPl12373qy
         QcUvdC89H/0HHBWP2TkYuc+8CyN7ImpsWgH2OvTIAX9ye7EWabVW5e2ZnmP6yK7AHT
         Ehub270Iu5Kz3m4XRIzSphRPqdPAbeR/Dg7Gisyu6Wfo+829XuSCCqDVw1u/Tl8OJD
         s9thIxkbQvBZg==
Date:   Mon, 7 Nov 2022 14:34:34 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Greg KH <greg@kroah.com>
Cc:     Kees Cook <keescook@chromium.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the tty tree
Message-ID: <20221107143434.66f7be35@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/A+wwO2mwquoSTT6Uue5tnDG";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/A+wwO2mwquoSTT6Uue5tnDG
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the tty tree, today's linux-next build (htmldocs) produced
this warning:

drivers/tty/tty_io.c:2271: warning: cannot understand function prototype: '=
bool tty_legacy_tiocsti __read_mostly =3D IS_ENABLED(CONFIG_LEGACY_TIOCSTI)=
; '

Introduced by commit

  83efeeeb3d04 ("tty: Allow TIOCSTI to be disabled")

--=20
Cheers,
Stephen Rothwell

--Sig_/A+wwO2mwquoSTT6Uue5tnDG
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNofMoACgkQAVBC80lX
0Gz2tQf/enPT5KUbwFpN7Ka7dzJpOtRPxTIoeWyaV1vw8dBOqhUZvLt+QUXUAkgS
CHEGNsLF3WymcSOYEReEJ0Zdqf+t8VI1Ys3U2yaYGBMxv2QwbBXjPC4QgS+NB6gx
8e9gCXDmsaH/Nq88gmB8ptW3Y1eHEaTtXb0T9BBXT5DdL+GLtPSDOlcvsRIHMPOP
nwozgffNX3aogH1qhDFkxTZ6iW6oz331uv+cS0Q6LCBaL86UcZ5H8Rw0+3X0PNL4
SreXnGB+YBiq9zgDcAGRsJwGKTwslAL9qFT+1XhpXQICUhua4lR9dTf2Lr5mA/D8
+QvELSeF2e93wqG4zd/yxH+wjbuPkg==
=DhZ0
-----END PGP SIGNATURE-----

--Sig_/A+wwO2mwquoSTT6Uue5tnDG--
