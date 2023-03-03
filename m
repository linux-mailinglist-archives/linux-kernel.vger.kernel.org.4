Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 896D66A94B9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 11:03:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229771AbjCCKDX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 05:03:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229615AbjCCKDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 05:03:21 -0500
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BEEA59CE
        for <linux-kernel@vger.kernel.org>; Fri,  3 Mar 2023 02:03:19 -0800 (PST)
Received: by mail-ed1-x536.google.com with SMTP id ay14so4397742edb.11
        for <linux-kernel@vger.kernel.org>; Fri, 03 Mar 2023 02:03:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677837798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WGynNVbD7bhkWPwRtuZIYOHNAiw3+RAyPRyR/rq0hI8=;
        b=VjgNgQ+PXlb5wUU5dejz2Qxr4CGfcx/bQdtSCAQdAMhZdnOzBw0J3daRW72B7iJxpZ
         ajjqZmYGkvzf2QBKSq2mnQDMQVLU7N5EagsBph+MHzrcT8iliCj7OxzRobdSc8Mt/RPl
         AoG1Qm/RoBpAaw6JfnYzhbrgSNqY14CQL3FVtEnoeg52uvlxp1rRextD7Sn/lPcAWaNf
         YgPE6em9pkE+NAdNnPWcgmRl08zrVjv9I1SZ7FiJ7ucKhaSiwlPuyLvKmIp94GRi5MRD
         Ts5tzXE8Eyv4r9rz6vwc1FNqa3uZfs77mYTgc3SYNDCEnpFhFYUNuTAvLsOhYufbb+Dg
         EETA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677837798;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WGynNVbD7bhkWPwRtuZIYOHNAiw3+RAyPRyR/rq0hI8=;
        b=rNid8Mz21lUFEZVGcpSFg3sgzyEK3hgGxFqgPGSdo9St8yLTlo0YeqaXckYg/7hBto
         7CuJfd6j7nJxd5h8PrkX+zeoILWI4vD/tjiSHA4iqdfkD7eRsjwlvCCwoQ1RbAvtw1r1
         kiO2TeATx3fGX5a3rRs4tjvndzUm6CGcUpHYED8+I7sXekgR6HvcWGMkcdcZiPPmoXoG
         k4f7f2EXQsdYMoplPjoeA3c0dLzbxuyePab0oSCqOLI0uDW/zw4oO5JyhcT6H2Y86k9T
         l4IfjPtngriOV1yEHun70U2YbU9iLY4gpSEBBUjwvhUZ6KsgxGwGxlJa5EESl30yIHgO
         Wpfw==
X-Gm-Message-State: AO0yUKXbeOWVuJ36wrMpmhgYPGWvsTexzbSiBkryt1cYEn81GCnZHy/f
        nu/WpkEbM4js2xVic7k9LX2nRQ==
X-Google-Smtp-Source: AK7set+f5KN1QCsYanUNAi4iOL3ckk1ezCxnW6vJXk9YRqpogTv4LrmnjTkEvCsDrXYw6ylDPdbgMw==
X-Received: by 2002:a17:906:207:b0:8f3:8bfd:a8e with SMTP id 7-20020a170906020700b008f38bfd0a8emr1029393ejd.26.1677837797763;
        Fri, 03 Mar 2023 02:03:17 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o6-20020a17090611c600b008b17eb06282sm770154eja.213.2023.03.03.02.03.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 03 Mar 2023 02:03:17 -0800 (PST)
Message-ID: <0b8adbf1-aae2-e773-1c11-5d8de0c54b8a@linaro.org>
Date:   Fri, 3 Mar 2023 11:03:15 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 8/9] dt-bindings: crypto: fsl-sec4-snvs: add snvs-lpgpr
 support
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        herbert@gondor.apana.org.au, davem@davemloft.net,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        horia.geanta@nxp.com, pankaj.gupta@nxp.com, gaurav.jain@nxp.com,
        shawnguo@kernel.org, s.hauer@pengutronix.de
Cc:     kernel@pengutronix.de, stefan@agner.ch,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Peng Fan <peng.fan@nxp.com>
References: <20230301015702.3388458-1-peng.fan@oss.nxp.com>
 <20230301015702.3388458-9-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230301015702.3388458-9-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/03/2023 02:57, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> Add snvs-lpgpr support for fsl-sec4-snvs
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  .../bindings/crypto/fsl-sec4-snvs.yaml        | 19 +++++++++++++++++++
>  1 file changed, 19 insertions(+)
> 
> diff --git a/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml b/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
> index 1a4b4975e1d9..688057ec5c97 100644
> --- a/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
> +++ b/Documentation/devicetree/bindings/crypto/fsl-sec4-snvs.yaml
> @@ -124,6 +124,25 @@ properties:
>        - compatible
>        - interrupts
>  
> +  snvs-lpgpr:
> +    type: object

Why not ref to that binding? Much less code...

Best regards,
Krzysztof

