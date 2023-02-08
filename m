Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B100D68F315
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Feb 2023 17:21:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230506AbjBHQVJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Feb 2023 11:21:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbjBHQVH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Feb 2023 11:21:07 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79F867DB2
        for <linux-kernel@vger.kernel.org>; Wed,  8 Feb 2023 08:21:02 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id d13-20020a17090ad3cd00b0023127b2d602so149195pjw.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Feb 2023 08:21:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DEK2hpnhKwRYWIzo95uMsYr/kmP35iiqnxWMgT8vgts=;
        b=pDV+ti3ntpszBYfVs4HVL6dUHbOruexFfJpKANSPxdj7777CGaQrL8qR/JxgZFPEAX
         UF2N7UfmBg1Mf44Yod4l+/c+/kN7Rv1ZYJjsVsqHf6rP+gNmHwtAVZLRzxz/0D1SWCOA
         AhZnbjWre51joOKbbYaWbi0nBYDKMaRiKlPJgVbgyfXLKkBkqRnMXaccELDX5HjzK37I
         rPV09U73E3DkYAGrvR5bSl60+sNjDaYzhfUQorulq4ihIikL/zpYDpvv//5e6FvDHf1u
         o6fZbDIoNHQic3jKoSf7ASHxVce7A2ogOUwe23pc8OQUKHCPVZQhxIVG3Oy7K35JVRvR
         wBWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DEK2hpnhKwRYWIzo95uMsYr/kmP35iiqnxWMgT8vgts=;
        b=OETOqNpqrMFABha8hO0Ch46nhd+c61rH0/9rgMWGY+1UlJV867knt/giLVW8Zu+99C
         yfyFaAAWwsu+j6qeM4JnE6LeC4M2xAsXw5wNDByS7VYBMD5W9XhdauwbUzFISq3wINw0
         odpHu07aV1jbFIyHPPcFtae9qG4r43bMrgTxrKCQMnjII1i3WttSOLE0OB07YBu++GmM
         Udp0jKuQVRAEZlyWj31ujn+6wInNznZxndGg9htcLT8fq9KruJ5MAgHEZonH9AARCVxw
         0R4xPkq5zPIAc0FFEBEXNlZN20p5DLvHTyOpxC3duoDgjyLA9ZAR9M+u/QycgQer8VJV
         4bXA==
X-Gm-Message-State: AO0yUKXCGz5yhm2y0scM4basnyW6Pnu2EpPZ+58n4xqnokUFuCAg47Um
        /fWZPh70MSu3vkS1azHxeECZZKqaagfR2mSR8pSPYw==
X-Google-Smtp-Source: AK7set+31m7g6T9Y00tJ+g9NCbMOVM9o9Xb/+KORsRblpNgCthvgcYzQeH0aZNWG1Bqj+1n+jW7iYH96m29fkZkM3Go=
X-Received: by 2002:a17:902:e842:b0:196:b12:25fa with SMTP id
 t2-20020a170902e84200b001960b1225famr2200287plg.17.1675873261969; Wed, 08 Feb
 2023 08:21:01 -0800 (PST)
MIME-Version: 1.0
References: <20230208111630.20132-1-quic_jinlmao@quicinc.com> <CAJ9a7ViBS9K6cKsOi3btw1b5cM9VTSb-q8s6W3WUAgeW3-T2Sg@mail.gmail.com>
In-Reply-To: <CAJ9a7ViBS9K6cKsOi3btw1b5cM9VTSb-q8s6W3WUAgeW3-T2Sg@mail.gmail.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Wed, 8 Feb 2023 16:20:50 +0000
Message-ID: <CAJ9a7ViA5BsbLjRWMsttmpmcPh1yUXK8J79k-pqYybVZkMQHXQ@mail.gmail.com>
Subject: Re: [PATCH] coresight: core: Add sysfs node to reset all sources and sinks
To:     Mao Jinlong <quic_jinlmao@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Hao Zhang <quic_hazha@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quick correction - you need to look for enable_source  / enable_sink
files and disable those that are currently '1'

Mike

On Wed, 8 Feb 2023 at 16:16, Mike Leach <mike.leach@linaro.org> wrote:
>
> Hi
>
> As this is a sysfs only update - would it not be easier to simply use
> a shell script to iterate through coresight/devices/ looking for
> disable_source / disable_sink files and setting those accordingly?
>
> See tools/perf/tests/shell/test_arm_coresight.sh for an example of a
> script that does similar iteration to test coresight in perf
>
> Regards
>
> Mike
>
> On Wed, 8 Feb 2023 at 11:16, Mao Jinlong <quic_jinlmao@quicinc.com> wrote:
> >
> > Add sysfs node to reset all the sources and sinks. When mltiple
> > sources are enabled, write 1 to reset_source_sink node to disable
> > all sources and sinks.
> >
> > Signed-off-by: Mao Jinlong <quic_jinlmao@quicinc.com>
> > ---
> >  drivers/hwtracing/coresight/coresight-core.c | 106 +++++++++++++++++--
> >  1 file changed, 99 insertions(+), 7 deletions(-)
> >
> > diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> > index d3bf82c0de1d..06741ed2dee7 100644
> > --- a/drivers/hwtracing/coresight/coresight-core.c
> > +++ b/drivers/hwtracing/coresight/coresight-core.c
> > @@ -458,6 +458,28 @@ static bool coresight_disable_source(struct coresight_device *csdev)
> >         return !csdev->enable;
> >  }
> >
> > +/**
> > + * coresight_get_source - Get the source from the path
> > + *
> > + * @path: The list of devices.
> > + *
> > + * Returns the soruce csdev.
> > + *
> > + */
> > +static struct coresight_device *coresight_get_source(struct list_head *path)
> > +{
> > +       struct coresight_device *csdev;
> > +
> > +       if (!path)
> > +               return NULL;
> > +
> > +       csdev = list_first_entry(path, struct coresight_node, link)->csdev;
> > +       if (csdev->type != CORESIGHT_DEV_TYPE_SOURCE)
> > +               return NULL;
> > +
> > +       return csdev;
> > +}
> > +
> >  /*
> >   * coresight_disable_path_from : Disable components in the given path beyond
> >   * @nd in the list. If @nd is NULL, all the components, except the SOURCE are
> > @@ -1159,20 +1181,18 @@ int coresight_enable(struct coresight_device *csdev)
> >  }
> >  EXPORT_SYMBOL_GPL(coresight_enable);
> >
> > -void coresight_disable(struct coresight_device *csdev)
> > +static void _coresight_disable(struct coresight_device *csdev)
> >  {
> >         int cpu, ret;
> >         struct list_head *path = NULL;
> >         u32 hash;
> >
> > -       mutex_lock(&coresight_mutex);
> > -
> >         ret = coresight_validate_source(csdev, __func__);
> >         if (ret)
> > -               goto out;
> > +               return;
> >
> >         if (!csdev->enable || !coresight_disable_source(csdev))
> > -               goto out;
> > +               return;
> >
> >         switch (csdev->subtype.source_subtype) {
> >         case CORESIGHT_DEV_SUBTYPE_SOURCE_PROC:
> > @@ -1187,7 +1207,7 @@ void coresight_disable(struct coresight_device *csdev)
> >                 path = idr_find(&path_idr, hash);
> >                 if (path == NULL) {
> >                         pr_err("Path is not found for %s\n", dev_name(&csdev->dev));
> > -                       goto out;
> > +                       return;
> >                 }
> >                 idr_remove(&path_idr, hash);
> >                 break;
> > @@ -1198,8 +1218,12 @@ void coresight_disable(struct coresight_device *csdev)
> >
> >         coresight_disable_path(path);
> >         coresight_release_path(path);
> > +}
> >
> > -out:
> > +void coresight_disable(struct coresight_device *csdev)
> > +{
> > +       mutex_lock(&coresight_mutex);
> > +       _coresight_disable(csdev);
> >         mutex_unlock(&coresight_mutex);
> >  }
> >  EXPORT_SYMBOL_GPL(coresight_disable);
> > @@ -1761,8 +1785,76 @@ char *coresight_alloc_device_name(struct coresight_dev_list *dict,
> >  }
> >  EXPORT_SYMBOL_GPL(coresight_alloc_device_name);
> >
> > +/*
> > + * Set the sink active status to false.
> > + */
> > +static int coresight_reset_sink(struct device *dev, void *data)
> > +{
> > +       struct coresight_device *csdev = to_coresight_device(dev);
> > +
> > +       if ((csdev->type == CORESIGHT_DEV_TYPE_SINK ||
> > +               csdev->type == CORESIGHT_DEV_TYPE_LINKSINK) &&
> > +               csdev->activated)
> > +               csdev->activated = false;
> > +
> > +       return 0;
> > +}
> > +
> > +static void coresight_reset_all_sink(void)
> > +{
> > +       bus_for_each_dev(&coresight_bustype, NULL, NULL, coresight_reset_sink);
> > +}
> > +
> > +static ssize_t reset_source_sink_store(struct bus_type *bus,
> > +                                      const char *buf, size_t size)
> > +{
> > +       int id, cpu, ret = 0;
> > +       unsigned long val;
> > +       struct coresight_device *csdev;
> > +       struct list_head *path = NULL;
> > +
> > +       ret = kstrtoul(buf, 10, &val);
> > +       if (ret)
> > +               return ret;
> > +
> > +       mutex_lock(&coresight_mutex);
> > +
> > +       /* Disable all per cpu sources */
> > +       for_each_present_cpu(cpu) {
> > +               path = per_cpu(tracer_path, cpu);
> > +               if (path) {
> > +                       csdev = coresight_get_source(path);
> > +                       if (!csdev)
> > +                               continue;
> > +               }
> > +               _coresight_disable(csdev);
> > +       }
> > +
> > +       /* Disable all sources which aren't associated with CPU */
> > +       idr_for_each_entry (&path_idr, path, id) {
> > +               csdev = coresight_get_source(path);
> > +               if (!csdev)
> > +                       continue;
> > +
> > +               _coresight_disable(csdev);
> > +       }
> > +       /* Reset all activated sinks */
> > +       coresight_reset_all_sink();
> > +
> > +       mutex_unlock(&coresight_mutex);
> > +       return size;
> > +}
> > +static BUS_ATTR_WO(reset_source_sink);
> > +
> > +static struct attribute *coresight_reset_source_sink_attrs[] = {
> > +       &bus_attr_reset_source_sink.attr,
> > +       NULL,
> > +};
> > +ATTRIBUTE_GROUPS(coresight_reset_source_sink);
> > +
> >  struct bus_type coresight_bustype = {
> >         .name   = "coresight",
> > +       .bus_groups     = coresight_reset_source_sink_groups,
> >  };
> >
> >  static int __init coresight_init(void)
> > --
> > 2.39.0
> >
>
>
> --
> Mike Leach
> Principal Engineer, ARM Ltd.
> Manchester Design Centre. UK



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
