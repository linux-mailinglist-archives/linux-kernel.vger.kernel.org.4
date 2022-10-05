Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7554F5F5301
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:00:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229734AbiJEK75 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 06:59:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229479AbiJEK7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 06:59:53 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 66B37F014;
        Wed,  5 Oct 2022 03:59:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D618B81DA3;
        Wed,  5 Oct 2022 10:59:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A0837C433D6;
        Wed,  5 Oct 2022 10:59:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664967587;
        bh=4jMzYU24d+yMcsfaBx4vsYUmNNj3cHQ/4Qvv5atAB90=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sTFtUD9liLjl7WLjHQo9PkZqVUv1WS49na83tXcwV1XDblWGoJS9XhIxLrHsF9bkM
         J+wIT2LpUcp8dEWJ8A11qVMdMqtJOEfPI2TOFwhbetcMld3OzyXXRRPkvlL5Fm+aWs
         SRGW0Oq1eyFSu8hFPfgUQoBlVbfkN9A43/7qsfsddSxl/gWfbSZoi9gZ9YNq+6jLyI
         eqnTm+VsnAIm2SPvlTafw4kc2H/+ozTJq54/M/U7imPMSjephI7JShfTalx7rkxLzG
         430kgIwvhOEoHOzpq/HvCGT7+QzUAhAc3gNJiqiDZLXSgSHcoN2/Z7qudBcZNFC9F+
         C0fET9YU/C2Pg==
Date:   Wed, 5 Oct 2022 11:59:41 +0100
From:   Mark Brown <broonie@kernel.org>
To:     Trevor Wu =?utf-8?B?KOWQs+aWh+iJryk=?= <Trevor.Wu@mediatek.com>
Cc:     "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "lkp@intel.com" <lkp@intel.com>, "tiwai@suse.com" <tiwai@suse.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "alsa-devel@alsa-project.org" <alsa-devel@alsa-project.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>
Subject: Re: [PATCH 08/12] ASoC: mediatek: mt8188: add platform driver
Message-ID: <Yz1jnb03bsI06rQB@sirena.org.uk>
References: <20220930145701.18790-9-trevor.wu@mediatek.com>
 <202210011740.ZdLtxKq1-lkp@intel.com>
 <de20b79da18bde2bbe56784cf4e209894f8235bf.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="FJN3P96NgRROT9Pz"
Content-Disposition: inline
In-Reply-To: <de20b79da18bde2bbe56784cf4e209894f8235bf.camel@mediatek.com>
X-Cookie: Poland has gun control.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--FJN3P96NgRROT9Pz
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Oct 05, 2022 at 06:50:53AM +0000, Trevor Wu (=E5=90=B3=E6=96=87=E8=
=89=AF) wrote:
> Hi maintainers,
>=20
> As I mentioned in the comment, this patch depends on a reviewing
> series.
> Should I remove the related code from this patch in case of the build
> error?

It's bit easier to do that, though it should be fine to just note in the
cover like you've done.

--FJN3P96NgRROT9Pz
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmM9Y5wACgkQJNaLcl1U
h9BpvQf/ViaTtdSwbnr8r5a/PKyi33v6+70ypVPJ7U7DC3iVnoob7xh2CQFQ2gLX
d0Te48W6ZDxbn1e2XJDjCTizZubyJz89RbVGCg1Wibo7MkH6k5mRlmid0tlZ2Mq3
N+9UYz7o6J3WVelnqLnjbka3ZgbDhhdK+zFzUk9GcOJ+mrum1zsSxz2DYGmyMcMc
LXO+GljHMiR/v0NkCd8is0F9CHL51VzAr2GRuCPIpZ9k0JPUicmU6GSHonnsgDkA
71QA9FB1l4mIx08vqkJONs2M6TqjVPtssxwsaokQZRNtSMW32QgFyKcqAa+MubXf
kg7ZSAzRJCdkZAO9ITzwMosQFlVfbg==
=NONF
-----END PGP SIGNATURE-----

--FJN3P96NgRROT9Pz--
