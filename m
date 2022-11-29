Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CF5B63C50D
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 17:24:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232523AbiK2QY1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 11:24:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235824AbiK2QYU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 11:24:20 -0500
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65E986930F
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:24:17 -0800 (PST)
Received: by mail-wm1-x32f.google.com with SMTP id l39-20020a05600c1d2700b003cf93c8156dso11222118wms.4
        for <linux-kernel@vger.kernel.org>; Tue, 29 Nov 2022 08:24:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3GRCujY2fAX+k+XJzaZ2/t/vuB/DeUSEDa+GNTMfusQ=;
        b=1eaHXzpwyfP0Xm9D0dKf3bkMGVH7/RDX8y6pi0wi5VI9JnC7f+wXmOqzSkOVJlYUyn
         2PIGzbHvMMRDvA1hqyFKhjy3kakuJy1ftnKZhI+gO8CnA2+S3yM3DAcACE+bAosP0+gE
         n/LYTU2ououqsTNoyItyMUnEiUXCL540Qgf0ZXU57bdLrB42ZfaKRAgEmA7V4op25LQQ
         5w4//RTlRU+L3hIlmfHCgUmeNJdDJFEuIFBAEhN2/KdtsOXr2AF+GFFZnHe0wdn8JC8E
         vToQIGhEFn5w13btdt01kqjcC65N6r1N4RzTicYqMUtE4JHRWAAAibm95fEgv01kywRJ
         1sEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:content-language:subject
         :references:cc:to:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3GRCujY2fAX+k+XJzaZ2/t/vuB/DeUSEDa+GNTMfusQ=;
        b=y/T8k2+w0vsU0lKqB6TZqgUd3wfbH8PkJ/H6piON7AlIVVEiZU8v+7f+F3M47qi7zl
         SlVhIfloC5DDbTfy+wryCWSufC5EjuXiGbwwDlEacC4nWdFORZuFhfaZmoD7ZZThfRb7
         YjPnwsAK0aMu5VxbIKS7RASK7sjN0zFD2zuIgav9CMthCnudH33HYLj6LTE/km0L19Oa
         Vk8jMeq4oD9U1GIWwJJA4xE1eSbAYSx0Y6aBRzO+0TW1nUrI3c0+FkMjxQTySXEPrCsZ
         Js5vKopokgtMYd6keA0TbUeEs5EA6KAqhL8BVzTrmhChrIPn3UtefiLlA4QARNV6CAgl
         YgZQ==
X-Gm-Message-State: ANoB5pl5utAOrxfro3gZMvA9I7bVhfLq+PAKk5GQK6n6ithekfFG85Z2
        QnT2NAUdxpp3qfbHZKV94IcxHw==
X-Google-Smtp-Source: AA0mqf6WH15ucpt9mj1yfuOJMrgVZJ8iDUK+OVWRFbLh+62MS79+TdGJJYsFeGLXckdY8erRt2KZwg==
X-Received: by 2002:a05:600c:4b17:b0:3cf:8b22:b567 with SMTP id i23-20020a05600c4b1700b003cf8b22b567mr27612720wmp.144.1669739055891;
        Tue, 29 Nov 2022 08:24:15 -0800 (PST)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id g3-20020adffc83000000b0024207ed4ce0sm11185741wrr.58.2022.11.29.08.24.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Nov 2022 08:24:15 -0800 (PST)
Message-ID: <8bd55bfc-009e-5357-d616-8f10196e25a4@baylibre.com>
Date:   Tue, 29 Nov 2022 17:24:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
To:     angelogioacchino.delregno@collabora.com
Cc:     devicetree@vger.kernel.org, krzysztof.kozlowski+dt@linaro.org,
        krzysztof.kozlowski@linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org, matthias.bgg@gmail.com,
        maz@kernel.org, robh+dt@kernel.org, tglx@linutronix.de,
        youlin.pei@mediatek.com
References: <20221128092217.36552-2-angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v3 1/4] dt-bindings: interrupt-controller: mediatek,cirq:
 Migrate to dt schema
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20221128092217.36552-2-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/11/2022 10:22, AngeloGioacchino Del Regno wrote:> Migrate 
mediatek,cirq.txt to dt schema as mediatek,mtk-cirq.yaml.
 > While at it, I've also fixed some typos that were present in the
 > original txt binding, as it was suggesting that the compatible
 > string would have "mediatek,cirq" as compatible but, in reality,
 > that's supposed to be "mediatek,mtk-cirq" instead.
 >
 > Little rewording on property descriptions also happened for
 > them to be more concise.
 >
 > Signed-off-by: AngeloGioacchino Del Regno 
<angelogioacchino.delregno@collabora.com>
 > Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
 > ---

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

