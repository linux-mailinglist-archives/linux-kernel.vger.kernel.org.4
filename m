Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A0BA70A154
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 23:10:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230482AbjESVKM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 May 2023 17:10:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44170 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229960AbjESVKJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 May 2023 17:10:09 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6096A199A;
        Fri, 19 May 2023 14:09:42 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-96b4ed40d97so575742466b.0;
        Fri, 19 May 2023 14:09:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1684530580; x=1687122580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=TorRBbiNSrshF0ap3UL67FrkImFt8D/40YtUQbz9REQ=;
        b=dpaHBYN0mAs5TZA7Iw/DfHqd5WpnxHSJmDSJe2Y/Qv7suXxR+zk9+Y/a8oNdaR5xs1
         KubdtoNaExtjhH4Ci1MCYZObY1Ei4uK19ae26VvY/zHjHESnwmEqTBuYpn0NRy8O2CHB
         XfYU/6neCWR/C5ivNQvsB15+a5rPECxIb6RWOO39MlCGQ9LmmFXEOTjok03KbvEEBWEQ
         IqOkWYomFa7p9KiFiArPe3YXNBSTDVp5fC0rmo525fVCAhYeZ6+kdmcWbKoQ1Qnc6CqH
         Pws5Ptp20mQwd87vfjkoFPqQffwywoaVjpnvQPhXW2/DRtEFciU3RoEXoHZWvAJGh+oE
         kj/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684530580; x=1687122580;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=TorRBbiNSrshF0ap3UL67FrkImFt8D/40YtUQbz9REQ=;
        b=YpAwvkL4LSa3ovYgsEDNE5J5BHs8Pppvm0Hr+aaDOQghBmllpl4Kx4dlMO2VClhGHZ
         BZ3opj0IAtoGFN5gXU0oYaGZ43418sXsl6aF3NQLgPERu5onjXwkrxjqTid4OLyKQ2zD
         xhZ+6iWf4SAo41j13sKTGaXY1+l7vzrds3l5PFnkg3kQdeZCQEsarHP9nNMU20YT5ZuI
         9j7+E2Q24IF9lsw5fKVVztNNyF6SuaKAD0qs0fYH9H2rMi/dtgTHkLxSwRrlnEeAzdjV
         XPDxMsrf6+WhOtAFWfR5liQsRppPx/pSYYQxrEE+NW1zXq7BsiZlq/JLFafdvDl0uZok
         2/3Q==
X-Gm-Message-State: AC+VfDzO2HFYgv/erW4LBH0ibMll/Hv7ZijHlIUqivP3qGLbwAHh0mYt
        7HuGawV57t8aP4ZHjLFJYuTU5peXMw3p+BOajkA=
X-Google-Smtp-Source: ACHHUZ6s33Zsi7MTUXzy5qgLERqDb+ABr1XwN5aDTGrd5iCKsQ+pQKlGN2FqdAmEp4ZnNXjwMFvf+/hgUtyP29y/vHc=
X-Received: by 2002:a17:907:971f:b0:96a:ec5c:687b with SMTP id
 jg31-20020a170907971f00b0096aec5c687bmr3096717ejc.64.1684530579899; Fri, 19
 May 2023 14:09:39 -0700 (PDT)
MIME-Version: 1.0
References: <20230517133309.9874-1-ddrokosov@sberdevices.ru> <20230517133309.9874-6-ddrokosov@sberdevices.ru>
In-Reply-To: <20230517133309.9874-6-ddrokosov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Fri, 19 May 2023 23:09:29 +0200
Message-ID: <CAFBinCC3kQ9Nz3R2W-Qj9tbPJfS8JsB_4AkmPgS6xpQ96DBy2w@mail.gmail.com>
Subject: Re: [PATCH v15 5/6] dt-bindings: clock: meson: add A1 Peripherals
 clock controller bindings
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>,
        krzysztof.kozlowski+dt@linaro.org
Cc:     neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        khilman@baylibre.com, jian.hu@amlogic.com, kernel@sberdevices.ru,
        rockosov@gmail.com, linux-amlogic@lists.infradead.org,
        linux-clk@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krzysztof and Dmitry,

On Wed, May 17, 2023 at 3:33=E2=80=AFPM Dmitry Rokosov <ddrokosov@sberdevic=
es.ru> wrote:
[...]
> +  clocks:
> +    items:
> +      - description: input fixed pll div2
> +      - description: input fixed pll div3
> +      - description: input fixed pll div5
> +      - description: input fixed pll div7
> +      - description: input hifi pll
> +      - description: input oscillator (usually at 24MHz)
> +
> +  clock-names:
> +    items:
> +      - const: fclk_div2
> +      - const: fclk_div3
> +      - const: fclk_div5
> +      - const: fclk_div7
> +      - const: hifi_pll
> +      - const: xtal
This IP block has at least one additional input called "sys_pll_div16".
My understanding is that the "sys_pll_div16" clock is generated by the
CPU clock controller. Support for the CPU clock controller
(dt-bindings and a driver) will be added at a later time by Dmitry.
How can we manage incrementally implementing the clock controllers?
From a hardware perspective the "sys_pll_div16" input is mandatory.
How to manage this in the .dts patches then (for example: does this
mean that Dmitry can only add the clock controller to the .dts when
all clock controller bindings have been implemented - or is there
another way)?


Best regards,
Martin
