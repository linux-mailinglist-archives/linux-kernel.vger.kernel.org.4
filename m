Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 824BB6CA9BD
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:58:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjC0P6e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:58:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232474AbjC0P6b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:58:31 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 557F730ED
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:58:28 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id mp3-20020a17090b190300b0023fcc8ce113so12218782pjb.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Mar 2023 08:58:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1679932708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=l/D58uTxJlcuHcU4qWGtFCzED/+wV9SKtL9vHysDKM0=;
        b=wJ493kOCJ4Sc2eWNECvpPc/GLbdkaTn1C4D1NOCw/ndF805mZnhm1vnV/Xk+T4LK16
         uksSlSaKK8dIkSvU5zKbPgLM+0gaEmf9L0jQ1WYJrpP3ciJhAFi/ktEDitW5EuOR+6Ia
         ozwnKJhxiS6zp5YbMVcWvHdSdg8kbOLJb4TlTlWzNaL/lmZPrZMXpBi3X5m134tXpehM
         cs1XgYduF+HC3ie6D+EAZHJUoRXs60sSwoQufAuDVMo3XIGS9nclJ50Gbp4Z/4n670fr
         823ydWgRN4oPVXCrOAMShp3chdbPEfKWXf8AbC7IRj0+J++kSbMTaFNJtcuoVoCpwysP
         6O0A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679932708;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=l/D58uTxJlcuHcU4qWGtFCzED/+wV9SKtL9vHysDKM0=;
        b=bqN2nfI1+rVOnbn8AAFGS/RNG1uFyAvyaBWkiR75AmULxVbqZEYUMHthM80mdNG9KL
         grL46f3RZRirMQdY4VCzBnKz3jcdZoCrtxD3jgNWOoXbG7QUTJqNMcAlhUxZuWJnmmxp
         hVlGkT6wNpMsS2bU3QRqy8MBv/Jr1vYghzy2eHVk4Oj/u2XKLgK2sf4RW8PQZVukai0b
         Wc2XSBkJoDU/RpQlvfvckv/pWWpBKWEGP1k5hcmnkbMWDFuOkzFYIxCxtAjn+PPEBKre
         mEExvaUaaKYhPxtuNZvwIVdt38Eg5S0IuphHsg/32YdFdhgEEFjnVu1FeyXf2OoT3oE5
         /F8g==
X-Gm-Message-State: AAQBX9dXBumnJKBKyKbJZ2yC3hw8HmoFlwV/zbkTWaUVLY3Hqks4gIU+
        KqCCPzyeUzG45T+GsOEZBrp9owAZ3uj2mWpVaEtQoA==
X-Google-Smtp-Source: AKy350YaQzK3TF63oVqDQouwPxKz3giaJiH60VCPzrZvy559rdh+r9L/QkO+wydgK87V0ypGMgljfpdUffAqKw++FIM=
X-Received: by 2002:a17:90a:de93:b0:237:9ca5:4d5d with SMTP id
 n19-20020a17090ade9300b002379ca54d5dmr3734689pjv.6.1679932707746; Mon, 27 Mar
 2023 08:58:27 -0700 (PDT)
MIME-Version: 1.0
References: <20230324061608.33609-1-quic_hazha@quicinc.com> <20230324061608.33609-2-quic_hazha@quicinc.com>
In-Reply-To: <20230324061608.33609-2-quic_hazha@quicinc.com>
From:   Mike Leach <mike.leach@linaro.org>
Date:   Mon, 27 Mar 2023 16:58:16 +0100
Message-ID: <CAJ9a7VgAJ25CCGwwdfs2DXKaKYoA-BUQAdyZt5udm4qJf9ZQrA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] Coresight: Add coresight dummy driver
To:     Hao Zhang <quic_hazha@quicinc.com>
Cc:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
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

On Fri, 24 Mar 2023 at 06:16, Hao Zhang <quic_hazha@quicinc.com> wrote:
>
> Some Coresight devices that HLOS don't have permission to access
> or configure. Such as Coresight sink EUD, some TPDMs etc. So there
> need driver to register dummy devices as Coresight devices. Provide
> Coresight API for dummy device operations, such as enabling and
> disabling dummy devices. Build the Coresight path for dummy sink or
> dummy source for debugging.
>
> Signed-off-by: Hao Zhang <quic_hazha@quicinc.com>
> ---
>  drivers/hwtracing/coresight/Kconfig           |  11 ++
>  drivers/hwtracing/coresight/Makefile          |   1 +
>  drivers/hwtracing/coresight/coresight-dummy.c | 176 ++++++++++++++++++
>  3 files changed, 188 insertions(+)
>  create mode 100644 drivers/hwtracing/coresight/coresight-dummy.c
>
> diff --git a/drivers/hwtracing/coresight/Kconfig b/drivers/hwtracing/coresight/Kconfig
> index 2b5bbfffbc4f..06f0a7594169 100644
> --- a/drivers/hwtracing/coresight/Kconfig
> +++ b/drivers/hwtracing/coresight/Kconfig
> @@ -236,4 +236,15 @@ config CORESIGHT_TPDA
>
>           To compile this driver as a module, choose M here: the module will be
>           called coresight-tpda.
> +
> +config CORESIGHT_DUMMY
> +       tristate "Dummy driver support"
> +       help
> +         Enables support for dummy driver. Dummy driver can be used for
> +         CoreSight sources/sinks that are owned and configured by some
> +         other subsystem and use Linux drivers to configure rest of trace
> +         path.
> +
> +         To compile this driver as a module, choose M here: the module will be
> +         called coresight-dummy.
>  endif
> diff --git a/drivers/hwtracing/coresight/Makefile b/drivers/hwtracing/coresight/Makefile
> index 33bcc3f7b8ae..995d3b2c76df 100644
> --- a/drivers/hwtracing/coresight/Makefile
> +++ b/drivers/hwtracing/coresight/Makefile
> @@ -30,3 +30,4 @@ obj-$(CONFIG_CORESIGHT_TPDA) += coresight-tpda.o
>  coresight-cti-y := coresight-cti-core.o        coresight-cti-platform.o \
>                    coresight-cti-sysfs.o
>  obj-$(CONFIG_ULTRASOC_SMB) += ultrasoc-smb.o
> +obj-$(CONFIG_CORESIGHT_DUMMY) += coresight-dummy.o
> diff --git a/drivers/hwtracing/coresight/coresight-dummy.c b/drivers/hwtracing/coresight/coresight-dummy.c
> new file mode 100644
> index 000000000000..2d4eb3e546eb
> --- /dev/null
> +++ b/drivers/hwtracing/coresight/coresight-dummy.c
> @@ -0,0 +1,176 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/module.h>
> +#include <linux/platform_device.h>
> +#include <linux/coresight.h>
> +#include <linux/of.h>
> +#include <linux/pm_runtime.h>
> +
> +#include "coresight-priv.h"
> +#include "coresight-trace-id.h"
> +
> +struct dummy_drvdata {
> +       struct device                   *dev;
> +       struct coresight_device         *csdev;
> +       int                             traceid;
> +};
> +
> +DEFINE_CORESIGHT_DEVLIST(dummy_devs, "dummy");
> +
> +static int dummy_source_enable(struct coresight_device *csdev,
> +                              struct perf_event *event, u32 mode)
> +{
> +       struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +       dev_info(drvdata->dev, "Dummy source enabled\n");
> +
> +       return 0;
> +}
> +
> +static void dummy_source_disable(struct coresight_device *csdev,
> +                                struct perf_event *event)
> +{
> +       struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +       dev_info(drvdata->dev, "Dummy source disabled\n");
> +}
> +
> +static int dummy_sink_enable(struct coresight_device *csdev, u32 mode,
> +                               void *data)
> +{
> +       struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +       dev_info(drvdata->dev, "Dummy sink enabled\n");
> +
> +       return 0;
> +}
> +
> +static int dummy_sink_disable(struct coresight_device *csdev)
> +{
> +       struct dummy_drvdata *drvdata = dev_get_drvdata(csdev->dev.parent);
> +
> +       dev_info(drvdata->dev, "Dummy sink disabled\n");
> +
> +       return 0;
> +}
> +
> +static const struct coresight_ops_source dummy_source_ops = {
> +       .enable         = dummy_source_enable,
> +       .disable        = dummy_source_disable,
> +};
> +
> +static const struct coresight_ops_sink dummy_sink_ops = {
> +       .enable         = dummy_sink_enable,
> +       .disable        = dummy_sink_disable,
> +};
> +
> +static const struct coresight_ops dummy_cs_ops = {
> +       .source_ops     = &dummy_source_ops,
> +       .sink_ops       = &dummy_sink_ops,
> +};
> +
> +static int dummy_probe(struct platform_device *pdev)
> +{
> +       int ret, trace_id;
> +       struct device *dev = &pdev->dev;
> +       struct coresight_platform_data *pdata;
> +       struct dummy_drvdata *drvdata;
> +       struct coresight_desc desc = { 0 };
> +
> +       desc.name = coresight_alloc_device_name(&dummy_devs, dev);
> +       if (!desc.name)
> +               return -ENOMEM;
> +
> +       pdata = coresight_get_platform_data(dev);
> +       if (IS_ERR(pdata))
> +               return PTR_ERR(pdata);
> +       pdev->dev.platform_data = pdata;
> +
> +       drvdata = devm_kzalloc(dev, sizeof(*drvdata), GFP_KERNEL);
> +       if (!drvdata)
> +               return -ENOMEM;
> +
> +       drvdata->dev = &pdev->dev;
> +       platform_set_drvdata(pdev, drvdata);
> +
> +       if (of_property_read_bool(pdev->dev.of_node, "qcom,dummy-source")) {
> +               desc.type = CORESIGHT_DEV_TYPE_SOURCE;
> +               desc.subtype.source_subtype =
> +                                       CORESIGHT_DEV_SUBTYPE_SOURCE_OTHERS;
> +       } else if (of_property_read_bool(pdev->dev.of_node,
> +                                        "qcom,dummy-sink")) {
> +               desc.type = CORESIGHT_DEV_TYPE_SINK;
> +               desc.subtype.sink_subtype = CORESIGHT_DEV_SUBTYPE_SINK_BUFFER;

This will break the automatic sink selection on a system where perf is
looking for a default sink and the dummy sink is closest  / first
discovered.

i.e. when perf record -e cs_etm// <options>
is used to trace a program in linux, a dummy sink appearing in the
coresight tree with this designation may be selected.

This needs to be corrected, probably with a unique sub-type that
appears before the CORESIGHT_DEV_SUBTYPE_SINK_BUFFER value in the enum
as the selection is based on >= CORESIGHT_DEV_SUBTYPE_SINK_BUFFER.

By implication adding a new value - will possibly affect other code
using the enum values so will need to be checked

Regards

Mike



> +       } else {
> +               dev_info(dev, "Device type not set\n");
> +               return -EINVAL;
> +       }
> +
> +       desc.ops = &dummy_cs_ops;
> +       desc.pdata = pdev->dev.platform_data;
> +       desc.dev = &pdev->dev;
> +       drvdata->csdev = coresight_register(&desc);
> +       if (IS_ERR(drvdata->csdev))
> +               return PTR_ERR(drvdata->csdev);
> +
> +       trace_id = coresight_trace_id_get_system_id();
> +       if (trace_id < 0) {
> +               ret = trace_id;
> +               goto cs_unregister;
> +       }
> +       drvdata->traceid = (u8)trace_id;
> +
> +       pm_runtime_enable(dev);
> +       dev_info(dev, "Dummy device initialized\n");
> +
> +       return 0;
> +
> +cs_unregister:
> +       coresight_unregister(drvdata->csdev);
> +
> +       return ret;
> +}
> +
> +static int dummy_remove(struct platform_device *pdev)
> +{
> +       struct dummy_drvdata *drvdata = platform_get_drvdata(pdev);
> +       struct device *dev = &pdev->dev;
> +
> +       coresight_trace_id_put_system_id(drvdata->traceid);
> +       pm_runtime_disable(dev);
> +       coresight_unregister(drvdata->csdev);
> +       return 0;
> +}
> +
> +static const struct of_device_id dummy_match[] = {
> +       {.compatible = "qcom,coresight-dummy"},
> +       {},
> +};
> +
> +static struct platform_driver dummy_driver = {
> +       .probe  = dummy_probe,
> +       .remove = dummy_remove,
> +       .driver = {
> +               .name   = "coresight-dummy",
> +               .of_match_table = dummy_match,
> +       },
> +};
> +
> +static int __init dummy_init(void)
> +{
> +       return platform_driver_register(&dummy_driver);
> +}
> +module_init(dummy_init);
> +
> +static void __exit dummy_exit(void)
> +{
> +       platform_driver_unregister(&dummy_driver);
> +}
> +module_exit(dummy_exit);
> +
> +MODULE_LICENSE("GPL");
> +MODULE_DESCRIPTION("CoreSight dummy source driver");
> --
> 2.17.1
>


-- 
Mike Leach
Principal Engineer, ARM Ltd.
Manchester Design Centre. UK
