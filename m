Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 628767139AA
	for <lists+linux-kernel@lfdr.de>; Sun, 28 May 2023 15:34:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229615AbjE1NeR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 May 2023 09:34:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229459AbjE1NeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 May 2023 09:34:15 -0400
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A5C3BD
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 06:34:14 -0700 (PDT)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-565ee3d14c2so7313367b3.2
        for <linux-kernel@vger.kernel.org>; Sun, 28 May 2023 06:34:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1685280853; x=1687872853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=UrEVsTM5vKIOld13EPKPZ9FVBGQ0zgJjZs6J4jvV/zQ=;
        b=YEjaEvz9E26Gf7MMtO58BQM3WmZoF5U+bwreby0QKR26gtFeB1Foq5RusqLrwrXals
         YXnJpK7564brgnQ7/jDKuyTTQAyKBZBzHi1PDgTEzl7zVqeF1DTC7tzvvqf8RUGsTM93
         DcDy9hIRswj5ipNgSdPu78QG5pRLSjPl7YMqY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685280853; x=1687872853;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=UrEVsTM5vKIOld13EPKPZ9FVBGQ0zgJjZs6J4jvV/zQ=;
        b=Hm64Agrg5ON9SQJmVXHMCujPAvIApmtMLV8jK6zesfLQ0EXnS6ja3hL5KNB/4A6mLr
         9rPtmvj0sLBcSiNhcaK4T2k8I8NDg0tUC+/T3szaLYp6aNw6u820QVtEh61AkLdZgMbD
         OQhIUOEWr7JNMaEPnut3O8AL20E/YPz0HFi6qJkBKJVRGxMMEeba4XF/W0fWiKv2BX4p
         TE7qmDFK+gbtRX2a/88Mfot2CKrYIl9XZup996sE49y2LAc70rmQ8yjvA+JQGcg1hELA
         bHWrBGjOCd7QOmyCkhRTG9rqYFvDHfUNSSABN6+yfIQieeD50diT2VtAy48kCqeMi3nm
         PE0g==
X-Gm-Message-State: AC+VfDykoKDcO6QhhaNL3DZlc2E3JAvoZKqY//qeU5pUyPzhcU982AQI
        AQAC77nLpMpebZJp3xwK+ui3MZKtBpFjxJFQracpbg==
X-Google-Smtp-Source: ACHHUZ6rNq1797W4VSS1+Dgqg217ZXWZz44DxffkTuC/Vs+7FWyf4bszCFSBGg9ZFpxgoyZiB9LuVSp5sjU/rWSWyb8=
X-Received: by 2002:a0d:e747:0:b0:561:43bf:fc8e with SMTP id
 q68-20020a0de747000000b0056143bffc8emr9154349ywe.10.1685280853448; Sun, 28
 May 2023 06:34:13 -0700 (PDT)
MIME-Version: 1.0
References: <20230528132727.3933-1-aford173@gmail.com>
In-Reply-To: <20230528132727.3933-1-aford173@gmail.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Sun, 28 May 2023 19:04:01 +0530
Message-ID: <CAMty3ZB=XfMr7k31yHzZ+YHFxT0ifCbmR4+s5yw+YgTSJE0Jxg@mail.gmail.com>
Subject: Re: [PATCH V2] dt-bindings: bridge: samsung-dsim: Make some flags optional
To:     Adam Ford <aford173@gmail.com>
Cc:     dri-devel@lists.freedesktop.org, aford@beaconembedded.com,
        Conor Dooley <conor.dooley@microchip.com>,
        Inki Dae <inki.dae@samsung.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 28, 2023 at 6:57=E2=80=AFPM Adam Ford <aford173@gmail.com> wrot=
e:
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
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/samsung,mip=
i-dsim.yaml b/Documentation/devicetree/bindings/display/bridge/samsung,mipi=
-dsim.yaml
> index 9f61ebdfefa8..06b6c44d4641 100644
> --- a/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsim.=
yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/samsung,mipi-dsim.=
yaml
> @@ -70,7 +70,9 @@ properties:
>    samsung,burst-clock-frequency:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
> -      DSIM high speed burst mode frequency.
> +      DSIM high speed burst mode frequency.  If absent,
> +      the pixel clock from the attached device or bridge
> +      will be used instead.
>
>    samsung,esc-clock-frequency:
>      $ref: /schemas/types.yaml#/definitions/uint32
> @@ -80,7 +82,8 @@ properties:
>    samsung,pll-clock-frequency:
>      $ref: /schemas/types.yaml#/definitions/uint32
>      description:
> -      DSIM oscillator clock frequency.
> +      DSIM oscillator clock frequency. If absent, the clock frequency
> +      of sclk_mipi will be used instead.

Maybe this explicit comment won't require as it is not listed in "required"

Reviewed-by: Jagan Teki <jagan@amarulasolutions.com>
