Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23C7D6A5C00
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:33:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjB1Pdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54646 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229894AbjB1Pdo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:33:44 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 02C142ED76
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:33:29 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id p26so6693559wmc.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:33:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677598407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9nv9JNtDlCNdtDLRBoEfNQRumarktclBfrFr5F3k7E8=;
        b=bMu5ay0c51WoE+NUEQb+duROsc8eq0IELqCZ4lPXk8hzWns/Tnde6Ss1GglVTUCWCg
         nGIsimZlVgTollaFCtjotqgD14tpS2X/5T9IG7dL7MQGVjqu2KZOPg1ycRef2iJ/9DCe
         CoOd+KvWlYjSSAdH3/+dXBMceTIZ7MzgGpBpSe4oW02FXRWSh04/rLs2NyT2eaVOR/JV
         jUtOJ8204uu8ATG1R2Gcc9OtMErMZRGU75FaEBiBQgJl4hA8HmU8gzF+Y8osYrCLRac0
         vRJfe+Vq8UslgPsi+TTZqpZICXz38dJVtQHgdmUPqp5EvAyQQfHMs+S9jgZXqFsuDPO9
         A7lQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677598407;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9nv9JNtDlCNdtDLRBoEfNQRumarktclBfrFr5F3k7E8=;
        b=YoNF5AkP957Wlpvi+gPVSADDe/5QpLIJPgWwpZnIf17fMv1L1kOy9F9EQOqAsURKZI
         XzaqkZqhWSIGXkgA0Ei9ahI9QXvJ+VFnuzIP1stCaGS8b6puWpG8wpg8SaIZ1K1xZgOU
         tyWQUzlpyNzt/ngwy573MlsZK9syBp30ikl2Sm9ZOZk2VPgEzIiPjzsSwg30kXElEG2l
         IOrEcSNkN/aZfurcMWVdMrNz1zEaCJpf2pHEtsgywWhT+kgw7ThMgOjKcTnm1IbDObCI
         NowTodiS4Tmg9Hsv4AfnH3+h6fFioSSOpdOU8/Jn0dF7h1pzwbshSAgnbNo7Dzy/IetP
         +3CA==
X-Gm-Message-State: AO0yUKXQfS/HQtYY6qJN3Pw/WMZQLRNJeY5GD4a6mCBRl5pR9DGP1quf
        2Pj6HhoSqGmyyMw8d4bMWf8EFA==
X-Google-Smtp-Source: AK7set8wq1PJum4pWy19ypA8LxCBU2liGpV1nyFqRuNVz1Djx5bVEeSFVDn7ExYe4bqelqqqJo5RFg==
X-Received: by 2002:a05:600c:164a:b0:3eb:4cb5:dfa with SMTP id o10-20020a05600c164a00b003eb4cb50dfamr2471202wmn.31.1677598407489;
        Tue, 28 Feb 2023 07:33:27 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id az11-20020a05600c600b00b003e1202744f2sm16169728wmb.31.2023.02.28.07.33.26
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 07:33:27 -0800 (PST)
Message-ID: <54bd7d0b-b47b-dfae-f62e-9393162d79a7@linaro.org>
Date:   Tue, 28 Feb 2023 15:33:26 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 06/18] media: venus: hfi_venus: Write to VIDC_CTRL_INIT
 after unmasking interrupts
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>
References: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
 <20230228-topic-venus-v1-6-58c2c88384e9@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230228-topic-venus-v1-6-58c2c88384e9@linaro.org>
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

On 28/02/2023 15:24, Konrad Dybcio wrote:
> The downstream driver signals the hardware to be enabled only after the
> interrupts are unmasked, which... makes sense. Follow suit.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/media/platform/qcom/venus/hfi_venus.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
> index 772e5e9cf127..4d785e53aa0b 100644
> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
> @@ -454,7 +454,6 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
>   	void __iomem *wrapper_base = hdev->core->wrapper_base;
>   	int ret = 0;
>   
> -	writel(BIT(VIDC_CTRL_INIT_CTRL_SHIFT), cpu_cs_base + VIDC_CTRL_INIT);
>   	if (IS_IRIS1(hdev->core) || IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core)) {
>   		mask_val = readl(wrapper_base + WRAPPER_INTR_MASK);
>   		mask_val &= ~(WRAPPER_INTR_MASK_A2HWD_BASK_V6 |
> @@ -466,6 +465,7 @@ static int venus_boot_core(struct venus_hfi_device *hdev)
>   	writel(mask_val, wrapper_base + WRAPPER_INTR_MASK);
>   	writel(1, cpu_cs_base + CPU_CS_SCIACMDARG3);
>   
> +	writel(BIT(VIDC_CTRL_INIT_CTRL_SHIFT), cpu_cs_base + VIDC_CTRL_INIT);
>   	while (!ctrl_status && count < max_tries) {
>   		ctrl_status = readl(cpu_cs_base + CPU_CS_SCIACMDARG0);
>   		if ((ctrl_status & CPU_CS_SCIACMDARG0_ERROR_STATUS_MASK) == 4) {
> 

This should go before you add your new macros in-place of IS_V6() and it 
should have a fixes.

---
bod
