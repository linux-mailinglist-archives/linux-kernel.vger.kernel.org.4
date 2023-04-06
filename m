Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEA516D9EA6
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 19:23:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239903AbjDFRXG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 13:23:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240060AbjDFRWu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 13:22:50 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE6B1B44E
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 10:22:17 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id lj25so3105767ejb.11
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 10:22:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680801672;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tawsjfYtMGozuT0+oJb8JYsHG0MPSBpn7m2LDDA3H5E=;
        b=BmqaHOJZj9mium6HXQqS4dk47FRBYtqOtNVezBIDz5j86anJuYs454F0nE8MPocW1m
         tCRRuZpXSvfJtXR2ogkreFVwj3kXmwn3iBgYlqv/0x0sv7owgMhWKZhaoJ88YSEjTsu1
         4Re/LZJ69EIyFND0FD9avBubY4ZSQqVChLNcDQIOzyiv+OVmuQYYrd4NhPt2Q44cx7cU
         abbgvJnjp9WKCtub7CA6ScIiBRSKCLVUDCI+Cil7wuFForRoCubGydGncEW5tgxidSfY
         /jGqbQ4aqZhrNhqu2oMkJF5O173GuTaCRtPhdEda6Le4nNtGPKLxpK7Xuz4wS3cap5uO
         cMjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680801672;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tawsjfYtMGozuT0+oJb8JYsHG0MPSBpn7m2LDDA3H5E=;
        b=Vk97VwumAM4XQhQB/OpcTdnULyTSNa/lo23UDs9JFXUvRhq0F+dTqXcM0HBx9adbC5
         Oq2x/pOKfovhQBodMwKGRmZ7+aermQ6B1FahR+975K8fhabHJZgOS7af69OH8pBG9PUx
         7S4AEDudJToZDf4FOa6LVX7ENbNt7SgyRnKTGvgAIL32+OBfgXUchugaJ3w/LgiAHlZO
         5qcDUVRbJWOvRbrI9QLnLTs2V5lT6BugrjOmpYxhK8XqJhaN8HgQ4w17SpfWHxZXvnyj
         UjWJU38hLDBZKyEGEdBRTBjwyvFCd0ZR72LNWqqrKiDbwHpDvy5y5zmGutlIMndpBvU/
         5sfA==
X-Gm-Message-State: AAQBX9fe5eNT3jTZjLIvAf+t63JRa8q49BiJ+kgsJMYZkrbMBlXwyRjp
        PvEBtItnRLfBCiTTkK4Y4DZ+xQ==
X-Google-Smtp-Source: AKy350aO9a5yXIZQNH0/KwZTNod7vVE1tj0vAxkNIo2O0yfqRzyKySPu5nUYfixbApYNusSVbQyPvg==
X-Received: by 2002:a17:906:3155:b0:931:8ad4:a586 with SMTP id e21-20020a170906315500b009318ad4a586mr7845173eje.30.1680801672598;
        Thu, 06 Apr 2023 10:21:12 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed? ([2a02:810d:15c0:828:49e6:bb8c:a05b:c4ed])
        by smtp.gmail.com with ESMTPSA id 22-20020a170906319600b00930525d89e2sm1058660ejy.89.2023.04.06.10.21.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Apr 2023 10:21:12 -0700 (PDT)
Message-ID: <5d9ef033-4b35-475a-fe40-ecaed402f40e@linaro.org>
Date:   Thu, 6 Apr 2023 19:21:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 1/2] dt-bindings: arm: realtek: Add Realtek Pym
 Particles EVB
Content-Language: en-US
To:     =?UTF-8?B?Q1lfSHVhbmdb6buD6Ymm5pmPXQ==?= <cy.huang@realtek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?B?SmFtZXMgVGFpIFvmiLTlv5fls7Bd?= <james.tai@realtek.com>,
        =?UTF-8?Q?Andreas_F=c3=a4rber?= <afaerber@suse.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-realtek-soc@lists.infradead.org" 
        <linux-realtek-soc@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <cc3c64023eb847ed86554971de2dbf39@realtek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <cc3c64023eb847ed86554971de2dbf39@realtek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 06/04/2023 09:18, CY_Huang[黃鉦晏] wrote:
> Define a compatible string for Realtek RTD1319 Pym Particles eval board.
> 
> Signed-off-by: cy.huang <cy.huang@realtek.com>
> ---
>  v1-->v2:
>  * Put string in alphabetical order

Where? What have changed?

>  V1:
>  * RTD1319 SoC and Realtek PymParticle EVB
> 
>  Documentation/devicetree/bindings/arm/realtek.yaml | 6 ++++++
>  1 file changed, 6 insertions(+)

Best regards,
Krzysztof

