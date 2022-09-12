Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DAFD05B572A
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 11:26:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229885AbiILJ0u (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 05:26:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbiILJ0k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 05:26:40 -0400
Received: from mail-yw1-x1133.google.com (mail-yw1-x1133.google.com [IPv6:2607:f8b0:4864:20::1133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61FD9356F7
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:26:39 -0700 (PDT)
Received: by mail-yw1-x1133.google.com with SMTP id 00721157ae682-348b1838c2bso92999687b3.3
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 02:26:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=cwQj5obcaM7B1VRLTw3R5nGoUNAD1mxjg74I4qTPXT4=;
        b=b2yPVa9fb68JXnUGEb+T8BHV4rpc6FCpV5KcLnBMMCngN5aIJMatluHfkrbwJ0QNJg
         P+LUwGnTKxvO/6mFxK0ZwLwmwen1OoMCt5iEENFSrd9wLNw6ScOU9OQaS9wwRiknPEKv
         J8oqwscUaOIDBvgP9o+ALugwKn81PUguHwitCPhxeI4FGObr7xlMR6lToRcUG8yDe7jv
         dLQMl1dT+8EhyM09k/Fjt9BFUhDsZoqHcdzCfk6AutCX4j7iMI+kpsg3j0FrD52e3Hbi
         XSdtg4uB97jagdmFctXXfQZ+c+pSQcjcMKNax1cHQDo1iIiPgg9+P46sorcW6vvbe7/G
         LXWw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=cwQj5obcaM7B1VRLTw3R5nGoUNAD1mxjg74I4qTPXT4=;
        b=WHnvsjpGFDOv7B1PSd78F3xahMsl+rbMUgGlnmQIzaSHkb1tydUiCx58dGOUsrkKw6
         ZOR98oGKAuiWO7YHrMthL0oNWvBkfHZF6VUMouy7T32RkecVrzdCR5X94M7LfhfAwE9J
         XqXB/fugXXCGmRIPVhGBsupHh3kxbKIgvNmIcHuyZJS53mSu0ovWU815A9yOouZ6JBJA
         LGymaymAz3P3P2AEvG3bWjRC7bEATjRZAF/RE6O8Nw/S9ejWbIbSNnWkiqUJJAza0pHb
         PXiKWlpHOBXlcXFsCp7UMJ9h2LRNOJNvb0pmvMxFRKPL4rwviw/dWMhso/MW0yRbRUCI
         x8yQ==
X-Gm-Message-State: ACgBeo3GJ0gIiJO8K2YPYAqBDqJx+91BsvWmHjOMWIN0acqaC4Gm+qx0
        Ple88ogYN4uokPdFX86OAsMzHch7Z1XQo2mh7d5nO4j8qeE=
X-Google-Smtp-Source: AA6agR4QWpforoq11G7M2G7vbWVhQWNSW6oRbW+whR3ru3y+OZqPnTMvwaS5k5Mv7zTU1W+mavx8EmreKwwIxvKkA58=
X-Received: by 2002:a0d:eb15:0:b0:345:4a33:1d43 with SMTP id
 u21-20020a0deb15000000b003454a331d43mr21109579ywe.181.1662974798460; Mon, 12
 Sep 2022 02:26:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220626201712.18064-1-ubizjak@gmail.com> <CAHk-=wiayOnntaOaQtjm4JXNoXjQdkyT3euMKNfn4ozHRk-oqg@mail.gmail.com>
 <CAFULd4bM0=oNvp5VAfHa59nBK3=f++PR3EB2B-Zds1ae+14dfA@mail.gmail.com> <CAHk-=wiEQeRuAwHYOS6oBmewLBXg6Nd6xMPmMz2E75f660TDSA@mail.gmail.com>
In-Reply-To: <CAHk-=wiEQeRuAwHYOS6oBmewLBXg6Nd6xMPmMz2E75f660TDSA@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Mon, 12 Sep 2022 11:26:27 +0200
Message-ID: <CAFULd4YwShMV4Zi-Qv0F3XHtJtEsogPPGp+xwGACB8Ei_RGXWg@mail.gmail.com>
Subject: Re: [PATCH v2 RESEND] locking/lockref/x86: Enable ARCH_USE_CMPXCHG_LOCKREF
 for X86_CMPXCHG64
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     "the arch/x86 maintainers" <x86@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Sep 10, 2022 at 7:23 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sat, Sep 10, 2022 at 2:28 AM Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> > May I consider this message as a formal Acked-by: for the patch? I'll
> > resubmit the patch with a commit message updated to reference
> > lockref_put_not_zero instead of the removed lockref_get_or_lock.
>
> Sure, sounds good to me.
>
> It would be particularly nice if you can also see any change in
> performance numbers - but that simply may not be possible.
>
> 32-bit x86 tends to also be very low core count, so the whole lockref
> thing may or may not be measurable (no practical contention on the
> lock), but the code certainly seems to get better.

I tested this patch on an old core-2 duo in 32-bit mode, mainly to
test my try_cmpxchg64 patch on 32-bit targets. There were no
observable changes in the run time, but we are talking about a
two-core system here. OTOH, there were considerable code-size savings,
as noticed in my patch submission entry.

Please also note, that I am aware that changes to the default
configuration of 32-bit falls into the vintage computing nowadays.
However, a couple of enthusiast old-timers would still like to squeeze
some more juice out of their old rigs (e.g. m68k, alpha and x86-32) by
using all available processor infrastructure. OTOH, I don't want to
burden x86 maintainers with my hobby, but here we are talking about
such low-hanging fruit that it warrants the one-line change. By the
same patch, the default config can be cleaned a bit and made a bit
more consistent also for x86_64.

Thanks,
Uros.
