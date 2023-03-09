Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCA26B2495
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 13:54:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjCIMx5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 07:53:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230177AbjCIMxx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 07:53:53 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 777128B05D
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 04:53:49 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id o12so6502418edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 04:53:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678366428;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BO4cSDH+yXCwg0BT3FsRcGzY/hRaLSEZ2u3ktKpW830=;
        b=ziWmzXQIaPy8kBMFn8U4Isxw4W011yHj1C92+vFeuSCbLm9g1WT38plDvFVRGx2o5S
         jH1jIYwIWfUyKXpXjG0iCd0INbTeBfMLPZqcssG4PoQsEdK8Jyb4w10tbvbo7KJAGLAo
         pFDM4xc0ROwcMCFxLrlm9M3EzRaHcpy3flTaPVFeccQ/k8ig36ebRyoNPHFtI05Y40M8
         h3WOAgENN3HpeH9bHCFz/jn5VdXSat/rXdmG9SmyHqzhRTdKP4IYg4vsLz0Q2QgHNs4i
         LCLAY9Wsxi2U1rD8y8mVySz3tzERir1uwFjmfA5odNPSfSFs1+YeR8Qi9jjcpiN/mNL9
         lokw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678366428;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BO4cSDH+yXCwg0BT3FsRcGzY/hRaLSEZ2u3ktKpW830=;
        b=k03FOsKzUyaUk2iO3w5dqfQddLFhPs0poNzWrTDofk2VQuxayNUwVCVwhx1j9VWFw0
         JMk0paR35/C0obvhXYls4z88n6R/bUIbYuiLA5neWaog4V97GuW2FxU2urDruoeeTs/G
         Vn/L4OR/QG6R5vRr5nrIHML4hPX9aIw1bZjCKHtz8uaaKcKuQeONRgU594bAiAB4esdy
         c1FMV8eceg7ZTGVKx+s9VSvwedFIMTaE0Sd+zuOGO1a0ByaMp60fwwRH3JhhS9q9v5PR
         FbZLI6ljESGc5usRhpUU6+e+qHfpRyGZiwmUnXTHK9nBY8f1HOHnqOA5zso5AasurrLg
         260w==
X-Gm-Message-State: AO0yUKUSPz2U3+EiE9wwGanpVylbEIWSBMNDy7L68mDVyjulSORsjcD0
        IYspjGzkW1dn/5eF1PFWo/eCbQ==
X-Google-Smtp-Source: AK7set8sieCz4hwrVvbAOjrecgn2A01genzK5N4Z+WBEZA1KC00G5BKipuhwVn3ZnC5rsqEVTLYnAA==
X-Received: by 2002:a17:906:80c1:b0:87b:d62c:d87 with SMTP id a1-20020a17090680c100b0087bd62c0d87mr22515819ejx.1.1678366427965;
        Thu, 09 Mar 2023 04:53:47 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:7ee2:e73e:802e:45c1? ([2a02:810d:15c0:828:7ee2:e73e:802e:45c1])
        by smtp.gmail.com with ESMTPSA id e7-20020a170906c00700b008cff300cf47sm8737117ejz.72.2023.03.09.04.53.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Mar 2023 04:53:47 -0800 (PST)
Message-ID: <98964f70-f7f7-9560-3cfb-84eafb33a492@linaro.org>
Date:   Thu, 9 Mar 2023 13:53:45 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [EXTERNAL] Re: [PATCH v5 1/2] dt-bindings: net: Add ICSSG
 Ethernet
Content-Language: en-US
To:     Md Danish Anwar <a0501179@ti.com>, Rob Herring <robh@kernel.org>,
        MD Danish Anwar <danishanwar@ti.com>
Cc:     "Andrew F. Davis" <afd@ti.com>, Suman Anna <s-anna@ti.com>,
        Roger Quadros <rogerq@kernel.org>,
        YueHaibing <yuehaibing@huawei.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Eric Dumazet <edumazet@google.com>,
        "David S. Miller" <davem@davemloft.net>, andrew@lunn.ch, nm@ti.com,
        ssantosh@kernel.org, srk@ti.com, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, netdev@vger.kernel.org,
        linux-omap@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20230210114957.2667963-1-danishanwar@ti.com>
 <20230210114957.2667963-2-danishanwar@ti.com>
 <20230210192001.GB2923614-robh@kernel.org>
 <43df3c2c-d0d0-f2b8-cf8b-8a2453ca43b4@ti.com>
 <63dbbda7-a444-8dac-6399-45e305652155@linaro.org>
 <d7f18805-7b26-e2c9-a40e-262165ec8f9b@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <d7f18805-7b26-e2c9-a40e-262165ec8f9b@ti.com>
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

On 09/03/2023 12:44, Md Danish Anwar wrote:

> 
> The SRAM that we are using here is phandle to MMIO-SRAM only. In the example
> section you can see, sram node points to msmc_ram (ti,sram = <&msmc_ram>;) And
> msmc_ram has compatible as "mmio-sram" in k3-am65-main.dtsi [1].
> 
> 	msmc_ram: sram@70000000 {
> 		compatible = "mmio-sram";
> 		reg = <0x0 0x70000000 0x0 0x200000>;
> 
> So I can use 'sram' property as there is no need to make this as ti specific.
> Let me know if it seems good to you.

Yes, it's fine, thanks.

Best regards,
Krzysztof

