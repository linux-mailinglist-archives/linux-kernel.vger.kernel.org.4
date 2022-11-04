Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47C6361930A
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 09:58:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiKDI6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 04:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230435AbiKDI6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 04:58:08 -0400
Received: from mail-qk1-f178.google.com (mail-qk1-f178.google.com [209.85.222.178])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F56C29369;
        Fri,  4 Nov 2022 01:58:07 -0700 (PDT)
Received: by mail-qk1-f178.google.com with SMTP id z1so2672401qkl.9;
        Fri, 04 Nov 2022 01:58:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=k0h09O5iwDfuBI18fNUtkAkl+YS3x19zmiWPf5QOi2c=;
        b=CyKvxt4A0Ys6kyi2jtEciC9uFk5nc74HmMcP9nhRPkMC/e8DRi6vtxsvwyAf7ZBfXA
         V1o7SpNNlGIDC/3vL9M5EkoeCui75ZIC+wL5LuCQp6gHiI3yZJd0atf2o1FY0BA0piTU
         NstvPcAqBAzlhb9lPbC+czfalvdbJiwmgO/kGXds5anlk3n1oKgP+CsD3fb/vBiQbUeo
         1JDF3VznZx3YC8O8fehQQxq2q52ecb02buQZw7/FAHOoIFrFqpt5XSWsS7HJjuo/R5UB
         mdjUcFghLiIMlkekkON+PwXL7b77NpnXohgF2P8osXIl1x7/i9DlmGPJKM5uujk66KhQ
         CZag==
X-Gm-Message-State: ACrzQf1fXvJgtlAdYDnLQ8sRU9au5UnXWniPjSlBzyNUje6/z0Mprft8
        q5UGf+tmVxYEJ0G81avqAAbhrJpBGtTVeQ==
X-Google-Smtp-Source: AMsMyM7ncAe6TL9EWstF41A4MfCSHJGbgB4MwJRN4+8N0oHdDwrVDh4ybvs+eGvHhfELuQZJLMCB4g==
X-Received: by 2002:a05:620a:470e:b0:6fa:7ef0:6425 with SMTP id bs14-20020a05620a470e00b006fa7ef06425mr4254752qkb.418.1667552286331;
        Fri, 04 Nov 2022 01:58:06 -0700 (PDT)
Received: from mail-yb1-f178.google.com (mail-yb1-f178.google.com. [209.85.219.178])
        by smtp.gmail.com with ESMTPSA id ay30-20020a05620a179e00b006c479acd82fsm2555722qkb.7.2022.11.04.01.58.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Nov 2022 01:58:05 -0700 (PDT)
Received: by mail-yb1-f178.google.com with SMTP id r3so5068877yba.5;
        Fri, 04 Nov 2022 01:58:05 -0700 (PDT)
X-Received: by 2002:a25:6b07:0:b0:6cd:3a43:bfe5 with SMTP id
 g7-20020a256b07000000b006cd3a43bfe5mr21224934ybc.89.1667552285680; Fri, 04
 Nov 2022 01:58:05 -0700 (PDT)
MIME-Version: 1.0
References: <20221103205546.24836-1-wsa+renesas@sang-engineering.com> <20221103205546.24836-4-wsa+renesas@sang-engineering.com>
In-Reply-To: <20221103205546.24836-4-wsa+renesas@sang-engineering.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Fri, 4 Nov 2022 09:57:53 +0100
X-Gmail-Original-Message-ID: <CAMuHMdXia+MNwab6Npc22qWaXaDY0T6VVvxCJGuXRDwukLA53w@mail.gmail.com>
Message-ID: <CAMuHMdXia+MNwab6Npc22qWaXaDY0T6VVvxCJGuXRDwukLA53w@mail.gmail.com>
Subject: Re: [PATCH 3/4] arm64: dts: renesas: white-hawk-cpu: sort RWDT entry correctly
To:     Wolfram Sang <wsa+renesas@sang-engineering.com>
Cc:     linux-renesas-soc@vger.kernel.org,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Thu, Nov 3, 2022 at 9:55 PM Wolfram Sang
<wsa+renesas@sang-engineering.com> wrote:
> Fixes: 495e36c3a313 ("arm64: dts: renesas: white-hawk-cpu: Enable watchdog timer")
> Signed-off-by: Wolfram Sang <wsa+renesas@sang-engineering.com>

Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
i.e. will queue in renesas-devel for v6.2.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
