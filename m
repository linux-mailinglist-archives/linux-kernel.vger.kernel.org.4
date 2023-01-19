Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E0E6735D2
	for <lists+linux-kernel@lfdr.de>; Thu, 19 Jan 2023 11:42:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229788AbjASKmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 Jan 2023 05:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230394AbjASKmF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Jan 2023 05:42:05 -0500
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 066B8530DA
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:41:57 -0800 (PST)
Received: by mail-ej1-x62b.google.com with SMTP id u19so4489813ejm.8
        for <linux-kernel@vger.kernel.org>; Thu, 19 Jan 2023 02:41:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uS3a51Hf3DeDt61DkEEova6jWQ+51q/C5Vt9AtIW4EY=;
        b=a610o/VsGt0ptWMrSEL2hb8IAPtrLG6IiIGvUpRybeQv9TGs2j85nG/DIQAbNi7WP3
         sSkKuQU/+WGfQEalbavTnvcl/h2hkZ9Cxo7/m4qx1al4e0n/XZbdwzMHTzaAzDfZQKuo
         lyfxsC/Mz74rur7iPU7SptxxP/muoAvfj+HfRm0wPxD3Mq1+eAnhPN68G4szYnAf8Z8M
         X0mk/um2i58ScTWClViIAcB77BMJwMEUp3OaM3ztgKznkaHabIpC6nMe5RXSKgfCTnQa
         yrleFtKy3+RJURyzn64eJDRao50rQnCssDMjPW8AKCIw83UhXeGpxm2muW2sFtmTDbN/
         f1LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uS3a51Hf3DeDt61DkEEova6jWQ+51q/C5Vt9AtIW4EY=;
        b=GkVJVkuQ2r2GV3PTWozT2/F9ir6vm2bIftjQXJ4kjXK2CxLQuGHCB1u11wA1TDVWRb
         cX3FO1JQoubf4nD+ukivBG3N0SloHJNeZ8tI7+n7DGN/jZAW/lZuM5WNel1v356ip3/d
         ujy0/mMolO6CAcXG+6EcG+lheKASbhAOOE59d5sQ9+T+RHUKJABWWI4hEp+wpGqdiHqj
         wBqoBPxXTTYl5MJgfNtEPG+5Mh+RnKZlh1B40jKe2bDhi0Hk7NIDvFQWfFmWznehVZsU
         7h2OeargtRIPNJ6tEy4XmcND1JNA35Er2BDOTpXzsuMyVE3gHVga0KAJ0TSlzeE7TWaS
         YGzA==
X-Gm-Message-State: AFqh2kp9kJjW9eukfOuqJ1XugCRPDxSZHQL26E+7k71wUFr9dwvDPZ5V
        sQm/NDLlNUKBuyMmeD4u6rtIag==
X-Google-Smtp-Source: AMrXdXulFNkg2BZdef9haxKrfnXc0E4+Br72L9bPdpuMtceDIFili6YQO7W/wr8o7/OWWyw6Yy4jHA==
X-Received: by 2002:a17:906:15d2:b0:84c:cf42:e16 with SMTP id l18-20020a17090615d200b0084ccf420e16mr12961395ejd.1.1674124916149;
        Thu, 19 Jan 2023 02:41:56 -0800 (PST)
Received: from [192.168.1.101] (abxh150.neoplus.adsl.tpnet.pl. [83.9.1.150])
        by smtp.gmail.com with ESMTPSA id hq15-20020a1709073f0f00b0084c7029b24dsm16222588ejc.151.2023.01.19.02.41.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 19 Jan 2023 02:41:55 -0800 (PST)
Message-ID: <83385cac-9b66-8236-6039-65332ea9edb3@linaro.org>
Date:   Thu, 19 Jan 2023 11:41:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 2/2] firmware: qcom_scm: Fully implement
 qcom_scm_lmh_dcvsh()
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, agross@kernel.org,
        krzysztof.kozlowski@linaro.org, marijn.suijten@somainline.org,
        Amit Kucheria <amitk@kernel.org>,
        Thara Gopinath <thara.gopinath@gmail.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Loic Poulain <loic.poulain@linaro.org>,
        Stephan Gerhold <stephan@gerhold.net>,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org
References: <20230113031401.2336157-1-konrad.dybcio@linaro.org>
 <20230113031401.2336157-3-konrad.dybcio@linaro.org>
 <20230119030422.askkliovlyonurvz@builder.lan>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230119030422.askkliovlyonurvz@builder.lan>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19.01.2023 04:04, Bjorn Andersson wrote:
> On Fri, Jan 13, 2023 at 04:14:01AM +0100, Konrad Dybcio wrote:
>> The qcom_scm_lmh_dcvsh call can actually pass two values to the
>> secure world. The second value is used for example with the
>> LMH_FREQ_CAP function, which limits the maximum achievable frequency
>> directly from LMh. Add the missing arguments, handle them and update
>> the current usages of this function.
>>
>> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
>> ---
>>  drivers/firmware/qcom_scm.c | 13 ++++++++-----
>>  drivers/thermal/qcom/lmh.c  | 28 ++++++++++++++--------------
>>  include/linux/qcom_scm.h    |  5 +++--
>>  3 files changed, 25 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
>> index cdbfe54c8146..58a19a47e442 100644
>> --- a/drivers/firmware/qcom_scm.c
>> +++ b/drivers/firmware/qcom_scm.c
>> @@ -1252,12 +1252,13 @@ int qcom_scm_lmh_profile_change(u32 profile_id)
>>  }
>>  EXPORT_SYMBOL(qcom_scm_lmh_profile_change);
>>  
>> -int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
>> -		       u64 limit_node, u32 node_id, u64 version)
>> +int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val0,
>> +		       u32 payload_val1, u64 limit_node, u32 node_id,
>> +		       u64 version, bool has_val1)
> 
> Rather than always passing a dummy payload_val1 and then having has_val1
> to indicate if it should be considered or not... how about moving the
> payload last in the call, as a va_list with a "count" before that?
Sounds neat, but..

> 
> I.e:
> 
> int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u64 limit_node, u32 node_id,
> 		       u64 version, unsigned int payload_count, ...)
> 
>>  {
>>  	dma_addr_t payload_phys;
>>  	u32 *payload_buf;
>> -	int ret, payload_size = 5 * sizeof(u32);
>> +	int ret, payload_size = (5 + has_val1) * sizeof(u32);
> 
> allocate 4 + payload_count
> 
>>  
>>  	struct qcom_scm_desc desc = {
>>  		.svc = QCOM_SCM_SVC_LMH,
>> @@ -1278,8 +1279,10 @@ int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
>>  	payload_buf[0] = payload_fn;
>>  	payload_buf[1] = 0;
>>  	payload_buf[2] = payload_reg;
>> -	payload_buf[3] = 1;
>> -	payload_buf[4] = payload_val;
>> +	payload_buf[3] = has_val1 ? 2 : 1;
>> +	payload_buf[4] = payload_val0;
>> +	if (has_val1)
>> +		payload_buf[5] = payload_val1;
> 
> Something like:
> 
> payload_buf[3] = payload_count;
> va_start(ap, payload_count);
> for (i = 0; i < payload_count; i++)
> 	payload_buf[4 + i] = va_arg(ap, uint32_t);
> va_end(ap);
..can the call accept more arguments? And will they be
interpreted in any way? Otherwise I may add also add
WARN_ON() or something like this to prevent user error.

> 
> 
> 
> That said, I don't see a single "true" below. Perhaps I'm missing it? I
> would expect some code in the same series use the newly introduced
> logic.
Yeah there's no "true"s, this patch only refactored the
code in preparation for 8998/660, but adding them as-is
makes little sense before LMh_lite is also supported
(AFAIUU this LMh_normal part is just an interface for OSM
and the actual limits programming is either done on an
internal-consensus-between-all-3-blocks basis OR just by
LMh_lite. I can delay resending this series until the
changes are actually required if you prefer.

On newer SoCs LMh wakes up as part of OSM_secure/EPSS
programming and needs little to no configuration
externally (as you can see in this driver) and there's
no external _lite block.

Konrad
> 
> Thanks,
> Bjorn
> 
>>  
>>  	desc.args[0] = payload_phys;
>>  
>> diff --git a/drivers/thermal/qcom/lmh.c b/drivers/thermal/qcom/lmh.c
>> index 5e8ff196c9a6..d2b5ea8322eb 100644
>> --- a/drivers/thermal/qcom/lmh.c
>> +++ b/drivers/thermal/qcom/lmh.c
>> @@ -147,23 +147,23 @@ static int lmh_probe(struct platform_device *pdev)
>>  		return -EINVAL;
>>  
>>  	if (flags & LMH_ENABLE_ALGOS) {
>> -		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1,
>> -					 LMH_NODE_DCVS, node_id, 0);
>> +		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_CRNT, LMH_ALGO_MODE_ENABLE, 1, 0,
>> +					 LMH_NODE_DCVS, node_id, 0, false);
>>  		if (ret)
>>  			dev_err(dev, "Error %d enabling current subfunction\n", ret);
>>  
>> -		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_REL, LMH_ALGO_MODE_ENABLE, 1,
>> -					 LMH_NODE_DCVS, node_id, 0);
>> +		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_REL, LMH_ALGO_MODE_ENABLE, 1, 0,
>> +					 LMH_NODE_DCVS, node_id, 0, false);
>>  		if (ret)
>>  			dev_err(dev, "Error %d enabling reliability subfunction\n", ret);
>>  
>> -		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_BCL, LMH_ALGO_MODE_ENABLE, 1,
>> -					 LMH_NODE_DCVS, node_id, 0);
>> +		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_BCL, LMH_ALGO_MODE_ENABLE, 1, 0,
>> +					 LMH_NODE_DCVS, node_id, 0, false);
>>  		if (ret)
>>  			dev_err(dev, "Error %d enabling BCL subfunction\n", ret);
>>  
>> -		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_ALGO_MODE_ENABLE, 1,
>> -					 LMH_NODE_DCVS, node_id, 0);
>> +		ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_ALGO_MODE_ENABLE, 1, 0,
>> +					 LMH_NODE_DCVS, node_id, 0, false);
>>  		if (ret) {
>>  			dev_err(dev, "Error %d enabling thermal subfunction\n", ret);
>>  			return ret;
>> @@ -177,22 +177,22 @@ static int lmh_probe(struct platform_device *pdev)
>>  	}
>>  
>>  	/* Set default thermal trips */
>> -	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_ARM_THRESHOLD, temp_arm,
>> -				 LMH_NODE_DCVS, node_id, 0);
>> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_ARM_THRESHOLD, temp_arm, 0,
>> +				 LMH_NODE_DCVS, node_id, 0, false);
>>  	if (ret) {
>>  		dev_err(dev, "Error setting thermal ARM threshold%d\n", ret);
>>  		return ret;
>>  	}
>>  
>> -	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_HI_THRESHOLD, temp_high,
>> -				 LMH_NODE_DCVS, node_id, 0);
>> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_HI_THRESHOLD, temp_high, 0,
>> +				 LMH_NODE_DCVS, node_id, 0, false);
>>  	if (ret) {
>>  		dev_err(dev, "Error setting thermal HI threshold%d\n", ret);
>>  		return ret;
>>  	}
>>  
>> -	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_LOW_THRESHOLD, temp_low,
>> -				 LMH_NODE_DCVS, node_id, 0);
>> +	ret = qcom_scm_lmh_dcvsh(LMH_SUB_FN_THERMAL, LMH_TH_LOW_THRESHOLD, temp_low, 0,
>> +				 LMH_NODE_DCVS, node_id, 0, false);
>>  	if (ret) {
>>  		dev_err(dev, "Error setting thermal ARM threshold%d\n", ret);
>>  		return ret;
>> diff --git a/include/linux/qcom_scm.h b/include/linux/qcom_scm.h
>> index 1e449a5d7f5c..9fd798d17fdd 100644
>> --- a/include/linux/qcom_scm.h
>> +++ b/include/linux/qcom_scm.h
>> @@ -117,8 +117,9 @@ extern int qcom_scm_hdcp_req(struct qcom_scm_hdcp_req *req, u32 req_cnt,
>>  extern int qcom_scm_iommu_set_pt_format(u32 sec_id, u32 ctx_num, u32 pt_fmt);
>>  extern int qcom_scm_qsmmu500_wait_safe_toggle(bool en);
>>  
>> -extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val,
>> -			      u64 limit_node, u32 node_id, u64 version);
>> +extern int qcom_scm_lmh_dcvsh(u32 payload_fn, u32 payload_reg, u32 payload_val0,
>> +			      u32 payload_val1, u64 limit_node, u32 node_id,
>> +			      u64 version, bool has_val1);
>>  extern int qcom_scm_lmh_profile_change(u32 profile_id);
>>  extern bool qcom_scm_lmh_dcvsh_available(void);
>>  
>> -- 
>> 2.39.0
>>
