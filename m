Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 472AD6CBBEC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 12:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232988AbjC1KHD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 06:07:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229611AbjC1KGx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 06:06:53 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902A865B9
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:06:33 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id s8so7604425pfk.5
        for <linux-kernel@vger.kernel.org>; Tue, 28 Mar 2023 03:06:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679997993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=qiA6wsSxwC1GRa63Z1d4DCGWvof/U0m3XxEtySo8Du8=;
        b=FYL6dSL8wdZjdUuV2I+gx7GnuxYvNLEj3xSjpXH65FY1HbI/YtzJ5uPPcoKcEZWpLk
         igEobR0gFBjdmj71lstkw/e5b8LTPwMmS11xFbMH/XCYuPyvmR+Kp6Brhx9gq6VKO69h
         Xl9uA0kgtBtABfzc9MgDnMckfJJbZkIrtPgFOJccPwdfI+JDxEBOvzPn1sulVPrhrm9m
         5tQ4t3cUmwdD9+/1G+6xxkTxGQm5LA1gHxewyDZ01G6kIHLBnqHYscDVIq//x1pOIplr
         R26uURZe9XFNkfK806QQPBfYElSlArLZOwrKI5weg3uxfDxWcVEFlPEIcF3YvC8F00bQ
         7rXg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679997993;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=qiA6wsSxwC1GRa63Z1d4DCGWvof/U0m3XxEtySo8Du8=;
        b=2nJF7LQE7Q4WfKQxFHNlfCGC3YUrwY5XDHTcCEXO9e2MPocqu3r16xDg7Z2mVnU36S
         cDDeXgtMwCZAQOFYXzYpl/MmF6UkZQWEX5vBdjxZHhUeeFl5u6L/U3K/I3d8puDusXjJ
         6eykBhzXaJOOElHB/gtpS2VZ/Kl9M+KV0YU0AUegnaZy3Si0rB5t/xMVbPr+gKmM2Pfg
         5fFMtCdb1rDTm7Xd87NdMiBLvGwd7F6fZFIaiRKVCF0BxrhgiRmEYb/BBxFp4x2Xl8AN
         t6ogI9x9kw7hTrDILUVbZPlD1XrKsP7NRGD6N5bdvV1BF8AfO1Zlgu/CTbvPGm0AJLZ+
         RjLQ==
X-Gm-Message-State: AAQBX9d4fL8Zh4OItIfwEx/2u1cq9SbNT86daMW0+SSdcz5PU8C1H5kH
        oIE786Vd+GSfsrxVmuLbmw44VeoJlWNPIfWeHi+/5A==
X-Google-Smtp-Source: AKy350Y7KgmZWYQwiF20Van+UKKpbS7BTkh6RSynzVmd7hL3j6DjIBJ3Up79H2JZThT6onRSBAxNh2fvDSxjhv2HKt4=
X-Received: by 2002:a63:f04c:0:b0:503:919f:b942 with SMTP id
 s12-20020a63f04c000000b00503919fb942mr3833216pgj.11.1679997992978; Tue, 28
 Mar 2023 03:06:32 -0700 (PDT)
MIME-Version: 1.0
References: <20230324061608.33609-1-quic_hazha@quicinc.com>
 <20230324061608.33609-2-quic_hazha@quicinc.com> <CAJ9a7VgAJ25CCGwwdfs2DXKaKYoA-BUQAdyZt5udm4qJf9ZQrA@mail.gmail.com>
 <0faff427-1f01-8783-9585-32dca872fe45@quicinc.com> <883c72a4-0c72-fd08-1b04-577037138b43@arm.com>
 <9fcc59cf-c76e-8cee-d232-830b31e35060@quicinc.com>
In-Reply-To: <9fcc59cf-c76e-8cee-d232-830b31e35060@quicinc.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Tue, 28 Mar 2023 11:06:21 +0100
Message-ID: <CAJ9a7Vj7L1wbc2iad-Tbf+2d_t5z-GpN7WEff0_FupVZVRNymA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Coresight: Add coresight dummy driver
To:     Hao Zhang <quic_hazha@quicinc.com>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Konrad Dybcio <konradybcio@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Jonathan Corbet <corbet@lwn.net>, Leo Yan <leo.yan@linaro.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Tingwei Zhang <quic_tingweiz@quicinc.com>,
        Jinlong Mao <quic_jinlmao@quicinc.com>,
        Yuanfang Zhang <quic_yuanfang@quicinc.com>,
        Tao Zhang <quic_taozha@quicinc.com>,
        Trilok Soni <quic_tsoni@quicinc.com>,
        linux-arm-msm@vger.kernel.org,
        Bjorn Andersson <andersson@kernel.org>,
        linux-doc@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

A few additional comments....

On Tue, 28 Mar 2023 at 10:24, Hao Zhang <quic_hazha@quicinc.com> wrote:
>
> Hi Suzuki,
>
> On 3/28/2023 4:35 PM, Suzuki K Poulose wrote:
> > On 28/03/2023 08:22, Hao Zhang wrote:
> >> Hi Mike,
> >>
> >> On 3/27/2023 11:58 PM, Mike Leach wrote:
> >>> Hi,
> >>>
> >>> On Fri, 24 Mar 2023 at 06:16, Hao Zhang <quic_hazha@quicinc.com> wrote:
> >>>>
> >>>> Some Coresight devices that HLOS don't have permission to access
> >>>> or configure. Such as Coresight sink EUD, some TPDMs etc. So there
> >>>> need driver to register dummy devices as Coresight devices. Provide
> >>>> Coresight API for dummy device operations, such as enabling and
> >>>> disabling dummy devices. Build the Coresight path for dummy sink or
> >>>> dummy source for debugging.
> >>>>
> >>>> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
> >>>> ---
> >>>>   drivers/hwtracing/coresight/Kconfig           |  11 ++
> >>>>   drivers/hwtracing/coresight/Makefile          |   1 +
> >>>>   drivers/hwtracing/coresight/coresight-dummy.c | 176
> >>>> ++++++++++++++++++
> >>>>   3 files changed, 188 insertions(+)
> >>>>   create mode 100644 drivers/hwtracing/coresight/coresight-dummy.c
> >>>>
> >>>> diff --git a/drivers/hwtracing/coresight/Kconfig
> >>>> b/drivers/hwtracing/coresight/Kconfig
> >>>> index 2b5bbfffbc4f..06f0a7594169 100644
> >>>> --- a/drivers/hwtracing/coresight/Kconfig
> >>>> +++ b/drivers/hwtracing/coresight/Kconfig
> >>>> @@ -236,4 +236,15 @@ config CORESIGHT_TPDA
> >>>>
> >>>>            To compile this driver as a module, choose M here: the
> >>>> module will be
> >>>>            called coresight-tpda.
> >>>> +
> >>>> +config CORESIGHT_DUMMY
> >>>> +       tristate "Dummy driver support"
> >>>> +       help
> >>>> +         Enables support for dummy driver. Dummy driver can be used
> >>>> for
> >>>> +         CoreSight sources/sinks that are owned and configured by some
> >>>> +         other subsystem and use Linux drivers to configure rest of
> >>>> trace
> >>>> +         path.
> >>>> +
> >>>> +         To compile this driver as a module, choose M here: the
> >>>> module will be
> >>>> +         called coresight-dummy.
> >>>>   endif
> >>>> diff --git a/drivers/hwtracing/coresight/Makefile
> >>>> b/drivers/hwtracing/coresight/Makefile
> >>>> index 33bcc3f7b8ae..995d3b2c76df 100644
> >>>> --- a/drivers/hwtracing/coresight/Makefile
> >>>> +++ b/drivers/hwtracing/coresight/Makefile
> >>>> @@ -30,3 +30,4 @@ obj-$(CONFIG_CORESIGHT_TPDA) += coresight-tpda.o
> >>>>   coresight-cti-y := coresight-cti-core.o coresight-cti-platform.o \
> >>>>                     coresight-cti-sysfs.o
> >>>>   obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
> >>>> +obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
> >>>> diff --git a/drivers/hwtracing/coresight/coresight-dummy.c
> >>>> b/drivers/hwtracing/coresight/coresight-dummy.c
> >>>> new file mode 100644
> >>>> index 000000000000..2d4eb3e546eb
> >>>> --- /dev/null
> >>>> +++ b/drivers/hwtracing/coresight/coresight-dummy.c
> >>>> @@ -0,0 +1,176 @@
> >>>> +// SPDX-License-Identifier: GPL-2.0
> >>>> +/*
> >>>> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights
> >>>> reserved.
> >>>> + */
> >>>> +
> >>>> +#include <linux/kernel.h>
> >>>> +#include <linux/module.h>
> >>>> +#include <linux/platform_device.h>
> >>>> +#include <linux/coresight.h>
> >>>> +#include <linux/of.h>
> >>>> +#include <linux/pm_runtime.h>
> >>>> +
> >>>> +#include "coresight-priv.h"
> >>>> +#include "coresight-trace-id.h"
> >>>> +
> >>>> +struct dummy_drvdata {
> >>>> +       struct device                   *dev;
> >>>> +       struct coresight_device         *csdev;
> >>>> +       int                             traceid;
> >>>> +};
> >>>> +
> >>>> +DEFINE_CORESIGHT_DEVLIST(dummy_devs, "dummy");
> >>>> +

minor nit: can we have dummy_source and dummy_sink as the device names
to make it clear at the first level what these are without having to
look at the attributes?

> >>>> +static int dummy_source_enable(struct coresight_device *csdev,
> >>>> +                              struct perf_event *event, u32 mode)
> >>>> +{
> >>>> +       struct dummy_drvdata *drvdata =
> >>>> dev_get_drvdata(csdev->dev.parent);
> >>>> +
> >>>> +       dev_info(drvdata->dev, "Dummy source enabled\n");
> >>>> +
> >>>> +       return 0;
> >>>> +}
> >>>> +
> >>>> +static void dummy_source_disable(struct coresight_device *csdev,
> >>>> +                                struct perf_event *event)
> >>>> +{
> >>>> +       struct dummy_drvdata *drvdata =
> >>>> dev_get_drvdata(csdev->dev.parent);
> >>>> +
> >>>> +       dev_info(drvdata->dev, "Dummy source disabled\n");
> >>>> +}
> >>>> +
> >>>> +static int dummy_sink_enable(struct coresight_device *csdev, u32 mode,
> >>>> +                               void *data)
> >>>> +{
> >>>> +       struct dummy_drvdata *drvdata =
> >>>> dev_get_drvdata(csdev->dev.parent);
> >>>> +
> >>>> +       dev_info(drvdata->dev, "Dummy sink enabled\n");
> >>>> +
> >>>> +       return 0;
> >>>> +}
> >>>> +
> >>>> +static int dummy_sink_disable(struct coresight_device *csdev)
> >>>> +{
> >>>> +       struct dummy_drvdata *drvdata =
> >>>> dev_get_drvdata(csdev->dev.parent);
> >>>> +
> >>>> +       dev_info(drvdata->dev, "Dummy sink disabled\n");
> >>>> +
> >>>> +       return 0;
> >>>> +}
> >>>> +
> >>>> +static const struct coresight_ops_source dummy_source_ops = {
> >>>> +       .enable         = dummy_source_enable,
> >>>> +       .disable        = dummy_source_disable,
> >>>> +};
> >>>> +
> >>>> +static const struct coresight_ops_sink dummy_sink_ops = {
> >>>> +       .enable         = dummy_sink_enable,
> >>>> +       .disable        = dummy_sink_disable,
> >>>> +};
> >>>> +
> >>>> +static const struct coresight_ops dummy_cs_ops = {
> >>>> +       .source_ops     = &dummy_source_ops,
> >>>> +       .sink_ops       = &dummy_sink_ops,
> >>>> +};
> >>>> +
> >>>> +static int dummy_probe(struct platform_device *pdev)
> >>>> +{
> >>>> +       int ret, trace_id;
> >>>> +       struct device *dev = &pdev->dev;
> >>>> +       struct coresight_platform_data *pdata;
> >>>> +       struct dummy_drvdata *drvdata;
> >>>> +       struct coresight_desc desc = { 0 };
> >>>> +
> >>>> +       desc.name = coresight_alloc_device_name(&dummy_devs, dev);
> >>>> +       if (!desc.name)
> >>>> +               return -ENOMEM;
> >>>> +
> >>>> +       pdata = coresight_get_platform_data(dev);
> >>>> +       if (IS_ERR(pdata))
> >>>> +               return PTR_ERR(pdata);
> >>>> +       pdev->dev.platform_data = pdata;
> >>>> +
> >>>> +       drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> >>>> +       if (!drvdata)
> >>>> +               return -ENOMEM;
> >>>> +
> >>>> +       drvdata->dev = &pdev->dev;
> >>>> +       platform_set_drvdata(pdev, drvdata);
> >>>> +
> >>>> +       if (of_property_read_bool(pdev->dev.of_node,
> >>>> "qcom,dummy-source")) {
> >>>> +               desc.type = CORESIGHT_DEV_TYPE_SOURCE;
> >>>> +               desc.subtype.source_subtype =
> >>>> + CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS;
> >>>> +       } else if (of_property_read_bool(pdev->dev.of_node,
> >>>> +                                        "qcom,dummy-sink")) {

It would simplify things if the compatibles were
arm,coresight-dummy-source and arm,coresight-dummy-sink - and drop the
two additional attributes, using of_device_is_compatible() here.

> >>>> +               desc.type = CORESIGHT_DEV_TYPE_SINK;
> >>>> +               desc.subtype.sink_subtype =
> >>>> CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;
> >>>
> >>> This will break the automatic sink selection on a system where perf is
> >>> looking for a default sink and the dummy sink is closest  / first
> >>> discovered.
> >>>
> >>> i.e. when perf record -e cs_etm// <options>
> >>> is used to trace a program in linux, a dummy sink appearing in the
> >>> coresight tree with this designation may be selected.
> >>>
> >>> This needs to be corrected, probably with a unique sub-type that
> >>> appears before the CORESIGHT_DEV_SUBTYPE_SINK_BUFFER value in the enum
> >>> as the selection is based on >= CORESIGHT_DEV_SUBTYPE_SINK_BUFFER.
> >>>
> >
> > Good point Mike.
> >
> >>> By implication adding a new value - will possibly affect other code
> >>> using the enum values so will need to be checked
> >>>
> >>> Regards
> >>>
> >>> Mike
> >>>
> >>
> >> Thanks for your comments, I will add a new sub-type for dummy sink and
> >> check the impact of it.
> >
> > Please keep this as the lowest priority, something like:
> >
> >   enum coresight_dev_subtype_sink {
> > +    CORESIGHT_DEV_SUBTYPE_SINK_DUMMY,
> >          CORESIGHT_DEV_SUBTYPE_SINK_PORT,
> >          CORESIGHT_DEV_SUBTYPE_SINK_BUFFER,
> >          CORESIGHT_DEV_SUBTYPE_SINK_SYSMEM,
> >          CORESIGHT_DEV_SUBTYPE_SINK_PERCPU_SYSMEM,
> > };
> >
> > This should be fine without any impact on the existing code, as we
> > expect the driver modules to be updated with the new core module.
> >
> > Suzuki
> >
>
> Sure, I will take your advice in the next version of patch.
>
> Thanks,
> Hao
>
> >
> >>
> >> Thanks,
> >> Hao
> >>
> >>>
> >>>> +       } else {
> >>>> +               dev_info(dev, "Device type not set\n");
> >>>> +               return -EINVAL;
> >>>> +       }
> >>>> +
> >>>> +       desc.ops = &dummy_cs_ops;
> >>>> +       desc.pdata = pdev->dev.platform_data;
> >>>> +       desc.dev = &pdev->dev;
> >>>> +       drvdata->csdev = coresight_register(&desc);
> >>>> +       if (IS_ERR(drvdata->csdev))
> >>>> +               return PTR_ERR(drvdata->csdev);
> >>>> +
> >>>> +       trace_id = coresight_trace_id_get_system_id();
> >>>> +       if (trace_id < 0) {
> >>>> +               ret = trace_id;
> >>>> +               goto cs_unregister;
> >>>> +       }
> >>>> +       drvdata->traceid = (u8)trace_id;
> >>>> +

Number of issues here:-
1) Why are sinks being given a trace ID? - they do not need them.
2) how is the trace ID communicated to the underlying hardware system?
- there appears to be no way of doing this here. Without this you
cannot guarantee that there will not be clashes.
Although your use case may mitigate against this - for this to be a
generic module there must be a way to ensure the IDs can be discovered
externally.
3) Trace IDs are a limited resource - most sources allocate on enable,
release on disable  / reset - this would be preferable.


Regards

Mike

> >>>> +       pm_runtime_enable(dev);
> >>>> +       dev_info(dev, "Dummy device initialized\n");
> >>>> +
> >>>> +       return 0;
> >>>> +
> >>>> +cs_unregister:
> >>>> +       coresight_unregister(drvdata->csdev);
> >>>> +
> >>>> +       return ret;
> >>>> +}
> >>>> +
> >>>> +static int dummy_remove(struct platform_device *pdev)
> >>>> +{
> >>>> +       struct dummy_drvdata *drvdata = platform_get_drvdata(pdev);
> >>>> +       struct device *dev = &pdev->dev;
> >>>> +
> >>>> +       coresight_trace_id_put_system_id(drvdata->traceid);
> >>>> +       pm_runtime_disable(dev);
> >>>> +       coresight_unregister(drvdata->csdev);
> >>>> +       return 0;
> >>>> +}
> >>>> +
> >>>> +static const struct of_device_id dummy_match[] = {
> >>>> +       {.compatible = "qcom,coresight-dummy"},
> >>>> +       {},
> >>>> +};
> >>>> +
> >>>> +static struct platform_driver dummy_driver = {
> >>>> +       .probe  = dummy_probe,
> >>>> +       .remove = dummy_remove,
> >>>> +       .driver = {
> >>>> +               .name   = "coresight-dummy",
> >>>> +               .of_match_table = dummy_match,
> >>>> +       },
> >>>> +};
> >>>> +
> >>>> +static int __init dummy_init(void)
> >>>> +{
> >>>> +       return platform_driver_register(&dummy_driver);
> >>>> +}
> >>>> +module_init(dummy_init);
> >>>> +
> >>>> +static void __exit dummy_exit(void)
> >>>> +{
> >>>> +       platform_driver_unregister(&dummy_driver);
> >>>> +}
> >>>> +module_exit(dummy_exit);
> >>>> +
> >>>> +MODULE_LICENSE("GPL");
> >>>> +MODULE_DESCRIPTION("CoreSight dummy source driver");
> >>>> --
> >>>> 2.17.1
> >>>>
> >>>
> >>>
> >



-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
