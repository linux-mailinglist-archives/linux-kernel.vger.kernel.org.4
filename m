Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0882E5B8F42
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 21:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229626AbiINT1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 15:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229449AbiINT1C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 15:27:02 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FCC4832F3
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 12:26:59 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j6-20020a17090a694600b00200bba67dadso15370522pjm.5
        for <linux-kernel@vger.kernel.org>; Wed, 14 Sep 2022 12:26:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=Q8h0EfFmy9ME9NWCOd5pepImjm1NXwHplGPDhrk7Zac=;
        b=YvvHBUvMo5+APTJ0vuQJIk3u2vaBMg0aE+Q7/3s7UXYMx6Kp8ndTE2bsFSBBh45xhF
         oPnIaCZ8KXXIxEOrdVU2k92FYWJbcV6jrDqGrUPXY31huH7qImUJqb9JJmS6e7idvpMr
         gvYCH7KuqN3r9y7eaOWWVgZ2OpfCLyYQ2XqzY8nuD82Ihwi9Jx7l2H8XYLDibXJmw2tH
         nY49trvWLChEbtDBxlo7S1DJ+eRKp3xydkGgWcfh8R3y1uobf0WMLyAxtc1Zw/y6htFQ
         OzY9ep3ltYgRuv2pCSqPcOlcUzK+nDGlv3qzcL5VuPLfK8L9jrDQbW1a73vxFHm9REgS
         pJAg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=Q8h0EfFmy9ME9NWCOd5pepImjm1NXwHplGPDhrk7Zac=;
        b=JWpJ7aj65MhoURZO63UDkWGjZUCLdv2128hFx8beduC9DnMlQGm+pFEY2/sxFA1DrX
         Obi4clF47y7SyqKDQeteq92ETJR1mMe9uG44LDKTbUGD3AS0wkug7KdsurE7QJSD0nas
         S9tOHY4ZwNWudF7OpXDc/9eM578dU6iey3pLYH5Iym5F5t9My98ZhIa0ggkGgftXz23u
         Pypl/QLxvkYmsgtuoYUYhris5Cg2kKqEModaF97qiKUX2zc4rYh7q9WC8OK0+s4S5XX7
         sP/ybFYsH0CYryQLsXo6bGQeqpTFS1gLuhVYJU//GaVEYCIpoM6CBLP/FcvulW1UvoGs
         GNxQ==
X-Gm-Message-State: ACrzQf2D83rJHKmphV7agzm/+ih3aO4LHuz1ZO4I3JoHeZ8PQFFleFcR
        dKnFb8Ve3bwX5LEkYRKVTum6YyXG7m8=
X-Google-Smtp-Source: AMsMyM5eEsEPcXICb+9qrRpuMHh6AEaHYdB5Vuf77d3bjAajvRX5YULa77s2KQMieb/3VrJ3PIIf3w==
X-Received: by 2002:a17:902:c949:b0:178:323f:6184 with SMTP id i9-20020a170902c94900b00178323f6184mr536785pla.130.1663183619119;
        Wed, 14 Sep 2022 12:26:59 -0700 (PDT)
Received: from autolfshost ([2409:4041:d9d:79ec:78cd:7d4c:66f8:5f42])
        by smtp.gmail.com with ESMTPSA id p9-20020a170902a40900b00176953f7997sm11055422plq.158.2022.09.14.12.26.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 14 Sep 2022 12:26:58 -0700 (PDT)
Date:   Thu, 15 Sep 2022 00:56:42 +0530
From:   Anup K Parikh <parikhanupk.foss@gmail.com>
To:     Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        skhan@linuxfoundation.org, airlied@linux.ie, daniel@ffwll.ch
Cc:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] A simple doc fix
Message-ID: <YyIq8mXKXP1kCoLS@autolfshost>
References: <YyGuwqpuwq+PT3K1@autolfshost>
 <5372b154-dc25-a917-9908-c59555afc865@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5372b154-dc25-a917-9908-c59555afc865@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 14, 2022 at 10:24:36AM -0400, Andrey Grodzovsky wrote:
> 
> On 2022-09-14 06:36, Anup K Parikh wrote:
> > Fix two warnings during doc build which also results in corresponding
> > additions in generated docs
> > 
> > Warnings Fixed:
> > 1. include/drm/gpu_scheduler.h:462: warning: Function parameter or member
> >     'dev' not described in 'drm_gpu_scheduler'
> > 2. drivers/gpu/drm/scheduler/sched_main.c:1005: warning: Function
> >     parameter or member 'dev' not described in 'drm_sched_init'
> > 
> > Signed-off-by: Anup K Parikh <parikhanupk.foss@gmail.com>
> > ---
> >   drivers/gpu/drm/scheduler/sched_main.c | 1 +
> >   include/drm/gpu_scheduler.h            | 1 +
> >   2 files changed, 2 insertions(+)
> > 
> > diff --git a/drivers/gpu/drm/scheduler/sched_main.c b/drivers/gpu/drm/scheduler/sched_main.c
> > index 68317d3a7a27..875d00213849 100644
> > --- a/drivers/gpu/drm/scheduler/sched_main.c
> > +++ b/drivers/gpu/drm/scheduler/sched_main.c
> > @@ -994,6 +994,7 @@ static int drm_sched_main(void *param)
> >    *		used
> >    * @score: optional score atomic shared with other schedulers
> >    * @name: name used for debugging
> > + * @dev: A device pointer for use in error reporting in a multiple GPU scenario.
> 
> 
> Why multiple GPUs scenario ? It's also used in single GPU scenario.
> 
> Andrey
> 
> 
Hello Mr. Andrey Grodzovsky,

Thanks for the quick review and response.

My documentation string (same for both files) is based on commit id
8ab62eda177bc350f34fea4fcea23603b8184bfd. It seemed that both warnings
might've been introduced by the addition of that device pointer.

Also, the commit message specifically mentions this addition for use with
DRM_DEV_ERROR() to make life easier under a multiple GPU scenario. So, I
used cscope to look for DRM_DEV_ERROR() and then for drm_dev_printk(). I
also checked previous versions of both files and noticed DRM_ERROR() in
drivers/gpu/drm/scheduler/sched_main.c changed to DRM_DEV_ERROR().

Perhaps, I wrongly correlated my cscope/history findings with the commit
message and used absolute wording. I guess that this might be (I usually
avoid absolute wording) useful not only in a single GPU scenario (to print
better standardized messages with dev when available) but also in non-error
printing such as with KERN_NOTICE, KERN_INFO, etc. I'm still not sure if
the added device pointer could be used for something else besides printing.

Please let me know if my understanding is correct and whether I should
change the wording to:

A device pointer - primarily useful for printing standardized messages with
DRM_DEV_ERROR().
> >    *
> >    * Return 0 on success, otherwise error code.
> >    */
> > diff --git a/include/drm/gpu_scheduler.h b/include/drm/gpu_scheduler.h
> > index addb135eeea6..920b91fd1719 100644
> > --- a/include/drm/gpu_scheduler.h
> > +++ b/include/drm/gpu_scheduler.h
> > @@ -435,6 +435,7 @@ struct drm_sched_backend_ops {
> >    * @_score: score used when the driver doesn't provide one
> >    * @ready: marks if the underlying HW is ready to work
> >    * @free_guilty: A hit to time out handler to free the guilty job.
> > + * @dev: A device pointer for use in error reporting in a multiple GPU scenario.
> >    *
> >    * One scheduler is implemented for each hardware ring.
> >    */
