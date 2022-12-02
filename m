Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC65F64096A
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Dec 2022 16:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233730AbiLBP2r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Dec 2022 10:28:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233728AbiLBP2p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Dec 2022 10:28:45 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4472093811
        for <linux-kernel@vger.kernel.org>; Fri,  2 Dec 2022 07:28:44 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id s8so7888360lfc.8
        for <linux-kernel@vger.kernel.org>; Fri, 02 Dec 2022 07:28:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Rhy//qLFittA0coM8TxsRtxZgThmCcgsSfvJxmA9v3Y=;
        b=S9c9YgmdMr0078QQf931B1d/nJtUT4ChUdcd2Z+X18AuW2KC1S9Se8dBucyLWjtzCz
         FLJdjVcWHMoRsx6Wf+qzYN23ibicfn1LF1/xSHIHxcgNE5nHkpLzHcdIO5t37mMZ8ezP
         2eaMrkxXa19S+k3xM3peanZKU4hNlNdK6sWTS1dI6b+quR0Izvg4d5MydObLlVy3yrz8
         2mOsr6uKiql1ztsAX4chrWg6R0Yazb6BKBZYBIglpNmEYsa9GtRpOIQJ/cPlceekWd2l
         oGXH5b8hFyCTE1hUvAIQ+sX5Wb9gLaOdnkZRRBmPNlACZQBZxK+pEzwp1224XNk5FPni
         z2/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Rhy//qLFittA0coM8TxsRtxZgThmCcgsSfvJxmA9v3Y=;
        b=XCNzTRQvspWf3T3N/VIrKlVdK+LZsKdk5Hxpp+xQwsYoyIu3c00vFxzr5+9bkzCYfk
         AWwR9Y5rPzrs3sdJfuqsd0BkGLkKayNrIuGRRUPJuWewGek/6QxvhoOI3Wo+N3UJH3nM
         hI6F/qVXIMYD/T5N6Rrxmk2aae3Kx1HZ8n3x8v2+A5c4sqgsEU3twum2ns2FmGC3S80W
         J0a2u/Zked722lqVH7kpb/aKaq9Tgd9FgjXjurjvXhImJTffw+JaagoKfVtoQn7x8ar4
         nv4wrNn62YH0lcoEe9oX3uPIqK6RSPBU3EdwfzUCYTgB56KE7/dUItBCDhnTjVc7glGI
         5qcg==
X-Gm-Message-State: ANoB5plj0207A9W/H96VUBQDWZmst/yLOphrpZ6i1IR1A7+2BfOu0I1L
        WFAqE5rP5tP+La69rJpnHR8cvg==
X-Google-Smtp-Source: AA0mqf4FfGzuJktbtBNSonr/Ki1u5N3TeULvNzSjsU3uCztwuxgg9KYN1He2ban3YJrsqY0Bd1V/Ug==
X-Received: by 2002:ac2:592b:0:b0:4b5:5b36:28b6 with SMTP id v11-20020ac2592b000000b004b55b3628b6mr114224lfi.4.1669994922657;
        Fri, 02 Dec 2022 07:28:42 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p1-20020ac24ec1000000b004991437990esm1059331lfr.11.2022.12.02.07.28.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Dec 2022 07:28:42 -0800 (PST)
Message-ID: <9aa26e69-3be3-fd72-4085-050384a3e353@linaro.org>
Date:   Fri, 2 Dec 2022 16:28:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH net-next v1 2/4] dt-bindings: vendor-prefixes: add
 MaxLinear
Content-Language: en-US
To:     Michael Walle <michael@walle.cc>, Xu Liang <lxu@maxlinear.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20221202151204.3318592-1-michael@walle.cc>
 <20221202151204.3318592-3-michael@walle.cc>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221202151204.3318592-3-michael@walle.cc>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/12/2022 16:12, Michael Walle wrote:
> MaxLinear is a manufacturer of integrated circuits.
> https://www.maxlinear.com
> 
> Signed-off-by: Michael Walle <michael@walle.cc>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

