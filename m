Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F90C712289
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 10:44:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242505AbjEZIoe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 04:44:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242606AbjEZIoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 04:44:25 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9691BF
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:44:21 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id 2adb3069b0e04-4f4d6aee530so450956e87.2
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 01:44:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685090660; x=1687682660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IVnDaE09fpwuijeo62SjM0LPoo+TZrYZ+he/bLhSsMI=;
        b=sUnFonjQy77BbmupE9PtTuA2GIbMWh1dFcdM/bmc8v1nNcizK7zwqVvypFgEta8lzf
         eMrXAso6d3muk/d5xWTPPvlEbv33Ea9oFJsM5GmrJE8S27VAo4YvhWp6aQ87sinfSJeY
         YdsLxry74R0fj9JFxWgpoyflTDMoZSVkfrRLt9clZez7XQYqgnPW9Om8s/PeZgPLdhJB
         j8kppvO8WJvVaCgUSESBultDeysZRhcnIrUCpovStUVd1P7Ui4wGCuBhbG54ziwTJj3b
         V+ROvcik9IK58stHuaZkbuo4giKIMeM2dn4mIllAB8qyQfT2hVoNr6F5aztkNYEXww/8
         hZEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685090660; x=1687682660;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IVnDaE09fpwuijeo62SjM0LPoo+TZrYZ+he/bLhSsMI=;
        b=TFpjsOYIv6wUBTr/SK52BbxwulGtvQaAQzUjyURx313Hdg/f0OAGRLLbjo5Ab8cZYt
         pbmAUgUBCNlj3yI+8mDHY64z+pIkKjmts7LWrnhHwLYcj67Q4Y2xi0RCcNbS9jW2Ceag
         60HinsB8962aEWceQjlCnw+/raLVqkF6/ssoLefPx5Z3tmKbgMSPMceQzCNPeiRj1mV8
         aElh7O2pWoZ8wH/LL8JRH96w0kYUUKHV+leO0kzEpqWerBrx5fnKdrcyIBkTbzLuBKIA
         1W01HjShhLheIciBtfo0C9Wu0WtNNqZg9svoumH0SznXg4htHrvAshC6zp1cbjh9l4To
         UxQQ==
X-Gm-Message-State: AC+VfDy21DwP0644BgMz/Pshk6uyP2unW72etvKnUJIbYmeLQa08c0pA
        fimfTV7YpsZF91O258yKAG7Hdw==
X-Google-Smtp-Source: ACHHUZ5NitM/a17W7+HylbMoqxSys4Jq3GzGcXgowZdZmdyMa1JgNFeNSIoahSjhURF8Qx0MwJp6eg==
X-Received: by 2002:ac2:5623:0:b0:4f1:40fe:a976 with SMTP id b3-20020ac25623000000b004f140fea976mr255443lff.30.1685090659696;
        Fri, 26 May 2023 01:44:19 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id q27-20020ac2529b000000b004f4b2c91c2esm520785lfm.231.2023.05.26.01.44.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 01:44:19 -0700 (PDT)
Message-ID: <d8d50268-96ae-d843-9dc5-37b30d87d238@linaro.org>
Date:   Fri, 26 May 2023 10:44:18 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 5/5] cpufreq: qcom-nvmem: use helper to get SMEM SoC ID
Content-Language: en-US
To:     Bjorn Andersson <andersson@kernel.org>
Cc:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        ilia.lin@kernel.org, rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-pm@vger.kernel.org, ansuelsmth@gmail.com
References: <20230525210214.78235-1-robimarko@gmail.com>
 <20230525210214.78235-5-robimarko@gmail.com>
 <5382b518-7691-ee70-c522-9ce0b14d60c1@linaro.org>
 <20230526024317.3t6nfv2aw27mrlj5@ripper>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230526024317.3t6nfv2aw27mrlj5@ripper>
Content-Type: text/plain; charset=UTF-8
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



On 26.05.2023 04:43, Bjorn Andersson wrote:
> On Fri, May 26, 2023 at 01:18:02AM +0200, Konrad Dybcio wrote:
>>
>>
>> On 25.05.2023 23:02, Robert Marko wrote:
>>> Now that SMEM exports a helper to get the SMEM SoC ID lets utilize it.
>>> Currently qcom_cpufreq_get_msm_id() is encoding the returned SMEM SoC ID
>>> into an enum, however there is no reason to do so and we can just match
>>> directly on the SMEM SoC ID as returned by qcom_smem_get_soc_id().
>>>
>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
>>> ---
>>> Changes in v4:
>>> * Adapt to name change to qcom_smem_get_soc_id()
>>>
>>> Changes in v3:
>>> * Adapt to helper using argument now
>>>
>>> Changes in v2:
>>> * Utilize helper exported by SMEM instead of refactoring
>>> qcom_cpufreq_get_msm_id()
>>> ---
>>>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 56 +++++-----------------------
>>>  1 file changed, 10 insertions(+), 46 deletions(-)
>>>
>>> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>> index 60e99be2d3db..a88b6fe5db50 100644
>>> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>> @@ -29,16 +29,8 @@
>>>  #include <linux/slab.h>
>>>  #include <linux/soc/qcom/smem.h>
>>>  
>>> -#define MSM_ID_SMEM	137
>>> -
>>>  #include <dt-bindings/arm/qcom,ids.h>
>>>  
>>> -enum _msm8996_version {
>>> -	MSM8996_V3,
>>> -	MSM8996_SG,
>>> -	NUM_OF_MSM8996_VERSIONS,
>>> -};
>>> -
>>>  struct qcom_cpufreq_drv;
>>>  
>>>  struct qcom_cpufreq_match_data {
>>> @@ -135,60 +127,32 @@ static void get_krait_bin_format_b(struct device *cpu_dev,
>>>  	dev_dbg(cpu_dev, "PVS version: %d\n", *pvs_ver);
>>>  }
>>>  
>>> -static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
>>> -{
>>> -	size_t len;
>>> -	u32 *msm_id;
>>> -	enum _msm8996_version version;
>>> -
>>> -	msm_id = qcom_smem_get(QCOM_SMEM_HOST_ANY, MSM_ID_SMEM, &len);
>>> -	if (IS_ERR(msm_id))
>>> -		return NUM_OF_MSM8996_VERSIONS;
>>> -
>>> -	/* The first 4 bytes are format, next to them is the actual msm-id */
>>> -	msm_id++;
>>> -
>>> -	switch ((enum _msm_id)*msm_id) {
>>> -	case QCOM_ID_MSM8996:
>>> -	case QCOM_ID_APQ8096:
>>> -		version = MSM8996_V3;
>>> -		break;
>>> -	case QCOM_ID_MSM8996SG:
>>> -	case QCOM_ID_APQ8096SG:
>>> -		version = MSM8996_SG;
>>> -		break;
>>> -	default:
>>> -		version = NUM_OF_MSM8996_VERSIONS;
>>> -	}
>>> -
>>> -	return version;
>>> -}
>>> -
>>>  static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>>>  					  struct nvmem_cell *speedbin_nvmem,
>>>  					  char **pvs_name,
>>>  					  struct qcom_cpufreq_drv *drv)
>>>  {
>>>  	size_t len;
>>> +	u32 msm_id;
>> __le32
>>
>>>  	u8 *speedbin;
>>> -	enum _msm8996_version msm8996_version;
>>> +	int ret;
>>>  	*pvs_name = NULL;
>>>  
>>> -	msm8996_version = qcom_cpufreq_get_msm_id();
>>> -	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
>>> -		dev_err(cpu_dev, "Not Snapdragon 820/821!");
>>> -		return -ENODEV;
>>> -	}
>>> +	ret = qcom_smem_get_soc_id(&msm_id);
>>> +	if (ret)
>>> +		return ret;
>> Now since it can return a PTR_ERR, you should check for IS_ERR
>> and return ERR_PTR if that happens
> 
> No, the PTR_ERR() extracted the error value out of the pointer, so it's
> just an integer now (or zero on success). So this is looking correct to
> me.
Riiight the function that returns a pointer to an error is *within*
the one we're calling.. So much so for me reviewing late at night..

Konrad
> 
>>
>> LGTM otherwise!
>>
>> Konrad
>>>  
>>>  	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
>>>  	if (IS_ERR(speedbin))
>>>  		return PTR_ERR(speedbin);
>>>  
>>> -	switch (msm8996_version) {
>>> -	case MSM8996_V3:
>>> +	switch (msm_id) {
>>> +	case QCOM_ID_MSM8996:
> 
> And here are those cpu-endian constants... If msm_id is a __le32 then
> all these constants needs to be cpu_to_le32().
> 
> Regards,
> Bjorn
> 
>>> +	case QCOM_ID_APQ8096:
>>>  		drv->versions = 1 << (unsigned int)(*speedbin);
>>>  		break;
>>> -	case MSM8996_SG:
>>> +	case QCOM_ID_MSM8996SG:
>>> +	case QCOM_ID_APQ8096SG:
>>>  		drv->versions = 1 << ((unsigned int)(*speedbin) + 4);
>>>  		break;
>>>  	default:
