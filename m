Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAE84629506
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 10:58:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232880AbiKOJ6b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 04:58:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237821AbiKOJ6X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 04:58:23 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12DFF22B0B
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:58:22 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id b3so23616992lfv.2
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 01:58:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6juo/G7lsQvTKk0wwfl/N9U9Zrf2YS9a6XxIt2w0Gz4=;
        b=Wehg82bsZeGgL44LnWaLKYNuB7qTx/GrZyqn00wtkPxp1Af2/5Xez9E68dlhiHh30A
         Qp2Tf+tBvu/HHAbGjX+BbvZo5lYjEF+UxPXkiAREzX5UG3fW9JPAKGzkUFsgrIhjzNH+
         u00dz4b9InlHCrYL6+VtIi76gQYLRsDhbtZ07PS7prBJUzCQQlex8s1PQ2qE3J0KySEy
         WM9YBLig2uO9dICchdYjkQ7leE3wo3xQPKKiNUXN2p3+391hcOyOvWQJzsqukONWXqhN
         yvGrwUNQkaMrpLaBB3Vz+GccTrTsgaWbdnAGk67rEOTtCX0RMiOjEBdSJq48k8n9CU/M
         U7Iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=6juo/G7lsQvTKk0wwfl/N9U9Zrf2YS9a6XxIt2w0Gz4=;
        b=0ZTiAKeZk6eXLbu2n8sH8Gc2xg4erVdYrNXRjpeWiLrTOvWlZwk0eXshpYO0M/+m7X
         y2KT+va40971PFdz0KCZqEKKbWlC+Ogvs8LYiOt83wTKzrglQGms4xYd22+Nu1r6Ydz9
         dvU6kE9Dya2PkQi57sngei6Y+/p2UTEAemXhecbvP4TvFk+R5jEOHc80rCin7fx4JxCL
         2cToD6Pvs2ADY8acZLsEp1v1lUU3cL/FIf76xZWQLvu2hcUU0bY8ZpEQI0w7WODM+Gck
         4nq5eZveucCy3dTnNiK24LEFZKdk6UBZrMK+WcUlbIzODwmF3kNasj6XMbmRiPh7N4qA
         RN8w==
X-Gm-Message-State: ANoB5pkbrY49zplYXhWke9MCsmhiApMJMcBsZdzF0YsdsJHOEaXxF97q
        3cehpRi9uxXQ9ohCdwUX2MK+Dg==
X-Google-Smtp-Source: AA0mqf5ZDNZjWdGk7sBPAGwBXO0zxQiHOKP9nStDRm0y7OArlh4UHkBE1J+m5ZYnT1T8HbqaDP5o+g==
X-Received: by 2002:ac2:55a9:0:b0:4a4:6256:a888 with SMTP id y9-20020ac255a9000000b004a46256a888mr5067978lfg.46.1668506300450;
        Tue, 15 Nov 2022 01:58:20 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id i25-20020a2e8099000000b0026bca725cd0sm2436205ljg.39.2022.11.15.01.58.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 15 Nov 2022 01:58:19 -0800 (PST)
Message-ID: <168ed6e6-21bf-f034-504e-6da36842f4bc@linaro.org>
Date:   Tue, 15 Nov 2022 10:58:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 3/3] dt-bindings: gpio: Add Nuvoton NPCM750 serial I/O
 expansion interface(SGPIO)
Content-Language: en-US
To:     Jim Liu <jim.t90615@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>
Cc:     JJLIU0@nuvoton.com, KWLIU@nuvoton.com, brgl@bgdev.pl,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, openbmc@lists.ozlabs.org
References: <20221108092840.14945-1-JJLIU0@nuvoton.com>
 <20221108092840.14945-4-JJLIU0@nuvoton.com>
 <CACRpkdb+Bkwa8yCKGtRcsJ6KnJh+RUuz_gOrQV63pcYQLaHCaw@mail.gmail.com>
 <CAKUZ0+GCf_Zv=VhnY5Z=yYAfR1=_ha98BVVxRGVy8ui6so_Yrg@mail.gmail.com>
 <CACRpkdYW0P8gqtGdiRX_frP32WF2W=NVg1JTu1fVMBXxEL0-WA@mail.gmail.com>
 <CAKUZ0+Hy5suFg9VZ8-+cH7kGc5KLqUnf9hjnT+iaw+a1HF8x0A@mail.gmail.com>
 <CACRpkdYbS_syVwgc=YndkV-DpEF0K8NpH6WzP=g0AFpN+OTN8A@mail.gmail.com>
 <CAKUZ0+FD=x8s+vqUpYwsuRUw-yTHQjtTFzWDwW=d4k8X1x1LoQ@mail.gmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <CAKUZ0+FD=x8s+vqUpYwsuRUw-yTHQjtTFzWDwW=d4k8X1x1LoQ@mail.gmail.com>
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

On 15/11/2022 10:21, Jim Liu wrote:
> Hi Linus and Krzysztof
> 
> Thanks for your understanding and your suggestion.
> I will follow your suggestion to modify the yaml file.
> -> nuvoton,input-ngpios = <...>
> -> nuvoton,output-ngpios = <...>
> 
> And I don't think the node name needs to use gpio.
> because it's not a general gpio, so I reference aspeed dts and use sgpio.
> Could I use the sgpio node name or could you provide some suggestions?

Aspeed DTS has poor code readability (not following several common DT
conventions), so using it as an example or argument is not correct
approach. Nodes have name "gpio" for GPIO controllers or one of
pinctrl.yaml for pin controllers.

Best regards,
Krzysztof

