Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9871A6BAC5F
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 10:43:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbjCOJn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 05:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjCOJnW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 05:43:22 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF3252F75;
        Wed, 15 Mar 2023 02:43:21 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id cn21so42834162edb.0;
        Wed, 15 Mar 2023 02:43:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678873399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=FdAORWhuy7UpOtPuCDIcq2G8nFcvWyaAoBPU8Jm7BG4=;
        b=HZLymt1yWd22U988Ky5g9AOZbRqgaMwK1eM/ZmdnmXQ00bSdAYqmGa2rUe2aiitvML
         2In12v+z4HpVvRfSJP5mkUyu3nBv6Wouiz6Pyl3J0XxBG1o+fF8uxBxrPywNNdG8aeV4
         4YO6EpK7qZwXwOkfXGscVbINkctbVHeF/xoM/uN8CSjWV2+SrAOIB5l0MOCKSuIymK9K
         hbFvcNV+UbA2J6e+yiLL3QXxXadSrR6CyYKcVgSHGg3GIyilZsm7VgMfzl6yz0pumORE
         NaFqdWodJxsUXXihmK8GnFXHbE+3YbjeWJxmvba8f+jm3cgZ9Nw8/DKAt8KGBFX8w/Ja
         qikQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678873399;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=FdAORWhuy7UpOtPuCDIcq2G8nFcvWyaAoBPU8Jm7BG4=;
        b=ENp9LQ+zv4KNLWVpXMjvewFvF+67YqIPHJzu2yIjW5aAuEB1okNyQaspk5RYuDxQ2L
         mPYkSF5JLLblLjn5LE75xdKj6Hl1vzK8Fb6iydpVdEXg5f8qNg3trMXsRWaY6gwqq7Yd
         3LaKoTBSbv7/LTLIPjpoyBf12UcwQeBqjNxwsSCaWph09Sst1BNxXxX0ixPL1T5B0Z3E
         MZ4u8aZ0G24s8dpXWcRX+5B8pcyVL4ygO/RZYBZGgIJ7cbzug9TjpL1vfMYlSvpm5Qfc
         U8WAEwZTjsdUramMOmrFaFmJrN4rWZVNKKbtMhu5IFGzsfSlTYHnOZ1rT8VYIsajHSfa
         GBQw==
X-Gm-Message-State: AO0yUKVu6l8yvhTyzRV3brsfSq7wCT7Sj3ICL47ZdMWs3I/cnHEgyFDL
        uT1JzQjDwCn9hl9AWYljNizbTsI8l9fDEG675EisT0wQc9U=
X-Google-Smtp-Source: AK7set8f4DgucIX2+xcISs7Sks0D0B7X1c5NnRYnH4rSvmtaCCsqH6ITS9FHJYnH6BeyO/ld9zQ7IB3wmVs3O66vgtM=
X-Received: by 2002:a50:aadd:0:b0:4fb:30fc:1e99 with SMTP id
 r29-20020a50aadd000000b004fb30fc1e99mr1094750edc.0.1678873399502; Wed, 15 Mar
 2023 02:43:19 -0700 (PDT)
MIME-Version: 1.0
References: <20230210111141.1379645-1-keguang.zhang@gmail.com>
 <a3e6f6038511ad48258627dbf4c335e2.sboyd@kernel.org> <CAJhJPsUQN5Lo_rVUbbmGY68gorwkcQT=9AXfcEh371cP97Wj_A@mail.gmail.com>
 <20230315092910.GA8008@alpha.franken.de>
In-Reply-To: <20230315092910.GA8008@alpha.franken.de>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Wed, 15 Mar 2023 17:43:02 +0800
Message-ID: <CAJhJPsWDO_nyPLH7uMTB+ODS74SAKDPGOXxk_Nperk1dKBKStQ@mail.gmail.com>
Subject: Re: [PATCH] MIPS: loongson32: Update the clock initialization
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-clk@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Serge Semin <Sergey.Semin@baikalelectronics.ru>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 15, 2023 at 5:29=E2=80=AFPM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Wed, Mar 15, 2023 at 11:07:23AM +0800, Keguang Zhang wrote:
> > On Sat, Feb 11, 2023 at 7:31=E2=80=AFAM Stephen Boyd <sboyd@kernel.org>=
 wrote:
> > >
> > > Quoting Keguang Zhang (2023-02-10 03:11:41)
> > > > The Loongson-1 clock driver is under re-implementation
> > > > to add DT support. As a result, ls1x_clk_init() will be dropped soo=
n.
> > > > Therefore, call of_clk_init() for clock initialization instead.
> > > >
> > > > Link: https://lore.kernel.org/all/20230209132614.1079198-3-keguang.=
zhang@gmail.com
> > > > Link: https://lore.kernel.org/all/20230209132614.1079198-4-keguang.=
zhang@gmail.com
> >
> > Hi Thomas,
> > Sorry to bother you.
> > For fear of raising build error, is it possible to merge this patch
> > before the above two patches getting applied?
> > Or is there anything to improve?
> > Thanks very much!
>
> the IMHO best way would be to let this patch go the same way as
> the other patch set. So Stephen could you take this into your
> tree, too ?
>
Sure. Will do.

> Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>
> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessaril=
y a
> good idea.                                                [ RFC1925, 2.3 =
]



--=20
Best regards,

Keguang Zhang
