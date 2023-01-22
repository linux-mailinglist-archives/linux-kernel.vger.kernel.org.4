Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECA7D676D41
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 14:49:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229960AbjAVNtw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 08:49:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229949AbjAVNtu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 08:49:50 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77C631E1F1
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 05:49:45 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id j17so7232308wms.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 05:49:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=n4HC6qouSeVZQItRIxIIESZp16atoc5adtJd1Q2QlF4=;
        b=qt075DMCqQcWv5lP/Xxgv/hcseDrBbg4U34aA9gISFu1+SS3LcRFB8hXYMFh9ypZJl
         rTMG8CPT4091NvRdr+mXFgP0ysUKBy264h0a+bGcsXMdJ556LaB9F/ilC0rzPs3Rbj5e
         xFPu498zf2ZIFr5B6FPeuNurawFk9/s61rUNj1FNIJeuv46YfZSAujb84SL8vcTOGR0T
         rhyGZt69TPFalqeowYPKCsLCAkzptu2HlnFJV8KzoZz5i96qrLK9b58m411uLK9CPmBA
         PgsyZ25xFan4dcbH63A6hbnglAIxnEhxCkr5TftyVFOfxTA5jGnuWz9125yYnTCHNK/+
         Kgwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=n4HC6qouSeVZQItRIxIIESZp16atoc5adtJd1Q2QlF4=;
        b=xITWzj3bDDsJtgKKkeWFgHbKU0cyPcRXBpME75EHwquoPaHIn33bunO967pht8LekH
         pF2pr+TaO6KNtNer7is8Dv5mjp6rOymaxEut9rhkj0wwGe/uSNklojm4rdurtvqgjSli
         UgKYh9jlbBDv931xjoDcl9fkLAKcVdS1/3uqPIYvIt8yQsb5kV9KL/beN2UExzZbVDiq
         wSTauPzAlc94t5pwpQ6Eu7EXXn0D7SOJZNdu2mCCEY4FahrgiwXLwG+0QQPxmf3VLn+U
         SO/YzcyvUHgCSlQUZ7Z8EraCVZJIut1hVoepQVw0BmFnb986pNt1Pj5DQqjNKEbbumW3
         iBVg==
X-Gm-Message-State: AFqh2kplKSKz6+LbUdZxTzkCyfszAZ2toMfK9x0eUADokrgcLyvJ558Y
        JPtf1hXT7JJtXPdke6k9i7H2CQ==
X-Google-Smtp-Source: AMrXdXtWzk4h7L0/T2hQcONOtPAv9+Zq8uAXQpraPYwgNWCeiMl3ld1ZvI9Y0ZWGaO3EmBiDSjkd5Q==
X-Received: by 2002:a05:600c:539a:b0:3d9:ef72:190d with SMTP id hg26-20020a05600c539a00b003d9ef72190dmr20265304wmb.19.1674395384068;
        Sun, 22 Jan 2023 05:49:44 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id c2-20020a05600c0a4200b003daf6e3bc2fsm18894274wmq.1.2023.01.22.05.49.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 22 Jan 2023 05:49:43 -0800 (PST)
Message-ID: <25410783-17e5-35de-3be9-930f50584196@linaro.org>
Date:   Sun, 22 Jan 2023 14:49:41 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v3 2/3] dt-bindings: clock: mediatek: add mt7981 clock IDs
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        Miles Chen <miles.chen@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Fabien Parent <fparent@baylibre.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>,
        Jianhui Zhao <zhaojh329@gmail.com>
References: <cover.1674233728.git.daniel@makrotopia.org>
 <367c21c111458abf35170b37d51d023a04a04510.1674233728.git.daniel@makrotopia.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <367c21c111458abf35170b37d51d023a04a04510.1674233728.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/2023 18:24, Daniel Golle wrote:
> Add MT7981 clock dt-bindings, include topckgen, apmixedsys,
> infracfg, and ethernet subsystem clocks.
> 
> Signed-off-by: Jianhui Zhao <zhaojh329@gmail.com>
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

