Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69C18628A31
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 21:11:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236771AbiKNULl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 15:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237446AbiKNULb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 15:11:31 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A5DA1A236;
        Mon, 14 Nov 2022 12:11:30 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id hh9so7493632qtb.13;
        Mon, 14 Nov 2022 12:11:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xE0dAKpBGmBo+dBYwNKS7hwOOhYBUTGgAYlVMA/0mbo=;
        b=ThjPT5EvDOWBr9mZ93WgcLDfbqyiAv7qXsCgX4Gg1S1TFJhZ1WX2HklyiZ592z62Bv
         s5vRkhmso5rYIrvQZznEV+XZSDg4pM+jXmCdUejX7us2cfPsXhKSLMGF929Y/Z7n+vAT
         cbZHqoK7JXlwrbluX8d39FJRwHcW5WU4Ynm/5eXdOHoyDXKzbnCHl1XoRcEzct4UCPLD
         WxqRKwbL25i8Le7pTksgTRX44ibuuta5Ci/tzehz+Y//qp5luIWgmsaXeE+jw1woqUHe
         3bkUqmP7XdCxklZOVFLIMzMGQ8zMywG/MO/dBFjEI9gPVMzmkNlzTsNKr6lVIcY03tFj
         D4Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xE0dAKpBGmBo+dBYwNKS7hwOOhYBUTGgAYlVMA/0mbo=;
        b=x1rRGmTo8xjQ3HYZobQr5nL7SAR+y8jGbPNJ43d1BYuqD7eB6BdCLigAnMdS6JKN0u
         PcRbu6bPfkrssbLV3peLX3fKuC8SxL8T+OnhNDa07lAMJT01VTz5EKVutt8xsHwr19Eb
         LKCzEb9sdM9lILnY1FevRm1B3ZEjtr7XV3ChQrZgtagUV2xziURLyVmueQ3esEeCwZoY
         TLDVx7fSUyXsR6IyPdu4HXIGSV+HD1ldPt3349A7QtnI2+YqBjb6/XoIEUssPEC/c7+A
         l0KE0IpBkd9bHN+clChG7UAG/BT6J/mPTMBQlJNH3qeQy0GEB2p1Wq5LjmM/8oki2mjt
         RZFA==
X-Gm-Message-State: ANoB5pk5wKm+NC8eHJ8LWMtXcHAG3D5mK2cSeR4O22rS90V4Aibuu26d
        1S3fqry0aJ9He/xmk2+18Jm84Fxi56iaKy/55l0=
X-Google-Smtp-Source: AA0mqf6agftU0LXb4mGusoE3Lvd4A4QQye3B8Mr4cMMKYc8ZKGxyACdrMpVm47bvuM8TEkMeK7ILwyt2yKk1RfqLrnE=
X-Received: by 2002:ac8:13c3:0:b0:3a5:27b2:c1ce with SMTP id
 i3-20020ac813c3000000b003a527b2c1cemr13626725qtj.458.1668456689530; Mon, 14
 Nov 2022 12:11:29 -0800 (PST)
MIME-Version: 1.0
References: <20221114180843.1125308-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <OS0PR01MB5922DDCE24ED6F6DD44B4B3F86059@OS0PR01MB5922.jpnprd01.prod.outlook.com>
 <CAMuHMdUFsOktkVG0T9yGoVSKZ=JP1bdWnhpyQ5rKFt545JYnHg@mail.gmail.com>
In-Reply-To: <CAMuHMdUFsOktkVG0T9yGoVSKZ=JP1bdWnhpyQ5rKFt545JYnHg@mail.gmail.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Mon, 14 Nov 2022 20:11:02 +0000
Message-ID: <CA+V-a8v65ruNJYETXTMW0K56ODc0mAUdTLcs7SWCLy-gKSL4Ww@mail.gmail.com>
Subject: Re: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we put the PM clocks
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Biju Das <biju.das.jz@bp.renesas.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-renesas-soc@vger.kernel.org" 
        <linux-renesas-soc@vger.kernel.org>,
        Fabrizio Castro <fabrizio.castro.jz@renesas.com>,
        Prabhakar Mahadev Lad <prabhakar.mahadev-lad.rj@bp.renesas.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Geert,

On Mon, Nov 14, 2022 at 7:03 PM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>
> Hi Biju,
>
> On Mon, Nov 14, 2022 at 7:42 PM Biju Das <biju.das.jz@bp.renesas.com> wrote:
> > > -----Original Message-----
> > > From: Prabhakar <prabhakar.csengg@gmail.com>
> > > Sent: 14 November 2022 18:09
> > > To: Geert Uytterhoeven <geert+renesas@glider.be>; Wim Van Sebroeck
> > > <wim@linux-watchdog.org>; Guenter Roeck <linux@roeck-us.net>; Philipp Zabel
> > > <p.zabel@pengutronix.de>; linux-watchdog@vger.kernel.org
> > > Cc: linux-kernel@vger.kernel.org; linux-renesas-soc@vger.kernel.org;
> > > Prabhakar <prabhakar.csengg@gmail.com>; Biju Das
> > > <biju.das.jz@bp.renesas.com>; Fabrizio Castro
> > > <fabrizio.castro.jz@renesas.com>; Prabhakar Mahadev Lad <prabhakar.mahadev-
> > > lad.rj@bp.renesas.com>
> > > Subject: [PATCH] watchdog: rzg2l_wdt: Issue a reset before we put the PM
> > > clocks
> > >
> > > From: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > >
> > > On RZ/Five SoC it was observed that setting timeout (to say 1 sec) wouldn't
> > > reset the system. To fix this we make sure we issue a reset before putting
> > > the PM clocks to make sure the registers have been cleared.
> > >
> > > While at it re-used rzg2l_wdt_stop() in rzg2l_wdt_set_timeout() as we were
> > > calling the same functions here.
> > >
> > > Signed-off-by: Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>
> > > ---
> > > Note,
> > > - This patch has been tested on RZ/G2L, RZ/V2M and RZ/Five.
> > > - My initial investigation showed adding the delay after
> > > pm_runtime_get_sync()
> > >   also fixed this issue.
> > > - Do I need add the fixes tag ? what should be the operation PUT-
> > > >RESET/RESET->PUT?
> >
> > It looks like timing issue, None of the previous devices are affected by this.
>
> To me it looks like the device must be clocked for the reset signal
> to be propagated?
>
In the HW manual (7.4.3 Procedure for Activating Modules) it does
state the below before applying the reset signal,

Set up the clock control register for the clock signal connected to
the target module to start the supply of the clock.
Note that the PLL for the clock should be started before the clock if
the PLL is stopped.

So maybe I can add the fixes tag in v2.

Cheers,
Prabhakar
