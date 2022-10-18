Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E2F3602D44
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:45:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbiJRNpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:45:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231159AbiJRNpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:45:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5DD52CAE5B
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:45:38 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id fn7-20020a05600c688700b003b4fb113b86so12246255wmb.0
        for <linux-kernel@vger.kernel.org>; Tue, 18 Oct 2022 06:45:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:from:to:cc:subject:date:message-id:reply-to;
        bh=p0FXx0MqoXM7qRnrNL7t4EmZOdwWs5pyFYPwTCmqmp8=;
        b=LAPQ5AHr+YUkErvoTp0ZXm7ZQOQmOhkVBD0LbdqaxBdFqDyM8by9Vkvvs5hRE+t4zF
         E58/9EBts6ZjVFq83pthyRyXj96wuR0kCUqNw9bD/3Qp2heiqjp/R5LnYK9o5rerZ8ah
         4zCXdhhoFJ9pI9pLUxzxWkRTyzrS5X4icm/pkKgeNtRXLb4zfhwBFCC4Tu7oN8Pq7iZT
         ybhSrjgVZ1a4X1MZl77+boDoehpAOK6skgDB+yWo1n2Pv5r0WrlVF+IP69TzQj2OgiSn
         vOHlXZ22g4jd68m5U+tH5fQTcog8Q/D0simKzcwwNG1vX+ddzjZJDyl6g94LCdB9Fhgn
         4Gzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:from:reply-to
         :references:cc:to:content-language:subject:user-agent:mime-version
         :date:message-id:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=p0FXx0MqoXM7qRnrNL7t4EmZOdwWs5pyFYPwTCmqmp8=;
        b=SOCdwEqEd9Kf/EejI/U2WgxuixgsaeAloWazn1NdwVY7J4clsav8iqhAlyNqgMH56Z
         uVJGN2DIcQStjhfVV20d7m2n1LR5MpGIMWdkC0aF688FGSlELbJH1esyW8xwyDBHkpSL
         e5E+k0q4vaS+oVOkirWFcDpkeruPnAM3g5FXxqOgjBQdlaUdVqx9akdxIURsIwnydCRH
         923NR2qB+HIAiKKk79ukHH40z1GEU3Lht7uyMIjpsNpSQFza+6NSGXTINPiMRa0FwLzv
         kSIy7j76XZRsSAqearKUF4jchsDcegApXsg8DmnizbTBWdc3OWgMJ7wVENEJgUQmzS1L
         R1tg==
X-Gm-Message-State: ACrzQf2Hzzy0fXwDIkYfv7QYGH3EuaX5gd0qDsxotkmVcL+FiEqVPy0k
        bLOeX6t3Lxd3kYjZUx1LQSu+nQ==
X-Google-Smtp-Source: AMsMyM79iWwqi/ZdX86WcBF8m+9LIVpOvaXTTX10eniKQTWKsRPtL4ktZrtP+JqyWFKuKjwzlE1gEw==
X-Received: by 2002:a05:600c:22c8:b0:3c4:3c91:6c6c with SMTP id 8-20020a05600c22c800b003c43c916c6cmr23568351wmg.139.1666100736938;
        Tue, 18 Oct 2022 06:45:36 -0700 (PDT)
Received: from ?IPV6:2a01:e0a:982:cbb0:7fad:ace8:cda6:d900? ([2a01:e0a:982:cbb0:7fad:ace8:cda6:d900])
        by smtp.gmail.com with ESMTPSA id u12-20020a5d6acc000000b0022ae0965a8asm10810747wrw.24.2022.10.18.06.45.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 18 Oct 2022 06:45:36 -0700 (PDT)
Message-ID: <0641baae-0904-f9ac-e612-6fe0783a06ea@linaro.org>
Date:   Tue, 18 Oct 2022 15:45:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.1
Subject: Re: [PATCH 4/5] arm64: dts: qcom: sm8350: Add GPI DMA compatible
 fallback
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Vinod Koul <vkoul@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, dmaengine@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Richard Acayan <mailingradian@gmail.com>,
        Melody Olvera <quic_molvera@quicinc.com>
References: <20221015140447.55221-1-krzysztof.kozlowski@linaro.org>
 <20221015140447.55221-5-krzysztof.kozlowski@linaro.org>
Reply-To: neil.armstrong@linaro.org
From:   Neil Armstrong <neil.armstrong@linaro.org>
Organization: Linaro Developer Services
In-Reply-To: <20221015140447.55221-5-krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/10/2022 16:04, Krzysztof Kozlowski wrote:
> Use SM6350 as fallback for GPI DMA, to indicate devices are compatible
> and that drivers can bind with only one compatible.
> 
> Signed-off-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> ---
>   arch/arm64/boot/dts/qcom/sm8350.dtsi | 6 +++---
>   1 file changed, 3 insertions(+), 3 deletions(-)
> 

Reviewed-by: Neil Armstrong <neil.armstrong@linaro.org>
