Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4AFE6633796
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Nov 2022 09:55:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232911AbiKVIz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Nov 2022 03:55:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232361AbiKVIzY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Nov 2022 03:55:24 -0500
Received: from mail-qt1-f181.google.com (mail-qt1-f181.google.com [209.85.160.181])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DD2193F1;
        Tue, 22 Nov 2022 00:55:24 -0800 (PST)
Received: by mail-qt1-f181.google.com with SMTP id s4so8860017qtx.6;
        Tue, 22 Nov 2022 00:55:24 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P7qk9S0cPIQ0L5zgnqXV8Oc65l49/AfnuuGAj/cKJTk=;
        b=XM4pgryGinKaUIuRWHujuOGyGex/kjQfJrimqTpuOdTdknmVrSV2IEQhzIXkZ6uwQg
         /mrRsuXyI9BErkOJ5ucN38tJ4oFISnSbXgpbpYV02/ZAjLea+IfPVIa2uGp7Irj2vio9
         3bWadttIVkgesveJLUjb229/XLkNrd4Aq7X84EU1LBSheHY88ThCYss4oBmO75v/gEna
         RN4bxkevduaeGln+Nw1Btj4+50PTXWDdrHl+9P2AW6LuNd/VOrWjpcmF/Q884dvmdMzL
         lCxjk3UNFTuBwPXlOrPhN+XH+A63W+ibV1Al4qESDmDR2cT06oqXqTnzjD83TE4yrEjp
         4g+A==
X-Gm-Message-State: ANoB5pmAAX4Ymkegi22IfUcVb1tOl42KrvpmXiK9Bchpn1RCHncY5OfD
        ybTWhttCit4AKjb3bR4tkW78EQdiRkP+Hg==
X-Google-Smtp-Source: AA0mqf7uEyhL6SZ4wQqqSS9FgyZTnHN6MilujgP5+sAe7rzs8HcJBKMdPNWem73Tv4Fg7UOV0gjQPQ==
X-Received: by 2002:a05:622a:4890:b0:3a5:84b9:3292 with SMTP id fc16-20020a05622a489000b003a584b93292mr20723848qtb.119.1669107323118;
        Tue, 22 Nov 2022 00:55:23 -0800 (PST)
Received: from mail-yw1-f182.google.com (mail-yw1-f182.google.com. [209.85.128.182])
        by smtp.gmail.com with ESMTPSA id x12-20020ae9e90c000000b006b5cc25535fsm9366502qkf.99.2022.11.22.00.55.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Nov 2022 00:55:22 -0800 (PST)
Received: by mail-yw1-f182.google.com with SMTP id 00721157ae682-398cff43344so88100087b3.0;
        Tue, 22 Nov 2022 00:55:21 -0800 (PST)
X-Received: by 2002:a0d:fec2:0:b0:36b:56d3:71b8 with SMTP id
 o185-20020a0dfec2000000b0036b56d371b8mr20585246ywf.384.1669107321620; Tue, 22
 Nov 2022 00:55:21 -0800 (PST)
MIME-Version: 1.0
References: <20221117122547.809644-1-tomi.valkeinen@ideasonboard.com>
 <20221117122547.809644-3-tomi.valkeinen@ideasonboard.com> <CAMuHMdWUvLzCtFRXvUpCxczpkpaunb==gjBMwdniXY4UBVuMUw@mail.gmail.com>
 <f5df3cb8-d315-b06b-aa04-f0b4af64a1c2@ideasonboard.com>
In-Reply-To: <f5df3cb8-d315-b06b-aa04-f0b4af64a1c2@ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 22 Nov 2022 09:55:10 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWsvcd3_CX_dESW3EO4FoSGcMWAAyKO_5g2ch-jezdzzQ@mail.gmail.com>
Message-ID: <CAMuHMdWsvcd3_CX_dESW3EO4FoSGcMWAAyKO_5g2ch-jezdzzQ@mail.gmail.com>
Subject: Re: [PATCH v1 2/8] dt-bindings: display: bridge: renesas,dsi-csi2-tx:
 Add r8a779g0
To:     Tomi Valkeinen <tomi.valkeinen@ideasonboard.com>
Cc:     Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Magnus Damm <magnus.damm@gmail.com>,
        dri-devel@lists.freedesktop.org, linux-renesas-soc@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Robert Foss <robert.foss@linaro.org>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

On Tue, Nov 22, 2022 at 9:20 AM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
> On 17/11/2022 17:14, Geert Uytterhoeven wrote:
> > On Thu, Nov 17, 2022 at 1:26 PM Tomi Valkeinen
> > <tomi.valkeinen@ideasonboard.com> wrote:
> >> From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> >>
> >> Extend the Renesas DSI display bindings to support the r8a779g0 V4H.
> >>
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> >> ---
> >>   .../bindings/display/bridge/renesas,dsi-csi2-tx.yaml           | 3 ++-
> >>   1 file changed, 2 insertions(+), 1 deletion(-)
> >>
> >> diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dsi-csi2-tx.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,dsi-csi2-tx.yaml
> >> index afeeb967393d..bc3101f77e5a 100644
> >> --- a/Documentation/devicetree/bindings/display/bridge/renesas,dsi-csi2-tx.yaml
> >> +++ b/Documentation/devicetree/bindings/display/bridge/renesas,dsi-csi2-tx.yaml
> >> @@ -11,13 +11,14 @@ maintainers:
> >>
> >>   description: |
> >>     This binding describes the MIPI DSI/CSI-2 encoder embedded in the Renesas
> >> -  R-Car V3U SoC. The encoder can operate in either DSI or CSI-2 mode, with up
> >> +  R-Car V3U/V4H SoC. The encoder can operate in either DSI or CSI-2 mode, with up
> >
> > Perhaps "R-Car Gen4 SoCs", so we stay within 80 chars, and don't have
> > to update this when the next member of the family is around the block?
>
> Is V3U gen 4? Or do you mean "R-Car V3U and Gen 4 SoCs"?

Despite the name, R-Car V3U is the first member of the R-Car Gen4 family...
https://www.renesas.com/us/en/products/automotive-products/automotive-system-chips-socs/r-car-v3u-best-class-r-car-v3u-asil-d-system-chip-automated-driving

> > Is there anything that might be SoC-specific?
> > If not, perhaps the time is ripe for a family-specific compatible value?
>
> At least v3u and v4h DSIs are slightly different. Well, the DSI IP block
> itself looks the same, but the PLL and PHY are different.

I noticed, when I saw the dsi-csi2 driver changes.
So no family-specific compatible value is needed.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
