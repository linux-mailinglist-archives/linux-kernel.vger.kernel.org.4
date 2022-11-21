Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC176631BC0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:44:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230129AbiKUIoj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:44:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiKUIoh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:44:37 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9513520BC8
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:44:36 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id e76so4047815yba.5
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:44:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=MOA8LWvdV7vpIMbp9gmLxG/AXDKNs21CCNUeFEEyCbw=;
        b=mh4hjbsIkIWgtGVdWHbO6uRTTCtqDAaA0PiKTf6yrwq0RcoypNQhrl/hYvdzXzWCSx
         4lh1uj9/Hk34rHY3RRHj8YY0c0FzORA+o2GBvv6yPIZSjhd2jlsh+8T8lCDtdOkXtmOB
         rW/pgrqGY06BVrtyfCcsByO5HjzpcxVzOLy4QJPB2k6nSxcRbaEqvJWnrLb4tx7GSnYB
         aw5TNaDTTXCSZj5CcoHz4YDn4hvADeiFFUiFWRXOLPdDVvBkC7JFocJIFD36e3P0lr+w
         j5UVmAkFg4IDeJgaGmQ+j7zvrpC4P+ES1RMO0XnoUx+Zvly7UwjMnf+W7bFcUla06Xxh
         KYDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=MOA8LWvdV7vpIMbp9gmLxG/AXDKNs21CCNUeFEEyCbw=;
        b=Ke9Z+HL/q+Fg2R4fFqlxWWCipuIUk/qyQuQRAKwzl6tn75v0xsK4v7TzEYDed7GNjY
         OaCwlV4Edv3vIJYfO7BjM/oq6lyw7grJWSyh0hQrgj7FwIiyqwFx7R5w8FE6l+RJ4NP5
         6k+6KpDeeWmzPeLpKQAg/nE/cBBfHMsBoxpRosIfDzmNZTBwZksukXFYUbq3b/AHereB
         IbMRMFs95tfM3TTX0S9LZj+nKGchMCfG9GH5AxfZcldSUco6yz3kUTzdOkp5OoC4lLH5
         9oxz28/TKbjALVEtzJE0fCLDaAMMpHZPpV9zExvIho1xBhpidAlNpN8E0GW5SbQqFEGt
         2iDw==
X-Gm-Message-State: ANoB5pk0lDwxz7uCjaa94O5jUbi79XQtt30l3G9wI1Uw23U/UQ9LTj3x
        JJpez+8wdT9ydbxO708DC0t591uax8LmlGX5g+CCog==
X-Google-Smtp-Source: AA0mqf71c9Z2Oz47hdONC4Rp43orqWmur2bLHwuIBQFUL1X3mP3qGUw0rlvHQu+QiIynGYu5DNDw6ViXPOhYelbY4LQ=
X-Received: by 2002:a25:75d7:0:b0:6ea:c9e3:fcc3 with SMTP id
 q206-20020a2575d7000000b006eac9e3fcc3mr6559879ybc.553.1669020275636; Mon, 21
 Nov 2022 00:44:35 -0800 (PST)
MIME-Version: 1.0
References: <CA+G9fYuFxZTxkeS35VTZMXwQvohu73W3xbZ5NtjebsVvH6hCuA@mail.gmail.com>
 <Y3Y+DQsWa79bNuKj@elver.google.com> <4208866d-338f-4781-7ff9-023f016c5b07@intel.com>
 <Y3bCV6VckVUEF7Pq@elver.google.com> <41ac24c4-6c95-d946-2679-c1be2cb20536@intel.com>
 <CA+G9fYs3NLZgorPT33vu6XQ3HA6BpN_hL6GZWbfnirGYt1tNaQ@mail.gmail.com>
In-Reply-To: <CA+G9fYs3NLZgorPT33vu6XQ3HA6BpN_hL6GZWbfnirGYt1tNaQ@mail.gmail.com>
From:   Marco Elver <elver@google.com>
Date:   Mon, 21 Nov 2022 09:43:59 +0100
Message-ID: <CANpmjNOrZgBsgk1xxxz8-DrpnT0F0zyjin67=8_Ss7YZK-5_Mw@mail.gmail.com>
Subject: Re: WARNING: CPU: 0 PID: 0 at arch/x86/include/asm/kfence.h:46 kfence_protect
To:     Naresh Kamboju <naresh.kamboju@linaro.org>
Cc:     Dave Hansen <dave.hansen@intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        kasan-dev <kasan-dev@googlegroups.com>, X86 ML <x86@kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, regressions@lists.linux.dev,
        lkft-triage@lists.linaro.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Alexander Potapenko <glider@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 21 Nov 2022 at 08:28, Naresh Kamboju <naresh.kamboju@linaro.org> wrote:
>
> Hi Dave,
>
> On Fri, 18 Nov 2022 at 05:24, Dave Hansen <dave.hansen@intel.com> wrote:
> >
> > On 11/17/22 15:23, Marco Elver wrote:
> > > Yes - it's the 'level != PG_LEVEL_4K'.
> >
> > That plus the bisect made it pretty easy to find, thanks for the effort!
> >
> > Could you double-check that the attached patch fixes it?  It seemed to
> > for me.
>
> I have applied the attached patch on Linux next 20221118 and tested [1].
> The reported issue has been fixed now.
>
> Reported-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Tested-by: Linux Kernel Functional Testing <lkft@linaro.org>
> Tested-by: Naresh Kamboju <naresh.kamboju@linaro.org>
>
> OTOH,
> I request you to walk through the boot and test log [1] (new see few failures).
>  not ok 7 - test_double_free
>  not ok 9 - test_invalid_addr_free
>  not ok 11 - test_corruption
>  not ok 18 - test_kmalloc_aligned_oob_write
>  # kfence: pass:19 fail:4 skip:2 total:25
>  # Totals: pass:19 fail:4 skip:2 total:25
>  not ok 6 - kfence

Fixed by https://lkml.kernel.org/r/20221118152216.3914899-1-elver@google.com
