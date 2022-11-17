Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 391C662E65B
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 22:06:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240776AbiKQVGX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 16:06:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240490AbiKQVFa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 16:05:30 -0500
Received: from mail-lj1-x229.google.com (mail-lj1-x229.google.com [IPv6:2a00:1450:4864:20::229])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59F4F91C0E
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:04:30 -0800 (PST)
Received: by mail-lj1-x229.google.com with SMTP id x21so4306280ljg.10
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 13:04:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=P8TTugNZHLWC9Qncfa1343u+Jv0frYz+A5xvg4AkUbg=;
        b=KlsyntQaCuqyPTkx2otFzLmxKaSUmMcVeEQAkafWmqIL3H5j7A8ey6ywEP9aEGE/er
         yeR6adPlyUNlYS6mNFOLZqNHa9iXxQIpTPvrPDlW26nKw4uc8FDbgH8sJM0QlLRTWBMS
         etBo21wSz8D3WSEZ1jl8NltBnX6HPPMeRFdpja5Ma2l6vhoBIxPsaJ4O8deBFGWj0D5y
         BQQbZngEQoI8jUTjlAGERKG1fCAGfWSUs5LKJ+MIP9Q+Wjxy9TmycckJG204vfowLcc1
         7YR8AJmnDQcnw6IsNCbToxS1PWVIsNog6yd9M+H03oXyDv41WYJT3C/Fs/RpITmsirFy
         FkrA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=P8TTugNZHLWC9Qncfa1343u+Jv0frYz+A5xvg4AkUbg=;
        b=8DrSnxs49oZ4e8SsREvXNtI7LTSunHWGUkUq48O0jE3US/AbqXvmklPnPN9Vr5QX/m
         1Z9LMzxS2Bk9e6hiSJI+2WuUd7avaAmTH3O0fxe60sjHtIC8jiwLeW3ZHKYHa8evN0Qu
         Mb85iR4N3al+Op4b8n13S6cYyNZb6I6/9+jvh84CXnqULn4nweM0eVcnrpE6EjkooGlw
         X5C3pXuVdpPv1Ud5DAorEQVVjQ1oDDhNMChjD3l+NE1BzCwdn2uJVBy92ioJDejH8Rsc
         SbzISrmmqS8JryFEgRSolXx6j4lFF9cPITNgoZmOnasYiTEaXa3BAd/hedlWTCF/3sC6
         RNpA==
X-Gm-Message-State: ANoB5pmHkuW50tQiWy7+KBjIw/DvJNe1hnGQHvZ9sXvwEk+PIYS27Vv+
        PanWdldZiXV7T2MyBRliGsX4Azc+5x8TXIQMYq0=
X-Google-Smtp-Source: AA0mqf53emzQZs1niDHdj9/iGQgRbS+a8Rx2QvYROHEr3nMwZbBkidr8JI4mLA+ZK/FSSAnJIIgcTFdVn90mLfQPDoM=
X-Received: by 2002:a05:651c:389:b0:278:f5de:8478 with SMTP id
 e9-20020a05651c038900b00278f5de8478mr1503035ljp.65.1668719064359; Thu, 17 Nov
 2022 13:04:24 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009d5daa05ed9815fa@google.com> <20221117024511.3606-1-hdanton@sina.com>
 <20221117125523.3783-1-hdanton@sina.com> <87wn7tlg4n.ffs@tglx>
In-Reply-To: <87wn7tlg4n.ffs@tglx>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Thu, 17 Nov 2022 13:04:12 -0800
Message-ID: <CABBYNZKnCyLkRKH=DFZbDSL=m0O5PUVkQjtiB0xpCZM7v78HmQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING in call_timer_fn
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Hillf Danton <hdanton@sina.com>,
        syzbot <syzbot+6fb78d577e89e69602f9@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        syzkaller-bugs@googlegroups.com,
        Steven Rostedt <rosted@goodmis.org>,
        Marcel Holtmann <marcel@holtmann.org>
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

Hi Thomas,

On Thu, Nov 17, 2022 at 8:06 AM Thomas Gleixner <tglx@linutronix.de> wrote:
>
> On Thu, Nov 17 2022 at 20:55, Hillf Danton wrote:
> > On 17 Nov 2022 12:54:28 +0100 Thomas Gleixner <tglx@linutronix.de>
> >>
> >> The work has been canceled already before in the same function and there
> >> are some more delayed works which can trigger this.
> >>
> >> So no, this whole close_sync() function is prone to teardown races and
> >> just slapping a single cancel here without deeper analysis does not cut
> >> it.
> >
> > Agree.
> >
> > A set of sync cancelations can do the job, given what is defined in struct
> > hci_dev wrt workqueue.
>
> It's only part of the solution because you also have to prevent that
> work is queued from other parts of the code....

I thought we would have something similar to shutdown_timer (e.g.
shutdown_delayed_work) so we can safely free its object/struct, at
least that was the impression I got when discussing with Steven.

-- 
Luiz Augusto von Dentz
