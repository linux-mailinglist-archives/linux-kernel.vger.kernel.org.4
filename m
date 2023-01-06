Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73E5365FE20
	for <lists+linux-kernel@lfdr.de>; Fri,  6 Jan 2023 10:41:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232445AbjAFJkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 Jan 2023 04:40:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233386AbjAFJjb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Jan 2023 04:39:31 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D6458817
        for <linux-kernel@vger.kernel.org>; Fri,  6 Jan 2023 01:32:01 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id m8-20020a05600c3b0800b003d96f801c48so3147294wms.0
        for <linux-kernel@vger.kernel.org>; Fri, 06 Jan 2023 01:32:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=v982tKjruzjnEGR+qtBvwCfxbuiittS57VqGvWmNxEA=;
        b=xaCDj00Zx5JE+B4HrORfAr0IUeuE5ge23LPipHcZiC+zhR+ezzDiRV+IkbNT1CNAfz
         rcZpOyT+Fjty9jGTicbtHTPGVD6+xBAHsPfRj7SmGkCbqgYflh6KN0ngzQiHkZ/wb0g2
         GQwNtJiRUz9XyhjzUb4XRYeJXa/9JHTqgG/f+6ZMzLL5EV9512q02xKq0HL9ZrKmbdZo
         qIf8MnF2ucYuTihFjPM26qK+eqI35YBoIWuZGBJN6rDpvJLAJAOqN2ynjxDf85eUp+9L
         w/mouXYO4yJKgYvCtgK5fOo2+VuFObrE8U8Z4zW0W4w58uztuEn9Gk10ZqHfObAvhaQr
         g5bw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=v982tKjruzjnEGR+qtBvwCfxbuiittS57VqGvWmNxEA=;
        b=SCEfsYOSKGDkeR+71xpCp9S+c96XlW8CoWn2Hi68aLcBdHjLLsHB+T4Rcs0+1KVNig
         ZHAOYkCF99calmvNlXJcqVcq6UZAh9YIf/dCiKmeFEj4kDeNosRikS84MYzcWtEEYQT6
         H0anIt/yViwcUnFZeTKsHpoxltpjPHeN1u1caSka96N1+T54KmtDrZir9XFfIJGz8wZK
         1nLTiET6w5j6yV4Y3es7Dob/JECg2aultWEb8Pua87wp5xYweUT16Ovb1WtAkvs1kd0M
         HEwR3vH2nO4q6+iJDDQ0rRVHvbGV94ZlbrJ1e5NkaxKSsAxtmGUdpId2bJKE19xiPCbi
         tcCQ==
X-Gm-Message-State: AFqh2kohpu7Acbv736QC07QEk60S8NISEF8foLX81wnyMMghNN+Gv5oJ
        Tf1fyXpNASmyF5aS5QH8pJrJzH/A/JbemFZb
X-Google-Smtp-Source: AMrXdXvYSLjYzCElzyzK7yhn2iQbRJ2DGluk25DvaH9fz9jVXIzkSfkiBzSZ7TwN2v8AjLBXVXylQw==
X-Received: by 2002:a05:600c:798:b0:3d3:5737:3b0f with SMTP id z24-20020a05600c079800b003d357373b0fmr47719090wmo.36.1672997519650;
        Fri, 06 Jan 2023 01:31:59 -0800 (PST)
Received: from [192.168.1.102] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id iv14-20020a05600c548e00b003b47b80cec3sm6203606wmb.42.2023.01.06.01.31.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 06 Jan 2023 01:31:58 -0800 (PST)
Message-ID: <bb52b82d-5149-c512-ad30-3b993221bd78@linaro.org>
Date:   Fri, 6 Jan 2023 10:31:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [PATCH 1/3] dt-bindings: clock: document SM8550 DISPCC clock
 controller
Content-Language: en-US
To:     Neil Armstrong <neil.armstrong@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230103-topic-sm8550-upstream-dispcc-v1-0-81bfcc26b2dc@linaro.org>
 <20230103-topic-sm8550-upstream-dispcc-v1-1-81bfcc26b2dc@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103-topic-sm8550-upstream-dispcc-v1-1-81bfcc26b2dc@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 14:53, Neil Armstrong wrote:
> Document device tree bindings for display clock controller for
> Qualcomm SM8550 SoC.
> 
> Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
> ---
>  .../bindings/clock/qcom,sm8550-dispcc.yaml         | 106 +++++++++++++++++++++
>  include/dt-bindings/clock/qcom,sm8550-dispcc.h     | 101 ++++++++++++++++++++
>  2 files changed, 207 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
> new file mode 100644
> index 000000000000..06c04656cb55
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8550-dispcc.yaml
> @@ -0,0 +1,106 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sm8550-dispcc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Display Clock & Reset Controller for SM8550
> +
> +maintainers:
> +  - Bjorn Andersson <andersson@kernel.org>
> +  - Neil Armstrong <neil.armstrong@linaro.org>
> +
> +description: |
> +  Qualcomm display clock control module provides the clocks, resets and power
> +  domains on SM8550.
> +
> +  See also:: include/dt-bindings/clock/qcom,sm8550-dispcc.h
> +
> +properties:
> +  compatible:
> +    enum:
> +      - qcom,sm8550-dispcc
> +
> +  clocks:
> +    minItems: 3

Clock inputs should be optional if we can really treat them optional,
e.g. reparent to something else or just adjust list of parents. Since
the driver has fixed parent data, it suggests these are not really
optional and they are all in the hardware (always).


Best regards,
Krzysztof

