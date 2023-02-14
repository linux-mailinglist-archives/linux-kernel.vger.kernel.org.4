Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D76696E4C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Feb 2023 21:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231756AbjBNULg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Feb 2023 15:11:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60114 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbjBNULe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Feb 2023 15:11:34 -0500
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0709ED2
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 12:11:27 -0800 (PST)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-52f1b1d08c2so97581237b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 14 Feb 2023 12:11:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=CugAHDwfDvxDIt0AM3bPQhn+jgScaC+ZsDp2eafN2MA=;
        b=kaHuwZuozd/uwQY2LXXKeDd0XTRPgmEyBrqC6AOHxcrVbvANFUB/cJQzNyDmSTo8Xu
         nsN/8nRPqAnzT0nX44w7gjADJWOZMWrpn9oJUc/Ys/5o564mfLTmL0dTwgvb+yGJR1zg
         90z1lGhU7i3ZeMC0cfMDi3aqlqihWQu9uYfsCGmwK3X89VkyWTcS9h1KmqHhJ9wFYh3M
         qkEgSy4N5Hn4CeBoqSwQl8VDaSEMH9hRSlRqnus2rOjweYQ/sEtHE4LB6izkPb6vsj32
         WwKionXiZIK8na1Os9Cnpo4i/bOdNH8Mc2rG2KZRA2bNlkSp1NE1aDdUNeUjzYr26zv/
         oNwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=CugAHDwfDvxDIt0AM3bPQhn+jgScaC+ZsDp2eafN2MA=;
        b=GaIfMP7rjdTKunQVAtPTqsWeayNzVgvRbFgExz1mnHUybg2/hBMKHka1uX00x3l+/3
         C+aSI71ncvwmmtQ9WziWjQLM+kuqLNsgBNirVJ31ziK6jT4mt4pYMJzAk7MLJq4PUY/l
         FN8/94mRhofkG9mVDjAfuvjVWSGjuQWWo+h2K2g85ejgSNeysLeGJ5VHK6tm2DA85GtS
         Hq39QeKrGPu2a+WUp/reCqP8DovNQTzj5Zmj1gETEJn+dvuu1DHgC15IGiO5NjQ4A1kE
         dE9sZ+mp4YCKfhjg4ZRWlzNnKTnCMyvAAR87NX9UllMw6Mai1p2ko4HmRC2In4cwKisp
         09uw==
X-Gm-Message-State: AO0yUKUDOWWL82eP4VzUXt1lnTv01LoLTNhD9kHWEKmZ5uqQEC/IJzLq
        pOW4QC/+y1JQmGAdC8t5mvmR5lsB4vvepVhtqeDo
X-Google-Smtp-Source: AK7set8gF8yZFNU5iS80Sq7CPE9sU5oyTQ1gkrK6ATEg7+Dc/81PtMzV/A4BTy6H3TA8WDJV2PU6BO+0RPUKfcpo8/I=
X-Received: by 2002:a81:830c:0:b0:52e:d52e:97d0 with SMTP id
 t12-20020a81830c000000b0052ed52e97d0mr432243ywf.117.1676405486975; Tue, 14
 Feb 2023 12:11:26 -0800 (PST)
MIME-Version: 1.0
References: <20230213190754.1836051-1-kan.liang@linux.intel.com>
 <20230213190754.1836051-3-kan.liang@linux.intel.com> <CANDhNCqVcrZHGW4QJBD8_hZehmRpnNAsGFsmwsxBZNm3wpFZpQ@mail.gmail.com>
 <e306e2ea-dea5-0eab-9eae-f9ea5fe7d52e@linux.intel.com> <CANDhNCq1b-7C=cox6ufC3Kxycu87qPzDHtJH_5jwPmPjjig5ww@mail.gmail.com>
 <6898b1c8-9dbf-67ce-46e6-15d5307ced25@linux.intel.com> <0df181b9-fb34-78e8-1376-65d45f7f938f@linux.intel.com>
In-Reply-To: <0df181b9-fb34-78e8-1376-65d45f7f938f@linux.intel.com>
From:   John Stultz <jstultz@google.com>
Date:   Tue, 14 Feb 2023 12:11:16 -0800
Message-ID: <CANDhNCoZNmK12beqE5AAnQrpHEW01xKWwOWTQQEsWSuOaH0HRQ@mail.gmail.com>
Subject: Re: [RFC PATCH V2 2/9] perf: Extend ABI to support post-processing
 monotonic raw conversion
To:     "Liang, Kan" <kan.liang@linux.intel.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>, peterz@infradead.org,
        mingo@redhat.com, linux-kernel@vger.kernel.org, sboyd@kernel.org,
        eranian@google.com, namhyung@kernel.org, ak@linux.intel.com,
        adrian.hunter@intel.com
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

On Tue, Feb 14, 2023 at 9:00 AM Liang, Kan <kan.liang@linux.intel.com> wrote:
> On 2023-02-14 9:51 a.m., Liang, Kan wrote:
> > If I understand correctly, the idea is to let the user space tool run
> > the above interpoloation algorithm several times to 'guess' the atomic
> > mapping. Using the mapping information to covert the TSC from the PEBS
> > record. Is my understanding correct?
> >
> > If so, to be honest, I doubt we can get the accuracy we want.
> >
>
> I implemented a simple test to evaluate the error.

Very cool!

> I collected TSC -> CLOCK_MONOTONIC_RAW mapping using the above algorithm
> at the start and end of perf cmd.
>         MONO_RAW        TSC
> start   89553516545645  223619715214239
> end     89562251233830  223641517000376
>
> Here is what I get via mult/shift conversion from this patch.
>         MONO_RAW        TSC
> PEBS    89555942691466  223625770878571
>
> Then I use the time information from start and end to create a linear
> function and 'guess' the MONO_RAW of PEBS from the TSC. I get
> 89555942692721.
> There is a 1255 ns difference.
> I tried several different PEBS records. The error is ~1000ns.
> I think it should be an observable error.

Interesting. That's a good bit higher than I'd expect as I'd expect a
clock_gettime() call to take ~ double digit nanoseconds range on
average, so the error should be within that.

Can you share your logic?

thanks
-john
