Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70578614FE5
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Nov 2022 18:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229636AbiKARA0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Nov 2022 13:00:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231192AbiKARAY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Nov 2022 13:00:24 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 412A8E52
        for <linux-kernel@vger.kernel.org>; Tue,  1 Nov 2022 10:00:23 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id l42-20020a9d1b2d000000b0066c6366fbc3so2232948otl.3
        for <linux-kernel@vger.kernel.org>; Tue, 01 Nov 2022 10:00:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xk+MtDazZwHkRnY9ofj6QJmGpLSc2+y5Ct3XSUfAelc=;
        b=QyMYws8rgBJ9b00O9E8UIu8UKBiysOXXb0NQzFXBrd8FSajn4in+zEoMxHwBdKVX2z
         qu+4kk1Q+1O+D0MGykvBTLWshOvoSlJxhsv7sXtwWMO6aLy+oHj7mhJxtgN1rDVaabzx
         C1RQFr7WCHncNVzoz2zhvyFfEhxNDJ7XjBX5+/c3Z7IzzBe1xR1wmflg4RJeSd8ezXQM
         1P+LyQpe1/ihEmhBdir7v0fnebdFwN3k4TP0HqkLjrHJP4JoX4nEWB44aa+s6Rzx9DqX
         9ddQ9RVbuMGSKI/EOOFbfvYVJZkZv3j4nOzAw/XEjNzD8nSPSzm3ixGpGnWxkFEg70c4
         ONpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:sender:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=xk+MtDazZwHkRnY9ofj6QJmGpLSc2+y5Ct3XSUfAelc=;
        b=dBv8r1Yon9xs6tbYia91dIKFONkXtMCqfbeZ30hgUuH3r0W6zsfbdFr++baJVUEcWO
         mDoJ/dtJMJ8DeL1nrs5sCnFnf2yoTGHLRAYoCBncenE2xMm5Ukxj4GKGEPKR+Tu3p3z8
         hYxWSEO0xR4MVWATcYnX658lkt9vGDKT3E01YmLXMEB5sX2sRqpQdL0KxMbhJSwewSLn
         wxcgoSLG9Kif7Oa1KuiJRXDHCyYeJnMwxpT3O9arcKS2o+aCtOwNSJkjXnlXDxTg9Y4k
         nayFrVPYAelqsLKii3tdVFg0oGJGT8+akWsOT/AEbpplTW36rq02awVaG57OOpVWCcbj
         9ljQ==
X-Gm-Message-State: ACrzQf0frAMIStXncCeviefQmrXW3b3OJ00SYCMKzCn1N4BgqxHwahu7
        pKgO0v/Hb3DNZArReEqKu8XADIqs8zA=
X-Google-Smtp-Source: AMsMyM6M4mNeyT98P4VyrDPXxkgpwL9ShPbp6gBfaxGb9sD4/3pngjoRmc2QtsnzyNqVkHiXek3JIA==
X-Received: by 2002:a9d:4d90:0:b0:66c:47a9:da6c with SMTP id u16-20020a9d4d90000000b0066c47a9da6cmr7228423otk.250.1667322022532;
        Tue, 01 Nov 2022 10:00:22 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t14-20020a056808158e00b00349a06c581fsm3613672oiw.3.2022.11.01.10.00.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Nov 2022 10:00:19 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Date:   Tue, 1 Nov 2022 10:00:15 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>
Subject: Re: Linux 6.1-rc3
Message-ID: <20221101170015.GA1314742@roeck-us.net>
References: <CAHk-=wgJVNe4mUxGJE5B-_GMg0oOgxkZz3UxehVRiCT3QvoZ0w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAHk-=wgJVNe4mUxGJE5B-_GMg0oOgxkZz3UxehVRiCT3QvoZ0w@mail.gmail.com>
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Oct 30, 2022 at 03:35:51PM -0700, Linus Torvalds wrote:
> It's Sunday afternoon, so it must be time for an rc release.
> 
> I know I said last week that rc2 was unusually large. It turns out
> that rc3 is almost exactly the same size. But at least for an rc3
> release, that bigger size is a bit more normal: this is when people
> are starting to find problems and send in fixes for them.
> 
> So while rc2 was just _way_ bigger than usual, rc3 is only a bit
> larger than an average rc3 release is. But it's still on the largish
> side. I hope that things start calming down, and we'll start seeing
> the size of these rc's shrink. Please?
> 
> Unlike rc2, there's no one single reason for the bulk of the rc3
> changes. They're pretty much all over, with the usual distribution -
> drivers dominating (networking, gpu and sound are most noticeable, but
> there's a little bit of everything).
> 
> Outside of drivers, tool updates stand out, with selftests, perf, and
> the pm-graph tool all seeing a fair amount of changes.
> 
> And then we have the usual things: architecture updates, some
> filesystem work, and core kernel fixes (mainly networking and mm).
> 
> Anyway, while it isn't small, nothing looks particularly worrisome or
> strange, and I thin kyou can just scan the appended shortlog to get a
> feel for the kinds of fixes we have here. Please do give it more
> testing, and here's to hoping we'll start seeing the rc's shrink from
> now on.
> 

Build results:
	total: 152 pass: 152 fail: 0
Qemu test results:
	total: 500 pass: 500 fail: 0

No runtime warnings.

There is one spurious build error. It does not happen all the time,
and even on the same SHA it is not easy to reproduce. If I see it,
I may see it on one server reliably but not at all on another with
almost the same hardware configuration.

Building powerpc:allnoconfig ... failed
--------------
Error log:
Inconsistent kallsyms data
Try make KALLSYMS_EXTRA_PASS=1 as a workaround

I first noticed the error after commit 73bbb94466fd ("kallsyms: support
"big" kernel symbols"). Reverting this commit fixes the problem if and
when it is reproducible. I can not reproduce it with v6.1-rc3.
KALLSYMS_EXTRA_PASS=1 does _not_ fix the problem. Adding more kallsyms
passes (I tried up to 20) does not help either; it never stabilizes.
Instead, the data oscillates between runs (i.e., if it happens, even
runs produce the same kallsyms data, and odd runs produce the same data).

Maybe something changed between commit 73bbb94466fd and v6.1-rc3 and
the problem is gone for good. If not I'll report if I see it again.

Guenter
