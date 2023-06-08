Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA10A728020
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 14:35:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235017AbjFHMfA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 08:35:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236157AbjFHMew (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 08:34:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 835261FDF;
        Thu,  8 Jun 2023 05:34:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1814264D27;
        Thu,  8 Jun 2023 12:34:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 433F0C433EF;
        Thu,  8 Jun 2023 12:34:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686227690;
        bh=s8uRf6ILDhBHCnhDd8+nAGZMi3XQ0o46ths1HzP+BVQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=GY9DNorE7X3V5Mzsv56Kq74WoD34bZAcBoXH9lZMT6KPm9vT6AknTz/JPSUBTrk+d
         ymsTKgjoPeCvai8bPH26i1VAfWHNfK1McSR415GyOkFQUm6Yx24DqNgmFS0bgw2vwl
         NeTkyQ/R8hEE9gio/34vD7foOHHx7bspPleuaGxlTs5y4RGymtLIaSY9OfmitIVvis
         6XfU8ILPJ1sf1jbJZHvEIRvI590zxluIqxa3TPF2xX5c02RNHq0puaeBcZhKc5BBSg
         yp9+Mhtcg2rt/lA2ahcx4AHYrsgx0f+xAli4SmyVcmBX46FBIlkdpguY02gJDHQ2Ux
         QuZzR6g0kFyjw==
Date:   Thu, 8 Jun 2023 13:34:45 +0100
From:   Lee Jones <lee@kernel.org>
To:     Jerome Neanne <jneanne@baylibre.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Tony Lindgren <tony@atomide.com>, khilman@baylibre.com,
        msp@baylibre.com, francesco@dolcini.it,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-omap@vger.kernel.org,
        Jonathan Cormier <jcormier@criticallink.com>
Subject: Re: [PATCH v5 2/2] mfd: tps65219: Add gpio cell instance
Message-ID: <20230608123445.GG1930705@google.com>
References: <20230511-tps65219-add-gpio-support-v5-0-ebb94281c854@baylibre.com>
 <20230511-tps65219-add-gpio-support-v5-2-ebb94281c854@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20230511-tps65219-add-gpio-support-v5-2-ebb94281c854@baylibre.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 07 Jun 2023, Jerome Neanne wrote:

> tps65219 PMIC GPIOs are exposed in a standard way:
> gpiodetect
> gpiochip0 [tps65219-gpio] (3 lines)
> 
> tps65219-gpios is incorrect cell name (plural):
> Changed to tps65219-gpio (singular)
> 
> Co-developed-by: Jonathan Cormier <jcormier@criticallink.com>
> Signed-off-by: Jonathan Cormier <jcormier@criticallink.com>
> Reviewed-by: Linus Walleij <linus.walleij@linaro.org>
> Signed-off-by: Jerome Neanne <jneanne@baylibre.com>
> ---
>  drivers/mfd/tps65219.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

Applied, thanks

-- 
Lee Jones [李琼斯]
