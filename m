Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96AB86BC896
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 09:13:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbjCPINW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 04:13:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231196AbjCPIMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 04:12:53 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1333FB421C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:12:31 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id eh3so4128704edb.11
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 01:12:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678954348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GCiG6dJpmfG/sbbJg8bGZk+CNQ9dVe/ueslAXrzul14=;
        b=OLj7QfyYZwreKo0JtHFnAC9gT9S+F9luw8+lvXjQ50SF24oCO0OLe8cVvVnuU5wB04
         oB0UlPufKyK7rJQ+bOfC9VUz45l00+Nrss4mex2UuaTXBqF5/YBHOBP/wWzn13Kl+hSW
         ZPsnWWLTuDlaj8LAMUBpDW0i1Vm58EtbA7kHVRe44ng6iFraXn3wjS9rKKDE3lRpd5Le
         OajO6/IhcUFhm5Pahg9FJAp+Jwe2isbz68z8r5Z6Zd3F/hXbB04VJb2MhI+ljla6cwLh
         J4dD1bkhFr8PtqJrWsFtUzodV5gMn/+ifbJRmpfxOe/E2McbFgtNql6vuK1g6s9XtfpK
         tdrw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678954348;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GCiG6dJpmfG/sbbJg8bGZk+CNQ9dVe/ueslAXrzul14=;
        b=BkGz5y0tdWV9WKwfkFo8/46Pz+fKUqWEuMZgLDclbMjexlJvZj5z/8o6dJxZnnp4Fp
         geXhBVTOoKC27QCqBcKBxcJgfhe8bMRMMD1DpeLmdP54Dg6ussjDrYYKN44mtbtt9AoZ
         jFblIZjRM1x1vHxJ/aNq69Um3pPbziICJGb5JPh8CGYYUaEbohVRLcdZlMKCx+L/0uc2
         tddqnFiYVqmyyuI/rdrYkFKO/Obdv1jc106+TimO9LIiCqg2i+GcLQ7z0UUctjrctRwp
         zReLSYbR8O7ZK3/DbcXRtte30wnDBcpHMJotz8LrGenqJdaLI4U8WWV7lW2/Zi26sCdQ
         VRvQ==
X-Gm-Message-State: AO0yUKWCcrhuraJnMRxh9BuL2ljbR0bGG0OPwVK8UprP6XQ8QTSuizGh
        6YY2MdzCwFY/7j8reqecTOVVIA==
X-Google-Smtp-Source: AK7set9YahOMys4Z/ysmxCqUAg8miomha6ccdvvx7lfoqZVecUevePrWpO+50TvWbpt/TGyu1U0tkQ==
X-Received: by 2002:a17:906:3156:b0:8b2:7564:dfd5 with SMTP id e22-20020a170906315600b008b27564dfd5mr9344400eje.60.1678954348377;
        Thu, 16 Mar 2023 01:12:28 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id l26-20020a170906a41a00b009260634e25asm3520485ejz.121.2023.03.16.01.12.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 01:12:28 -0700 (PDT)
Message-ID: <411d138a-c3a2-3b99-937f-7436142ac813@linaro.org>
Date:   Thu, 16 Mar 2023 09:12:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dt-bindings: pinctrl: qcom,qcm2290-tlmm: Allow
 input-enable
Content-Language: en-US
To:     Konrad Dybcio <konrad.dybcio@linaro.org>,
        linux-arm-msm@vger.kernel.org, andersson@kernel.org,
        agross@kernel.org
Cc:     marijn.suijten@somainline.org,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawn.guo@linaro.org>, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20230314222705.2940258-1-konrad.dybcio@linaro.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230314222705.2940258-1-konrad.dybcio@linaro.org>
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

On 14/03/2023 23:27, Konrad Dybcio wrote:
> Allow the common input-enable. This was missed with the
> initial submission.
> 
> Fixes: 5147022214db ("dt-bindings: pinctrl: qcom: Add QCM2290 pinctrl bindings")
> Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
> ---
>  Documentation/devicetree/bindings/pinctrl/qcom,qcm2290-tlmm.yaml | 1 +


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

