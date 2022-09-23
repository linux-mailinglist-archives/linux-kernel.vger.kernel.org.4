Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55C735E76A8
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 11:18:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230116AbiIWJST (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 05:18:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229867AbiIWJSQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 05:18:16 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CF185FAC1
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:18:15 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id j24so13432978lja.4
        for <linux-kernel@vger.kernel.org>; Fri, 23 Sep 2022 02:18:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=zCCsISQtcxyw8amZYwvhvc9T7nwDgM18FSAE5RNKrU0=;
        b=fJFe03hW++93PPI4nR6ZbenufSqnk45BOJjvZqhzDXJPNVZMyddW2REwAstofnGK2I
         5eL+ZKHoNl/e0gVftljb8TTjuGdqp5mqa1B3XEUxYRb7SX85Q6ReWYek9dxJwlvW/592
         xGUsMXfXsS2F9VVNzaHkGIySst+vJ2BL/HQzxdIBZMThql3b7pyFI8p1VLu76oK2uU0t
         cNHw9X6OlqUOUKho99NxLVxnJ19rhxuyzOB0CUshZF21NQfQjzHKmgTAUZ9/NYcJObhV
         RgcB40fVrilt7NEaA+YWzxqNMsdgyHLysmokvtWOtUXzU9TP9oSPWdgHdiUDAqHykD1i
         /0Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=zCCsISQtcxyw8amZYwvhvc9T7nwDgM18FSAE5RNKrU0=;
        b=uh7H2igFaemXjDm6XYyQdsaqGak6igdyv9sdP9e7vIoX9tur1zkxsF/K4bUgiI+x+B
         7Qtsz3X6P0q7kyrfu26ncD0fY5N9eWOTI4cgHpV81x6EScf6qywK4hzhA8JRUDkphGP+
         8mLkuxH0jK2GdwYo5b3QZ8jvGJcZ6Daur+LZRk9eJ3DmwDYTDnJ4ioVzUl0vFvRCazFT
         teZNoo09940+1FG6pp5LzYUyn7ogINreJHXSnKos9sdTiVmdaa4uqlyhxsRwTH/zEa4g
         vwRZ8cRZcfHwwWMY9QerHQVYL7UA8TKKbFl9IoDup8/UWJ9O6r0umGtbZUm6bzQBtJ6J
         Rmug==
X-Gm-Message-State: ACrzQf0N3QqGFjLraJu8Klny22Dwqfkp+90+Y1mmmKByDS3pI7QKrWOt
        wDwp7TmDfdk8XWRXEg6PejKKyQ==
X-Google-Smtp-Source: AMsMyM7OJaLDYJ/XIYVnRAr+Xn7Wgg1hfr3CsHHtM9owaNGBsLkxlBovLAJnN7S7NiVHfJ2XyE5tRQ==
X-Received: by 2002:a2e:bc04:0:b0:26c:5e:c186 with SMTP id b4-20020a2ebc04000000b0026c005ec186mr2583939ljf.118.1663924694089;
        Fri, 23 Sep 2022 02:18:14 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id i2-20020a056512340200b00497ab39bcd0sm1360523lfr.96.2022.09.23.02.18.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 23 Sep 2022 02:18:13 -0700 (PDT)
Message-ID: <b5e050bd-e200-b2a4-5967-8855e9f0395c@linaro.org>
Date:   Fri, 23 Sep 2022 11:18:12 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 1/3] dt-bindings: arm: add DT binding for D-Link
 DNS-323
To:     Mauri Sandberg <maukka@ext.kapsi.fi>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, arnd@arndb.de, olof@lixom.net,
        andrew@lunn.ch, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, linux@armlinux.org.uk
Cc:     pali@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
References: <20220427162123.110458-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-2-maukka@ext.kapsi.fi>
Content-Language: en-US
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220922202458.7592-2-maukka@ext.kapsi.fi>
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

On 22/09/2022 22:24, Mauri Sandberg wrote:
> Add bindings for D-Link DNS-323. It introduces altogether four new
> compatibles: dlink,dns323, dlink,dns323a1, dlink,dns323b1 and
> dlink,dns323c1. One is for the common parts between the devices and
> then there is one for each three hardware variants.
> 
> Signed-off-by: Mauri Sandberg <maukka@ext.kapsi.fi>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

