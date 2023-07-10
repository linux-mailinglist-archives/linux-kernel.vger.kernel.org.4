Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4186774D4AA
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jul 2023 13:37:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230222AbjGJLhy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jul 2023 07:37:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229583AbjGJLhw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jul 2023 07:37:52 -0400
Received: from mail-ed1-x52a.google.com (mail-ed1-x52a.google.com [IPv6:2a00:1450:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2649E3
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:37:51 -0700 (PDT)
Received: by mail-ed1-x52a.google.com with SMTP id 4fb4d7f45d1cf-51e5e4c6026so413364a12.0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 04:37:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1688989070; x=1691581070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=mS49Wtz3TzRcx25R7DDNtuIqce10iBXCdR5Hdk2vgrA=;
        b=iU+M+r71BtUY/oZSjRY/hyhQMcK14jxslw0ePhv0rlRL0pxcSqeE3jppUK200SYR96
         ieERUpDDjd1BqSyPc9TI80p6owY2zi989cjQ5617ZdksfVtY8M+RMM2L9FqKbVYDxC6/
         501MNT67p1egcawEx7hNsX0jK6mGz7Gt4m9WwY0OycapuevPjINwJuGE7hUIjL63u7p5
         vKezK74Hp1sf+PW99U3FPWffRmhJ9nkNyPKoT/Hlb24Lb3wSxsgube81Fte8kW/rfdxg
         hfQzOMu1lg1y1A2xoYJR5nEpAMzFeERv2epyXA1Pyg+l/RSEh3ffptKtWedQJp7n9YHt
         PjYg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688989070; x=1691581070;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=mS49Wtz3TzRcx25R7DDNtuIqce10iBXCdR5Hdk2vgrA=;
        b=dJFC17dRDYaMnTScEqRltgsFj0D3ln4WGo0fE+jNmqUkZxWOl2ijec+hXtp3czn6WZ
         ra35SWd9a8f2xh+NsSm7qU4AuU+nM9bZcdf+u9EMwuhrXZQCCPEwdBP72lx2ApF3EsQc
         +9LPiUrfD/u1B21jOC9ZU/ZVJEx/stPI5UGbJyI3uJ9/5wyBXAW6ON0dvgzwIIL4/Mjp
         Y26tDfowakokEVkw2irVKKOCeqANmJVxOILNpvvUOkfNsGGt818SlgQXKaCCfQ/Hj+zl
         XKMW76XfKyXQp4bBKz9DDYKghWxmKqdhjw64zHoFfDTmQ/YkjLKcgwlUs+x0MigDG47J
         thrA==
X-Gm-Message-State: ABy/qLb5/LAG8xPI1J2uwTLqyTQ/K/0G6iDLRFyF4KOlmyaUB/4Dh1+a
        bMABBtlvKejOEyjwvgT/EMAxGw==
X-Google-Smtp-Source: APBJJlG/ythdjVOEGhXXPzG6fsYC/s5Hx+kLbmBV7fACvh0QaTgNc2JsK6P/IaMxUnP/Jvb9324wAw==
X-Received: by 2002:a05:6402:2ce:b0:51e:293e:eb96 with SMTP id b14-20020a05640202ce00b0051e293eeb96mr8499341edx.40.1688989070227;
        Mon, 10 Jul 2023 04:37:50 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.223.104])
        by smtp.gmail.com with ESMTPSA id l9-20020aa7c309000000b0051def9be785sm5645491edq.85.2023.07.10.04.37.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Jul 2023 04:37:49 -0700 (PDT)
Message-ID: <d752e5e0-3c34-02ad-6768-42eb2c66e582@linaro.org>
Date:   Mon, 10 Jul 2023 13:37:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.13.0
Subject: Re: [PATCH 1/2] dt-bindings: arm: qcom,ids: drop the IPQ5019 SoC ID
Content-Language: en-US
To:     Kathiravan T <quic_kathirav@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Cc:     quic_srichara@quicinc.com, quic_sjaganat@quicinc.com,
        quic_anusha@quicinc.com, quic_saahtoma@quicinc.com
References: <20230710105419.1228966-1-quic_kathirav@quicinc.com>
 <20230710105419.1228966-2-quic_kathirav@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230710105419.1228966-2-quic_kathirav@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/07/2023 12:54, Kathiravan T wrote:
> IPQ5019 SoC is not available in production. Lets drop it.
> 
> Signed-off-by: Kathiravan T <quic_kathirav@quicinc.com>
> ---
>  include/dt-bindings/arm/qcom,ids.h | 1 -
>  1 file changed, 1 deletion(-)
> 
> diff --git a/include/dt-bindings/arm/qcom,ids.h b/include/dt-bindings/arm/qcom,ids.h
> index bcbe9ee2cdaf..179dd56b2d95 100644
> --- a/include/dt-bindings/arm/qcom,ids.h
> +++ b/include/dt-bindings/arm/qcom,ids.h
> @@ -250,7 +250,6 @@
>  #define QCOM_ID_QRU1000			539
>  #define QCOM_ID_QDU1000			545
>  #define QCOM_ID_QDU1010			587
> -#define QCOM_ID_IPQ5019			569

What about users of this binding? What's the impact on them? When did
the SoC become obsolete and unsupported by Qualcomm? Remember that
ceasing a production does not mean that magically all users of a product
disappear...


Best regards,
Krzysztof

