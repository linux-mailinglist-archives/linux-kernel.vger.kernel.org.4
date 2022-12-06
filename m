Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EAC66444DE
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 14:48:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234387AbiLFNrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 08:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233008AbiLFNrr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 08:47:47 -0500
Received: from mail-qk1-f169.google.com (mail-qk1-f169.google.com [209.85.222.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A506E6382;
        Tue,  6 Dec 2022 05:47:45 -0800 (PST)
Received: by mail-qk1-f169.google.com with SMTP id s10so5899879qkg.8;
        Tue, 06 Dec 2022 05:47:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+zwsuo3CbkQiK4rUg7GOR+GbgfKxh+ViwiReQiXihu4=;
        b=O0roLiliPFHMohCelMW05/SC+x27XduQuDBAIjwArJobFtgLKS/LWUKHUjNnEcl5ca
         WQ4+C/Vzfu6xMPLwsvRW1G6OD4079gPLyIZaQjrnxrz/V/fSHKQOXP/XXB7F83pdam+d
         LsEQBoEDBpf6vtz0dzucTaZuNYDHJXRYm+eYnxdwSOUuZZiQtCd9QpTeiNd3GQXzCKPr
         OMzcBDhbfXk9EcCgoJy5dUndlgL1kon52aFOKu45nC5BTLc/LWsj2Uh9Iq3kQB/zBWJO
         7bLS7vo0QTsNVVVQLvhNGAtCuPik/8TsWsxf9DlwrxeEA2OOCZ52d0clUYpx+/ZWmLWi
         h+KQ==
X-Gm-Message-State: ANoB5plu/By1G5bmq1lPO/XH/e6ACqSNP8/C5lGQrPvNUvbCcsHDLonZ
        lW2/+ykyjB5KxNOhQfk4Efbjsj8cplMl/Q==
X-Google-Smtp-Source: AA0mqf5G9ngwaiFCXxegDWVAKaFng66wuz5KJUBYewstRebV9OoFKwnm+voLiXyTZiwTLvPNev/l2Q==
X-Received: by 2002:a37:aad1:0:b0:6fc:cbd8:25d7 with SMTP id t200-20020a37aad1000000b006fccbd825d7mr10961379qke.350.1670334462203;
        Tue, 06 Dec 2022 05:47:42 -0800 (PST)
Received: from mail-yw1-f170.google.com (mail-yw1-f170.google.com. [209.85.128.170])
        by smtp.gmail.com with ESMTPSA id t17-20020a37ea11000000b006b5cc25535fsm14738377qkj.99.2022.12.06.05.47.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 05:47:41 -0800 (PST)
Received: by mail-yw1-f170.google.com with SMTP id 00721157ae682-3b56782b3f6so151890997b3.13;
        Tue, 06 Dec 2022 05:47:41 -0800 (PST)
X-Received: by 2002:a81:4e09:0:b0:370:202b:f085 with SMTP id
 c9-20020a814e09000000b00370202bf085mr16748351ywb.502.1670334461439; Tue, 06
 Dec 2022 05:47:41 -0800 (PST)
MIME-Version: 1.0
References: <20221201095631.89448-1-tomi.valkeinen+renesas@ideasonboard.com>
 <20221201095631.89448-6-tomi.valkeinen+renesas@ideasonboard.com>
 <CAMuHMdXXoNq0CxSqPLzZUPdVTNa+6u+DNhbm_pCSQOvTHf3EjQ@mail.gmail.com> <b35d7cf0-99ef-86b7-41b3-0751abd4642a@ideasonboard.com>
In-Reply-To: <b35d7cf0-99ef-86b7-41b3-0751abd4642a@ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Dec 2022 14:47:29 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVeyo-8G2LtA9tgqJ8P8zT2EQGx8GYUWQx66ut29e8RTw@mail.gmail.com>
Message-ID: <CAMuHMdVeyo-8G2LtA9tgqJ8P8zT2EQGx8GYUWQx66ut29e8RTw@mail.gmail.com>
Subject: Re: [PATCH v5 5/7] arm64: dts: renesas: white-hawk-cpu: Add DP output support
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
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tomi,

On Tue, Dec 6, 2022 at 2:45 PM Tomi Valkeinen
<tomi.valkeinen+renesas@ideasonboard.com> wrote:
> On 05/12/2022 12:10, Geert Uytterhoeven wrote:
> > On Thu, Dec 1, 2022 at 10:56 AM Tomi Valkeinen
> > <tomi.valkeinen+renesas@ideasonboard.com> wrote:
> >>
> >> Add DT nodes needed for the mini DP connector. The DP is driven by
> >> sn65dsi86, which in turn gets the pixel data from the SoC via DSI.
> >>
> >> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> >> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> >> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
> >
> > (same comments as v2)
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
> > i.e. will queue in renesas-devel for v6.3, with the mini-dp-con node
> > moved up.
>
> Ah, sorry, I had missed this change. I'll update my branch too.

Np.  IIRC, you were sending out v5 while I was reviewing v2/v4.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
