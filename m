Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62855696145
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 11:47:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232288AbjBNKrM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 05:47:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232203AbjBNKrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 05:47:09 -0500
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60958252A2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:46:48 -0800 (PST)
Received: by mail-ej1-x62c.google.com with SMTP id jg8so38987877ejc.6
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 02:46:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bSZu2dCpB4pUnfEG7IZ7hWgBfaAKgOTGJQciP+JhljI=;
        b=aInsRALgA9wZYs93mqIJfVgwnQuxi8FJcVt7WdnlcIoY/NwQulebHxmweQjHMbfsiQ
         vq6JJyxTh8yirL735aQ7KfJ/Ued/I3W63m/SLwzueFUtAPZCXT7NAM747gy0YAckbJtd
         DeE+BZMjvwVTLVg3Fmr882truHpV/P0nxG/2ZiMYgX5yeMDmASvEnfJKR90qJkryIjOg
         4O0aQZPubX3k9resjMZh6If4fx6fXbkeYDZmbxxfpd1oh2qXmdwSR+ft+4hUVsqj9QHk
         QkOjnHrNxHZZFZoAA3OB9vCK/ZDcxQjlUoUoUdz4mrt2idONS0Yr1QvdlUjUE5wBHgGG
         p3mg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bSZu2dCpB4pUnfEG7IZ7hWgBfaAKgOTGJQciP+JhljI=;
        b=OBDL2qIbYXwclu8VNaq/wOQMvmC6av9jq9wU1QgBiySc8UpoiJ7ybZ1E7VQx+uy1cZ
         t19Do/LdC8rxQFxXTGVsz9nKlWssOP5NhslksU10QqLXsTtAIy8rlpJ/6CtKViX8FquK
         Sxriw1InsR4mEVdm9XZW/5L3a0GogapTnHPvmME1Gt8tgZw5gISqx9qdgFxAouOonIIK
         IdXV26I7fG1DuUUqLOorNdezbh8lxvJappEUGezdYz24Ga60ddjzlpaTZqpRSpS3Q0Ts
         0KnKNqsUrIVVQ5mxwYkKMMpqsjC/I17sPI5Wi1j7vAuvtM+seq4aVHQZAqrzw5OHwgrr
         qxuA==
X-Gm-Message-State: AO0yUKXGknOcGPSSFfgJrY9aneD09qQAjnnabcBM2uMmZlUIVu59/wrR
        ug/BLY9mefUHqIVLtPiVPca1R3i4xVjEtpTm
X-Google-Smtp-Source: AK7set+SZIbDQUqGvv3dWu5Z+4Ra/zloJPpjrNsbIKyCqSc+rR30uYZQqR/vfvaa2Dts5ofkLbFpQg==
X-Received: by 2002:a17:907:7245:b0:8a5:8620:575 with SMTP id ds5-20020a170907724500b008a586200575mr3170288ejc.3.1676371605817;
        Tue, 14 Feb 2023 02:46:45 -0800 (PST)
Received: from [192.168.1.101] (abxh117.neoplus.adsl.tpnet.pl. [83.9.1.117])
        by smtp.gmail.com with ESMTPSA id sd18-20020a170906ce3200b008b1329cd4cdsm449192ejb.190.2023.02.14.02.46.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 14 Feb 2023 02:46:45 -0800 (PST)
Message-ID: <9e9a2822-2b4b-a4e7-d430-e6233ff0c7f1@linaro.org>
Date:   Tue, 14 Feb 2023 11:46:43 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH] interconnect: qcom: qcm2290: Fix MASTER_SNOC_BIMC_NRT
To:     linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org, krzysztof.kozlowski@linaro.org
Cc:     marijn.suijten@somainline.org, Georgi Djakov <djakov@kernel.org>,
        Shawn Guo <shawn.guo@linaro.org>, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230103142120.15605-1-konrad.dybcio@linaro.org>
Content-Language: en-US
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
In-Reply-To: <20230103142120.15605-1-konrad.dybcio@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3.01.2023 15:21, Konrad Dybcio wrote:
> Due to what seems to be a copy-paste error, the _NRT master was
> identical to the _RT master, which should not be the case.. Fix it
> using the values available from the downstream kernel [1].
> 
> [1] https://android.googlesource.com/kernel/msm-extra/devicetree/+/refs/heads/android-msm-bramble-4.19-android11-qpr1/qcom/scuba-bus.dtsi#127
> Fixes: 1a14b1ac3935 ("interconnect: qcom: Add QCM2290 driver support")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
Gentle bump

Konrad
> Not tested on real hw.
> 
>  drivers/interconnect/qcom/qcm2290.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/interconnect/qcom/qcm2290.c b/drivers/interconnect/qcom/qcm2290.c
> index 0da612d6398c..a29cdb4fac03 100644
> --- a/drivers/interconnect/qcom/qcm2290.c
> +++ b/drivers/interconnect/qcom/qcm2290.c
> @@ -147,9 +147,9 @@ static struct qcom_icc_node mas_snoc_bimc_nrt = {
>  	.name = "mas_snoc_bimc_nrt",
>  	.buswidth = 16,
>  	.qos.ap_owned = true,
> -	.qos.qos_port = 2,
> +	.qos.qos_port = 3,
>  	.qos.qos_mode = NOC_QOS_MODE_BYPASS,
> -	.mas_rpm_id = 163,
> +	.mas_rpm_id = 164,
>  	.slv_rpm_id = -1,
>  	.num_links = ARRAY_SIZE(mas_snoc_bimc_nrt_links),
>  	.links = mas_snoc_bimc_nrt_links,
