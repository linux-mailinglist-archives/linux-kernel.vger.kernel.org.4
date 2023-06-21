Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E66F738CE4
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 19:18:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229837AbjFURSg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 13:18:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229502AbjFURSe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 13:18:34 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FBC1E2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 10:18:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9A2A66162F
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 17:18:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 549F7C433C8;
        Wed, 21 Jun 2023 17:18:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687367913;
        bh=cTL3D7DKDihOkPfXURWj9D65BZeqMO4WG7mpFscggWg=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=sIlN26O1B/DaSE39sjxqjW23VQg+pX1el1cNq+RWDpRPfjfIHEwEMvdoH++i+pnqL
         9xjjmJYbLYDOX70uDhTv7RPhoJ9xAnkvi29xyoDtdVOgv+rq06/0FpulibG3c0DSrr
         WHPUl/AKJDA1Qt3mLuhCLWvcBzIT4Msd96XGE6i8L37ybRfXP4OoRjOW58nidLPx/q
         qgw+yVYB/UbonvYtM/2+jn0cfgWDwxLsZ5siFqvwffRfC8PsJZ+Ova7NgcRE16AJ8O
         ZdrmtrIHhF9W0/GEYnL6yy8fpIkEChRyWgm/ZgTNLq+vXh4MZT/RjXaW7e4cBZqG28
         kV3NJzO5UTAxA==
Date:   Wed, 21 Jun 2023 18:18:29 +0100
From:   Lee Jones <lee@kernel.org>
To:     baomingtong001@208suo.com
Cc:     linux-kernel@vger.kernel.org
Subject: Re: [PATCH] mfd: sm501: prefer unsigned int over unsigned
Message-ID: <20230621171829.GN10378@google.com>
References: <20230613082016.28701-1-luojianhong@cdjrlc.com>
 <25f84d945d94832e8d6b295cff004439@208suo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <25f84d945d94832e8d6b295cff004439@208suo.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 13 Jun 2023, baomingtong001@208suo.com wrote:

> 
> Fix the following coccicheck warning:
> 
> drivers/mfd/sm501.c:887: Prefer 'unsigned int' to bare use of 'unsigned'.
> 
> Signed-off-by: Mindtong Bao <baomingtong001@208suo.com>
> ---
>  drivers/mfd/sm501.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)

This patch did not make it to the upstream mailing list (LKML).

  https://lore.kernel.org/all/?q=%22mfd%3A+sm501%3A+prefer+unsigned+int+over+unsigned%22

I cannot take it unless it shows up there first.

Please debug this and resend.

> diff --git a/drivers/mfd/sm501.c b/drivers/mfd/sm501.c
> index 28027982cf69..f08ad7249dc5 100644
> --- a/drivers/mfd/sm501.c
> +++ b/drivers/mfd/sm501.c
> @@ -884,7 +884,7 @@ static inline struct sm501_devdata
> *sm501_gpio_to_dev(struct sm501_gpio *gpio)
>      return container_of(gpio, struct sm501_devdata, gpio);
>  }
> 
> -static int sm501_gpio_get(struct gpio_chip *chip, unsigned offset)
> +static int sm501_gpio_get(struct gpio_chip *chip, unsigned int offset)
> 
>  {
>      struct sm501_gpio_chip *smgpio = gpiochip_get_data(chip);

-- 
Lee Jones [李琼斯]
