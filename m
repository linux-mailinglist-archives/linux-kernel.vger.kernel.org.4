Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E19716B2609
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 15:00:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229611AbjCIOAG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 09:00:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231461AbjCIN7l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 08:59:41 -0500
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278C9F184B
        for <linux-kernel@vger.kernel.org>; Thu,  9 Mar 2023 05:56:45 -0800 (PST)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-53916ab0c6bso36326857b3.7
        for <linux-kernel@vger.kernel.org>; Thu, 09 Mar 2023 05:56:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678370204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Vhxj3g02U6JfJorCEqukLhEPbi5ScM6y20Fj/uWtxsc=;
        b=M6OUagewNatTVBWogs7CL7Frl+ekF/MC2BZgxAEhzQWeyuSsXaRpkf4c99DXMGsgc6
         GIkzhUNU2BURb1j3QuJVpX9peQPez+0A+Lwv3I+Pr4W55I9ScaDo7aFhChRp0sadmIiL
         0lKL1TZ0CxVdMF8HoIQ/7ufJEuKA5Dra+MJuKUyHRmB9rs9CuHe4y70Qv5xVu1WwZK0B
         1vXdXtOHzSOCFokSbLcL3GvOf4lTYuXwXKVhUa8ogJNH81T3PpCdFdiMh5PpBeOSTCOE
         8RasSI/d7wlsztguwb8tqjCkoykqGh1gdjoQgiePJjOS2aABefBearXVltjCsf9a3xlk
         bqLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678370204;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Vhxj3g02U6JfJorCEqukLhEPbi5ScM6y20Fj/uWtxsc=;
        b=2im4j61M5FZb7YGJ2iRK5EiOwNsStk1xDYF1l042XHt4/cLCA0B9qfIhAV1cPVnfJW
         tEMJuRTLw8OsxyXB3R4WNv/UE3qmIFUqoR8UPEVag/4YqG7uQUIOhr6QAKg65Wg0Bum9
         Dc1VCvS+iwo2qTeEW8xWB3mQaFmit58Xpq3kJNVnDMJTLGEjIFzm0gHU4oDa+HLoK8Mc
         Cz2LA85OfHPvqA2calv9mlzfgG2XeOtyHXT5MftHTnnbx75LiICkcZmqaeM9w09k5Zlv
         vz9eO3z/JijsTAvRDDfWdjhCjBBANwgUTf4Rr59w3y//o/FT4VHgQf8U75oJDrdzjAXk
         MCSA==
X-Gm-Message-State: AO0yUKUWlWtfttQCfg771SgBWX0RDf/Bj7qlKTtmuvgAgFhYpHH04eg7
        ZXTArBjK3HTIjCI4lcEwfxo0fSCi+fWPz0VLo/nKqg==
X-Google-Smtp-Source: AK7set8C8YjXMi5gSQYXdOX+ayCa5RjgmjqpOw5RNChqcaFChToV9jRVJLPT0IsYxq4ctbaJ0y/nV2OJRYi9K+NoTvc=
X-Received: by 2002:a81:ad63:0:b0:52a:9f66:80c6 with SMTP id
 l35-20020a81ad63000000b0052a9f6680c6mr13521476ywk.9.1678370204353; Thu, 09
 Mar 2023 05:56:44 -0800 (PST)
MIME-Version: 1.0
References: <20230203-evk-board-support-v2-0-6ec7cdb10ccf@baylibre.com> <20230203-evk-board-support-v2-3-6ec7cdb10ccf@baylibre.com>
In-Reply-To: <20230203-evk-board-support-v2-3-6ec7cdb10ccf@baylibre.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Thu, 9 Mar 2023 14:56:33 +0100
Message-ID: <CACRpkdb+CQFOW8zjK2pGhRX=tBUcJAyVN=ohEt8eccndA2nYpA@mail.gmail.com>
Subject: Re: [PATCH v2 03/18] dt-bindings: pinctrl: mediatek,mt8365-pinctrl:
 add drive strength property
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>,
        =?UTF-8?Q?Bernhard_Rosenkr=C3=A4nzer?= <bero@baylibre.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, Alexandre Bailon <abailon@baylibre.com>,
        devicetree@vger.kernel.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 7, 2023 at 2:18 PM Alexandre Mergnat <amergnat@baylibre.com> wrote:

> This SoC is able to drive the following output current:
> - 2 mA
> - 4 mA
> - 6 mA
> - 8 mA
> - 10 mA
> - 12 mA
> - 14 mA
> - 16 mA
>
> Then drive-strength property is set with enum to reflect its HW capability.
>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Is this something I can apply directly to the pinctrl tree once the DT
maintainers have
had a chance to look at it?

Yours,
Linus Walleij
