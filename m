Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C3011719379
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 08:44:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231805AbjFAGoR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 02:44:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54704 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230410AbjFAGoP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 02:44:15 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C778199
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:44:14 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-96ff9c0a103so55652466b.0
        for <linux-kernel@vger.kernel.org>; Wed, 31 May 2023 23:44:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1685601853; x=1688193853;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s+1wS1GvVs6PVXCbsDn8FmeR29QoRaStBT4rEQw6v+Q=;
        b=YtFWCgx6LUtIu8l0J8H/K3u+P9knKjerhMvZ+0b7bpWgVgJWJ4EwZlZ9s0RBU2vQ7b
         k9wCysHrXRBOfwX6ZyIbFbcpGk5ucrnlQa9g6nDl3ARDGir6ACUwlwVWi3a0IrjORY2m
         cMFjLnR2pWhVK5R/7tOquV3At/B/CjJ5u+kHv8yQ9ZS8EZCKe3jhA7vnXH3gCKZq1bBj
         VcDOcS6X0HA7zf3It9QBv91axLUjAwByw9pWnC+GXvdWGvwW9ThFB/s7vaRTswPikPy5
         VYiYq7XU+f9ZJ9v2zzBvpp1ZAq5LK2z6sQAa0rwRSEfNBllwgSsamFfWBiARCkG2BFaM
         WZKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685601853; x=1688193853;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s+1wS1GvVs6PVXCbsDn8FmeR29QoRaStBT4rEQw6v+Q=;
        b=ZI89pMooSWz6R8sRal+A14U86gn41zdkXaym/24Bz7h/gazk6Va6grHcbJ5d3txP94
         UoZZJqgVos8O5LQrBlJRFJabXULO5r20iyR/M6w+ic53vlR1+c4LzNBUuXbu4oPsWEmB
         nBi1ruTVs21MxrCsAMs/9aWA0mxh+K+zCvUJC1UePk1Z4xtuaQDN8BeWwsTzOW2pj++E
         3NHvmiQDb+OpIxFb8dQNB23pITi0P21wAMeMLqT2R8ZJt8an7wnmsgsV/S2o2pQS3po1
         YqxLObbExg/jqvAN4dpE+4oFJVm9pY/yZvNanJ1n0zB/uJLdUPImQr/yexV8A8QV2nA3
         DVMw==
X-Gm-Message-State: AC+VfDyAjkqCJqLYdEz8k1cO2llTvPHLqF6qJ4puDlsRrNl1a8keSm34
        Mga58wfmzIlpWZVu24GTkqV6EQ==
X-Google-Smtp-Source: ACHHUZ4kVX76yv2xK8y6XHIqAlXpeG8XkpxTLU+NnzuBLJjrKbxHtpdLoctkxaBvAvpnEkI006kV9A==
X-Received: by 2002:a17:907:7291:b0:96f:4ee4:10d4 with SMTP id dt17-20020a170907729100b0096f4ee410d4mr7100245ejc.43.1685601853256;
        Wed, 31 May 2023 23:44:13 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.199.204])
        by smtp.gmail.com with ESMTPSA id w27-20020a170906481b00b0096a91ab434fsm10070374ejq.40.2023.05.31.23.44.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 23:44:12 -0700 (PDT)
Message-ID: <aef14b93-d848-e400-55c4-b86a6d526aa1@linaro.org>
Date:   Thu, 1 Jun 2023 08:44:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 08/43] dt-bindings: timers: Add Cirrus EP93xx
Content-Language: en-US
To:     Nikita Shubin <nikita.shubin@maquefel.me>,
        Alexander Sverdlin <alexander.sverdlin@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Linus Walleij <linus.walleij@linaro.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Michael Peters <mpeters@embeddedTS.com>,
        Kris Bahnsen <kris@embeddedTS.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
References: <20230424123522.18302-1-nikita.shubin@maquefel.me>
 <20230601053546.9574-9-nikita.shubin@maquefel.me>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230601053546.9574-9-nikita.shubin@maquefel.me>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 07:33, Nikita Shubin wrote:
> This adds device tree bindings for the Cirrus Logic EP93xx
> timer block used in these SoCs.
> 
> Signed-off-by: Nikita Shubin <nikita.shubin@maquefel.me>
> ---
> 
> Notes:
>     v0 -> v1:
>     - as Hartley (unfortunately) looks like not interested in dt rework,
>       added myself instead
>     
>     Krzysztof Kozlowski:
>     - removed wildcards
>     - use fallback compatible and list all possible compatibles
>     - fix ident
>     - dropped bindings in title

I gave you already the tag. I also explained in lengthy message what to
do with it, yet you did not include it here.

I'll stop the review.

Best regards,
Krzysztof

