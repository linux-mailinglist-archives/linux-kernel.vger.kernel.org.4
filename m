Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63FF0625E24
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 16:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233369AbiKKPSr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 10:18:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234196AbiKKPRy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 10:17:54 -0500
Received: from mail-lj1-x235.google.com (mail-lj1-x235.google.com [IPv6:2a00:1450:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3617577203
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:17:32 -0800 (PST)
Received: by mail-lj1-x235.google.com with SMTP id d20so4824381ljc.12
        for <linux-kernel@vger.kernel.org>; Fri, 11 Nov 2022 07:17:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=kBeLtt806xuAVLanhVYNh3Yb8OkYSIv62TYrl3SBTCg=;
        b=NpUQ1k7cnJ6Y+btt/QCKgUHDvfM24FoMAzrWdP2kHUVvRcdX39YHGWI7RhlKIvRtfY
         Fvqc7DfeHIZB8nWuKjzVacMTbB2q+eUW9FbYki/rYpF4RyhNkou+OrxE2fVthb+90zff
         SvYuUeqT8TsFNm2OjorlexvawJkgedmJLil4EPu38CXdFZT14sPIptQw7tjp601UWDR8
         EkkjcVXQ5zQcFoVBp9VoZQcI3pBz+Yx2wUmaUJ9HZsF3wNPzDgEn4ryA2hMYlxK4OT3j
         LchupSZEtoaB1SoYHnaKv6t3WOwqGv1KFGsDAevEHy3Jls7iYNJCVYxI+QwB+FUNr2mq
         xWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=kBeLtt806xuAVLanhVYNh3Yb8OkYSIv62TYrl3SBTCg=;
        b=N2PyUPKqxD8ZFxy2ISJR+xcuc8NwK179ROV12gkGuvbKPS8UDGu0Imy6uzXwCJ0Scl
         BSDqEwIDIPM1pfhMaNJWqLyIhH5SqSXp40587dS7m7erIU8rpgqjs0Tc/1v1/ie4Y4CX
         5oqvv/ql1AnlwcaCRdl7Dds6aDvyK1HB3GAMfoNRzBOFvNwAQ2StZK/bvOoh+y5IeCcO
         jdtcveO9djcTaWvMk8O1kwLpi2FSrFpW+f5DZv33SC0SA4cfKwDpSLPGVqu2yE3ScEsm
         mEQpsyGO7xmQORkKCghDxQmkxGu3WzGXDxdoaBASCCsjOeKSOsC7ZAr1poKznvdMBbdM
         tPMw==
X-Gm-Message-State: ANoB5pnsmbnZM9hr76nqwRF1q1uBn3H5bxEEtNpaJxITYqaMCTYzijgT
        NTYlznFtxX6eaxD5DmCAXQH0NBK7VWpSqA==
X-Google-Smtp-Source: AA0mqf67yeOajmW2PCp/0xsLFqXNEMXfRV/CNsGFNrg6CE4V6sENMpCjMFr1JbX99+cv2DrS5QSDSw==
X-Received: by 2002:a2e:9ec2:0:b0:277:2600:9cc0 with SMTP id h2-20020a2e9ec2000000b0027726009cc0mr797972ljk.437.1668179850436;
        Fri, 11 Nov 2022 07:17:30 -0800 (PST)
Received: from [192.168.0.20] (088156142199.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.199])
        by smtp.gmail.com with ESMTPSA id d8-20020a056512368800b0049110ba325asm367089lfs.158.2022.11.11.07.17.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Nov 2022 07:17:29 -0800 (PST)
Message-ID: <a22888cd-34cb-3453-0dc2-096da208564c@linaro.org>
Date:   Fri, 11 Nov 2022 16:17:29 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 02/14] dt-bindings: phy: qcom,qmp-usb3-dp: fix sc8280xp
 bindings
Content-Language: en-US
To:     Johan Hovold <johan+linaro@kernel.org>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221111092457.10546-1-johan+linaro@kernel.org>
 <20221111092457.10546-3-johan+linaro@kernel.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221111092457.10546-3-johan+linaro@kernel.org>
Content-Type: text/plain; charset=UTF-8
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

On 11/11/2022 10:24, Johan Hovold wrote:
> The current QMP USB3-DP PHY bindings are based on the original MSM8996
> binding which provided multiple PHYs per IP block and these in turn were
> described by child nodes.
> 

Thank you for your patch. There is something to discuss/improve.


> +
> +maintainers:
> +  - Vinod Koul <vkoul@kernel.org>

Maybe you want to add also yourself?

> +
> +description:
> +  The QMP PHY controller supports physical layer functionality for a number of
> +  controllers on Qualcomm chipsets, such as, PCIe, UFS and USB.
> +
> +  See also:
> +    - include/dt-bindings/dt-bindings/phy/phy.h
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sc8280xp-qmp-usb43dp-phy
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    maxItems: 4
> +
> +  clock-names:
> +    items:
> +      - const: aux
> +      - const: ref
> +      - const: com_aux
> +      - const: usb3_pipe
> +
> +  power-domains:
> +    maxItems: 1
> +
> +  resets:
> +    maxItems: 2
> +
> +  reset-names:
> +    items:
> +      - const: phy
> +      - const: common
> +
> +  vdda-phy-supply: true
> +
> +  vdda-pll-supply: true
> +
> +  "#clock-cells":
> +    const: 1
> +
> +  clock-output-names:
> +    items:
> +      - const: usb3_pipe
> +      - const: dp_link
> +      - const: dp_vco_div

Why defining here fixed names? The purpose of this field is to actually
allow customizing these - at least in most cases. If these have to be
fixed, then driver should just instantiate these clocks with such names,
right?

Best regards,
Krzysztof

