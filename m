Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FD47723D4F
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 11:28:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237434AbjFFJ2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 05:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjFFJ2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 05:28:22 -0400
Received: from fgw23-7.mail.saunalahti.fi (fgw23-7.mail.saunalahti.fi [62.142.5.84])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AA0CE5F
        for <linux-kernel@vger.kernel.org>; Tue,  6 Jun 2023 02:28:20 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw23.mail.saunalahti.fi (Halon) with ESMTP
        id 77eae969-044c-11ee-b972-005056bdfda7;
        Tue, 06 Jun 2023 12:28:18 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 6 Jun 2023 12:28:17 +0300
To:     Jiasheng Jiang <jiasheng@iscas.ac.cn>
Cc:     andy.shevchenko@gmail.com, oe-kbuild-all@lists.linux.dev,
        linus.walleij@linaro.org, brgl@bgdev.pl, palmer@dabbelt.com,
        paul.walmsley@sifive.com, linux-gpio@vger.kernel.org,
        linux-riscv@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3] gpio: ath79: Add missing check for platform_get_irq
Message-ID: <ZH78McKA5nKU1Wg8@surfacebook>
References: <20230606031841.38665-1-jiasheng@iscas.ac.cn>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230606031841.38665-1-jiasheng@iscas.ac.cn>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tue, Jun 06, 2023 at 11:18:41AM +0800, Jiasheng Jiang kirjoitti:

Is this v4?

> Add the missing check for platform_get_irq() and return error
> if it fails.
> The returned error code will be dealed with in
> module_platform_driver(ath79_gpio_driver) and the driver will not
> be registered.

No, this functional change and has not to be for the fixes unless _this_ is the
regression you are fixing. Did the driver work before at some point as after
this change?

Otherwise you have to _justify_ that this functional change won't break
existing setups (with broked IRQ in Device Tree, for example).

-- 
With Best Regards,
Andy Shevchenko


