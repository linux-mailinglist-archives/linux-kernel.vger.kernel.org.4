Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646CB6C3545
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:13:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231610AbjCUPM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:12:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57542 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231418AbjCUPMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:12:45 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFEE150983
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:12:39 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id d10so8753355pgt.12
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 08:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679411559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=+R1rOHrkxNc1mE2qEpnHzeekyoCGMoA2eexCQ+q58BY=;
        b=ncDt/ksE/I91Iyx1Z2Jf7hHIQnte2/iQmRwlGHniXxBebaFqNLTsSELP+OdHk00ILg
         0mbBRzLlZThGJOFSLWytqRI3FvKa2qp86B7nqATDeM9akDQGK0Od/CPo321/k7GYlK6F
         fbjEEAdH8+WHLUTB4HHVP7tScVKqxVKO6G/EQMXndsXqZJ0Rp+8prMVzrx5v8sU6yoL0
         hLEcbMge0iT3twDRZsEAAukTy1wtO5Jh1WfKGfAt45zJqQolHxnWKQeE63L9PtMWEBgW
         36f9oXUnzMUxd43g4xir+HTw0UKBPHTS0hlccpB8xyFYQ6BYO1RvxRKREwihISCllZZF
         oY2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679411559;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=+R1rOHrkxNc1mE2qEpnHzeekyoCGMoA2eexCQ+q58BY=;
        b=HqeeN1XbS6Dp4fNg3mJzgC1It+GPrOCUT2e2j0pG7v3ZVlCZxngzmA0afsRcT9C9oT
         pXbT0ayyVsYgXulY5Bmp94UOJNJUR1vmujE3hCQ7FtZbGXKJ4IgLIoYCPB8Azb/6ZOM8
         HYdh2Um0g2WaOobVgpSEirI+xk4yFhkTEM91ZwA3nMhH7rocUvz1x7leWyuDKzxCTSH1
         TjOdY1fuQhfDBaFRhS2ZP5jhqdSgF/iPhoqsWAr+HJOal1wwpnY3CC5JtQXPwbA2kOm7
         9QXF/H0SbYe90Es/pEya9xfq0HZJHHFZbjjXoc12n41Hv75dLy+ZJ2P2maHpRis9EnNT
         mxXA==
X-Gm-Message-State: AO0yUKXwn+pVjE4qye3lORwuCty81BQo1PZYo06okAFYsbuyhLmaGEI5
        xHqrz/Z31KTijJ//Ulbvsp1zkZ+lheM8yOafoiH6RQ==
X-Google-Smtp-Source: AK7set9F1WixTSQKJNK/H113IKA9GRRiTexCBsIIzeuNawSVdFJ0q3CTWp009b1dumUwIPFHqfT2gkiOTCTpyZ+9CJI=
X-Received: by 2002:a65:4841:0:b0:50a:c1b3:ed55 with SMTP id
 i1-20020a654841000000b0050ac1b3ed55mr748682pgs.11.1679411558960; Tue, 21 Mar
 2023 08:12:38 -0700 (PDT)
MIME-Version: 1.0
References: <20230310160610.742382-1-james.clark@arm.com> <20230310160610.742382-3-james.clark@arm.com>
 <c01553d3-d0b3-eebd-55e5-ab9defdf1124@arm.com>
In-Reply-To: <c01553d3-d0b3-eebd-55e5-ab9defdf1124@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 21 Mar 2023 15:12:27 +0000
Message-ID: <CAJ9a7VinZOoHnJaOyyO8+jQpvDsru9t4kmpdYyMv5qAq3vy2tQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/9] coresight: Change name of pdata->conns
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

On Thu, 16 Mar 2023 at 17:17, Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
>
> On 10/03/2023 16:06, James Clark wrote:
> > conns is actually for output connections. Change the name to make it
> > clearer and so that we can add input connections later.
> >
> > No functional changes.
> >
> > Signed-off-by: James Clark <james.clark@arm.com>
> > ---
> >   drivers/hwtracing/coresight/coresight-core.c  | 26 +++++++++----------
> >   .../hwtracing/coresight/coresight-platform.c  | 12 ++++-----
> >   .../hwtracing/coresight/coresight-tmc-etr.c   |  2 +-
> >   include/linux/coresight.h                     |  2 +-
> >   4 files changed, 21 insertions(+), 21 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> > index e3b63fd52b9c..c0eda7407fb8 100644
> > --- a/drivers/hwtracing/coresight/coresight-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-core.c
> > @@ -119,7 +119,7 @@ static int coresight_find_link_inport(struct coresight_device *csdev,
> >       struct coresight_connection *conn;
> >
> >       for (i = 0; i < parent->pdata->nr_outport; i++) {
> > -             conn = &parent->pdata->conns[i];
> > +             conn = &parent->pdata->out_conns[i];
> >               if (conn->child_dev == csdev)
> >                       return conn->child_port;
> >       }
> > @@ -137,7 +137,7 @@ static int coresight_find_link_outport(struct coresight_device *csdev,
> >       struct coresight_connection *conn;
> >
> >       for (i = 0; i < csdev->pdata->nr_outport; i++) {
> > -             conn = &csdev->pdata->conns[i];
> > +             conn = &csdev->pdata->out_conns[i];
> >               if (conn->child_dev == child)
> >                       return conn->outport;
> >       }
> > @@ -606,7 +606,7 @@ coresight_find_enabled_sink(struct coresight_device *csdev)
> >       for (i = 0; i < csdev->pdata->nr_outport; i++) {
> >               struct coresight_device *child_dev;
> >
> > -             child_dev = csdev->pdata->conns[i].child_dev;
> > +             child_dev = csdev->pdata->out_conns[i].child_dev;
> >               if (child_dev)
> >                       sink = coresight_find_enabled_sink(child_dev);
> >               if (sink)
> > @@ -722,7 +722,7 @@ static int coresight_grab_device(struct coresight_device *csdev)
> >       for (i = 0; i < csdev->pdata->nr_outport; i++) {
> >               struct coresight_device *child;
> >
> > -             child  = csdev->pdata->conns[i].child_dev;
> > +             child = csdev->pdata->out_conns[i].child_dev;
> >               if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
> >                       if (!coresight_get_ref(child))
> >                               goto err;
> > @@ -733,7 +733,7 @@ static int coresight_grab_device(struct coresight_device *csdev)
> >       for (i--; i >= 0; i--) {
> >               struct coresight_device *child;
> >
> > -             child  = csdev->pdata->conns[i].child_dev;
> > +             child = csdev->pdata->out_conns[i].child_dev;
> >               if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
> >                       coresight_put_ref(child);
> >       }
> > @@ -752,7 +752,7 @@ static void coresight_drop_device(struct coresight_device *csdev)
> >       for (i = 0; i < csdev->pdata->nr_outport; i++) {
> >               struct coresight_device *child;
> >
> > -             child  = csdev->pdata->conns[i].child_dev;
> > +             child = csdev->pdata->out_conns[i].child_dev;
> >               if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
> >                       coresight_put_ref(child);
> >       }
> > @@ -794,7 +794,7 @@ static int _coresight_build_path(struct coresight_device *csdev,
> >       for (i = 0; i < csdev->pdata->nr_outport; i++) {
> >               struct coresight_device *child_dev;
> >
> > -             child_dev = csdev->pdata->conns[i].child_dev;
> > +             child_dev = csdev->pdata->out_conns[i].child_dev;
> >               if (child_dev &&
> >                   _coresight_build_path(child_dev, sink, path) == 0) {
> >                       found = true;
> > @@ -964,7 +964,7 @@ coresight_find_sink(struct coresight_device *csdev, int *depth)
> >               struct coresight_device *child_dev, *sink = NULL;
> >               int child_depth = curr_depth;
> >
> > -             child_dev = csdev->pdata->conns[i].child_dev;
> > +             child_dev = csdev->pdata->out_conns[i].child_dev;
> >               if (child_dev)
> >                       sink = coresight_find_sink(child_dev, &child_depth);
> >
> > @@ -1334,7 +1334,7 @@ static int coresight_orphan_match(struct device *dev, void *data)
> >        * an orphan connection whose name matches @csdev, link it.
> >        */
> >       for (i = 0; i < i_csdev->pdata->nr_outport; i++) {
> > -             conn = &i_csdev->pdata->conns[i];
> > +             conn = &i_csdev->pdata->out_conns[i];
> >
> >               /* Skip the port if FW doesn't describe it */
> >               if (!conn->child_fwnode)
> > @@ -1375,7 +1375,7 @@ static int coresight_fixup_device_conns(struct coresight_device *csdev)
> >       int i, ret = 0;
> >
> >       for (i = 0; i < csdev->pdata->nr_outport; i++) {
> > -             struct coresight_connection *conn = &csdev->pdata->conns[i];
> > +             struct coresight_connection *conn = &csdev->pdata->out_conns[i];
> >
> >               if (!conn->child_fwnode)
> >                       continue;
> > @@ -1412,7 +1412,7 @@ static int coresight_remove_match(struct device *dev, void *data)
> >        * a connection whose name matches @csdev, remove it.
> >        */
> >       for (i = 0; i < iterator->pdata->nr_outport; i++) {
> > -             conn = &iterator->pdata->conns[i];
> > +             conn = &iterator->pdata->out_conns[i];
> >
> >               if (conn->child_dev == NULL || conn->child_fwnode == NULL)
> >                       continue;
> > @@ -1548,7 +1548,7 @@ void coresight_release_platform_data(struct coresight_device *csdev,
> >                                    struct coresight_platform_data *pdata)
> >   {
> >       int i;
> > -     struct coresight_connection *conns = pdata->conns;
> > +     struct coresight_connection *conns = pdata->out_conns;
> >
> >       for (i = 0; i < pdata->nr_outport; i++) {
> >               /* If we have made the links, remove them now */
> > @@ -1560,7 +1560,7 @@ void coresight_release_platform_data(struct coresight_device *csdev,
> >                */
> >               if (conns[i].child_fwnode) {
> >                       fwnode_handle_put(conns[i].child_fwnode);
> > -                     pdata->conns[i].child_fwnode = NULL;
> > +                     pdata->out_conns[i].child_fwnode = NULL;
> >               }
> >       }
> >       if (csdev)
> > diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
> > index 475899714104..5085525a32bb 100644
> > --- a/drivers/hwtracing/coresight/coresight-platform.c
> > +++ b/drivers/hwtracing/coresight/coresight-platform.c
> > @@ -27,9 +27,9 @@ static int coresight_alloc_conns(struct device *dev,
> >                                struct coresight_platform_data *pdata)
> >   {
> >       if (pdata->nr_outport) {
> > -             pdata->conns = devm_kcalloc(dev, pdata->nr_outport,
> > -                                         sizeof(*pdata->conns), GFP_KERNEL);
> > -             if (!pdata->conns)
> > +             pdata->out_conns = devm_kcalloc(dev, pdata->nr_outport,
> > +                                         sizeof(*pdata->out_conns), GFP_KERNEL);
> > +             if (!pdata->out_conns)
> >                       return -ENOMEM;
> >       }
> >
> > @@ -251,7 +251,7 @@ static int of_coresight_parse_endpoint(struct device *dev,
> >                       break;
> >               }
> >
> > -             conn = &pdata->conns[endpoint.port];
> > +             conn = &pdata->out_conns[endpoint.port];
> >               if (conn->child_fwnode) {
> >                       dev_warn(dev, "Duplicate output port %d\n",
> >                                endpoint.port);
> > @@ -744,8 +744,8 @@ static int acpi_coresight_parse_graph(struct acpi_device *adev,
> >               int port = conns[i].outport;
> >
> >               /* Duplicate output port */
> > -             WARN_ON(pdata->conns[port].child_fwnode);
> > -             pdata->conns[port] = conns[i];
> > +             WARN_ON(pdata->out_conns[port].child_fwnode);
> > +             pdata->out_conns[port] = conns[i];
> >       }
> >
> >       devm_kfree(&adev->dev, conns);
> > diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> > index ed589cfff1b5..86d4a08aa833 100644
> > --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> > +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> > @@ -782,7 +782,7 @@ tmc_etr_get_catu_device(struct tmc_drvdata *drvdata)
> >               return NULL;
> >
> >       for (i = 0; i < etr->pdata->nr_outport; i++) {
> > -             tmp = etr->pdata->conns[i].child_dev;
> > +             tmp = etr->pdata->out_conns[i].child_dev;
> >               if (tmp && coresight_is_catu_device(tmp))
> >                       return tmp;
> >       }
> > diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> > index 1f878e8ed8c4..322d7273e122 100644
> > --- a/include/linux/coresight.h
> > +++ b/include/linux/coresight.h
> > @@ -109,7 +109,7 @@ union coresight_dev_subtype {
> >   struct coresight_platform_data {
> >       int nr_inport;
> >       int nr_outport;
> > -     struct coresight_connection *conns;
> > +     struct coresight_connection *out_conns;
>
> The comment above this structure might need to reflect the name change.
>
> Otherwise looks good to me.
>
> Suzuki
>
> >   };
> >
> >   /**
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>


--
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
