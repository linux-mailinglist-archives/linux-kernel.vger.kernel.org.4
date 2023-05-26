Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 700F5712EAD
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 23:06:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242813AbjEZVGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 17:06:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230058AbjEZVGQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 17:06:16 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D536FBD
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:06:14 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id 2adb3069b0e04-4f3a873476bso1277754e87.1
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 14:06:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685135173; x=1687727173;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=HCC2tysqUqqkaNpnqdNWnUBouxAoiiM0e8gfRKPQ5dg=;
        b=GGJ9BfMkvOG0mXaVIBEMdVdTuzayT86InEdbaj8/tl/frdzfg7m+DgT5B7mt9rJbCQ
         /GokqKGTpWO20celynhnQeyQKVa+AsnJR+4qAHpGRgnpyajFD740ib+hhbInDq2K8w2J
         VC5LeTqwhbR8GtA38Vii7gBHV5Dvn4LhJb42e70mAdYQ6zkXXsWqU31ylNa2QhqL3zHr
         MXDxW6Trk4rH+HEn5Oh2mOn383z0WaYjSsNojkKwo33YZaKxS6WzS/KhVPR6J8QCRu6H
         UsXwr4KpGjBiPtDtK8gsOtqlwwpDBAmMSePqC0DlZRgLs/7BISJjiyWGBmVdnXglMDTW
         AA6w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685135173; x=1687727173;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=HCC2tysqUqqkaNpnqdNWnUBouxAoiiM0e8gfRKPQ5dg=;
        b=HQ16+8sFdgMK/RnjpctsPAZnVFKCQ5uowgCEoikYb5aQx3SmWNhAtQdrcm07k4Md2h
         AEMcWCwCrAMEZEIKeHMUuCSuIea86P0ODPBjBiBFKsoDwV3ErmunkiCzEANbRDtWfKPU
         yQ24+Z8duNP47xuKMUjkUGB7tEate/fsHonUAU2cdnAD5HTNADywNwYv6gjmY+1OuFFw
         jlCNDRSSBzJ+6+ZSXC/tfcqK035L4QritEhnOLnt7suBMGfHYyC7k/1zGdz03SDC6DEA
         Q+zRWqSLjsCGBmYqqh9y8X//237pSzkQ7wsSxs8k9HRS5qlGf1A4xMIzevj2WOFTxtBo
         widg==
X-Gm-Message-State: AC+VfDw7DpJVr0wD/aeepbBp6JWnsS0VbHW7HiqgvlkbP4D7wHL4LSrJ
        lsXS2ckQH6wg1nxL72fOgeAXTg==
X-Google-Smtp-Source: ACHHUZ7B4FIban15l1ISJAPvtW7ZjsrwGVWbiw5WbYtvCRaYlaZVzhno4m4NHbLnSWar9vL/kiiz9A==
X-Received: by 2002:a05:6512:21e:b0:4e8:5e39:6234 with SMTP id a30-20020a056512021e00b004e85e396234mr746343lfo.16.1685135173104;
        Fri, 26 May 2023 14:06:13 -0700 (PDT)
Received: from [192.168.1.101] (abyj77.neoplus.adsl.tpnet.pl. [83.9.29.77])
        by smtp.gmail.com with ESMTPSA id n7-20020a195507000000b004efedad4604sm794156lfe.18.2023.05.26.14.06.12
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 26 May 2023 14:06:12 -0700 (PDT)
Message-ID: <04a57d7a-8e9f-c4df-b6a7-6161c9e83b38@linaro.org>
Date:   Fri, 26 May 2023 23:06:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v5 5/5] cpufreq: qcom-nvmem: use helper to get SMEM SoC ID
Content-Language: en-US
To:     Robert Marko <robimarko@gmail.com>, agross@kernel.org,
        andersson@kernel.org, ilia.lin@kernel.org, rafael@kernel.org,
        viresh.kumar@linaro.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-pm@vger.kernel.org
Cc:     ansuelsmth@gmail.com
References: <20230526204802.3081168-1-robimarko@gmail.com>
 <20230526204802.3081168-5-robimarko@gmail.com>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230526204802.3081168-5-robimarko@gmail.com>
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



On 26.05.2023 22:48, Robert Marko wrote:
> Now that SMEM exports a helper to get the SMEM SoC ID lets utilize it.
> Currently qcom_cpufreq_get_msm_id() is encoding the returned SMEM SoC ID
> into an enum, however there is no reason to do so and we can just match
> directly on the SMEM SoC ID as returned by qcom_smem_get_soc_id().
> 
> Signed-off-by: Robert Marko <robimarko@gmail.com>
> Acked-by: Viresh Kumar <viresh.kumar@linaro.org>
> ---
> Changes in v4:
> * Adapt to name change to qcom_smem_get_soc_id()
> 
> Changes in v3:
> * Adapt to helper using argument now
> 
> Changes in v2:
> * Utilize helper exported by SMEM instead of refactoring
> qcom_cpufreq_get_msm_id()
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 56 +++++-----------------------
>  1 file changed, 10 insertions(+), 46 deletions(-)
> 
> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> index 60e99be2d3db..a88b6fe5db50 100644
> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> @@ -29,16 +29,8 @@
>  #include <linux/slab.h>
>  #include <linux/soc/qcom/smem.h>
>  
> -#define MSM_ID_SMEM	137
> -
>  #include <dt-bindings/arm/qcom,ids.h>
>  
> -enum _msm8996_version {
> -	MSM8996_V3,
> -	MSM8996_SG,
> -	NUM_OF_MSM8996_VERSIONS,
> -};
> -
>  struct qcom_cpufreq_drv;
>  
>  struct qcom_cpufreq_match_data {
> @@ -135,60 +127,32 @@ static void get_krait_bin_format_b(struct device *cpu_dev,
>  	dev_dbg(cpu_dev, "PVS version: %d\n", *pvs_ver);
>  }
>  
> -static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
> -{
> -	size_t len;
> -	u32 *msm_id;
> -	enum _msm8996_version version;
> -
> -	msm_id = qcom_smem_get(QCOM_SMEM_HOST_ANY, MSM_ID_SMEM, &len);
> -	if (IS_ERR(msm_id))
> -		return NUM_OF_MSM8996_VERSIONS;
> -
> -	/* The first 4 bytes are format, next to them is the actual msm-id */
> -	msm_id++;
> -
> -	switch ((enum _msm_id)*msm_id) {
> -	case QCOM_ID_MSM8996:
> -	case QCOM_ID_APQ8096:
> -		version = MSM8996_V3;
> -		break;
> -	case QCOM_ID_MSM8996SG:
> -	case QCOM_ID_APQ8096SG:
> -		version = MSM8996_SG;
> -		break;
> -	default:
> -		version = NUM_OF_MSM8996_VERSIONS;
> -	}
> -
> -	return version;
> -}
> -
>  static int qcom_cpufreq_kryo_name_version(struct device *cpu_dev,
>  					  struct nvmem_cell *speedbin_nvmem,
>  					  char **pvs_name,
>  					  struct qcom_cpufreq_drv *drv)
>  {
>  	size_t len;
> +	u32 msm_id;
>  	u8 *speedbin;
> -	enum _msm8996_version msm8996_version;
> +	int ret;
>  	*pvs_name = NULL;
>  
> -	msm8996_version = qcom_cpufreq_get_msm_id();
> -	if (NUM_OF_MSM8996_VERSIONS == msm8996_version) {
> -		dev_err(cpu_dev, "Not Snapdragon 820/821!");
> -		return -ENODEV;
> -	}
> +	ret = qcom_smem_get_soc_id(&msm_id);
> +	if (ret)
> +		return ret;
>  
>  	speedbin = nvmem_cell_read(speedbin_nvmem, &len);
>  	if (IS_ERR(speedbin))
>  		return PTR_ERR(speedbin);
>  
> -	switch (msm8996_version) {
> -	case MSM8996_V3:
> +	switch (msm_id) {
> +	case QCOM_ID_MSM8996:
> +	case QCOM_ID_APQ8096:
>  		drv->versions = 1 << (unsigned int)(*speedbin);
>  		break;
> -	case MSM8996_SG:
> +	case QCOM_ID_MSM8996SG:
> +	case QCOM_ID_APQ8096SG:
>  		drv->versions = 1 << ((unsigned int)(*speedbin) + 4);
>  		break;
>  	default:
