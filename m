Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 920C76E470E
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Apr 2023 14:02:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjDQMCC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Apr 2023 08:02:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229568AbjDQMCA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Apr 2023 08:02:00 -0400
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04F05186
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:01:13 -0700 (PDT)
Received: by mail-pg1-x52f.google.com with SMTP id bv65so11391423pgb.8
        for <linux-kernel@vger.kernel.org>; Mon, 17 Apr 2023 05:01:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681732850; x=1684324850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=Y5WFoLKuJc4bt4B+OhyBT+WEU2WaNCSiHDdnZw0Zh4Y=;
        b=Xmi4uKWdubLvAlEb9m50suOa/AogPOQyByF8YYfngAb7w2Knigr5F6QNAiIOE0QUf6
         2UGwWl/vzYvrmbw004Ri/9b2CsH+GMus7gJmTIqFCrfcOhz74VTMo5/5WJ9rkpmSQB7Q
         BI0NEcbe6u/CX16i5ucITjYxLji2PLApaGHux7ADCRMHORukt9/sUNqwsqQaGGC+zFfC
         kms4GWPyTf5hLppJXziHiBep5ywoZ3ahjGoY8bbNGj1J4oRXlbKoDdliQ5No9SGL9ijW
         TlqBmDvgYip6zb39bYjpjD9+oxsnbsZdHPrPWobnQMIIyqcOaAaCDg+k2ZsNheupHeLG
         vlqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681732850; x=1684324850;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Y5WFoLKuJc4bt4B+OhyBT+WEU2WaNCSiHDdnZw0Zh4Y=;
        b=IiDUqr1xzaTn8+YblBuXv3T8HcJ5BkvmPwjTy5zKVpNNDSU6CIL66d0A1POn22blN3
         1IWBMwPbTiMoOcc6c1czMI2wWPP5wXlw63JbLzJk4A8imfYmXBIY6s+tZ8ZEQ7kzvUDy
         aNchYmKlO0E5W/ix+rLGg83tJQfiURkOlU0vn2GNa8O8FUCPKrmhEOlRVxvthz2pG29t
         bLk9H9jXN59/8EJX+Ire+P7dUAP+CT9k+2VAHCE0YnIl96YKMaRRV0sqQ5fOLwRTd5rO
         crkFDiSmfvpblcc7pRxx1VohSof+dRvQzloGs9Roe2GtVBXLJvuL0WDZVhwv5lgLK0Cv
         +WpQ==
X-Gm-Message-State: AAQBX9fEwB709EWJ1oY6/EtXgAYa1ic2wNL1zysB9+EmUYF/gXISEW/B
        Z8jrK2V0f6E5AHJCmhDx0pWCCY4uTJk84PcZRIDAag==
X-Google-Smtp-Source: AKy350YHOnV5WhDiPEpVQLwHI2qdIXn5Y3jnBo7qJqYA+Wwc5W282da/C2tttJNliucWIUyjSBPLNRA9btbdbjNiYn4=
X-Received: by 2002:a63:5456:0:b0:518:98f1:2467 with SMTP id
 e22-20020a635456000000b0051898f12467mr2936895pgm.11.1681732849733; Mon, 17
 Apr 2023 05:00:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230404155121.1824126-1-james.clark@arm.com> <20230404155121.1824126-13-james.clark@arm.com>
In-Reply-To: <20230404155121.1824126-13-james.clark@arm.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 17 Apr 2023 13:00:38 +0100
Message-ID: <CAJ9a7VgS3Bjnocxkg1mY4Vi6v7KpQFk1nrDa2z2O-Z_+4OekfA@mail.gmail.com>
Subject: Re: [PATCH v5 12/13] coresight: Enable and disable helper devices
 adjacent to the path
To:     James Clark <james.clark@arm.com>
Cc:     coresight@lists.linaro.org, quic_jinlmao@quicinc.com,
        suzuki.poulose@arm.com,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Leo Yan <leo.yan@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi James

On Tue, 4 Apr 2023 at 16:52, James Clark <james.clark@arm.com> wrote:
>
> Currently CATU is the only helper device, and its enable and disable
> calls are hard coded. To allow more helper devices to be added in a
> generic way, remove these hard coded calls and just enable and disable
> all helper devices.
>
> This has to apply to helpers adjacent to the path, because they will
> never be in the path. CATU was already discovered in this way, so
> there is no change there.
>
> One change that is needed is for CATU to call back into ETR to allocate
> the buffer. Because the enable call was previously hard coded, it was
> done at a point where the buffer was already allocated, but this is no
> longer the case.
>
> Signed-off-by: James Clark <james.clark@arm.com>
> ---
>  drivers/hwtracing/coresight/coresight-catu.c  |  21 ++-
>  drivers/hwtracing/coresight/coresight-core.c  | 161 ++++++++++++++++--
>  .../hwtracing/coresight/coresight-etm-perf.c  |   4 +-
>  drivers/hwtracing/coresight/coresight-priv.h  |   3 +
>  .../hwtracing/coresight/coresight-tmc-etr.c   |  43 +----
>  include/linux/coresight.h                     |  11 +-
>  6 files changed, 188 insertions(+), 55 deletions(-)
>
> diff --git a/drivers/hwtracing/coresight/coresight-catu.c b/drivers/hwtracing/coresight/coresight-catu.c
> index bc90a03f478f..3949ded0d4fa 100644
> --- a/drivers/hwtracing/coresight/coresight-catu.c
> +++ b/drivers/hwtracing/coresight/coresight-catu.c
> @@ -395,13 +395,18 @@ static inline int catu_wait_for_ready(struct catu_drvdata *drvdata)
>         return coresight_timeout(csa, CATU_STATUS, CATU_STATUS_READY, 1);
>  }
>
> -static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
> +static int catu_enable_hw(struct catu_drvdata *drvdata, enum cs_mode cs_mode,
> +                         void *data)
>  {
>         int rc;
>         u32 control, mode;
> -       struct etr_buf *etr_buf = data;
> +       struct etr_buf *etr_buf = NULL;
>         struct device *dev = &drvdata->csdev->dev;
>         struct coresight_device *csdev = drvdata->csdev;
> +       struct coresight_device *etrdev;
> +       union coresight_dev_subtype etr_subtype = {
> +               .sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM
> +       };
>
>         if (catu_wait_for_ready(drvdata))
>                 dev_warn(dev, "Timeout while waiting for READY\n");
> @@ -416,6 +421,13 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
>         if (rc)
>                 return rc;
>
> +       etrdev = coresight_find_input_type(
> +               csdev->pdata, CORESIGHT_DEV_TYPE_SINK, etr_subtype);
> +       if (etrdev) {
> +               etr_buf = tmc_etr_get_buffer(etrdev, cs_mode, data);
> +               if (IS_ERR(etr_buf))
> +                       return PTR_ERR(etr_buf);
> +       }
>         control |= BIT(CATU_CONTROL_ENABLE);
>
>         if (etr_buf && etr_buf->mode == ETR_MODE_CATU) {
> @@ -441,13 +453,14 @@ static int catu_enable_hw(struct catu_drvdata *drvdata, void *data)
>         return 0;
>  }
>
> -static int catu_enable(struct coresight_device *csdev, void *data)
> +static int catu_enable(struct coresight_device *csdev, enum cs_mode mode,
> +                      void *data)
>  {
>         int rc;
>         struct catu_drvdata *catu_drvdata = csdev_to_catu_drvdata(csdev);
>
>         CS_UNLOCK(catu_drvdata->base);
> -       rc = catu_enable_hw(catu_drvdata, data);
> +       rc = catu_enable_hw(catu_drvdata, mode, data);
>         CS_LOCK(catu_drvdata->base);
>         return rc;
>  }
> diff --git a/drivers/hwtracing/coresight/coresight-core.c b/drivers/hwtracing/coresight/coresight-core.c
> index 939b7fb751b5..16689fe4ba98 100644
> --- a/drivers/hwtracing/coresight/coresight-core.c
> +++ b/drivers/hwtracing/coresight/coresight-core.c
> @@ -403,8 +403,8 @@ static void coresight_disable_link(struct coresight_device *csdev,
>         csdev->enable = false;
>  }
>
> -static int coresight_enable_source(struct coresight_device *csdev,
> -                                  enum cs_mode mode)
> +int coresight_enable_source(struct coresight_device *csdev, enum cs_mode mode,
> +                           void *data)
>  {
>         int ret;
>
> @@ -413,7 +413,7 @@ static int coresight_enable_source(struct coresight_device *csdev,
>                         ret = coresight_control_assoc_ectdev(csdev, true);
>                         if (ret)
>                                 return ret;
> -                       ret = source_ops(csdev)->enable(csdev, NULL, mode);
> +                       ret = source_ops(csdev)->enable(csdev, data, mode);
>                         if (ret) {
>                                 coresight_control_assoc_ectdev(csdev, false);
>                                 return ret;
> @@ -426,25 +426,75 @@ static int coresight_enable_source(struct coresight_device *csdev,
>
>         return 0;
>  }
> +EXPORT_SYMBOL_GPL(coresight_enable_source);
> +
> +static bool coresight_is_helper(struct coresight_device *csdev)
> +{
> +       return csdev->type == CORESIGHT_DEV_TYPE_HELPER;
> +}
> +
> +static int coresight_enable_helper(struct coresight_device *csdev,
> +                                  enum cs_mode mode, void *data)
> +{
> +       int ret;
> +
> +       if (!helper_ops(csdev)->enable)
> +               return 0;
> +       ret = helper_ops(csdev)->enable(csdev, mode, data);
> +       if (ret)
> +               return ret;
> +
> +       csdev->enable = true;
> +       return 0;
> +}
> +
> +static void coresight_disable_helper(struct coresight_device *csdev)
> +{
> +       int ret;
> +
> +       if (!helper_ops(csdev)->disable)
> +               return;
> +
> +       ret = helper_ops(csdev)->disable(csdev, NULL);
> +       if (ret)
> +               return;
> +       csdev->enable = false;
> +}
> +
> +static void coresight_disable_helpers(struct coresight_device *csdev)
> +{
> +       int i;
> +       struct coresight_device *helper;
> +
> +       for (i = 0; i < csdev->pdata->nr_outconns; ++i) {
> +               helper = csdev->pdata->out_conns[i]->dest_dev;
> +               if (helper && coresight_is_helper(helper))
> +                       coresight_disable_helper(helper);
> +       }
> +}
>
>  /**
>   *  coresight_disable_source - Drop the reference count by 1 and disable
>   *  the device if there are no users left.
>   *
>   *  @csdev: The coresight device to disable
> + *  @data: Opaque data to pass on to the disable function of the source device.
> + *         For example in perf mode this is a pointer to the struct perf_event.
>   *
>   *  Returns true if the device has been disabled.
>   */
> -static bool coresight_disable_source(struct coresight_device *csdev)
> +bool coresight_disable_source(struct coresight_device *csdev, void *data)
>  {
>         if (atomic_dec_return(&csdev->refcnt) == 0) {
>                 if (source_ops(csdev)->disable)
> -                       source_ops(csdev)->disable(csdev, NULL);
> +                       source_ops(csdev)->disable(csdev, data);
>                 coresight_control_assoc_ectdev(csdev, false);
> +               coresight_disable_helpers(csdev);
>                 csdev->enable = false;
>         }
>         return !csdev->enable;
>  }
> +EXPORT_SYMBOL_GPL(coresight_disable_source);
>
>  /*
>   * coresight_disable_path_from : Disable components in the given path beyond
> @@ -495,6 +545,9 @@ static void coresight_disable_path_from(struct list_head *path,
>                 default:
>                         break;
>                 }
> +
> +               /* Disable all helpers adjacent along the path last */
> +               coresight_disable_helpers(csdev);
>         }
>  }
>
> @@ -504,9 +557,28 @@ void coresight_disable_path(struct list_head *path)
>  }
>  EXPORT_SYMBOL_GPL(coresight_disable_path);
>
> -int coresight_enable_path(struct list_head *path, enum cs_mode mode, void *sink_data)
> +static int coresight_enable_helpers(struct coresight_device *csdev,
> +                                   enum cs_mode mode, void *data)
>  {
> +       int i, ret = 0;
> +       struct coresight_device *helper;
> +
> +       for (i = 0; i < csdev->pdata->nr_outconns; ++i) {
> +               helper = csdev->pdata->out_conns[i]->dest_dev;
> +               if (!helper || helper->type != CORESIGHT_DEV_TYPE_HELPER)

minor issue: Use coresight_is_helper() here too?

> +                       continue;
> +
> +               ret = coresight_enable_helper(helper, mode, data);
> +               if (ret)
> +                       return ret;
> +       }
>
> +       return 0;
> +}
> +
> +int coresight_enable_path(struct list_head *path, enum cs_mode mode,
> +                         void *sink_data)
> +{
>         int ret = 0;
>         u32 type;
>         struct coresight_node *nd;
> @@ -516,6 +588,10 @@ int coresight_enable_path(struct list_head *path, enum cs_mode mode, void *sink_
>                 csdev = nd->csdev;
>                 type = csdev->type;
>
> +               /* Enable all helpers adjacent to the path first */
> +               ret = coresight_enable_helpers(csdev, mode, sink_data);
> +               if (ret)
> +                       goto err;
>                 /*
>                  * ETF devices are tricky... They can be a link or a sink,
>                  * depending on how they are configured.  If an ETF has been
> @@ -710,7 +786,7 @@ static int coresight_grab_device(struct coresight_device *csdev)
>                 struct coresight_device *child;
>
>                 child = csdev->pdata->out_conns[i]->dest_dev;
> -               if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
> +               if (child && coresight_is_helper(child))
>                         if (!coresight_get_ref(child))
>                                 goto err;
>         }
> @@ -721,7 +797,7 @@ static int coresight_grab_device(struct coresight_device *csdev)
>                 struct coresight_device *child;
>
>                 child = csdev->pdata->out_conns[i]->dest_dev;
> -               if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
> +               if (child && coresight_is_helper(child))
>                         coresight_put_ref(child);
>         }
>         return -ENODEV;
> @@ -740,7 +816,7 @@ static void coresight_drop_device(struct coresight_device *csdev)
>                 struct coresight_device *child;
>
>                 child = csdev->pdata->out_conns[i]->dest_dev;
> -               if (child && child->type == CORESIGHT_DEV_TYPE_HELPER)
> +               if (child && coresight_is_helper(child))
>                         coresight_put_ref(child);
>         }
>  }
> @@ -1102,7 +1178,7 @@ int coresight_enable(struct coresight_device *csdev)
>         if (ret)
>                 goto err_path;
>
> -       ret = coresight_enable_source(csdev, CS_MODE_SYSFS);
> +       ret = coresight_enable_source(csdev, CS_MODE_SYSFS, NULL);
>         if (ret)
>                 goto err_source;
>
> @@ -1159,7 +1235,7 @@ void coresight_disable(struct coresight_device *csdev)
>         if (ret)
>                 goto out;
>
> -       if (!csdev->enable || !coresight_disable_source(csdev))
> +       if (!csdev->enable || !coresight_disable_source(csdev, NULL))
>                 goto out;
>
>         switch (csdev->subtype.source_subtype) {
> @@ -1644,6 +1720,69 @@ static inline int coresight_search_device_idx(struct coresight_dev_list *dict,
>         return -ENOENT;
>  }
>
> +static bool coresight_compare_type(enum coresight_dev_type type_a,
> +                                  union coresight_dev_subtype subtype_a,
> +                                  enum coresight_dev_type type_b,
> +                                  union coresight_dev_subtype subtype_b)
> +{
> +       if (type_a != type_b)
> +               return false;
> +
> +       switch (type_a) {
> +       case CORESIGHT_DEV_TYPE_SINK:
> +               return subtype_a.sink_subtype == subtype_b.sink_subtype;
> +       case CORESIGHT_DEV_TYPE_LINK:
> +               return subtype_a.link_subtype == subtype_b.link_subtype;
> +       case CORESIGHT_DEV_TYPE_LINKSINK:
> +               return subtype_a.link_subtype == subtype_b.link_subtype &&
> +                      subtype_a.sink_subtype == subtype_b.sink_subtype;
> +       case CORESIGHT_DEV_TYPE_SOURCE:
> +               return subtype_a.source_subtype == subtype_b.source_subtype;
> +       case CORESIGHT_DEV_TYPE_HELPER:
> +               return subtype_a.helper_subtype == subtype_b.helper_subtype;
> +       default:
> +               return false;
> +       }
> +}
> +
> +struct coresight_device *
> +coresight_find_input_type(struct coresight_platform_data *pdata,
> +                         enum coresight_dev_type type,
> +                         union coresight_dev_subtype subtype)
> +{
> +       int i;
> +       struct coresight_connection *conn;
> +
> +       for (i = 0; i < pdata->nr_inconns; ++i) {
> +               conn = pdata->in_conns[i];
> +               if (conn &&
> +                   coresight_compare_type(type, subtype, conn->src_dev->type,
> +                                          conn->src_dev->subtype))
> +                       return conn->src_dev;
> +       }
> +       return NULL;
> +}
> +EXPORT_SYMBOL_GPL(coresight_find_input_type);
> +
> +struct coresight_device *
> +coresight_find_output_type(struct coresight_platform_data *pdata,
> +                          enum coresight_dev_type type,
> +                          union coresight_dev_subtype subtype)
> +{
> +       int i;
> +       struct coresight_connection *conn;
> +
> +       for (i = 0; i < pdata->nr_outconns; ++i) {
> +               conn = pdata->out_conns[i];
> +               if (conn->dest_dev &&
> +                   coresight_compare_type(type, subtype, conn->dest_dev->type,
> +                                          conn->dest_dev->subtype))
> +                       return conn->dest_dev;
> +       }
> +       return NULL;
> +}
> +EXPORT_SYMBOL_GPL(coresight_find_output_type);
> +
>  bool coresight_loses_context_with_cpu(struct device *dev)
>  {
>         return fwnode_property_present(dev_fwnode(dev),
> diff --git a/drivers/hwtracing/coresight/coresight-etm-perf.c b/drivers/hwtracing/coresight/coresight-etm-perf.c
> index a48c97da8165..166adcf592cd 100644
> --- a/drivers/hwtracing/coresight/coresight-etm-perf.c
> +++ b/drivers/hwtracing/coresight/coresight-etm-perf.c
> @@ -492,7 +492,7 @@ static void etm_event_start(struct perf_event *event, int flags)
>                 goto fail_end_stop;
>
>         /* Finally enable the tracer */
> -       if (source_ops(csdev)->enable(csdev, event, CS_MODE_PERF))
> +       if (coresight_enable_source(csdev, CS_MODE_PERF, event))
>                 goto fail_disable_path;
>
>         /*
> @@ -586,7 +586,7 @@ static void etm_event_stop(struct perf_event *event, int mode)
>                 return;
>
>         /* stop tracer */
> -       source_ops(csdev)->disable(csdev, event);
> +       coresight_disable_source(csdev, event);
>
>         /* tell the core */
>         event->hw.state = PERF_HES_STOPPED;
> diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
> index 65ae6d161c57..5575014f73e0 100644
> --- a/drivers/hwtracing/coresight/coresight-priv.h
> +++ b/drivers/hwtracing/coresight/coresight-priv.h
> @@ -216,5 +216,8 @@ void coresight_set_assoc_ectdev_mutex(struct coresight_device *csdev,
>
>  void coresight_set_percpu_sink(int cpu, struct coresight_device *csdev);
>  struct coresight_device *coresight_get_percpu_sink(int cpu);
> +int coresight_enable_source(struct coresight_device *csdev, enum cs_mode mode,
> +                           void *data);
> +bool coresight_disable_source(struct coresight_device *csdev, void *data);
>
>  #endif
> diff --git a/drivers/hwtracing/coresight/coresight-tmc-etr.c b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> index 00a0c2aa8481..37afe8b52760 100644
> --- a/drivers/hwtracing/coresight/coresight-tmc-etr.c
> +++ b/drivers/hwtracing/coresight/coresight-tmc-etr.c
> @@ -775,40 +775,19 @@ static const struct etr_buf_operations etr_sg_buf_ops = {
>  struct coresight_device *
>  tmc_etr_get_catu_device(struct tmc_drvdata *drvdata)
>  {
> -       int i;
> -       struct coresight_device *tmp, *etr = drvdata->csdev;
> +       struct coresight_device *etr = drvdata->csdev;
> +       union coresight_dev_subtype catu_subtype = {
> +               .helper_subtype = CORESIGHT_DEV_SUBTYPE_HELPER_CATU
> +       };
>
>         if (!IS_ENABLED(CONFIG_CORESIGHT_CATU))
>                 return NULL;
>
> -       for (i = 0; i < etr->pdata->nr_outconns; i++) {
> -               tmp = etr->pdata->out_conns[i]->dest_dev;
> -               if (tmp && coresight_is_catu_device(tmp))
> -                       return tmp;
> -       }
> -
> -       return NULL;
> +       return coresight_find_output_type(etr->pdata, CORESIGHT_DEV_TYPE_HELPER,
> +                                         catu_subtype);
>  }
>  EXPORT_SYMBOL_GPL(tmc_etr_get_catu_device);
>
> -static inline int tmc_etr_enable_catu(struct tmc_drvdata *drvdata,
> -                                     struct etr_buf *etr_buf)
> -{
> -       struct coresight_device *catu = tmc_etr_get_catu_device(drvdata);
> -
> -       if (catu && helper_ops(catu)->enable)
> -               return helper_ops(catu)->enable(catu, etr_buf);
> -       return 0;
> -}
> -
> -static inline void tmc_etr_disable_catu(struct tmc_drvdata *drvdata)
> -{
> -       struct coresight_device *catu = tmc_etr_get_catu_device(drvdata);
> -
> -       if (catu && helper_ops(catu)->disable)
> -               helper_ops(catu)->disable(catu, drvdata->etr_buf);
> -}
> -
>  static const struct etr_buf_operations *etr_buf_ops[] = {
>         [ETR_MODE_FLAT] = &etr_flat_buf_ops,
>         [ETR_MODE_ETR_SG] = &etr_sg_buf_ops,
> @@ -1058,13 +1037,6 @@ static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
>         if (WARN_ON(drvdata->etr_buf))
>                 return -EBUSY;
>
> -       /*
> -        * If this ETR is connected to a CATU, enable it before we turn
> -        * this on.
> -        */
> -       rc = tmc_etr_enable_catu(drvdata, etr_buf);
> -       if (rc)
> -               return rc;
>         rc = coresight_claim_device(drvdata->csdev);
>         if (!rc) {
>                 drvdata->etr_buf = etr_buf;
> @@ -1072,7 +1044,6 @@ static int tmc_etr_enable_hw(struct tmc_drvdata *drvdata,
>                 if (rc) {
>                         drvdata->etr_buf = NULL;
>                         coresight_disclaim_device(drvdata->csdev);
> -                       tmc_etr_disable_catu(drvdata);
>                 }
>         }
>
> @@ -1162,8 +1133,6 @@ static void __tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
>  void tmc_etr_disable_hw(struct tmc_drvdata *drvdata)
>  {
>         __tmc_etr_disable_hw(drvdata);
> -       /* Disable CATU device if this ETR is connected to one */
> -       tmc_etr_disable_catu(drvdata);
>         coresight_disclaim_device(drvdata->csdev);
>         /* Reset the ETR buf used by hardware */
>         drvdata->etr_buf = NULL;
> diff --git a/include/linux/coresight.h b/include/linux/coresight.h
> index b97edd24f3ec..61dfbab5fa98 100644
> --- a/include/linux/coresight.h
> +++ b/include/linux/coresight.h
> @@ -375,7 +375,8 @@ struct coresight_ops_source {
>   * @disable    : Disable the device
>   */
>  struct coresight_ops_helper {
> -       int (*enable)(struct coresight_device *csdev, void *data);
> +       int (*enable)(struct coresight_device *csdev, enum cs_mode mode,
> +                     void *data);
>         int (*disable)(struct coresight_device *csdev, void *data);
>  };
>
> @@ -646,5 +647,13 @@ coresight_add_out_conn(struct device *dev,
>                        struct coresight_platform_data *pdata,
>                        const struct coresight_connection *new_conn);
>  int coresight_add_in_conn(struct coresight_connection *conn);
> +struct coresight_device *
> +coresight_find_input_type(struct coresight_platform_data *pdata,
> +                         enum coresight_dev_type type,
> +                         union coresight_dev_subtype subtype);
> +struct coresight_device *
> +coresight_find_output_type(struct coresight_platform_data *pdata,
> +                          enum coresight_dev_type type,
> +                          union coresight_dev_subtype subtype);
>
>  #endif         /* _LINUX_COREISGHT_H */
> --
> 2.34.1
>

Reviewed-by: Mike Leach <mike.leach@linaro.org>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
