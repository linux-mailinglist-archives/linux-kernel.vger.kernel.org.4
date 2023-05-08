Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 230C26FBB2B
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 00:51:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233835AbjEHWvX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 18:51:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36168 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjEHWvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 18:51:19 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 183467ED7;
        Mon,  8 May 2023 15:51:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QFc314YVTz4x44;
        Tue,  9 May 2023 08:51:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1683586270;
        bh=GoA8n/e4DUi0nPKQIp2gJNGRtdRebfHKoah7CCT7Oi4=;
        h=Date:From:To:Cc:Subject:From;
        b=R0Xkl56J4pzjofMhQ1+s40533GhS0yqoY38r+u0jYN/ZWeYI6oFnjkxB9m3bvoha3
         ZV30mQOS+CvQQlijIgdeVor3uIQDsT2QHKY8T7Wdj7ZxUnq0BrtIlzQGA0Pd/NO5vP
         zecf/+9BVqli9Yp0vSRu5wQcPs82/apuzO+cFpfEUOY4CgJWo5jGSyOjB42ujTqKxD
         e+L3eJ0TQeEhBtfWOlKCTNduASRf81Q9c9e2UYyJiEQ4dpmry0YX8MAivrr0sAq5T1
         mTcIjLviJh1KQJRhZbwJaN5oNBVJJJSygeYgFZyJacnvhDlKvho7tKTbTk562fVzwY
         /xisWppSWLaCA==
Date:   Tue, 9 May 2023 06:33:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Mauro Carvalho Chehab <mchehab@kernel.org>
Cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Arnd Bergmann <arnd@arndb.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: duplicate patches in the v4l-dvb-fixes tree
Message-ID: <20230509063325.0e746f55@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Yr7RK1g3BR35S8ylzrQrpyO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Yr7RK1g3BR35S8ylzrQrpyO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

The following commits are also in Linus Torvalds' tree as different
commits (but the same patches):

  4ab0bfe3badf ("media: nxp: imx8-isi: fix buiding on 32-bit")

This is commit

  ba0ad6ed89fd ("media: nxp: imx8-isi: fix buiding on 32-bit")

in Linus' tree.

--=20
Cheers,
Stephen Rothwell

--Sig_/Yr7RK1g3BR35S8ylzrQrpyO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmRZXJYACgkQAVBC80lX
0GybTwf9H+hAcp2mlPu8GQSd/d4yUExGA948SudeQ8IGeWyqw3kwZFmCscxxgFvB
NZkxGKGn7BxSRMSCYxELNbktrsv1OO9Fpla3GxqCUUM2CcxiCZ5bIP1XQ9fMRGWo
duV9phKYuhZU23Vz+pa9aSFH0xgWdMFqnysuJhjKeDcqtp1uMV+kRm/KT+ksA6Zz
2OAL7yiq9tT/IVCbPf6B1bJF0an4w373idTZyNbRoR6g3Hy9NMH1sWGmgpZe2q3q
gDaVhGypr9YKzXEtNeb1YgUQbNZ5FRrht4GTdhGBgP9mebCkxCevSAQ89kytNsTi
u7nwgMkLne7WyAfxHibcb/gHqIJ3Iw==
=qtK+
-----END PGP SIGNATURE-----

--Sig_/Yr7RK1g3BR35S8ylzrQrpyO--
