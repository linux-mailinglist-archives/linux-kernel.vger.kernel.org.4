Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF11B5F9F3B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 15:14:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229931AbiJJNOn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 09:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiJJNOk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 09:14:40 -0400
Received: from mail-lj1-x22b.google.com (mail-lj1-x22b.google.com [IPv6:2a00:1450:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7906CF0
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 06:14:34 -0700 (PDT)
Received: by mail-lj1-x22b.google.com with SMTP id bs14so298859ljb.9
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 06:14:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ventanamicro.com; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=OXyeQu4pjY7czfJQbaMj9AK6RvZC9JV1U7ovRNzbT44=;
        b=l9pgHcG7BnSrXinqIZNGqO0oKd9QBp0Um2ZQROjA/OyzUDVDP4li5WZ1BwmrBo0NMd
         yeY/6aLFJfGf6ows5gAcvBuvMaAgrbT+Uc6ManoK50aqeI58XE1SlQ2hq1C7e/GcLVWQ
         5f1C4G9NyCMbtYLRREA0L7JpryofEtUdoV1abCBScZo0k6kmBrJFqz1gLTpTu51CTlvg
         lIpFYnNZwy0Mu7vUjdO/1tvgsYPej1hTosyVj8pobYJ0nAuTVQ1QOK7SX8qQhvooNC7C
         uxemMAAr75TkOvI/1IEvR/yo1pkrzMwCZvxsv6BUhsxTNMLlW9QBATERWyXoN+/ZBtaZ
         sx8g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OXyeQu4pjY7czfJQbaMj9AK6RvZC9JV1U7ovRNzbT44=;
        b=MnIK5+URcaHfnODqHVVnJoHlZrrKfglKCb/pFcGVEECAaHmCTTKpXGx3Wx8SU/x4aW
         Csne0fs7yCQQTly4lmQNBwzx5BaY0yRdNOKco/tPbiY9DzQl8FgINjejsVWYBkpBbGRK
         kjB/pBbQ9j3pNBFSeVBsk1KQ6MKg3z8UEORbapUDZCAzyqQVo8PgDb2UgueCdBlGiLcB
         6MNSxUvjnz12J16u1cp/Xjbnq9ROOFWzpTm5yjhF08F2Cfqrb3HwuI1Hevxxjs6tTiLo
         /Wlg+3L3zc5BIPClD1J82En7nAmexqULWQbUSkNJpHQK+qhj8nm5DoTXuJlyRqcOf1GE
         0UaA==
X-Gm-Message-State: ACrzQf2mha2ppkPxSYAxvbF+z8h3t3WCeY1wgJaa3ZmHtJ06mvbYaSEQ
        KJBk4lJyJ5yuWBlJeDiHCgR0j9bj+60/9A26aWMgnw==
X-Google-Smtp-Source: AMsMyM5H8QBrSwBPLDlELP6PNp2YVhFqVvYnLuqWAR8hsw1aEyZU5jG+G437Ohm7dRrP5lHUu0kVHgyAVU/wVS3Iz6I=
X-Received: by 2002:a2e:3017:0:b0:26e:1730:9064 with SMTP id
 w23-20020a2e3017000000b0026e17309064mr6908363ljw.34.1665407672213; Mon, 10
 Oct 2022 06:14:32 -0700 (PDT)
MIME-Version: 1.0
References: <20221010122726.2405153-1-heiko@sntech.de> <20221010122726.2405153-2-heiko@sntech.de>
 <CAK9=C2VHPBgL208ZHb78Nab1dQjfF6tZuKTRRT5V=vnvfODEGw@mail.gmail.com> <7864901.lvqk35OSZv@phil>
In-Reply-To: <7864901.lvqk35OSZv@phil>
From:   Anup Patel <apatel@ventanamicro.com>
Date:   Mon, 10 Oct 2022 18:44:21 +0530
Message-ID: <CAK9=C2W4doWTnqgmj9XcJtMz_eiGZ-=wA1cC=-xKd3v+2=RO6g@mail.gmail.com>
Subject: Re: [PATCH v5 1/2] RISC-V: Cache SBI vendor values
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     atishp@atishpatra.org, anup@brainfault.org, will@kernel.org,
        mark.rutland@arm.com, paul.walmsley@sifive.com, palmer@dabbelt.com,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, Conor.Dooley@microchip.com,
        ajones@ventanamicro.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 6:25 PM Heiko Stuebner <heiko@sntech.de> wrote:
>
> Am Montag, 10. Oktober 2022, 14:45:45 CEST schrieb Anup Patel:
> > On Mon, Oct 10, 2022 at 5:57 PM Heiko Stuebner <heiko@sntech.de> wrote:
> > >
> > > sbi_get_mvendorid(), sbi_get_marchid() and sbi_get_mimpid() might get
> > > called multiple times, though the values of these CSRs should not change
> > > during the runtime of a specific machine.
> > >
> > > So cache the values in the functions and prevent multiple ecalls
> > > to read these values.
> > >
> > > As Andrew Jones noted, at least marchid and mimpid may be negative
> > > values when viewed as a long, so we use a separate static bool to
> > > indiciate the cached status.
> > >
> > > Suggested-by: Atish Patra <atishp@atishpatra.org>
> > > Signed-off-by: Heiko Stuebner <heiko@sntech.de>
> > > ---
> > >  arch/riscv/kernel/sbi.c | 30 +++++++++++++++++++++++++++---
> > >  1 file changed, 27 insertions(+), 3 deletions(-)
> > >
> > > diff --git a/arch/riscv/kernel/sbi.c b/arch/riscv/kernel/sbi.c
> > > index 775d3322b422..cc618aaa9d11 100644
> > > --- a/arch/riscv/kernel/sbi.c
> > > +++ b/arch/riscv/kernel/sbi.c
> > > @@ -625,17 +625,41 @@ static inline long sbi_get_firmware_version(void)
> > >
> > >  long sbi_get_mvendorid(void)
> > >  {
> > > -       return __sbi_base_ecall(SBI_EXT_BASE_GET_MVENDORID);
> > > +       static long id;
> > > +       static bool cached;
> > > +
> > > +       if (!cached) {
> > > +               id = __sbi_base_ecall(SBI_EXT_BASE_GET_MVENDORID);
> > > +               cached = true;
> > > +       }
> > > +
> > > +       return id;
> > >  }
> > >
> > >  long sbi_get_marchid(void)
> > >  {
> > > -       return __sbi_base_ecall(SBI_EXT_BASE_GET_MARCHID);
> > > +       static long id;
> > > +       static bool cached;
> >
> > This breaks for heterogeneous SMP systems (similar to big.LITTLE)
> > where HARTs will have different marchid even though they belong to
> > same CPU Vendor.
> >
> > Due to the above rationale, the patch adding marchid, mvendorid, and
> > mimpid in /proc/cpuinfo caches these values on a per-CPU basis.
>
> For people reading along, I think you mean
> https://lore.kernel.org/r/20220727043829.151794-1-apatel@ventanamicro.com

Yes, this is the patch I am referring.

>
> For my understanding, was there a reason in the past for doing the caching
> only for cpuinfo and not for every invocation of the ecalls?

The caching was done only for /proc/cpuinfo because at that point
time only "cat /proc/cpuinfo" would need these value at runtime.

Now that we have more uses of marchid, mvendorid, and mimpid,
at runtime, we should definitely have the cached values available
to other parts of kernel.

My suggestion is to keep sbi_get_xyz() functions unmodified and
instead add new functions in arch/riscv/kernel/cpu.c (on-top-of
/proc/cpuinfo patch) which allows users to read cached values of
any CPU.

For example, we could export following functions from
arch/riscv/kernel/cpu.c:
unsigned long riscv_cached_mvendorid(unsigned int cpu);
unsigned long riscv_cached_marchid(unsigned int cpu);
unsigned long riscv_cached_mimpid(unsigned int cpu);

Regards,
Anup
