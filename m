Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A1FE6BDCD5
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Mar 2023 00:21:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229680AbjCPXVk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 19:21:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229488AbjCPXVd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 19:21:33 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED7BD60AB4;
        Thu, 16 Mar 2023 16:21:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 518C9B82396;
        Thu, 16 Mar 2023 23:21:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8B27C433D2;
        Thu, 16 Mar 2023 23:21:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1679008888;
        bh=3Oui75984P2dEQ09SAAqFYPA7I0ywfps+4tuLUL6s5I=;
        h=In-Reply-To:References:Subject:From:Cc:To:Date:From;
        b=eKvZ3xfxssXXsEZv1JYx9bh2g9vo0NqPIAnxSRHcKoK8Ld7bv1+VX9h+6RA2iF4g6
         kl3IqiX+whbFZDIoQ6QbFFT5Z8GPKmEkcLd42aftfL1IjgFffIAeLNiDY7gfWfw1Wt
         7LtfXNAlpFXaJRG9y/IZ2Qn1gXbDBgQUW+HFmAkWlcQmg409x7Np7kcqYQKhnaabJ9
         0+uodqEFP6AlrPDERW/oKvggmM32IT3BmaLSPrZBYiCPNwmXNv1okjeW7TZdJGeJ5U
         j1EGbqE7Y+wqgS/fgZyG7UtrjvUeVd5fUzXTE2pEC7/lB4U788ukUpEhqI/KorLU4X
         8PYShIgCVG11Q==
Message-ID: <2f5f469817d637883c73e49a924530ac.sboyd@kernel.org>
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <20230307153617.643260-2-sebastian.reichel@collabora.com>
References: <20230307153617.643260-1-sebastian.reichel@collabora.com> <20230307153617.643260-2-sebastian.reichel@collabora.com>
Subject: Re: [PATCHv7 01/11] clk: RK808: reduce 'struct rk808' usage
From:   Stephen Boyd <sboyd@kernel.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        kernel@collabora.com
To:     Heiko Stuebner <heiko@sntech.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Lee Jones <lee@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Date:   Thu, 16 Mar 2023 16:21:26 -0700
User-Agent: alot/0.10
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Sebastian Reichel (2023-03-07 07:36:07)
> Reduce usage of 'struct rk808' (driver data of the parent MFD), so
> that only the chip variant field is still being accessed directly.
> This allows restructuring the MFD driver to support SPI based
> PMICs.
>=20
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---

Acked-by: Stephen Boyd <sboyd@kernel.org>
