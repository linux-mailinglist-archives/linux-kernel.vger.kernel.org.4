Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707BC6EFC37
	for <lists+linux-kernel@lfdr.de>; Wed, 26 Apr 2023 23:10:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239905AbjDZVK3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 26 Apr 2023 17:10:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239746AbjDZVK1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Apr 2023 17:10:27 -0400
Received: from mail-oo1-f47.google.com (mail-oo1-f47.google.com [209.85.161.47])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9E413ABD;
        Wed, 26 Apr 2023 14:10:08 -0700 (PDT)
Received: by mail-oo1-f47.google.com with SMTP id 006d021491bc7-5475e0147c9so2209959eaf.1;
        Wed, 26 Apr 2023 14:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682543408; x=1685135408;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mu0CENun8oFZTueHArmv4VmXak5XmpNKe7QDDJtnNAM=;
        b=EYUEHhuwHQ/DevkXkerGPX0wXksDma91oKP96pfCY2B2PMqWkhkGiF97muhbmTFvs6
         HpXkOr1mKTiyIDSVdM3I7j4Wb24UmaFe/DZdlG0OyODiU3D2FkqXmiRd2BAsTHSVERJk
         1Y7c9pYMkqDpbsxpikyGoe9QlmTJVa3yNbuN8ltSxaz0SXxka50WHB4JflMH41ePTNn4
         wiR6jq9sbI3j1wrnLvt0Z/Kj19Rq4d453azGDJfZdJWeXbLeivtEgsgu8ATDUn4p9r6n
         STtM/dBCDPPHWuVYNRHrmq0nWHsKA8p5WIp3J1ORExnavczryQYhIU/ZFW8C1MOY0k3C
         m1Qg==
X-Gm-Message-State: AAQBX9e+H0CXA8z8jur89r5M/M/shkFtpsWBpGTkY3EjPz7asX2TF3S5
        ljlFinn7kH+z/KS7IGL9gg==
X-Google-Smtp-Source: AKy350ZiQQZVuONWZ4qZ3rjKWFp/+fC6WoEIdnMn+PbZciaDx8naIN2vbcz6/nEY74IMf5U9XKf8aQ==
X-Received: by 2002:a05:6808:21a2:b0:38e:6cb1:298b with SMTP id be34-20020a05680821a200b0038e6cb1298bmr11228463oib.53.1682543407669;
        Wed, 26 Apr 2023 14:10:07 -0700 (PDT)
Received: from robh_at_kernel.org (66-90-144-107.dyn.grandenetworks.net. [66.90.144.107])
        by smtp.gmail.com with ESMTPSA id b82-20020aca3455000000b0038ec2b341c2sm4366485oia.12.2023.04.26.14.10.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Apr 2023 14:10:07 -0700 (PDT)
Received: (nullmailer pid 1240028 invoked by uid 1000);
        Wed, 26 Apr 2023 21:10:06 -0000
Date:   Wed, 26 Apr 2023 16:10:06 -0500
From:   Rob Herring <robh@kernel.org>
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>
Subject: Re: [PATCH v6 03/12] dt-bindings: watchdog: mediatek,mtk-wdt: add
 mt8365
Message-ID: <20230426211006.GA1227761-robh@kernel.org>
References: <20230203-evk-board-support-v6-0-8d6b1cfe7f29@baylibre.com>
 <20230203-evk-board-support-v6-3-8d6b1cfe7f29@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230203-evk-board-support-v6-3-8d6b1cfe7f29@baylibre.com>
X-Spam-Status: No, score=-1.2 required=5.0 tests=BAYES_00,
        FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,
        RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 26, 2023 at 12:49:03PM +0200, Alexandre Mergnat wrote:
> Add binding description for mediatek,mt8365-wdt
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Tested-by: Kevin Hilman <khilman@baylibre.com>
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> ---
>  Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
>  1 file changed, 1 insertion(+)

This has already been applied by Guenter.

Rob
