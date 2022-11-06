Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FAF161E60E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 22:02:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229452AbiKFVCm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 16:02:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230073AbiKFVCk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 16:02:40 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 85891FAD1;
        Sun,  6 Nov 2022 13:02:36 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N56J63pBnz4x2c;
        Mon,  7 Nov 2022 08:02:30 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667768551;
        bh=4Fjz4sns41q4ToLSDjK5uJQU25DdkizJxOpUafS3xPU=;
        h=Date:From:To:Cc:Subject:From;
        b=spW3v4bKww21+hj+hLrSnFxchLe6RgtxUSg9OXkQOFEPVL/ELubHHS1AVr6Zxcfjv
         +Yp10JDv79Ayjamb4PZy8tz6Wnb/t6SedH/8dWo/+f10hmXVYKpMoNdF5UqzPkisVz
         gyvc069Ff88zQ++3PvMeEGTEz97/k5Wzxq2ECDlx2RkuYYRN/LghDhTJp3QJ/ffWqu
         cYOn3vDWAXxoIdKddWmigsCSeCK33jbqjiKFEiZHJUrkKH+V6YtPHK8KbJ2QF+BCuD
         2wmN7i+cboc935WrpYUETqEz/Sz2qTGRndu0SRPPL/qSFcUJOGteccXKvJU/CFKD5e
         7n06Ob6TQw5HQ==
Date:   Mon, 7 Nov 2022 08:02:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Sterba <dsterba@suse.cz>
Cc:     Boris Burkov <boris@bur.io>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the btrfs tree
Message-ID: <20221107080225.358cc0ee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/tmttz4tCK+9XPvDf+eHf8WF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/tmttz4tCK+9XPvDf+eHf8WF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  5a2644cf1841 ("btrfs: fix improper error handling in btrfs_unlink")

Fixes tag

  Fixes: 6a1d44efb9d0 ("btrfs: setup qstr from dentrys using fscrypt helper=
")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: c0916fbc08be ("btrfs: setup qstr from dentrys using fscrypt helper")

--=20
Cheers,
Stephen Rothwell

--Sig_/tmttz4tCK+9XPvDf+eHf8WF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNoIOEACgkQAVBC80lX
0GxT5Qf/QXQW3QsAh0ttmDmpBJtwikgJMa/9QMiqDhDLMsHEchq2P7b18z9FX03n
2mCy4SBIeY0F/Azr9q7nLarsFHu4e+ulz1GsQ8yrtCVqVDFbiKS7z/qm3D9I/U1R
1MknIaZ9wmzafwe3QpM2a9lTYll0F5dylz3OGnN1TNFJNBXI84w1vjrdmXkGXwbx
jxsCGWTf4i8YELO3nmFeU1VM9tHZXBt5qmZEDhyIu2kY4S1KIqXKPaSeu/1u0OId
GsiXP9MpegU5gXgsRTspe32HyXXWKdUmerfxdP84XhUT6f4cBpleYwqm+gRZDtId
iyej4tdW31Pms9YlnKk563PWFRZLbw==
=PXOI
-----END PGP SIGNATURE-----

--Sig_/tmttz4tCK+9XPvDf+eHf8WF--
