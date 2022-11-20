Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F44631380
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Nov 2022 11:58:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbiKTK6N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 05:58:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiKTK6L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 05:58:11 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A2C18D4AE
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 02:58:10 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id c1so14940913lfi.7
        for <linux-kernel@vger.kernel.org>; Sun, 20 Nov 2022 02:58:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uUXSxOgsLMhzEpNkySjXy0kcuEKDN5qHgUfta7WCO3Y=;
        b=EXVtfntCJeagfksD+ZV0+0lxJVaPUf6tg3iMPra+nz9Idd0OaYGTetInQxd1uLpC0J
         PKeHAk92Y8E5XQZLAYId2FG5jbf6zECdv0o3PvyxGQAk3p/2WgD7B6sR+cui7znJo146
         UzDw7EqWNyzomV3WPrTMX5N4iC9zQ0JqBuRu1ZDI1F3Hk9o2EG2+FfFE/83tvLn5zLIM
         M0PJroW+uWvMRq4SkRjtbuxVwD86JUjo6MSZiXivxF3019exQj1oGdPhZybPs6PZx+Vy
         hIHhhD+6zd5tM7PfOQNa7t/aJGHlqhKEC5nCItw/Glb17jEKiwTqotBSifYJEXbIHey3
         EyVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uUXSxOgsLMhzEpNkySjXy0kcuEKDN5qHgUfta7WCO3Y=;
        b=Jg/RCuA13xTjIqFrd69E8kzWPeyziQGU2InDS7n/qbJjT4SdE2ib1UgJFflJ4PsIIn
         96NN1XDTWtwuj8+MQCi9uzAs+7JeG6BeGHYxitd6dTuQSByVTfYxB2X+ikAjez4P+Yop
         LcopbmDb9Zg8Jm42kRB7m8ZIAYJ9qtXuNsSLPnAKhj49zh6j8ch+vz5BRd2vnk7eDkML
         IegiLop2aBrCwXFh/Re1E0zGjiqYSIz65dRQcFQhwZUQ/oLhOVe1EN+M+/UeK1rdpHp4
         ZRugV3UeLZruoap0vuOlLfedZcChxjXhhwYTG50nv9D6trHj27acgKGkzXwM5NTPlKQ7
         L2/g==
X-Gm-Message-State: ANoB5pnfj4QiCs0sxuiitDuJpifRQYfhLGkV2vhDViSQpqjypEQmN0GN
        gms8ZFOwik7aF/F+IxyJcUQzXQ==
X-Google-Smtp-Source: AA0mqf4Mu65ldzDouhPwdjiSlJOg3hhY43q41zeKYBqg+S5wU0FjJx/xB5x5rYnFAP77xZ7jB/3z5g==
X-Received: by 2002:a05:6512:3ca4:b0:4b4:b5c2:647c with SMTP id h36-20020a0565123ca400b004b4b5c2647cmr4574684lfv.42.1668941888449;
        Sun, 20 Nov 2022 02:58:08 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d20-20020a056512369400b004a2c3fd32edsm1486897lfs.144.2022.11.20.02.58.06
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 20 Nov 2022 02:58:07 -0800 (PST)
Message-ID: <528648f2-17df-ab19-8ad4-76423bbc0ae4@linaro.org>
Date:   Sun, 20 Nov 2022 11:58:05 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v4 1/2] dt-bindings: pinctrl: qcom: Add QDU1000 and
 QRU1000 pinctrl
Content-Language: en-US
To:     Melody Olvera <quic_molvera@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221118182039.29236-1-quic_molvera@quicinc.com>
 <20221118182039.29236-2-quic_molvera@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221118182039.29236-2-quic_molvera@quicinc.com>
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

On 18/11/2022 19:20, Melody Olvera wrote:
> Add device tree bindings for QDU1000 and QRU1000 TLMM devices.
> 
> Signed-off-by: Melody Olvera <quic_molvera@quicinc.com>
> ---
>  .../bindings/pinctrl/qcom,qdu1000-tlmm.yaml   | 134 ++++++++++++++++++
>  1 file changed, 134 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
> 
> diff --git a/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
> new file mode 100644
> index 000000000000..cb0c496d8666
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/pinctrl/qcom,qdu1000-tlmm.yaml
> @@ -0,0 +1,134 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/pinctrl/qcom,qdu1000-tlmm.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Technologies, Inc. QDU1000/QRU1000 TLMM block
> +
> +maintainers:
> +  - Melody Olvera <quic_molvera@quicinc.com>
> +
> +description: |
> +  This Top Level Mode Multiplexer block (TLMM) is found in the QDU1000 and
> +  QRU1000 platforms.

It's better to keep consistent style which allows to do easy
search/replace, than to have new files using their own sentences. So
keep it the same as was unified in few recent commits.

> +allOf:
> +  - $ref: /schemas/pinctrl/qcom,tlmm-common.yaml#
> +
> +properties:
> +  compatible:
> +    const: qcom,qdu1000-tlmm
> +
> +  reg:
> +    maxItems: 1
> +
> +  interrupts: true
> +  interrupt-controller: true
> +  "#interrupt-cells": true
> +  gpio-controller: true
> +
> +  gpio-reserved-ranges:
> +    minItems: 1
> +    maxItems: 75

Technically you can have up to 76 separate ranges (151 GPIOs).

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

