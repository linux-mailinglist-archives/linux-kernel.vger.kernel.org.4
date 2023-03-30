Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69EAB6D0839
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232446AbjC3O0l (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:26:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231852AbjC3O0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:26:40 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44AFA114
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:26:39 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id e65so23644008ybh.10
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 07:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google; t=1680186398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YYAj9pqSL7hDBw0RLOL8GO8jrfaq2Goh8quwi8z2P+U=;
        b=o+Dzd58+BP9xg6ilalPvcpuhfUPZR3bAjkdMgibJu8M4CaBS+4HpGC8nrvhXslDKi5
         R9ko5gdcv4ZXVQMu0pWzS75IsVcF1Ton2sDrpHiZBqUMI7Yz5iqXkHTN6D3PcqbHvvYy
         6cQ7sBlSC6cI6kQwBTscSXjNqYmxod8+5Ol0c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680186398;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YYAj9pqSL7hDBw0RLOL8GO8jrfaq2Goh8quwi8z2P+U=;
        b=c//Cn8kpr8MBT1xlQ9SGSS2rcFSfRzr0+0CBtBzpZo20jVbsdXmi62ciTeR9F9OY2q
         4LtGehNuIcQ4ir5v1BLPet6vzyiWBJHW8+FHpVosO927Wfdvx9qRaptTfefFs8bBDCE7
         JsfIoITMxQZ3xYQS7Bp6r+qr8lNQcZJxEUqI7Hd7760Z22tilEvjSMBza3JdW9NT6wwH
         PYPlZt+OTQQc8qrdEA2CgY5rPh7WXDclu2OpYS5JghpM+W4sHf9Phq7UHjOZSYTiFweR
         q365BTXNbwT1AIWf0JkOsqJ82ROqPJd4y20qGEZNbiybVcVkATo0kPQ9nYHbfsnOOUJF
         Lj9Q==
X-Gm-Message-State: AAQBX9emAtg+iLb0Vi4joBNogSrGtujtBLf8FHVjbv5zjrBW5FhqHYdn
        2gM56SpquLrOb5XrFv09z/T7TC60jCj5ATRlXSCMNw==
X-Google-Smtp-Source: AKy350YNV+2K9E9YDUGfrkxdbFk0oBtF0klAUoQNYSyuJPRoz9XL+Uy7LTLKyvnC+os/wbNNqOe+3HzdkUlRBHdlxGw=
X-Received: by 2002:a05:6902:154a:b0:b3c:637f:ad00 with SMTP id
 r10-20020a056902154a00b00b3c637fad00mr16184012ybu.5.1680186398403; Thu, 30
 Mar 2023 07:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230330101752.429804-1-francesco@dolcini.it> <20230330101752.429804-2-francesco@dolcini.it>
In-Reply-To: <20230330101752.429804-2-francesco@dolcini.it>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 30 Mar 2023 19:56:26 +0530
Message-ID: <CAMty3ZAQPEnCgj9r+tsuqiOzRzHPnKSEXcDqE7LKHH16Zu2Wvw@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] dt-bindings: display: bridge: sn65dsi83: Add DSI
 video mode
To:     Francesco Dolcini <francesco@dolcini.it>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        dri-devel@lists.freedesktop.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Marek Vasut <marex@denx.de>, devicetree@vger.kernel.org,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 3:48=E2=80=AFPM Francesco Dolcini <francesco@dolcin=
i.it> wrote:
>
> From: Francesco Dolcini <francesco.dolcini@toradex.com>
>
> SN65DSI8[34] device supports burst video mode and non-burst video mode
> with sync events or with sync pulses packet transmission as described in
> the DSI specification.
>
> Add property to select the expected mode, this allows for example to
> select a mode that is compatible with the DSI host interface.
>
> Signed-off-by: Francesco Dolcini <francesco.dolcini@toradex.com>
> ---
>  .../devicetree/bindings/display/bridge/ti,sn65dsi83.yaml  | 8 ++++++++
>  1 file changed, 8 insertions(+)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi8=
3.yaml b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> index 48a97bb3e2e0..ebee16726b02 100644
> --- a/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/ti,sn65dsi83.yaml
> @@ -35,6 +35,14 @@ properties:
>    vcc-supply:
>      description: A 1.8V power supply (see regulator/regulator.yaml).
>
> +  dsi-video-mode:
> +    description: |
> +      0 - burst-mode
> +      1 - non-burst with sync event
> +      2 - non-burst with sync pulse
> +    $ref: /schemas/types.yaml#/definitions/uint32
> +    enum: [0, 1, 2]

I'm thinking this can go to dsi common code since the video modes are
common across all controllers and make the core initialize the default
and update if any sink devices are willing to change the modes. Sound
like a big move but worth useful.

Thanks,
Jagan.
