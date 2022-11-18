Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E72362FE7E
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Nov 2022 21:01:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230322AbiKRUBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Nov 2022 15:01:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbiKRUBo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Nov 2022 15:01:44 -0500
Received: from mail-lj1-x22f.google.com (mail-lj1-x22f.google.com [IPv6:2a00:1450:4864:20::22f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7126FC78DD
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:01:43 -0800 (PST)
Received: by mail-lj1-x22f.google.com with SMTP id s24so8064983ljs.11
        for <linux-kernel@vger.kernel.org>; Fri, 18 Nov 2022 12:01:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GPrbHb3+211d62G+QcXXF3a3BGF9p+XV97IR2W1Bg5Q=;
        b=V4M+7rpBcdBq7/hYVteWBRv/ty9ZWDcURM5JZ9qyrcMFVooRl1eo4zZCg3WQDC72I0
         1lsFdGZNc3Y7OGESG5dDeJD7p0K1sPRqj8+Bt62UeYA89s+Xguogj760lOIAL1vBZLyR
         zXtRfSpUhQ94V3BbdirO4NVCCuRMFQaXJHg1VqiC9a39yRUx48WWTM/nYK8xftob/o2m
         /qgDs5gTNtBRjDCv2RJurR/vEbNq3sX5ZATa45xB4pAN0HbwomgDN7r+em7i5Zm6irkV
         ArTYp8Xh4or840xzajEZ+qRVLHmID0ApCA3bj5+3+uiQXmE4I6gjX8r6VY4mDVBqR/Ut
         /0ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GPrbHb3+211d62G+QcXXF3a3BGF9p+XV97IR2W1Bg5Q=;
        b=Bgsyct19fbf9gjhXvUEEweEZe1U6QxI+vvL1E36H8XfjvxCBqLbosiIdACV4vHJqG2
         sc8xgULXOc2d4vGOZ1rm2dp8w7Sq0MHc3hlQpi+i4iud/zcTfNSCa68jup/IKSi/UV2B
         8OfO5JIKf3FIi4AUuwkDTv/9+K015WVIfVhwYYLl7SsvqBQUXoaxiqUDmSCRSCFpbEE1
         5q+tOHPd1JgEG6nVbsfMuKHvsdpaI04M/i3e9DWnj72A5x+nuGto/Z357ZTyrX+syEnA
         b1wvXo+Nr2PU+q/mxNls9uTZDNe8i9y4gZH/VkqQfwvVzNCZB94iM/rEOutkvXAkpg7c
         N0AQ==
X-Gm-Message-State: ANoB5pnYZ95b/xegFREBhH4C/obZsrLN/qeBscfSCORTcrPtY+KHov4Q
        SPtpQ1HKWTpDI/MGYgBjzrqpv0oRmd70rkUGzpOQ8srS/MU=
X-Google-Smtp-Source: AA0mqf4N4e4+I0GBD7ELbJOO09jQy5jyauSkZM51QJ+DIQiVxH0EIv+HARvqMg7QDte7vJud6GBym76htP6LjhUUqRo=
X-Received: by 2002:a2e:87ce:0:b0:277:ddf:f476 with SMTP id
 v14-20020a2e87ce000000b002770ddff476mr3035239ljj.432.1668801701538; Fri, 18
 Nov 2022 12:01:41 -0800 (PST)
MIME-Version: 1.0
References: <0000000000009d5daa05ed9815fa@google.com> <20221117024511.3606-1-hdanton@sina.com>
 <20221117125523.3783-1-hdanton@sina.com> <87wn7tlg4n.ffs@tglx>
 <CABBYNZKnCyLkRKH=DFZbDSL=m0O5PUVkQjtiB0xpCZM7v78HmQ@mail.gmail.com>
 <CABBYNZJYbzX9xoqU8_KEArTJ2=5eMTiDTjMbNjEYNVmi1rkp+A@mail.gmail.com> <20221118012805.3862-1-hdanton@sina.com>
In-Reply-To: <20221118012805.3862-1-hdanton@sina.com>
From:   Luiz Augusto von Dentz <luiz.dentz@gmail.com>
Date:   Fri, 18 Nov 2022 12:01:29 -0800
Message-ID: <CABBYNZLEjEtwbr+5W4nt=7HhNLBG9_J9xj_rJC=cbA-1pBgRHQ@mail.gmail.com>
Subject: Re: [syzbot] WARNING in call_timer_fn
To:     Hillf Danton <hdanton@sina.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        syzbot <syzbot+6fb78d577e89e69602f9@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        syzkaller-bugs@googlegroups.com,
        Steven Rostedt <rosted@goodmis.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>
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

Hi Hillf,

On Thu, Nov 17, 2022 at 5:28 PM Hillf Danton <hdanton@sina.com> wrote:
>
> On Thu, Nov 17, 2022 at 1:04 PM Luiz Augusto von Dentz <luiz.dentz@gmail.com> wrote:
> > >
> > > I thought we would have something similar to shutdown_timer (e.g.
> > > shutdown_delayed_work) so we can safely free its object/struct, at
> > > least that was the impression I got when discussing with Steven.
>
> Because of the cough in Bluetooth's throat does not mean it makes sense
> to ask workqueue to take a flu jab. Why not cure it directly locally,
> given the cases of workqueue under the drivers dir. And timer?

Like Thomas said we can only resolve this partially with the likes of
cancel_workqueue(_sync), though we can use HCI_UNREGISTER to stop
rescheduling cmd_timer, so imo having something similar to
shutdown_timer makes things simpler for subsystems/drivers, anyway I'm
fine fixing it directly since it is probably going to be simpler to
backport, perhaps something like the following is all we need:

diff --git a/net/bluetooth/hci_core.c b/net/bluetooth/hci_core.c
index 0540555b3704..977684f5fb57 100644
--- a/net/bluetooth/hci_core.c
+++ b/net/bluetooth/hci_core.c
@@ -4090,6 +4090,7 @@ static void hci_cmd_work(struct work_struct *work)

                        rcu_read_lock();
                        if (test_bit(HCI_RESET, &hdev->flags) ||
+                           test_bit(HCI_UNREGISTER, &hdev->flags) ||
                            hci_dev_test_flag(hdev, HCI_CMD_DRAIN_WORKQUEUE))
                                cancel_delayed_work(&hdev->cmd_timer);
                        else

-- 
Luiz Augusto von Dentz
