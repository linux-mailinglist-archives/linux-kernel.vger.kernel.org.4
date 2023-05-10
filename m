Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 71A556FD7E8
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:12:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236445AbjEJHM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:12:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236438AbjEJHMZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:12:25 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4397040E0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:12:23 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id 4fb4d7f45d1cf-50bc456cc39so10299306a12.1
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:12:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683702742; x=1686294742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZJffLVX+d+kDN0Y0P8K31M8VqJM5JSo1YYMxUDynrsA=;
        b=qkLY7BevynINTMCh8r/9TD1ewtjN4/hlx5zOJKfFWCCA59EQ8EPpuHYR+899VEWQYS
         hp9YFlYAQUERwFDL3IkxfH3uBGL8WH6KUjq+PSwqRqHg5XrXXk4rbzRE9mNspa73c9k1
         wg6hgKQefUHUJF3mvtcF0NLLJsMQyw1t/1vYwFhbakJt2P89WHG1d4fcBcC1XzTerxRe
         W1o7ecxkD+AvL8Z8kavTlHYs+uTc+vclgAaUl3G05IAlUp/lzzr03usJLuZ8D8Q3k9aF
         XiK9YdluJYRVyo8fR8wc+Oe2seKVp7dNIWIecFnRmdlMhUegHpfjfrpb8PRfrGb72BUh
         3vaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683702742; x=1686294742;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZJffLVX+d+kDN0Y0P8K31M8VqJM5JSo1YYMxUDynrsA=;
        b=R6TdDw1ceSsJ0a666lyfycAieyb15T07I+m855P56SCndOt9r04lpYnV4gZCKDIhdD
         xp1aNKfJCDe0H85RLVXLGc5q2xpujZVgySUWI0VHJZFkKV1xLiYyVZfKOL+8yRbiwtPh
         ZbysfJX6DtVBZvgUGLryqqFOgAGxtgGpQ/PKDJWQ3i1i5SvWiTbV9rnmFxVkZAOBK4Su
         77SkemuaBstz/VjJmtdqAkRObZ5i7p8uH2jT9o0a1T0u4bqzQQfsONRfkvHgF14uGb9u
         p9rlLWPqORCRtShk/0wi/FbbQwRRxB0JmQyiZ/RrA3PIARZYAAzWbIjx4+hmHdl4Symh
         WqAw==
X-Gm-Message-State: AC+VfDy8R+ioYu4NvUmHh49iF62JySrCI8QAACe9fL37KAQ7StPyxWuS
        C51B9d52WHgfIN2/jw987wzSAybEp2XTBycAb8w=
X-Google-Smtp-Source: ACHHUZ5Yup2vBnN4XJBf+aPs05GYTt/6L/UNkJC8UP8kGeMs6AQgpMtUBMmANPUKzs1YMaQjjmSA7g==
X-Received: by 2002:aa7:c546:0:b0:509:d476:3a0f with SMTP id s6-20020aa7c546000000b00509d4763a0fmr11928851edr.2.1683702741727;
        Wed, 10 May 2023 00:12:21 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:c175:a0f9:6928:8c9d? ([2a02:810d:15c0:828:c175:a0f9:6928:8c9d])
        by smtp.gmail.com with ESMTPSA id bf18-20020a0564021a5200b004bd6e3ed196sm1532628edb.86.2023.05.10.00.12.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 00:12:21 -0700 (PDT)
Message-ID: <603c177d-07c7-4cb4-da53-0e1a11ee8828@linaro.org>
Date:   Wed, 10 May 2023 09:12:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH V4 1/3] dt-bindings: clock: qcom: Add SM8450 video clock
 controller
Content-Language: en-US
To:     Taniya Das <quic_tdas@quicinc.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        quic_skakitap@quicinc.com, quic_jkona@quicinc.com
References: <20230509172148.7627-1-quic_tdas@quicinc.com>
 <20230509172148.7627-2-quic_tdas@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230509172148.7627-2-quic_tdas@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/05/2023 19:21, Taniya Das wrote:
> Add device tree bindings for the video clock controller on Qualcomm
> SM8450 platform.
> 
> Signed-off-by: Taniya Das <quic_tdas@quicinc.com>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
> Changes since V3:
>  - None.
> 
> Changes since V2:
>  - As per Stephen's comments drop clock-names to match how newer
>    qcom clk bindings are being done.
>  - Change the header file name as qcom,sm8450-videocc.h to match
>    latest upstream header files.
> 
> Changes since V1:
>  - Change the properties order to keep reg after the compatible
>    property.
> 
>  .../bindings/clock/qcom,sm8450-videocc.yaml   | 77 +++++++++++++++++++
>  .../dt-bindings/clock/qcom,sm8450-videocc.h   | 38 +++++++++
>  2 files changed, 115 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
>  create mode 100644 include/dt-bindings/clock/qcom,sm8450-videocc.h
> 
> diff --git a/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> new file mode 100644
> index 000000000000..58e59065bb2a
> --- /dev/null
> +++ b/Documentation/devicetree/bindings/clock/qcom,sm8450-videocc.yaml
> @@ -0,0 +1,77 @@
> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
> +%YAML 1.2
> +---
> +$id: http://devicetree.org/schemas/clock/qcom,sm8450-videocc.yaml#
> +$schema: http://devicetree.org/meta-schemas/core.yaml#
> +
> +title: Qualcomm Video Clock & Reset Controller on SM8450
> +
> +maintainers:
> +  - Taniya Das <quic_tdas@quicinc.com>
> +
> +description: |
> +  Qualcomm video clock control module provides the clocks, resets and power
> +  domains on SM8450.
> +
> +  See also:: include/dt-bindings/clock/qcom,videocc-sm8450.h
> +
> +properties:
> +  compatible:
> +    const: qcom,sm8450-videocc
> +
> +  reg:
> +    maxItems: 1
> +
> +  clocks:
> +    items:
> +      - description: Video AHB clock from GCC
> +      - description: Board XO source

Why the order is different than all other devices? Board XO is always first.


Best regards,
Krzysztof

