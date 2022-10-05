Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B10895F527A
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 12:21:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229829AbiJEKVM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 06:21:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229453AbiJEKVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 06:21:09 -0400
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6AB5760E3;
        Wed,  5 Oct 2022 03:21:08 -0700 (PDT)
Received: by mail-ed1-x52b.google.com with SMTP id u21so18144604edi.9;
        Wed, 05 Oct 2022 03:21:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=WkUF7nsCWMrVQcZjPcJShdJ544XjXf3Wq64oN9V1KwM=;
        b=iW47KgRGaHFC17do7RlXeHlCMVmgZQVkJ4WOZiycISwH6BHkk0XYlBS3ufqhFwFpAi
         5SasslWV/lQ5k0Y2c5dsA2p2daanQEh0osc3NIRUmNwME7S0ciI1Tyu70E3ZUWgZJAl4
         IZoRxBzt4KIITsZWaoAJAazFAg1QZy2V5Okt//0Oe62mkT+aXlBuH7mav/hwlVmWQaqB
         6wR1hXMZZ3cxOg3VnX4TNbe8AfSxNaqGgGbrOzcS8PgRRAhMXCbzUvdf65n0244SKezu
         B3lM7uq0ELCLs8d9QO7CFjFyXhceIsRG4lmW2JNaFJVrwcpyZh1HgfVPuV/MB6UQCkeB
         9qXA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=WkUF7nsCWMrVQcZjPcJShdJ544XjXf3Wq64oN9V1KwM=;
        b=qjvRay5uUy9zehyYWTYPRwFNYXLBQZS3dj6xbDiLCl3u07PBHmblza+gUIlTIYBr85
         vjguXa5ryQ5MPu7pMT0zXIj+Cti8q9/IIGfE50IMrccDslxwFOeX2l9Jkd3x/7QRuFJr
         SzHHyVgD60DmyrS1rkSu99HiOOBGmMDRLCzV0TsAYdvO3FFRJfdPtCYAnb1FHiR3TpBq
         Hte3TheixMLLT36ax9sDutagoCXJQarhtXP8BpiTk4K9rMZhwnOz5Yb9aSGXC+YNpWpU
         pBLodQjW6AyrrbeU/agTF72a09Cnw2XB9ibAorM6N1w5G73McKqaw09S0keq0xgJAe3j
         m6/g==
X-Gm-Message-State: ACrzQf2qcMdMCRls8QsbdsHIyb2/p2em28NQx9qbgQTC/Imp4RYihsm3
        18Q49TOVqngBdWcrrqYq/aaEH/2WiCuCQlw+z14=
X-Google-Smtp-Source: AMsMyM6/e7AQ2JNXwNzTR6TshoLirQtaoB5igRP6UNCpCiTb1aLMt2J+38J0hwLyWHxuPXoMyNpmbS7V+NYupLpXcgI=
X-Received: by 2002:a05:6402:50d1:b0:452:899e:77c with SMTP id
 h17-20020a05640250d100b00452899e077cmr27499515edb.0.1664965267172; Wed, 05
 Oct 2022 03:21:07 -0700 (PDT)
MIME-Version: 1.0
References: <20221003223222.448551-1-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <20221003223222.448551-3-prabhakar.mahadev-lad.rj@bp.renesas.com>
 <YzxwoELNBctbhjJb@spud> <CA+V-a8tgvF16vduoQ+ZbzTpRJUmCnN-GPQs5G8AqMOXbnznwHA@mail.gmail.com>
 <F0B6C609-6C39-4080-8F07-7FEFFAFEA993@kernel.org> <5254a42c-9233-6f9a-eff8-33324a184d20@microchip.com>
In-Reply-To: <5254a42c-9233-6f9a-eff8-33324a184d20@microchip.com>
From:   "Lad, Prabhakar" <prabhakar.csengg@gmail.com>
Date:   Wed, 5 Oct 2022 11:20:40 +0100
Message-ID: <CA+V-a8tS=vsTW=SvGeAjy_M9C=ZwtaWHYhdBK=XV0M9T_c3b5A@mail.gmail.com>
Subject: Re: [RFC PATCH v2 2/2] soc: renesas: Add L2 cache management for
 RZ/Five SoC
To:     Conor.Dooley@microchip.com
Cc:     conor@kernel.org, geert+renesas@glider.be,
        paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, magnus.damm@gmail.com,
        heiko@sntech.de, guoren@kernel.org, philipp.tomsich@vrull.eu,
        nathan@kernel.org, atishp@rivosinc.com, apatel@ventanamicro.com,
        linux-renesas-soc@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-riscv@lists.infradead.org,
        biju.das.jz@bp.renesas.com, prabhakar.mahadev-lad.rj@bp.renesas.com
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

Hi Conor,

On Wed, Oct 5, 2022 at 10:17 AM <Conor.Dooley@microchip.com> wrote:
>
> On 05/10/2022 09:58, Conor Dooley wrote:
> > EXTERNAL EMAIL: Do not click links or open attachments unless you know the content is safe
> >
> > On 5 October 2022 09:44:56 IST, "Lad, Prabhakar" <prabhakar.csengg@gmail.com> wrote:
> >> Hi Conor,
> >>
> >> Thank you for the review.
> >>
> >> On Tue, Oct 4, 2022 at 6:43 PM Conor Dooley <conor@kernel.org> wrote:
> >
> >>>> +static void cpu_dcache_wb_range(unsigned long start,
> >>>> +                             unsigned long end,
> >>>> +                             int line_size)
> >>>> +{
> >>>> +     bool ucctl_ok = false;
> >>>> +     unsigned long pa;
> >>>> +     int mhartid = 0;
> >>>> +#ifdef CONFIG_SMP
> >>>> +     mhartid = smp_processor_id();
> >>>> +#endif
> >>>
> >>> Won't this produce complaints from your if you compile with CONFIG_SMP
> >>> set?
> >>>
> >> No I dont see a build issue with SMP enabled, do you see any reason
> >> why it should fail?
> >
> > Not fail but complain about the unused variable.
> >
>
> Not unused variable, sorry but the unused 0 that it was initialised with*

No, it doesn't complain (I dont think compilers complain of such
unused assignments, maybe I'm wrong). BTW I am using GCC 9.4.0. Do you
think I need to update it?

Cheers,
Prabhakar
