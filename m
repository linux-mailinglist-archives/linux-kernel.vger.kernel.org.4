Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12B4D5EDE27
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 15:52:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233276AbiI1NwE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 09:52:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233380AbiI1NwA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 09:52:00 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9768E786C9;
        Wed, 28 Sep 2022 06:51:59 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id EFDFD61E7B;
        Wed, 28 Sep 2022 13:51:58 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 16BB2C433D6;
        Wed, 28 Sep 2022 13:51:54 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664373118;
        bh=ROqLS98VGR+VwDcyhPpFKMOIVZET4jcf8OvFsP707zY=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=jHDEpF2TQL0WX+xB2qPBHQTOVbMKScDc2Jh159+954zJYLNRz65uOi1TqxdCXcUJa
         zp8DFzhyGpEjSLOEEwM0uri7zr3u3+3Ik97vS6FzBGNV6LnvrzW9g8kxGahq2QryU0
         OCKilBJGnDrQnirnAZDtAe/MoXwZM+2CNe3ACFevjWrr/fbldP9oTTYuRGsFvCNrdi
         K6DhIhREDSni09KjL4ZxK5sjilkJ9V4G/sK0pC0fuBUAJwhfKEOlCu6aUOthwabph/
         Vq+A5dRV1EUz1gKfoA9OorxqkEqX0RC1ETsigtW4K7nYY4kMv8dS26znfPti2qhkH1
         0jQVR86c6VHGw==
Date:   Wed, 28 Sep 2022 14:51:51 +0100
From:   Lee Jones <lee@kernel.org>
To:     Sebastian Reichel <sebastian.reichel@collabora.com>
Cc:     Heiko Stuebner <heiko@sntech.de>, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Mark Brown <broonie@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com
Subject: Re: [PATCHv3 02/14] mfd: rk808: use dev_err_probe
Message-ID: <YzRRd/4Wdr5Comu1@google.com>
References: <20220909175522.179175-1-sebastian.reichel@collabora.com>
 <20220909175522.179175-3-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220909175522.179175-3-sebastian.reichel@collabora.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 09 Sep 2022, Sebastian Reichel wrote:

> Use dev_err_probe instead of dev_err in probe function,
> which simplifies code a little bit and prints the error
> code.
> 
> Also drop possibly incorrect printing of chip id registers
> while touching the error message.
> 
> Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
> ---
>  drivers/mfd/rk808.c | 48 +++++++++++++++------------------------------
>  1 file changed, 16 insertions(+), 32 deletions(-)

For my own reference (apply this as-is to your sign-off block):

  Acked-for-MFD-by: Lee Jones <lee@kernel.org>

-- 
Lee Jones [李琼斯]
