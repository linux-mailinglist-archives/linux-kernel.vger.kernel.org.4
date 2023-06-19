Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9ED7E7351A0
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Jun 2023 12:10:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231866AbjFSKKi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Jun 2023 06:10:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231845AbjFSKKV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Jun 2023 06:10:21 -0400
Received: from mail-wm1-x335.google.com (mail-wm1-x335.google.com [IPv6:2a00:1450:4864:20::335])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B90710C0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:09:53 -0700 (PDT)
Received: by mail-wm1-x335.google.com with SMTP id 5b1f17b1804b1-3f90b8acefeso12725785e9.0
        for <linux-kernel@vger.kernel.org>; Mon, 19 Jun 2023 03:09:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687169381; x=1689761381;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=qL1Y9NTTBFPTkLhCXPXhMrGsEQz66xI2d8hJPKibEXE=;
        b=ecl8/xkZnzxzwe1eJeQ03wgBEZ/tw5tQF+fKaVcp3eggBHVTKjxoB80xb872DQdfO6
         yrIqcQsJSzw2ht1btgrJgLGsfdSH8FwxPcFBWfu15tx1WzPppHLrafK91LNIRIL0/Cde
         lVQwgjSveA0Xa5X1+RFpDGFzK8ptefNmHogIv77x0rF4CgLOMCRkPcmLrg69024UMiE1
         jNYJZ+/kp4eWCjI0P7Y8xbAzyPY7vhxY75I0ZdiRKMD3cIjVCh4rJtkiGk5vKADvrQo9
         uiDTUGuhL8RpHxenz8+q0FpZ8VH0VNRJvSmdO1mvwBpRqZhebBfWveidCRhO9ZAMGCXL
         omRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687169381; x=1689761381;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :content-language:subject:reply-to:from:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qL1Y9NTTBFPTkLhCXPXhMrGsEQz66xI2d8hJPKibEXE=;
        b=kUQakrWnatYtTeSqeW8C79m2eBUwd1J/4fOi0mDDDhjxWHPRzvPMf5UtK1xbkb+XZQ
         1//Do65hHirUXt7bOvHu2l7cLFmTnZVoP8HoJUkP34+4L15MDwMP8rrwxY6lJvfX/QTo
         lM1RlAK6QjZhCtVNryp8gbq9iGvp3IP4PZ/CZ5exmoWIoIvDLBpH93qKC2Wk7GbgKvw7
         jpAP8dktquR4zFkShKJWLoZmZA6HQBLQjkW6Psm/kPBHtpQePmOFGXakXDy+XQ8n+oAs
         QCrrFKgTrPgMIUCHvAqQoijw3sdCQpy+H9dLB/0UnadKyQnFxXFYAQidm7eerMZyWpIF
         tn1g==
X-Gm-Message-State: AC+VfDxlObw9K1TvHiU374kjwtov3Z/jwVhIm4fYXcO94PA4C75K+P8N
        7HIDztZoMKJIBtpcn8wdfMa4lg==
X-Google-Smtp-Source: ACHHUZ75N+n4c2DV5uEmFOy5Vi9V0f6zvoat3Q+ugXiUr7THvx6ZpwB/C/0AFoTjplRxgN/Qps+eAw==
X-Received: by 2002:a05:600c:2190:b0:3f9:be1:507d with SMTP id e16-20020a05600c219000b003f90be1507dmr2619357wme.20.1687169380970;
        Mon, 19 Jun 2023 03:09:40 -0700 (PDT)
Received: from [192.168.7.189] (679773502.box.freepro.com. [212.114.21.58])
        by smtp.gmail.com with ESMTPSA id u9-20020a05600c00c900b003f9b0cfbe30sm2626023wmm.36.2023.06.19.03.09.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Jun 2023 03:09:40 -0700 (PDT)
Message-ID: <5b9535d6-d59e-5b8b-2649-3efdb777a8a2@linaro.org>
Date:   Mon, 19 Jun 2023 12:09:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
From:   Neil Armstrong <neil.armstrong@linaro.org>
Reply-To: neil.armstrong@linaro.org
Subject: Re: [PATCH 2/2] interconnect: qcom: sm8550: add enable_mask for bcm
 nodes
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Georgi Djakov <djakov@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230619-topic-sm8550-upstream-interconnect-mask-vote-v1-0-66663c0aa592@linaro.org>
 <20230619-topic-sm8550-upstream-interconnect-mask-vote-v1-2-66663c0aa592@linaro.org>
 <f4801649-6968-7e62-01b1-7aa517a5d2f3@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <f4801649-6968-7e62-01b1-7aa517a5d2f3@linaro.org>
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

On 19/06/2023 11:55, Konrad Dybcio wrote:
> On 19.06.2023 10:24, Neil Armstrong wrote:
>> Set the proper enable_mask to needs requiring such value
>> to be used instead of a bandwidth when voting.
>>
>> The masks were copied from the downstream implementation at [1].
>>
>> [1] https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/blob/kernel.lnx.5.15.r1-rel/drivers/interconnect/qcom/kalama.c
>>
>> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
>> ---
> The values match downstream, so:
> 
> Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> 
> Since you're already touching this code, may I turn your interest to:
> 
> 1. Adding enable_mask-s to 8450 and 8775
> 
> 2. Porting https://git.codelinaro.org/clo/la/kernel/msm-5.15/-/commit/d5edeca085f4
> 
> 3. Adding the default perf settings for 8450 and 8550

Yep this would be the next steps.

Neil

> 
> Konrad
> 
>>   drivers/interconnect/qcom/sm8550.c | 17 +++++++++++++++++
>>   1 file changed, 17 insertions(+)
>>
>> diff --git a/drivers/interconnect/qcom/sm8550.c b/drivers/interconnect/qcom/sm8550.c
>> index d823ba988ef6..0864ed285375 100644
>> --- a/drivers/interconnect/qcom/sm8550.c
>> +++ b/drivers/interconnect/qcom/sm8550.c
>> @@ -1473,6 +1473,7 @@ static struct qcom_icc_node qns_mem_noc_sf_cam_ife_2 = {
>>   
>>   static struct qcom_icc_bcm bcm_acv = {
>>   	.name = "ACV",
>> +	.enable_mask = 0x8,
>>   	.num_nodes = 1,
>>   	.nodes = { &ebi },
>>   };
>> @@ -1485,6 +1486,7 @@ static struct qcom_icc_bcm bcm_ce0 = {
>>   
>>   static struct qcom_icc_bcm bcm_cn0 = {
>>   	.name = "CN0",
>> +	.enable_mask = 0x1,
>>   	.keepalive = true,
>>   	.num_nodes = 54,
>>   	.nodes = { &qsm_cfg, &qhs_ahb2phy0,
>> @@ -1524,6 +1526,7 @@ static struct qcom_icc_bcm bcm_cn1 = {
>>   
>>   static struct qcom_icc_bcm bcm_co0 = {
>>   	.name = "CO0",
>> +	.enable_mask = 0x1,
>>   	.num_nodes = 2,
>>   	.nodes = { &qxm_nsp, &qns_nsp_gemnoc },
>>   };
>> @@ -1549,6 +1552,7 @@ static struct qcom_icc_bcm bcm_mm0 = {
>>   
>>   static struct qcom_icc_bcm bcm_mm1 = {
>>   	.name = "MM1",
>> +	.enable_mask = 0x1,
>>   	.num_nodes = 8,
>>   	.nodes = { &qnm_camnoc_hf, &qnm_camnoc_icp,
>>   		   &qnm_camnoc_sf, &qnm_vapss_hcp,
>> @@ -1589,6 +1593,7 @@ static struct qcom_icc_bcm bcm_sh0 = {
>>   
>>   static struct qcom_icc_bcm bcm_sh1 = {
>>   	.name = "SH1",
>> +	.enable_mask = 0x1,
>>   	.num_nodes = 13,
>>   	.nodes = { &alm_gpu_tcu, &alm_sys_tcu,
>>   		   &chm_apps, &qnm_gpu,
>> @@ -1608,6 +1613,7 @@ static struct qcom_icc_bcm bcm_sn0 = {
>>   
>>   static struct qcom_icc_bcm bcm_sn1 = {
>>   	.name = "SN1",
>> +	.enable_mask = 0x1,
>>   	.num_nodes = 3,
>>   	.nodes = { &qhm_gic, &xm_gic,
>>   		   &qns_gemnoc_gc },
>> @@ -1633,6 +1639,7 @@ static struct qcom_icc_bcm bcm_sn7 = {
>>   
>>   static struct qcom_icc_bcm bcm_acv_disp = {
>>   	.name = "ACV",
>> +	.enable_mask = 0x1,
>>   	.num_nodes = 1,
>>   	.nodes = { &ebi_disp },
>>   };
>> @@ -1657,12 +1664,14 @@ static struct qcom_icc_bcm bcm_sh0_disp = {
>>   
>>   static struct qcom_icc_bcm bcm_sh1_disp = {
>>   	.name = "SH1",
>> +	.enable_mask = 0x1,
>>   	.num_nodes = 2,
>>   	.nodes = { &qnm_mnoc_hf_disp, &qnm_pcie_disp },
>>   };
>>   
>>   static struct qcom_icc_bcm bcm_acv_cam_ife_0 = {
>>   	.name = "ACV",
>> +	.enable_mask = 0x0,
>>   	.num_nodes = 1,
>>   	.nodes = { &ebi_cam_ife_0 },
>>   };
>> @@ -1681,6 +1690,7 @@ static struct qcom_icc_bcm bcm_mm0_cam_ife_0 = {
>>   
>>   static struct qcom_icc_bcm bcm_mm1_cam_ife_0 = {
>>   	.name = "MM1",
>> +	.enable_mask = 0x1,
>>   	.num_nodes = 4,
>>   	.nodes = { &qnm_camnoc_hf_cam_ife_0, &qnm_camnoc_icp_cam_ife_0,
>>   		   &qnm_camnoc_sf_cam_ife_0, &qns_mem_noc_sf_cam_ife_0 },
>> @@ -1694,6 +1704,7 @@ static struct qcom_icc_bcm bcm_sh0_cam_ife_0 = {
>>   
>>   static struct qcom_icc_bcm bcm_sh1_cam_ife_0 = {
>>   	.name = "SH1",
>> +	.enable_mask = 0x1,
>>   	.num_nodes = 3,
>>   	.nodes = { &qnm_mnoc_hf_cam_ife_0, &qnm_mnoc_sf_cam_ife_0,
>>   		   &qnm_pcie_cam_ife_0 },
>> @@ -1701,6 +1712,7 @@ static struct qcom_icc_bcm bcm_sh1_cam_ife_0 = {
>>   
>>   static struct qcom_icc_bcm bcm_acv_cam_ife_1 = {
>>   	.name = "ACV",
>> +	.enable_mask = 0x0,
>>   	.num_nodes = 1,
>>   	.nodes = { &ebi_cam_ife_1 },
>>   };
>> @@ -1719,6 +1731,7 @@ static struct qcom_icc_bcm bcm_mm0_cam_ife_1 = {
>>   
>>   static struct qcom_icc_bcm bcm_mm1_cam_ife_1 = {
>>   	.name = "MM1",
>> +	.enable_mask = 0x1,
>>   	.num_nodes = 4,
>>   	.nodes = { &qnm_camnoc_hf_cam_ife_1, &qnm_camnoc_icp_cam_ife_1,
>>   		   &qnm_camnoc_sf_cam_ife_1, &qns_mem_noc_sf_cam_ife_1 },
>> @@ -1732,6 +1745,7 @@ static struct qcom_icc_bcm bcm_sh0_cam_ife_1 = {
>>   
>>   static struct qcom_icc_bcm bcm_sh1_cam_ife_1 = {
>>   	.name = "SH1",
>> +	.enable_mask = 0x1,
>>   	.num_nodes = 3,
>>   	.nodes = { &qnm_mnoc_hf_cam_ife_1, &qnm_mnoc_sf_cam_ife_1,
>>   		   &qnm_pcie_cam_ife_1 },
>> @@ -1739,6 +1753,7 @@ static struct qcom_icc_bcm bcm_sh1_cam_ife_1 = {
>>   
>>   static struct qcom_icc_bcm bcm_acv_cam_ife_2 = {
>>   	.name = "ACV",
>> +	.enable_mask = 0x0,
>>   	.num_nodes = 1,
>>   	.nodes = { &ebi_cam_ife_2 },
>>   };
>> @@ -1757,6 +1772,7 @@ static struct qcom_icc_bcm bcm_mm0_cam_ife_2 = {
>>   
>>   static struct qcom_icc_bcm bcm_mm1_cam_ife_2 = {
>>   	.name = "MM1",
>> +	.enable_mask = 0x1,
>>   	.num_nodes = 4,
>>   	.nodes = { &qnm_camnoc_hf_cam_ife_2, &qnm_camnoc_icp_cam_ife_2,
>>   		   &qnm_camnoc_sf_cam_ife_2, &qns_mem_noc_sf_cam_ife_2 },
>> @@ -1770,6 +1786,7 @@ static struct qcom_icc_bcm bcm_sh0_cam_ife_2 = {
>>   
>>   static struct qcom_icc_bcm bcm_sh1_cam_ife_2 = {
>>   	.name = "SH1",
>> +	.enable_mask = 0x1,
>>   	.num_nodes = 3,
>>   	.nodes = { &qnm_mnoc_hf_cam_ife_2, &qnm_mnoc_sf_cam_ife_2,
>>   		   &qnm_pcie_cam_ife_2 },
>>

