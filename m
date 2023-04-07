Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8786DAE60
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 15:52:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbjDGNwc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 09:52:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40808 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232943AbjDGNwN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 09:52:13 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E81D52B
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 06:49:27 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id j22so8552414ejv.1
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 06:49:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680875364;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=bzY0VrOQTdhqb0xLz66yvPJl/GNdYUn650SOB4Bm09E=;
        b=cOGiYYGRbtQnZeCD9QAclfQHyNRlDqZeUSuPCh4/DPCGm+6i5ASUZFEjO9l3nyDeoa
         XkmIRhNgo+pcN9x653lqzGw/M3/5QwxdKu/ZMmRBlNKOSBjppYXDlKLY78rDUxER3m8e
         mMkrhEY43wWKGpIhXiANbwLJKNMH4HHDoywdrjO2Qyk8mqfqLAAsiB625woAheq7WXCz
         xT2KhVP2TAB4PlC/oZn81zwh1YsUvFucFmx+Lbx88AcUXcw3mcy2cWE06QnCWOb81rLo
         CfMCkUPhcHPuEOk0KaXFFyQxGob2ac7IVuHZOYSuHAcDNYAaJkIF6SDUSgKP6xBafTm7
         afhw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680875364;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=bzY0VrOQTdhqb0xLz66yvPJl/GNdYUn650SOB4Bm09E=;
        b=hy5PVkq4m5XPPleqarslFwcDKB62HM893akyLo791K/I6inDgHSHP0NkjR4C/ABVPV
         syN16UCOxDGB7VO+xlTuwQDhXjL1/fiKS6U1AJCVan60XPweuZJcsFNXxrTGlxUHaxxy
         nsEVOhqTuLs24MrF89QL4JOttbgOrYgSVDMFUQFY4eD2ojcYWBCkj3jN2JgU53j90++I
         uGLJkRM+Z/MM2iSPGDHHc3fhgZSFqj4T3yOJtu3zSacuhfgU1XbaZNV/Rmna41ySdFX1
         8aanhBZVcNcNaAHMJeNYv4OdsXS6f/3NKEvE0eT2avjiszCPMV4XNo7IDR6sW+r4t9JY
         QTuA==
X-Gm-Message-State: AAQBX9dZRZY5xg5UOKMEW7ct7Gy/kO2ylH8Js/Oxk53TUudtJ7KxbEpW
        EjfeNuZZm9znjGnT8a0PhdZUCw==
X-Google-Smtp-Source: AKy350YwpUdmG0KaCQJJF4r+lCKOc6QEvs5tkq4aYNG2bKi1iKT+qj+Y9CzWolMLeqEkPQOItaOBlw==
X-Received: by 2002:a17:906:5945:b0:8c3:3439:24d9 with SMTP id g5-20020a170906594500b008c3343924d9mr2393601ejr.24.1680875364729;
        Fri, 07 Apr 2023 06:49:24 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:b20f:8824:c926:8299? ([2a02:810d:15c0:828:b20f:8824:c926:8299])
        by smtp.gmail.com with ESMTPSA id x9-20020a50d609000000b004fce9ff4830sm1907574edi.88.2023.04.07.06.49.23
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Apr 2023 06:49:24 -0700 (PDT)
Message-ID: <0f1c0267-da04-8ddc-0703-1f51b53f542f@linaro.org>
Date:   Fri, 7 Apr 2023 15:49:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] dt-bindings: arm: amlogic: add C3 bindings
Content-Language: en-US
To:     Kelvin Zhang <kelvin.zhang@amlogic.com>,
        linux-amlogic@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>
References: <20230407102704.1055152-1-kelvin.zhang@amlogic.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230407102704.1055152-1-kelvin.zhang@amlogic.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/04/2023 12:27, Kelvin Zhang wrote:
> Document the new C3 SoC/board device tree bindings.
> 
> C3 is an advanced edge AI processor designed for smart IP camera
> applications, which does not belong to Meson series.
> 
> Therefore, modify the title field accordingly.

Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

