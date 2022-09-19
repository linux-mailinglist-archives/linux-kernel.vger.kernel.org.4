Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EABC85BC619
	for <lists+linux-kernel@lfdr.de>; Mon, 19 Sep 2022 12:10:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbiISKKx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 06:10:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229540AbiISKKu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 06:10:50 -0400
Received: from mail-qk1-f174.google.com (mail-qk1-f174.google.com [209.85.222.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FBE2175B6;
        Mon, 19 Sep 2022 03:10:45 -0700 (PDT)
Received: by mail-qk1-f174.google.com with SMTP id 3so19723695qka.5;
        Mon, 19 Sep 2022 03:10:45 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=rvouYMCfTHFXehJMfj1wqjvz02ze/sMD6F7RyGxCLAk=;
        b=NqmQepT001G1vepUunGLC1Rt5wuf7ZYafI+ny9vxUvHTDveP9NClZ0JnNKBSs0RKE3
         F4fopicUUOqcmTNx8stJ9Rf+Y+WCM+JyM5Hif3dPbbQZsg/xNqNcZOQ8RR6JXPwL98Ig
         x7Q9ySxdYwFSKPm7NavbvB/M70KYZRgS+PxQ4GT9NSZopH/wNCsh+ArP/KR/Q3Ihx4Dx
         ZGlNKZZgTqJbRsKYzjv5Mr1k4KL4bTQbLEWMuap6O0vyRojGLmEuT1/HbQigh2J5YNFR
         pQVGSu/9jWbe829A8EC8zHYjlcHxA63UR9OMddwxM0B82lyqYh/tL3Zh2b7gTIwfCWMG
         cnPw==
X-Gm-Message-State: ACrzQf2jsEvb/pcCxyFlnq1TpyrsKVepl0V4fVnNdE9eHrTnBePE59bt
        GDGyxgffrpPHoA0I3CSyvPd5R6Bxkmvs/w==
X-Google-Smtp-Source: AMsMyM50jq9Yl4J5npGavYwZNDM4Lc3xivLFuQVIqv0uB21lxw/QfAGjYejOl22mr3aa5l9MvwJS3A==
X-Received: by 2002:a05:620a:40d0:b0:6ce:bda8:e20a with SMTP id g16-20020a05620a40d000b006cebda8e20amr11623004qko.247.1663582244602;
        Mon, 19 Sep 2022 03:10:44 -0700 (PDT)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id q13-20020a37f70d000000b006b8e63dfffbsm12011792qkj.58.2022.09.19.03.10.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 19 Sep 2022 03:10:44 -0700 (PDT)
Received: by mail-yb1-f172.google.com with SMTP id e187so35528708ybh.10;
        Mon, 19 Sep 2022 03:10:44 -0700 (PDT)
X-Received: by 2002:a25:8e84:0:b0:696:466c:baa with SMTP id
 q4-20020a258e84000000b00696466c0baamr12820355ybl.604.1663582243840; Mon, 19
 Sep 2022 03:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220914134211.199631-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <CAMuHMdVRmuQm5xRgpQurCJTu7goqNi5zj+Q9cLLz_s_p=znbbA@mail.gmail.com>
 <CA+V-a8vDMFKJb0wDOR8LZifRDBa0hju-YgL_BDb0chVjpef98w@mail.gmail.com> <OS0PR01MB592272F7C6A9519E1CA99647864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
In-Reply-To: <OS0PR01MB592272F7C6A9519E1CA99647864D9@OS0PR01MB5922.jpnprd01.prod.outlook.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 19 Sep 2022 12:10:32 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWzWQgL1eki_aL_MnfQfM_S1yTuabWQAP8GzuA_D_A_kw@mail.gmail.com>
Message-ID: <CAMuHMdWzWQgL1eki_aL_MnfQfM_S1yTuabWQAP8GzuA_D_A_kw@mail.gmail.com>
Subject: Re: [PATCH] arm64: dts: renesas: rzg2ul-smarc-som: Drop enabling wdt2
To:     Biju Das <biju.das.jz@bp.renesas.com>
Cc:     "Lad, Prabhakar" <prabhakar.csengg@gmail.com>,
        Magnus Damm <magnus.damm@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Biju,

On Mon, Sep 19, 2022 at 12:06 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > On Sun, Sep 18, 2022 at 10:04 AM Geert Uytterhoeven <geert@linux-
> > m68k.org> wrote:
> > > On Wed, Sep 14, 2022 at 3:43 PM Prabhakar
> > <prabhakar.csengg@gmail.com> wrote:
> > > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > >
> > > > WDT CH2 is specifically to check the operation of Cortex-M33 CPU
> > so
> > > > don't enable WDT2 by default.
> > > >
> > For consistency I'll drop enabling WDT2 from the RZ/G2L{C} too.
>
> Does remove unused clocks turn off WDT2 clock during late init??
>
> If that is the case, we should remove entries from clock table as well?

Or add it to *_crit_mod_clks[]?

Note that drivers/clk/renesas/r9a07g043-cpg.c creates wdt2 clocks
and resets, so that should probably be moved inside the #ifdef
CONFIG_ARM64 section.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
