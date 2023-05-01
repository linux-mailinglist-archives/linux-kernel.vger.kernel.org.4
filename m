Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16B416F364F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 May 2023 20:52:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232621AbjEASw0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 May 2023 14:52:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37760 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229915AbjEASwY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 May 2023 14:52:24 -0400
Received: from mail-ej1-x62a.google.com (mail-ej1-x62a.google.com [IPv6:2a00:1450:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92A332136;
        Mon,  1 May 2023 11:51:44 -0700 (PDT)
Received: by mail-ej1-x62a.google.com with SMTP id a640c23a62f3a-94f3cd32799so579330666b.0;
        Mon, 01 May 2023 11:51:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20221208; t=1682967102; x=1685559102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6zP0vMHwmZXieSLSNoKwDOqfsPAbGPB2SLcEW5GPdQQ=;
        b=qroS6O6kMMC6J1KDt4ywXQ/bMsQxOvCbWfZ/Z7UL9WvtneEH9hyOzLJKZSuA1XDjC2
         z8vTFN503MhQ30OdZzw+3uqIn07y95dgWsPGJ8Vqyg9tmU/MJqQ0GHtCUkTIAqvst54A
         J/LPoj2XO0Um/QW62ThpAvfq7Xj2QHWR/UVu29rhbcrfbK5w/LMXx9iyeZ80PPFfaJs2
         PiuQ0N9bhznCxeGk3c+iBVG1lJTdxhAtP1NO3Z1RsnLPjdy6hQ+VxioLQIWmCpbddvM6
         w2IEdLAalCYnNAvV/8kyXEMSz4JX8cXAP9xOpHwDq0mGbD2TS9kn+o6qSlkGpjzBu850
         iC6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682967102; x=1685559102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6zP0vMHwmZXieSLSNoKwDOqfsPAbGPB2SLcEW5GPdQQ=;
        b=Lk89b/m9RDUe+FLMH0K1ekwkQShy5tjsLFgS02W4i26DkApaku8E1ILG1PBxM1nNSG
         VpzU8vXTyZFCVmKlP1uFuKBgYwpEgg06D9AOWXwOB/DALP0Xhn6R/fnm0WsQevUSjyRl
         /uSaRDRUi5G5ym8mwACRQm7lx0A23NtZuEMwXgLwsircmpuhOCIoTWghHUZcN/eXcrbe
         wBflhSB5YVjzWqFiCW8kVL4L3SAMS7brj3U43GEwqRK6tdTabPKV0kpQNHUrnoJxoAdr
         JxAfurSUnEQfJclOOSorFZnHJxBcMH/3NJl6GWjJqjKWUFw7Xqc6wbp7lra12kkUF1KF
         0ebQ==
X-Gm-Message-State: AC+VfDyK1fd2gLDh1220mnL90B8/pLaRn+Mkm3Ut+4ce7auGv+9YZ2u8
        3dUgomak3BBrzW0etIXQ06ofxPq8l8w9JD+WHfI=
X-Google-Smtp-Source: ACHHUZ7Me7pTW5yueWPmd5/+A3AyHpU4s8ymVXhEcf0C84hqs66/hFNO8zjhF4mjKtwXfMXaDosvgVn1TOg7qkbMEBg=
X-Received: by 2002:a17:907:7da9:b0:94e:c938:1987 with SMTP id
 oz41-20020a1709077da900b0094ec9381987mr14785122ejc.7.1682967102192; Mon, 01
 May 2023 11:51:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230426095805.15338-1-ddrokosov@sberdevices.ru> <20230426095805.15338-6-ddrokosov@sberdevices.ru>
In-Reply-To: <20230426095805.15338-6-ddrokosov@sberdevices.ru>
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Date:   Mon, 1 May 2023 20:51:30 +0200
Message-ID: <CAFBinCCdoaNuQymcjp5j9MHn2jpPWMqXe-+EgBo=5Ot8Bwaofw@mail.gmail.com>
Subject: Re: [PATCH v14 5/6] dt-bindings: clock: meson: add A1 Peripherals
 clock controller bindings
To:     Dmitry Rokosov <ddrokosov@sberdevices.ru>
Cc:     neil.armstrong@linaro.org, jbrunet@baylibre.com,
        mturquette@baylibre.com, sboyd@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, khilman@baylibre.com,
        jian.hu@amlogic.com, kernel@sberdevices.ru, rockosov@gmail.com,
        linux-amlogic@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dmitry,

On Wed, Apr 26, 2023 at 11:58=E2=80=AFAM Dmitry Rokosov
<ddrokosov@sberdevices.ru> wrote:
>
> Add the documentation for Amlogic A1 Peripherals clock driver,
> and A1 Peripherals clock controller bindings.
Maybe a native English speaker can comment on whether it's
"peripheral" or "peripherals".

[...]
> Signed-off-by: Jian Hu <jian.hu@amlogic.com>
> Signed-off-by: Dmitry Rokosov <ddrokosov@sberdevices.ru>
> Reviewed-by: Rob Herring <robh@kernel.org>
> ---
>  .../bindings/clock/amlogic,a1-clkc.yaml       |  73 +++++++++++
>  .../bindings/clock/amlogic,a1-pll-clkc.yaml   |   5 +-
>  include/dt-bindings/clock/amlogic,a1-clkc.h   | 114 ++++++++++++++++++
I have seen that Yu Tu named the S4 peripheral clock controller
binding and driver "s4-peripherals-clkc" [0].
Does it make sense to apply the same naming here as well?


Best regards,
Martin


[0] https://lore.kernel.org/linux-amlogic/20230417065005.24967-3-yu.tu@amlo=
gic.com/
