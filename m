Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A6AD72CEFD
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 21:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237745AbjFLTGf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 15:06:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237775AbjFLTGc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 15:06:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58B2F1711
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 12:06:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C0CC562D63
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 19:06:24 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B55EAC433EF;
        Mon, 12 Jun 2023 19:06:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686596784;
        bh=+2CAjCfuiSvAQl5TXc8jdaS4YZBtxrP4Iq6jzt/7FnU=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=fuEwoXIT6KsRx/x8OU1vcGkN+5jlLj2A1GBzDyfg7BY/fXV2BjY7cYa84QwjEKLnm
         VOBeUJILFwZjWfST+Wq14X/hAJLHUc9+QooZ+M8Z41mfUHSxnBztJ0B0S7ObT45U+g
         u6NrgVRSSFWNkXT0ARLZLMQ1yYYK/ieAYU+CdX0PV6f9pgxcQ5oY/gxnJjxz5oeDYj
         jGwqCkDYuHJq8QzmzD4gLW5U8gNvwbhv/VWEwx5tktuIgwl2E29H4h7rNu+fwk7qU8
         2zUEuHR8KJm8AhCvG7A4fs4uEDMgN0+lo7Z3dJrSkdFifK4ZxvBFsI5J42BijoA/NJ
         HyZMuo8m7DXzg==
Date:   Mon, 12 Jun 2023 20:06:19 +0100
From:   Mark Brown <broonie@kernel.org>
To:     YingKun Meng <mengyingkun@loongson.cn>
Cc:     lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        alsa-devel@alsa-project.org, loongarch@lists.linux.dev,
        loongson-kernel@lists.loongnix.cn
Subject: Re: [ PATCH v2 2/3] ASoC: loongson: Add Loongson ASoC Sound Card
 Support
Message-ID: <1568e064-606e-4f56-951f-429a87a3a2d9@sirena.org.uk>
References: <20230612090046.3039532-1-mengyingkun@loongson.cn>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="JmH6MnoyxZ+mPA1w"
Content-Disposition: inline
In-Reply-To: <20230612090046.3039532-1-mengyingkun@loongson.cn>
X-Cookie: If it heals good, say it.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--JmH6MnoyxZ+mPA1w
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Mon, Jun 12, 2023 at 05:00:46PM +0800, YingKun Meng wrote:

> +	if (ls_card->mclk_fs) {
> +		mclk = ls_card->mclk_fs * params_rate(params);
> +		ret = snd_soc_dai_set_sysclk(cpu_dai, 0, mclk,
> +					     SND_SOC_CLOCK_OUT);
> +		if (ret < 0) {
> +			dev_err(codec_dai->dev, "cpu_dai clock not set\n");
> +			return ret;
> +		}

Does this need to be in the machine driver - this isn't configuring an
external clock, it's just within the SoC, so presumably the driver for
the SoC DAI can just set itself up.

--JmH6MnoyxZ+mPA1w
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEyBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmSHbKoACgkQJNaLcl1U
h9DjFQf3dlnL5S14TJo0QE32BmeVlgoqhFL9wxd3gu8bQCVhB6nAC9Bf3q/HRd5T
fvkq/Qtuv1n4VCXt28d1SboHdkcwwbyeNFvR2UE+c9yVumPy5VHXHNfsdRCJlDn0
dkrA+p2IG6SrGIKeyhTv4na9U5psScEjaTMqfTyk0DmlQO1IPRhpEi9/TI8VvRE4
DR9zoE5bPwbnMw68HEOS1GJQaHvdfDVWV4lKAvB4SpUqdHmpe871o33+2dfsHi9w
XCcqPyi/b3NwpA2/7r58meKwtroWgNVK3UXBrzQMwHFM1cEItj7b7WEIctIZrFxl
Le5GHVG0fRO4igXwrRUArFACZFhI
=PFnV
-----END PGP SIGNATURE-----

--JmH6MnoyxZ+mPA1w--
