Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D6EA06AE48A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 16:23:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231192AbjCGPW5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 10:22:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjCGPWP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 10:22:15 -0500
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98BDA2195C
        for <linux-kernel@vger.kernel.org>; Tue,  7 Mar 2023 07:20:06 -0800 (PST)
Received: by mail-ed1-x52e.google.com with SMTP id k10so29764041edk.13
        for <linux-kernel@vger.kernel.org>; Tue, 07 Mar 2023 07:20:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678202403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=0vUqYOABwC6dH9eXtw+7fd144/F3EeLBv064ik05cls=;
        b=VcAn9G3JE1EJjbm4iUox8vRzl6w5qvNV4fQa3Ajfo/UJOyqJLmuTZ+YQUdiia+jxd0
         ATfgbOVyPJimxKLVb7tDSBJ6x2XKAmxikpkP0ChBkDgeyHZZFORoKI4bk6s+oljfZrYU
         6G+4XSGWDw36ROV8RBKJx/gXDCEGnAt/LheVn5+8QmL+3WrHnB8XmNbgslzWcoa8Gqea
         y4rKww6To/GGXo2rCvubaxOFyjsPAxF6ioIOIBywMPLRmT2SE/FviYCtKB2/P//ZFUwr
         e2f8CxEs6JV/3I+YgNYjqtHEMphG+Yzdmy8TgJ6L7JcUPm6oL0ZNRm9mJmXbcH6I4g9s
         2ePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678202403;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=0vUqYOABwC6dH9eXtw+7fd144/F3EeLBv064ik05cls=;
        b=6WnLIeylMwmEupVC0PFpPtBZXF6RPqdFnZYiU8ZpFZahuEafAgCrV3ydP/cSuFsdM2
         j3zcGv9Ofj5324sGPa3GzIlVdrD0HjQfIo/MwfOtb5dwzOgO9tQ275RGqo1BmOVArVNK
         eh1NPcGXrxdUOrqfY66rw4MnfJfftdIl9NOh1TOmlN3BWAxRPWICQR/s/E9cWfmO2aqD
         jcxMrBlx8vODsfMYCVIyH+f1S0OxSxoSO6UQDuJ7PrmvqOMdGCJJGjaospi/ElV20UBh
         UtRcuTz11nxYf3CJlDgk7ZnjpkHt29skA/JKimd6clYmnhLvtTQu+5YcsLeqvRYYkmjY
         vqtg==
X-Gm-Message-State: AO0yUKX5kfSEGPOZLkkDO152qp0xm5ZiD1Olf58jrsPvJck7pHydbeHf
        8byY0v78/0URUAAJRBZpLRGIgQ==
X-Google-Smtp-Source: AK7set9aJQcmRihzLRtukwurj+6TQ1BOf6lzmT9UIyJQalcHMYZt6SnWGXL7g5D+/z5yObv1kwbADQ==
X-Received: by 2002:a50:fe99:0:b0:4cd:e84d:1e74 with SMTP id d25-20020a50fe99000000b004cde84d1e74mr15028688edt.0.1678202403026;
        Tue, 07 Mar 2023 07:20:03 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:a60f:e604:c252:1f3d? ([2a02:810d:15c0:828:a60f:e604:c252:1f3d])
        by smtp.gmail.com with ESMTPSA id r15-20020a50c00f000000b004bbc90e1fa3sm6874179edb.93.2023.03.07.07.20.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Mar 2023 07:20:02 -0800 (PST)
Message-ID: <ec7af3f9-5feb-0785-278c-209eeefd0aac@linaro.org>
Date:   Tue, 7 Mar 2023 16:20:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 07/11] mailbox: qcom-apcs-ipc: Add IPQ5018 APCS IPC
 support
Content-Language: en-US
To:     Manikanta Mylavarapu <quic_mmanikan@quicinc.com>,
        agross@kernel.org, andersson@kernel.org, konrad.dybcio@linaro.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, mathieu.poirier@linaro.org,
        mturquette@baylibre.com, sboyd@kernel.org, quic_gurus@quicinc.com,
        loic.poulain@linaro.org, quic_eberman@quicinc.com,
        robimarko@gmail.com, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-remoteproc@vger.kernel.org, linux-clk@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_gokulsri@quicinc.com,
        quic_sjaganat@quicinc.com, quic_kathirav@quicinc.com,
        quic_arajkuma@quicinc.com, quic_anusha@quicinc.com,
        quic_poovendh@quicinc.com
References: <1678164097-13247-1-git-send-email-quic_mmanikan@quicinc.com>
 <1678164097-13247-8-git-send-email-quic_mmanikan@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1678164097-13247-8-git-send-email-quic_mmanikan@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/03/2023 05:41, Manikanta Mylavarapu wrote:
> Enable IPQ5018 APCS IPC support by adding the compatible.
> 
> Signed-off-by: Manikanta Mylavarapu <quic_mmanikan@quicinc.com>
> ---
>  drivers/mailbox/qcom-apcs-ipc-mailbox.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/mailbox/qcom-apcs-ipc-mailbox.c b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> index 6bbf87c6d60b..0b873c76fd7e 100644
> --- a/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> +++ b/drivers/mailbox/qcom-apcs-ipc-mailbox.c
> @@ -141,6 +141,7 @@ static int qcom_apcs_ipc_remove(struct platform_device *pdev)
>  
>  /* .data is the offset of the ipc register within the global block */
>  static const struct of_device_id qcom_apcs_ipc_of_match[] = {
> +	{ .compatible = "qcom,ipq5018-apcs-apps-global", .data = &ipq6018_apcs_data },

Why do you need new entry with same driver data?

Best regards,
Krzysztof

