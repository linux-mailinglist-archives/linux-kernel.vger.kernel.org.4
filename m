Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5F22D7464E8
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 23:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjGCVdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 17:33:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230303AbjGCVdg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 17:33:36 -0400
Received: from fgw22-7.mail.saunalahti.fi (fgw22-7.mail.saunalahti.fi [62.142.5.83])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 940911A7
        for <linux-kernel@vger.kernel.org>; Mon,  3 Jul 2023 14:33:35 -0700 (PDT)
Received: from localhost (88-113-24-87.elisa-laajakaista.fi [88.113.24.87])
        by fgw22.mail.saunalahti.fi (Halon) with ESMTP
        id 42b1666a-19e9-11ee-a9de-005056bdf889;
        Tue, 04 Jul 2023 00:33:33 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 4 Jul 2023 00:33:33 +0300
To:     Mario Limonciello <mario.limonciello@amd.com>
Cc:     Basavaraj.Natikar@amd.com, Shyam-sundar.S-k@amd.com,
        linus.walleij@linaro.org, npliashechnikov@gmail.com,
        nmschulte@gmail.com, friedrich.vock@gmx.de, dridri85@gmail.com,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/4] pinctrl: amd: Unify debounce handling into
 amd_pinconf_set()
Message-ID: <ZKM-rde5VyTScJHC@surfacebook>
References: <20230630194716.6497-1-mario.limonciello@amd.com>
 <20230630194716.6497-4-mario.limonciello@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230630194716.6497-4-mario.limonciello@amd.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fri, Jun 30, 2023 at 02:47:15PM -0500, Mario Limonciello kirjoitti:
> Debounce handling is done in two different entry points in the driver.
> Unify this to make sure that it's always handled the same.

...

> -static int amd_gpio_set_debounce(struct gpio_chip *gc, unsigned offset,
> -		unsigned debounce)
> +static int amd_gpio_set_debounce(struct amd_gpio *gpio_dev, unsigned offset,
> +				 unsigned debounce)

Side note: Are you going to fix unsigned --> unsigned int?
The former is discouraged.

...

> +out:

out_unlock: ?

>  	raw_spin_unlock_irqrestore(&gpio_dev->lock, flags);
>  
>  	return ret;

-- 
With Best Regards,
Andy Shevchenko


