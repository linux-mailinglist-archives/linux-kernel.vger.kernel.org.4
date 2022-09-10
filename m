Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF90F5B446B
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 08:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiIJG2i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 10 Sep 2022 02:28:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiIJG2f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 10 Sep 2022 02:28:35 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E58C09E0E6
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 23:28:34 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id d189so5578902ybh.12
        for <linux-kernel@vger.kernel.org>; Fri, 09 Sep 2022 23:28:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=VVGMPzF4qPTcVF0S13mk7tfi+gz326IHs3V7xzCu89k=;
        b=Q1yactfH9fHoBlFjLh/RkEEKZc3eMN7+1hST+ET0eD8TuzAbVHOIwT/SgxBsaOTOmw
         G1WGrYmr4IUkTkMAy/hg1UIFPTIKs91bN8kjU75OSnlWcHwbymrr+YXXBO+HSeMxL4ae
         3rImXB28cfFdSo5K/0RASIr9653GanFYqkkHqAk2E8YU9z8RakvPenpLqdspbdMYEgHn
         zwcK5R8EMG9BTqPEcP5HG9Gq4fFc8zA1mxXrNrI3BqTYYKd1OgoUsfABSRdkkwXbL+O9
         crCRzFvo/k2hIUfVWB0Z4bTI2j9D0h1jTQkgqsP1hsu2KTndX/Xp1UMyzcInHNTFSgIb
         U06A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=VVGMPzF4qPTcVF0S13mk7tfi+gz326IHs3V7xzCu89k=;
        b=xdej5MX8guyzuhsZX1S+MXg/qyzZqoc8yizPpPsz5XgXbP2rFLE/VJfbAhLUml+3to
         UiR+Ripjl0X/w89+E6cEOOCEIEBC1GsINSbGVQRnC6ug5iNEpcmbbx1Qjtx2zIqYpf3Q
         ML0230EEpmj8BGB+n26jRSST7mU2DzRYuDEe9GUL2rm0b45MF7573+3EWZIxXcvqJhq5
         wy+Vi7nk7lFdYfpJnKrz8fZ8lTDbtcr2faBFSRMIoL9z/PUkiNRT5qHvQJjr7pPpjVne
         P5y4fB+oLlLZBzcs8swSu4jEaXK3X6EeQo51UyiPt+xi58GnyoZ8SS7ujhPS9eee2aNP
         Xb5g==
X-Gm-Message-State: ACgBeo13SJDvPARqZECn8aqlaTcfrEuMaJCAC/YyrcAVOrCxQHiTeCbd
        He1BtTOeuG8bp8k2ykKQO7h+atkKb1FFGDrsQA8i3Z9PgTE=
X-Google-Smtp-Source: AA6agR5eOT8uI8O2s0BA5NJo82/U37NcUj2qumkS3F8JdL9Q4GLpnWh6BAB/JO2wVEvdfDr+LXl3ZDDd1UiFWz+1L6A=
X-Received: by 2002:a05:6902:56e:b0:6a8:f726:79cd with SMTP id
 a14-20020a056902056e00b006a8f72679cdmr14066826ybt.209.1662791314058; Fri, 09
 Sep 2022 23:28:34 -0700 (PDT)
MIME-Version: 1.0
References: <20220626201712.18064-1-ubizjak@gmail.com> <CAHk-=wiayOnntaOaQtjm4JXNoXjQdkyT3euMKNfn4ozHRk-oqg@mail.gmail.com>
In-Reply-To: <CAHk-=wiayOnntaOaQtjm4JXNoXjQdkyT3euMKNfn4ozHRk-oqg@mail.gmail.com>
From:   Uros Bizjak <ubizjak@gmail.com>
Date:   Sat, 10 Sep 2022 08:28:22 +0200
Message-ID: <CAFULd4bM0=oNvp5VAfHa59nBK3=f++PR3EB2B-Zds1ae+14dfA@mail.gmail.com>
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

On Sun, Jul 3, 2022 at 11:01 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> On Sun, Jun 26, 2022 at 1:18 PM Uros Bizjak <ubizjak@gmail.com> wrote:
> >
> >    Also, by using try_cmpxchg64() instead of cmpxchg64()
> > in CMPXCHG_LOOP macro, the compiler actually produces sane code,
> > improving lockref_get_or_lock main loop from:
>
> Heh. I'm actually looking at that function because I committed my "add
> sparse annotation for conditional locking" patch, and
> lockref_get_or_lock() has the wrong "polarity" for conditional locking
> (it returns false when it takes the lock).
>
> But then I started looking closer, and that function has no users any
> more. In fact, it hasn't had users since back in 2013.
>
> So while I still think ARCH_USE_CMPXCHG_LOCKREF is fine for 32-bit
> x86, the part about improving lockref_get_or_lock() code generation is
> kind of pointless. I'm going to remove that function as "unused, and
> with the wrong return value".

May I consider this message as a formal Acked-by: for the patch? I'll
resubmit the patch with a commit message updated to reference
lockref_put_not_zero instead of the removed lockref_get_or_lock.

Thanks,
Uros.
