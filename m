Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1ECF3643FC3
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 10:23:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235056AbiLFJXX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 04:23:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39732 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234987AbiLFJWv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 04:22:51 -0500
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 781DA220D3
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 01:20:30 -0800 (PST)
Received: by mail-wr1-x433.google.com with SMTP id w15so22544178wrl.9
        for <linux-kernel@vger.kernel.org>; Tue, 06 Dec 2022 01:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=jinBcPSkEbBkoDxJN/eRyhQV/jBZKLuC/Y4mXEJDUBw=;
        b=dxWlUGmeupuPuJkU7adI5ygpuordIPTUDXDz2xfn0beqgCIkzmpPYT8uVff6LliFa9
         rTphtRnpNutX79xC3H+iE8Z80DmQvF58B95YvBuNFIVOd9KBQXHmXUhAcKoJMNMZMUwJ
         IDFRUQ2rVk7rKma1ZcbkPrJ8fbMQdDn4RCjkS7wgf3dqLglOUYVKm3o7O7NcthjB/BuU
         8UZPVjD1Rz9HAQSiV8z8aG+IMOmtU7Qkom/5Ng+5RPyMxIp4RSnKnirtXDKWKY9WGulN
         fIYHpA2HB6UDHnsROebpYGGfEobK27qQDZPDDNrhI4mRnPLDjsTKpxm3YHMq27n+1l2f
         tShQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=jinBcPSkEbBkoDxJN/eRyhQV/jBZKLuC/Y4mXEJDUBw=;
        b=4pFQrTN26hRKrOLpklOEZpZAiYEssQoTCykuTTDPXTHipuRH8yVkCOIEDAVHFcjarG
         eEGAcsP+g3cnaYgXWI7r+3BMRmNu6xGL2UEohw7rMOKOTyJSvkB5TnjJuLT1LfARZL8o
         W/Yp4Nz3I1M+nBZ2eu7VkCt2tGTvdkJQPK0Vf/pxbnXtdvdckfO0HbH5ZvpCOaj65aBf
         2m6eDOncoUxOxvHJ24QbCdOexptskBmqaMtIWoZNa3bDrZY9mVtubZILdvfK3xBOA78N
         CIQFQ00zxVcnI1sm+nJnk8Lhhm9GzVLqVGNwtLFtBEKruAewJGRQxqoC7MP0ib308mpD
         YjZw==
X-Gm-Message-State: ANoB5pmUwk1pHnaay2Xiir2PlyodMFHqCIIobd6xokNRlTgTDb6wWWBI
        F/2GqKhIhz4Ima3vtG6otBGf7tvcOQr9busydxd/uTUO90E=
X-Google-Smtp-Source: AA0mqf6Z5dP+iQBbx1ft2L32IbIAwP11d9FkmHPe2lCw58ExxCHa5zIQPDifd8Z+f2JMFuWuQNGX0/uDUAG1HaEw77U=
X-Received: by 2002:a5d:58e6:0:b0:242:5562:6d6 with SMTP id
 f6-20020a5d58e6000000b00242556206d6mr7111642wrd.541.1670318428890; Tue, 06
 Dec 2022 01:20:28 -0800 (PST)
MIME-Version: 1.0
References: <CAJNi4rOgYmmtOaXVqYB9sAxDmRhGhS_vVXmZbCbMjvFCQsdjCw@mail.gmail.com>
 <CAJhGHyD+oR8SeYeObJ2DSKfudqBtBOiL14jCsST3L5OG8WjT_g@mail.gmail.com>
 <CAJNi4rOs-=xx5qV-hQQYgSLQCz_q3JuFxJEd+wpPaao8Ej26yQ@mail.gmail.com> <CAJhGHyAVbCm6i7pTRDDXgdwS25d5O3uMCvKzyOcafRAdN-S7JQ@mail.gmail.com>
In-Reply-To: <CAJhGHyAVbCm6i7pTRDDXgdwS25d5O3uMCvKzyOcafRAdN-S7JQ@mail.gmail.com>
From:   richard clark <richard.xnu.clark@gmail.com>
Date:   Tue, 6 Dec 2022 17:20:17 +0800
Message-ID: <CAJNi4rNU0-GVnLMqdGFvHOsTb26eDEgjZJSE6Doo8QU6MYx+JQ@mail.gmail.com>
Subject: Re: work item still be scheduled to execute after destroy_workqueue?
To:     Lai Jiangshan <jiangshanlai@gmail.com>
Cc:     tj@kernel.org, linux-kernel@vger.kernel.org
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

On Tue, Dec 6, 2022 at 2:23 PM Lai Jiangshan <jiangshanlai@gmail.com> wrote:
>
> On Tue, Dec 6, 2022 at 12:35 PM richard clark
> <richard.xnu.clark@gmail.com> wrote:
>
> > >
> > A WARN is definitely reasonable and has its benefits. Can I try to
> > submit the patch and you're nice to review as maintainer?
> >
> > Thanks,
> > Richard
> > >
>
> Sure, go ahead.
>
> What's in my mind is that the following code is wrapped in a new function:
>
>         mutex_lock(&wq->mutex);
>         if (!wq->nr_drainers++)
>                 wq->flags |= __WQ_DRAINING;
>         mutex_unlock(&wq->mutex);
>
>
> and the new function replaces the open code drain_workqueue() and
> is also called in destroy_workqueue() (before calling drain_workqueue()).
>
Except that, do we need to defer the __WQ_DRAINING clean to the
rcu_call, thus we still have a close-loop of the drainer's count, like
this?

--- a/kernel/workqueue.c
+++ b/kernel/workqueue.c

@@ -3528,6 +3526,9 @@ static void rcu_free_wq(struct rcu_head *rcu)

        else
                free_workqueue_attrs(wq->unbound_attrs);

+       if (!--wq->nr_drainers)
+               wq->flags &= ~__WQ_DRAINING;
+
        kfree(wq);

>
> __WQ_DRAINING will cause the needed WARN on illegally queuing items on
> destroyed workqueue.

I will re-test it if there are no concerns about the above fix...

>
> Thanks
> Lai
