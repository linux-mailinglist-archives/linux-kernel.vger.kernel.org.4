Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8A56E1DB6
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:01:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229947AbjDNIBF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:01:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45996 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229625AbjDNIBC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:01:02 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A7ED610E2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:01:01 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id jg21so43230484ejc.2
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:01:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681459260; x=1684051260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uj24E0utItoUj+eQLTC83uT9r1QSYEGR8TG8+GQ0L+o=;
        b=GcPL057XYpipwF4+iBqYzZ1J5xhLB+5K+M+EuKVsxXtSi59foLRiM+JtVNK+nt1Feh
         b3AttSE8tWSI5gizSo07QQu2UDGjiXZc+sxlfeoSOc05YSgnxdxbHeO0M7d5hNWVQ05t
         5/ckfvwNXR5C6kbrkP1PgN3sz5Ach5Y8vOQggId/xrlyFxc5oY/atvWKAmYqUdaAc8FR
         53gVoNfNQvUUI/HloYdr09F83g+fOw5V1rGAAaJ7QluHyGF8F20GkUNFePVIJmS0v0dU
         pRMAov2UBVimTOcmlx5nky8B1VWzoQgK111fPPQGb/4EqdUChxy4CRhOgtHcxotXmeYH
         c+6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681459260; x=1684051260;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uj24E0utItoUj+eQLTC83uT9r1QSYEGR8TG8+GQ0L+o=;
        b=AeJPh7SV55rzPS/T6bJmeFSJkAajG4Kwnw5WQdTjk2T/z5gM2QUk3DU/ImvdoGy32T
         +4mSGQcik/F4jVVg5Kg1ZnvXsX/vqEMNHw5ECuFG9ZXEIbQnzYJ6+pwAUrf5SJBuhQGu
         nv65hRKT1k8CmAg6czCa2BtEw7VHTtQk7amC1a2VA1PymBiyCPeCIFe3g3Zyhmenj1hS
         Um2DJndn/mxE+odh65h39PSG35E1JH25Yq1vRjW66IvKAfSZ/cKeuOqACU1y+lrE7Wm0
         y6dgwtNbkZQppar6sP/amSPcw2N158xDQ1M1fLVoPn6amlzLc+SnVx5JvTRyK7fvC86v
         fKBA==
X-Gm-Message-State: AAQBX9cfpL1ZtIvCwWkwKMJ/9ePOdSW+bOhQ6qpj+vOqqSFgVWMEy3C/
        ny+N2vQrwitGHiAfoWqUZYsGpA==
X-Google-Smtp-Source: AKy350bCXmdaTRCL/M+/LO6/ppWZKpBcQqXzDRpPqeaDbdg5FRk8xkQKylplO4qaCD4qcxjYDUetPw==
X-Received: by 2002:a17:906:37c2:b0:8b2:c2fc:178e with SMTP id o2-20020a17090637c200b008b2c2fc178emr4972329ejc.74.1681459260184;
        Fri, 14 Apr 2023 01:01:00 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8a60:6b0f:105a:eefb? ([2a02:810d:15c0:828:8a60:6b0f:105a:eefb])
        by smtp.gmail.com with ESMTPSA id q13-20020a1709066acd00b0094e44445f30sm2049063ejs.215.2023.04.14.01.00.59
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 01:00:59 -0700 (PDT)
Message-ID: <083e67e6-3e9f-27fe-64c9-431541c943e8@linaro.org>
Date:   Fri, 14 Apr 2023 10:00:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [RFC PATCH 3/5] dt-binding: can: m_can: Remove required interrupt
 attributes
Content-Language: en-US
To:     Judith Mendez <jm@ti.com>,
        Chandrasekar Ramakrishnan <rcsekar@samsung.com>
Cc:     Nishanth Menon <nm@ti.com>, Vignesh Raghavendra <vigneshr@ti.com>,
        Andrew Davis <afd@ti.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        Schuyler Patton <spatton@ti.com>
References: <20230413223051.24455-1-jm@ti.com>
 <20230413223051.24455-4-jm@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230413223051.24455-4-jm@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/04/2023 00:30, Judith Mendez wrote:
> Remove required attributes for interrupt and interrupt names
> since some MCANs may not have hardware interrupt routed to A53

Like which? Can you give specific model names?

> Linux.
> 

Use subject prefixes matching the subsystem (which you can get for
example with `git log --oneline -- DIRECTORY_OR_FILE` on the directory
your patch is touching).

It's dt-bindings:


> Signed-off-by: Judith Mendez <jm@ti.com>
> ---
>  Documentation/devicetree/bindings/net/can/bosch,m_can.yaml | 2 --
>  1 file changed, 2 deletions(-)
> 
> diff --git a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> index 67879aab623b..43f1aa9addc0 100644
> --- a/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> +++ b/Documentation/devicetree/bindings/net/can/bosch,m_can.yaml
> @@ -122,8 +122,6 @@ required:
>    - compatible
>    - reg
>    - reg-names
> -  - interrupts
> -  - interrupt-names
>    - clocks
>    - clock-names
>    - bosch,mram-cfg

Best regards,
Krzysztof

