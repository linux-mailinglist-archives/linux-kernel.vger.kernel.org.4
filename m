Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A3D268759E
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 06:52:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231576AbjBBFwW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 00:52:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230502AbjBBFv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 00:51:57 -0500
Received: from mail-oi1-x236.google.com (mail-oi1-x236.google.com [IPv6:2607:f8b0:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AFD950843
        for <linux-kernel@vger.kernel.org>; Wed,  1 Feb 2023 21:51:29 -0800 (PST)
Received: by mail-oi1-x236.google.com with SMTP id p185so606459oif.2
        for <linux-kernel@vger.kernel.org>; Wed, 01 Feb 2023 21:51:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=ILCvujNyyZTxSuALv1I1KaEgQ0h411mj7e3IcQ3tJpU=;
        b=ElSNIgd/vsGEwlaPeBFKsemhS770s+1BVTND0AsJp1G482uurP/TdvNPMTzBqrgEG0
         E3dr8zLUPqKRt1ERz2AFAeOn7cRuW+hi6LijISJrYuWSroLwxMz/Zl2dq08TvXnD70HQ
         cT0v79aj5UYDNOZE5NVJg4WrFKx7k2VGpFjXK/q5WRFu37myfPQc5oxVorf/vr6xgbd/
         h7mz3d/unvLmJOCbHWSeL3S6pOQS5OYAZHDB9xgkjhBwDkH5mfP8MN+V6EljxZJRydlm
         +gQ21pbKvBMj9pt/VmNLsdG31bksbwfpBbOvzluYDBFUSFjTLx54oyRNK4W8TO7G87d9
         OkOA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=ILCvujNyyZTxSuALv1I1KaEgQ0h411mj7e3IcQ3tJpU=;
        b=zNTNnH24EW7grqM5LU6Fywk+DXz2SqCzW12GmoyBMH3yU65hcoWhcsqy3YgHbS3TLw
         TXHmxvqNMkOxj6qyVHxCfQtltWiwsu7PXIIuTXB5H7N28YS2XCJraD8/I1MI3mKduG1E
         8bGNw4y+/JZrYPeHN6mVpi2Vyxrj52ybK6Rk1DdaKvU0juLSKn82iOXvUKIkEa/KFAtX
         eZ/eIRQvZkVnd80O3g2ZONio+QO7WTyO1CjkQXoLH3VpqFHJ6FoVBOGBQY7E9T2rqkC9
         fOO6nDtecWeMuAB/eJlM1iOEFN59ff5BT3wR1RJ54IXx6vKAG2Yl4TW0MTslJoc6D1u7
         KBMg==
X-Gm-Message-State: AO0yUKUwbeAyIJekcyS8Ba2d4HeRcYk/NjHfm/WKomzP0HFF89sgTcEg
        JpEGfZhoxRiwoqDqgDs6SnUJwBec9B61mP8hCWo2kATX
X-Google-Smtp-Source: AK7set+hOVxeK+28sYneHBt7Ti2HfC75WsaRczZ4bJAZe5qdsqd55Bud+PRHxdSuQle4Kom/O1SSgvyOESHNbZVHBQE=
X-Received: by 2002:a05:6808:913:b0:378:94fa:a719 with SMTP id
 w19-20020a056808091300b0037894faa719mr103560oih.146.1675317088491; Wed, 01
 Feb 2023 21:51:28 -0800 (PST)
MIME-Version: 1.0
References: <20221228034617.58386-1-zh.nvgt@gmail.com> <CAO2zrtZjDj5U4CCwVWQcWfbXJa0hwRjjNRE7jtHshrEb-nEwEg@mail.gmail.com>
 <CABb+yY3VtTYiyu0s470+Z0bQAPycec7gj+EF5kt=-zhufdutrQ@mail.gmail.com>
In-Reply-To: <CABb+yY3VtTYiyu0s470+Z0bQAPycec7gj+EF5kt=-zhufdutrQ@mail.gmail.com>
From:   Hang Zhang <zh.nvgt@gmail.com>
Date:   Thu, 2 Feb 2023 00:51:17 -0500
Message-ID: <CAO2zrtZew3=wB++==JFJ86DvZgttwF8xjaSVUUrY7HAX4469Ww@mail.gmail.com>
Subject: Re: [PATCH] mailbox: mailbox-test: fix potential use-after-free issues
To:     Jassi Brar <jassisinghbrar@gmail.com>
Cc:     linux-kernel@vger.kernel.org, sudeep.holla@arm.com,
        lee.jones@linaro.org
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

On Thu, Feb 2, 2023 at 12:17 AM Jassi Brar <jassisinghbrar@gmail.com> wrote:
>
> On Wed, Feb 1, 2023 at 10:25 PM Hang Zhang <zh.nvgt@gmail.com> wrote:
> >
> > On Tue, Dec 27, 2022 at 10:46 PM Hang Zhang <zh.nvgt@gmail.com> wrote:
> > >
> > > mbox_test_message_write() is the .write handler of the message
> > > debugfs interface, it operates on global pointers "tdev->signal"
> > > and "tdev->message" (e.g., allocation, dereference, free and
> > > nullification). However, these operations are not protected by any
> > > locks, making use-after-free possible in the concurrent setting.
> > > E.g., one invocation of the handler may have freed "tdev->signal"
> > > but being preempted before nullifying the pointer, then another
> > > invocation of the handler may dereference the now dangling pointer,
> > > causing use-after-free. Similarly, "tdev->message", as a shared
> > > pointer, may be manipulated by multiple invocations concurrently,
> > > resulting in unexpected issues such as use-after-free.
> > >
> > > Fix these potential issues by protecting the above operations with
> > > the spinlock "tdev->lock", which has already been deployed in other
> > > handlers of the debugfs interface (e.g., .read). This patch introduces
> > > the same lock to the .write handler.
> > >
> > > Signed-off-by: Hang Zhang <zh.nvgt@gmail.com>
> > > ---
> > >  drivers/mailbox/mailbox-test.c | 10 ++++++++--
> > >  1 file changed, 8 insertions(+), 2 deletions(-)
> > >
> > > diff --git a/drivers/mailbox/mailbox-test.c b/drivers/mailbox/mailbox-test.c
> > > index 4555d678fadd..b2315261644a 100644
> > > --- a/drivers/mailbox/mailbox-test.c
> > > +++ b/drivers/mailbox/mailbox-test.c
> > > @@ -97,6 +97,7 @@ static ssize_t mbox_test_message_write(struct file *filp,
> > >         struct mbox_test_device *tdev = filp->private_data;
> > >         void *data;
> > >         int ret;
> > > +       unsigned long flags;
> > >
> > >         if (!tdev->tx_channel) {
> > >                 dev_err(tdev->dev, "Channel cannot do Tx\n");
> > > @@ -110,9 +111,12 @@ static ssize_t mbox_test_message_write(struct file *filp,
> > >                 return -EINVAL;
> > >         }
> > >
> > > +       spin_lock_irqsave(&tdev->lock, flags);
> > >         tdev->message = kzalloc(MBOX_MAX_MSG_LEN, GFP_KERNEL);
> >
> This is bad.  atomic context should not do things like alloc.
> Also, please look up MAINTAINERS and cc authors.
>
> thanks.

Hi Jassi, thank you for your quick reply! We now cc'ed the major authors
of the file identified from the commit history. While this patch is bad as
you pointed out (sorry for that), do you think the concurrency issue here
is valid and worth a fix? If so, we can seek to improve the patch with the
help of the developers. Thank you very much!

Best,
Hang
