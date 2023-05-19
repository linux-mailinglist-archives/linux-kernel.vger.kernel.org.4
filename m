Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DCF470A324
	for <lists+linux-kernel@lfdr.de>; Sat, 20 May 2023 01:05:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229720AbjESXFg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 19:05:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbjESXFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 19:05:33 -0400
Received: from mail-lf1-x129.google.com (mail-lf1-x129.google.com [IPv6:2a00:1450:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 020C81B0
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:05:32 -0700 (PDT)
Received: by mail-lf1-x129.google.com with SMTP id 2adb3069b0e04-4f004cc54f4so4528066e87.3
        for <linux-kernel@vger.kernel.org>; Fri, 19 May 2023 16:05:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1684537530; x=1687129530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CH793sgUCPoEgTdNsNBKhvmlcAnZbyZV686B0yjydUs=;
        b=iIXIbqGFs2GyzDqFUHXlLHXs/1bOgPBkV1jtXHFHgSJtHr1RkPYvzH7bJL6Z+Smtyi
         uIMzQWDqj4X5CN+MyOQSAuVjayUFVJ5wZ8DJbFObUk2Q4NB55fJhVXRUN9frmT02m4xU
         tdLehwwzvwayaC3uVcmDnNWcX3YqDEO17hM06d5TI4edDwsY5jPv12eUVVr0RfKhnTvs
         7YBmrEvDhqjwNVqkCU8H3OIktdnC/yWfXD2hwbhiDCSlF1AjG+CGHImuNasEuuFCKeTc
         UsXbeqBL5RQQ1qLJj53peYuhYAnMl84KJbx9hfWXkXPe1r/w5RmF/VRYRwONIm4q/6Zi
         sgtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684537530; x=1687129530;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=CH793sgUCPoEgTdNsNBKhvmlcAnZbyZV686B0yjydUs=;
        b=drsVsvH8mnjw6G2MQMu/BW9x6KFLkM/GkWWHVW7669HSE5DcvAGeGsrY3qiSdKFIOY
         uq5FMhhrXFCzXcxWFm+ry/a5br5XpC50sJ6yeeXPeL0bMcJwnl5XNPkDbjGiOeZp8WiF
         VM0C1tD0ESKTYOCnz6vROhl1AwfY0KPUtJd9gmMt82yqWOBAmlLKCl7l40ZM8w/YBmkH
         MA/vDzeV1cG38liFKctEPQDyBRyMLX692byUt16ocorkmDoftrnqKqrx2JF5diwdavXt
         lYSRkxZLFkXx5QfSe2LNVmHeTnvU9br/siwg6nGNNzKCYl9rDeUg9Ot3LnZYmeLw0p9R
         KLoA==
X-Gm-Message-State: AC+VfDxbZWMzMAkduSytUulN+jb9K78m1D9JQhSVtEB+KOvrsWXLvRzb
        PKBibTp3B8jh8wtGy32BaDFVcQ==
X-Google-Smtp-Source: ACHHUZ6v2paA0KBB2zxzN55IlBrN83cQBJA7xyejdrGS8nCRzjtP9hi+JHBTdrwuZKTYyXr35upYFA==
X-Received: by 2002:a05:6512:21a6:b0:4f3:a71a:9e6a with SMTP id c6-20020a05651221a600b004f3a71a9e6amr1064723lft.43.1684537530277;
        Fri, 19 May 2023 16:05:30 -0700 (PDT)
Received: from ?IPV6:2001:14ba:a0db:1f00::8a5? (dzdqv0yyyyyyyyyyybcwt-3.rev.dnainternet.fi. [2001:14ba:a0db:1f00::8a5])
        by smtp.gmail.com with ESMTPSA id v30-20020a056512049e00b004f37aac79f4sm50774lfq.185.2023.05.19.16.05.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 19 May 2023 16:05:29 -0700 (PDT)
Message-ID: <0ce92028-d69d-8c4d-c912-a3daf0ce3d33@linaro.org>
Date:   Sat, 20 May 2023 02:05:29 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 2/3] clk: qcom: gpucc-sm8550: Add support for graphics
 clock controller
Content-Language: en-GB
To:     Jagadeesh Kona <quic_jkona@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Satya Priya Kakitapalli <quic_skakitap@quicinc.com>,
        Taniya Das <quic_tdas@quicinc.com>
References: <20230519213656.26089-1-quic_jkona@quicinc.com>
 <20230519213656.26089-3-quic_jkona@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
In-Reply-To: <20230519213656.26089-3-quic_jkona@quicinc.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/2023 00:36, Jagadeesh Kona wrote:
> Add support for gpucc driver on SM8550, which provides clocks for the
> graphics subsystem.
> 
> Signed-off-by: Jagadeesh Kona <quic_jkona@quicinc.com>
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>

Jagadeesh, if you are submitting a patch, your sign-off should be the 
last one. If Taniya participated in development of the driver, you might 
want to add the "Co-Developed-by" tag in addition to existing ones.

> ---
>   drivers/clk/qcom/Kconfig        |   8 +
>   drivers/clk/qcom/Makefile       |   1 +
>   drivers/clk/qcom/gpucc-sm8550.c | 609 ++++++++++++++++++++++++++++++++
>   3 files changed, 618 insertions(+)
>   create mode 100644 drivers/clk/qcom/gpucc-sm8550.c
> 

[skipped]

> +static int __init gpu_cc_sm8550_init(void)
> +{
> +	return platform_driver_register(&gpu_cc_sm8550_driver);
> +}
> +subsys_initcall(gpu_cc_sm8550_init);

module_device_driver

> +
> +static void __exit gpu_cc_sm8550_exit(void)
> +{
> +	platform_driver_unregister(&gpu_cc_sm8550_driver);
> +}
> +module_exit(gpu_cc_sm8550_exit);
> +
> +MODULE_DESCRIPTION("QTI GPU_CC SM8550 Driver");
> +MODULE_LICENSE("GPL");

-- 
With best wishes
Dmitry

