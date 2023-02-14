Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 519C9696179
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:52:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231728AbjBNKwU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:52:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbjBNKwR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:52:17 -0500
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC01CDC
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:52:16 -0800 (PST)
Received: from localhost (88-113-24-128.elisa-laajakaista.fi [88.113.24.128])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id a3675129-ac55-11ed-bd9b-005056bd6ce9;
        Tue, 14 Feb 2023 12:52:13 +0200 (EET)
From:   andy.shevchenko@gmail.com
Date:   Tue, 14 Feb 2023 12:52:13 +0200
To:     Alexander Stein <alexander.stein@ew.tq-group.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/1] gpio: vf610: make irq_chip immutable
Message-ID: <Y+tn3Y+SraIetn5X@surfacebook>
References: <20230214073638.571417-1-alexander.stein@ew.tq-group.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230214073638.571417-1-alexander.stein@ew.tq-group.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Feb 14, 2023 at 08:36:38AM +0100, Alexander Stein kirjoitti:
> Since recently, the kernel is nagging about mutable irq_chips:
> 
>     "not an immutable chip, please consider fixing it!"
> 
> Drop the unneeded copy, flag it as IRQCHIP_IMMUTABLE, add the new
> helper functions and call the appropriate gpiolib functions.

...

> The overall changes are based on commit f1138dacb7ff
> ("gpio: sch: make irq_chip immutable")

Nice, but you forgot one crucial detail. You need to mark GPIO resuested
whenever it's locked as IRQ and otherwise when unlocked.

-- 
With Best Regards,
Andy Shevchenko


