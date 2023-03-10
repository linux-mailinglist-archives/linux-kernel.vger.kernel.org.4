Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8C206B3893
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 09:29:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230406AbjCJI32 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 03:29:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229768AbjCJI3W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 03:29:22 -0500
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86839D528
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:29:20 -0800 (PST)
Received: by mail-ed1-x52f.google.com with SMTP id x3so17245590edb.10
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 00:29:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678436959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=uB0rK1kBMI+Nt2y6Mc9XPaDU5dUgUBOxars7E0HbbVA=;
        b=zgXBVXiVl7XoFo76/yrd+B+8ZajxnPqv4LRc4lpDiXq7OdZ7PU/xXWxE7HWrpyTF/4
         N1lpTiy7Rd19f/jIRZij0fBTMeCwHLg6Fy+27lUQEeTbJhj52jiCJptd62K8WbgTSuAA
         cy5EVQC1vzd2U40ptkBfNGpr1GDVSRVl5mMIX1O/utfr3GQxRecLGhuaPwZwCGHZ8h/o
         tjsyIFnNU6Pb+rB8y+kcbencLHR5P36ivelAWTgGr/IE8D4nIhiNx9kNOkleDoXi3Mzq
         IEnEkctP6UNzz2Xj0yGHZr+ypNEX+hydG89RjYsnqy2hhsYic3rCyHHqAKdJspIs3x7J
         Ro3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678436959;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uB0rK1kBMI+Nt2y6Mc9XPaDU5dUgUBOxars7E0HbbVA=;
        b=XubAu+BunVoqdi/Vh1ocxXHXReoizvwThLXkmmQ/nVS6CQ4BuoST2lKcKvKhztA994
         Pp+Kn5Tm1jNC9zBlIrJI1vF8O6MMNzR/Aa4XDl2DScOO3T3Ti68bIHVf7TBYlfLWO9sj
         yMS6RYz5ALsyCIkC2EWQvGv5bakAG5APQJNr7WvFeUItKJ5eQxZrkFEub+qHUoI7/b1c
         t/7yW8acSnKRrmu/UZZcV3pSlQEYj9vtexRqvqQjOxrtU1gwtUkWqfJXuz8BRWOucK9J
         EAoh54h4VOT9Vw5gmwEMsjcHRPUKOewCczYV6o82WV7nLK5sCZHyb9tyyLIr2jDUTgdu
         vZUA==
X-Gm-Message-State: AO0yUKVV79RMxlTwr1T+oPGCJGeLiFYjUHNgJwrZxRtsNZR9JkMiy8i1
        /5RvFKdFJHJUID46IFnKngJCDA==
X-Google-Smtp-Source: AK7set8UQKKMmAOVRYKQ/i/KExXg3AgioafyC3Q1XOnef/dHb+v6PnHiGYD4PqIZELC7xxX0L8tn1Q==
X-Received: by 2002:a17:906:246:b0:8b1:fc1a:7d21 with SMTP id 6-20020a170906024600b008b1fc1a7d21mr30206548ejl.5.1678436959029;
        Fri, 10 Mar 2023 00:29:19 -0800 (PST)
Received: from ?IPV6:2a02:810d:15c0:828:2a59:841a:ebc:7974? ([2a02:810d:15c0:828:2a59:841a:ebc:7974])
        by smtp.gmail.com with ESMTPSA id br5-20020a170906d14500b008ddf3476c75sm673322ejb.92.2023.03.10.00.29.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Mar 2023 00:29:18 -0800 (PST)
Message-ID: <22325550-5b32-d55a-e647-3890be6b475a@linaro.org>
Date:   Fri, 10 Mar 2023 09:29:17 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 02/21] dt-bindings: display: mediatek: ccorr: add binding
 for MT8365 SoC
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Daniel Vetter <daniel@ffwll.ch>, CK Hu <ck.hu@mediatek.com>,
        Jitao Shi <jitao.shi@mediatek.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Sam Ravnborg <sam@ravnborg.org>,
        Rob Herring <robh+dt@kernel.org>,
        =?UTF-8?Q?Uwe_Kleine-K=c3=b6nig?= <u.kleine-koenig@pengutronix.de>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Xinlei Lee <xinlei.lee@mediatek.com>
Cc:     Guillaume La Roque <glaroque@baylibre.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        dri-devel@lists.freedesktop.org,
        Fabien Parent <fparent@baylibre.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20230220-display-v1-0-45cbc68e188b@baylibre.com>
 <20230220-display-v1-2-45cbc68e188b@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230220-display-v1-2-45cbc68e188b@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/03/2023 15:22, Alexandre Mergnat wrote:
> Display Color Correction for MT8365 is compatible with another SoC.
> Then, add MT8365 binding along with MT8183 SoC.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

