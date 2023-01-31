Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1069682D9D
	for <lists+linux-kernel@lfdr.de>; Tue, 31 Jan 2023 14:19:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229909AbjAaNTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 Jan 2023 08:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57548 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229661AbjAaNTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Jan 2023 08:19:38 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679FBCA2C;
        Tue, 31 Jan 2023 05:19:15 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id m5-20020a05600c4f4500b003db03b2559eso10567355wmq.5;
        Tue, 31 Jan 2023 05:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=cZRozeW6YOLnif6Ckl8oBilHTLhswPBqWjV3sIbziCE=;
        b=ixjiW/Mvj8mquMLB2q4In9V9xg/bqrhPrhLU5eE2hrmI5S83T3XuE8Ru6YhmJwZU8Y
         KqWpCNXj9zZV1bKiCN5REGN1wffrL9jfiyHn63kd0wO4FLkxzVIYo8aqT+adaKuobu41
         79S8TVhV+Q6F8uWgJrBqYuz3FZP++KVIEnE49NtXttFJBm0LKUIey4VMIja4miJs2TYY
         snsBfizbCqneIQOSjuq38VrrKNkgR6sG7ykJgLNOaPg8Ot8Gr4CV7RNii3lwLVfMQnLb
         TvvM1r9eRZkpALIIwm8qHfsXyHWKJz6WtKVl6IXXR6+bvekyStjs5lUh1ntHyS0lgWfl
         7bfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cZRozeW6YOLnif6Ckl8oBilHTLhswPBqWjV3sIbziCE=;
        b=PIBVDhqoC/7JpYgN3z7HJ4lETM0R38ABqg1DEqW2FtmbaCVQIpQGRuatfplBVlL1qw
         DDlvBs40ADXNijgUNu4a6DpVys/2QmkljXXLZBunUTcSM3B16qnnryk25xOFikpumN9Y
         MbIOU9589V+bYtv1J/rpvCvQ+uo/i4TJxAf6GfSOCHL564fZcao4kb31+WpGDqKwFjpe
         0b32ndTSgAOnNHTvwblQzJBA5BvVPeIf5hqr666R27BRkeXK5sqOaLUqx1SLeFcmxGRc
         L0WgXmbWBc7OEp31iNwLhDnjOlQDSZvjGjO12MSlDumRa0Jttek+J6ydwEXUgxTNbhvZ
         HdMg==
X-Gm-Message-State: AO0yUKUMeHtjs3gZTz2zV3blH1Xm1t3YqEdg4uyFQpMhb0RmteUaSnuu
        OI9PGzWWd5JVu+kjTfm6Rfs=
X-Google-Smtp-Source: AK7set8lMoCchUZ47rKVO1EMdvOM6q/D8z6KJP3FDh7nmVCHolnlrg/SPfjfh340KcvspftNZR5YCQ==
X-Received: by 2002:a05:600c:6022:b0:3dc:5ad1:7a40 with SMTP id az34-20020a05600c602200b003dc5ad17a40mr7548204wmb.30.1675171153067;
        Tue, 31 Jan 2023 05:19:13 -0800 (PST)
Received: from [192.168.2.177] ([207.188.167.132])
        by smtp.gmail.com with ESMTPSA id a19-20020a05600c349300b003cfa622a18asm20309226wmq.3.2023.01.31.05.19.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 31 Jan 2023 05:19:12 -0800 (PST)
Message-ID: <5192bc94-12c7-dce4-c2e6-fa4b8c1ced9d@gmail.com>
Date:   Tue, 31 Jan 2023 14:19:11 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH v4 05/14] soc: mediatek: mtk-svs: use svs clk control APIs
Content-Language: en-US
To:     Roger Lu <roger.lu@mediatek.com>,
        Enric Balletbo Serra <eballetbo@gmail.com>,
        Kevin Hilman <khilman@kernel.org>,
        Nicolas Boichat <drinkcat@google.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Fan Chen <fan.chen@mediatek.com>,
        Jia-wei Chang <jia-wei.chang@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20230111074528.29354-1-roger.lu@mediatek.com>
 <20230111074528.29354-6-roger.lu@mediatek.com>
From:   Matthias Brugger <matthias.bgg@gmail.com>
In-Reply-To: <20230111074528.29354-6-roger.lu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 11/01/2023 08:45, Roger Lu wrote:
> In MediaTek HW design, svs and thermal both use the same clk source.
> It means that svs clk reference count from CCF includes thermal control
> counts. That makes svs driver confuse whether it disabled svs's main clk
> or not from CCF's perspective and lead to turn off their shared clk
> unexpectedly. Therefore, we add svs clk control APIs to make sure svs's
> main clk is controlled well by svs driver itself.
> 
> Here is a NG example. Rely on CCF's reference count and cause problem.
> 
> thermal probe (clk ref = 1)
> -> svs probe (clk ref = 2)
>     -> svs suspend (clk ref = 1)
>        -> thermal suspend (clk ref = 0)
>        -> thermal resume (clk ref = 1)
>     -> svs resume (encounter error, clk ref = 1)
>     -> svs suspend (clk ref = 0)
>        -> thermal suspend (Fail here, thermal HW control w/o clk)
> 
> Fixes: a825d72f74a3 ("soc: mediatek: fix missing clk_disable_unprepare() on err in svs_resume()")
> Signed-off-by: Roger Lu <roger.lu@mediatek.com>

That looks wrong. Although I don't out of my mind, there should be a way to tell 
the clock framework that this clock is shared between several devices.

I wonder if using clk_enable and clk_disable in svs_resume/suspend wouldn't be 
enough.

Regards,
Matthias

> ---
>   drivers/soc/mediatek/mtk-svs.c | 57 ++++++++++++++++++++++++++--------
>   1 file changed, 44 insertions(+), 13 deletions(-)
> 
> diff --git a/drivers/soc/mediatek/mtk-svs.c b/drivers/soc/mediatek/mtk-svs.c
> index 9575aa645643..830263bad81e 100644
> --- a/drivers/soc/mediatek/mtk-svs.c
> +++ b/drivers/soc/mediatek/mtk-svs.c
> @@ -326,6 +326,7 @@ static const u32 svs_regs_v2[] = {
>    * @bank_max: total number of svs banks
>    * @efuse: svs efuse data received from NVMEM framework
>    * @tefuse: thermal efuse data received from NVMEM framework
> + * @clk_cnt: clock count shows the clk enable/disable times by svs driver
>    */
>   struct svs_platform {
>   	char *name;
> @@ -343,6 +344,7 @@ struct svs_platform {
>   	u32 bank_max;
>   	u32 *efuse;
>   	u32 *tefuse;
> +	s32 clk_cnt;
>   };
>   
>   struct svs_platform_data {
> @@ -502,6 +504,32 @@ static void svs_switch_bank(struct svs_platform *svsp)
>   	svs_writel_relaxed(svsp, svsb->core_sel, CORESEL);
>   }
>   
> +static bool svs_is_clk_enabled(struct svs_platform *svsp)
> +{
> +	return svsp->clk_cnt > 0 ? true : false;
> +}
> +
> +static int svs_clk_enable(struct svs_platform *svsp)
> +{
> +	int ret;
> +
> +	ret = clk_prepare_enable(svsp->main_clk);
> +	if (ret) {
> +		dev_err(svsp->dev, "cannot enable main_clk: %d\n", ret);
> +		return ret;
> +	}
> +
> +	svsp->clk_cnt++;
> +
> +	return 0;
> +}
> +
> +static void svs_clk_disable(struct svs_platform *svsp)
> +{
> +	clk_disable_unprepare(svsp->main_clk);
> +	svsp->clk_cnt--;
> +}
> +
>   static u32 svs_bank_volt_to_opp_volt(u32 svsb_volt, u32 svsb_volt_step,
>   				     u32 svsb_volt_base)
>   {
> @@ -1569,6 +1597,12 @@ static int svs_suspend(struct device *dev)
>   	int ret;
>   	u32 idx;
>   
> +	if (!svs_is_clk_enabled(svsp)) {
> +		dev_err(svsp->dev, "svs clk is disabled already (%d)\n",
> +			svsp->clk_cnt);
> +		return 0;
> +	}
> +
>   	for (idx = 0; idx < svsp->bank_max; idx++) {
>   		svsb = &svsp->banks[idx];
>   
> @@ -1590,7 +1624,7 @@ static int svs_suspend(struct device *dev)
>   		return ret;
>   	}
>   
> -	clk_disable_unprepare(svsp->main_clk);
> +	svs_clk_disable(svsp);
>   
>   	return 0;
>   }
> @@ -1600,16 +1634,14 @@ static int svs_resume(struct device *dev)
>   	struct svs_platform *svsp = dev_get_drvdata(dev);
>   	int ret;
>   
> -	ret = clk_prepare_enable(svsp->main_clk);
> -	if (ret) {
> -		dev_err(svsp->dev, "cannot enable main_clk, disable svs\n");
> +	ret = svs_clk_enable(svsp);
> +	if (ret)
>   		return ret;
> -	}
>   
>   	ret = reset_control_deassert(svsp->rst);
>   	if (ret) {
>   		dev_err(svsp->dev, "cannot deassert reset %d\n", ret);
> -		goto out_of_resume;
> +		goto svs_resume_clk_disable;
>   	}
>   
>   	ret = svs_init02(svsp);
> @@ -1624,8 +1656,9 @@ static int svs_resume(struct device *dev)
>   	dev_err(svsp->dev, "assert reset: %d\n",
>   		reset_control_assert(svsp->rst));
>   
> -out_of_resume:
> -	clk_disable_unprepare(svsp->main_clk);
> +svs_resume_clk_disable:
> +	svs_clk_disable(svsp);
> +
>   	return ret;
>   }
>   
> @@ -2411,11 +2444,9 @@ static int svs_probe(struct platform_device *pdev)
>   		goto svs_probe_free_resource;
>   	}
>   
> -	ret = clk_prepare_enable(svsp->main_clk);
> -	if (ret) {
> -		dev_err(svsp->dev, "cannot enable main clk: %d\n", ret);
> +	ret = svs_clk_enable(svsp);
> +	if (ret)
>   		goto svs_probe_free_resource;
> -	}
>   
>   	svsp->base = of_iomap(svsp->dev->of_node, 0);
>   	if (IS_ERR_OR_NULL(svsp->base)) {
> @@ -2456,7 +2487,7 @@ static int svs_probe(struct platform_device *pdev)
>   	iounmap(svsp->base);
>   
>   svs_probe_clk_disable:
> -	clk_disable_unprepare(svsp->main_clk);
> +	svs_clk_disable(svsp);
>   
>   svs_probe_free_resource:
>   	if (!IS_ERR_OR_NULL(svsp->efuse))
