Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E4FF717377
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 04:03:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233956AbjEaCDJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 22:03:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233942AbjEaCDG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 22:03:06 -0400
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26816121
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 19:03:04 -0700 (PDT)
Received: by mail-lf1-x12d.google.com with SMTP id 2adb3069b0e04-4f3ba703b67so5817041e87.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 19:03:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685498582; x=1688090582;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dNFWAlhd+NPgLVbtBH/HPjTzNQ2DvCN6HU78Q//Xfuc=;
        b=iMjZCyK8pxB8aRpKTGIQnEl4IVrJGwKEKh0Y6hfVFfeONYqiuDbdIGs+hX4U8ajNBN
         Gu96a2+iPT1dYhDIS8rKKhYVeisiRSYs2Te4kAvuv5xrTdLnxH5QhoNXHLb/HBalfdvh
         GUCil86sOzdqnNbFccuFVYdTjnd8el+Tt1JMSuZlWcCcWlHFfLJouYhWr6gNmWFOFmKt
         j48OWWQLnUPWxQR096x1dsPLy41PeLhxNumEMr3JudWVR5tZ/uwSoLc5/XBEmjc6a5R7
         jAXvFbIYplNPKxIphD5bRW1iA/UXcwTTehUjSyqtZSBHg+WbtW5r1xT46OL1ujXCTBRA
         BzNw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685498582; x=1688090582;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dNFWAlhd+NPgLVbtBH/HPjTzNQ2DvCN6HU78Q//Xfuc=;
        b=a5SHKiyB1x5prNY9lQrytVtXlQezZWRf2LTCsHRgN898Unu4LCFQuHlB8Am0Lkh/Ze
         rLdxcQQjNAImpakyJ1/0QVCM0wZHk9OAhC/yKZkhflUZKrH4DrV1K69M5srqJyBaMaDO
         pNHTT5F3aJQQNqaOlNO/iVIHgzgBnGOlF9QEKpP2Smy43VNIz4UaEHFuIrc/ziZ/ZDqh
         zII1s+KJVVTUblAr2UcEkjvVFtki3pZcGsbJVjvlvnPExVSSltoPm40ndWIL2JGxTDJx
         pmFlSHKIRC4vhr4v+YsDtnu1ttr25KIPwcTcW1oK3zBMqjlYXeZRccE/pdBTQwahOFox
         o9JA==
X-Gm-Message-State: AC+VfDw+V6j7w7tQbqia4RyZ1orAjean5TidfX2r1VwuYp/90wf2Yz81
        MKfaf307J9ptAiG/8jLhQeVY8Q==
X-Google-Smtp-Source: ACHHUZ6i32RyZDSQre4wrWco3VcfvxCHFg/pYLcuBYdHrwmmrXpe7Q6j7CxupAWYrV4dT3T94cP2GQ==
X-Received: by 2002:a05:6512:49c:b0:4f4:b38c:1f8a with SMTP id v28-20020a056512049c00b004f4b38c1f8amr1538794lfq.53.1685498582414;
        Tue, 30 May 2023 19:03:02 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id s6-20020a19ad46000000b004efff420b11sm512516lfd.181.2023.05.30.19.03.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 30 May 2023 19:03:01 -0700 (PDT)
Message-ID: <3f1bfaf9-35ff-59ae-6756-84fc8900ed92@linaro.org>
Date:   Wed, 31 May 2023 05:03:01 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND PATCH v2 2/2] cpufreq: qcom-nvmem: add support for
 IPQ8064
Content-Language: en-GB
To:     Robert Marko <robimarko@gmail.com>, rafael@kernel.org,
        viresh.kumar@linaro.org, agross@kernel.org, andersson@kernel.org,
        konrad.dybcio@linaro.org, ilia.lin@kernel.org,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
Cc:     ansuelsmth@gmail.com
References: <20230530165807.642084-1-robimarko@gmail.com>
 <20230530165807.642084-2-robimarko@gmail.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230530165807.642084-2-robimarko@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/05/2023 19:58, Robert Marko wrote:
> From: Christian Marangi <ansuelsmth@gmail.com>
> 
> IPQ8064 comes in 3 families:
> * IPQ8062 up to 1.0GHz
> * IPQ8064/IPQ8066/IPQ8068 up to 1.4GHz
> * IPQ8065/IPQ8069 up to 1.7Ghz
> 
> So, in order to be able to share one OPP table, add support for
> IPQ8064 family based of SMEM SoC ID-s as speedbin fuse is always 0 on
> IPQ8064.
> 
> Bit are set with the following logic:
> * IPQ8062 BIT 0
> * IPQ8064/IPQ8066/IPQ8068 BIT 1
> * IPQ8065/IPQ8069 BIT 2
> 
> speed is never fused, only psv values are fused.
> Set speed to the versions to permit a unified opp table following
> this named opp:
> 
> opp-microvolt-speed<SPEED_VALUE>-pvs<PSV_VALUE>-v0
> 
> Example:
> - for ipq8062 psv2
>    opp-microvolt-speed0-pvs2-v0 = < 925000 878750 971250>
> - for ipq8064 psv2
>    opp-microvolt-speed2-pvs2-v0 = <925000 878750 971250>;
> - for ipq8065 psv2
>    opp-microvolt-speed4-pvs2-v0 = <950000 902500 997500>;
> 
> Signed-off-by: Christian Marangi <ansuelsmth@gmail.com>
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> ---
>   drivers/cpufreq/qcom-cpufreq-nvmem.c | 73 +++++++++++++++++++++++++++-
>   1 file changed, 72 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index ce444b5962f2..c644138680ba 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -34,6 +34,10 @@
>   #define IPQ8074_HAWKEYE_VERSION		BIT(0)
>   #define IPQ8074_ACORN_VERSION		BIT(1)
>   
> +#define IPQ8062_VERSION		BIT(0)
> +#define IPQ8064_VERSION		BIT(1)
> +#define IPQ8065_VERSION		BIT(2)

I think it would be more logical to change these defines to consecutive 
enum instead of BIT(n) values. Another (and better in my opinion) option 
is to drop versions completely (and remove speedN from the opp names) 
and to have per-SoC tables in per-SoC dtsi files. There are already 
separate ipq8064.dtsi, ipq8062.dtsi and ipq8065.dtsi files. It makes 
little sense to overcomplicate the OPP tables.

> +
>   struct qcom_cpufreq_drv;
>   
>   struct qcom_cpufreq_match_data {
> @@ -207,6 +211,69 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
>   	return ret;
>   }
>   
> +static int qcom_cpufreq_ipq8064_name_version(struct device *cpu_dev,
> +					     struct nvmem_cell *speedbin_nvmem,
> +					     char **pvs_name,
> +					     struct qcom_cpufreq_drv *drv)
> +{
> +	int speed = 0, pvs = 0, pvs_ver = 0;
> +	int msm_id, ret = 0;
> +	u8 *speedbin;
> +	size_t len;
> +
> +	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
> +
> +	if (IS_ERR(speedbin))
> +		return PTR_ERR(speedbin);
> +
> +	switch (len) {
> +	case 4:
> +		get_krait_bin_format_a(cpu_dev, &speed, &pvs, &pvs_ver,
> +				       speedbin);
> +		break;
> +	default:
> +		dev_err(cpu_dev, "Unable to read nvmem data. Defaulting to 0!\n");
> +		ret = -ENODEV;
> +		goto len_error;
> +	}
> +
> +	ret = qcom_smem_get_soc_id(&msm_id);
> +	if (ret)
> +		return ret;
> +
> +	switch (msm_id) {
> +	case QCOM_ID_IPQ8062:
> +		drv->versions = IPQ8062_VERSION;
> +		break;
> +	case QCOM_ID_IPQ8064:
> +	case QCOM_ID_IPQ8066:
> +	case QCOM_ID_IPQ8068:
> +		drv->versions = IPQ8064_VERSION;
> +		break;
> +	case QCOM_ID_IPQ8065:
> +	case QCOM_ID_IPQ8069:
> +		drv->versions = IPQ8065_VERSION;
> +		break;
> +	default:
> +		dev_err(cpu_dev,
> +			"SoC ID %u is not part of IPQ8064 family, limiting to 1.0GHz!\n",
> +			msm_id);
> +		drv->versions = IPQ8062_VERSION;
> +		break;
> +	}
> +
> +	/*
> +	 * IPQ8064 speed is never fused. Only psv values are fused.
> +	 * Set speed to the versions to permit a unified opp table.
> +	 */
> +	snprintf(*pvs_name, sizeof("speedXX-pvsXX-vXX"), "speed%d-pvs%d-v%d",
> +		 drv->versions, pvs, pvs_ver);
> +
> +len_error:
> +	kfree(speedbin);
> +	return ret;
> +}
> +
>   static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
>   					     struct nvmem_cell *speedbin_nvmem,
>   					     char **pvs_name,
> @@ -256,6 +323,10 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
>   	.genpd_names = qcs404_genpd_names,
>   };
>   
> +static const struct qcom_cpufreq_match_data match_data_ipq8064 = {
> +	.get_version = qcom_cpufreq_ipq8064_name_version,
> +};
> +
>   static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
>   	.get_version = qcom_cpufreq_ipq8074_name_version,
>   };
> @@ -404,7 +475,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
>   	{ .compatible = "qcom,apq8096", .data = &match_data_kryo },
>   	{ .compatible = "qcom,msm8996", .data = &match_data_kryo },
>   	{ .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
> -	{ .compatible = "qcom,ipq8064", .data = &match_data_krait },
> +	{ .compatible = "qcom,ipq8064", .data = &match_data_ipq8064 },
>   	{ .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
>   	{ .compatible = "qcom,apq8064", .data = &match_data_krait },
>   	{ .compatible = "qcom,msm8974", .data = &match_data_krait },

-- 
With best wishes
Dmitry

