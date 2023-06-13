Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 262AA72DC7E
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 10:30:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241140AbjFMIaR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 04:30:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241293AbjFMIaG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 04:30:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E282C9;
        Tue, 13 Jun 2023 01:30:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9772D620EA;
        Tue, 13 Jun 2023 08:30:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81900C433D2;
        Tue, 13 Jun 2023 08:30:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686645004;
        bh=6d42DbKgu8Ei2jLZ7JrS4wpOmLl2weh1xU1RAzLXuv0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=U7nb8VHi1M/V+P+7RhyqjKOtaDVctjbsdOhMSOSeZdtpmUzwbZW43X1xR/GFCmu9D
         Pb9Y/x+vCtAK8U7dGFQPF9Y7qfMJwP/nvxojlCUh1AOGKywoxSlil/bK8jSpuCeRVr
         77xOHM9NSqVxSSxU1R2Rwu1eUDlCfD6icKD4mM26GSezBtoJ2/ZgCUCgpnpnEiXIcz
         1412f1T/WfxFCq3J1fcM0kqYpzfpZ10ycBhQSuKDs9oRvJxRZjpgbdKVuoL6lHQMp/
         fcxq1alrDVAJj1RpDQWpoWJPbrjcZLU+FKoEn+2fu2cynGpCjD2SV9P5DlpZdVX/AY
         T8mGvcH1F/ZEw==
Date:   Tue, 13 Jun 2023 10:30:01 +0200
From:   Maxime Ripard <mripard@kernel.org>
To:     Sui Jingfeng <suijingfeng@loongson.cn>
Cc:     Sui Jingfeng <15330273260@189.cn>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>, Li Yi <liyi@loongson.cn>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian Koenig <christian.koenig@amd.com>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Nathan Chancellor <nathan@kernel.org>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v14 0/2] drm: add kms driver for loongson display
 controller
Message-ID: <a23d6mgl4fbfa4ucgjvwgw7l3somxo4tkhit7ygy55fldlum56@vm3tyjdsx24l>
References: <20230520105718.325819-1-15330273260@189.cn>
 <d4e647d8-294c-abd7-40c6-37381796203d@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6kkkzeylcfa5wg45"
Content-Disposition: inline
In-Reply-To: <d4e647d8-294c-abd7-40c6-37381796203d@loongson.cn>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--6kkkzeylcfa5wg45
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hi,

On Mon, Jun 12, 2023 at 10:58:54PM +0800, Sui Jingfeng wrote:
> Hi,
>=20
>=20
> Any ideas for this trivial DC driver? Sorry about my broken English.
>=20
> What to do next? Send a new version?

Thomas already told you to merge it in the previous version:
https://lore.kernel.org/dri-devel/7b77020f-d543-13bf-e178-bc416bcc728d@suse=
=2Ede/

So.. do that?

Maxime

--6kkkzeylcfa5wg45
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQRcEzekXsqa64kGDp7j7w1vZxhRxQUCZIgpCQAKCRDj7w1vZxhR
xaX9AP98NAUeUldG+9TkOuUCTTK2w4Lhn+TkARbi5tstE7HcyAEAyXSOV9A0A5k7
xuUxndGdKHR5Al+XvMPG/pYoL0jt9w0=
=kRkF
-----END PGP SIGNATURE-----

--6kkkzeylcfa5wg45--
