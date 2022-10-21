Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1FC0F6070FC
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Oct 2022 09:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230049AbiJUHZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Oct 2022 03:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiJUHY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Oct 2022 03:24:59 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D0805A8F0;
        Fri, 21 Oct 2022 00:24:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AD26B829DA;
        Fri, 21 Oct 2022 07:24:45 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A7F24C433B5;
        Fri, 21 Oct 2022 07:24:43 +0000 (UTC)
Authentication-Results: smtp.kernel.org;
        dkim=pass (1024-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="VEQcLfJR"
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zx2c4.com; s=20210105;
        t=1666337080;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=c1x8QUT5O2OciEEXZVNz4pBAlOtVi5j4g0TsFcYJWC8=;
        b=VEQcLfJR06RATWj1jP6BEamliNWicNQZCUIn2xNmezRUMPUgZLtr+wqFyJofCctaXj9WhW
        0GqT14rlvlxvlxX641dspQnkeOai1eP1obvQuTx0qp1k1fsQeu24bC3Sn8MwdK4yoU3Z3Y
        wcpIsCpCwvogKB2VSpeiztadbJfLt44=
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id a6851a28 (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Fri, 21 Oct 2022 07:24:40 +0000 (UTC)
Received: by mail-vk1-f179.google.com with SMTP id e8so1000324vkm.9;
        Fri, 21 Oct 2022 00:24:39 -0700 (PDT)
X-Gm-Message-State: ACrzQf1j27/hDx8qcmBYGR2ejcFAeVmQyDhrF2zIJXuirxkVkKPPQO/D
        jasa5ZZSkXKzhMn12TGQA4iMXUTB7JZcCCGEr7M=
X-Google-Smtp-Source: AMsMyM6iQcd6TjLHKvikCsvJ3cGYu3DXKNh/p5VusNHTRGcKUe3LSPwOAqFsvFTgINCUR+iVmjUSnm5Q/71PdT5Y1zw=
X-Received: by 2002:ac5:cbd3:0:b0:3ab:ab7c:178f with SMTP id
 h19-20020ac5cbd3000000b003abab7c178fmr11282181vkn.37.1666337078591; Fri, 21
 Oct 2022 00:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221020000356.177CDC433C1@smtp.kernel.org> <Y1EZuQcO8UoN91cX@localhost.localdomain>
 <CAHmME9prEhkHqQmtDGCSFunNnxiKdE_8FHKiksyqebUN63U81Q@mail.gmail.com>
 <CAHk-=whFow9Wd6C8htoRUt5wXbwf1i_qbuArBbhXOPqYsTFvtw@mail.gmail.com>
 <CAHmME9qBZqTd0D_gr8nE+DUzCrC0fxZNZK=7u+21jbgtFgAJBg@mail.gmail.com>
 <CAHk-=wjZDC9o8iwF+bU91Hx40HjGOpMui+VoFCDJkaGCu=rG4A@mail.gmail.com>
 <202210201151.ECC19BC97A@keescook> <CAHk-=wgdXRZy0-3v+vLZdDfRFKFXZLehgmR2QUKSemBA99sfmg@mail.gmail.com>
 <CAHk-=wjvp=ys2adnWwc1PNt3OrZ_0EkFaUcvjiVuOoVNjX_+AA@mail.gmail.com> <Y1JA0S7jvlA2573n@kroah.com>
In-Reply-To: <Y1JA0S7jvlA2573n@kroah.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Fri, 21 Oct 2022 03:24:27 -0400
X-Gmail-Original-Message-ID: <CAHmME9ouSriPmMCQ3kfF01k4-D4hc7g22GE8m79gT5snqr7MSg@mail.gmail.com>
Message-ID: <CAHmME9ouSriPmMCQ3kfF01k4-D4hc7g22GE8m79gT5snqr7MSg@mail.gmail.com>
Subject: Re: [PATCH -mm] -funsigned-char, x86: make struct p4_event_bind::cntr
 signed array
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Alexey Dobriyan <adobriyan@gmail.com>,
        akpm@linux-foundation.org, linux-kernel@vger.kernel.org,
        mm-commits@vger.kernel.org, masahiroy@kernel.org,
        andriy.shevchenko@linux.intel.com,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Greg,

On Fri, Oct 21, 2022 at 2:48 AM Greg KH <gregkh@linuxfoundation.org> wrote:
>
> On Thu, Oct 20, 2022 at 01:17:33PM -0700, Linus Torvalds wrote:
> > And in other cases, there's no actual difference at all, just
> > different register usage, so the diff looks fairly big, but doesn't
> > seem to be real.  In one case I looked at, it started with a 'movzbl',
> > but it was that in both cases, because the type was actually 'unsigned
> > char' to begin with. But for some reason it just used different
> > registers. Example:
> >
> >  - handle_control_request() in drivers/usb/gadget/udc/dummy_hcd.c
> >
> >    The reason here *seems* to be that
> >
> >                         char *buf;
> >                         buf = (char *)urb->transfer_buffer;
> >
> >    where it really probably should be 'u8 *buf', since it actually
> > does a cast to 'u8' in one place, but there isn't even any read of
> > that 'buf' pointer. So the difference seems to be entirely just some
> > "different type in assignment" cast internal to gcc that then
> > incidentally generated a random other choice in register allocation.
>
> I've send a patch for this now:
>         https://lore.kernel.org/r/20221021064453.3341050-1-gregkh@linuxfoundation.org
> and will take it through the USB tree, unless Jason wants to grab it
> through his tree.

This doesn't appear to have any actual effect, but just changes gcc's
register allocation unexpectedly. So feel free to take it, as it
doesn't seem like it's "one of those bad cases" that I'm keeping track
of.

Jason
