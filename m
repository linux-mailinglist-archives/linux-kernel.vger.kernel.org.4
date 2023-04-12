Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B906DF1CA
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 12:16:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231176AbjDLKQw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 06:16:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229521AbjDLKQu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 06:16:50 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD41130CB
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 03:16:49 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-54f6a796bd0so95065377b3.12
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 03:16:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681294609; x=1683886609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=19dXlvHgMePLLzjJNE3ILaQBnedS0pYMNzyfIhoRXxM=;
        b=EAQfrASv8KPDAv4+pdLnYB1XvWdCG7BadG3EAWkTPPvVu2WBJVwxQm5f3l+6H0/jXN
         XS6n5ikdV770ofbD9X+Xa1hogZytqUvOK3WbjoaYpClNJiQKJKMWrqyOkYVBtZhOIg3T
         n3gKngm1vDtu+KKmTbiVAbCMsq3z6NpoxFSw0DRAMvOR7xQYXFje0S3YfXI97Cvvl5UN
         HWAxKX4no7XAg6CDu3zpAEtAY7OfQvAdVv7828OSrDKFTsZjke2iu6ZsRi2qRhNsmibD
         C8DOad/FaPWFbFZ213gQ/GT0797QI2vO5fXEUknzvesvgL6VHK50g99XoO2ovG/K/z0I
         pCKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681294609; x=1683886609;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=19dXlvHgMePLLzjJNE3ILaQBnedS0pYMNzyfIhoRXxM=;
        b=ru9+qEG/J9qShdUwD3rk9tlHMejC6exeZNPEy+BtfRbZkeIKUpShjK2n1xF6E6uAL1
         TnZK5DFUHohgnSCzePBSrpzPUBPo4PW3ZWDcSTwyUxA0pNiglMOJMcMTNsu1YIbmYl9b
         BlYahESyTnWTEhDUmEr7icFuO0Fap0bTgc8xOlfi7PeCnoOnwGIWAtelO/Xy3rSxCcVE
         UewNxbutNNRNOMIM0RE4IqJ0Uc0Pjep4dqOdp5PGWggwMrhNjf/5ISOx24AP6LWELe1o
         beHbPZmFLKCezXZzbAVMDq5m3/g5NegGkHb4jDeBIpTI94B/oTD5VO9T7veiSSAsmPyn
         xvnA==
X-Gm-Message-State: AAQBX9eZvw3UUHK23TesoOCPDKHe/yHYg/38Gwb+YEGTFP+QDMkuwI4Q
        n54Mz3yRFGaNYzC9BsiVxlk8I7WGfCn0GPMWXapzbFy8yw==
X-Google-Smtp-Source: AKy350Zbl3xTmIJhw9eX8Q6upCZv7QKX45sX7JtpGJJaFIZE+ybDiJmirCSO3VVFaUGoUxmOUUDVuGGBn6ZRB8avHh4=
X-Received: by 2002:a81:bc48:0:b0:54f:a609:e88 with SMTP id
 b8-20020a81bc48000000b0054fa6090e88mr454918ywl.7.1681294608809; Wed, 12 Apr
 2023 03:16:48 -0700 (PDT)
MIME-Version: 1.0
References: <CALjTZvZ=Y1psyd0nmfzm6GhqMKvq5V_NQCWb_X02nasp1CpfcQ@mail.gmail.com>
 <87r0spcuvi.fsf@intel.com>
In-Reply-To: <87r0spcuvi.fsf@intel.com>
From:   Rui Salvaterra <rsalvaterra@gmail.com>
Date:   Wed, 12 Apr 2023 11:16:37 +0100
Message-ID: <CALjTZvao=N7wxyj_DpqzWUhdJwEsWSKUo3ddi-3ubgMp8BXi_Q@mail.gmail.com>
Subject: Re: [BUG?] INFO: rcu_sched detected expedited stalls on CPUs/tasks: {
 0-.... } 3 jiffies s: 309 root: 0x1/.
To:     Jani Nikula <jani.nikula@linux.intel.com>
Cc:     rodrigo.vivi@intel.com, tvrtko.ursulin@linux.intel.com,
        paulmck@kernel.org, intel-gfx@lists.freedesktop.org,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jani,

On Wed, 12 Apr 2023 at 10:28, Jani Nikula <jani.nikula@linux.intel.com> wrote:
>
> Please file a bug at fdo gitlab [1]. Add drm.debug=0xe and maybe
> log_buf_len=4M or similar kernel parameters, and attach dmesg all the
> way from boot to reproducing the problem.

Sure, will do, thanks!

> How long is "for some time now"?

That's a wonderful question. I actually found a screenshot I took on
the 14th October(!) with one of these traces. I don't know the exact
kernel version, but since I've been running weekly release candidates
for years, it shouldn't be hard to pinpoint, if strictly needed. Since
the trace seemed informative and I haven't noticed any problems, I was
kind of hoping it would solve itself in time. I guess my patience
lasted 6 months. :)

Kind regards,
Rui
