Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CD36DED6B
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 10:19:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229818AbjDLITk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 04:19:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58612 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229758AbjDLITg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 04:19:36 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69E621B0
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:19:33 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id f26so20625020ejb.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 01:19:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681287572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=LquOzlkyKxehJwDFL94uuL+mZHnm4ypcdZd+4o5Ged4=;
        b=F1IrCq74k6tf6dr0Qc7aTdHAsgfGrG9hJELpGAh8kF5IOvOTqF0UrclwyIfZbuBzxS
         NM+tgPhkyyiL55Fv9rqrJxvnhMko9d++g2tQPdeHZG41JeB7xN0VrhSIrKb2XeuW8zPC
         ZgMEFy8m1isYfUTi3qDcNP+laDGqNOXz3yF/7NYHsoqL2XsZeOq+m409D8Su4KVB+dSI
         0ikClf9gW1ZGDGjiUy94QvtY9SexQXw7Q/s+nq/l3vIbzjjZoZnYArYC5Jv+VXD/uMhM
         +eEuAblS54Wc6Nm6x+HIzxwQXqug0CCtmfdebj/marMW6oJbqSMSkVLj86jsJd11fSOe
         UcrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681287572;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=LquOzlkyKxehJwDFL94uuL+mZHnm4ypcdZd+4o5Ged4=;
        b=fLEIcZQ2yNJ0pd0wM1KzC3qi9uBKue6TqcI82IjT/+UisgFxHk58r0D2P7ytIl2L+z
         bwrXpR9+bxhviVXR55hfWS3jrUTIhWQuNOS2UOBkjzWfRWTbaeZ7ZtoxXm1g9ZERTRgr
         fLG3N2580lKp9+z7XJvPRdBjXQRwfFG7YpyNMBhM2hdoVf7v1/VFWa/M1BrdmbLppsmr
         fSdOFtaX1kwiQH9Dr2/iQplRAu/3xX7sC9mhqyE6uoWlfU7/Zc4aio8WIQl1jbkkStJP
         FaOll0xgNyWz1xp2irUEP4YMVnHO1b6n58St5HmN9NI+Nb9zKi3znsGEPYKFtO6yLU2u
         B9NA==
X-Gm-Message-State: AAQBX9fo6RFt51zcr3H2kzlcQEILTJ4U5f6G1XzrDMn+ZY8zXMd03jTC
        YKtnFzsPJu/acyydRobmT7CFpA==
X-Google-Smtp-Source: AKy350aUIRnZQrhIU0+8BIzA1Tzh6d3p28M/rwt/syiKhSoZSWUFrGONjAuXmxFG4qTc8Drh88wNvw==
X-Received: by 2002:a17:906:da82:b0:94a:464a:e88e with SMTP id xh2-20020a170906da8200b0094a464ae88emr15184505ejb.42.1681287571933;
        Wed, 12 Apr 2023 01:19:31 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8fa0:9989:3f72:b14f? ([2a02:810d:15c0:828:8fa0:9989:3f72:b14f])
        by smtp.gmail.com with ESMTPSA id qk16-20020a1709077f9000b0094d7bc8e9aasm2037006ejc.94.2023.04.12.01.19.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 01:19:31 -0700 (PDT)
Message-ID: <1f276e6d-4a13-49f8-0953-9b1658d31c04@linaro.org>
Date:   Wed, 12 Apr 2023 10:19:30 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH V2 1/3] dt-bindings: sram: qcom,imem: Add Boot Stat region
 within IMEM
Content-Language: en-US
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
References: <cover.1680874520.git.quic_schowdhu@quicinc.com>
 <96601c1f9e433ef8fbc608d5ca09365b9c0d8132.1680874520.git.quic_schowdhu@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <96601c1f9e433ef8fbc608d5ca09365b9c0d8132.1680874520.git.quic_schowdhu@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2023 16:04, Souradeep Chowdhury wrote:
> All Qualcomm bootloaders log useful timestamp information related
> to bootloader stats in the IMEM region. Add the child node within
> IMEM for the boot stat region containing register address and
> compatible string.
> 
> Signed-off-by: Souradeep Chowdhury <quic_schowdhu@quicinc.com>
> ---
>  .../devicetree/bindings/sram/qcom,imem.yaml         | 21 +++++++++++++++++++++
>  1 file changed, 21 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/sram/qcom,imem.yaml b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> index 665c06e..9998d65 100644
> --- a/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> +++ b/Documentation/devicetree/bindings/sram/qcom,imem.yaml
> @@ -26,6 +26,7 @@ properties:
>            - qcom,sdm845-imem
>            - qcom,sdx55-imem
>            - qcom,sdx65-imem
> +          - qcom,sm8450-imem

Use recent Linux kernel for your work.

Best regards,
Krzysztof

