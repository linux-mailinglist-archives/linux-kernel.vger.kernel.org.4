Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEC4F642678
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 11:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231722AbiLEKLV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 05:11:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230244AbiLEKLO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 05:11:14 -0500
Received: from mail-qt1-f173.google.com (mail-qt1-f173.google.com [209.85.160.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0A21192BB;
        Mon,  5 Dec 2022 02:10:45 -0800 (PST)
Received: by mail-qt1-f173.google.com with SMTP id x28so9937804qtv.13;
        Mon, 05 Dec 2022 02:10:45 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ZUxVNYgQpF1NtWJx4x3VZYK+8ZOnXcCaeiuWHvm8oJQ=;
        b=Oqhr9lMfdFBlFC8M70abI3LjCKGzUeRVTHspFz6NvJKcFT59N5oHUUcoL6rk2OuDw/
         QxVESqfDyZvZNoEh0qBXO3rIJL8MeSXVKNc/QTo8WxcLJkiDMKC6KJV0veaQx+n7xY00
         G0E6aoxMVwrzpB0pn7GQJ/qaM7RZ1Zaa7GD0nJmg97MXqkdNRC3kBsbm2z/i38Ku8AuK
         7zqEu2Vq9zZTMIC2wjvNmNteG9h8vEuON2nbnInhhmHMAopBv8TyTKcVXT+A6yr/1qb5
         kWdvvrMFNISbEDYtUCMN73rlnohrfGeGeb3aRfXpkj31w6VmhbCLJpwBT2zc54qZZsIL
         8y8g==
X-Gm-Message-State: ANoB5pnLUKLhTuZO43ysgJSIAZMoPntxGHzDQLuSo9C359X9I4s36zPL
        gG0UCdGSXELkupv+TmWiWtIueEpS6I2YmQ==
X-Google-Smtp-Source: AA0mqf4ns+kNgrI/SpK83Ys51gqrpe3PfSY5ExFkHlR5SENbltU/yNZIg0ZYzOOxzjvODMoFrG0vWQ==
X-Received: by 2002:ac8:478f:0:b0:3a7:e57b:11a7 with SMTP id k15-20020ac8478f000000b003a7e57b11a7mr2095184qtq.451.1670235044514;
        Mon, 05 Dec 2022 02:10:44 -0800 (PST)
Received: from mail-yb1-f174.google.com (mail-yb1-f174.google.com. [209.85.219.174])
        by smtp.gmail.com with ESMTPSA id w12-20020a05620a424c00b006fa4cac54a5sm12358196qko.72.2022.12.05.02.10.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Dec 2022 02:10:43 -0800 (PST)
Received: by mail-yb1-f174.google.com with SMTP id c140so13773604ybf.11;
        Mon, 05 Dec 2022 02:10:43 -0800 (PST)
X-Received: by 2002:a25:7204:0:b0:6f0:9ff5:1151 with SMTP id
 n4-20020a257204000000b006f09ff51151mr51492773ybc.543.1670235043063; Mon, 05
 Dec 2022 02:10:43 -0800 (PST)
MIME-Version: 1.0
References: <20221201095631.89448-1-tomi.valkeinen+renesas@ideasonboard.com> <20221201095631.89448-6-tomi.valkeinen+renesas@ideasonboard.com>
In-Reply-To: <20221201095631.89448-6-tomi.valkeinen+renesas@ideasonboard.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 5 Dec 2022 11:10:31 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXXoNq0CxSqPLzZUPdVTNa+6u+DNhbm_pCSQOvTHf3EjQ@mail.gmail.com>
Message-ID: <CAMuHMdXXoNq0CxSqPLzZUPdVTNa+6u+DNhbm_pCSQOvTHf3EjQ@mail.gmail.com>
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
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 1, 2022 at 10:56 AM Tomi Valkeinen
<tomi.valkeinen+renesas@ideasonboard.com> wrote:
>
> Add DT nodes needed for the mini DP connector. The DP is driven by
> sn65dsi86, which in turn gets the pixel data from the SoC via DSI.
>
> Signed-off-by: Tomi Valkeinen <tomi.valkeinen+renesas@ideasonboard.com>
> Reviewed-by: Kieran Bingham <kieran.bingham+renesas@ideasonboard.com>
> Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>

(same comments as v2)
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.3, with the mini-dp-con node
moved up.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
