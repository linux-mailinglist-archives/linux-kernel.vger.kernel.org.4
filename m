Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 395B071A1FC
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 17:09:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233558AbjFAPJR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 11:09:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234403AbjFAPJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 11:09:10 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C06C11AB
        for <linux-kernel@vger.kernel.org>; Thu,  1 Jun 2023 08:08:44 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id 2adb3069b0e04-4f3b9755961so1228181e87.0
        for <linux-kernel@vger.kernel.org>; Thu, 01 Jun 2023 08:08:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685632038; x=1688224038;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Nhrt/1kbZo1WGd9bqUxFgUA77aZYWI2EtqRfb5cofNk=;
        b=p+j+QHsYedatEunjmIsqmYJ+EZNRzUY4GsYzlTe+eRDXQuT7Vh5cELtoFVRr30kj4/
         SXwgGC6QnmxzDTuUJiAMMkUF6fI7v44fJXPLqiPKlEmPMbDKNQpu3uFTAFdXd+38n3Zs
         cVhFXnGB1aclcPqYcoflRwNruUwORUMNOBNLtZv7JnJU4fd+TtY9KmlHinPQbGAh06Bg
         rM3m/jGLNFHC5a8ApOjz70IjhwWD37nNLKOz2IJoVSvnnDFn8m3sj614i6ZKDn7ly8UW
         /MZ5eHqkKRLqmbSxpnxds/k7M2QjEkjfAgaqDrxLR1tiICdikXQfG2vVoNKqYTq/M2/6
         yKng==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685632038; x=1688224038;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Nhrt/1kbZo1WGd9bqUxFgUA77aZYWI2EtqRfb5cofNk=;
        b=Jq/Q4hhcjK5F5v6KTF/g9ON87laWWYXJykbPxmKLGSznDGMUeytGe5A87cJY3vG7XR
         2rGjgsYZFpcOGjiTrGCWSl/lks5Jw9Rn+nhLkffuCIdeNqzaeQQb1+8TNRQu67pgAMP/
         yE4AaSld65uUoyS5RPnh5HJvuDjAq25scQnnRYWjZHtP6+1SqNA8vFWoi9UnjdFCU+Ng
         7fJwW8BoZLhdcF/hFq6If2kxQfcZmujKhvdriW17yb2IOCm/nS4FmpDACNjmL7Vm38+W
         OOhR5xa17svsUvUIWrL8Br9vJ2BEkLd+GKaVRJ/lzaZM3ZazjZzafdByF7n6yFQzQLyD
         iO1g==
X-Gm-Message-State: AC+VfDw4x8dmfKOVTwNs5prb/pagbAJej42xd+BPx7cXqjXbfFJ+miQ2
        vGyNSfXtivMKjSB/qIGWMQFfDw==
X-Google-Smtp-Source: ACHHUZ7uf4fti3eUJKD/fDjTjB1esmiPNPYdbZUliBqEDu/Toj34vBdtzDVLCniLeKc4i8kl+dnNyA==
X-Received: by 2002:ac2:5605:0:b0:4f2:4419:932c with SMTP id v5-20020ac25605000000b004f24419932cmr151494lfd.23.1685632038174;
        Thu, 01 Jun 2023 08:07:18 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id m1-20020ac24ac1000000b004f13634da05sm1116245lfp.180.2023.06.01.08.07.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 08:07:17 -0700 (PDT)
Message-ID: <517f8b82-1230-985a-811a-2100f0dd339e@linaro.org>
Date:   Thu, 1 Jun 2023 18:07:17 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND PATCH v2 2/2] cpufreq: qcom-nvmem: add support for
 IPQ8064
Content-Language: en-GB
To:     Christian Marangi <ansuelsmth@gmail.com>
Cc:     Robert Marko <robimarko@gmail.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, ilia.lin@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
References: <20230530165807.642084-1-robimarko@gmail.com>
 <20230530165807.642084-2-robimarko@gmail.com>
 <3f1bfaf9-35ff-59ae-6756-84fc8900ed92@linaro.org>
 <647708e2.050a0220.514c7.feab@mx.google.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <647708e2.050a0220.514c7.feab@mx.google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2023 04:36, Christian Marangi wrote:
> On Wed, May 31, 2023 at 05:03:01AM +0300, Dmitry Baryshkov wrote:
>> On 30/05/2023 19:58, Robert Marko wrote:
>>> From: Christian Marangi <ansuelsmth@gmail.com>
>>>
>>> IPQ8064 comes in 3 families:
>>> * IPQ8062 up to 1.0GHz
>>> * IPQ8064/IPQ8066/IPQ8068 up to 1.4GHz
>>> * IPQ8065/IPQ8069 up to 1.7Ghz
>>>
>>> So, in order to be able to share one OPP table, add support for
>>> IPQ8064 family based of SMEM SoC ID-s as speedbin fuse is always 0 on
>>> IPQ8064.
>>>
>>> Bit are set with the following logic:
>>> * IPQ8062 BIT 0
>>> * IPQ8064/IPQ8066/IPQ8068 BIT 1
>>> * IPQ8065/IPQ8069 BIT 2
>>>
>>> speed is never fused, only psv values are fused.
>>> Set speed to the versions to permit a unified opp table following
>>> this named opp:
>>>
>>> opp-microvolt-speed<SPEED_VALUE>-pvs<PSV_VALUE>-v0
>>>
>>> Example:
>>> - for ipq8062 psv2
>>>     opp-microvolt-speed0-pvs2-v0 = < 925000 878750 971250>
>>> - for ipq8064 psv2
>>>     opp-microvolt-speed2-pvs2-v0 = <925000 878750 971250>;
>>> - for ipq8065 psv2
>>>     opp-microvolt-speed4-pvs2-v0 = <950000 902500 997500>;
>>>
>>> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
>>> ---
>>>    drivers/cpufreq/qcom-cpufreq-nvmem.c | 73 +++++++++++++++++++++++++++-
>>>    1 file changed, 72 insertions(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>> index ce444b5962f2..c644138680ba 100644
>>> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
>>> @@ -34,6 +34,10 @@
>>>    #define IPQ8074_HAWKEYE_VERSION		BIT(0)
>>>    #define IPQ8074_ACORN_VERSION		BIT(1)
>>> +#define IPQ8062_VERSION		BIT(0)
>>> +#define IPQ8064_VERSION		BIT(1)
>>> +#define IPQ8065_VERSION		BIT(2)
>>
>> I think it would be more logical to change these defines to consecutive enum
>> instead of BIT(n) values. Another (and better in my opinion) option is to
>> drop versions completely (and remove speedN from the opp names) and to have
>> per-SoC tables in per-SoC dtsi files. There are already separate
>> ipq8064.dtsi, ipq8062.dtsi and ipq8065.dtsi files. It makes little sense to
>> overcomplicate the OPP tables.
>>
> 
> That is what was used downstream but it was also wrong and against the
> normal implementation of this driver itself.
> 
> OPP have opp-supported-hw just for the task with the principle of
> declaring a single table in dtsi and automatically select the right one.
> 
> Using the implementation downstream (opp table in each dtsi) is actually
> worse as ipq8065 have 1.4ghz and not 1.2ghz and that can correctly be
> handled with opp-supported-hw (and this change) or using delete-property
> in dtsi (that I don't really like and it's ugly)
> 
> Also this implementation would match what is currently secribed for the
> use of OPP in the documentation.
> 
> Hope you can understand the reason of this change, the intention is to
> clear and trying to use standard OPP stuff instead of hacks in the DTS.

I'm fine with the opp-supported-hw part (I forgot that it is used by 
default with the help of drv->versions). I do not like the idea of 
encoding the same value into the -speedN part. If it is not needed, it's 
better be dropped than using a semi-dummy value there.

So, I'd suggest to define an enum, use BIT(enum_value) for drv->versions 
and drop the speed%d part.

Also, while we are at it, could you please define a schema for your opp 
extensions? An example would make it easier to understand the bindings 
(and will also provide a reference for possible other implementers).

> 
>>> +
>>>    struct qcom_cpufreq_drv;
>>>    struct qcom_cpufreq_match_data {
>>> @@ -207,6 +211,69 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
>>>    	return ret;
>>>    }
>>> +static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
>>> +					     struct nvmem_cell *speedbin_nvmem,
>>> +					     char **pvs_name,
>>> +					     struct qcom_cpufreq_drv *drv)
>>> +{
>>> +	int speed = 0, pvs = 0, pvs_ver = 0;
>>> +	int msm_id, ret = 0;
>>> +	u8 *speedbin;
>>> +	size_t len;
>>> +
>>> +	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
>>> +
>>> +	if (IS_ERR(speedbin))
>>> +		return PTR_ERR(speedbin);
>>> +
>>> +	switch (len) {
>>> +	case 4:
>>> +		get_krait_bin_format_a(cpu_dev, &speed, &pvs, &pvs_ver,
>>> +				       speedbin);
>>> +		break;
>>> +	default:
>>> +		dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
>>> +		ret = -ENODEV;
>>> +		goto len_error;
>>> +	}
>>> +
>>> +	ret = qcom_smem_get_soc_id(&msm_id);
>>> +	if (ret)
>>> +		return ret;
>>> +
>>> +	switch (msm_id) {
>>> +	case QCOM_ID_IPQ8062:
>>> +		drv->versions = IPQ8062_VERSION;
>>> +		break;
>>> +	case QCOM_ID_IPQ8064:
>>> +	case QCOM_ID_IPQ8066:
>>> +	case QCOM_ID_IPQ8068:
>>> +		drv->versions = IPQ8064_VERSION;
>>> +		break;
>>> +	case QCOM_ID_IPQ8065:
>>> +	case QCOM_ID_IPQ8069:
>>> +		drv->versions = IPQ8065_VERSION;
>>> +		break;
>>> +	default:
>>> +		dev_err(cpu_dev,
>>> +			"SoC ID %u is not part of IPQ8064 family, limiting to 1.0GHz!\n",
>>> +			msm_id);
>>> +		drv->versions = IPQ8062_VERSION;
>>> +		break;
>>> +	}
>>> +
>>> +	/*
>>> +	 * IPQ8064 speed is never fused. Only psv values are fused.
>>> +	 * Set speed to the versions to permit a unified opp table.
>>> +	 */
>>> +	snprintf(*pvs_name, sizeof("speedXX-pvsXX-vXX"), "speed%d-pvs%d-v%d",
>>> +		 drv->versions, pvs, pvs_ver);
>>> +
>>> +len_error:
>>> +	kfree(speedbin);
>>> +	return ret;
>>> +}
>>> +
>>>    static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
>>>    					     struct nvmem_cell *speedbin_nvmem,
>>>    					     char **pvs_name,
>>> @@ -256,6 +323,10 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
>>>    	.genpd_names = qcs404_genpd_names,
>>>    };
>>> +static const struct qcom_cpufreq_match_data match_data_ipq8064 = {
>>> +	.get_version = qcom_cpufreq_ipq8064_name_version,
>>> +};
>>> +
>>>    static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
>>>    	.get_version = qcom_cpufreq_ipq8074_name_version,
>>>    };
>>> @@ -404,7 +475,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
>>>    	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
>>>    	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
>>>    	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
>>> -	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
>>> +	{ .compatible = "qcom,ipq8064", .data = &match_data_ipq8064 },
>>>    	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
>>>    	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
>>>    	{ .compatible = "qcom,msm8974", .data = &match_data_krait },
>>
>> -- 
>> With best wishes
>> Dmitry
>>
> 

-- 
With best wishes
Dmitry

