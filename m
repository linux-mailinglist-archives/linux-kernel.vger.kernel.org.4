Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A669F6C1263
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 13:54:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231455AbjCTMx6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 08:53:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231558AbjCTMxX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 08:53:23 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9AAC5FCA;
        Mon, 20 Mar 2023 05:52:08 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5AD7EB80D5B;
        Mon, 20 Mar 2023 12:52:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C693DC4339B;
        Mon, 20 Mar 2023 12:52:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679316726;
        bh=n5+Z0EWzVOx+HrYkSJdus/2VhgrkucWhKSzM/jEvrrA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=JSdfOY444Kn4KQdYZExJ0fhaYkkEziHh/TpN11EkvuLy7wiYxZTDRVkSaj3qcofdU
         Ayu2cB8aoWoy27d5jE7TYxktNFbL7eBPyc6/5O4l8H5s5aUz+kzXXKIVjPOetrX0qW
         mlMZO4Hr5h54ItwHan9Dmb+czV5I0FFfDRk1bvzkppdkAeYxENnZj9MOPKCORaHQzA
         ogpNqiqfKOSdGz7NNM8MeD5o8lCQWHF9zoUQ6edXbr+5buNPWLhB/DFT0t4LO+7WXF
         WFf/KBl2IU1VC5rd7n5XsobNOPcDgesiGzmKKX1X1SIaDCTgfJtp1XUqXgnCR46Nr1
         2tAyNltueNPaw==
Date:   Mon, 20 Mar 2023 12:52:00 +0000
From:   Mark Brown <broonie@kernel.org>
To:     zhuyinbo <zhuyinbo@loongson.cn>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-spi@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jianmin Lv <lvjianmin@loongson.cn>,
        wanghongliang@loongson.cn, Liu Peibao <liupeibao@loongson.cn>,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [PATCH v2 2/2] spi: loongson: add bus driver for the loongson
 spi controller
Message-ID: <9917d619-1104-4040-bb6f-c564fcf72806@sirena.org.uk>
References: <20230317082950.12738-1-zhuyinbo@loongson.cn>
 <20230317082950.12738-3-zhuyinbo@loongson.cn>
 <68b6034f-8305-4854-a4c9-962be988ade7@sirena.org.uk>
 <9b7aff76-eff4-3b82-d7af-a723fbf21a32@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UQy/+RE7PqT3TMK0"
Content-Disposition: inline
In-Reply-To: <9b7aff76-eff4-3b82-d7af-a723fbf21a32@loongson.cn>
X-Cookie: Keep away from fire or flame.
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UQy/+RE7PqT3TMK0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Sat, Mar 18, 2023 at 02:07:16PM +0800, zhuyinbo wrote:
> =E5=9C=A8 2023/3/18 =E4=B8=8A=E5=8D=8812:26, Mark Brown =E5=86=99=E9=81=
=93:
> > On Fri, Mar 17, 2023 at 04:29:50PM +0800, Yinbo Zhu wrote:

> > As IIRC I mentioned last time setup() might be called while other
> > transfers are happening and therefore shouldn't affect parallel
> > operations on other devices.

> I think add spin_lock in=C2=A0 transfer_one interface that should be to f=
ix this
> issue, Do you think so?

No, that doesn't help if setup() reconfigures the controller while it's
doing a transfer.  The issue is that the controller might be put into
the wrong mode or run at the wrong speed.

--UQy/+RE7PqT3TMK0
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmQYVu8ACgkQJNaLcl1U
h9AP6gf/SBhSh2gZSV/RhDWzmCpbWueMzWS3CZY7eGRvr0gQ0FIQQUH+zMtP0kl9
Hy24uUGeIFHBL26BUmzuWegPU3iWcj3eFS22XHmRpJCz6mtlLDK6tgYL7DTSUPZ0
aAMpB/r9uopGNetiidI8I2/eyN39WIJEt5Cfp9otSSYE0dqcoS/ufOKv3EIlyf7q
9M29FCI9GtiHgn54mNMY7TEC7DLcP7ZrbOl+fif8715RanAePrSQx7qo5XSrnpbR
ZSpOpf/TNnPHYCsCcsOCYqzM6wooC1ri8B06WXO7IQ+r6E4NUrVH501vozYeq0wG
Rs0U1X7q6K8DPh2F5YfMYd5pelLMHg==
=iIdB
-----END PGP SIGNATURE-----

--UQy/+RE7PqT3TMK0--
