Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F809746AB6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231237AbjGDHdP convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jul 2023 03:33:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231163AbjGDHdN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:33:13 -0400
Received: from mail-yw1-f169.google.com (mail-yw1-f169.google.com [209.85.128.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EF3D199;
        Tue,  4 Jul 2023 00:33:12 -0700 (PDT)
Received: by mail-yw1-f169.google.com with SMTP id 00721157ae682-577497ec6c6so42407047b3.2;
        Tue, 04 Jul 2023 00:33:12 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688455991; x=1691047991;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=CGNXFBCkiTfXuJAYc1PokrnliwHO0f5MH6mf+8iL6KA=;
        b=F2RSfoXg73gcz4h9knMDQFYlIZNTnoKZ/G9Vy52Aqi1mS0QLcUrZTkYjOwawjuJDlx
         yRpq88uGKUsA3w3bKxTenXkpIAVFnGfEU6CzY8tdP36V1tonikGFIpL8PMURtlt5fkPw
         OZwk2MOaoMuB58c5TgvlusJ9ZnojszBrOXQtu9vJl/e+pWFcHmOKBa2Dt3yOiAY3/TtE
         whUaJGZnisu4yYarwL8Kxx7/Y5hytK33l5L0AFUeoYYQP0/iIhuXpBc90c/skNT5ZRv1
         ZCGOaLfNVkFDJPKRMdEwCJ+F74Ro3XCIZ3YItt+rXjngLvDtlQPdlWPIw+3r5tDYtklU
         lNEw==
X-Gm-Message-State: ABy/qLaQ+UApbEmm998yuGRKQ9JGBiHjTmshhH7cBbAdkBTu+kapPJTl
        8s9cKvMn1dIQnyXUJAoUbO+AYic62hhCig==
X-Google-Smtp-Source: APBJJlE1oDgNDbHcN/R9hVVUD45nArZPH6szVzNQZb9QFKvvGsbQrXUUBccfo9Qg+YbBQDYrmUuXQQ==
X-Received: by 2002:a81:7486:0:b0:573:6cf0:4008 with SMTP id p128-20020a817486000000b005736cf04008mr13603905ywc.26.1688455991216;
        Tue, 04 Jul 2023 00:33:11 -0700 (PDT)
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com. [209.85.219.169])
        by smtp.gmail.com with ESMTPSA id t185-20020a0deac2000000b005772e9388cdsm2782397ywe.62.2023.07.04.00.33.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 00:33:10 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id 3f1490d57ef6-c5cf26e9669so411782276.0;
        Tue, 04 Jul 2023 00:33:10 -0700 (PDT)
X-Received: by 2002:a25:8692:0:b0:bd0:5332:ad52 with SMTP id
 z18-20020a258692000000b00bd05332ad52mr10868693ybk.31.1688455990486; Tue, 04
 Jul 2023 00:33:10 -0700 (PDT)
MIME-Version: 1.0
References: <20230527164452.64797-1-contact@artur-rojek.eu>
 <20230527164452.64797-4-contact@artur-rojek.eu> <CAMuHMdV3gn8g-gKam71K=WfT3CVNwvz5eKPSh2Fqi3wVg7ZwNw@mail.gmail.com>
 <f7b9ceb9739f8ae5cbee4f6073ce3af3921a2540.camel@physik.fu-berlin.de>
 <CAMuHMdVFBo+KMNQ6gzh3rZrZ+_Wfg=UJ4XOW4Uqibnjm6T7CdA@mail.gmail.com>
 <8205bc2cb9f983914ff6920deed3f54893713ba0.camel@physik.fu-berlin.de>
 <d5667e9675bf8be35b1a5414d443b8f371b1bd9e.camel@physik.fu-berlin.de>
 <CAMuHMdV=kc1sZfsBad99ofbUBUyuZ_fAekdkFJYp9Rhskf9xWg@mail.gmail.com> <485e9274ebf29da4075b40c2888f95a6cdc6d4ed.camel@physik.fu-berlin.de>
In-Reply-To: <485e9274ebf29da4075b40c2888f95a6cdc6d4ed.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jul 2023 09:32:59 +0200
X-Gmail-Original-Message-ID: <CAMuHMdUtgUu36uMOS0ij=1_oFKeqj2kwb_4DkhxAsrZQisMpew@mail.gmail.com>
Message-ID: <CAMuHMdUtgUu36uMOS0ij=1_oFKeqj2kwb_4DkhxAsrZQisMpew@mail.gmail.com>
Subject: Re: [PATCH v2 3/3] sh: dma: Correct the number of DMA channels in SH7709
To:     John Paul Adrian Glaubitz <glaubitz@physik.fu-berlin.de>
Cc:     Artur Rojek <contact@artur-rojek.eu>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>,
        Rafael Ignacio Zurita <rafaelignacio.zurita@gmail.com>,
        linux-sh@vger.kernel.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Adrian,

On Tue, Jul 4, 2023 at 7:45 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Sat, 2023-06-17 at 13:09 +0200, Geert Uytterhoeven wrote:
> > On Sat, Jun 17, 2023 at 9:32 AM John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> > > On Thu, 2023-06-08 at 12:03 +0200, John Paul Adrian Glaubitz wrote:
> > > > > > > That is actually safer, as the user can override NR_ONCHIP_DMA_CHANNELS
> > > > > > > when configuring his kernel, thus breaking DMA  due to an incorrect
> > > > > > > value of SH_DMAC_NR_MD_CH.
> > > > > > >
> > > > > > > Unfortunately we cannot protect against that when using a single DMAC,
> > > > > > > as SH_DMAC_NR_MD_CH can be either 4, 6, or 8.
> > > > > > >
> > > > > > > Perhaps this configuration should be moved from Kconfig to <cpu/dma.h>,
> > > > > > > to protect against a user overriding this value?
> > > > > >
> > > > > > Isn't SH_DMAC_NR_MD_CH already hardwired to the SoC being used?
> > > > >
> > > > > It depends on CONFIG_NR_ONCHIP_DMA_CHANNELS, while it
> > > > > should be fixed based on the SoC.
> > > >
> > > > I agree. However, I would be fine with merging this patch set first and fixing
> > > > this particular issue in a follow-up series.
> > >
> > > So, my suggestion is to take this series as-is for 6.5, then get the other issues
> > > you mentioned fixed for 6.6. I think it's already a gain when these issues are
> > > fixed and the kernel boots on the HP Journada 680 again.
> >
> > Sure, I don't want to block the acceptance of this series at all.
> > Thanks!
>
> Apologies for the late reply. Would you mind adding your Reviewed-by to this patch
> before I review and apply the series?

With "must be a multiply of two" and "Must be an even number" removed.
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
