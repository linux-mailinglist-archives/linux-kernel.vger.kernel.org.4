Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 425276862EA
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 10:34:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232007AbjBAJeU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 04:34:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231946AbjBAJeS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 04:34:18 -0500
Received: from mail-yw1-x112e.google.com (mail-yw1-x112e.google.com [IPv6:2607:f8b0:4864:20::112e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6A4934018
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 01:34:17 -0800 (PST)
Received: by mail-yw1-x112e.google.com with SMTP id 00721157ae682-4ff1fa82bbbso238122647b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 01:34:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=zhWSgBLB/d7CBkiS7vUeRrl+u5WlVlYA2/RDeWKtD4s=;
        b=bVa6yGtrbg7X54zNXj3nrQQADqcWyif95t7Tpgktx+hZ+nQxcoC8M2mGx+4jdvE+p1
         cjVHphe0Kn8DXQryEt/Hp/bjA5K1wHoMwGl0dz9LfD6eUDlZWL+mKYIk0SXI6gEqWvfA
         g5opR0g/nF8uRKATRfp91PHqQYHEX/eUWpHAhK8LFt2ZY7Dfi7WfcJneOMHsRqVT+xtz
         sq9qCoYkZJN3Z9I6wG1qKahOuOvt9f8gkdQB9qNZkAGen8epRUTEEJtTc575m4Q+C1B1
         hMCi4cBpMEm88PNR8VZLGCQY3BCX/0dds6L8a7XWQgQGvmL52HudtxZD0Jslcje1dhZ/
         BYEw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=zhWSgBLB/d7CBkiS7vUeRrl+u5WlVlYA2/RDeWKtD4s=;
        b=KTKdLk3TmF5DZKyZA+aalqpET9pOfQWRkACEL+KEIo40AuqrDgaDdXn7RQxQn1IOp4
         DNNaDTfC7qSADiSuw1Qxmzi7PCUJg3sIGGilU843yJGM3MA8tFXqJWHTa8nk65ZCK+4i
         7YxLQF/voVjshbY3V++z9teGifbDEUAf2CC0cr+1Fl1TesBkT2Zu+PjBtxPqVd3V5tB/
         vwHYl/Zu8mLB3edAeHm81pxYB3AQ/ZoCCv/Ng4F4F3vAjyeagc5iVqmQ2GbYTPNHQqRz
         bJjBJt8+JaZgGOyL5sPsa7vJCRAV+mI6nhacZCC2E3y8xEUusbjcoJIa130l6/md1Hd9
         9GSQ==
X-Gm-Message-State: AO0yUKUgQ+kOQPCOlcAqxECsUpWHnb2c/Mf/uk+ovLi91wmjuFu3/myh
        zENVvOh6OYXutHMm6ADqcnoTbEge0ZDIu+ahDZoHUQ==
X-Google-Smtp-Source: AK7set85DUWKc2v6zBheFw+i+qRyYX8wNKafC0i6wlEmLLx9nxLNChCq4IX/VQmJmD1rBU/5J52AObA7BfAxiJlPCF4=
X-Received: by 2002:a81:fe02:0:b0:506:369c:69c1 with SMTP id
 j2-20020a81fe02000000b00506369c69c1mr221926ywn.192.1675244056986; Wed, 01 Feb
 2023 01:34:16 -0800 (PST)
MIME-Version: 1.0
References: <20230127162409.2505312-1-elver@google.com> <Y9QUi7oU3nbdIV1J@FVFF77S0Q05N>
 <CANpmjNNGCf_NqS96iB+YLU1M+JSFy2tRRbuLfarkUchfesk2=A@mail.gmail.com> <Y9ef8cKrE4RJsrO+@FVFF77S0Q05N>
In-Reply-To: <Y9ef8cKrE4RJsrO+@FVFF77S0Q05N>
From:   Marco Elver <elver@google.com>
Date:   Wed, 1 Feb 2023 10:33:40 +0100
Message-ID: <CANpmjNOEG2KPN+NaF37E-d8tbAExKvjVMAXUORC10iG=Bmk=vA@mail.gmail.com>
Subject: Re: [PATCH v2] perf: Allow restricted kernel breakpoints on user addresses
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@kernel.org>,
        Namhyung Kim <namhyung@kernel.org>,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Jann Horn <jannh@google.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrey Konovalov <andreyknvl@gmail.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 30 Jan 2023 at 11:46, Mark Rutland <mark.rutland@arm.com> wrote:
[...]
> > This again feels like a deficiency with access_ok(). Is there a better
> > primitive than access_ok(), or can we have something that gives us the
> > guarantee that whatever it says is "ok" is a userspace address?
>
> I don't think so, since this is contextual and temporal -- a helper can't give
> a single correct answert in all cases because it could change.

That's fair, but unfortunate. Just curious: would
copy_from_user_nofault() reliably fail if it tries to access one of
those mappings but where access_ok() said "ok"?

Though that would probably restrict us to only creating watchpoints
for addresses that are actually mapped in the task.

> In the cases we switch to another mapping, we could try to ensure that we
> enable/disable potentially unsafe watchpoints/breakpoints.

That seems it'd be too hard to reason that it's 100% safe, everywhere,
on every arch. I'm still convinced we can prohibit creation of such
watchpoints in the first place, but need something other than
access_ok().

> Taking a look at arm64, our idmap code might actually be ok, since we usually
> mask all the DAIF bits (and the 'D' or 'Debug' bit masks HW
> breakpoints/watchpoints). For EFI we largely switch to another thread (but not
> always), so that would need some auditing.
>
> So if this only needs to work in per-task mode rather than system-wide mode, I
> reckon we can have some save/restore logic around those special cases where we
> transiently install a mapping, which would protect us.

It should only work in per-task mode.

> For the threads that run with special mappings in the low half, I'm not sure
> what to do. If we've ruled out system-wide monitoring I believe those would be
> protected from unprivileged users.

Can the task actually access those special mappings, or is it only
accessible by the kernel?

Thanks,
-- Marco
