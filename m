Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0BDC6A5C52
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:49:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230124AbjB1Pte (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:49:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44636 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229796AbjB1Ptc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:49:32 -0500
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D26C1989
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:49:31 -0800 (PST)
Received: by mail-wm1-x32a.google.com with SMTP id j3so6746670wms.2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:49:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677599370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GIjRK4WU6Odv6iw6Vj5f3eB9PmR5dRiHlpZQJi4VUcs=;
        b=ZCuz2uXFRRizYz0zXGPUy/HHo6sOlPgrImRQbNWUOrU1kJCHMk0h4mbwk1q8KTGr6I
         u0sacpALYv2zG68KzTFg/YbD6aNF4CSj43CocTu91/qLDDHR0HrBKLY2GyZ6PJQSdORE
         eZY9qDi3QIOQRHjLKpDmTBWVwZ8JsyGZ2PC88sIUV9eD1k7zx/1DSWCovu74yLdZhpdG
         5vsKJG82RbCN7Tk6Ub/AkMLNVtf7WDuh95WxKC2A1ztVC2EZz0q1SkvyGfStkb7usi3z
         LrD39uZS5pWmoWtSFhyB2tHtRjkDGIlDJXlb5yAf/cawiKwZ0b2cWCbcEUNbE1d87LZB
         voYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677599370;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIjRK4WU6Odv6iw6Vj5f3eB9PmR5dRiHlpZQJi4VUcs=;
        b=glVSqeSnHczYiswfkaABQu4WkAqnfamAHSuI49MsjgLBxBq15JBuXGzS51yIq+IIUd
         E3oyIfwg44BUXzHP+92hLI+/aoyLaP5RrZUjQo/TrrmBJzr+suyPBxnLf5WhIsfFPUrh
         Lf7DeXltiFtmFsUOMGncLvZvwWiVt2cFFMf8WcNFWUFH6W8l99dER9IC6Ou6EKW4peEf
         GqTgsDXVVrXZvMB8Ka6mapkPuLreVgJRgFepQ46KQsge+5XIqsp5dGHbzjD60c5qQW7w
         s81sGXPT6aeLpnhpiWPnrGnYXrGJWvFEl4ChPJJsGIas29Vz+xjax42ynDVOXxQjuUK3
         O/rw==
X-Gm-Message-State: AO0yUKVJo8/F+IZ4sUI5AbPP7d57FgStwROM0tsD5FCykQxByy093MOK
        Hn9ulsCaWv29pYMJYzI+uqmMMQ==
X-Google-Smtp-Source: AK7set8Oj7b4Exc7jkGmOD2K8C29DVHf2w7Ipq+A3pTLWn2zWdbtJzNHQL5+U10fj5XjsX2d0n8dyw==
X-Received: by 2002:a05:600c:3b05:b0:3eb:399f:6b70 with SMTP id m5-20020a05600c3b0500b003eb399f6b70mr2507406wms.31.1677599370068;
        Tue, 28 Feb 2023 07:49:30 -0800 (PST)
Received: from [192.168.0.162] (188-141-3-169.dynamic.upc.ie. [188.141.3.169])
        by smtp.gmail.com with ESMTPSA id u26-20020a05600c441a00b003e21638c0edsm13261465wmn.45.2023.02.28.07.49.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 28 Feb 2023 07:49:29 -0800 (PST)
Message-ID: <171eb397-fffc-83b0-fef1-af6c7e109d71@linaro.org>
Date:   Tue, 28 Feb 2023 15:49:28 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 13/18] media: venus: hfi_platform: Check vpu_version
 instead of device compatible
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
 <20230228-topic-venus-v1-13-58c2c88384e9@linaro.org>
From:   Bryan O'Donoghue <bryan.odonoghue@linaro.org>
In-Reply-To: <20230228-topic-venus-v1-13-58c2c88384e9@linaro.org>
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
> This is not a matter of the host SoC, but the VPU chip in Venus. Fix it.
> 
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>   drivers/media/platform/qcom/venus/hfi_platform.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/hfi_platform.c b/drivers/media/platform/qcom/venus/hfi_platform.c
> index f07f554bc5fe..d163d5b0e6b7 100644
> --- a/drivers/media/platform/qcom/venus/hfi_platform.c
> +++ b/drivers/media/platform/qcom/venus/hfi_platform.c
> @@ -80,7 +80,7 @@ hfi_platform_get_codecs(struct venus_core *core, u32 *enc_codecs, u32 *dec_codec
>   	if (plat->codecs)
>   		plat->codecs(enc_codecs, dec_codecs, count);
>   
> -	if (of_device_is_compatible(core->dev->of_node, "qcom,sc7280-venus")) {
> +	if (IS_IRIS2_1(core)) {
>   		*enc_codecs &= ~HFI_VIDEO_CODEC_VP8;
>   		*dec_codecs &= ~HFI_VIDEO_CODEC_VP8;
>   	}
> 

Reviewed-by: Bryan O'Donoghue <bryan.odonoghue@linaro.org>
