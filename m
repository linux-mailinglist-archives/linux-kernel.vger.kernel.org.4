Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7F58573A212
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 15:42:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229651AbjFVNmI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 09:42:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230462AbjFVNmE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 09:42:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1C651FC1;
        Thu, 22 Jun 2023 06:42:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5344E61857;
        Thu, 22 Jun 2023 13:42:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B4068C433CD;
        Thu, 22 Jun 2023 13:42:00 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687441320;
        bh=4LC7hw/PY4f5vlMOk+YDnrEpM4WWWX0cAv/SgJJYtgU=;
        h=References:In-Reply-To:From:Date:Subject:To:Cc:From;
        b=tSJlPFgnienD6jgfmeaKGzB0l+Kc6RnWss1WHP+ZHUNbzq6MPuAS05exbUr+fQJ9o
         p31BD97zTQRy1vmNPPX0SHnpZ0BnvfL7VNjuRWVfgMf16HPOgQiPS1evGUNQ1GVayl
         Hu+6wEvedKkAWcu8RZgmFhspiFqhFza5wCnvc3Zvxtm0StIfecqg0LReRMuH7aYLcI
         hjzL5o2iruFCiZN/CHwGXJ4igX0z8kFPExrJRtLLiXcDK8eZrtFWg7+T6KNGYZqYN/
         v3sK1DVSi2Lz0+O7D/ef9VxuFxrsfWjn6bmljjfABFo+pp0ebtxLmVGFGS5YgWo4vb
         ZxeY4qksBJ3NA==
Received: by mail-lj1-f174.google.com with SMTP id 38308e7fff4ca-2b477e9d396so68335761fa.3;
        Thu, 22 Jun 2023 06:42:00 -0700 (PDT)
X-Gm-Message-State: AC+VfDxVsAMpbOTBYenLwQi/2y+aJvYFqiMj8IG1gXpBWphlxBtNHKM6
        meDABErJSszh+SLDeUKLjsAeYoMsV+v4mKpjbg==
X-Google-Smtp-Source: ACHHUZ7emLjQORGniFVNfDpmunOmkm4bz1TNSJ8PNnkhTsylQPGLWjN4DySrgFxdcf2XZTL3yGZEM9JcQeMgXYPC7QA=
X-Received: by 2002:a2e:8848:0:b0:2b5:8335:a51f with SMTP id
 z8-20020a2e8848000000b002b58335a51fmr4662400ljj.11.1687441318581; Thu, 22 Jun
 2023 06:41:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230614173633.2430653-1-robh@kernel.org> <20230614173633.2430653-2-robh@kernel.org>
 <23325977-ba37-4360-afb5-4ab38a66107e@roeck-us.net> <feef6589-d0d6-8e64-fefd-914c234dcfba@kernel.org>
 <167e83a0-8666-27af-5e2c-4ddda917795a@roeck-us.net> <78cce73d-16d1-e357-bee7-2176479604f4@kernel.org>
In-Reply-To: <78cce73d-16d1-e357-bee7-2176479604f4@kernel.org>
From:   Rob Herring <robh@kernel.org>
Date:   Thu, 22 Jun 2023 07:41:45 -0600
X-Gmail-Original-Message-ID: <CAL_JsqLdEoiiCR6n1XqQe-6_9-9Hu1t_r17hXG9rTmSAMBZ9OA@mail.gmail.com>
Message-ID: <CAL_JsqLdEoiiCR6n1XqQe-6_9-9Hu1t_r17hXG9rTmSAMBZ9OA@mail.gmail.com>
Subject: Re: [PATCH 2/2] ata: octeon: Add compile test support
To:     Damien Le Moal <dlemoal@kernel.org>
Cc:     Guenter Roeck <linux@roeck-us.net>,
        Sergey Shtylyov <s.shtylyov@omp.ru>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-ide@vger.kernel.org, linux-mips@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 21, 2023 at 10:26=E2=80=AFPM Damien Le Moal <dlemoal@kernel.org=
> wrote:
>
> On 6/22/23 12:01, Guenter Roeck wrote:
> > On 6/21/23 17:57, Damien Le Moal wrote:
> >> On 6/22/23 01:51, Guenter Roeck wrote:
> >>> On Wed, Jun 14, 2023 at 11:36:33AM -0600, Rob Herring wrote:
> >>>> Add COMPILE_TEST to enable building Cavium Octeon drivers in MIPS
> >>>> allyesconfig/allmodconfig builds. There's a dependency on MIPS heade=
rs,
> >>>> so other arches can't be enabled.
> >>>>
> >>>> Signed-off-by: Rob Herring <robh@kernel.org>
> >>>> ---
> >>>> Tested on allmodconfig build. Not sure if there's other MIPS configs
> >>>> where this doesn't work. We'll see what 0-day says.
> >>>
> >>> Odd, in next-20230621 I get:
> >>>
> >>> Building mips:allmodconfig ... failed
> >>
> >> Indeed odd. Given that this is an allmodconfig, I would assume that
> >> CONFIG_CAVIUM_OCTEON_SOC is set ?
> >>
> >
> > No, it is not. CONFIG_CAVIUM_OCTEON_SOC is a choice option,
> > meaning only one of the choices can be set, and mips:allmodconfig
> > selects a different choice.
>
> OK. Then I think I need to drop this patch as I do not see how to allow
> COMPILE_TEST without CONFIG_CAVIUM_OCTEON_SOC being set.
>
> Rob ?

These could be fixed, but not sure it's worth the effort.

> >
> > Guenter
> >
> >>> --------------
> >>> Error log:
> >>> ERROR: modpost: "__udivdi3" [drivers/ata/pata_octeon_cf.ko] undefined=
!

This is due to 64-bit divides on 32-bit build, so do_div() needs to be used=
.

> >>> ERROR: modpost: "octeon_get_io_clock_rate" [drivers/ata/pata_octeon_c=
f.ko] undefined!

We'd need a static inline in the header for octeon_get_io_clock_rate().

Of course the real fix is Octeon needs to move to use the clock framework.

> >>> ERROR: modpost: "__tracepoint_ata_bmdma_stop" [drivers/ata/pata_octeo=
n_cf.ko] undefined!
> >>> ERROR: modpost: "__traceiter_ata_bmdma_stop" [drivers/ata/pata_octeon=
_cf.ko] undefined!

Probably can just drop the trace_ata_bmdma_stop() call. It was added
to replace a printk.

Rob
