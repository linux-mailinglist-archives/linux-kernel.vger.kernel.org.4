Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBFEC63EC3D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Dec 2022 10:21:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229780AbiLAJVI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Dec 2022 04:21:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiLAJVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Dec 2022 04:21:06 -0500
Received: from mail-qv1-f46.google.com (mail-qv1-f46.google.com [209.85.219.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A4DB4B9A6;
        Thu,  1 Dec 2022 01:21:03 -0800 (PST)
Received: by mail-qv1-f46.google.com with SMTP id e18so933751qvs.1;
        Thu, 01 Dec 2022 01:21:03 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=6fSb3KNzIEE0W7AdsV0sBOucQCqOQ/fqMgUl4ol27wc=;
        b=cJFBxx9j8I/zHqTUyiFAPQ0PAtFeh2XypUVvo7p8ieMvl6ftdDQhEz+Flcy8/irrj7
         U/FYRdA35UhuOxhFbNhAj9z9WgGYEf9IJ/HaVGgotAHtu2d6W8HEgD0tc3JS5J4W3Fze
         uL8Tr3dSJeRTTaz2v2WMkx+7JLQdbDe9bfi3g9kACeCQxSNteJwv49Tv5+knTRDZPfMV
         JGF/4tu8MPF6fZii2H83hxqw9sm1cY9gf91BdAe9ZGF56yepc9uBawEgyTqi+F1Xj3Mm
         NnaxRpmhEqACmKwJH8EcCOjtudgVC7Fj+AGCNtNz4//nbEdbcXH/0a2Xzgj2upY593aL
         4G0A==
X-Gm-Message-State: ANoB5pmn6+uV39Fe7yBHO6Mul62zt1DB4jROZ0gF0C+/OPpy5tmHL2kA
        IYcoTEw5FAshlaeEGknT9K770z9yQmct7w==
X-Google-Smtp-Source: AA0mqf7VTgGdtYS84x5c9SRxszdWNDitTe+7wFuFDprrHRlQWDyuZeHB+uAKf6VDZpmEd9M2UDsnFw==
X-Received: by 2002:a05:6214:5f86:b0:4c6:141f:819d with SMTP id ls6-20020a0562145f8600b004c6141f819dmr49493889qvb.34.1669886462206;
        Thu, 01 Dec 2022 01:21:02 -0800 (PST)
Received: from mail-yw1-f181.google.com (mail-yw1-f181.google.com. [209.85.128.181])
        by smtp.gmail.com with ESMTPSA id x10-20020a05620a258a00b006fc92cf4703sm2983108qko.132.2022.12.01.01.21.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Dec 2022 01:21:01 -0800 (PST)
Received: by mail-yw1-f181.google.com with SMTP id 00721157ae682-381662c78a9so10946067b3.7;
        Thu, 01 Dec 2022 01:21:00 -0800 (PST)
X-Received: by 2002:a81:a148:0:b0:3b4:8af5:48e with SMTP id
 y69-20020a81a148000000b003b48af5048emr33977890ywg.383.1669886460726; Thu, 01
 Dec 2022 01:21:00 -0800 (PST)
MIME-Version: 1.0
References: <20221123065946.40415-1-tomi.valkeinen+renesas@ideasonboard.com> <20221123065946.40415-5-tomi.valkeinen+renesas@ideasonboard.com>
In-Reply-To: <20221123065946.40415-5-tomi.valkeinen+renesas@ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Thu, 1 Dec 2022 10:20:49 +0100
X-Gmail-Original-Message-ID: <CAMuHMdWAPZHLxgQioNBw1HhZpvAN5WFydc-bbMkpfH5pdc1vNg@mail.gmail.com>
Message-ID: <CAMuHMdWAPZHLxgQioNBw1HhZpvAN5WFydc-bbMkpfH5pdc1vNg@mail.gmail.com>
Subject: Re: [PATCH v2 4/7] arm64: dts: renesas: r8a779g0: Add display related nodes
To:     Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
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
        Jernej Skrabec <jernej.skrabec@gmail.com>
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

On Wed, Nov 23, 2022 at 8:00 AM Tomi Valkeinen
<tomi.valkeinen+renesas@ideasonboard.com> wrote:
> Add DT nodes for components needed to get the DSI output working:
> - FCPv
> - VSPd
> - DU
> - DSI
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.3.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
