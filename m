Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D04726A9F49
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 19:40:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231846AbjCCSkW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 13:40:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232023AbjCCSjz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 13:39:55 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E09F5A6DF;
        Fri,  3 Mar 2023 10:39:07 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id fd25so2187085pfb.1;
        Fri, 03 Mar 2023 10:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677868735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=KW5zlYPdh4KEZGnqXGymEZlZPZq2XOWrLglIoL3yYbM=;
        b=NeSjzgAVcH618mykrKytTLTjNl+tmOdpa2naPP9um9V7H6W8FQTp/PoOzLPQ49UaRz
         lLRb7Ei69pi2ttA1cpJMHunqc7/xtIxoTSCwBvtpRrBpw7lPYVsUa4Wm5TjHaoM5j7Vl
         MCBEOvaNqPljFvYd+RlcEdKAGTnFqCak4MfIB6fx7a+xwsl0A4Oli6Fj3EB8lePCRZqz
         KXs4C5Ci57j335oVTtHKMcxAMzMSOacoHIC9KAYBoWVHuDcjEHTUfZUf0GDUuJ5oPjwK
         HMgvJN/cfRGDPxhyhZd1eWOj3P7VV34o613c69jHkTJc4SLJise+aT7n1MBqBxqlBGH9
         DCwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677868735;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=KW5zlYPdh4KEZGnqXGymEZlZPZq2XOWrLglIoL3yYbM=;
        b=hgAmjzTqq37iG2vudO3VCX4chq1XYrBMc4k3iknhhKQv8AqOf3IGW0kmKv5Ipd/Hhv
         Y/9x63zVgAS+TVwYV5rOeIa858egGFWkQWperA8llp1nwtnJ1/s2OhFaDGqQ/jdVmV9c
         BpiV+yFdn0tYicr55oS4xxO/0/ii80MiYYvwl8CxtxfakfyA/qQXZ3WVGiiobeGI/NI3
         Z2nTApPju41ZjibwEYbYT2EK4DdWBzMKhkhlhDI/DCDU8+eoPB6//zqxcSx7yjy+bqOn
         4ka4XfCC576oyGkYZqHpZWnXOGs9SEI21hWEbE+lz8UDQyvfuciYKt1TCRIpgIM00jTu
         16Nw==
X-Gm-Message-State: AO0yUKV7m2U9ZG+vBZ9ILmoARS6Hqv0l7MjkzmR4pZY3TtTbjzwFB4s7
        kROASSzOzKSVZsBvAalYndB8T3NHgG6e+31EnBA=
X-Google-Smtp-Source: AK7set/hfR9Rcii36vKUJ5TL+U7hSRvp4CpKJDa6gvrZVAf+H0DuOQMNvIe5RszSZ05x7/BNECSknxdDDFn0nfZB81E=
X-Received: by 2002:a63:9845:0:b0:503:8257:1cf0 with SMTP id
 l5-20020a639845000000b0050382571cf0mr816437pgo.11.1677868734579; Fri, 03 Mar
 2023 10:38:54 -0800 (PST)
MIME-Version: 1.0
References: <20230121112947.53433-1-robimarko@gmail.com> <20230121112947.53433-4-robimarko@gmail.com>
 <d71e8a18-8a09-c722-d9dd-b2d48615828f@linaro.org> <CAA8EJppwNVtUjB7fUZSCrZ88Ssbhmc4HD6oA2nV0uEx+vHBXUw@mail.gmail.com>
 <2a7a43f1-a13d-f094-5167-de74d5092d91@linaro.org>
In-Reply-To: <2a7a43f1-a13d-f094-5167-de74d5092d91@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Fri, 3 Mar 2023 19:38:43 +0100
Message-ID: <CAOX2RU6vociXPTQE4tegQE8YXjHgQAHgdQWm3N9PPekgaw3ung@mail.gmail.com>
Subject: Re: [PATCH 4/4] cpufreq: qcom-nvmem: make qcom_cpufreq_get_msm_id()
 return the SoC ID
To:     Konrad Dybcio <konrad.dybcio@linaro.org>
Cc:     Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        ilia.lin@kernel.org, agross@kernel.org, andersson@kernel.org,
        rafael@kernel.org, viresh.kumar@linaro.org,
        linux-kernel@vger.kernel.org, linux-pm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org
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

On Sat, 18 Feb 2023 at 21:40, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 18.02.2023 21:36, Dmitry Baryshkov wrote:
> > On Sat, 18 Feb 2023 at 16:43, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>
> >>
> >>
> >> On 21.01.2023 12:29, Robert Marko wrote:
> >>> Currently, qcom_cpufreq_get_msm_id() does not simply return the SoC ID
> >>> after getting it via SMEM call but instead uses an enum to encode the
> >>> matched SMEM ID to 2 variants of MSM8996 which are then used in
> >>> qcom_cpufreq_kryo_name_version() to set the supported version.
> >>>
> >>> This prevents qcom_cpufreq_get_msm_id() from being universal and its doing
> >>> more than its name suggests, so lets make it just return the SoC ID
> >>> directly which allows matching directly on the SoC ID and removes the need
> >>> for msm8996_version enum which simplifies the driver.
> >>> It also allows reusing the qcom_cpufreq_get_msm_id() for new SoC-s.
> >>>
> >>> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >>> ---
> >>>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 44 ++++++++--------------------
> >>>  1 file changed, 12 insertions(+), 32 deletions(-)
> >>>
> >>> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> >>> index da55d2e1925a..9deaf9521d6d 100644
> >>> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> >>> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> >>> @@ -32,12 +32,6 @@
> >>>
> >>>  #include <dt-bindings/arm/qcom,ids.h>
> >>>
> >>> -enum _msm8996_version {
> >>> -     MSM8996_V3,
> >>> -     MSM8996_SG,
> >>> -     NUM_OF_MSM8996_VERSIONS,
> >>> -};
> >>> -
> >>>  struct qcom_cpufreq_drv;
> >>>
> >>>  struct qcom_cpufreq_match_data {
> >>> @@ -134,30 +128,16 @@ static void get_krait_bin_format_b(struct device *cpu_dev,
> >>>       dev_dbg(cpu_dev, "PVS version: %d\n", *pvs_ver);
> >>>  }
> >>>
> >>> -static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
> >>> +static int qcom_cpufreq_get_msm_id(void)
> >> This should be u32 as info->id is __le32

Nice catch.


> >>
> >> And please export this function from socinfo, it'll come in
> >> useful for other drivers!

I intentionally did not do that as socinfo is currently fully optional
and I dont really like
the idea of making it required for anything using SMEM.

Regards,
Robert

>
> Konrad
> >
