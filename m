Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8446A6B92AF
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 13:07:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230231AbjCNMH2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 08:07:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231360AbjCNMHW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 08:07:22 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5C66133E
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:06:47 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id m4so6694240lfj.2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Mar 2023 05:06:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678795575;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=e6PMzxNPu0tsz3tjRajBCZnSPtI1e5mB9Su+fsMf3bk=;
        b=Dkuwu1dFGFoMSVkuxQVa1GD2Nl2OPE0YFBafjm4iaAtc+EQ3/NFUJ+GST24b3ymsk6
         um+RZQxhy6h4v6XpKGwQxpxPqWHbeAlSvSMmMMY/SS+evvb/aJN7KzCddo/jt0n6ifFk
         AKIB8DZ+nAbo5tzq8nFdIYGXgfQiBDidop5k9mLq/HcuNnmauJaZjtkceAQilJhSVqzD
         ynqDM13h6tIfchnN5G+2V2a8vEmaxKx6YmStmk+soihKqtVx/mr4lOgFQJ9CLdKKY5mF
         qUSxVkozbLLnGjWcffoaHK9E2+Dq301aqJYS1TI5TQ5jcmHLJF+VlULpRU+TE5LVuN+v
         IXMg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678795575;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=e6PMzxNPu0tsz3tjRajBCZnSPtI1e5mB9Su+fsMf3bk=;
        b=XBy1f5m6S07o0AawOe50Q04iWxv6NpzxP1QK+SFrxqBa/hIoMjcuFR7WP5xelTb+M/
         wp+vZA8wxO7LHHgk9KqBVBhT3Qgwkw+fafB2fC+o9MHIPz0T3bZpLga6Iwm0pC5jkMAR
         /68j9vcmpfQhz7eDNnu6B/Qo6rCPzdT/7KTEsjj0wbs7mvBB0fQPB0q9oh4vh4mJ2GH5
         k/0A6DrEDaGubF7ymf1jHTNfSoJ+UbRn1FpbbUrZloBojqB1YohgD90b9Yz88pRtYhj1
         yEhkjqXl4dwamtHSEMAn4Y6U8NIvkOEimKgbhzMsAsdPMcX04Vt/e2r/HIB50jtJf4g+
         2wiQ==
X-Gm-Message-State: AO0yUKV9CnieAvlr3x7LcaeNUXwZJLinA/IfWU6SozlwqcT+j98MWyeV
        3+2gZoEtxWyCvkXMmju+z/28zg==
X-Google-Smtp-Source: AK7set8y1S3Ew42r0fNJc7kHIb75SA1cUzze9ztJfgE0b5T6mi+HLLRdUIRz6wmiM+EMjWdU5uLedg==
X-Received: by 2002:ac2:4189:0:b0:4dd:ad88:ba5c with SMTP id z9-20020ac24189000000b004ddad88ba5cmr712969lfh.4.1678795575616;
        Tue, 14 Mar 2023 05:06:15 -0700 (PDT)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id f25-20020ac251b9000000b004dab932248fsm378828lfk.180.2023.03.14.05.06.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Mar 2023 05:06:14 -0700 (PDT)
Message-ID: <20ebe4a3-1352-ae02-a56b-672ff3fcf12d@linaro.org>
Date:   Tue, 14 Mar 2023 13:06:12 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v3 06/10] drm/msm/dsi: Switch the QCM2290-specific
 compatible to index autodetection
Content-Language: en-US
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Krishna Manikandan <quic_mkrishn@quicinc.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh@kernel.org>, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230307-topic-dsi_qcm-v3-0-8bd7e1add38a@linaro.org>
 <20230307-topic-dsi_qcm-v3-6-8bd7e1add38a@linaro.org>
 <20230314000322.ptxs5d5mx54vdopa@SoMainline.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230314000322.ptxs5d5mx54vdopa@SoMainline.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_HTTP,RCVD_IN_SORBS_SOCKS,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 14.03.2023 01:03, Marijn Suijten wrote:
> On 2023-03-07 14:01:44, Konrad Dybcio wrote:
>> Now that the logic can handle multiple sets of registers, move
>> the QCM2290 to the common logic and mark it deprecated. This allows us
>> to remove a couple of structs, saving some memory.
>>
>> Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/gpu/drm/msm/dsi/dsi.c     |  4 +++-
>>  drivers/gpu/drm/msm/dsi/dsi_cfg.c | 28 ++--------------------------
>>  2 files changed, 5 insertions(+), 27 deletions(-)
>>
>> diff --git a/drivers/gpu/drm/msm/dsi/dsi.c b/drivers/gpu/drm/msm/dsi/dsi.c
>> index 31fdee2052be..90d43628b22b 100644
>> --- a/drivers/gpu/drm/msm/dsi/dsi.c
>> +++ b/drivers/gpu/drm/msm/dsi/dsi.c
>> @@ -174,7 +174,9 @@ static int dsi_dev_remove(struct platform_device *pdev)
>>  
>>  static const struct of_device_id dt_match[] = {
>>  	{ .compatible = "qcom,mdss-dsi-ctrl", .data = NULL /* autodetect cfg */ },
>> -	{ .compatible = "qcom,dsi-ctrl-6g-qcm2290", .data = &qcm2290_dsi_cfg_handler },
>> +
>> +	/* Deprecated, don't use */
>> +	{ .compatible = "qcom,dsi-ctrl-6g-qcm2290", .data = NULL },
>>  	{}
>>  };
>>  
>> diff --git a/drivers/gpu/drm/msm/dsi/dsi_cfg.c b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
>> index 6d4b2ce4b918..29ccd755cc2e 100644
>> --- a/drivers/gpu/drm/msm/dsi/dsi_cfg.c
>> +++ b/drivers/gpu/drm/msm/dsi/dsi_cfg.c
>> @@ -169,7 +169,8 @@ static const struct msm_dsi_config sdm845_dsi_cfg = {
>>  	.bus_clk_names = dsi_v2_4_clk_names,
>>  	.num_bus_clks = ARRAY_SIZE(dsi_v2_4_clk_names),
>>  	.io_start = {
>> -		{ 0xae94000, 0xae96000 }, /* SDM845 / SDM670 / SC7180 */
>> +		{ 0xae94000, 0xae96000 }, /* SDM845 / SDM670 */
>> +		{ 0x5e94000 }, /* QCM2290 / SM6115 / SM6125 / SM6375 */
>>  	},
>>  };
>>  
>> @@ -203,25 +204,6 @@ static const struct msm_dsi_config sc7280_dsi_cfg = {
>>  	},
>>  };
>>  
>> -static const char * const dsi_qcm2290_bus_clk_names[] = {
>> -	"iface", "bus",
>> -};
>> -
>> -static const struct regulator_bulk_data qcm2290_dsi_cfg_regulators[] = {
>> -	{ .supply = "vdda", .init_load_uA = 21800 },	/* 1.2 V */
>> -};
> 
> These two consts should really have already been deleted as part of
> 04/10: drm/msm/dsi: dsi_cfg: Deduplicate identical structs.
Right, will fix

> 
>> -static const struct msm_dsi_config qcm2290_dsi_cfg = {
>> -	.io_offset = DSI_6G_REG_SHIFT,
>> -	.regulator_data = qcm2290_dsi_cfg_regulators,
>> -	.num_regulators = ARRAY_SIZE(qcm2290_dsi_cfg_regulators),
>> -	.bus_clk_names = dsi_qcm2290_bus_clk_names,
>> -	.num_bus_clks = ARRAY_SIZE(dsi_qcm2290_bus_clk_names),
>> -	.io_start = {
>> -		{ 0x5e94000 },
>> -	},
>> -};
>> -
>>  static const struct msm_dsi_host_cfg_ops msm_dsi_v2_host_ops = {
>>  	.link_clk_set_rate = dsi_link_clk_set_rate_v2,
>>  	.link_clk_enable = dsi_link_clk_enable_v2,
>> @@ -312,9 +294,3 @@ const struct msm_dsi_cfg_handler *msm_dsi_cfg_get(u32 major, u32 minor)
>>  
>>  	return cfg_hnd;
>>  }
>> -
>> -/*  Non autodetect configs */
>> -const struct msm_dsi_cfg_handler qcm2290_dsi_cfg_handler = {
>> -	.cfg = &qcm2290_dsi_cfg,
>> -	.ops = &msm_dsi_6g_v2_host_ops,
>> -};
> 
> And how do you think dsi.c is able to reference this... don't forget to
> remove it from dsi_cfg.h in v4.  In fact, if you look at how this was
> implemented you should also be able to remove #include "dsi_cfg.h" from
> dsi.c.  A clean revert of that patch would be nice, or just use it as
> reference to find the remnants:
> 
> https://lore.kernel.org/all/1644853060-12222-2-git-send-email-loic.poulain@linaro.org/
Ack

Konrad
> 
> - Marijn
