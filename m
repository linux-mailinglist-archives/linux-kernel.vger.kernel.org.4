Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5975F6E1E1A
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 10:25:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229969AbjDNIY6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 04:24:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230287AbjDNIYh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 04:24:37 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7EF83D8
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:24:09 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id xi5so43694827ejb.13
        for <linux-kernel@vger.kernel.org>; Fri, 14 Apr 2023 01:24:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681460646; x=1684052646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=B5WD2gH3v1xh1o9givBu2e0w5swNPvhe4afXVRz+MMM=;
        b=oL2AVZdFWoDex9JkWRqff2ZD9V1chGSVX2PbXu8xygcwfNgaAECi+J/jq4IvngaZ7y
         PXGFg2oWbN+6Ti1aDMNflhZMr4aeTCV3Fn7wAS84QyfBZGasr5mGwO0KpsOsSl3yllKq
         a5Kgb8EnYyMQ2TK5voW/kOf2a52ATwrGmt455naheGH5rx3rVv/nu3hCSVmeLvah5YN3
         09EKjCFWOrlStNsycYRXmax28GtewTPwjDFXqtd4ViyFL3W44QWTbc3Qp7XrRfwjFI55
         1F7nc9TR5jfSu3SLXYSajVg9nGUKOBP1By4Ju0iluU9P8Lg0Gd8VGmCVHAI4Mg3ZEjdm
         vUlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681460646; x=1684052646;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=B5WD2gH3v1xh1o9givBu2e0w5swNPvhe4afXVRz+MMM=;
        b=PIb5rsmc0agsfu+GSVwHhfkDfmxPtbT+9OpHNsWBjqRmOTElxOuTnatkz6bgK5Am+0
         91ZzKVOWORuCHbe2miEDkuuDq8XHaYgzHAjc6cYN8lTirnxjyEs9cwRQrJzmbHEcw/no
         v2YTdtA/S5NqJsi/r/hKJgNM93w5MAmMbPpAlAumvYhmAovbobBFVrlhgOhXt3+C8VDx
         C5pbjWpEXKZKFy4H/W1oTLlBpqudzVOpldzOkJS04HzZo0vnHdZSGuOW2TqHQ25pzNeY
         AYAZ2Jaq7sLmhgjE2sMDCmHB3GGjCjjuYkzJxoEfV09u1OimmAq4cz0Df8iTL/F8kSBl
         dejg==
X-Gm-Message-State: AAQBX9cs34MxxgolQqCle+ywTY8zwLB8vsS+ItmAczFyFiEuWNgM8NKL
        haDSuxY3qMMaTm0WhD6zBnoOKw==
X-Google-Smtp-Source: AKy350Yyst89FsoZKHfvDoqzSjH2OZKJJ8WXXeFSuUX3l3Dk4pEzIM0gMQIP9wV/17aCQ0jwNMC+hg==
X-Received: by 2002:a17:907:1191:b0:94a:4875:262d with SMTP id uz17-20020a170907119100b0094a4875262dmr5997882ejb.67.1681460646226;
        Fri, 14 Apr 2023 01:24:06 -0700 (PDT)
Received: from ?IPV6:2a02:810d:15c0:828:8a60:6b0f:105a:eefb? ([2a02:810d:15c0:828:8a60:6b0f:105a:eefb])
        by smtp.gmail.com with ESMTPSA id p8-20020a17090664c800b0094b360a281dsm2094426ejn.123.2023.04.14.01.24.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Apr 2023 01:24:05 -0700 (PDT)
Message-ID: <1ef0beda-9608-d73c-bab6-a07a971f939e@linaro.org>
Date:   Fri, 14 Apr 2023 10:24:04 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 04/27] dt-bindings: display: mediatek: aal: Add compatible
 for MediaTek MT6795
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, matthias.bgg@gmail.com
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        jassisinghbrar@gmail.com, chunfeng.yun@mediatek.com,
        vkoul@kernel.org, kishon@kernel.org, thierry.reding@gmail.com,
        u.kleine-koenig@pengutronix.de, chunkuang.hu@kernel.org,
        ck.hu@mediatek.com, jitao.shi@mediatek.com,
        xinlei.lee@mediatek.com, houlong.wei@mediatek.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-pwm@vger.kernel.org,
        kernel@collabora.com, phone-devel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht
References: <20230412112739.160376-1-angelogioacchino.delregno@collabora.com>
 <20230412112739.160376-5-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230412112739.160376-5-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 12/04/2023 13:27, AngeloGioacchino Del Regno wrote:
> Add a compatible string for MediaTek Helio X10 MT6795: similarly to
> MT8173, this SoC has the gamma LUT registers in DISP_AAL.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

