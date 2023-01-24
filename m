Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3160B679E2D
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 17:06:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233958AbjAXQGS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 11:06:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233921AbjAXQGM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 11:06:12 -0500
Received: from mail-pj1-x102e.google.com (mail-pj1-x102e.google.com [IPv6:2607:f8b0:4864:20::102e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8E847099
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:06:11 -0800 (PST)
Received: by mail-pj1-x102e.google.com with SMTP id z9-20020a17090a468900b00226b6e7aeeaso14460563pjf.1
        for <linux-kernel@vger.kernel.org>; Tue, 24 Jan 2023 08:06:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=kernel-dk.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EaJ5uloDE1xwsTbIvPSRRAo35iopKRTOnBfbrFq44rc=;
        b=cEWlA1UMEddC8rKg438WN/rErVePXAxlbwibf7PX0V2XLZEwMc4y8O7OuNLGMBDysc
         vXaRwJLVjJFfI63ZbY63qZvloElxUukV7moyKGBQHuUTS1ao46soebum76DHGLs8Hz5t
         jnVqR43c6ViQi1S8tLNSeqJgoy4QA9M1IO1tH3re3ZenRpY+lNAs0RgyOoGFftEvot5M
         FDba86PecJqnt7KDKQW+EybaYFaQKnH3/5KEuPV6UDMlsapmHOMcMGpwLK7aMZ6SpqTR
         0ISz0W/8R7wUHaQE2rk6Bqlj2MHsPDzFAzg0rqiYFvfUAvjQTx74dF1V//AMirrJneVY
         jv1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EaJ5uloDE1xwsTbIvPSRRAo35iopKRTOnBfbrFq44rc=;
        b=CvVz3ipbzYZ97RuxYLXbdX2IdVs9sbMUG7Y/VVOOzzMMVwjBn4mlZp2rGcx7cDZnf+
         hjQ8Yb97PAo3NInwydBjCUsKiMryo3+gvrr48R/ly0++h3cHL1DwZyPWgzWKGh/osXXb
         6E0ZanP8MYtSlBdQ6AF7JKCmUKhjvEGhVYlRcwb7ERUMXmujo9RDGpH5l8wPsVeKZuPg
         +S4HnoV1aEE0O54zpYVeQ7VER3ZElOCoU/EFI/MBV2HkZXn8tIg2vsoKUmSkPGV+s380
         gopHqqLkAy2XEhRG/3Ajr6lMegVYNT6zq2iS7VQyNJJurP/PwkYg7ZeA0mYPt/R5AzD5
         RrSA==
X-Gm-Message-State: AFqh2kq89TXlXD0tXgKxP9VYaaDhBBlvvC6hR+bE/82/837DwNpZtSZy
        mBP+2uq5ybYkhHG71kgyM6aHPq5/EoEziANJ
X-Google-Smtp-Source: AMrXdXuaN3p4hq4pVS0mte8ZskOqqUdc4/2P0YDhIxGwTBu1l9nJfON2y/F7hcgqI/ktqoQfSnCKgg==
X-Received: by 2002:a17:902:b183:b0:18b:cea3:645 with SMTP id s3-20020a170902b18300b0018bcea30645mr7062002plr.0.1674576370400;
        Tue, 24 Jan 2023 08:06:10 -0800 (PST)
Received: from [192.168.1.136] ([198.8.77.157])
        by smtp.gmail.com with ESMTPSA id h2-20020a170902f7c200b00196048cc113sm1836298plw.126.2023.01.24.08.06.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 24 Jan 2023 08:06:09 -0800 (PST)
Message-ID: <b03383e3-cb10-8b70-a042-dbc2170ee3ec@kernel.dk>
Date:   Tue, 24 Jan 2023 09:06:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux aarch64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH] x86/fpu: don't set TIF_NEED_FPU_LOAD for PF_IO_WORKER
 threads
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        the arch/x86 maintainers <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
References: <560c844c-f128-555b-40c6-31baff27537f@kernel.dk>
 <Y8/8CFwtpmjzdK9c@hirez.programming.kicks-ass.net>
From:   Jens Axboe <axboe@kernel.dk>
In-Reply-To: <Y8/8CFwtpmjzdK9c@hirez.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_SBL_CSS,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/24/23 8:40 AM, Peter Zijlstra wrote:
> On Tue, Jan 24, 2023 at 08:23:20AM -0700, Jens Axboe wrote:
>> We don't set it on PF_KTHREAD threads as they never return to userspace,
>> and PF_IO_WORKER threads are identical in that regard. As they keep
>> running in the kernel until they die, skip setting the FPU flag on them.
> 
> No objection to the actual patch; but this changelog fails to tell us
> why this is important.
> 
> What made you get up and write this patch :-) Presumably this is a
> performance issue? If so, can you quantify how much?

You snipped the part where that was explained, but arguably that should
probably go into the commit message itself:

"Not urgent, more of a cosmetic thing that was found while debugging and
issue and pondering why the FPU flag is set on these threads."

So it's not really a performance issue, it was just something odd that
got me scratching my head when debugging another issue and poking at
the flags.

Want a resend of it, or will you just augment the commit message?

-- 
Jens Axboe


