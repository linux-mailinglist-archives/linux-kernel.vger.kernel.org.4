Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA304648372
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Dec 2022 15:10:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230130AbiLIOKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Dec 2022 09:10:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230007AbiLIOKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Dec 2022 09:10:04 -0500
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 026CC79CA1
        for <linux-kernel@vger.kernel.org>; Fri,  9 Dec 2022 06:07:10 -0800 (PST)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-1447c7aa004so5727455fac.11
        for <linux-kernel@vger.kernel.org>; Fri, 09 Dec 2022 06:07:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=EC7aCx3NVZPRrIAdRd/P0UiHZeuimNDqrKtypaG8KIs=;
        b=VgMCqrSWhn+zUG0ZHoAQzM6Ocr5uTpzOurxKHgH2SVCKmWO2RCPqntsO6OsqWIuRqC
         bSa9VZ9Qb2lmALXqzuojvsvaplZfwILqCRwnEHeaJZTDKKqMJZr/ZNYbCRUc66sWssWT
         iJr2frb9W0Ksz6aVDTK4UmTsYtFOgnO9w0mCg7p23vOHpAIz0azzKcyoFvRwosPjtFyL
         R6X0irs1PC3HS3DoNahJH0rEnLz+61/H+PGWaHPY29tH74waoU22igeFiLlWH8TELDQP
         piuSuwuyJ7ftIxwuQ54Ca0N6TGZ4t1zJeAx4gqRBsNdu3Kw6Yc3ZwidX1RDPsMDCbTfj
         spNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=EC7aCx3NVZPRrIAdRd/P0UiHZeuimNDqrKtypaG8KIs=;
        b=6PvGqqUsGhkbV4F4Mm5PrhYouLNV1CmKZo8llwqfAFAfweiSCCKhyhgYvTdMHBV6yv
         Ok0G+BrbhmYOF4LbUuBlIa6KTtMYDFWkisTFMqNl92xYnW8fI/RVXdkJ3MrBVq1DrcAF
         KsQ7MUlmGq76hbOl6F3o93WlV3QUHm/sk26/jJccaVcUnEvyJQyLVxraHO+rsKPZwlL9
         aZG1jbW/lJfTfrEMovByYskTaIa2KM0IoGtBMz+65ewSC+nRmbcKJZkhwzAur4C0rRqq
         xZeqvRtNJlAytAD0u45OB4Yg6fB/1oJJ9JVSPzQUTqqicClr8nUcLPwd35ja8fQzVYUo
         z5mA==
X-Gm-Message-State: ANoB5pmYgGPcN2zcX/tAJ8Q9B9XNaoToBKCfJsh+O/T+7gCjL0KBFvlt
        W3OXtN7sL1bGXzG6wUROPfCFQQ==
X-Google-Smtp-Source: AA0mqf6r+0JFrZ8XA1iJTcU/t4YRiTG+aRPr+8wCCnDVUggR1p5Evn3Kyr9O0njDcH4rzdjaOs8vhA==
X-Received: by 2002:a05:6359:204:b0:e0:5d8a:8170 with SMTP id ej4-20020a056359020400b000e05d8a8170mr83874rwb.20.1670594816259;
        Fri, 09 Dec 2022 06:06:56 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-47-55-122-23.dhcp-dynamic.fibreop.ns.bellaliant.net. [47.55.122.23])
        by smtp.gmail.com with ESMTPSA id dm15-20020a05620a1d4f00b006feb0007217sm1158484qkb.65.2022.12.09.06.06.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 09 Dec 2022 06:06:55 -0800 (PST)
Received: from jgg by wakko with local (Exim 4.95)
        (envelope-from <jgg@ziepe.ca>)
        id 1p3e1e-0070V7-LG;
        Fri, 09 Dec 2022 10:06:54 -0400
Date:   Fri, 9 Dec 2022 10:06:54 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Hillf Danton <hdanton@sina.com>
Cc:     Leon Romanovsky <leon@kernel.org>,
        syzbot <syzbot+3fd8326d9a0812d19218@syzkaller.appspotmail.com>,
        linux-kernel@vger.kernel.org, linux-rdma@vger.kernel.org,
        markzhang@nvidia.com, ohartoov@nvidia.com,
        syzkaller-bugs@googlegroups.com
Subject: Re: [syzbot] WARNING: refcount bug in nldev_newlink
Message-ID: <Y5NA/oZ7RpeUXzJN@ziepe.ca>
References: <0000000000004fe6c005ef43161d@google.com>
 <Y5Gq/zVi/fR85OJK@unreal>
 <20221209134229.1987-1-hdanton@sina.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221209134229.1987-1-hdanton@sina.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 09, 2022 at 09:42:29PM +0800, Hillf Danton wrote:
> On 9 Dec 2022 09:01:14 -0400 Jason Gunthorpe <jgg@ziepe.ca>
> > On Thu, Dec 08, 2022 at 11:14:39AM +0200, Leon Romanovsky wrote:
> > 
> > > Jason, what do you think?
> > 
> > No, the key to this report is that the refcount dec is inside the tracker:
> > 
> > > >  __refcount_dec include/linux/refcount.h:344 [inline]
> > > >  refcount_dec include/linux/refcount.h:359 [inline]
> > > >  ref_tracker_free+0x539/0x6b0 lib/ref_tracker.c:118
> > > >  netdev_tracker_free include/linux/netdevice.h:4039 [inline]
> > 
> > Which is not underflowing the refcount on the dev, it is actually
> > trying to say the tracker has become unbalanced.
> > 
> > Eg this put is not matched with a hold that specified the tracker.
> > 
> > Probably this:
> > 
> > diff --git a/drivers/infiniband/core/device.c b/drivers/infiniband/core/device.c
> > index ff35cebb25e265..115b77c5e9a146 100644
> > --- a/drivers/infiniband/core/device.c
> > +++ b/drivers/infiniband/core/device.c
> > @@ -2192,6 +2192,7 @@ static void free_netdevs(struct ib_device *ib_dev)
> >                 if (ndev) {
> >                         spin_lock(&ndev_hash_lock);
> >                         hash_del_rcu(&pdata->ndev_hash_link);
> > +                       netdev_tracker_free(ndev, &pdata->netdev_tracker);
> >                         spin_unlock(&ndev_hash_lock);
> >  
> >                         /*
> > @@ -2201,7 +2202,7 @@ static void free_netdevs(struct ib_device *ib_dev)
> >                          * comparisons after the put
> >                          */
> >                         rcu_assign_pointer(pdata->netdev, NULL);
> > -                       dev_put(ndev);
> > +                       __dev_put(ndev);
> >                 }
> >                 spin_unlock_irqrestore(&pdata->netdev_lock, flags);
> >         }
> 
> Wonder why this makes sense given rcu_assign_pointer(pdata->netdev, NULL)
> under pdata->netdev_lock.

Oh, yah, that is right, so we can just do the natural thing:

                        rcu_assign_pointer(pdata->netdev, NULL);
-                       dev_put(ndev);
+                       netdev_put(ndev, &pdata->netdev_tracker);


Jason
