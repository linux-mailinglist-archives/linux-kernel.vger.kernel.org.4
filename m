Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE3AE61FF9B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 21:35:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232363AbiKGUfZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 15:35:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231367AbiKGUfY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 15:35:24 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8504BDE1;
        Mon,  7 Nov 2022 12:35:22 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4N5jfF4C1Xz4xG8;
        Tue,  8 Nov 2022 07:35:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1667853317;
        bh=TX4lPhdELh/6PRlKl53+p75vcG7r79UMHGQlxgH1zzs=;
        h=Date:From:To:Cc:Subject:From;
        b=BDXzb1VQWFJ+cClwWAZFsCn185h2l3QIwoS6o2EFgptpVEB71gIyynTHSw7DWjG8r
         vh5kdNrd6WmiHoKkn0B0CNDQz9wGavi0aJJgKCGBOA3n3tNSC+DcMH3SxjWHnSrVOX
         FYV/L4LL8DueGuIuPVz43u9tgexwl+Rh0e/0eTlq2a0jI9kQI1cHepeQgOJE7msZjl
         YZrMmbgSsfv3oT91DXrwxUVj88WQsJmZv8PztYeeO6IGhYZb24fXZDUPjuuPfMpwbQ
         Lc6830xX9wMqwkHAgnxnYUwAlYeg1J1vznR3Ku5tV1jdC66U55S8G4C9FVV4YpMfHr
         LKYI0NmijZVoA==
Date:   Tue, 8 Nov 2022 07:34:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Gao Xiang <xiang@kernel.org>
Cc:     Yue Hu <huyue2@coolpad.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: Fixes tag needs some work in the erofs-fixes tree
Message-ID: <20221108073459.610a2e2e@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/YUa4V+7SY97Vqamb7JXZq_D";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_MED,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/YUa4V+7SY97Vqamb7JXZq_D
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

In commit

  40f72c923c28 ("erofs: fix general protection fault when reading fragment")

Fixes tag

  Fixes: 08a0c9ef3e7e ("erofs: support on-disk compressed fragments data")

has these problem(s):

  - Target SHA1 does not exist

Maybe you meant

Fixes: b15b2e307c3a ("erofs: support on-disk compressed fragments data")

--=20
Cheers,
Stephen Rothwell

--Sig_/YUa4V+7SY97Vqamb7JXZq_D
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmNpa/MACgkQAVBC80lX
0GyGJwf+MsQ8vYmG3cn4iOizE4GJXQl9J+Iik5Ef/zKrrbcBEGXWw1NBxnpYSiem
ba2KrsmafTxItDZXnAhcQ/31R4RKK/kzoZni4oJ4Q/2EvFeGrN5xb35rrqp5LxPg
P/WhIi+SiLbdyxAC9EjeZzZxNXctywaCf/W1rRGIz/ge1ncuV+HGZTVcUz9TDzHT
Bg/xRoczc+ZieRD7286AJXX2RHMe+AIRxbQ2Op1PKy8hFWoCnT2I02SzoFHTNl+V
wyY0AwDrj42rqFG4zFvk1T+AvkDHddiU994gg/QXHVd3+Vu/1lV1WGtxek5PwObL
V7wKN8Gi87kv4YoiWXmczJFMdQwStw==
=izP9
-----END PGP SIGNATURE-----

--Sig_/YUa4V+7SY97Vqamb7JXZq_D--
