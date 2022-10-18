Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3C1C603160
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 19:11:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229463AbiJRRLS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 13:11:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229602AbiJRRLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 13:11:16 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 915A2C895E
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:11:15 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id l28so10075262qtv.4
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 10:11:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AtZtFlWaxDzp4p+zyoaTuOJhPmtR/rXSVbDgcVsy++M=;
        b=tnIPN01nJpr5rusLud3hXjIo2aDkZ+LjkWepVdHkW95LxlFnX4zXSYGAv0cpxkN2PY
         xrTi47GvozItMnZUJX1J73I8rs7f4JKXTW4TD8wg6nWWqsXPlfWnv8sgSEeS1EvHhhiB
         BE6eEB12x97rxWtUqK3JigC7BcdOp/TsmYmoFjnvh9FeGSypTAaEba5DX3lmvjpzPmai
         CM+1lfLcVt2cGAJhQKiCBNHrL3x5qlsBIoKqDF+M5xts/0VeCUPKaE4RZg1UyYsxZTc/
         52Qz5AkPADMoEL6TN75vTc3ds2tV5c9eMfb1NXjWgXfyuKEab+Vw1iGL72LIsfcPm+XF
         avgA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AtZtFlWaxDzp4p+zyoaTuOJhPmtR/rXSVbDgcVsy++M=;
        b=zLW1SOnXzoTu/CENwHQ4Tqrnu8DsiYa3uFZ79hRTfMfwg8qGUnsGtudSxweaiEZDCa
         yc6sNdIqf1LTCrcrQKlxiQp/mXywFcOJl3GvNgNbfXsL0EQK9LWMoODQ+qXLjvfEnCkv
         bnRwl2Oik6rhYd0MsdeQKFLhfwm3cEF3mrHpEV+Zh60KtihCmIwMcOwPPBTGQgJk2rxJ
         3jK9nnb9UCaz4qvWLyvt8iLRf2n3yhjL8/thVCyEUddSuaiRbZmMMf5JvN92DyKCV3j0
         zTeVictyoHAda98MpTr/L3+mpaNIPhlNxgUqRdzA67Xpn3mXUzOLhwxgi1uFZuPHaXaX
         KBMw==
X-Gm-Message-State: ACrzQf1E3aaBF1sY2o/opMpVktIhr1iWH4GRn5vV41PpPEqVxsOdKx8Z
        Th8Z/kJK/QKGypwgyfxBmo2j4A==
X-Google-Smtp-Source: AMsMyM6SadXRdagzOt9c1T8+N4cXX7UyAxOLgO26HDrO47PED7/ad9lu195FTu+7QvB61W4FUzMg5g==
X-Received: by 2002:ac8:5cc6:0:b0:398:10b4:8fff with SMTP id s6-20020ac85cc6000000b0039810b48fffmr2933621qta.602.1666113074679;
        Tue, 18 Oct 2022 10:11:14 -0700 (PDT)
Received: from [192.168.10.124] (pool-72-83-177-149.washdc.east.verizon.net. [72.83.177.149])
        by smtp.gmail.com with ESMTPSA id g5-20020ac80705000000b00398ed306034sm2203461qth.81.2022.10.18.10.11.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 10:11:13 -0700 (PDT)
Message-ID: <12d79669-6e8c-6cf8-2e32-d4e0e2e42f3d@linaro.org>
Date:   Tue, 18 Oct 2022 13:11:12 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH V3 1/2] dt-bindings: firmware: qcom-scm: Add optional
 interrupt
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        konrad.dybcio@somainline.org, robimarko@gmail.com,
        quic_gurus@quicinc.com, quic_rjendra@quicinc.com
References: <1666086406-5452-1-git-send-email-quic_sibis@quicinc.com>
 <1666086406-5452-2-git-send-email-quic_sibis@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <1666086406-5452-2-git-send-email-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18/10/2022 05:46, Sibi Sankar wrote:
> From: Guru Das Srinagesh <quic_gurus@quicinc.com>
> 
> Add an interrupt specification to the bindings to support the wait-queue
> feature.
> 
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> The interrupt property for scm firmware from a binding perspective is
> completely optional i.e. not all tz fw running in the wild on sm8450
> devices support this feature. The bootloader does the interrupt property
> addition on sm8450 devices with wait-queue support.
> 
>  Documentation/devicetree/bindings/firmware/qcom,scm.yaml | 5 +++++
>  1 file changed, 5 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> index c5b76c9f7ad0..6483d76b2371 100644
> --- a/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> +++ b/Documentation/devicetree/bindings/firmware/qcom,scm.yaml
> @@ -71,6 +71,11 @@ properties:
>    '#reset-cells':
>      const: 1
>  
> +  interrupts:
> +    description:
> +      The wait-queue interrupt that firmware raises as part of handshake
> +      protocol to handle sleeping SCM calls.

You still miss here constraints... nothing improved. Just look at other
properties in this file.

maxItems:1

Best regards,
Krzysztof

