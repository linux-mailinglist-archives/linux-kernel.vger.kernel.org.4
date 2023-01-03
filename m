Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E69A65CA37
	for <lists+linux-kernel@lfdr.de>; Wed,  4 Jan 2023 00:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234039AbjACXIF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 18:08:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234148AbjACXHw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 18:07:52 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B781140ED
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 15:07:51 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id fm16-20020a05600c0c1000b003d96fb976efso22775915wmb.3
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 15:07:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lDE6h0KPhj6AIMY4aMfpR7Ax0qyv3jao400DqdntNho=;
        b=Y8kmRIHNhMfv+VNyVHSGCKZ/lq6Tt5KXyba9zKRt1KNw9clauGfBpIM1m/SK55CWN5
         xh/9TqzyiQePghGQeBG97tHQcO8f39Vghm10K4jgPOq/W07Kz4ueJx3B79G87p0xJ/3i
         sCDXiaDPV+BN4XXJjWjq7coLwp0DzdjD275s4VfyxAgaTnxVkJV1sO/KQyNfVlsqGP8X
         qbko3qUOkO8BzgISdTYqFVzJdJSHiGYXR2/qX35s2QfJy635mwYQfx2EBes7BEAYx8VP
         CgGXrYcPqzckRwk+H4CI/wC7MWONrzNXluWmp/H4iHrqPDVInDbydZqTZ50lp71pxBjV
         hrsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lDE6h0KPhj6AIMY4aMfpR7Ax0qyv3jao400DqdntNho=;
        b=HpBfAouuPdJ8T+7S9Gv5Ge6nreORtTeboaYQ9y3h7zz75XvrEgDn/7BW3BdyUfo9ro
         6yKN7xIxmnBvlLCrYqRAwUr2g/b2IqTZLlQ8GcgU2pyoAeI4LnsBHlNaPQlZw9pyUwK9
         Q70Dd3g5j19GRZnR/L2ubvoY4pywzw5BZInthm2zkg9VK+zY2sk51yygKbRJdrCUtQvz
         Cl9xMgz7hHbVqGdwHWADV7d6aK1/cUG+oRVuz2CU481U2Zq2OvhJVQdKw0rITJBhFkhg
         kXcq/HcDSdU1+3j6a1ksTJsDIuv3oxTShQQbdUSgzbEul4G0RsKf7EWAGI7H4CEQAS5a
         9NlA==
X-Gm-Message-State: AFqh2kqnEnOku7n388V0rvZmoJZZAZOVeOQ8pg1a123E5w4dy4PRYrtJ
        6LvSB0ULVdncc9KuYLu4aZPW+w==
X-Google-Smtp-Source: AMrXdXvXG724I/sd05QWuuEW+jfcX529OyXenOf+lWx0cDQaLSno906kAh3rbDLxFIeeJDHdC0dELw==
X-Received: by 2002:a05:600c:42d5:b0:3d6:e790:c9a0 with SMTP id j21-20020a05600c42d500b003d6e790c9a0mr39450829wme.10.1672787269703;
        Tue, 03 Jan 2023 15:07:49 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id k5-20020a05600c080500b003d208eb17ecsm41233157wmp.26.2023.01.03.15.07.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 15:07:49 -0800 (PST)
Message-ID: <735088f7-2888-04b1-7751-a3ad7e13a857@linaro.org>
Date:   Tue, 3 Jan 2023 23:07:46 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH 1/4] interconnect: qcom: rpm: Don't set QoS params before
 non-zero bw is requested
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230103173059.265856-1-konrad.dybcio@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230103173059.265856-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 17:30, Konrad Dybcio wrote:
> Until now, the icc-rpm driver unconditionally set QoS params, even on
> empty requests. This is superfluous and the downstream counterpart does
> not do it. Follow it by doing the same.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/interconnect/qcom/icc-rpm.c | 6 ++++++
>   1 file changed, 6 insertions(+)
> 
> diff --git a/drivers/interconnect/qcom/icc-rpm.c b/drivers/interconnect/qcom/icc-rpm.c
> index 43b9ce0dcb6a..06e0fee547ab 100644
> --- a/drivers/interconnect/qcom/icc-rpm.c
> +++ b/drivers/interconnect/qcom/icc-rpm.c
> @@ -193,6 +193,12 @@ static int qcom_icc_qos_set(struct icc_node *node, u64 sum_bw)
>   	struct qcom_icc_provider *qp = to_qcom_provider(node->provider);
>   	struct qcom_icc_node *qn = node->data;
>   
> +	/* Defer setting QoS until the first non-zero bandwidth request. */
> +	if (!(node->avg_bw || node->peak_bw)) {
> +		dev_dbg(node->provider->dev, "NOT Setting QoS for %s\n", qn->name);
> +		return 0;
> +	}
> +
>   	dev_dbg(node->provider->dev, "Setting QoS for %s\n", qn->name);
>   
>   	switch (qp->type) {

Doesn't downstream clear the registers on a zero allocation request ?

https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LA.BR.1.2.9-00810-8x09.0/drivers/platform/msm/msm_bus/msm_bus_bimc.c#L1302

https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LA.BR.1.2.9-00810-8x09.0/drivers/platform/msm/msm_bus/msm_bus_bimc.c#L1318

https://git.codelinaro.org/clo/la/kernel/msm-3.18/-/blob/LA.BR.1.2.9-00810-8x09.0/drivers/platform/msm/msm_bus/msm_bus_bimc.c#L1367

msm_bus_bimc_set_qos_bw()
{
	/* Only calculate if there's a requested bandwidth and window */
	if (qbw->bw && qbw->ws) {
	}else
		/* Clear bandwidth registers */
		set_qos_bw_regs(base, mas_index, 0, 0, 0, 0, 0);
}

---
bod
