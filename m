Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE32F5E959B
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 21:01:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230404AbiIYTBq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 15:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229567AbiIYTBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 15:01:42 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 862F52EF2F;
        Sun, 25 Sep 2022 12:01:39 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id d11so4419397pll.8;
        Sun, 25 Sep 2022 12:01:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=m9ofgECn4wQJW2nxra3yB+p7Od1ax8HHQnJpAHg7WYo=;
        b=CWp2H4vnz+6Cou0BZ9ODBck7zXwOqNE770Ukejii2ywWQkL4yvQgUzcH7uQpVc+QAd
         wMQtdFIkzNa+sERfxMx7ydstuiTIRAXI6FD/6iiyzWHBoMfwx3V4U1TAo0zMnZ/c5XT0
         z7q78jFw1fhOyXOSsY7L9o01vnyXiexf2Kxc4gAWJ2yYDI3DhD+zRoHWbh3R7wEwptzg
         D1/FWQ+hKPCtREBIYwdEVOEdWyMUhkydpj42XtTvJ6F/a/tEdMk6ln4uiUb+PX/QE6vA
         2+lr4hOwaZM9e+ymUggLW+6kRm9vXAuzsoih8Go5H6bxDAEwdzvIaLxasxBbK50bDt3R
         1WVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=m9ofgECn4wQJW2nxra3yB+p7Od1ax8HHQnJpAHg7WYo=;
        b=jPn4gDFn1Xq7S8PwwTb3H25sudSs5tLk1TUGtxWhQRO5BlhdmXjLzLhgHlP0LVz4/b
         6IpooWylmGo1iGNtn+sK/kRIKwSo8ujCXbZ7orBOo2SpYUvAmZqGQH7MQY+tJ5VyWiDA
         AsVy03/p/+hAJNhdr2yxn18AcEMkoXYyHwshTEaD9mgZh2JQFH2yVJRWBSIsmL67j1GM
         k/90FxjmbnPp97B114HK8KQMI0LXnRojCX3X9L5EBXiyXvQZdIXAZIGh7w1EQGBiPZBf
         XCd+ZBJl+7A/keZVZnd3Lu0TLxw0NmXwZZs2SquXfM1CKHeBhff661UJXmxZoIHGwpNe
         /hgw==
X-Gm-Message-State: ACrzQf0neLIETtseZ3OdHL0vSK+QKR7OgatUBXOnpMAUCfiY8+4Ky4FZ
        jelGoJ0hVBUlv0hyxMG4hAA=
X-Google-Smtp-Source: AMsMyM4cHpxSvCGRMuJKo9wKc/9wKbE/cJXimmPFgRJMPK/Oaoj7pvJ0weEAoD2wecHLpgH9lGnqUg==
X-Received: by 2002:a17:90b:3e8c:b0:202:c7b1:b20b with SMTP id rj12-20020a17090b3e8c00b00202c7b1b20bmr20870000pjb.54.1664132498910;
        Sun, 25 Sep 2022 12:01:38 -0700 (PDT)
Received: from [172.30.1.63] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id jo18-20020a170903055200b00176a2d23d1asm9590357plb.56.2022.09.25.12.01.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 25 Sep 2022 12:01:38 -0700 (PDT)
Message-ID: <c5addc04-f29a-1366-6513-7d3bbc306e3b@gmail.com>
Date:   Mon, 26 Sep 2022 04:01:33 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH] PM / devfreq: rockchip-dfi: Fix an error message
Content-Language: en-US
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        MyungJoo Ham <myungjoo.ham@samsung.com>,
        Kyungmin Park <kyungmin.park@samsung.com>,
        Heiko Stuebner <heiko@sntech.de>
Cc:     linux-kernel@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org
References: <47627a29a443aedf3b36a4f72b3e1ad89933a0ea.1662819332.git.christophe.jaillet@wanadoo.fr>
From:   Chanwoo Choi <cwchoi00@gmail.com>
In-Reply-To: <47627a29a443aedf3b36a4f72b3e1ad89933a0ea.1662819332.git.christophe.jaillet@wanadoo.fr>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Christophe,

On 22. 9. 10. 23:15, Christophe JAILLET wrote:
> There is a typo in the message. The clock name should be 'pclk_ddr_mon'.
> Fix it.
> 
> While at it, switch to dev_err_probe() which is less verbose, filters
> -EPROBE_DEFER, and log the error code in a human readable way.
> 
> Signed-off-by: Christophe JAILLET <christophe.jaillet@wanadoo.fr>
> ---
> This looks like a cut'n'paste typo from drivers/devfreq/rk3399_dmc.c
> ---
>  drivers/devfreq/event/rockchip-dfi.c | 7 +++----
>  1 file changed, 3 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/devfreq/event/rockchip-dfi.c b/drivers/devfreq/event/rockchip-dfi.c
> index 9a88faaf8b27..39ac069cabc7 100644
> --- a/drivers/devfreq/event/rockchip-dfi.c
> +++ b/drivers/devfreq/event/rockchip-dfi.c
> @@ -189,10 +189,9 @@ static int rockchip_dfi_probe(struct platform_device *pdev)
>  		return PTR_ERR(data->regs);
>  
>  	data->clk = devm_clk_get(dev, "pclk_ddr_mon");
> -	if (IS_ERR(data->clk)) {
> -		dev_err(dev, "Cannot get the clk dmc_clk\n");
> -		return PTR_ERR(data->clk);
> -	}
> +	if (IS_ERR(data->clk))
> +		return dev_err_probe(dev, PTR_ERR(data->clk),
> +				     "Cannot get the clk pclk_ddr_mon\n");
>  
>  	/* try to find the optional reference to the pmu syscon */
>  	node = of_parse_phandle(np, "rockchip,pmu", 0);

Applied it. Thanks.

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi
