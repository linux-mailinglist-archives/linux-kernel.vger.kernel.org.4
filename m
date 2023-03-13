Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0306B722D
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Mar 2023 10:11:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjCMJK4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Mar 2023 05:10:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231236AbjCMJKe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Mar 2023 05:10:34 -0400
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 15CC0CC02
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:10:03 -0700 (PDT)
Received: by mail-lf1-x12a.google.com with SMTP id n2so14703727lfb.12
        for <linux-kernel@vger.kernel.org>; Mon, 13 Mar 2023 02:10:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678698602;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=7aY14zEhDNC6Iw4MnZQWVJ1q/taMZFItzZke1HHu3Zs=;
        b=DBZQrTFcvPr2zMcgrb0f7wqCJDEzSq7UPSp+DZBgIuYV1MqRAGNsumyGXnDcncpWZi
         MQz3p3HpysfBlbfCFqdYm1ykeK3t7RHE3eXidqLOy3O3UQXUCHSX2WlrWDxUz3zSIK09
         pz2Ne1D+gKMl9QYInAieCq4TaNEoBdmwr2WDR5Or5i4ovVwirsiVNr3HGngRj9sboWBf
         H09J2a3O91KSfdi+NfVoFaeBsqF7nRMbjLuMCaCAxRIT4AXaPnWVH0HfQAoBlsGGx0CD
         +ztqT+K0s3kpgxJV8jjhAAD03vy8B1AZE1xSCNZsT2k0jp6H3X0TaydR+DVKTkPcfFVs
         A7CA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678698602;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=7aY14zEhDNC6Iw4MnZQWVJ1q/taMZFItzZke1HHu3Zs=;
        b=0oRDHqpxEW2tvGPzuMRaBJZNFcJs4PBk1N6sQNFX8r1V6Sbq4jhWWQ7ulb4AcZvJ5y
         FZhtaIcYlNeN0NxRLA6z18Hr4BIxFoTaS9zKy5j6A9FjUofn8ktrAIwkXEgSB1eGNnNE
         4i9pvSas2ldJxRIft4EkOdhmlDJ5d2EpZ80pZSzjTMv37IXqC6t7O4QW8yI7+PrAy4HA
         cFVZZVs6eEZJzqA0Qd43FFX1ojsEs4wTjvo0Yi0dXmkOnd7BEPGdYWwIJcVYfS/jT+2n
         B4p+B5g8qJ2e3YTvBUdxmeiVt9k/FJ/qXALkl16SSqY2/iqLv7sg3XWxsqDhA2Ut9+Z/
         m56Q==
X-Gm-Message-State: AO0yUKXtt6vpy9xsd8J4DfxgIn3FKOhh2sQDIkoShAzO076Zb3V3LI4w
        DeRBXgFll32va76rZHv5oLP3vw==
X-Google-Smtp-Source: AK7set8CUgmV2ifXQ4GVSQbtuTjAaLfWL+iD1zJeMiMJGAtKnEp0+rnc5ubsAPhwvTknzukJ+//fzw==
X-Received: by 2002:a19:ac05:0:b0:4b5:5b36:28bd with SMTP id g5-20020a19ac05000000b004b55b3628bdmr3181743lfc.2.1678698602212;
        Mon, 13 Mar 2023 02:10:02 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id x7-20020ac24887000000b004d5813386fdsm901376lfc.139.2023.03.13.02.10.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Mar 2023 02:10:01 -0700 (PDT)
Message-ID: <3b0cad53-391e-806d-536b-609dbca9e5d4@linaro.org>
Date:   Mon, 13 Mar 2023 10:10:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 2/2] interconnect: qcom: rpm: drop bogus pm domain attach
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Yassine Oudjana <y.oudjana@protonmail.com>,
        Christophe JAILLET <christophe.jaillet@wanadoo.fr>,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230313084953.24088-1-johan+linaro@kernel.org>
 <20230313084953.24088-3-johan+linaro@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230313084953.24088-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 13.03.2023 09:49, Johan Hovold wrote:
> Any power domain would already have been attached by the platform bus
> code so drop the bogus power domain attach which always succeeds from
> probe.
> 
> This effectively reverts commit 7de109c0abe9 ("interconnect: icc-rpm:
> Add support for bus power domain").
> 
> Fixes: 7de109c0abe9 ("interconnect: icc-rpm: Add support for bus power domain")
> Cc: Yassine Oudjana <y.oudjana@protonmail.com>
> Signed-off-by: Johan Hovold <johan+linaro@kernel.org>
> ---
Running Friday's -next (so, without your cleanups):

cat /sys/kernel/debug/pm_genpd/aggre0_noc/current_state
> on

Removing the pd attach:

cat /sys/kernel/debug/pm_genpd/aggre0_noc/current_state
> on

Also removing the other consumer of this genpd, the simple-pm-bus
hosting PCIe:

cat /sys/kernel/debug/pm_genpd/aggre0_noc/current_state
> on

So it looks like that's the case!

Tested-by: Konrad Dybcio <konrad.dybcio@linaro.org> # MSM8996 Sony Kagura
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/interconnect/qcom/icc-rpm.c | 6 ------
>  drivers/interconnect/qcom/icc-rpm.h | 1 -
>  drivers/interconnect/qcom/msm8996.c | 1 -
>  3 files changed, 8 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 3b055cd893ea..c303ce22a7cd 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -496,12 +496,6 @@ int qnoc_probe(struct platform_device *pdev)
>  	if (ret)
>  		return ret;
>  
> -	if (desc->has_bus_pd) {
> -		ret = dev_pm_domain_attach(dev, true);
> -		if (ret)
> -			goto err_disable_clks;
> -	}
> -
>  	provider = &qp->provider;
>  	provider->dev = dev;
>  	provider->set = qcom_icc_set;
> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
> index a49af844ab13..02257b0d3d5c 100644
> --- a/drivers/interconnect/qcom/icc-rpm.h
> +++ b/drivers/interconnect/qcom/icc-rpm.h
> @@ -91,7 +91,6 @@ struct qcom_icc_desc {
>  	size_t num_nodes;
>  	const char * const *clocks;
>  	size_t num_clocks;
> -	bool has_bus_pd;
>  	enum qcom_icc_type type;
>  	const struct regmap_config *regmap_cfg;
>  	unsigned int qos_offset;
> diff --git a/drivers/interconnect/qcom/msm8996.c b/drivers/interconnect/qcom/msm8996.c
> index 25a1a32bc611..14efd2761b7a 100644
> --- a/drivers/interconnect/qcom/msm8996.c
> +++ b/drivers/interconnect/qcom/msm8996.c
> @@ -1823,7 +1823,6 @@ static const struct qcom_icc_desc msm8996_a0noc = {
>  	.num_nodes = ARRAY_SIZE(a0noc_nodes),
>  	.clocks = bus_a0noc_clocks,
>  	.num_clocks = ARRAY_SIZE(bus_a0noc_clocks),
> -	.has_bus_pd = true,
>  	.regmap_cfg = &msm8996_a0noc_regmap_config
>  };
>  
