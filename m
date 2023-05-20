Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3B91A70A972
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 19:22:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230307AbjETRWb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 May 2023 13:22:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229617AbjETRW3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 May 2023 13:22:29 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78A27DF
        for <linux-kernel@vger.kernel.org>; Sat, 20 May 2023 10:22:28 -0700 (PDT)
Received: from mercury (unknown [185.254.75.45])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: sre)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id CC7046603276;
        Sat, 20 May 2023 18:22:26 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1684603346;
        bh=EfPREliC14ufTBd9m+Ctkx8qzjEo4WHQhzv5J2dsXWs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=nzGPb24oK/xKPTnHbtMNNpv3L2HXPIkCixoSX8WdIVxaScmbyK6UVaeeX7urXTY6w
         3Si3NH/HyLwiGdj4mC48Dc+gzd2ACALmoevnyzrMmn0W1gR+0ZOEzGShiBiZzyhJXc
         knSUts77EsWFmkeqRcWbLRsJSywASQc2HfwsQ0DyWbg5EEKy52gKm+1IDVHEmt6tab
         NfeWuHe0dguSBVGRikGNex26VuAlWtayXO2CFwvVsgdGB66HVnsE3hSutKBjO35h5r
         tPPbeYqhluvSKcRpWcpvgRc2oasrjVzW1mwL+s4XuCJGf7pPCgry5aLRloKcOS/Dmz
         asEse4vgovVCw==
Received: by mercury (Postfix, from userid 1000)
        id 5A40610628E0; Sat, 20 May 2023 19:22:24 +0200 (CEST)
Date:   Sat, 20 May 2023 19:22:24 +0200
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Kees Cook <keescook@chromium.org>
Cc:     Arnd Bergmann <arnd@kernel.org>,
        Carlos Chinea <carlos.chinea@nokia.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Jianglei Nie <niejianglei2021@163.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Wang Qing <wangqing@vivo.com>,
        Yang Yingliang <yangyingliang@huawei.com>,
        Yuan Can <yuancan@huawei.com>,
        Miaoqian Lin <linmq006@gmail.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] hsi: fix ssi_waketest() declaration
Message-ID: <20230520172224.ngyvbjk6bl75qmx2@mercury.elektranox.org>
References: <20230516202226.559733-1-arnd@kernel.org>
 <202305161330.FE7311B@keescook>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jndqyqf4dc4zinfa"
Content-Disposition: inline
In-Reply-To: <202305161330.FE7311B@keescook>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jndqyqf4dc4zinfa
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Tue, May 16, 2023 at 01:30:35PM -0700, Kees Cook wrote:
> On Tue, May 16, 2023 at 10:22:07PM +0200, Arnd Bergmann wrote:
> > From: Arnd Bergmann <arnd@arndb.de>
> >=20
> > The ssi_waketest() function definition causes a 'make W=3D1' warning
> > because the declaration is hidden away in ssi_protocol.c:
> >=20
> > drivers/hsi/controllers/omap_ssi_core.c:147:6: error: no previous proto=
type for 'ssi_waketest'
> >=20
> > Move it into a header file instead.
> >=20
> > Fixes: dc7bf5d71868 ("HSI: Introduce driver for SSI Protocol")
> > Signed-off-by: Arnd Bergmann <arnd@arndb.de>
>=20
> Reviewed-by: Kees Cook <keescook@chromium.org>

Thanks, queued.

-- Sebastian

--jndqyqf4dc4zinfa
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmRpAcwACgkQ2O7X88g7
+ppGiBAAl4UBkglC9LCH67Xl6HE868T1Y0Rs91pxTIE6xfEKzYd5ONE4i8T1uG+H
XqNtKqT7pNccAmvhTfQtLqc4+zu3vRd1A0ZBCL5HEhKiBkTzdR7jYdQzKr9rfmLy
xIaypnXVjpaCsomFiNjuBLQy6xp5BiV1xdbVLBeI8dxEhaDVknsETr9I5uhDRdcJ
8BLuj9Yyh8EUPXNo3d8zBPy9XFevOIFI1gq3maigG1vCLDrWvtCOtsNfQx5yjdU5
TT6bmfBS2yOL6H5yBsu7803BOsiBbwdac/1l9JPuE3HI9zZv0fBnGF3SlXmjHkky
yfguW5Ff9u760mE50PtFn9Y3JwocVb8tatIWIwGWTRx7QoM4lD7HeFPu5B/pdc+9
JEBXdIKs2OpvcYNk1CKh1KRAfK+lciiIgXI4htGaq9CmeCMlMoyv/mT1jOjItXPo
7QqxBdQaqPqdIEGvSIYOI+8PTOiq4Nv2J9WvpxHg2vGJUicaPXZDpQgRU5MiEIM4
NdXWBs5H+v5uMJ8WkoutZHGqSkKWpniEvn09wrpUptE4F3NgFc01xXSuhpg8Y74A
5PLJHjCHREXcmZgMP0KdUve+K7hjWeIVXu6kJPQ3dDb4n46wjqmHqTTXsEJOPGNE
xtVy1/jQ2moOsBwv+4bBWjBnHxpXdlvZ39hnDJyYAhW3zPpQ3yM=
=9aei
-----END PGP SIGNATURE-----

--jndqyqf4dc4zinfa--
