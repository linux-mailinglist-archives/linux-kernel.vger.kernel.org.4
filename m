Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA93F63904B
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Nov 2022 20:33:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229717AbiKYTdq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Nov 2022 14:33:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54798 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229564AbiKYTdl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Nov 2022 14:33:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3DF1B45EE9;
        Fri, 25 Nov 2022 11:33:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E5DA9B82BF6;
        Fri, 25 Nov 2022 19:33:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 91CF4C433D6;
        Fri, 25 Nov 2022 19:33:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669404818;
        bh=RVB3BmgfIM7pdYM85+7yjccUQRTSMo0yeGZcTrcEkBg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YiKSxMzXLnMCrch/yOa86tO5zgmwB6DcYXj03TMvByfgpIh6B2hcGo3sNIi0sNJsv
         KQq48sgoO5ekFyI1H2FefHNQBLP4QvDUMfhqQX/97BQqYz9wqajSXX52HORXQIezow
         e6FgKhWxSXa788LsMeBn72lIkT9r4rR0DRwQdnC7fbrEJN0uteYjb3uFvDc+7cl2Tc
         KXQUfT6N/7+UTodtAuYQUIIgs/fogJCJtTP+jNT0KrgA9ZNL6ZWQPTssgMpzdRbLCE
         yIJ+aoe+sjvqWyZpZVIje3FQkd2jUbzGcj4+Uo82OP46X3hE7QEt4JueW7pmjJbfYB
         +6i2TMExQYD3w==
Date:   Fri, 25 Nov 2022 19:33:32 +0000
From:   Mark Brown <broonie@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCH v4 11/13] regulator: rk808: Use dev_err_probe
Message-ID: <Y4EYjNOrS6lDnDZK@sirena.org.uk>
References: <20221020204251.108565-1-sebastian.reichel@collabora.com>
 <20221020204251.108565-12-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="UP7MXguqYcaP8hwk"
Content-Disposition: inline
In-Reply-To: <20221020204251.108565-12-sebastian.reichel@collabora.com>
X-Cookie: Revenge is a meal best served cold.
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--UP7MXguqYcaP8hwk
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline

On Thu, Oct 20, 2022 at 10:42:49PM +0200, Sebastian Reichel wrote:
> Print error message for potential EPROBE_DEFER error using
> dev_err_probe, which captures the reason in
> /sys/kernel/debug/devices_deferred and otherwise silences
> the message.

This doesn't apply against current code, please check and resend.

--UP7MXguqYcaP8hwk
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEreZoqmdXGLWf4p/qJNaLcl1Uh9AFAmOBGIsACgkQJNaLcl1U
h9AS3Af/ZimRMulT/PKXc7g4xcMQKhfESORU7C4dMAr/UyeTa6EaxpaMCLNZ0+kz
7rVc/Abed6reU2tt/UbFtg+gBB0P2P4YOmgek6iLoF5qL1xx/LkCrFjhv77Y8g+3
cG66F3ZCIFdy41CkR933jxas+h6s0GAsIxg10yKI8bbaBK+BsvPRoG/6c5vogBZW
YaMxKDhSYjvkzOPQa3Bb4tneoiTLUDeOVxynPgbekfyz3KCphls/u09fkRsxIUsd
zZdcR1or0MI3uF01rDUaR/x7st4tFhssX+c+uYu5EG6mqZV+YumPFql6RlsMdmvN
piaqprywCVIMn2MgykGnYSH/yd0Eiw==
=WbNx
-----END PGP SIGNATURE-----

--UP7MXguqYcaP8hwk--
