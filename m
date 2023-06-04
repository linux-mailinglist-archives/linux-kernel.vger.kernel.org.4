Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B9C07721607
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 12:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229997AbjFDKZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 06:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbjFDKZY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 06:25:24 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B11CB6
        for <linux-kernel@vger.kernel.org>; Sun,  4 Jun 2023 03:25:23 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id 4fb4d7f45d1cf-5149e65c218so5737135a12.2
        for <linux-kernel@vger.kernel.org>; Sun, 04 Jun 2023 03:25:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685874321; x=1688466321;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=YJMkEbWSHnrMMvY5aFflCgy+a09GUp8CaxfqQLYJPe8=;
        b=McBfv3wHyWsk0SGbQ5NzvzBcitJkpkYBCcKhIr4LcsTctO8BBHr9h/hsEhg8Fwk08r
         jxWQO8ouTtG0WQ/67m/YleqKfdsKI8g4SmaRsT2cyy7crwB4kazGiiVxcix7QbzpMnE6
         DK8pL2ch++6vYrfXmnJrYN/juEihCEFhmCTbkAvudj4pc324In23ZX1khGt4c3s2lbpe
         JjT+9JehWk/oLAC+BSlGx3R48D2WhjGidNVcQkpsWiIdAo0V2GgTxD+C4eAw/JvdC54R
         ASeBAQqc2dWC+mVcPjhJ60goUepdbj+uC/u0TWXpZrP/CxVrU0XWRvVEVcT43XLIez7i
         CUjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685874321; x=1688466321;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=YJMkEbWSHnrMMvY5aFflCgy+a09GUp8CaxfqQLYJPe8=;
        b=iFW+/uGc2F3maF1YSyx8B8p3chsOV0tV8Pck8fipfaKR+7z6VRz4KpQExZ6I1eJXaT
         kN8RVfdCiNQqC2SaWfgn/n5u/hsi9KJWKWfIhrcxgWvHko2QRJrnU5/vJZw2Ds0ur/gx
         FWVNR2CoK2ojXCC1ahoOer5z1u1qeH2dL/dtyWIb8Avn+QwsOBfp9ALLax796zbK15EG
         ybbXYZQvnaVC8o1rRqzCZ0aJnz38bdACK6MAss9yhiOf6FYx61BU0D1S3ghwP5a4rwWJ
         zX4vemfceuBv51NNvkSVENCwzb90pxIxOVEunBlbJ9VIaNAQAinkqAeQV6QUJS1o0ZZf
         iNMw==
X-Gm-Message-State: AC+VfDzsGUMEmrLnae2fQH++kgZ9SD1WucNKxHRfNww7wHYx7Ze+ufs7
        XhpsHWLcihmWUdp+mhUpNW88rQ==
X-Google-Smtp-Source: ACHHUZ6fMJ/yHO+vKOlsfo5f9HIUMEEqhsXTkY3yEn808RCHlyky7VTMAEu8r0kM8MxtmIPIP/E1Gg==
X-Received: by 2002:aa7:d405:0:b0:514:ad09:44df with SMTP id z5-20020aa7d405000000b00514ad0944dfmr5493938edq.28.1685874321665;
        Sun, 04 Jun 2023 03:25:21 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id w15-20020a056402070f00b00514bb73b8casm2712792edx.57.2023.06.04.03.25.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Jun 2023 03:25:21 -0700 (PDT)
Message-ID: <6187d1a4-1667-21c5-00ba-4689caa6cac8@linaro.org>
Date:   Sun, 4 Jun 2023 12:25:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 1/3] dt-bindings: reserved-memory: rmtfs: Allow guard
 pages
Content-Language: en-US
To:     Bjorn Andersson <quic_bjorande@quicinc.com>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>
Cc:     linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230530233643.4044823-1-quic_bjorande@quicinc.com>
 <20230530233643.4044823-2-quic_bjorande@quicinc.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230530233643.4044823-2-quic_bjorande@quicinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/05/2023 01:36, Bjorn Andersson wrote:
> On some Qualcomm platforms it's required that the rmtfs memory is not
> placed adjacent to allocations performed by other clients. Some
> DeviceTree authors have solved this by reserving the space around
> the region, but this prevents such author to use rely on the OS to place
> the region, through the use of "size" (instead of a fixed location).
> 
> So introduce a flag to indicate that guard pages should be carved at the
> beginning and end of the memory region. The user shall account for the
> two 4k blocks in the defined size.
> 
> Signed-off-by: Bjorn Andersson <quic_bjorande@quicinc.com>
> ---
> 
> Changes since v1:
> - Drop qcom,alloc-size in favour of using reserved-memory/size
> - Introduce explicit property to signal that guard pages should be
>   carved out from this region (rather than always do it in the dynamic
>   case).
> 
>  .../bindings/reserved-memory/qcom,rmtfs-mem.yaml           | 7 +++++++
>  1 file changed, 7 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
> index bab982f00485..26e24e7b08cf 100644
> --- a/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
> +++ b/Documentation/devicetree/bindings/reserved-memory/qcom,rmtfs-mem.yaml
> @@ -26,6 +26,13 @@ properties:
>      description: >
>        identifier of the client to use this region for buffers
>  
> +  qcom,use-guard-pages:
> +    type: boolean
> +    description: >
> +      Indicates that the OS should ignore the first and last 4k block of the
> +      memory region, for the purpose of ensuring that the allocation is not
> +      adjacent to other protected regions.

Property name and description: do not describe the OS behavior. Describe
the hardware or firmware. Describe the actual problem or characteristic
which will be then interpreted by OS to do what you want. DT is not for
instructing OS what to do.

Best regards,
Krzysztof

