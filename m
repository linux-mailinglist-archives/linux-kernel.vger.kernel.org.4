Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C076CD3D9
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 10:00:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230164AbjC2IAa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 04:00:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230247AbjC2IAW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 04:00:22 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 163E640CF
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:00:19 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id y20so19069481lfj.2
        for <linux-kernel@vger.kernel.org>; Wed, 29 Mar 2023 01:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680076817;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BL2itQzukLRwkGxIdHjN1VJkHZ8v7g0L+3aB4SoIfhU=;
        b=yEec9OikNdut9qNOpXOS7YhiUrTl7g+qZgWu/lPjLyerRtom8d2ID1wb7ODdWSqG3M
         SQ1jF0GCZQii+ThZdpc2sO2aslJgs/Uai+NcZhQ+VNocgWjOATzme5tBTd3wgehQuB31
         3aukxeicKmfDAX4RDZEyitq5Ih7NSPW21FDNDn0wroOPYUoJIyaT5O0KDPZ2ce9kTJ9w
         V9lpv3e5/eFULKitL59D7zzsqLO/Xoh2CUtuecIjl2jNy6O9qUduu3fZ+mqm2rW63Jju
         3mhIypbLJ7U27cSHi3PCHPCubBkyILNXKavz4RcMGPvPp1gV1Dr0eFNtkZ/gwL8BXQq+
         3XVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680076817;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BL2itQzukLRwkGxIdHjN1VJkHZ8v7g0L+3aB4SoIfhU=;
        b=aybwOdtK23mmIc1uU0bv3vzMCZgUK8BC0z7aNMYmyM8vdz7a5ncVGbaAueuveSizoq
         bVVPV3cTAv5dTLPqbef7zA7en4Je+kxCJEDBJGU9cwouvD8nqPY+3/qTo97SnapAkdib
         kDc7I4J+t8+JMk+Ur/txbACuB0Aam4i9CV6RyERW0Dh020MHZcJ2Ov3j9ZZZQw5DigPR
         6UJBlWpxflI32jeZ2IdAJzMvjroKZA4PilPP45LoqaBjqPQXAHmNUhrwTi4WGNUKg1bk
         V/LzXiYm0fPQvgg1UtyBUe4ijZy9D9EeiAP2eGv5iuN7imN4KcONCLeSD1YZX4irX3D9
         8H6w==
X-Gm-Message-State: AAQBX9eiBuJLqlwQ3cRGU0ZWPhko8ySouwlRpp1eu4Baxdf+/Gn8LJfT
        RHzChucnIXzNdHcyc4KuERmUgA==
X-Google-Smtp-Source: AKy350buG4bPyFyMS83rhjniPHydkSePEYgBaTDKNZ48qvCPbrcmXETHLl0aQrjPXtzHeQHaEUYlUg==
X-Received: by 2002:ac2:5fe6:0:b0:4e0:a426:6ddc with SMTP id s6-20020ac25fe6000000b004e0a4266ddcmr4409082lfg.0.1680076817323;
        Wed, 29 Mar 2023 01:00:17 -0700 (PDT)
Received: from [192.168.0.21] (78-11-189-27.static.ip.netia.com.pl. [78.11.189.27])
        by smtp.gmail.com with ESMTPSA id h13-20020a2e900d000000b00290b375a068sm5361127ljg.39.2023.03.29.01.00.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 01:00:17 -0700 (PDT)
Message-ID: <24105ee4-4ad0-9aaf-566a-07033aabdf4f@linaro.org>
Date:   Wed, 29 Mar 2023 10:00:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 1/2] dt-bindings: pinctrl: mediatek: deprecate custom
 drive strength property
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230327-cleanup-pinctrl-binding-v1-0-b695e32e4f2e@baylibre.com>
 <20230327-cleanup-pinctrl-binding-v1-1-b695e32e4f2e@baylibre.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230327-cleanup-pinctrl-binding-v1-1-b695e32e4f2e@baylibre.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28/03/2023 15:06, Alexandre Mergnat wrote:
> Deprecate mediatek,drive-strength-adv which shall not exist, that was an
> unnecessary property that leaked upstream from downstream kernels and
> there's no reason to use it.
> 
> The generic property drive-strength-microamp should be used instead.
> 
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  .../devicetree/bindings/pinctrl/mediatek,mt8183-pinctrl.yaml      | 8 ++++++--
>  .../devicetree/bindings/pinctrl/mediatek,mt8365-pinctrl.yaml      | 6 +++++-
>  2 files changed, 11 insertions(+), 3 deletions(-)
> 

Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>


Best regards,
Krzysztof

