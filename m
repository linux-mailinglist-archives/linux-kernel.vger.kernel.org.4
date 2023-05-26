Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E7D712E90
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 22:57:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242984AbjEZU5I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 16:57:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjEZU5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 16:57:05 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF65318D
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:57:03 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id 5b1f17b1804b1-3f6cbdf16d2so8220775e9.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 13:57:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685134622; x=1687726622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Kevd9tgDOgwSftXhTE9dzSQzFuyzebjoDk0q9mVsTsM=;
        b=zrMSuFrykCqYrES/4m1rxa7Iwr1yjsnItV90+UE5VsksD7vg2YqmE65phbqV1XxFop
         EqfQoXnsO40ix2C+2Z+CQXNxYBGRNN4hoCrOZi40c5h93dUAWLjfVJ0jibg6VQe9CMbr
         pGFiQ0paD8Ux+53BP/Aq6vGkKRoOMQ743WINZ/ndUz5Zra8Grgc4JyxGKOl9zhclET2y
         29238zkCQHIQIJ/FC5/cYgMjAtKcQVI7TO+MZ/wrlEIeVdEWx8UZ9955yCv143W+YGYD
         UOs8Z81oCefMibvas7pwcp45cDbm9iyneAgvJSDm29DqjJg/wT4KlkXGtE0g1Jj1gRdr
         BdaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685134622; x=1687726622;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Kevd9tgDOgwSftXhTE9dzSQzFuyzebjoDk0q9mVsTsM=;
        b=b2tqfoJfnn7eOtnYkuhHN9G8hnzlZ3RY7GPZv1itBKhjnUaUoT3U4hDIuRFe6sZIYu
         rSSks+Cw7FxCodjOZt7zR8RL4OKEgcFl7m3hORwxMvBhbVu5r6VzjX2U7L2uwHC1BWnh
         YEGlBRmBtnmNP7oY1mGEktReh5VwzE+PHlPbEqvGAhSC101mbPssJTnSZC4lJ7Y7j0gs
         LLqn/lq68q1WiHXhzeYN81yNWr8HYz57Pe79jz/ynPzrv0EvuZCf0xHryvyWJXt3gREM
         HnL6ySiHLN5Ov3ycqsoQx35KffiJzgSjTWLMIhA4v5t4CR4lSz6uUXZ/zrrFOd39fm2R
         fcfw==
X-Gm-Message-State: AC+VfDwQdAAmDu1UXI5nkwLOq+0fPHM5Bd6Cs8A3wLMj7OYP9tLxPPRw
        MF7bAKMdcoxda90Ky9muNW2sVQ==
X-Google-Smtp-Source: ACHHUZ6C0A0jH4aVSmj3MVzhbuO2WL9I5GXhgB8XXQaTo2ua9/gIcfIkWZCpxaX5A+5RfmSpS6AWag==
X-Received: by 2002:a05:600c:d0:b0:3f6:7fb:b60e with SMTP id u16-20020a05600c00d000b003f607fbb60emr2075206wmm.35.1685134622380;
        Fri, 26 May 2023 13:57:02 -0700 (PDT)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id y12-20020a1c4b0c000000b003f4290720d0sm9721917wma.47.2023.05.26.13.57.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 13:57:01 -0700 (PDT)
Message-ID: <7124bf0e-193b-46a1-ea88-23d7df3bffa5@linaro.org>
Date:   Fri, 26 May 2023 21:57:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 3/3] media: camss: Link CAMSS power domain
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Robert Foss <rfoss@kernel.org>,
        Todor Tomov <todor.too@gmail.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230526180712.8481-1-y.oudjana@protonmail.com>
 <20230526180712.8481-4-y.oudjana@protonmail.com>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230526180712.8481-4-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/05/2023 19:07, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> The CAMSS power domain was previously enabled implicitly when the VFE
> power domains were enabled.
> Commit 46cc03175498 ("media: camss: Split power domain management")
> delayed enabling VFE power domains which in turn delayed enabling the
> CAMSS power domain. This made CSIPHY fail to enable camss_top_ahb_clk
> which requires the CAMSS power domain to be on:
> 
> [  199.097810] ------------[ cut here ]------------
> [  199.097893] camss_top_ahb_clk status stuck at 'off'
> [  199.097913] WARNING: CPU: 3 PID: 728 at drivers/clk/qcom/clk-branch.c:91 clk_branch_wait+0x140/0x160
> ...
> [  199.100064]  clk_branch_wait+0x140/0x160
> [  199.100112]  clk_branch2_enable+0x30/0x40
> [  199.100159]  clk_core_enable+0x6c/0xb0
> [  199.100211]  clk_enable+0x2c/0x50
> [  199.100257]  camss_enable_clocks+0x94/0xe0 [qcom_camss]
> [  199.100342]  csiphy_set_power+0x154/0x2a0 [qcom_camss]
> ...
> [  199.101594] ---[ end trace 0000000000000000 ]---
> 
> Link the CAMSS power domain in camss_configure_pd to make sure it gets
> enabled before CSIPHY tries to enable clocks.
> 
> Fixes: 02afa816dbbf ("media: camss: Add basic runtime PM support")
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>   drivers/media/platform/qcom/camss/camss.c | 9 ++++++++-
>   1 file changed, 8 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/camss/camss.c b/drivers/media/platform/qcom/camss/camss.c
> index 1ef26aea3eae..9aea8220d923 100644
> --- a/drivers/media/platform/qcom/camss/camss.c
> +++ b/drivers/media/platform/qcom/camss/camss.c
> @@ -1453,6 +1453,7 @@ static const struct media_device_ops camss_media_ops = {
>   static int camss_configure_pd(struct camss *camss)
>   {
>   	struct device *dev = camss->dev;
> +	int camss_pd_index;
>   	int i;
>   	int ret;
>   
> @@ -1496,7 +1497,13 @@ static int camss_configure_pd(struct camss *camss)
>   		}
>   	}
>   
> -	if (i > camss->vfe_num) {
> +	/* Link CAMSS power domain if available */
> +	camss_pd_index = device_property_match_string(camss->dev, "power-domain-names", "camss");
> +	if (camss_pd_index >= 0)

Surely if you get this far you already know that

camss->genpd_num = of_count_phandle_with_args(dev->of_node,
                                               "power-domains",
                                               "#power-domain-cells");
if (camss->genpd_num < 0) {
         dev_err(dev, "Power domains are not defined for camss\n");
         return camss->genpd_num;
}

So you don't need to add this additional dependency ?

---
bod
