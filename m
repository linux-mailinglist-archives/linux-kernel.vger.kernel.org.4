Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 576BB714103
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 00:33:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229627AbjE1Wdb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 18:33:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjE1Wd3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 18:33:29 -0400
Received: from mail-pf1-x433.google.com (mail-pf1-x433.google.com [IPv6:2607:f8b0:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E434BBB;
        Sun, 28 May 2023 15:33:28 -0700 (PDT)
Received: by mail-pf1-x433.google.com with SMTP id d2e1a72fcca58-64f1f133c37so662838b3a.0;
        Sun, 28 May 2023 15:33:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685313208; x=1687905208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=mxYoiLc/vExDmL+kL0vg9M26eP/FFN+ipF+7USiz+Qs=;
        b=gMbAwg6l3nnCWubWaLzBclbrKMBRi44kUeMeitvED+x42Gd1QOaUYFK8E5QcFIslAH
         7/f3ng1LLdYB3fIVseXuQkSl4urWwFKiOIhDINrl+8YvwTtreXEJFRrKPplr0sUaMroC
         82pzrPYVxMf1vsd7gwce1CJY9XCf81Tth7Q3IpGnZJMn4Y9Xyrb1QgTOE9lyE7mC4Yxs
         bzAR82UF8jRwYmldHMyKCj+yq7ZrgTPT60v/MAqLLU0P/GPEJR7ksanTbHH08LW/qs33
         kEEAB4FsC5zwYBQfWbLiLdUBEFirw+uauOxY6k+vZgDKxJNBTx8UPWSGl+1C9FI5KTt6
         Zc0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685313208; x=1687905208;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=mxYoiLc/vExDmL+kL0vg9M26eP/FFN+ipF+7USiz+Qs=;
        b=V/l+yufMweiuQafPo8+C+LOe4+Yr64tM8/RV4mq3iiNfMxZqTiZlhXGv4ZgGd7PkLK
         mZm7ihiInqFkZ0J4XHUVV0XAH4obvyHliJsLMF5bAjU9B4ac+hGNRzEmxFeWWz4POsIz
         wQoBGBbaNe3wydcUe8zRoN3+dbXv7sP/NnLxNqzoHlgKwsVGGdH/SxbE0z45OVByEvnd
         sUxDSPXCqkU/SQTrKIRg/3klOjI2qmB+UJrCH/vlzJJi5nxxOiiGPKcvP1QDaUT97QG3
         eFeyz5WTaKTU6tVyywnxVRhkmkBlH1ZKu7Sn8CGm8rH8SVlcvIGa11QTBr0kzDu/2kBj
         5NxA==
X-Gm-Message-State: AC+VfDxwB+qwgJmYjT7weknnScfnad0ZX2MQtMbYBup3vYVhTZEK/J8M
        eIjncAqk5pjw7C/wXgjoytNTlkZrN4SRcBBMY1w=
X-Google-Smtp-Source: ACHHUZ4Ja+1pV5iNINplvUcfTz1BH1UWGnLaYW6l9L568p9LWziUPWoWl2d5t4viZU5ppC3rjBoBaqwfHYVozXnQ/W8=
X-Received: by 2002:a17:903:32c2:b0:1b0:4680:60 with SMTP id
 i2-20020a17090332c200b001b046800060mr713375plr.1.1685313208104; Sun, 28 May
 2023 15:33:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230528132727.3933-1-aford173@gmail.com>
In-Reply-To: <20230528132727.3933-1-aford173@gmail.com>
From:   Fabio Estevam <festevam@gmail.com>
Date:   Sun, 28 May 2023 19:33:17 -0300
Message-ID: <CAOMZO5Ct1Ns353rTWF-B=wR6O9h9O9wcR21cTOXaU1b030=QgQ@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: bridge: samsung-dsim: Make some flags optional
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Robert Foss <rfoss@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        aford@beaconembedded.com,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        linux-kernel@vger.kernel.org,
        Conor Dooley <conor.dooley@microchip.com>,
        Rob Herring <robh+dt@kernel.org>,
        Jagan Teki <jagan@amarulasolutions.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        devicetree@vger.kernel.org,
        Marek Szyprowski <m.szyprowski@samsung.com>
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

On Sun, May 28, 2023 at 10:27=E2=80=AFAM Adam Ford <aford173@gmail.com> wro=
te:
>
> In the event a device is connected to the samsung-dsim
> controller that doesn't support the burst-clock, the
> driver is able to get the requested pixel clock from the
> attached device or bridge.  In these instances, the
> samsung,burst-clock-frequency isn't needed, so remove
> it from the required list.
>
> The pll-clock frequency can be set by the device tree entry
> for samsung,pll-clock-frequency, but in some cases, the
> pll-clock may have the same clock rate as sclk_mipi clock.
> If they are equal, this flag is not needed since the driver
> will use the sclk_mipi rate as a fallback.
>
> Signed-off-by: Adam Ford <aford173@gmail.com>
> Reviewed-by: Conor Dooley <conor.dooley@microchip.com>
> ---
> V2:  Split from driver series.  Re-word updates for burst
> and pll-clock frequency.

Reviewed-by: Fabio Estevam <festevam@gmail.com>
