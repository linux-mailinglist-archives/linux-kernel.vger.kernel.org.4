Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BBD796AA184
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Mar 2023 22:39:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231929AbjCCVjE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Mar 2023 16:39:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231793AbjCCVjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Mar 2023 16:39:01 -0500
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E90734230;
        Fri,  3 Mar 2023 13:38:52 -0800 (PST)
Received: by mail-pj1-x102c.google.com with SMTP id cp7-20020a17090afb8700b0023756229427so7534688pjb.1;
        Fri, 03 Mar 2023 13:38:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677879532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=7bcLQ/kVpuxdipjZe1ew1SkB7Qcp7vd86whAJ1c8evM=;
        b=EgaDL3rhB0SyGn1aTe3CIDYplGrvoXkUG6Jr2/OHu6yfgiRZPgkF58K+XCGzkPAJSC
         ghUmpIQJH7HmDO9lVoQOyG8T662K0bFZiSvSA5eFDYo71bjqXKMcg0MOS2nhJzol5rSL
         1aUlOuSD5amKXmmDofXfzhoCwxOfSyVB1VwcG6m3i5yJBdRs2onLqsefemkI+lj5M8Nf
         Q65KC4amJEdB5HdBLDOSXwAjywNyujGTdrz6GzsuqCED3gdRZWfQwmLsi4Wq5zKVYtrx
         P1i0S9rt4lo1sKAKpbA6vTRhFwSbz8sKYDYWXJ+CPeZVWVGbCfaH+asIskKJJ8f2L9fv
         1ukg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677879532;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=7bcLQ/kVpuxdipjZe1ew1SkB7Qcp7vd86whAJ1c8evM=;
        b=OXbaj1EJcMlWCFqs93xSHi+D/5ZMcWTBrtFnjXxsirXf3YYQLcEIwAZnPy9m5KWQfS
         QGpFtdzkqYy2ux8DJwFlc7msW1g1jLtcICG/JX+pgtYrxwI6bJpzQFFV36NrorXOHtNL
         ZMvbS2chuSbtVhejKu70qyXBDPv60I2nH45rHN1YMr11bYmkaGduiPEofyRDspieu4yj
         +QpCYVNyC+0wJBRt9NrTiPDPY6J8JRc0EF6oeiCiqyS2nP1XncPEOTWlgA0e9SzFxiFp
         T3W7NoELiDBgvGdDEJxE+C/+XP9E6gEWCMs6ihJZFwNu4Ng1Jh2/mdlvBQIFQChu5MQG
         zTkg==
X-Gm-Message-State: AO0yUKVPqj1FkkAVphEp5BYXYUxzwCr4296er1ndR3NaHLD+4ZCInKS5
        p1lnMEg9+5xRV/CyMn1uq6wubBcUDpyg6igjs/qSKkMFQHU=
X-Google-Smtp-Source: AK7set8xJhluwbKjbdiBJfuBibCdA1yaiCTHLZfumAnwRDfYz20sDp40J9Ke2WR/+hv6OHbeQWfYkXM5QAcZk2WcKXM=
X-Received: by 2002:a17:903:2644:b0:19a:fdca:e3e9 with SMTP id
 je4-20020a170903264400b0019afdcae3e9mr1218671plb.10.1677879532312; Fri, 03
 Mar 2023 13:38:52 -0800 (PST)
MIME-Version: 1.0
References: <20230121112947.53433-1-robimarko@gmail.com> <20230121112947.53433-4-robimarko@gmail.com>
 <d71e8a18-8a09-c722-d9dd-b2d48615828f@linaro.org> <CAA8EJppwNVtUjB7fUZSCrZ88Ssbhmc4HD6oA2nV0uEx+vHBXUw@mail.gmail.com>
 <2a7a43f1-a13d-f094-5167-de74d5092d91@linaro.org> <CAOX2RU6vociXPTQE4tegQE8YXjHgQAHgdQWm3N9PPekgaw3ung@mail.gmail.com>
 <2faac9b8-03b9-340f-d43f-317624d4d5bb@linaro.org>
In-Reply-To: <2faac9b8-03b9-340f-d43f-317624d4d5bb@linaro.org>
From:   Robert Marko <robimarko@gmail.com>
Date:   Fri, 3 Mar 2023 22:38:41 +0100
Message-ID: <CAOX2RU7GBuDc-uh_EKmXZu57GvRzfwzwESqgts2tUDbDoik-JA@mail.gmail.com>
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

On Fri, 3 Mar 2023 at 21:46, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
>
>
>
> On 3.03.2023 19:38, Robert Marko wrote:
> > On Sat, 18 Feb 2023 at 21:40, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>
> >>
> >>
> >> On 18.02.2023 21:36, Dmitry Baryshkov wrote:
> >>> On Sat, 18 Feb 2023 at 16:43, Konrad Dybcio <konrad.dybcio@linaro.org> wrote:
> >>>>
> >>>>
> >>>>
> >>>> On 21.01.2023 12:29, Robert Marko wrote:
> >>>>> Currently, qcom_cpufreq_get_msm_id() does not simply return the SoC ID
> >>>>> after getting it via SMEM call but instead uses an enum to encode the
> >>>>> matched SMEM ID to 2 variants of MSM8996 which are then used in
> >>>>> qcom_cpufreq_kryo_name_version() to set the supported version.
> >>>>>
> >>>>> This prevents qcom_cpufreq_get_msm_id() from being universal and its doing
> >>>>> more than its name suggests, so lets make it just return the SoC ID
> >>>>> directly which allows matching directly on the SoC ID and removes the need
> >>>>> for msm8996_version enum which simplifies the driver.
> >>>>> It also allows reusing the qcom_cpufreq_get_msm_id() for new SoC-s.
> >>>>>
> >>>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >>>>> ---
> >>>>>  drivers/cpufreq/qcom-cpufreq-nvmem.c | 44 ++++++++--------------------
> >>>>>  1 file changed, 12 insertions(+), 32 deletions(-)
> >>>>>
> >>>>> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> >>>>> index da55d2e1925a..9deaf9521d6d 100644
> >>>>> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> >>>>> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> >>>>> @@ -32,12 +32,6 @@
> >>>>>
> >>>>>  #include <dt-bindings/arm/qcom,ids.h>
> >>>>>
> >>>>> -enum _msm8996_version {
> >>>>> -     MSM8996_V3,
> >>>>> -     MSM8996_SG,
> >>>>> -     NUM_OF_MSM8996_VERSIONS,
> >>>>> -};
> >>>>> -
> >>>>>  struct qcom_cpufreq_drv;
> >>>>>
> >>>>>  struct qcom_cpufreq_match_data {
> >>>>> @@ -134,30 +128,16 @@ static void get_krait_bin_format_b(struct device *cpu_dev,
> >>>>>       dev_dbg(cpu_dev, "PVS version: %d\n", *pvs_ver);
> >>>>>  }
> >>>>>
> >>>>> -static enum _msm8996_version qcom_cpufreq_get_msm_id(void)
> >>>>> +static int qcom_cpufreq_get_msm_id(void)
> >>>> This should be u32 as info->id is __le32
> >
> > Nice catch.
> >
> >
> >>>>
> >>>> And please export this function from socinfo, it'll come in
> >>>> useful for other drivers!
> >
> > I intentionally did not do that as socinfo is currently fully optional
> > and I dont really like
> > the idea of making it required for anything using SMEM.
> "anything using SMEM"? As in the drivers, or SoCs?
> If the former, I don't see how exporting a function from within
> socid and using it here would make it required for other drivers.
> If the latter, we're talking non-qcom SoCs. SMEM has been with
> us forever.

I feel we have a misunderstanding,
currently, cpufreq-nvmem does not depend on socinfo being built
so I don't want to require it as a dependency in order to get the SMEM ID.

Granted, socinfo is useful on any QCA SoC so if adding new dependecies to
cpufreq-nvmem is acceptable I am not against exporting it there.
>
>
> I'm planning to reuse this for Adreno speedbin matching. It's one
> of those blocks that don't have a revision and/or bin reigster
> within themselves.

I understand the use case, I am sure it will be required in some other places
sooner or later as well.

Regards,
Robert
>
> Konrad
> >
> > Regards,
> > Robert
> >
> >>
> >> Konrad
> >>>
