Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E41475E94F9
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 19:37:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230411AbiIYRhz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 13:37:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59212 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232911AbiIYRht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 13:37:49 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69DC72F021;
        Sun, 25 Sep 2022 10:37:48 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id t190so4657829pgd.9;
        Sun, 25 Sep 2022 10:37:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date;
        bh=86BisdAmXDJ9lANgukVe30ctpG4RM3PlB3Cg2D9niNY=;
        b=cP13hLPoZIU49fFY+2bs8EtmhUkwvrz+XvTYOumfteg/YTgSyZJJtm8kbZFXEF6BOz
         SjsjHjDvbpJZZYjxiebfDgfZXSe+JwiV3166tUx6w1l7BstHPcZbTeoBPlw1rYrsQ/my
         r1HZIrh3yBXDlt//On1S/WmL5A0VsmCksOrk8xIOZJmLi8IZhV3J9Rf5IWQk37PNHcLC
         xuFtBdLYDOodlo+IMVIqS/PXcbtZNIkFaJ2yCRYxX7IOCwEOQ9id/jVLK5VQR0Nxd7VI
         iw1TdVUduSBDLxb84bJ0sWGjpash9/4LOKgUpJbb2lfqew0sxmMLTISd4wnXmK2/vnfG
         99Xg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date;
        bh=86BisdAmXDJ9lANgukVe30ctpG4RM3PlB3Cg2D9niNY=;
        b=HMrxgENMlaIT486x7L51Kyq2txCc6HOau9dumURFyNxam0m+hcBdyCl43cwJKl+VD0
         W0UzbTtMgo3GnTIfpw/BvgFnAvYeOsO50sy+4jv2iQ72kRFAMOFr81puxhc7kORbxsRW
         ZTECEN9NSZk3y6sI3HOFJzdg5RSq0HyngVC8E96Gg9DpwJ/bdYrRM5EuxhWdCs1l8dct
         8UCwuTOGDCDUJegDmEBONYD3M4plk/9CVDMxy/GotcSzSDJxkfMENknXNw5vXnb4HSPX
         Ujdq4d3/V234mVLleetRUJhAEdl1FTpA9jCH2cGT5A7B6aATcnLlH/ITZJo5f+tI374D
         OQXg==
X-Gm-Message-State: ACrzQf19yfa0waP/5VeHsSr3KIX+bJanJRG3kd26qn2yAOakkt1WAp3O
        Wkzrtx/xvSWudHoACTdJYcs=
X-Google-Smtp-Source: AMsMyM7uN7HZXXxe8VMNnHFgUykaV82sMNrLtLwisu1yQYKVhc/yLncSkHfD3oFLoutuja6QqdFk+A==
X-Received: by 2002:a05:6a00:1a8f:b0:548:8ce8:db73 with SMTP id e15-20020a056a001a8f00b005488ce8db73mr19679232pfv.10.1664127467998;
        Sun, 25 Sep 2022 10:37:47 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id b130-20020a621b88000000b0053e468a78a8sm10219020pfb.158.2022.09.25.10.37.46
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 10:37:47 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Sun, 25 Sep 2022 10:37:46 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     "Alice Guo (OSS)" <alice.guo@oss.nxp.com>
Cc:     m.felsch@pengutronix.de, wim@linux-watchdog.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, festevam@gmail.com,
        kernel@pengutronix.de, linux-imx@nxp.com,
        linux-watchdog@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/7] watchdog: imx7ulp: Add explict memory barrier for
 unlock sequence
Message-ID: <20220925173746.GB1763764@roeck-us.net>
References: <20220825083256.14565-1-alice.guo@oss.nxp.com>
 <20220825083256.14565-3-alice.guo@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220825083256.14565-3-alice.guo@oss.nxp.com>
X-Spam-Status: No, score=-1.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 25, 2022 at 04:32:51PM +0800, Alice Guo (OSS) wrote:
> From: Jacky Bai <ping.bai@nxp.com>
> 
> When reconfiguring the WDOG Timer of i.MX7ULP, there is a certain
> probability causes it to reset. The reason is that the CMD32EN of the
> WDOG Timer of i.MX7ULP is disabled in bootloader. The unlock sequence
> are two 16-bit writes to the CNT register within 16 bus clocks. Adding
> mb() is to guarantee that two 16-bit writes are finished within 16 bus
> clocks. Memory barriers cannot be added between these two 16-bit writes
> so that writel_relaxed is used.
> 
> Suggested-by: Ye Li <ye.li@nxp.com>
> Signed-off-by: Jacky Bai <ping.bai@nxp.com>
> Signed-off-by: Alice Guo <alice.guo@nxp.com>
> Reviewed-by: Ye Li <ye.li@nxp.com>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
> 
> Changes for v2:
>  - add the reason why memory barriers are added for unlock sequence in commit log
> 
>  drivers/watchdog/imx7ulp_wdt.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/watchdog/imx7ulp_wdt.c b/drivers/watchdog/imx7ulp_wdt.c
> index 014f497ea0dc..b8ac0cb04d2f 100644
> --- a/drivers/watchdog/imx7ulp_wdt.c
> +++ b/drivers/watchdog/imx7ulp_wdt.c
> @@ -179,9 +179,13 @@ static int imx7ulp_wdt_init(void __iomem *base, unsigned int timeout)
>  	int ret;
>  
>  	local_irq_disable();
> +
> +	mb();
>  	/* unlock the wdog for reconfiguration */
>  	writel_relaxed(UNLOCK_SEQ0, base + WDOG_CNT);
>  	writel_relaxed(UNLOCK_SEQ1, base + WDOG_CNT);
> +	mb();
> +
>  	ret = imx7ulp_wdt_wait(base, WDOG_CS_ULK);
>  	if (ret)
>  		goto init_out;
> -- 
> 2.17.1
> 
