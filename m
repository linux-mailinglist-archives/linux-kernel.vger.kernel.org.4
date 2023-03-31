Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 994416D2808
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 20:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233100AbjCaSqP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 14:46:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232901AbjCaSqM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 14:46:12 -0400
Received: from mail-yw1-x112b.google.com (mail-yw1-x112b.google.com [IPv6:2607:f8b0:4864:20::112b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 437C220DB5
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 11:46:05 -0700 (PDT)
Received: by mail-yw1-x112b.google.com with SMTP id 00721157ae682-5445009c26bso431743727b3.8
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 11:46:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112; t=1680288364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Zb6xLZTQTQfDOfnoLhLa6/IVI8QnMb1cauJ4IIp9pzk=;
        b=T8YJTdeMYbb5+drzr4PfwSAPqM0g2ur1tDsqj0l9TLQw8+V2H3RKsATUpFv8ILGFeF
         jRgBFoslWA5UWvvGMuGLLKHXjoEfsJxZm/z12TEe2Ri8mBh0nVkcqjnIuPrmYW2OVUyR
         SGb72wCQFq79qxru/phdmgHFLqNKp0YzEvHeOUu+3ej1ML+s4JtnpHUal4G1GDqGMk65
         yFegAuuOH8/q7xvzzcfwcOXRA32jXAxxKYjnX3GRrS/h//SZb5nyl+gqSulMDW+8RMYl
         P2hdl1o9gO5QKMKl9toztNs0lmlfUhD3IU6Y+rJlz3r0Mm1SGP57kPMihEtIJIH/JT1o
         MrQQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680288364;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Zb6xLZTQTQfDOfnoLhLa6/IVI8QnMb1cauJ4IIp9pzk=;
        b=CqIwfnqo2LDC978NyBPvQPG7d5EMJOCy7Osc37XDBgOD5Hfr7Pot9BeXPsjhaDG6Al
         e3yg3h9uhykcTIRFEr85wW0nLzraqmz1Cd6NYOSmFZ/kezmcQxj0NSUavaWoCgX47Yqh
         2qZBNDUIYd1ejL+XS1cWsqr47xAXTGRPYWvEDUz2fZEOFe08nW2WGWiZRhddZNQmsCNY
         tmjbrIMKJZDzDAarJ6YCSeNmYDVklknkydqa0Gb6rOlnI1AvjMvrIvUURHz6kAXrvFik
         wcPxK7Yar6/0hb3ny3zBLBLhLgFc7SLfmCPFUN0h01X/VhFkN8BjOngqJ3GPj222dp2E
         rD0w==
X-Gm-Message-State: AAQBX9e8X5udUBikT5crfzSVflYPAvfwO6Q9P/jBPIwjdBZDsdVG3HZ1
        Z7Hr/qnyecS+mRQZnzgRcX+yHFGYPufM9Y4aGXXnFg==
X-Google-Smtp-Source: AKy350bgwepPnwHMRW0YSZuNpQ8dtHQVLT8+IDDu10nrt86RgYns1z2FMH6EnSP3ABnDRvDAIqVyiIAEzbdJAM+G6zI=
X-Received: by 2002:a81:ac55:0:b0:546:1e9e:aa01 with SMTP id
 z21-20020a81ac55000000b005461e9eaa01mr6163297ywj.3.1680288364273; Fri, 31 Mar
 2023 11:46:04 -0700 (PDT)
MIME-Version: 1.0
References: <20230203-evk-board-support-v4-0-5cffe66a38c0@baylibre.com> <7hy1ncydtc.fsf@baylibre.com>
In-Reply-To: <7hy1ncydtc.fsf@baylibre.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
Date:   Fri, 31 Mar 2023 20:45:53 +0200
Message-ID: <CAFGrd9rKy9a4bUf1dkUtTogtWPFr5eu3jcsdaixi3hs_dWMwrg@mail.gmail.com>
Subject: Re: [PATCH v4 00/11] Improve the MT8365 SoC and EVK board support
To:     Kevin Hilman <khilman@baylibre.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-mmc@vger.kernel.org,
        linux-gpio@vger.kernel.org,
        Alexandre Bailon <abailon@baylibre.com>,
        Fabien Parent <fparent@baylibre.com>,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=0.0 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

You forgot to apply the patches merged by Matthias:

Changes in v4:
- Remove v3 applied patch from the serie:
  - arm64: dts: mediatek: add ethernet support for mt8365 SoC
  - arm64: dts: mediatek: add mmc support for mt8365 SoC
  - arm64: dts: mediatek: add mt6357 device-tree
  - arm64: dts: mediatek: add pwrap support to mt8365 SoC
  - arm64: dts: mediatek: Increase the size BL31 reserved memory

...

Changes in v3:
- Remove v2 applied patch from the serie:
  - dt-bindings: mmc: mediatek,mtk-sd: add mt8365

Regards,
Alex
