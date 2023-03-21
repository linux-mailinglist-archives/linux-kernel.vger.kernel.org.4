Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 60C136C38BD
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 18:57:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230298AbjCUR5B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 13:57:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230361AbjCUR4v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 13:56:51 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13CDC51C91
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:56:29 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id o6-20020a17090a9f8600b0023f32869993so17206271pjp.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 10:56:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679421388;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=r94G8t+laaLRHOqp7P6NpxqXY5ipeIxkdHAuq3GhtkU=;
        b=FqHGROlFeKRmjeq5RlLPU34wtJAd1p5fe0lZ//1ZGPnYLu2AjOOVTuxxzO98KffaFL
         lk+3qizt2R4AK6AR6mCf3Kn/u8mTYHjdJYmuIiFl3OlpZ1eNMwl9/hq83DKtd7rCDtxS
         RCXDW9R/ajRyFK/UhSmcqgM06xDl2DWQOHuKrPvRkquC7InbHhLKbUbmWDQiDdnEkYsv
         Er9NCeoQT9xP5AdZ6KE+Zhzqz9nj2Xd8jYXKR8gshFvML5TmwC39qYkAjB9NCSqc9mdC
         BBGhuZFPkvImL4kvzyhdNndy4oTWPoSWy42+7Vv3uMrgu4w/HOIBQcmaKUsPf0fy9+7P
         Objg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679421388;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=r94G8t+laaLRHOqp7P6NpxqXY5ipeIxkdHAuq3GhtkU=;
        b=JQ+ueUpm0vO5tL4OZRol0NxsfVvfVpDY28RnZ6AHNqdwM2khO7VrMoG2uuK2JGFg+V
         eSGHtBAp6QCPoAGbrMUqQiBjA2eLJGxPFDrA1NDaRa05KwB4jQ6FTo9ONXJoVNrBtQ1W
         dhgtChwkotOPPZP88ky2qbS7KLkKXmE/Mhu09rOF7ysVaZmRWB2FijlBmk4n+HcqNu5L
         KaevPGrqLqh47oFErycvaxpuT+ah1tOJ74SoL4i9dVQe4SGkY70Q3lhxj4vst8tW84Mh
         DAGtlVoJjMGxhC29fGC2siYHjLUjH05RjiD+g58AQ/gINFRdj1zT2+e7eyiwSydy7Ei0
         /tPg==
X-Gm-Message-State: AO0yUKVxUIkPTFsu1TkInWmqkt4AgBZyU9a39AUuxH5PQgX9cA0Xv68A
        QLHWE/61218RpISEW9KrcTDOkk8QZdQHBruFQV1Efw==
X-Google-Smtp-Source: AK7set99Lezq0qYv6gzZV3r6/9X/dce2iZeZI5kDliHXHztkipzJifJgdyGO+cknsvtp3ylxbHTLLHsBNuUA0FbXeWs=
X-Received: by 2002:a17:90a:d205:b0:23c:fae6:c1e1 with SMTP id
 o5-20020a17090ad20500b0023cfae6c1e1mr252377pju.6.1679421388545; Tue, 21 Mar
 2023 10:56:28 -0700 (PDT)
MIME-Version: 1.0
References: <20230310160610.742382-1-james.clark@arm.com> <20230310160610.742382-6-james.clark@arm.com>
 <c468a656-036f-df45-0c5e-034a73ed727a@arm.com>
In-Reply-To: <c468a656-036f-df45-0c5e-034a73ed727a@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 21 Mar 2023 17:56:16 +0000
Message-ID: <CAJ9a7Vg1EebruGT0irGE6sgk-Rs39-ptX_N3U=NkG3OsQeuBFQ@mail.gmail.com>
Subject: Re: [PATCH v2 5/9] coresight: Dynamically add connections
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     James Clark <james.clark@arm.com>, coresight@lists.linaro.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James

On Thu, 16 Mar 2023 at 17:12, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 10/03/2023 16:06, James Clark wrote:
> > Add a function for adding connections dynamically. This also removes
> > the 1:1 mapping between port number and the index into the connections
> > array. The only place this mapping was used was in the warning for
> > duplicate output ports, which has been replaced by a search. Other
> > uses of the port number already use the port member variable.
> >
> > Being able to dynamically add connections will allow other devices like
> > CTI to re-use the connection mechanism despite not having explicit
> > connections described in the DT.
> >
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >   .../hwtracing/coresight/coresight-platform.c  | 77 ++++++++++++++-----
> >   include/linux/coresight.h                     |  7 +-
> >   2 files changed, 64 insertions(+), 20 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> > index c77238cdf448..16553f7dde12 100644
> > --- a/drivers/hwtracing/coresight/coresight-platform.c
> > +++ b/drivers/hwtracing/coresight/coresight-platform.c
> > @@ -27,8 +27,9 @@ static int coresight_alloc_conns(struct device *dev,
> >                                struct coresight_platform_data *pdata)
> >   {
> >       if (pdata->nr_outconns) {
> > -             pdata->out_conns = devm_kcalloc(dev, pdata->nr_outconns,
> > -                                         sizeof(*pdata->out_conns), GFP_KERNEL);
> > +             pdata->out_conns = devm_krealloc_array(
> > +                     dev, pdata->out_conns, pdata->nr_outconns,
>
> super minor nit:
>                 pdata->out_conns = devm_krealloc_array(dev,
>
>
> > +                     sizeof(*pdata->out_conns), GFP_KERNEL | __GFP_ZERO);
> >               if (!pdata->out_conns)
> >                       return -ENOMEM;
> >       }
> > @@ -36,6 +37,48 @@ static int coresight_alloc_conns(struct device *dev,
> >       return 0;
> >   }
> >
> > +/*
> > + * Add a connection in the first free slot, or realloc
> > + * if there is no space. @conn's contents is copied into the new slot.
> > + *
> > + * If the output port is already assigned on this device, return -EINVAL
> > + */
> > +int coresight_add_conn(struct device *dev,
> > +                    struct coresight_platform_data *pdata,
> > +                    const struct coresight_connection *conn)
> > +{
> > +     int ret;
> > +     struct coresight_connection *free_conn = NULL;
> > +     struct coresight_connection *i;
> > +
> > +     /*
> > +      * Search for a free slot, and while looking for one, warn
> > +      * on any existing duplicate output port.
> > +      */
> > +     for (i = pdata->out_conns; i < pdata->out_conns + pdata->nr_outconns;
> > +          ++i) {
>
> minor nit: I see why you have gone against using "i" as index into
> the array. But I think having that as the index is still better
> readable.
>
>         for (i = 0; i < pdata->nr_outconns; i++) {
>                 struct coresight_connection *c = &pdata->out_conns[i];
>
> > +             if (i->remote_fwnode && conn->port != -1 &&
> > +                 i->port == conn->port) {
> > +                     dev_warn(dev, "Duplicate output port %d\n", i->port);
> > +                     return -EINVAL;
> > +             }

This code assumes that slots are filled sequentially and that it is
not possible to release slots out of order - i.e. if we find a free
slot, there is not a match in a later slot.
I can't think how this could happen but a comment to confirm this
might be needed here.

When we had 1:1 port / array index then this check was guaranteed

Mike



> > +             if (!i->remote_fwnode && !free_conn)
> > +                     free_conn = i;
> > +     }
> > +
> > +     if (!free_conn) {
>
> and:
>         /* No free slots */
>         if (i == pdata->nr_outconns) {
>
> > +             pdata->nr_outconns++;
> > +             ret = coresight_alloc_conns(dev, pdata);
> > +             if (ret)
> > +                     return ret;
> > +             free_conn = &pdata->out_conns[pdata->nr_outconns - 1];
> > +     }
> > +
>
> and:
>         pdata->out_conns[i] = *conn;
>
>
> Otherwise looks good to me.
>
> Suzuki
>
>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
