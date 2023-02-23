Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E2756A0ABD
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 14:37:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233157AbjBWNhY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 08:37:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233532AbjBWNhW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 08:37:22 -0500
Received: from mail-io1-xd2a.google.com (mail-io1-xd2a.google.com [IPv6:2607:f8b0:4864:20::d2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59BDE57D01
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:36:39 -0800 (PST)
Received: by mail-io1-xd2a.google.com with SMTP id f9so5657535iox.2
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 05:36:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=PljBaFwsOSiSajmSlW90uY5IAqYtGowFmvaV1Snd28o=;
        b=aghVqa0j350UpMSo80F/OvikYrBe+DeIfqUhFuWit/Y3cFWt0d87987aGDYP1QY7th
         dLAh1IxLwAL2KoWKKyY84gApMjNO2hRhr3zJ5NDCbGUoZEQscH+0cxlWxRVuDOVk2uGE
         oGNmC97taMtCBsJJwx5X332w7LFW7fvpbxf1M=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=PljBaFwsOSiSajmSlW90uY5IAqYtGowFmvaV1Snd28o=;
        b=NXEV/8CdKzmpe10ZjNJZUfY0hy5oyQ1Rk7qbiF5SYDLQJiUgbT/i4Wl0wA6PupcTlx
         VpIiNeb7xYO+Xj89z+xhQn0+iGAgYFNwvMR6cC+suZvmPd02fnJtc3Va9qnbaxTYDHC1
         lYN2ovAPsHb1TghKcrl8QC+rNkbsz+EWmsfF6+jPqUxf3R1exrOpJmp0gPAQTyQFrycS
         qBS7ifs/eQpB7pAAtf8Kk0VrwatJyZfIfQAZHMAX5TiXV65c5Gp9Sm7v/NKgB34WfXCd
         hyfCjBt9qGoUCxlT20uKw415mc5QF0+e559X6JpMBe8X3/4IRDl22zdCHf4OzL69dY5G
         9uWA==
X-Gm-Message-State: AO0yUKU8umKoCHQH9eokur90BTYsVuK11Y3ySiS/CVdvpx5IsNzwWY7J
        EovHSJxpEdXVHTYIQhnkPys8MrskcLhwlrJG/Tosxg==
X-Google-Smtp-Source: AK7set/mpYjZt1gR0m0p7QIkrMVPg+zxHDJsHk5bPOYLBOek2gQrZmEZtY4dYkIvYNlcS5eykCYem+K5vAxatmG+zfU=
X-Received: by 2002:a6b:d205:0:b0:71a:5a1f:544c with SMTP id
 q5-20020a6bd205000000b0071a5a1f544cmr1188867iob.5.1677159370385; Thu, 23 Feb
 2023 05:36:10 -0800 (PST)
MIME-Version: 1.0
References: <20230218111712.2380225-1-treapking@chromium.org>
 <20230218111712.2380225-2-treapking@chromium.org> <20230221154124.GA2584323-robh@kernel.org>
In-Reply-To: <20230221154124.GA2584323-robh@kernel.org>
From:   Pin-yen Lin <treapking@chromium.org>
Date:   Thu, 23 Feb 2023 21:35:59 +0800
Message-ID: <CAEXTbpctOtgE8uQJ7Bb8-ZRSjEwzQcQDegm1AuWfMmtDV0EbwA@mail.gmail.com>
Subject: Re: [PATCH v3 1/5] dt-bindings: display: bridge: Add ddc-i2c-bus for anx7688
To:     Rob Herring <robh@kernel.org>
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <rfoss@kernel.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Benson Leung <bleung@chromium.org>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        devicetree@vger.kernel.org,
        Nicolas Boichat <drinkcat@chromium.org>,
        chrome-platform@lists.linux.dev, linux-kernel@vger.kernel.org,
        Guenter Roeck <groeck@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

(Resend this with plaintext mode. Sorry for the previous spam.)

Hi Rob,

After some internal discussions, we decided to drop this series
because the driver is trying to do runtime routing of the display
signals, which is not supported by the current DRM system, even if we
can describe the design in the device tree. I'm explaining our use
case as a record, and I can follow up on the mtk_hdmi.c change if
anyone is interested.

The more detailed schematics looks like:
   +----------+    +----------------+    +-----------+
   |   MTK    |    |                |    |   HDMI    |
   |   HDMI   +--->|    TS3DV642    +--->| connector |
   |  bridge  |    |                |    +-----------+
   +----------+    |                |
                   |    HDMI MUX    |    +-------------+
                   |                |    |  anx7688    |   +-----------+
   +----------+    |                |    |  HDMI to DP |   |  USB-C    |
   | cros EC  +--->|                +--->|  bridge     +-->| connector |
   +----------+    +----------------+    +-------------+   +-----------+

The TS3DV642 HDMI MUX is controlled by the CrOS EC to switch the HDMI
signal between two output ports, and the generic-display-mux driver
was trying to control the downstream bridges according to the GPIO
status reported by EC. However, as far as I know, this kind of runtime
routing is not supported by DRM.

And, it can work fine if we only describe the following design in DT:

  +---------+   +-------------+   +-----------+
  |  MTK    |   |  anx7688    |   |  USB-C    |
  |  HDMI   +-->|  HDMI to DP +-->| connector |
  |  bridge |   |  bridge     |   +-----------+
  +---------+   +-------------+

This can work because the anx7688 driver won't reject any display
modes when the DP lane count is 0 ([1]), which is true when the HDMI
connector is used.

Thanks for your time for reviewing this series and sorry for not
explaining everything clearly at the beginning.

[1]: https://elixir.bootlin.com/linux/v6.2/source/drivers/gpu/drm/bridge/cros-ec-anx7688.c#L87

Regards,
Pin-yen


On Tue, Feb 21, 2023 at 11:41 PM Rob Herring <robh@kernel.org> wrote:
>
> On Sat, Feb 18, 2023 at 07:17:08PM +0800, Pin-yen Lin wrote:
> > Introduce a optional "ddc-i2c-bus" property for anx7688 bridge. This
> > allows the bridge to register a .get_edid callback.
>
> What's .get_edid? This is a binding and is independent of Linux.
>
> >
> > Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> > ---
> >
> > Changes in v3:
> > - New in v3
> >
> >  .../bindings/display/bridge/google,cros-ec-anx7688.yaml      | 5 +++++
> >  1 file changed, 5 insertions(+)
> >
> > diff --git a/Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml b/Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml
> > index a44d025d33bd..9d5ce8172e88 100644
> > --- a/Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml
> > +++ b/Documentation/devicetree/bindings/display/bridge/google,cros-ec-anx7688.yaml
> > @@ -25,6 +25,10 @@ properties:
> >      maxItems: 1
> >      description: I2C address of the device.
> >
> > +  ddc-i2c-bus:
> > +    description: phandle link to the I2C controller used for DDC EDID probing
> > +    $ref: /schemas/types.yaml#/definitions/phandle
> > +
>
> No, this belongs in the connector node. The DDC signals are routed to
> the connector, not the bridge chip.
>
> Rob
