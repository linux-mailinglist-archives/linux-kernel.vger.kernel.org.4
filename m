Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7BDAA69735C
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 02:17:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233349AbjBOBRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 20:17:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229739AbjBOBRL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 20:17:11 -0500
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28F9E22028
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:16:45 -0800 (PST)
Received: by mail-ej1-x633.google.com with SMTP id qb15so42408176ejc.1
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 17:16:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tsL0JC0jIYt1eWNNiISDr2Crkn4kE3SVi+fK75Pa3h4=;
        b=GjVSRVTxL3vlFqiY/wo5OhPhh49iB7o0pspEj3sIXwfqzv0eVeSNeNQT3VR21+koAs
         Tcb3DyVsM6psoRlMf7dmOj52ItH7Bmt6gHCpKpDwSekX0zSkdb351ptRQEUsMW0TlxpV
         6dlYbFhMCovT+1RjUXMKl1qJM3yx3sbtr8LApXiDINjpRBmrII+DqD24+b8MgRPflSqc
         NBTuSvw/bOO4i4GFGW5NtNzOZuh8x6jPQysPYON6HSkimxcibn1UyhDJpqiiNI3XQPmh
         eQeFvuJTx1Va8XIEcnRHlXauS/vDucUUpB37U8CYLxfKDJVEJWGmKWKwMzvqI0i783sr
         3TcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tsL0JC0jIYt1eWNNiISDr2Crkn4kE3SVi+fK75Pa3h4=;
        b=ZBMdjecKACvt7sMJFx9f4j3bU7dI+si5yAGPBLD05fJqCL8chHstQJafLtaTVSF3QZ
         pKOPjUJI63s4u4hBPfeUghq2KgY6Ecat6U9QRD5SjBs9p9wpKcjXoREeSYZQxGfJjlHM
         ELsyiELQqT0iG4QZMEYstvTkvY+lXh0oArEXjuiweAvI7kkW8M0gN6jXAMlx+qGtyopM
         rheK9WGbaGMEgg56aMymn++DhOi9d1SXSVz4eMilqMJGPN7kGz8Tfzp2TV6K4OdNx8TJ
         LpEnGvMrHjtlUT3cbrri5SN6WVWXAV2HNAQ1757SOAzkqarBm/2RGAQcK3DS+8Ts1Hos
         fYDA==
X-Gm-Message-State: AO0yUKXFgg5R19m0JacJ5uih/HkjH0Wp4k6vamvg102uZF96wKqMxBJ4
        EKOr99S6e9HO3/jv4H5yoOQUKg==
X-Google-Smtp-Source: AK7set8dv/Ef8OZSTCONkuQ4/DT0CAVesD4kalNwB/6MnwOT3jAt2lMmDUNw7jsC8nfbPmpGCDJKJg==
X-Received: by 2002:a17:906:868a:b0:878:5917:601 with SMTP id g10-20020a170906868a00b0087859170601mr382784ejx.58.1676423802326;
        Tue, 14 Feb 2023 17:16:42 -0800 (PST)
Received: from ?IPV6:2001:14ba:a085:4d00::8a5? (dzccz6yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a085:4d00::8a5])
        by smtp.gmail.com with ESMTPSA id bl4-20020a170906c24400b00880dbd4b6d4sm8941429ejb.136.2023.02.14.17.16.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 17:16:41 -0800 (PST)
Message-ID: <24167f9e-328c-0201-7eea-de201bed4b6a@linaro.org>
Date:   Wed, 15 Feb 2023 03:16:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH v4 12/12] interconnect: qcom: icc-rpm: Allow negative QoS
 offset
Content-Language: en-GB
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230214143720.2416762-1-konrad.dybcio@linaro.org>
 <20230214143720.2416762-13-konrad.dybcio@linaro.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230214143720.2416762-13-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/2023 16:37, Konrad Dybcio wrote:
> In some very very very very unfortunate cases, the correct offset of
> the QoS registers will be.. negative. One such case is MSM8998, where
> The DDR BWMON occupies what-would-be-the-BIMC-base which we usually
> take into account with the register calculation, making the actual
> BIMC node start at what-would-be-the-BIMC-base+0x300.
> 
> In order to keep the calculation code sane, the simplest - however
> ugly it may be - solution is to allow the offset to be negative.

I'm not sure how does this work, as e.g. qcom_icc_set_qnoc_qos() will 
try to access an address before the first register. Most probably this 
patch should go together with the rest of msm8998 patches.

A slightly better solution to making qos_offset negative might be to 
make bwmon a child node of the icc.

> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/interconnect/qcom/icc-rpm.h | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.h b/drivers/interconnect/qcom/icc-rpm.h
> index 77e263b93c27..5e4215f25c2e 100644
> --- a/drivers/interconnect/qcom/icc-rpm.h
> +++ b/drivers/interconnect/qcom/icc-rpm.h
> @@ -39,7 +39,7 @@ struct qcom_icc_provider {
>   	int num_intf_clks;
>   	enum qcom_icc_type type;
>   	struct regmap *regmap;
> -	unsigned int qos_offset;
> +	int qos_offset;
>   	u64 bus_clk_rate[2];
>   	bool keep_alive;
>   	struct clk_bulk_data bus_clks[2];
> @@ -105,7 +105,7 @@ struct qcom_icc_desc {
>   	bool keep_alive;
>   	enum qcom_icc_type type;
>   	const struct regmap_config *regmap_cfg;
> -	unsigned int qos_offset;
> +	int qos_offset;
>   };
>   
>   /* Valid for all bus types */

-- 
With best wishes
Dmitry

