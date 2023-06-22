Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EFE773A8B3
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 21:00:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbjFVTAF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 15:00:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231264AbjFVTAA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 15:00:00 -0400
Received: from mx.sberdevices.ru (mx.sberdevices.ru [45.89.227.171])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57083186;
        Thu, 22 Jun 2023 11:59:53 -0700 (PDT)
Received: from s-lin-edge02.sberdevices.ru (localhost [127.0.0.1])
        by mx.sberdevices.ru (Postfix) with ESMTP id 16BC55FD1D;
        Thu, 22 Jun 2023 21:59:51 +0300 (MSK)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sberdevices.ru;
        s=mail; t=1687460391;
        bh=mWWI0ZO0ptZ6K1WHLjWbKHpoK8xPQxDS9eQM4yizQ5Q=;
        h=Date:From:To:Subject:Message-ID:MIME-Version:Content-Type;
        b=MBpIpQgPlr8UapK8ML0TnxKTp0m1H12OHuGCLIGO7ZnyBDjxCN3+2ro6GfPNp6T/9
         hPaqLFwxkO8XqsVubZvqmkrzV3ncUpSrW49yEYYg4Mz4D0y2NLiUropv17bz3IcXey
         l+A5DmhkrozXvrpNFsaz2XRjOmFKk+/jqAkHsI4T6JK9T3HtKWU0bFRx56uK9yzkyq
         X8a83cU6ZznGtye5QaPdwAMrWNReabDhfi9PRjzyvdztGA+ZC2eWPmwKYRzq9hzzvh
         qcQTMc2Nv1wfNQsPOmyY0fVUeGaU8yNvPlYT5CHiMhwqfXbKZHoMzq7vaACsTkxPZc
         E/h2NLTgsjhJw==
Received: from p-i-exch-sc-m01.sberdevices.ru (p-i-exch-sc-m01.sberdevices.ru [172.16.192.107])
        by mx.sberdevices.ru (Postfix) with ESMTP;
        Thu, 22 Jun 2023 21:59:50 +0300 (MSK)
Date:   Thu, 22 Jun 2023 21:59:49 +0300
From:   Dmitry Rokosov <ddrokosov@sberdevices.ru>
To:     Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
CC:     <neil.armstrong@linaro.org>, <jbrunet@baylibre.com>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>,
        <khilman@baylibre.com>, <martin.blumenstingl@googlemail.com>,
        <linux-amlogic@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        Abaci Robot <abaci@linux.alibaba.com>
Subject: Re: [PATCH] clk: meson: pll: remove unneeded semicolon
Message-ID: <20230622185949.lctlydjcthya33ga@CAB-WSD-L081021>
References: <20230614084808.98819-1-jiapeng.chong@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20230614084808.98819-1-jiapeng.chong@linux.alibaba.com>
User-Agent: NeoMutt/20220415
X-Originating-IP: [100.64.160.123]
X-ClientProxiedBy: p-i-exch-sc-m01.sberdevices.ru (172.16.192.107) To
 p-i-exch-sc-m01.sberdevices.ru (172.16.192.107)
X-KSMG-Rule-ID: 4
X-KSMG-Message-Action: clean
X-KSMG-AntiSpam-Status: not scanned, disabled by settings
X-KSMG-AntiSpam-Interceptor-Info: not scanned
X-KSMG-AntiPhishing: not scanned, disabled by settings
X-KSMG-AntiVirus: Kaspersky Secure Mail Gateway, version 1.1.2.30, bases: 2023/06/22 14:26:00 #21556046
X-KSMG-AntiVirus-Status: Clean, skipped
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Dear Jiapeng,

Thank you for catching this bug! Appreciate it!

On Wed, Jun 14, 2023 at 04:48:08PM +0800, Jiapeng Chong wrote:
> No functional modification involved.
> 
> ./drivers/clk/meson/clk-pll.c:373:2-3: Unneeded semicolon.
> 
> Reported-by: Abaci Robot <abaci@linux.alibaba.com>
> Closes: https://bugzilla.openanolis.cn/show_bug.cgi?id=5533
> Signed-off-by: Jiapeng Chong <jiapeng.chong@linux.alibaba.com>
> ---
>  drivers/clk/meson/clk-pll.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/clk/meson/clk-pll.c b/drivers/clk/meson/clk-pll.c
> index 56ec2210f1ad..8fef90bf962f 100644
> --- a/drivers/clk/meson/clk-pll.c
> +++ b/drivers/clk/meson/clk-pll.c
> @@ -370,7 +370,7 @@ static int meson_clk_pll_enable(struct clk_hw *hw)
>  		usleep_range(10, 20);
>  		meson_parm_write(clk->map, &pll->current_en, 1);
>  		usleep_range(40, 50);
> -	};
> +	}
>  
>  	if (MESON_PARM_APPLICABLE(&pll->l_detect)) {
>  		meson_parm_write(clk->map, &pll->l_detect, 1);

Reviewed-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>

> -- 
> 2.20.1.7.g153144c
> 
> 
> _______________________________________________
> linux-amlogic mailing list
> linux-amlogic@lists.infradead.org
> http://lists.infradead.org/mailman/listinfo/linux-amlogic

-- 
Thank you,
Dmitry
