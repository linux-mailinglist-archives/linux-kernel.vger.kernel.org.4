Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E296652EED
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Dec 2022 10:50:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234699AbiLUJup (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Dec 2022 04:50:45 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234646AbiLUJtJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Dec 2022 04:49:09 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01CA922518
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:47:56 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id b3so22723264lfv.2
        for <linux-kernel@vger.kernel.org>; Wed, 21 Dec 2022 01:47:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=FLEBEWFKmVUzABbgomhdjBEc/qQs01rZclQnVraRaAk=;
        b=ixtgqs69him+R8vofbTGe5rZr6qzBwPsdEWRPLaodvy478LfY48Gn8IZjpy6W/9uno
         6z86B+MqaGd8IfCzQVzr2Kfu8W8jc8sz0yQiik0Uku40BEZiCWdNe9uapZR99jtiIDtX
         nRtSS6dVNX2GPaMNdy2ov4TvFcvOjrIoUy0JfLK8p3gCwznQQcu+kp1m6UfwHdMx7D/Y
         Qp4/W7NQ2pmuuA4Pb/yxuKggZcWCeZ4K20uOHKRQl4ijjX0cU1HVWJ8GiAj5w9LagUYQ
         PNlfGiMYmATCyRs93yiG9fV6EAHa0VtHKPwHs5jFrp+AiTw/cKb40UooFGTtcNaL27/q
         dN9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=FLEBEWFKmVUzABbgomhdjBEc/qQs01rZclQnVraRaAk=;
        b=0sFfC5T+Q8QUTlaplKO4R80gPvykADnGx5qQO7Pp1M8sCzmODuUILR/UG51xf/trV1
         kaHscFafesWHjg4cVlOeP+admybRK89ShQwarVh0VU0gUZwSZ7OI5Jp1l0Kq/zQEYkzf
         l6/OATRHyCkxjPPYdtTHI98TmQingahaRUtygJCX6PCgx61rUhfeHYy1OTpH8Fod9Rrd
         gt8nm9mcYp//x5XOlIWm6kMOeaZPmi+bc+YHlAUYau13i4SpdoLoMwx6ZPChXaRVboqJ
         qYNeC1IsRqH+sSDdJ/fRWnrguGgJGUGUBWsFAyrK83amfpuS5WGOnEFYG4IZG4yLIwIm
         cGQA==
X-Gm-Message-State: AFqh2kqiH8chzjpWNUOIW9i3k4/vdX0kFN1y8vGy0tpDWScqIF/UGqUo
        7q6jTpRMkcs1Km7tuGA1kQYxug==
X-Google-Smtp-Source: AMrXdXvSUsFWN8Ug4VQ+xJHQ8UMNbhnFMQgxkmiWJZt3pCBQprIlPuJ4OCiySDp51aDBu3BSEWWswQ==
X-Received: by 2002:a05:6512:31c5:b0:4b0:25f9:14ea with SMTP id j5-20020a05651231c500b004b025f914eamr552097lfe.21.1671616074385;
        Wed, 21 Dec 2022 01:47:54 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id u24-20020a2e9b18000000b00279ff5d5e10sm1266626lji.38.2022.12.21.01.47.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Dec 2022 01:47:54 -0800 (PST)
Message-ID: <3a26c733-6573-5954-f4e5-8a1f8abba140@linaro.org>
Date:   Wed, 21 Dec 2022 10:47:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH 1/3] dt-bindings: rng: Add StarFive TRNG module
Content-Language: en-US
To:     Jia Jie Ho <jiajie.ho@starfivetech.com>,
        Olivia Mackall <olivia@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Emil Renner Berthing <kernel@esmil.dk>,
        Conor Dooley <conor.dooley@microchip.com>,
        linux-crypto@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org
References: <20221221090819.1259443-1-jiajie.ho@starfivetech.com>
 <20221221090819.1259443-2-jiajie.ho@starfivetech.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20221221090819.1259443-2-jiajie.ho@starfivetech.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21/12/2022 10:08, Jia Jie Ho wrote:
> Add documentation to describe Starfive true random number generator
> module.
> 
> Co-developed-by: Jenny Zhang <jenny.zhang@starfivetech.com>
> Signed-off-by: Jenny Zhang <jenny.zhang@starfivetech.com>
> Signed-off-by: Jia Jie Ho <jiajie.ho@starfivetech.com>
> ---
>  .../bindings/rng/starfive,jh7110-trng.yaml    | 55 +++++++++++++++++++
>  1 file changed, 55 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/rng/starfive,jh7110-trng.yaml
> 


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

