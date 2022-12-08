Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9DEC2646A02
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 08:59:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiLHH7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 02:59:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229623AbiLHH7W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 02:59:22 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD7554461
        for <linux-kernel@vger.kernel.org>; Wed,  7 Dec 2022 23:59:20 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id cf42so857648lfb.1
        for <linux-kernel@vger.kernel.org>; Wed, 07 Dec 2022 23:59:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ifN3keePSqcP1VQvXgjgaCnpgDY0iz9KJSv9ZTvk64U=;
        b=NyfoEAix9x9ZjuHYxTQNy67/Ymvezy9y2hj03fXPx8mIJA6dW8Vi3co8zXn82yON7M
         UI15Ol21gzQW75izSCq/0gFibYIJ+JivwpvcRq1l4DDnVZW1gWGOFX73ZOK47ILqLNGC
         meSCv2o3EBf/9napNBpTFnXQQYsAK0NcMy85+jpBU+dwpoK0BHsnHLOk7qUq9TBL47RA
         Pxsvd4SPN+gRZ672am2fSNIjF5Zmts4mSiBR2YSuUMGAcfKQov7Y6hEXFoRfHSK4NOFj
         JE+/se7E9BrUhJ3YGBSaKWzrq4mrY1+gUCQivvAQuClqU/oedzs1/IcaLrO/norEsYcE
         4tGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ifN3keePSqcP1VQvXgjgaCnpgDY0iz9KJSv9ZTvk64U=;
        b=FGLmAahlPFXCQa70klrLXRPH4yXjck/emLIP93tXrz5KGI8PR/BUljdCPBrCPBh8RW
         TTG+xLQllJ2Avobq4Mvz3NF0eO9yo4Glpze6TKAY504z4fYMOyagMQ6oZKe09pBOa7Yi
         +0ODJp5h35K27psbdGwBssoL4W+M7+r3F9RK6IU2mgFLpBuM9b/0RzAG2eOEX3lwaiSf
         79PkX62ckOPPkCJVKts/Z8jXya2efQuECnsiT1an56ahmXai9SBnblmdpeV5BVVUbG6u
         jf2uhGC56OnN8wEbhRnykbvDhO5DPSNyjiJ2g8GFZo+E9Xj7V90hQIMyDIag4Ot7AKAt
         TQSw==
X-Gm-Message-State: ANoB5pmpFRDGnVof2LShwfly5wNn+713jj/jxw8VVRhKqls7R0UzVlA3
        FblTTZpmnySITcp8YxrJVhKPlQ==
X-Google-Smtp-Source: AA0mqf6Ai63Lvn4lPSEHsIJqs5NWlG+yEnhX8s/K+t+sinQ058a/JdqLaNPM6UtafcdtITYNKx3R2g==
X-Received: by 2002:a05:6512:33d2:b0:4b5:28fc:36e1 with SMTP id d18-20020a05651233d200b004b528fc36e1mr12149885lfg.179.1670486358836;
        Wed, 07 Dec 2022 23:59:18 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id o9-20020ac25e29000000b0049465afdd38sm3247926lfg.108.2022.12.07.23.59.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 07 Dec 2022 23:59:18 -0800 (PST)
Message-ID: <a2653b17-4ed4-6fe3-ca46-6f8917a58171@linaro.org>
Date:   Thu, 8 Dec 2022 08:59:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.1
Subject: Re: [PATCH V6 1/2] dt-bindings: firmware: qcom,scm: Add optional
 interrupt
Content-Language: en-US
To:     Sibi Sankar <quic_sibis@quicinc.com>, andersson@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     agross@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        robh+dt@kernel.org, konrad.dybcio@somainline.org,
        robimarko@gmail.com, quic_gurus@quicinc.com,
        quic_rjendra@quicinc.com
References: <20221208064031.2875-1-quic_sibis@quicinc.com>
 <20221208064031.2875-2-quic_sibis@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221208064031.2875-2-quic_sibis@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/12/2022 07:40, Sibi Sankar wrote:
> From: Guru Das Srinagesh <quic_gurus@quicinc.com>
> 
> Add an interrupt specification to the bindings to support the wait-queue
> feature on SM8450 SoCs.
> 
> Signed-off-by: Guru Das Srinagesh <quic_gurus@quicinc.com>
> Signed-off-by: Sibi Sankar <quic_sibis@quicinc.com>
> ---
> 
> The interrupt property for scm firmware from a binding perspective is
> completely optional i.e. not all tz fw running in the wild on sm8450
> devices support this feature. The bootloader does the interrupt property
> addition on sm8450 devices with wait-queue support.


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

