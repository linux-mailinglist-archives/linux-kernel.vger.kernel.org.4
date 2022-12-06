Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A88B643DF8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 09:01:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231848AbiLFIBM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 03:01:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230327AbiLFIBB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 03:01:01 -0500
Received: from mail-qk1-f173.google.com (mail-qk1-f173.google.com [209.85.222.173])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76441178A2;
        Tue,  6 Dec 2022 00:01:00 -0800 (PST)
Received: by mail-qk1-f173.google.com with SMTP id v8so6891538qkg.12;
        Tue, 06 Dec 2022 00:01:00 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=NwtnhNDE77wY8xo2aeVHI67JHPZRh1RTuiZ2DWCBbZc=;
        b=Ae/vfjtMldeQ/+G4WeRVUY0visx3TnckD1iWkyBuu/YsnWtOXv8hhOJRowajiVJ6Ln
         YOBpprutHVSRN016g43bSfv6Usicv/FzWtTWRqn8QhsoLHj2II9Q+2IY7BmVS0sMjbDZ
         LCT6Au3/sCJqe/5t+B4Rp45h8/XSy/4fpUsRyW4J0Se09bZyws9yrMUCB5XvZ9D9WJJG
         hXiPwBS081WqK0nlbLXzgsbi6Hh2qMv0ajHLPuaKkVXzEZa9TgszIike5pmE/RzylOu7
         WRJ9dVJPAyUFwxgBbIl7+zMIfrlg2YdMB2ADMmggCYh6LWz9UQ7oXNkRgNStkhcTDpjT
         z/mQ==
X-Gm-Message-State: ANoB5pkPmEWH0Nqq94cln71M0H7J0H12XkYT89nyMcaE/4GkyKX9tXyv
        itu5NfBiPI/dPr+afqzeclQuo7kwKKSNUw==
X-Google-Smtp-Source: AA0mqf7JcNGGKOmHaJ/73QQdP3YXe4/dTLFF0/RKcy442c/IzQICTUPSoFfbCMh37gecUjWhZGVdqg==
X-Received: by 2002:a05:620a:12bc:b0:6fc:add2:58e4 with SMTP id x28-20020a05620a12bc00b006fcadd258e4mr16033683qki.681.1670313659392;
        Tue, 06 Dec 2022 00:00:59 -0800 (PST)
Received: from mail-yb1-f172.google.com (mail-yb1-f172.google.com. [209.85.219.172])
        by smtp.gmail.com with ESMTPSA id u3-20020a05622a17c300b003a6947863e1sm9153801qtk.11.2022.12.06.00.00.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 06 Dec 2022 00:00:59 -0800 (PST)
Received: by mail-yb1-f172.google.com with SMTP id 7so17594133ybp.13;
        Tue, 06 Dec 2022 00:00:58 -0800 (PST)
X-Received: by 2002:a25:7a02:0:b0:6f7:952d:b145 with SMTP id
 v2-20020a257a02000000b006f7952db145mr33481513ybc.604.1670313657864; Tue, 06
 Dec 2022 00:00:57 -0800 (PST)
MIME-Version: 1.0
References: <a989b3b798ecaf3b45f35160e30e605636d66a77.1669044086.git.geert+renesas@glider.be>
 <CACRpkdZPhKT=wjToSiY+iyXk2_WdBZ1hEvmNvQQLJPZGN==-xQ@mail.gmail.com>
In-Reply-To: <CACRpkdZPhKT=wjToSiY+iyXk2_WdBZ1hEvmNvQQLJPZGN==-xQ@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 6 Dec 2022 09:00:46 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVDYsCPko9NJfa+JLk_MRFAR1dgSF3GahtTeABysDFyBA@mail.gmail.com>
Message-ID: <CAMuHMdVDYsCPko9NJfa+JLk_MRFAR1dgSF3GahtTeABysDFyBA@mail.gmail.com>
Subject: Re: [PATCH] usb: USB_FOTG210 should depend on ARCH_GEMINI
To:     Linus Walleij <linus.walleij@linaro.org>
Cc:     Fabian Vogt <fabian@ritter-vogt.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
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

Hi Linus,

On Mon, Dec 5, 2022 at 11:24 PM Linus Walleij <linus.walleij@linaro.org> wrote:
> On Mon, Nov 21, 2022 at 4:22 PM Geert Uytterhoeven
> <geert+renesas@glider.be> wrote:
> > The Faraday Technology FOTG210 USB2 Dual Role Controller is only present
> > on Cortina Systems Gemini SoCs.
>
> As it turns out, this is not true. The TI nSpire uses this too, I should have
> noted since the nSpire maintainer was patching the driver...
> https://lore.kernel.org/linux-usb/20210324141115.9384-1-fabian@ritter-vogt.de/
>
> Shall we revert it or just add another clause for the nSpire?

Oh, but the integration is not (yet) upstream, as I didn't find any
"faraday,fotg210" outside gemini.dtsi.

I guess another clause would be the most-userfriendly solution.

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
