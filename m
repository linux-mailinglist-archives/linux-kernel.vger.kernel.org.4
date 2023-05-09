Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4566C6FC758
	for <lists+linux-kernel@lfdr.de>; Tue,  9 May 2023 15:01:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235155AbjEINBe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 9 May 2023 09:01:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35906 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231544AbjEINBb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 May 2023 09:01:31 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4271135A9
        for <linux-kernel@vger.kernel.org>; Tue,  9 May 2023 06:01:30 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-ba1911d60f5so8843956276.2
        for <linux-kernel@vger.kernel.org>; Tue, 09 May 2023 06:01:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683637289; x=1686229289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=y4BpEDlZK9m9CBXh2ISxknnux/s6zSVif+mGDRabek8=;
        b=sm9zSk1XP42BdUNlC8QdFfbYpQ8dGmsf0Luxb/dmpd3ddIepdPHIQwy8xfSzkiN6wt
         QFqYK7NKUUpCmDyJx/2zvDYoznjLDfq4aSVWjM860iY8CH0Q3lF7xBLbst+uH9qAml8m
         HJrreUm7nwP+CcdilLmNrCs0yNd9wnUHlJKG4lu+zhOqHnn71HaQ382KwBRB5gHK5FZR
         qQZ88foqm1nXaEbojn+D202kNTRyVlNA/BtBS5fhhd7kDxmM6krH6Z7rciYCdIk3JmFf
         IiSZga86hjmgFnmll3q3si2hBQtOzhceGlKG5XsWRM4Wuy7C/4kahuzj3XVKQShGXhDl
         WNXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683637289; x=1686229289;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=y4BpEDlZK9m9CBXh2ISxknnux/s6zSVif+mGDRabek8=;
        b=F95Qfg3aqDe68wBmDdl0Ie/TigGVWwRjgySFKaISr3FhaYUyK8ovlc2pRfWwc6lkLs
         5ct6nw43rbqOpF0H0Ir7AcIz298wybuasjS/zNT97epSYApXZcli8OEehwlh3f0mFg0a
         LhVBomaYYEGsOGmMcwzb81PZkJvSwo2JUQSWdcOUKNgxjnvVXmOmFcu/h6wYGEML3sdl
         LWzItWG2B+gsV6Q5DCIqhAa/IAOapTQv8/U1pu4u+NMLkgsVSPyWSmgxX+mUiczLUPTQ
         8sQ61vYSsv4ZXzTsCjM2KWBWPxWaKeAqZIG0MjkXBKYyH6BE1s5UZygu+f9oxDxh2rkv
         VGcQ==
X-Gm-Message-State: AC+VfDxq2W1uz2JNXDoNexuJeF2fUZ/RC29qTw+2odxeDhWKY/HNrdyf
        rJfmHpbszTRzPckVJLFHtMV311IbXXMv6G++DdDOnA==
X-Google-Smtp-Source: ACHHUZ5sAhwP6LQDqPNnwkyZIz/dkEQ2JaNjhO99KERRhkt54/p3SiebJMun57UU+rVsf+8V7TgXmJHOhsNCxLCxDI4=
X-Received: by 2002:a25:ac9d:0:b0:b9e:92e3:7ab5 with SMTP id
 x29-20020a25ac9d000000b00b9e92e37ab5mr14874209ybi.26.1683637289138; Tue, 09
 May 2023 06:01:29 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1683628357.git.quic_schowdhu@quicinc.com>
 <35863b47c04c2edd7ae49c57d23682aba6111d4f.1683628357.git.quic_schowdhu@quicinc.com>
 <CAA8EJppkqN6cuYUCC-THb8wb=deRv-01pbS0JgSGf-VXnm8qEg@mail.gmail.com> <82fcfc55-2879-2af0-5a91-4e9481d41976@quicinc.com>
In-Reply-To: <82fcfc55-2879-2af0-5a91-4e9481d41976@quicinc.com>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Tue, 9 May 2023 16:01:17 +0300
Message-ID: <CAA8EJprKumrq=Zy0gBqSZ9Dga5mZuauCC4U0GpTs0T4YADrSoA@mail.gmail.com>
Subject: Re: [PATCH V6 2/3] soc: qcom: boot_stat: Add Driver Support for Boot Stats
To:     Souradeep Chowdhury <quic_schowdhu@quicinc.com>
Cc:     Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        Sibi Sankar <quic_sibis@quicinc.com>,
        Rajendra Nayak <quic_rjendra@quicinc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 9 May 2023 at 15:27, Souradeep Chowdhury
<quic_schowdhu@quicinc.com> wrote:
>
>
>
> On 5/9/2023 5:09 PM, Dmitry Baryshkov wrote:
> > On Tue, 9 May 2023 at 13:53, Souradeep Chowdhury
> > <quic_schowdhu@quicinc.com> wrote:


> >> diff --git a/drivers/soc/qcom/boot_stats.c b/drivers/soc/qcom/boot_stats.c
> >> new file mode 100644
> >> index 000000000000..ca67b6b5d8eb
> >> --- /dev/null
> >> +++ b/drivers/soc/qcom/boot_stats.c
> >> @@ -0,0 +1,100 @@
> >> +// SPDX-License-Identifier: GPL-2.0-only
> >> +/*
> >> + * Copyright (c) 2013-2019, 2021 The Linux Foundation. All rights reserved.
> >> + * Copyright (c) 2023 Qualcomm Innovation Center, Inc. All rights reserved.
> >> + */
> >> +
> >> +#include <linux/debugfs.h>
> >> +#include <linux/err.h>
> >> +#include <linux/io.h>
> >> +#include <linux/init.h>
> >> +#include <linux/kernel.h>
> >> +#include <linux/module.h>
> >> +#include <linux/of.h>
> >> +#include <linux/of_address.h>
> >> +#include <linux/platform_device.h>
> >> +
> >> +#define TO_MS(timestamp) ((timestamp * 1000) / 32768)
> >
> > Quoting v4 question, which got no answer:
> >
> > Some of the platforms DTs define 32KHz clock instead of 32.768 KHz
> > What should be the divisor in this case?
>
> This is the standard divisor used to calculate the pre_abl and abl times
> across most QCOM SoCs. Can you give an example where the sleep_stat
> counter has a different frequency?

Following SoCs declare 37000 as sleep_clk frequency:
ipq6018, qdu1000, qru1000, sc7280, sm6125, sm6375, sm8350, sm8450, sm8550.

This might be an error in the dtsi, or might be not.

>
> >
> >> +
> >> +/**
> >> + *  struct boot_stats - timestamp information related to boot stats
> >> + *  @abl_start: Time for the starting point of the abl
> >> + *  @abl_end: Time when the kernel starts loading from abl
> >> + */
> >> +struct boot_stats {
> >> +       u32 abl_start;
> >> +       u32 abl_end;
> >> +} __packed;
> >> +
> >> +struct bs_data {
> >> +       struct boot_stats __iomem *b_stats;
> >> +       struct dentry *dbg_dir;
> >> +};
> >> +
> >> +static void populate_boot_stats(char *abl_str, char *pre_abl_str, struct bs_data *drvdata)
> >> +{
> >> +        u32 abl_time, pre_abl_time;
> >> +
> >> +        abl_time = TO_MS(drvdata->b_stats->abl_end) - TO_MS(drvdata->b_stats->abl_start);
> >> +        sprintf(abl_str, "%u ms", abl_time);
> >> +
> >> +        pre_abl_time =  TO_MS(drvdata->b_stats->abl_start);
> >> +        sprintf(pre_abl_str, "%u ms", pre_abl_time);
> >
> > Another point from v4:
> >
> > It would be better to move the unit to the file name and include just
> > the number.
>
> Clarified from your first comment
>
> >
> >> +}
> >> +
> >> +static int boot_stats_probe(struct platform_device *pdev)
> >> +{
> >> +       char abl_str[20], pre_abl_str[20], *abl, *pre_abl;
> >> +       struct device *bootstat_dev = &pdev->dev;
> >> +       struct bs_data *drvdata;
> >> +
> >> +       drvdata = devm_kzalloc(bootstat_dev, sizeof(*drvdata), GFP_KERNEL);
> >> +       if (!drvdata)
> >> +               return dev_err_probe(bootstat_dev, -ENOMEM, "failed to allocate memory");
> >> +       platform_set_drvdata(pdev, drvdata);
> >> +
> >> +       drvdata->b_stats = devm_of_iomap(bootstat_dev, bootstat_dev->of_node, 0, NULL);
> >> +       if (IS_ERR(drvdata->b_stats))
> >> +               return dev_err_probe(bootstat_dev, PTR_ERR(drvdata->b_stats),
> >> +                                    "failed to map imem region");
> >> +
> >> +       drvdata->dbg_dir = debugfs_create_dir("qcom_boot_stats", NULL);
> >> +       if (IS_ERR(drvdata->dbg_dir))
> >> +               return dev_err_probe(bootstat_dev, PTR_ERR(drvdata->dbg_dir),
> >> +                                    "failed to create debugfs directory");
> >> +
> >> +       populate_boot_stats(abl_str, pre_abl_str, drvdata);
> >> +       abl = abl_str;
> >> +       pre_abl = pre_abl_str;
> >> +
> >> +       debugfs_create_str("pre_abl_time", 0400, drvdata->dbg_dir, (char **)&pre_abl);
> >> +       debugfs_create_str("abl_time", 0400, drvdata->dbg_dir, (char **)&abl);
> >> +
> >> +       return 0;
> >> +}
> >> +
> >> +void boot_stats_remove(struct platform_device *pdev)
> >> +{
> >> +       struct bs_data *drvdata = platform_get_drvdata(pdev);
> >> +
> >> +       debugfs_remove_recursive(drvdata->dbg_dir);
> >> +}
> >> +
> >> +static const struct of_device_id boot_stats_dt_match[] = {
> >> +       { .compatible = "qcom,imem-bootstats" },
> >> +       { }
> >> +};
> >> +MODULE_DEVICE_TABLE(of, boot_stats_dt_match);
> >> +
> >> +static struct platform_driver boot_stat_driver = {
> >> +       .probe  = boot_stats_probe,
> >> +       .remove_new = boot_stats_remove,
> >> +       .driver = {
> >> +               .name = "qcom-boot-stats",
> >> +               .of_match_table = boot_stats_dt_match,
> >> +       },
> >> +};
> >> +module_platform_driver(boot_stat_driver);
> >> +
> >> +MODULE_DESCRIPTION("Qualcomm Technologies Inc. Boot Stat driver");
> >> +MODULE_LICENSE("GPL");
> >> --
> >> 2.17.1
> >>
> >
> >



-- 
With best wishes
Dmitry
