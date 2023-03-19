Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33EAA6C01B6
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Mar 2023 13:45:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230203AbjCSMpe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 08:45:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbjCSMpa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 08:45:30 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92337CA29
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:45:22 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id er8so25246555edb.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Mar 2023 05:45:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679229921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2qlgbiw3Sb6++QsdHl2qUbuhVQ07WmikeLyvHR4RN2Y=;
        b=aGe7uAclUwzXTgHZ9/NAUe0MJQUqpOP0ZA3cHQwR+KlrS+x/4dFtfPwsBKlV03nGqw
         8SHHpm4E3GiAW9WTHPMGJ8dbvvKE8LIDGLHi8y4gMNV9ebaLg6bfamLBOM91pTEgWugc
         TJ2ibKtAQpKwkBdeG7tsiRRkHLK5uedpgKhLIvk7pksQ/5D0HXvB9IcrsUsmZp2WU13N
         7uDzmtAJIDJCkNKWi2C8d4udXSvZoF6Ytvqa+eSeREkB90sWe0S9qzJn+x8CaEamvN31
         Q7D+uX9y14RTbEJSW/UxUr1c4nlrpGt/JFj6RzSg2g6HLFPqpZRP0DyB2WFDyvrKXZ5W
         3O8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679229921;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2qlgbiw3Sb6++QsdHl2qUbuhVQ07WmikeLyvHR4RN2Y=;
        b=VDZWdaIxMJycelBWJi5parImsgdtPshGNE2GeDasdgrQdovdJ6injL+RQhVUqfmivJ
         /KOjVXjW6ZcqDGh9dytH5gHGeeaMFLl1Y7+VZl+25V1w+6AFpb3oFx93nPcG4CyLyj46
         hVxGf1NZxVZ3zty3oVB1v6McHKgeZSogaAMeHSMkjc/SaG3uoDhc5Gp5CK0ceLK7xChw
         J5+EzJ1H490mxCl2yKo996wrgTGDToYh2dWLyN4WkAIbfl+cm1z+mnt1VNEXyHvXLndE
         oUEI5RHwB9LvOBIm7rQ5GkugH1XDQNimh0SxcDaajM2Agl+a0pBaYg6RJMfetMXbRNyb
         wbFg==
X-Gm-Message-State: AO0yUKX0MgfMtohltYM4+yD61aNC6kmNk9rMVEtIQgoeU5n4D3m4ufVf
        y79nmqppfuvO9BJFD3Vzl8m6RA==
X-Google-Smtp-Source: AK7set80DrEMa/lVYTlIV0dXi5+5IMVgnmxxBGP5YTtGn4YA8es39AcADqXSwI4aMPr55TmOEstkyA==
X-Received: by 2002:a05:6402:48c:b0:4fb:5089:6e01 with SMTP id k12-20020a056402048c00b004fb50896e01mr9530273edv.6.1679229920763;
        Sun, 19 Mar 2023 05:45:20 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:5b5f:f22b:a0b:559d? ([2a02:810d:15c0:828:5b5f:f22b:a0b:559d])
        by smtp.gmail.com with ESMTPSA id i23-20020a0564020f1700b00500383a202csm3456600eda.6.2023.03.19.05.45.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Mar 2023 05:45:20 -0700 (PDT)
Message-ID: <921520a2-e3b5-7317-669f-a7c94895b34d@linaro.org>
Date:   Sun, 19 Mar 2023 13:45:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: phy: ti: phy-gmii-sel: Add support for
 J784S4 CPSW9G
Content-Language: en-US
To:     Siddharth Vadapalli <s-vadapalli@ti.com>, vkoul@kernel.org,
        kishon@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     linux-phy@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        srk@ti.com
References: <20230315092408.1722114-1-s-vadapalli@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230315092408.1722114-1-s-vadapalli@ti.com>
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

On 15/03/2023 10:24, Siddharth Vadapalli wrote:
> The CPSW9G instance of CPSW Ethernet Switch on TI's J784S4 SoC supports
> additional PHY modes like QSGMII. Add a compatible for it.
> 
> Enable the use of "ti,qsgmii-main-ports" property for J784S4 CPSW9G.
> 
> Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
> ---
>  Documentation/devicetree/bindings/phy/ti,phy-gmii-sel.yaml | 4 ++++
>  1 file changed, 4 insertions(+)

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

