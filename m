Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FAA5B45CE
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 11:54:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229562AbiIJJyq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 05:54:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229545AbiIJJyn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 05:54:43 -0400
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31BFA18B0A
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:54:42 -0700 (PDT)
Received: by mail-lf1-x136.google.com with SMTP id f14so5838899lfg.5
        for <linux-kernel@vger.kernel.org>; Sat, 10 Sep 2022 02:54:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date;
        bh=wZ6pO0qP2lP0EdvfsRwhcpTENHXsz3JcKbr3shUc4TU=;
        b=r0Zo8wGfSMBass6kqxL5Z6VCacDKNMGTgphBS/mfV9+5KJ+d8oQrYJhewxDxn5PlYU
         LyfQOOtMDsTTDXEinR3reqsvsNnlAAZrPt49fPx6cDo+6zmKbSDi8VZTRNAPHs867ULx
         VwG+M3+TwAoCEamKXwzzzoCIc2a86UUG4/F3WuBbZzz3roRjPtEerAz2OJeum0+gfu5t
         AJevs8ewiJ9hQIJn2O6InbGR7Y2GPNkSTrjg4qtmP3KpluVPPLnd8DvL07aPLk9bs4ep
         TccaQudoCNHdc4VgqE35KjFTFz8BoLjBNGNLo7MCebKLiw993gLwCA4y/XPScLxRpMg9
         Uj/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date;
        bh=wZ6pO0qP2lP0EdvfsRwhcpTENHXsz3JcKbr3shUc4TU=;
        b=1hc39tQ/OcDfl0IC0QFwqFmKbRux1s6isg9ns2LGwgPBdLoRdJ/4xIgGQD2CaUjSgT
         gFJgmlJDy4RbDwb0IyuSCqQ5EvuWM202MC4LuedP9jgyhOlJJ4j99EGmO/PwqgYG8Clh
         nIb+pGoRmhZucOYxvH6osWijO4K6VJCmqbB264k3g9FVtZdKWfBF7l0auWUmce16QhJJ
         SE8xV3IzN2/zveCpAAZZ3HU0szttwN8hHqlIGtAg5sx//6O2ZrsM5VJ8A3J/ALJTMBrM
         EI6e2+PSe1DgvlC0vXH8fJCntM2AX/PQyUfw4fyV5mbDadxAeaKKcKi5xF5RTCJfjZeI
         UXFw==
X-Gm-Message-State: ACgBeo2TjtjFJeX/LaqU0hlcFK0JMGRh4dL7Uv3YH10tON4SSOILXyLr
        svbeNrivebKO4BgFWB6TUbfdzQ==
X-Google-Smtp-Source: AA6agR4421xFsdbE0xflRQvnyCMglAk40p1nG6802nRC1Pk/i13y8S35zuJxNCMMgWbJdkcDHs5b9A==
X-Received: by 2002:a05:6512:38b2:b0:493:9a:ac2e with SMTP id o18-20020a05651238b200b00493009aac2emr5486129lft.126.1662803680563;
        Sat, 10 Sep 2022 02:54:40 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id k28-20020a05651c10bc00b0025e00e0116esm283118ljn.128.2022.09.10.02.54.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 10 Sep 2022 02:54:40 -0700 (PDT)
Message-ID: <104fb8b5-03fe-203a-57ed-e4c6616989cc@linaro.org>
Date:   Sat, 10 Sep 2022 11:54:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [RFC PATCH 02/10] dt-bindings: dma: apple,admac: Add iommus and
 power-domains properties
Content-Language: en-US
To:     Janne Grunau <j@jannau.net>, asahi@lists.linux.dev
Cc:     Mark Kettenis <kettenis@openbsd.org>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Hector Martin <marcan@marcan.st>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sven Peter <sven@svenpeter.dev>, Vinod Koul <vkoul@kernel.org>,
        devicetree@vger.kernel.org, dmaengine@vger.kernel.org,
        er <povik+lin@cutebit.org>, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
References: <20220909135103.98179-1-j@jannau.net>
 <20220909135103.98179-3-j@jannau.net>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20220909135103.98179-3-j@jannau.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/09/2022 15:50, Janne Grunau wrote:
> Apple's ADMAC is on all supported Apple silicon SoCs behind an IOMMU
> and has its own power-domain.
> 
> Signed-off-by: Janne Grunau <j@jannau.net>


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof
