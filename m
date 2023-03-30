Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBC836D00ED
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 12:16:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231255AbjC3KQr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 06:16:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230245AbjC3KQp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 06:16:45 -0400
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 341128A7C;
        Thu, 30 Mar 2023 03:16:25 -0700 (PDT)
Received: by mail-ed1-x533.google.com with SMTP id x3so74311205edb.10;
        Thu, 30 Mar 2023 03:16:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680171383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YXatgYbXhsZYoXe8ZY4NsV1wZPaLQfBBYSnqQiMHbS4=;
        b=IILSFggF6i4dBSm6O/OdfsNqvO8u9iaW4qy0DYrN8zd5KAHBHGwIvq24RZ/JVCwlGX
         F7rwcQe7/c/hayIO3i/ztQ4pERO3v5gaDLrtJV71/7HavVZCqIZfcC7fFrQAoYIU5EhJ
         yhSXDcxx6lHWFIqJ4NldHdGG6FPxuiwAgXOuAxGPUUwR2HVj7l7Inr3aQD2jEN+iPhYd
         NSh0zEjEt8fsq4+VbLW29rg9bq2EHQtB+9FWDrTikxRLrp7suh6CgfIBFjej7i9akxaW
         ZFPjjLFUl94Bz2DKh67Q/ESJCxfASj0RefWI4UZJYMt7R8HWzoZBTszDviumlyxce6J1
         ad5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680171383;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YXatgYbXhsZYoXe8ZY4NsV1wZPaLQfBBYSnqQiMHbS4=;
        b=iu2qWfjVUxKTQs8zJgVF0ilQx35qhigGsAUakfGG+Hgb4e0cwJGkChksFXFugv6w90
         eV6C9yyfjW0cu+BtIDZfRJID7FXb4/Lj5qIsQdtph4nLmbbfO11+7hNLrOoIMujqgtO7
         sZG/g1y+T5/6JOxKmFDxzTSsMb8dgz+bIgQ7rhWkT6W/6HlHn7NALp4aNxGH4mGHrdGz
         DFqqXO1omvn2xOT6H6ivcCZusbeOBw/xaRBspaUFt9bPRMcy07H+rf5/4cOa2BgM7GAQ
         6WyYlKPZMx86hwVsiwHSBeeSEw4YwNi6uLd/FEa7sJoCpB66CdyZILEc4V3LXx6+uelz
         z3UA==
X-Gm-Message-State: AAQBX9eSciqRQsR6vsDaMQfC3V7CnvrOwS26KEx007HvXzVyqSRCCJ35
        84nlWhtT9B2N8NkQDKZIdcgm44CZCF7W3UfnbGv1bnVplQnkfg==
X-Google-Smtp-Source: AKy350bAZ+jS3u/9uGH5AzTpN/eG0wqbQ1DzvuHB73JBZAeKSUwXVQbR2gx56Dr9jq4Kl7mve0ybsuNi+KVQ3FYgYP8=
X-Received: by 2002:a50:875e:0:b0:501:d2f5:7da9 with SMTP id
 30-20020a50875e000000b00501d2f57da9mr10801202edv.0.1680171383177; Thu, 30 Mar
 2023 03:16:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230328120506.375864-1-keguang.zhang@gmail.com>
 <20230328120506.375864-2-keguang.zhang@gmail.com> <20230328131735.GA11532@alpha.franken.de>
In-Reply-To: <20230328131735.GA11532@alpha.franken.de>
From:   Keguang Zhang <keguang.zhang@gmail.com>
Date:   Thu, 30 Mar 2023 18:16:06 +0800
Message-ID: <CAJhJPsXNujC1Wz=eHDkXREXSk3XT-co2V5XQXFRiNxUyr1TKGA@mail.gmail.com>
Subject: Re: [PATCH 1/3] MIPS: Loongson32: Remove deprecated PWM timer clocksource
To:     Thomas Bogendoerfer <tsbogend@alpha.franken.de>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-mips@vger.kernel.org,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 9:35=E2=80=AFPM Thomas Bogendoerfer
<tsbogend@alpha.franken.de> wrote:
>
> On Tue, Mar 28, 2023 at 08:05:04PM +0800, Keguang Zhang wrote:
> > The Loongson1 PWM timer will be moved to clocksource framework.
> > Then, the old driver is no longer needed.
> > Remove the deprecated code and update the Kconfig accordingly.
> >
> > Signed-off-by: Keguang Zhang <keguang.zhang@gmail.com>
> > ---
> >  arch/mips/loongson32/Kconfig       |  37 -----
> >  arch/mips/loongson32/common/time.c | 210 -----------------------------
> >  2 files changed, 247 deletions(-)
>
> Acked-by: Thomas Bogendoerfer <tsbogend@alpha.franken.de>
>
Hi Thomas,
Sorry!
I have to send v2 to delete the obsolete header file regs-pwm.h.

> --
> Crap can work. Given enough thrust pigs will fly, but it's not necessaril=
y a
> good idea.                                                [ RFC1925, 2.3 =
]



--=20
Best regards,

Keguang Zhang
