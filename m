Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A736A5C13
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:37:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjB1PhG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:37:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59040 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229962AbjB1PhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:37:03 -0500
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FFE5254
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:37:01 -0800 (PST)
Received: by mail-wr1-x42e.google.com with SMTP id e37so7731600wri.10
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:37:01 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677598619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=eQH1DUy39Ewg6ybie4WvlnpQSNvOs/GRqL+VeodO82E=;
        b=idjbpNpZmgW3geUl/3/PPsXJw7cgWxH651DaQMeA7Fy0SlGOg368wXbN1qD1UJwtm7
         AYVChfUxqAWaRGYkkfpZBeFandVVHpDzNQfPPhAOAUz2g2oLsuUSI/ftKcxgpn8sBnMP
         SoDtJWg4Kgg32MH5/a075S+3b9kf+XbMz8YVOhlhkb6tbrptt8RgneQj4+EaawT0wLH8
         UATjxNOkX2pZgR9OllSdX4aah/Pj5IRlOVr8hCVnJ2jcMlZZ9bR3rlKMqBpfcZjgphii
         YW5HKrSd0xocCE3cxRolvtWfNy4h3SCjr9VUIoKMzEd4AmeRAlinhxn7AVT3RgbkZYSn
         qGqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677598619;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=eQH1DUy39Ewg6ybie4WvlnpQSNvOs/GRqL+VeodO82E=;
        b=ROcJxAB0JLR5QzairfY5SxI4ZrVeU1+QhXzjpZ/cpUQ/64FNw1HAzBTUFzuFKOmcfL
         K81nzTlQ+fSstNANxyMCXobY+DVl4uHk+NmSyRI6rSTQvBUiOrYRBt1Vh1FCWWDklDKh
         z0vlAbWSJ/uV6XITWOBmyT/tzjYmm3GxcszuLd3VvEjGn338znz0fBvdV0HZ9tUUGe6S
         TMnqayWkq7ZrNkMuy5nsNjwotp+Ag+UxfVDeGs2ZY8K34ZbMdEK4loarN/vw9qVEpv0I
         lysujl1PBhqf+P1L+Vg8Q/Lz8AcueHrzTv1qZTiQzwRfGHi/XDcP84eg9clDdnLqdXGg
         d31g==
X-Gm-Message-State: AO0yUKXo9eRwC/yJoMZkwF9CtlG9PxXQw8otfzIpKBcR4/ywIr8ZXdzo
        HBE1kZsMb7Otw7PQB8m2r5CSQA==
X-Google-Smtp-Source: AK7set+CIo+8e+ZNITl4Ec2jPQyLBQhPXiP5EU0Aof1CizbcsL235lOg/bbk34raISs3EV2rZeOoXA==
X-Received: by 2002:a5d:6d45:0:b0:2c7:851:c0bf with SMTP id k5-20020a5d6d45000000b002c70851c0bfmr2561946wri.0.1677598619729;
        Tue, 28 Feb 2023 07:36:59 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id ay31-20020a05600c1e1f00b003e209186c07sm15322119wmb.19.2023.02.28.07.36.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 07:36:59 -0800 (PST)
Message-ID: <a5fe6f7d-d410-9903-789c-d8c760ce6f1b@linaro.org>
Date:   Tue, 28 Feb 2023 15:36:58 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 08/18] media: venus: hfi_venus: Fix version checks in
 venus_halt_axi()
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
 <20230228-topic-venus-v1-8-58c2c88384e9@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230228-topic-venus-v1-8-58c2c88384e9@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/02/2023 15:24, Konrad Dybcio wrote:
> Only IRIS2(_1) should enter the until-now-IS_V6() path and the
> condition for skipping part of it should be IS_IRIS2_1 and not the
> number of VPP pipes. Fix that.
> 
> Fixes: 4b0b6e147dc9 ("media: venus: hfi: Add 6xx AXI halt logic")
> Fixes: 78d434ba8659 ("media: venus: hfi: Skip AON register programming for V6 1pipe")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/media/platform/qcom/venus/hfi_venus.c | 4 ++--
>   1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_venus.c b/drivers/media/platform/qcom/venus/hfi_venus.c
> index 4d785e53aa0b..0d137e070407 100644
> --- a/drivers/media/platform/qcom/venus/hfi_venus.c
> +++ b/drivers/media/platform/qcom/venus/hfi_venus.c
> @@ -550,10 +550,10 @@ static int venus_halt_axi(struct venus_hfi_device *hdev)
>   	u32 mask_val;
>   	int ret;
>   
> -	if (IS_V6(hdev->core)) {
> +	if (IS_IRIS2(hdev->core) || IS_IRIS2_1(hdev->core)) {
>   		writel(0x3, cpu_cs_base + CPU_CS_X2RPMH_V6);
>   
> -		if (hdev->core->res->num_vpp_pipes == 1)
> +		if (IS_IRIS2_1(hdev->core))
>   			goto skip_aon_mvp_noc;
>   
>   		writel(0x1, aon_base + AON_WRAPPER_MVP_NOC_LPI_CONTROL);
> 

If you want to denote these as fixes, you need your patch 02/18 as a 
depend...

---
bod
