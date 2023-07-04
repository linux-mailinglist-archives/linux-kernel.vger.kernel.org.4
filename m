Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1014E746B3C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 09:55:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230316AbjGDHz0 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Tue, 4 Jul 2023 03:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230137AbjGDHzO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 03:55:14 -0400
Received: from mail-yw1-f174.google.com (mail-yw1-f174.google.com [209.85.128.174])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C03FE5F;
        Tue,  4 Jul 2023 00:54:54 -0700 (PDT)
Received: by mail-yw1-f174.google.com with SMTP id 00721157ae682-5703cb4bcb4so57043837b3.3;
        Tue, 04 Jul 2023 00:54:54 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688457293; x=1691049293;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=/6PEM/UjggbPB3U50bizdGKT5TbutaMqAFH7NawLuWM=;
        b=Q5s+lXJC7zbciN7St2jNyqE0XrGzGHUz/wSaIH6EJNTdbQdOvmnmHmVYEKksSPhpw0
         796ZiBTrLVWAI2JJ3Q5X/UUpzzNXb/9dpFrp8Dfuwpd0/RWy5Mq+Jvh8pefuInKZYM2S
         r7zpbUM6Oimd8WW4GI8fjEIhWDOZ6PG0DoZhYr3Mp7UIEHn7ohr6Pwz04kaXmi3HFcgv
         Z3BTwbF/ES4lXFsYZMh+ekLGI2YW0hFmmcSM9S2SV/oIxweW4J7mM+NY45uw9l2VOEp5
         9SiZgg3DiLDxU0W+fCwb6HuDj2BICjp2qt2ZRUqYvo9dL/epPYyB72T7eVQ/gqu1w/If
         mW7Q==
X-Gm-Message-State: ABy/qLaXd4vDD55Kt96/BmchUvdSdOQlm7ii4y+fxHLxB/A+XMY1jTxL
        3Rgz9mEssN2irgmpqmBTLrV2RGm9l64Jcg==
X-Google-Smtp-Source: APBJJlEu13jT5IYHerh5y8OXCZpB2G3am/20CXCveghqdOovEE5US5UR2FYwjoPSgmqtz+ZFKhWF+g==
X-Received: by 2002:a81:7d84:0:b0:577:60ba:440a with SMTP id y126-20020a817d84000000b0057760ba440amr10934249ywc.50.1688457293442;
        Tue, 04 Jul 2023 00:54:53 -0700 (PDT)
Received: from mail-yb1-f171.google.com (mail-yb1-f171.google.com. [209.85.219.171])
        by smtp.gmail.com with ESMTPSA id p190-20020a0de6c7000000b00577335ea38csm2749020ywe.121.2023.07.04.00.54.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 04 Jul 2023 00:54:53 -0700 (PDT)
Received: by mail-yb1-f171.google.com with SMTP id 3f1490d57ef6-c4dd264359cso2179908276.3;
        Tue, 04 Jul 2023 00:54:52 -0700 (PDT)
X-Received: by 2002:a25:df97:0:b0:bff:aaf9:b7a2 with SMTP id
 w145-20020a25df97000000b00bffaaf9b7a2mr13423578ybg.39.1688457292794; Tue, 04
 Jul 2023 00:54:52 -0700 (PDT)
MIME-Version: 1.0
References: <20230527164452.64797-1-contact@artur-rojek.eu>
 <20230527164452.64797-4-contact@artur-rojek.eu> <CAMuHMdV3gn8g-gKam71K=WfT3CVNwvz5eKPSh2Fqi3wVg7ZwNw@mail.gmail.com>
 <f7b9ceb9739f8ae5cbee4f6073ce3af3921a2540.camel@physik.fu-berlin.de>
 <CAMuHMdVFBo+KMNQ6gzh3rZrZ+_Wfg=UJ4XOW4Uqibnjm6T7CdA@mail.gmail.com>
 <8205bc2cb9f983914ff6920deed3f54893713ba0.camel@physik.fu-berlin.de>
 <d5667e9675bf8be35b1a5414d443b8f371b1bd9e.camel@physik.fu-berlin.de>
 <CAMuHMdV=kc1sZfsBad99ofbUBUyuZ_fAekdkFJYp9Rhskf9xWg@mail.gmail.com>
 <485e9274ebf29da4075b40c2888f95a6cdc6d4ed.camel@physik.fu-berlin.de>
 <CAMuHMdUtgUu36uMOS0ij=1_oFKeqj2kwb_4DkhxAsrZQisMpew@mail.gmail.com> <1af44c63f3fdffb3bb5d0cf718cc470ef8459c33.camel@physik.fu-berlin.de>
In-Reply-To: <1af44c63f3fdffb3bb5d0cf718cc470ef8459c33.camel@physik.fu-berlin.de>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Tue, 4 Jul 2023 09:54:41 +0200
X-Gmail-Original-Message-ID: <CAMuHMdW-zK9=FVN+hoqUfpbzwe6Un5k0PDgqV3ZdHveNZxDdyw@mail.gmail.com>
Message-ID: <CAMuHMdW-zK9=FVN+hoqUfpbzwe6Un5k0PDgqV3ZdHveNZxDdyw@mail.gmail.com>
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

Hi Adrian.

On Tue, Jul 4, 2023 at 9:43 AM John Paul Adrian Glaubitz
<glaubitz@physik.fu-berlin.de> wrote:
> On Tue, 2023-07-04 at 09:32 +0200, Geert Uytterhoeven wrote:
> > On Tue, Jul 4, 2023 at 7:45 AM John Paul Adrian Glaubitz
> > <glaubitz@physik.fu-berlin.de> wrote:
> > > On Sat, 2023-06-17 at 13:09 +0200, Geert Uytterhoeven wrote:
> > > > On Sat, Jun 17, 2023 at 9:32 AM John Paul Adrian Glaubitz
> > > > <glaubitz@physik.fu-berlin.de> wrote:
> > > > > On Thu, 2023-06-08 at 12:03 +0200, John Paul Adrian Glaubitz wrote:
> > > > > > > > > That is actually safer, as the user can override NR_ONCHIP_DMA_CHANNELS
> > > > > > > > > when configuring his kernel, thus breaking DMA  due to an incorrect
> > > > > > > > > value of SH_DMAC_NR_MD_CH.
> > > > > > > > >
> > > > > > > > > Unfortunately we cannot protect against that when using a single DMAC,
> > > > > > > > > as SH_DMAC_NR_MD_CH can be either 4, 6, or 8.
> > > > > > > > >
> > > > > > > > > Perhaps this configuration should be moved from Kconfig to <cpu/dma.h>,
> > > > > > > > > to protect against a user overriding this value?
> > > > > > > >
> > > > > > > > Isn't SH_DMAC_NR_MD_CH already hardwired to the SoC being used?
> > > > > > >
> > > > > > > It depends on CONFIG_NR_ONCHIP_DMA_CHANNELS, while it
> > > > > > > should be fixed based on the SoC.
> > > > > >
> > > > > > I agree. However, I would be fine with merging this patch set first and fixing
> > > > > > this particular issue in a follow-up series.
> > > > >
> > > > > So, my suggestion is to take this series as-is for 6.5, then get the other issues
> > > > > you mentioned fixed for 6.6. I think it's already a gain when these issues are
> > > > > fixed and the kernel boots on the HP Journada 680 again.
> > > >
> > > > Sure, I don't want to block the acceptance of this series at all.
> > > > Thanks!
> > >
> > > Apologies for the late reply. Would you mind adding your Reviewed-by to this patch
> > > before I review and apply the series?
> >
> > With "must be a multiply of two" and "Must be an even number" removed.
> > Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
>
> Thanks. I guess, I will drop the whole
>
>         "and clarify that NR_ONCHIP_DMA_CHANNELS must be a multiply of two"
>
> then. Correct?

Correct. Also in the help text.
Thanks!

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
