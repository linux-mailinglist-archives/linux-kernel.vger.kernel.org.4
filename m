Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F5196B5BEE
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Mar 2023 13:44:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230486AbjCKMoQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Mar 2023 07:44:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229872AbjCKMoM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Mar 2023 07:44:12 -0500
Received: from mail-lj1-x231.google.com (mail-lj1-x231.google.com [IPv6:2a00:1450:4864:20::231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B37E73392
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:44:11 -0800 (PST)
Received: by mail-lj1-x231.google.com with SMTP id t14so8103528ljd.5
        for <linux-kernel@vger.kernel.org>; Sat, 11 Mar 2023 04:44:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678538649;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VcaYjLjPvSB246IFQKjIZiDHQq6ZPuupoOOOjiqa1s8=;
        b=SKIKy9TkuiOdB+ZAQcysWMfNY9vWCkOja8VSjtXMF/7v7HwZQD64y9UfAJkJimu0B+
         HnfAUXQ1JnG2d2aVKGUTNIAyfbWCUNqRbqButwaXSB2nmggswUZlQnBbl2L2fP37RWd8
         V5QMfYnAGK1t6xf55sIyIKVeE7k3mIhexYCU/2YkD22TrtRTVnulLb2X8sCS9GmoXWdL
         ydVzfjWrSkzkIhEPgZuqtLsIY4s0AD2fQpqkgO+s+TiP082uMAEpCvLQEZ8v53gRx/Un
         OnVgI59ByLSUREuaC7aeX0o63AtyFpJh8ctMGE/bMD31t41eykNgGtNS+0Y05H6BJwSu
         StIg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678538649;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VcaYjLjPvSB246IFQKjIZiDHQq6ZPuupoOOOjiqa1s8=;
        b=wnRNxKvzBngcMVNj1M4eiJFN5tpqbB63CtvuWtmVCPjaPbIELVwpjWpTeW7pdAsi+V
         MOLx7KRRtnUlytHrPKfolfI144rbsEdTrL53H7QGxVk+n3pDPytmHucq11cNClGsNtZo
         RH4hNy00Gd+/Fx2CdYS/1UwH1QJEBzO/zFqMximS1w9vH3cXqem01AgjWd/MxrbRG3IZ
         TB7OhkKbBZT+CoK6mDgaji8MftkZaFdMGLsgBiTPMTo++BpGWkM4+8w/MKo9w7kFQIbT
         4W2l/suKu9oDU+dCLYrNToVo/0xow/mBVsgUpBhr1m8uZUkxmYUTmRyAB7RjXn7D7qrp
         KATg==
X-Gm-Message-State: AO0yUKXXcxU8nzyF/rGhwltEZWp8hxoU3YL8M7vi0m0effCuCpilbHJl
        AAwVyzfImYARAeteKGVwW6znLg==
X-Google-Smtp-Source: AK7set8YVXdMz3+JHVRAw7Tv+UChDLQa/90v83D5KK02MD+ozlocxpnXL8eMIIQQ3TMvE2gWZ8GzEg==
X-Received: by 2002:a2e:2283:0:b0:298:6d41:a663 with SMTP id i125-20020a2e2283000000b002986d41a663mr3824458lji.23.1678538649668;
        Sat, 11 Mar 2023 04:44:09 -0800 (PST)
Received: from [192.168.1.101] (abyj16.neoplus.adsl.tpnet.pl. [83.9.29.16])
        by smtp.gmail.com with ESMTPSA id x19-20020ac24893000000b004b5ab5e904esm303954lfc.306.2023.03.11.04.44.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Mar 2023 04:44:09 -0800 (PST)
Message-ID: <f256be10-779f-ba47-1f32-a8d6ef311ad1@linaro.org>
Date:   Sat, 11 Mar 2023 13:44:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] soc: qcom: Use of_property_present() for testing DT
 property presence
Content-Language: en-US
To:     Rob Herring <robh@kernel.org>, Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>
Cc:     devicetree@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230310144724.1545153-1-robh@kernel.org>
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230310144724.1545153-1-robh@kernel.org>
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



On 10.03.2023 15:47, Rob Herring wrote:
> It is preferred to use typed property access functions (i.e.
> of_property_read_<type> functions) rather than low-level
> of_get_property/of_find_property functions for reading properties. As
> part of this, convert of_get_property/of_find_property calls to the
> recently added of_property_present() helper when we just want to test
> for presence of a property and nothing more.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
Reviewed-by: Konrad Dybcio <konrad.dybcio@linaro.org>

Konrad
>  drivers/soc/qcom/qcom_aoss.c | 2 +-
>  drivers/soc/qcom/smem.c      | 2 +-
>  drivers/soc/qcom/smsm.c      | 2 +-
>  3 files changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
> index 18c856056475..e376c32cc16e 100644
> --- a/drivers/soc/qcom/qcom_aoss.c
> +++ b/drivers/soc/qcom/qcom_aoss.c
> @@ -395,7 +395,7 @@ static int qmp_cooling_devices_register(struct qmp *qmp)
>  		return -ENOMEM;
>  
>  	for_each_available_child_of_node(np, child) {
> -		if (!of_find_property(child, "#cooling-cells", NULL))
> +		if (!of_property_present(child, "#cooling-cells"))
>  			continue;
>  		ret = qmp_cooling_device_add(qmp, &qmp->cooling_devs[count++],
>  					     child);
> diff --git a/drivers/soc/qcom/smem.c b/drivers/soc/qcom/smem.c
> index 4f163d62942c..25f5925a8d51 100644
> --- a/drivers/soc/qcom/smem.c
> +++ b/drivers/soc/qcom/smem.c
> @@ -1045,7 +1045,7 @@ static int qcom_smem_probe(struct platform_device *pdev)
>  	int i;
>  
>  	num_regions = 1;
> -	if (of_find_property(pdev->dev.of_node, "qcom,rpm-msg-ram", NULL))
> +	if (of_property_present(pdev->dev.of_node, "qcom,rpm-msg-ram"))
>  		num_regions++;
>  
>  	array_size = num_regions * sizeof(struct smem_region);
> diff --git a/drivers/soc/qcom/smsm.c b/drivers/soc/qcom/smsm.c
> index 3e8994d6110e..8c137dff7dac 100644
> --- a/drivers/soc/qcom/smsm.c
> +++ b/drivers/soc/qcom/smsm.c
> @@ -510,7 +510,7 @@ static int qcom_smsm_probe(struct platform_device *pdev)
>  		return -ENOMEM;
>  
>  	for_each_child_of_node(pdev->dev.of_node, local_node) {
> -		if (of_find_property(local_node, "#qcom,smem-state-cells", NULL))
> +		if (of_property_present(local_node, "#qcom,smem-state-cells"))
>  			break;
>  	}
>  	if (!local_node) {
