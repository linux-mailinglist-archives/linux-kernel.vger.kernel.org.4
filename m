Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8A57D6AD216
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 23:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229918AbjCFWya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 17:54:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229663AbjCFWy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 17:54:28 -0500
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D8B437F3E
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 14:54:26 -0800 (PST)
Received: from localhost (88-113-24-128.elisa-laajakaista.fi [88.113.24.128])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id d687a016-bc71-11ed-b3cf-005056bd6ce9;
        Tue, 07 Mar 2023 00:54:24 +0200 (EET)
From:   andy.shevchenko@gmail.com
Date:   Tue, 7 Mar 2023 00:54:23 +0200
To:     Lizhe <sensor1010@163.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, geert+renesas@glider.be,
        info@metux.net, shc_work@mail.ru, j-keerthy@ti.com,
        hoan@os.amperecomputing.com, fancer.lancer@gmail.com,
        orsonzhai@gmail.com, baolin.wang@linux.alibaba.com,
        zhang.lyra@gmail.com, kaloz@openwrt.org, khalasa@piap.pl,
        keguang.zhang@gmail.com, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mips@vger.kernel.org
Subject: Re: [PATCH v1] drivers/gpio: remove redundant platform_set_drvdata()
Message-ID: <ZAZvH6CFtH4I1BOm@surfacebook>
References: <20230306151532.23246-1-sensor1010@163.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230306151532.23246-1-sensor1010@163.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, Mar 06, 2023 at 11:15:32PM +0800, Lizhe kirjoitti:
> remove redundant platform_set_drvdata(),
> Because there is no place to use the platform_get_drvdata

The commit message has to be improved:
- English grammar and punctuation
- style of func()
- clearer wording on what it all means

Note, to get driver data the dev_get_drvdata() can be used. Do you aware about
this? And hHow did you check these drivers?

-- 
With Best Regards,
Andy Shevchenko


