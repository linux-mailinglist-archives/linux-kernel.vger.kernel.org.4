Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B72436A5685
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 11:23:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230445AbjB1KXK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 05:23:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229686AbjB1KXI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 05:23:08 -0500
Received: from mail.zeus03.de (www.zeus03.de [194.117.254.33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7898AEC50
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 02:23:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple; d=sang-engineering.com; h=
        date:from:to:cc:subject:message-id:references:mime-version
        :content-type:in-reply-to; s=k1; bh=Mcb71SBLKJKo9n9XevXq87y2BbJN
        cVOghzuFyCgc96Y=; b=ZGJtnlb9Jw+qbvg28NF5dWPt62fo75S5TLrLQ76zOy/Y
        rpLfSFs9XW9G3p0kVxSlDNdTfu5RLmszoqIuvd5T29q7dfDU/597OMV6K9oX/iub
        g6Z4v8F3jvvlH/pFgD25Vc9XSInlWx3I/3rX0HYsurwLeDrMnmBt3L0A/EvJimE=
Received: (qmail 2424783 invoked from network); 28 Feb 2023 11:23:03 +0100
Received: by mail.zeus03.de with ESMTPSA (TLS_AES_256_GCM_SHA384 encrypted, authenticated); 28 Feb 2023 11:23:03 +0100
X-UD-Smtp-Session: l3s3148p1@QusL+7/1kLZehh92
Date:   Tue, 28 Feb 2023 11:23:02 +0100
From:   Wolfram Sang <wsa+renesas@sang-engineering.com>
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] media: renesas: vsp1: blacklist r8a7795 ES1.*
Message-ID: <Y/3WBpRUYfLCTsvy@ninjato>
Mail-Followup-To: Wolfram Sang <wsa+renesas@sang-engineering.com>,
        Pavel Machek <pavel@ucw.cz>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        linux-renesas-soc@vger.kernel.org,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230118122003.132905-1-wsa+renesas@sang-engineering.com>
 <Y8fpg/WkR4OMrpOu@pendragon.ideasonboard.com>
 <CAMuHMdUegruzCdP_+_qNuhVvFWp-_8zvdYw=v3kmt6zDU8=w5Q@mail.gmail.com>
 <Y8f2elExwiwxK2n+@pendragon.ideasonboard.com>
 <CAMuHMdXYsCN+evJB8idRFQ-v2B4bJ6vi+DSF=Zg6+QSiu+Op5Q@mail.gmail.com>
 <Y8f88dw/fWfVij/d@pendragon.ideasonboard.com>
 <Y/3UNv4a9xmAR+54@duo.ucw.cz>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nPQgwykiPRC2cvTf"
Content-Disposition: inline
In-Reply-To: <Y/3UNv4a9xmAR+54@duo.ucw.cz>
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_NONE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nPQgwykiPRC2cvTf
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

Hi Pavel,

> There's some agreement that DTBs are an ABI, and that they should work
> with old and new kernels. Disabling it in the driver seems like right
> solution.

We agreed to remove support for this specific SoC entirely from the
kernel. With this merge window, it won't boot anymore. It was for
internal development only anyhow. So, instead of adding new quirks for
it, I will remove all existing ones once rc1 is released. So, this patch
can be dropped.

Thank you for your review,

   Wolfram


--nPQgwykiPRC2cvTf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEEOZGx6rniZ1Gk92RdFA3kzBSgKbYFAmP91gMACgkQFA3kzBSg
KbZX2g/8CRdgZEghA+jOxG+dED3Yed4LejY50XrC8Meia645ecmev9Tk0D9teR9z
uBBw9DwG8Hy3IGZEMM2gvhRsyWG4nNH7bzS6J8+djwCcMru34uWxrhXZY4Yq3eyy
peR8+XrMv8mnEmof8o3nYmhPFUeLSlAqS6P52reA+TzaA3AwHfopOpvmZhdncZnb
IJSscvXRlK65igGwWYfdOSdppoCUojH3Qp7taeShjb3GAmCGpORhdIpWem08uhJy
t4xrHJJ9/W42MNqaN3wk7EnuJhO/AprtE2pmUGjIuhtNxdtprwqHK6g7ld5p7P+i
rg4Somtted4vC6/69AyZvBhaYxcoYuA48fiTlGuvFmp9fh7Jn1S3pOq73qt+J/wF
ZKO9J+wnsg+ZZzexpC2HsM+Y2GljV76ETxmOXssES0+JKv5uumw6m2wNq3IL2Hey
AtgixoYJrVZN3pRtIHEahGevzNkEk1239NKCIfRW78TrYuTStdjt9OePRIT9VQFh
dDBwXJ9krNyGMCJkXYUcbDD9JfRUFF9VDSjc4y/q9K9TMRPhnN/gz1qmtMwnWmEM
bNyFwHJbobAOpen223/gMdRKd14roJlyHHzKDXV4aSeE94E1dpF8PpfWSKGvojc6
YRyKMHHVj38f/SM5LpT/niU4NQsOTU9KdrDier2ePO3TRq8ogYw=
=JMpQ
-----END PGP SIGNATURE-----

--nPQgwykiPRC2cvTf--
