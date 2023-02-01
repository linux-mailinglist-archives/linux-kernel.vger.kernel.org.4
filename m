Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B00866865A8
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 13:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbjBAMBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 07:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231485AbjBAMBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 07:01:42 -0500
Received: from mail-wm1-x32b.google.com (mail-wm1-x32b.google.com [IPv6:2a00:1450:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2086360A4
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 04:01:36 -0800 (PST)
Received: by mail-wm1-x32b.google.com with SMTP id n28-20020a05600c3b9c00b003ddca7a2bcbso1231285wms.3
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 04:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6prvu2CI3NzcBWqU0N1Xpa6iVV1xGFav24j3mlsXXA4=;
        b=In09R1A0QdGqESTC/tbUuyeGu1hlVo9zBahaCjmLsXyT9YmlXvcrYY5h4eV9Ezsnii
         SxS1z4Xq3xRPII5NzoBuTDG1bkxeQiSXAflfnxM34O4B1w0EkmpaKZiUUnQ0usp4PgyY
         2n5ukflsgbrsWs/Dno1DOyK3+fwOMA2+NmNfSZ5ZkJH9b+ZiE5RAoVqhdo6LgiQlgRcn
         pv01MQninn/TwLUdLFP/0j0fi0WSwN8w2xWQfTOGFmqDSxnSSPq1w9BiAug9sODRqZ7V
         TiWjXSQfLoeLA0UMOoZRmUvtfluMom8Z/I7A+47kNUu7Q0QjCgDiSDNJ4w/YqX4JRDyI
         hUYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6prvu2CI3NzcBWqU0N1Xpa6iVV1xGFav24j3mlsXXA4=;
        b=XaeD3nScjKqVwK8jZlif6SLV7hP+UUNJoKKx/aoMaNxO1lhfvmAquXtdcs9S9H9hnE
         zuO9UItzSI9MU32mY/uWin8egtz+seNHt8GHPxcAiCs4E4jAbfbdzwIJiaNtVHmmCsQv
         /q5wrfDhS4pcskNcZbK9XcpZi1VR3Ae7prle0vThXR7vbVe8ye9lzs5ocqi/n7KhGFUY
         mtwHKfc9t5r7BjWPnHcVSqyDVj9Df08CvhosJQpv8c4YtTYElgfRqHhudVn9K6h8mjLT
         3bd9t5b12NR9DNtSzHm51Jncb70lE+NxW81kM7sXSS/NAwOxnzZkYxErZ0xscobvJN0i
         MjlQ==
X-Gm-Message-State: AO0yUKXGY3vm8L7OUpNK8ZaAbQn7ojgA/zSBhHSGADtcB4wpNDSVbn0K
        1hheky2IWirVz1VSZuSyTUiwGw==
X-Google-Smtp-Source: AK7set9jSoYr+KrAD0fdumuXJ7Cz89lWI/z0xkcgMMNwyBtEpC8hJTmIUDg3r3Q6CgjkEMUjQeAWuQ==
X-Received: by 2002:a05:600c:1d03:b0:3dd:1bcc:eb17 with SMTP id l3-20020a05600c1d0300b003dd1bcceb17mr1587144wms.28.1675252894823;
        Wed, 01 Feb 2023 04:01:34 -0800 (PST)
Received: from [192.168.1.195] ([5.133.47.210])
        by smtp.googlemail.com with ESMTPSA id y13-20020a1c4b0d000000b003dc4aae4739sm1522444wma.27.2023.02.01.04.01.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 01 Feb 2023 04:01:33 -0800 (PST)
Message-ID: <0df20322-e520-1622-8da8-6dbb44705aec@linaro.org>
Date:   Wed, 1 Feb 2023 12:01:32 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH V2 3/5] firmware: scm: Modify only the DLOAD bit in TCSR
 register for download mode
Content-Language: en-US
To:     Poovendhan Selvaraj <quic_poovendh@quicinc.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        mturquette@baylibre.com, sboyd@kernel.org,
        jassisinghbrar@gmail.com, catalin.marinas@arm.com, will@kernel.org,
        shawnguo@kernel.org, arnd@arndb.de, marcel.ziswiler@toradex.com,
        robimarko@gmail.com, dmitry.baryshkov@linaro.org,
        nfraprado@collabora.com, broonie@kernel.org,
        quic_gurus@quicinc.com, linux-arm-msm@vger.kernel.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_devipriy@quicinc.com
References: <20230201090529.30446-1-quic_poovendh@quicinc.com>
 <20230201090529.30446-4-quic_poovendh@quicinc.com>
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
In-Reply-To: <20230201090529.30446-4-quic_poovendh@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
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



On 01/02/2023 09:05, Poovendhan Selvaraj wrote:
> Add support to read-modify-write TCSR register to modify only DLOAD bit.
> 
> Co-developed-by: Anusha Rao <quic_anusha@quicinc.com>
> Signed-off-by: Anusha Rao <quic_anusha@quicinc.com>
> Co-developed-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> Signed-off-by: Kathiravan Thirumoorthy <quic_kathirav@quicinc.com>
> Signed-off-by: Poovendhan Selvaraj <quic_poovendh@quicinc.com>
> ---
>   drivers/firmware/qcom_scm.c | 12 ++++++++----
>   1 file changed, 8 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/firmware/qcom_scm.c b/drivers/firmware/qcom_scm.c
> index 2000323722bf..e3435587a72d 100644
> --- a/drivers/firmware/qcom_scm.c
> +++ b/drivers/firmware/qcom_scm.c
> @@ -407,7 +407,7 @@ int qcom_scm_set_remote_state(u32 state, u32 id)
>   }
>   EXPORT_SYMBOL(qcom_scm_set_remote_state);
>   
> -static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
> +static int __qcom_scm_set_dload_mode(struct device *dev, u32 val, bool enable)
>   {
>   	struct qcom_scm_desc desc = {
>   		.svc = QCOM_SCM_SVC_BOOT,
> @@ -417,7 +417,7 @@ static int __qcom_scm_set_dload_mode(struct device *dev, bool enable)
>   		.owner = ARM_SMCCC_OWNER_SIP,
>   	};
>   
> -	desc.args[1] = enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;
> +	desc.args[1] = enable ? val | QCOM_SCM_BOOT_SET_DLOAD_MODE : 0;


It is not read-modify-write when enable == false, its just writing 0.

Is this intentional?


>   
>   	return qcom_scm_call_atomic(__scm->dev, &desc, NULL);
>   }
> @@ -426,15 +426,19 @@ static void qcom_scm_set_download_mode(bool enable)
>   {
>   	bool avail;
>   	int ret = 0;
> +	u32 dload_addr_val;
>   
>   	avail = __qcom_scm_is_call_available(__scm->dev,
>   					     QCOM_SCM_SVC_BOOT,
>   					     QCOM_SCM_BOOT_SET_DLOAD_MODE);
> +	ret = qcom_scm_io_readl(__scm->dload_mode_addr, &dload_addr_val);
> +
>   	if (avail) {
> -		ret = __qcom_scm_set_dload_mode(__scm->dev, enable);
> +		ret = __qcom_scm_set_dload_mode(__scm->dev, dload_addr_val, enable);
>   	} else if (__scm->dload_mode_addr) {
>   		ret = qcom_scm_io_writel(__scm->dload_mode_addr,
> -				enable ? QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);
> +				enable ? dload_addr_val |
> +					QCOM_SCM_BOOT_SET_DLOAD_MODE : 0);

same here.


--srini

>   	} else {
>   		dev_err(__scm->dev,
>   			"No available mechanism for setting download mode\n");
