Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3E9076A5C26
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:40:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229779AbjB1PkT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:40:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjB1PkR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:40:17 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2F8D196B7
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:40:15 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id c18so6717111wmr.3
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:40:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677598814;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mo74FXa48EiHuR/p3cmL0JbUvzG9s2CSQCFcDO9etU4=;
        b=pw6QVKERnSKJ+6q59CSuM2qo672FcudvhDoRx/RARoL7NQYjK6hT4oCTmIovILiY9v
         uIS/W644P1m2HzcuVUaAeI+k/bM3SuXVwrrmvFAHTI8Otug54XpMSnKm3Hp+94CCH3fq
         L72Ezqm0ieAufr1E/7r7ure+vgpNDKeU/ySPkMIYoKWu0DbJFaW08ExX5D0QEt9WRFIO
         rOyhI/MD0Dr35otPmVmzrff0x3jMy5SiZrfrTMZlB+f2T9aUAc9Frt8e69NpNtnfEfzI
         j35XJtpEc/Vmm9EZHtE1ds7XAQBv3lzfk2ns8ZzXE4QPHch9GXIMP46Pu9u094yntX/r
         8asg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677598814;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mo74FXa48EiHuR/p3cmL0JbUvzG9s2CSQCFcDO9etU4=;
        b=jWXmlmCTlgJyaiyN4Tdv1cj4Z54BEs6KTVpnQkhxsrUq9IUFsNqvoaQRWjSW0UkvFE
         y9hMjePoPQq8UhBfBsPv3HM7yfN6jTicAEPZ+k3OG/5/RjD05ZczL/iMZz0WJmOlY5LW
         8+3fpBTjmQyBqCH5DLetfkI98/bDwmaJoHyNwbWtmjEQqNZ0wDVgX4pYuy0oJQGcQ8sC
         iKoXpLnHa0OOxObEM5ZsEDokptzfjqCp6/51wGTdfx3hETYgEpfLogNLDiI4++8XNU+l
         7Q2EKJqDljRUZ6pFhhoW7is9hpaXZ79Z/1+OR8iaw34LrkYasAN0vFshk8HUVgigxK2I
         MECQ==
X-Gm-Message-State: AO0yUKXOEma4yhNC9D5o1HOJNarmbdLwcNj2W8aJP+DG/354wNFgZWFl
        3XjrDy/qpchoQnlOHUb1NGomtOumgVXe9XoB
X-Google-Smtp-Source: AK7set+pz6p2SbJFmEqWt9MjkLkWAVY4jRiKSA9wG7+UuAauDfBrNS1y9jEPEreahs4LKelHsnijBg==
X-Received: by 2002:a05:600c:1d1d:b0:3df:db20:b0ae with SMTP id l29-20020a05600c1d1d00b003dfdb20b0aemr2717550wms.17.1677598814357;
        Tue, 28 Feb 2023 07:40:14 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id hg13-20020a05600c538d00b003dc434b39c7sm2533558wmb.0.2023.02.28.07.40.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 07:40:13 -0800 (PST)
Message-ID: <9ff1640c-8365-10f7-6765-0d1bd0e07620@linaro.org>
Date:   Tue, 28 Feb 2023 15:40:12 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 10/18] media: venus: hfi_venus: Fix version check in
 venus_cpu_and_video_core_idle()
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
 <20230228-topic-venus-v1-10-58c2c88384e9@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230228-topic-venus-v1-10-58c2c88384e9@linaro.org>
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
> IS_V6() should have instead checked for specific VPU versions. Fix it.
> 
> Fixes: e396e75fc254 ("media: venus: hfi: Read WRAPPER_TZ_CPU_STATUS_V6 on 6xx")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/media/platform/qcom/venus/hfi_venus.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
> index ecfbac36de20..584c84125887 100644
> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
> @@ -1543,7 +1543,7 @@ static bool venus_cpu_and_video_core_idle(struct venus_hfi_device *hdev)
>   	void __iomem *cpu_cs_base = hdev->core->cpu_cs_base;
>   	u32 ctrl_status, cpu_status;
>   
> -	if (IS_V6(hdev->core))
> +	if (IS_AR50_LITE(hdev->core) || IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core))
>   		cpu_status = readl(wrapper_tz_base + WRAPPER_TZ_CPU_STATUS_V6);
>   	else
>   		cpu_status = readl(wrapper_base + WRAPPER_CPU_STATUS);
> 

Same comment on the Fixes.

You need 02/18 to apply this to pervious kernels.

---
bod
