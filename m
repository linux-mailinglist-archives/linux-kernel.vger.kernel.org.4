Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DED606F472A
	for <lists+linux-kernel@lfdr.de>; Tue,  2 May 2023 17:28:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234285AbjEBP2G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 11:28:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230332AbjEBP1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 11:27:48 -0400
Received: from fgw20-7.mail.saunalahti.fi (fgw20-7.mail.saunalahti.fi [62.142.5.81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A95E2D5A
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 08:27:46 -0700 (PDT)
Received: from localhost (88-113-26-95.elisa-laajakaista.fi [88.113.26.95])
        by fgw20.mail.saunalahti.fi (Halon) with ESMTP
        id e06c2cb6-e8fd-11ed-b3cf-005056bd6ce9;
        Tue, 02 May 2023 18:27:41 +0300 (EEST)
From:   andy.shevchenko@gmail.com
Date:   Tue, 2 May 2023 18:27:40 +0300
To:     Xiaolei Wang <xiaolei.wang@windriver.com>
Cc:     aisheng.dong@nxp.com, festevam@gmail.com, shawnguo@kernel.org,
        ping.bai@nxp.com, kernel@pengutronix.de, linus.walleij@linaro.org,
        peng.fan@nxp.com, shenwei.wang@nxp.com,
        bartosz.golaszewski@linaro.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pinctrl: freescale: Fix a memory out of bounds when
 num_configs is 1
Message-ID: <ZFEr7BoCiLw8aSxv@surfacebook>
References: <20230501144139.985767-1-xiaolei.wang@windriver.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230501144139.985767-1-xiaolei.wang@windriver.com>
X-Spam-Status: No, score=0.7 required=5.0 tests=BAYES_00,DKIM_ADSP_CUSTOM_MED,
        FORGED_GMAIL_RCVD,FREEMAIL_FROM,NML_ADSP_CUSTOM_MED,SPF_HELO_NONE,
        SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mon, May 01, 2023 at 10:41:39PM +0800, Xiaolei Wang kirjoitti:
> The config passed in by pad wakeup is 1, When num_configs is 1,
> configs[1] should not be obtained, which will generate the
> following memory out-of-bounds situation:

> BUG: KASAN: stack out of bounds in imx_pinconf_set_scu+0x9c/0x160
>   Read size 8 at address ffff8000104c7558 by task sh/664
>     CPU: 3 PID: 664 Communication: sh Tainted: G WC 6.1.20 #1
>      Hardware name: Freescale i.MX8QM MEK (DT)
>   Call trace:

Please, read this
https://kernel.org/doc/html/latest/process/submitting-patches.html#backtraces-in-commit-messages
and update accordingly.

-- 
With Best Regards,
Andy Shevchenko


