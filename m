Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D4D46BC6FF
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 08:24:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230101AbjCPHYw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 03:24:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32888 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCPHYt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 03:24:49 -0400
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BF63A878
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:24:47 -0700 (PDT)
Received: by mail-ed1-x532.google.com with SMTP id o12so3759971edb.9
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 00:24:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678951486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/bgdteaO78IPJ8n05LVHoYGGSz252y+t9b/EMMp5aSg=;
        b=dWKdaX0KZEWMsPomMM/eVXxVb5lA9IaL7Chvky6Eh7fU1g0naZPWTi9exr7AlxuQXY
         LSKe6vGXzhKh962b933I/lyc+pqTFDovPtLB9SLs3cOC9/Zemt9VjbsTk75u3xBJ+/RA
         55mm3kgRdoI9The16qeJS6P8f6f8sXLkdlyCAidXBWR6IUI0BcJQkRIdkcswGWqMP0mC
         K8M3yYeHu4esP41yTID/n0J+VkvAWSSo/F0fyEbh2YUW3VKUgV7nrXmmz6s8wNeYToUv
         38DgzPHLC2Xw2CY8dB4FtFmdTAFsoXxCemuPe/qLAYNKhmCu+VkEAqw9E3yfoxwBecDA
         r7dQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678951486;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/bgdteaO78IPJ8n05LVHoYGGSz252y+t9b/EMMp5aSg=;
        b=t+YW8TVzjNbElfLuywlq00SI/IT+EaJikouWijXlWlZMH3Q/0d0H121iJoX9CkaHUW
         HMbqdk2L1bjma5ckHZEncUs5KXy94c7M739bKg4S061wAStK/ifkol+HmyzkMjAM0a/h
         /9IVKTpzYRmmUss1uM73J3/r2HjkxjZ8+aJ654jgH3CPsTFAYoQBYGPhsh95BU3euZPQ
         ks+pLzHrlVVNpnqBDqARBJt0kXGihjD3X9ygZMu2h3TJuZzOVt0+1l/BBq+M5GhY2niD
         FCN2wjj0zZXgyRJkQmxXTfmRTBx1U6hMATpUx1oVMvlqEBIEvisq43VzEt/qU6z9bt4F
         FtvQ==
X-Gm-Message-State: AO0yUKXRt+D9j7PKxHhS2dsqm4M8VqUaskfZQxqelS45DatZVwcMyBYz
        nwgrPas+rfBDpFW9WJlwGxb/Ig==
X-Google-Smtp-Source: AK7set8n1LQzlsokldgijr1RYIG80emZgfFLksKIExrU5Iu/kN9VQx86ychaKjlFf+qUbkPa/gENug==
X-Received: by 2002:a17:907:6297:b0:930:7324:2766 with SMTP id nd23-20020a170907629700b0093073242766mr1165143ejc.35.1678951486084;
        Thu, 16 Mar 2023 00:24:46 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:9827:5f65:8269:a95f? ([2a02:810d:15c0:828:9827:5f65:8269:a95f])
        by smtp.gmail.com with ESMTPSA id h7-20020a170906584700b0091fdc2b4fa2sm3493484ejs.145.2023.03.16.00.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 16 Mar 2023 00:24:45 -0700 (PDT)
Message-ID: <aa21d3df-0aa5-64b2-060c-3b360ad86917@linaro.org>
Date:   Thu, 16 Mar 2023 08:24:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v7 3/6] dt-bindings: net: snps,dwmac: Add 'ahb'
 reset/reset-name
Content-Language: en-US
To:     Samin Guo <samin.guo@starfivetech.com>,
        linux-riscv@lists.infradead.org, netdev@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Emil Renner Berthing <kernel@esmil.dk>,
        Richard Cochran <richardcochran@gmail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Peter Geis <pgwipeout@gmail.com>,
        Yanhong Wang <yanhong.wang@starfivetech.com>,
        Tommaso Merciai <tomm.merciai@gmail.com>
References: <20230316043714.24279-1-samin.guo@starfivetech.com>
 <20230316043714.24279-4-samin.guo@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230316043714.24279-4-samin.guo@starfivetech.com>
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

On 16/03/2023 05:37, Samin Guo wrote:
> According to:
> stmmac_platform.c: stmmac_probe_config_dt
> stmmac_main.c: stmmac_dvr_probe
> 
> dwmac controller may require one (stmmaceth) or two (stmmaceth+ahb)
> reset signals, and the maxItems of resets/reset-names is going to be 2.
> 
> The gmac of Starfive Jh7110 SOC must have two resets.
> it uses snps,dwmac-5.20 IP.
> 
> Signed-off-by: Samin Guo <samin.guo@starfivetech.com>
> Tested-by: Tommaso Merciai <tomm.merciai@gmail.com>

How do you test the bindings on hardware?

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

