Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F9856D5812
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 07:40:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233268AbjDDFkL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 01:40:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjDDFkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 01:40:10 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B216A1FD6;
        Mon,  3 Apr 2023 22:40:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4PrGn255scz4x91;
        Tue,  4 Apr 2023 15:40:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1680586807;
        bh=CSf9hj3weGdXbqDLFvMRCK0CkNK5irG/9fy0L47lyMk=;
        h=Date:From:To:Cc:Subject:From;
        b=ob6Z36W7IdG+rNOA68d8OGAV/7XldI/975wSyUCZoddfxM7PXzrqqsjCxaXHsJeNF
         NWxn7lmbhgQU28evo94JXKsh1PjGDCaL8G+XLpCrIGwgBU6t4MXiM38ARjhCrEtYw+
         8NJlYiXNYwkpVzfEAQ6UT2gpuzRy9E/8eoHWMjKMKswFCCRZnB0SJb8lGGO0kBzzTo
         yvua7gluNus9fQvdVOFfI1CVa80Pe2TfHcnIjjuZyRpLeL7Kfrh/DQVkA6qtH1Z6t8
         Chetlwk0Ydp6WjAXMsuH7PmL4SJRkAnbKHMBZ9qCyV/NGAes/QR8z2H6O+IoHLH875
         3rNuBn30sptCQ==
Date:   Tue, 4 Apr 2023 15:40:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>
Cc:     Bastien Nocera <hadess@hadess.net>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build warning after merge of the hid tree
Message-ID: <20230404154005.449800c3@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/SgBmrI8f5Qx8BspPcylE_+=";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/SgBmrI8f5Qx8BspPcylE_+=
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the hid tree, today's linux-next build (htmldocs) produced
this warning:

drivers/usb/core/message.c:1939: warning: Function parameter or member 'ifa=
ce' not described in 'usb_set_wireless_status'
drivers/usb/core/message.c:1939: warning: Excess function parameter 'dev' d=
escription in 'usb_set_wireless_status'

Introduced by commit

  0a4db185f078 ("USB: core: Add API to change the wireless_status")

--=20
Cheers,
Stephen Rothwell

--Sig_/SgBmrI8f5Qx8BspPcylE_+=
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmQruDUACgkQAVBC80lX
0GxUXgf/WVlLKor1xsr6MBgIoBlp2lsKGi5gPU8cPGQX69nNHl12OR3PWoB/m9TT
kVmJvipIeD8URfSWd+nETLYmmi1gaNv/Q/w0ygxRy3FwdKTX5339Vu6LDq43sRo3
UxN4EAoo7zCZyq0Ci0za6c2PMnf31PIWs4eJmesxzzC5yxF85Aar90sfYnOWKu4J
fPo5CWtUY7cKhV6eOIksiCb8cLuNzVkrJ4XHnVay32XSKy9DaiKc+sWvxR7yiS+U
WJBbTRpNFtxZfFegiz1PgJxR1rJmBORA40v2sfSu8cfmxxzgGC0CxA0Kzo+EJ8+6
/A1C35dZv8wnfjjWFbY+RQmC5VmnCg==
=TTzu
-----END PGP SIGNATURE-----

--Sig_/SgBmrI8f5Qx8BspPcylE_+=--
