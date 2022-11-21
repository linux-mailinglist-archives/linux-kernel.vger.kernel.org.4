Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A269B631DB2
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 11:07:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231234AbiKUKHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 05:07:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44302 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231327AbiKUKG6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 05:06:58 -0500
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0DA2A8C20
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:06:48 -0800 (PST)
Received: by mail-lf1-x133.google.com with SMTP id p8so18032234lfu.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 02:06:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=TJ3fUCUUb4OgK9EIYnGNYb2aW+q1y80Ga6j52JMMJAc=;
        b=Xx2EducX5SPjuGROun0fLcpuu4E54+3fEQ/7B+Cg8AQUFChFSn4ryJwAxgXT+lp2Xz
         iY836XuBd/5SXPPAGcRlIuP0kV3vGWHDZFY4zOX0xUJCisGwfBYW3MjUPLJ/0nUeeN66
         8K+leADfXog+TnCtYU1FnAwboiB0SGqePOQm4UJzkEjAN+asDlUltMsmfoJr9Je7Qbyn
         exXHDz8LjavgNNcHsU/ing/38onBvf2UMaS49d0i222buupMvpIIu/dfQ7M0RfUaR3l2
         n794cji7zB3aUUxDMdAjmXyYsyHR3q1TrtTehbVVO6dZGbEYQ8eEXzza1rHDgNJOgQdO
         wGaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=TJ3fUCUUb4OgK9EIYnGNYb2aW+q1y80Ga6j52JMMJAc=;
        b=FSIiUqbDR+QU3aD/w9bhtfQmdNDq5NOkDhUjc4v3nr/H+bcWxGq6Ps1A2ZQ99luYZa
         mWQUSh04rwHGVK+ENLk7SmWY9HXVSbicuR+dNlhrNHCJeCsppCLHB4T2Ul1X87TOymO0
         Ge8E/tmTM+n+lSdWotjkz2QFCZyK5JJ2cODcE4g5yGfWC+cFoUJ3QScBOS5+2nzDJHCD
         WLaDp7oZcpmiu/mIWIj+9Ew8iDCKvj0Yjbnw8gUtd6hdmeDIlQ+kMcnepvwjcp/sTxlY
         i3MmRur+Vc2KMLzCnpk93lSjdmcfv9JJDHo/WloTVBpupcxFW092XnwODuw7D/vLtfa3
         d97A==
X-Gm-Message-State: ANoB5pnTynZQuuxzdSsM2b4FP/2ODitFKYzTR/7raZ6YebKkRzlNxZlX
        UNxrvJCS92iR7n4ZJFqq1UfiZQ==
X-Google-Smtp-Source: AA0mqf6yegrrfLUd9Kkr39MLPBDY3UK6Wwsg4plewaXrhUazKl3rp8YGGCyidHD4+Qtk66F/cuVH2A==
X-Received: by 2002:a19:7b1d:0:b0:497:9e0d:183 with SMTP id w29-20020a197b1d000000b004979e0d0183mr6323597lfc.537.1669025207058;
        Mon, 21 Nov 2022 02:06:47 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id d14-20020a056512368e00b00494706193adsm1976191lfs.208.2022.11.21.02.06.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 21 Nov 2022 02:06:46 -0800 (PST)
Message-ID: <98005150-83a7-5439-0db1-d93d459c3809@linaro.org>
Date:   Mon, 21 Nov 2022 11:06:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 2/3] dt-bindings: timer: sifive,clint: add compatible for
 OpenC906
Content-Language: en-US
To:     Icenowy Zheng <uwu@icenowy.me>, Marc Zyngier <maz@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Jisheng Zhang <jszhang@kernel.org>,
        Samuel Holland <samuel@sholland.org>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-riscv@lists.infradead.org
References: <20221121041757.418645-1-uwu@icenowy.me>
 <20221121041757.418645-3-uwu@icenowy.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221121041757.418645-3-uwu@icenowy.me>
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

On 21/11/2022 05:17, Icenowy Zheng wrote:
> T-Head OpenC906 is a open-source-licensed fixed-configuration of C906,
> which is now public and able to be integrated.
> 
> Add a compatible for the CLINT shipped as part of OpenC906, which should
> just be ordinary C9xx CLINT.
> 
> Signed-off-by: Icenowy Zheng <uwu@icenowy.me>
> ---
>  Documentation/devicetree/bindings/timer/sifive,clint.yaml | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> index aada6957216c..86703e995e31 100644
> --- a/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
> @@ -35,6 +35,7 @@ properties:
>            - const: sifive,clint0
>        - items:
>            - enum:
> +              - thead,openc906-clint
>                - allwinner,sun20i-d1-clint

Add entries sorted alphabetically. This should be squashed with previous
patch.

Best regards,
Krzysztof

