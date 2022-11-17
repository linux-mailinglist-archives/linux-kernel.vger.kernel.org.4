Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBAB62DF82
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 16:20:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240031AbiKQPUw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 10:20:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240609AbiKQPUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 10:20:03 -0500
Received: from mail-qv1-f45.google.com (mail-qv1-f45.google.com [209.85.219.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDE7678D67;
        Thu, 17 Nov 2022 07:14:34 -0800 (PST)
Received: by mail-qv1-f45.google.com with SMTP id x13so1366353qvn.6;
        Thu, 17 Nov 2022 07:14:34 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SegVnAcLQLaJX7pNjPa5EmAcFg4cHidqxjj8yBrAgQs=;
        b=Fdf4gck142Pt8jwiiqMGY5l0tETOb4f80DP87uH9w0p3uw//fVxel6ixbiSrxeoo0Z
         A7DSjMGIZgA3VRauNDyI65+RT4Zm6Mx+A4QQ+bZgCT3/4BFy6NK4/Mfu1wPuOTh7nkLQ
         IMBTE4yu+Xe1YyGquK0Y99n1JQfFornRg+AFkN689CsIT+7HYvGkghm8JeDgdCiJvGyr
         oM0cj0VI6gLCyTRLojNN8e7yXDjPjCRnBZLtJPRf8lLi59iAk59lqHPZVmxOFvhHuHff
         Y0V1aDJZpwnsEZ7fq1/uKfBjZE7m6zhD5ddY8wasXFeEZTN52tN3MNWu1fz4fU76p8lF
         WcVQ==
X-Gm-Message-State: ANoB5pki1uEpFp0CEdu7DRJlwT9oCKnzMx7hrtw1DrvcM7EhYGsvrzAQ
        mMkbP+uDgGj4/6O3NVKQC1cOUNLu9Aeo/g==
X-Google-Smtp-Source: AA0mqf6BIcZS/ueXyCbM/BFH8nwdL9oBKRqDCZ8xAP+dsNCSYHbGPZBTVm/MfE+3ULlkKSxdxRQ4sA==
X-Received: by 2002:ad4:590a:0:b0:4bb:4ab2:5138 with SMTP id ez10-20020ad4590a000000b004bb4ab25138mr2679389qvb.114.1668698073611;
        Thu, 17 Nov 2022 07:14:33 -0800 (PST)
Received: from mail-yb1-f179.google.com (mail-yb1-f179.google.com. [209.85.219.179])
        by smtp.gmail.com with ESMTPSA id bj38-20020a05620a192600b006cbe3be300esm628529qkb.12.2022.11.17.07.14.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Nov 2022 07:14:32 -0800 (PST)
Received: by mail-yb1-f179.google.com with SMTP id v123so2211535ybv.5;
        Thu, 17 Nov 2022 07:14:32 -0800 (PST)
X-Received: by 2002:a25:9e84:0:b0:6de:6183:c5c3 with SMTP id
 p4-20020a259e84000000b006de6183c5c3mr2545467ybq.89.1668698072311; Thu, 17 Nov
 2022 07:14:32 -0800 (PST)
MIME-Version: 1.0
References: <20221117122547.809644-1-tomi.valkeinen@ideasonboard.com> <20221117122547.809644-3-tomi.valkeinen@ideasonboard.com>
In-Reply-To: <20221117122547.809644-3-tomi.valkeinen@ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 17 Nov 2022 16:14:21 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWUvLzCtFRXvUpCxczpkpaunb==gjBMwdniXY4UBVuMUw@mail.gmail.com>
Message-ID: <CAMuHMdWUvLzCtFRXvUpCxczpkpaunb==gjBMwdniXY4UBVuMUw@mail.gmail.com>
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
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

On Thu, Nov 17, 2022 at 1:26 PM Tomi Valkeinen
<tomi.valkeinen@ideasonboard.com> wrote:
> From: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
>
> Extend the Renesas DSI display bindings to support the r8a779g0 V4H.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> ---
>  .../bindings/display/bridge/renesas,dsi-csi2-tx.yaml           | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>
> diff --git a/Documentation/devicetree/bindings/display/bridge/renesas,dsi-csi2-tx.yaml b/Documentation/devicetree/bindings/display/bridge/renesas,dsi-csi2-tx.yaml
> index afeeb967393d..bc3101f77e5a 100644
> --- a/Documentation/devicetree/bindings/display/bridge/renesas,dsi-csi2-tx.yaml
> +++ b/Documentation/devicetree/bindings/display/bridge/renesas,dsi-csi2-tx.yaml
> @@ -11,13 +11,14 @@ maintainers:
>
>  description: |
>    This binding describes the MIPI DSI/CSI-2 encoder embedded in the Renesas
> -  R-Car V3U SoC. The encoder can operate in either DSI or CSI-2 mode, with up
> +  R-Car V3U/V4H SoC. The encoder can operate in either DSI or CSI-2 mode, with up

Perhaps "R-Car Gen4 SoCs", so we stay within 80 chars, and don't have
to update this when the next member of the family is around the block?

Is there anything that might be SoC-specific?
If not, perhaps the time is ripe for a family-specific compatible value?

>    to four data lanes.
>
>  properties:
>    compatible:
>      enum:
>        - renesas,r8a779a0-dsi-csi2-tx    # for V3U
> +      - renesas,r8a779g0-dsi-csi2-tx    # for V4H
>
>    reg:
>      maxItems: 1

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
