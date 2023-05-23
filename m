Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9006770E1CA
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:29:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235018AbjEWQ1k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:27:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231878AbjEWQ1h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:27:37 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D594E5
        for <linux-kernel@vger.kernel.org>; Tue, 23 May 2023 09:27:32 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id b2c8a84a-f986-11ed-a9de-005056bdf889;
        Tue, 23 May 2023 19:27:24 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 23 May 2023 19:27:23 +0300
To:     Ryan.Wanner@microchip.com
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        conor+dt@kernel.org, nicolas.ferre@microchip.com,
        alexandre.belloni@bootlin.com, claudiu.beznea@microchip.com,
        linus.walleij@linaro.org, ludovic.desroches@microchip.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-gpio@vger.kernel.org
Subject: Re: [PATCH 1/3] pinctrl: at91-pio4: Enable Push-Pull configuration
Message-ID: <ZGzpa5HVVCKzQu3E@surfacebook>
References: <cover.1684313910.git.Ryan.Wanner@microchip.com>
 <d898c31277f6bce6f7d830edf4332ff605498c7b.1684313910.git.Ryan.Wanner@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <d898c31277f6bce6f7d830edf4332ff605498c7b.1684313910.git.Ryan.Wanner@microchip.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Wed, May 17, 2023 at 01:54:04PM +0200, Ryan.Wanner@microchip.com kirjoitti:
> From: Ryan Wanner <Ryan.Wanner@microchip.com>
> 
> Enable push-pull configuration. Remove integer value argument from
> open-drain configuration as it is discarded when pinconf function is
> called from gpiolib. Add push-pull do debug and get functions.

Right, thank you for fixing this!
Other comments below.

...

> +		case PIN_CONFIG_DRIVE_PUSH_PULL:
> +			conf &= (~ATMEL_PIO_OPD_MASK);

Parentheses are redundant.

>  			break;

...

>  	if (conf & ATMEL_PIO_OPD_MASK)
>  		seq_printf(s, "%s ", "open-drain");
> +	if (!(conf & ATMEL_PIO_OPD_MASK))
> +		seq_printf(s, "%s ", "push-pull");

As commented already by others, the else would be better.

-- 
With Best Regards,
Andy Shevchenko


