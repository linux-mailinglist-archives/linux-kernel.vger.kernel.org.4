Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2A04719831
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 12:03:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232155AbjFAKDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 06:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42510 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233111AbjFAKC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 06:02:29 -0400
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B8DA1713
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 03:01:08 -0700 (PDT)
Received: by mail-lj1-x229.google.com with SMTP id 38308e7fff4ca-2b1a4250b07so4597221fa.3
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 03:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685613666; x=1688205666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=pbHx9mkIalFYvQk8AttERn7Qct3Pcni+m/qMzQruD+4=;
        b=hY77+3PnaYNoXfjz6DnJMvVK/CPrtjDNsHiU02S0qAnScAgBe58nlmVXA3o3+HO9/Y
         lMb5m4YJU1CzLClBUErD8GAcbybGSjiau/aq19DCxF0AN0GVUZg3cK4iQJS7ziGa3xMq
         b/BxSv+pTrGoLwLv0SwdUCZ2CJMw6JLVlTXxpQkKPoCCgyOJIPJKq7D2WB9KwOs7kD7c
         8oZVQKD+NbIFzbisx1hW5Tzd1D/p1rkvH8tl6075O3hwiHEX49t+km9XgYeDAZ/ZBluM
         RLKChJAVviSMdwhnFL+ut9bBwjbRS+/RbBPnsjhAvp8xO3ys4sBtk1/QS1Xka23WSNP4
         uuLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685613666; x=1688205666;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=pbHx9mkIalFYvQk8AttERn7Qct3Pcni+m/qMzQruD+4=;
        b=iT07dbTDI3xzClzYLaloSAaGGsi7e6Sp6wIT1hGaFPvaPwkRW2rfQt3R1dpCklJhBE
         gwaEIjAol24ObKD9Aw18Y3Y0DyJaAULeGiNQrBsHZbL3Vv/vnc4UOL5+IweQ/bUwG7gd
         kBYZ+UGNzbAnTiRCwFkq8zeq/zB0gArT0aQy42U4hCyteiESUgdy/TaHOpaMvF1fGvD6
         cFyO6Ecd527f+EWfGg7yt3AIDmru8DkQ2G9kQv0DO3VNkV7icy4yB072D0Li3dciKeUA
         V9EbDwutBh5odX+DHLBYkrmSAkOx+R9JR5AQsIETZ71we/gn7nXilr21C4qo7tjBUyJB
         S32w==
X-Gm-Message-State: AC+VfDwEUTaosSVBTDaJgUfmT1Ek3Axt5nDe6aZ6Mvq6uSefZTbqGLxz
        ALQG/EY+o+1ahkl0RNs2ycPKMw==
X-Google-Smtp-Source: ACHHUZ5otxg+ZdtCapOECusyx762HUEeeuoYczj6fNB2WK3usI3rpILgz5tz7mpDEcwsaxiV0yx7Eg==
X-Received: by 2002:a2e:95d9:0:b0:2af:23c0:ffe2 with SMTP id y25-20020a2e95d9000000b002af23c0ffe2mr4852488ljh.48.1685613666259;
        Thu, 01 Jun 2023 03:01:06 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id p10-20020a2e740a000000b002a8bb52d994sm3707426ljc.25.2023.06.01.03.01.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 03:01:05 -0700 (PDT)
Message-ID: <011a8584-b92e-2b80-3b0b-f6af21d23ef9@linaro.org>
Date:   Thu, 1 Jun 2023 13:01:05 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 08/20] interconnect: qcom: smd-rpm: Add rpmcc handling
 skeleton code
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Georgi Djakov <djakov@kernel.org>,
        Leo Yan <leo.yan@linaro.org>, Evan Green <evgreen@chromium.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230526-topic-smd_icc-v1-0-1bf8e6663c4e@linaro.org>
 <20230526-topic-smd_icc-v1-8-1bf8e6663c4e@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230526-topic-smd_icc-v1-8-1bf8e6663c4e@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 13:20, Konrad Dybcio wrote:
> Introduce qcom_icc_rpm_set_bus_rate() in preparation for handling RPM
> clock resources within the interconnect framework. This lets us greatly
> simplify all of the code handling, as setting the rate comes down to:
> 
> u32 rate_khz = max(clk.sleep_rate, clk.active_rate, clk_a.active_rate)
> write_to_rpm(clock.description, rate_khz);
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/interconnect/qcom/icc-rpm.h | 15 +++++++++++++++
>   drivers/interconnect/qcom/smd-rpm.c | 37 +++++++++++++++++++++++++++++++++++++
>   2 files changed, 52 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
> index 9b4ea4e39b9f..aec192321411 100644
> --- a/drivers/interconnect/qcom/icc-rpm.h
> +++ b/drivers/interconnect/qcom/icc-rpm.h
> @@ -22,6 +22,18 @@ enum qcom_icc_type {
>   	QCOM_ICC_QNOC,
>   };
>   
> +/**
> + * struct rpm_clk_resource - RPM bus clock resource
> + * @resource_type: RPM resource type of the clock resource
> + * @clock_id: index of the clock resource of a specific resource type
> + * @branch: whether the resource represents a branch clock
> +*/
> +struct rpm_clk_resource {
> +	u32 resource_type;
> +	u32 clock_id;
> +	bool branch;
> +};
> +
>   #define NUM_BUS_CLKS	2
>   
>   /**
> @@ -47,6 +59,7 @@ struct qcom_icc_provider {
>   	int qos_offset;
>   	u64 bus_clk_rate[NUM_BUS_CLKS];
>   	struct clk_bulk_data bus_clks[NUM_BUS_CLKS];
> +	const struct rpm_clk_resource *bus_clk_desc;
>   	struct clk_bulk_data *intf_clks;
>   	bool keep_alive;
>   	bool is_on;
> @@ -104,6 +117,7 @@ struct qcom_icc_desc {
>   	struct qcom_icc_node * const *nodes;
>   	size_t num_nodes;
>   	const char * const *bus_clocks;
> +	const struct rpm_clk_resource *bus_clk_desc;
>   	const char * const *intf_clocks;
>   	size_t num_intf_clocks;
>   	bool keep_alive;
> @@ -125,5 +139,6 @@ int qnoc_remove(struct platform_device *pdev);
>   
>   bool qcom_icc_rpm_smd_available(void);
>   int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val);
> +int qcom_icc_rpm_set_bus_rate(const struct rpm_clk_resource *clk, u32 active_rate, u32 sleep_rate);
>   
>   #endif
> diff --git a/drivers/interconnect/qcom/smd-rpm.c b/drivers/interconnect/qcom/smd-rpm.c
> index b0183262ba66..6c51e346b326 100644
> --- a/drivers/interconnect/qcom/smd-rpm.c
> +++ b/drivers/interconnect/qcom/smd-rpm.c
> @@ -16,6 +16,7 @@
>   #include "icc-rpm.h"
>   
>   #define RPM_KEY_BW		0x00007762
> +#define QCOM_RPM_SMD_KEY_RATE	0x007a484b

Nit: can we move all RPM keys to some common header?

>   
>   static struct qcom_smd_rpm *icc_smd_rpm;
>   
> @@ -44,6 +45,38 @@ int qcom_icc_rpm_smd_send(int ctx, int rsc_type, int id, u32 val)
>   }
>   EXPORT_SYMBOL_GPL(qcom_icc_rpm_smd_send);
>   
> +int qcom_icc_rpm_set_bus_rate(const struct rpm_clk_resource *clk, u32 active_rate, u32 sleep_rate)
> +{
> +	struct clk_smd_rpm_req req = {
> +		.key = cpu_to_le32(QCOM_RPM_SMD_KEY_RATE),
> +		.nbytes = cpu_to_le32(sizeof(u32)),
> +	};
> +	int ret;
> +
> +	/* Branch clocks are only on/off */
> +	if (clk->branch) {
> +		active_rate = !!active_rate;
> +		sleep_rate = !!sleep_rate;
> +	}
> +
> +	req.value = cpu_to_le32(active_rate);
> +	ret = qcom_rpm_smd_write(icc_smd_rpm,
> +				 QCOM_SMD_RPM_ACTIVE_STATE,
> +				 clk->resource_type,
> +				 clk->clock_id,
> +				 &req, sizeof(req));
> +	if (ret)
> +		return ret;
> +
> +	req.value = cpu_to_le32(sleep_rate);
> +	return qcom_rpm_smd_write(icc_smd_rpm,
> +				  QCOM_SMD_RPM_SLEEP_STATE,
> +				  clk->resource_type,
> +				  clk->clock_id,
> +				  &req, sizeof(req));
> +}
> +EXPORT_SYMBOL_GPL(qcom_icc_rpm_set_bus_rate);
> +
>   static int qcom_icc_rpm_smd_remove(struct platform_device *pdev)
>   {
>   	icc_smd_rpm = NULL;
> @@ -60,6 +93,10 @@ static int qcom_icc_rpm_smd_probe(struct platform_device *pdev)
>   		return -ENODEV;
>   	}
>   
> +	/* We need the clock driver to kick things off first to avoid ugly races */
> +	if (!qcom_smd_rpm_scaling_available())
> +		return -EPROBE_DEFER;


This should not be a part of this commit.

> +
>   	return 0;
>   }
>   
> 

-- 
With best wishes
Dmitry

