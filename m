Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAFD1719D00
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 15:11:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233444AbjFANKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 09:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233418AbjFANKw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 09:10:52 -0400
Received: from mail-oo1-xc2e.google.com (mail-oo1-xc2e.google.com [IPv6:2607:f8b0:4864:20::c2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF78F124;
        Thu,  1 Jun 2023 06:10:50 -0700 (PDT)
Received: by mail-oo1-xc2e.google.com with SMTP id 006d021491bc7-5552e031f47so608596eaf.1;
        Thu, 01 Jun 2023 06:10:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685625050; x=1688217050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=J8AI98V++sMW4tZAMoEr6HdOLT7QyK0R8dWzDfkiqZU=;
        b=ZmwdTBPfZaFV84Dz/ONJj9U9XlXK8IMlrWXJa3EGzSQmsftt/dTtQdIJY4GOeOiRF5
         KlsaZsSxRXXJLWEXg2JVdLGLNoUqGFUhK3Mi1t5p+YbEpqhb+DFBbbuiMIGdH8+zcWqv
         8fOvNKF6r2KGF9/1942FFJEZrzscvrFSMVikYYiaUmVveVK51olIttO7ZHoakrWEyf7K
         ZOgkiLvTTx0cTK5PSKgH+OFJnk8vu6yOGkw9Sd4585FcBNOG6U2R76raOQqEBqBOkiX+
         JFsGcpuQWz9ArsH7ISDviX91VLBbiXpu6z4K0kDroEOjRVUrulKFgnh/E03a8DMsyzk7
         s+5A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685625050; x=1688217050;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=J8AI98V++sMW4tZAMoEr6HdOLT7QyK0R8dWzDfkiqZU=;
        b=h77tEjEhTmiTCPZHjzS2I4zFdfZSm8Tak40mQloZCBD3Llh8SAoIslkZUMxpquJmE9
         ood0s7kK3pxOxYOhtV5bwdY9H+jCyoHHeUOVSrAmlVSg52W76oaokuVpie870BN/F/DT
         XYCGQl4bjbb6krZR9+3m98ki5edLgEjntGfO6dxDMLW7bq0gefvWBHFuUDhSQbovnw7T
         fW8UCKCXnGKy3YFBuCU4i79O+T9PoZTuGA6lMvCRW5x/wiB0tE+ciLsbnUrUwqN8rkuq
         O3RBQrZbxVE7qJXCCoGE5yH9lx5M7XYNgnNpT5TuOYLYAU2/7y3IwEXCiZsOnA/Wso0S
         j2iw==
X-Gm-Message-State: AC+VfDy+dNZiU3AZf56tX9S27mi1MTs3m+i/OlWInLnaQ2FUI8Sa24XJ
        qeywZk1GxHjm9b7TgDb9ymz7rCAuYsQ1qOmSEMA=
X-Google-Smtp-Source: ACHHUZ7Xr37SMBBkWdu291srA5vZgFyyH8lNP8q7TmL9ZoUbMW5Zs+DEHjvl7jegjpwzwll30KiT9kx/dNpL+iBmAsI=
X-Received: by 2002:a05:6358:52d3:b0:123:3812:7caa with SMTP id
 z19-20020a05635852d300b0012338127caamr8514795rwz.24.1685625049626; Thu, 01
 Jun 2023 06:10:49 -0700 (PDT)
MIME-Version: 1.0
References: <20230530165807.642084-1-robimarko@gmail.com> <b565b9b5-d7c1-7779-532e-565c3f5c5cd3@quicinc.com>
In-Reply-To: <b565b9b5-d7c1-7779-532e-565c3f5c5cd3@quicinc.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Thu, 1 Jun 2023 15:10:38 +0200
Message-ID: <CAOX2RU6ay_Bc0JYQ6rBcTRadm-71Jie5YH9B0J_1UywkcyqZ8g@mail.gmail.com>
Subject: Re: [RESEND PATCH v2 1/2] cpufreq: qcom-nvmem: add support for IPQ8074
To:     Kathiravan T <quic_kathirav@quicinc.com>
Cc:     rafael@kernel.org, viresh.kumar@linaro.org, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@linaro.org,
        ilia.lin@kernel.org, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ansuelsmth@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 1 Jun 2023 at 14:57, Kathiravan T <quic_kathirav@quicinc.com> wrote:
>
>
> On 5/30/2023 10:28 PM, Robert Marko wrote:
> > IPQ8074 comes in 2 families:
> > * IPQ8070A/IPQ8071A (Acorn) up to 1.4GHz
> > * IPQ8072A/IPQ8074A/IPQ8076A/IPQ8078A (Hawkeye) up to 2.2GHz
> >
> > So, in order to be able to share one OPP table lets add support for IPQ8074
> > family based of SMEM SoC ID-s as speedbin fuse is always 0 on IPQ8074.
> >
> > IPQ8074 compatible is blacklisted from DT platdev as the cpufreq device
> > will get created by NVMEM CPUFreq driver.
> >
> > Signed-off-by: Robert Marko <robimarko@gmail.com>
> > ---
> > Changes in v2:
> > * Print an error if SMEM ID is not part of the IPQ8074 family
> > and restrict the speed to Acorn variant (1.4GHz)
> > ---
> >   drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
> >   drivers/cpufreq/qcom-cpufreq-nvmem.c | 43 ++++++++++++++++++++++++++++
> >   2 files changed, 44 insertions(+)
> >
> > diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c b/drivers/cpufreq/cpufreq-dt-platdev.c
> > index ea86c9f3ed7a..78f6ff933f93 100644
> > --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> > +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> > @@ -170,6 +170,7 @@ static const struct of_device_id blocklist[] __initconst = {
> >       { .compatible = "ti,am62a7", },
> >
> >       { .compatible = "qcom,ipq8064", },
> > +     { .compatible = "qcom,ipq8074", },
> >       { .compatible = "qcom,apq8064", },
> >       { .compatible = "qcom,msm8974", },
> >       { .compatible = "qcom,msm8960", },
> > diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > index a88b6fe5db50..ce444b5962f2 100644
> > --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> > @@ -31,6 +31,9 @@
> >
> >   #include <dt-bindings/arm/qcom,ids.h>
> >
> > +#define IPQ8074_HAWKEYE_VERSION              BIT(0)
> > +#define IPQ8074_ACORN_VERSION                BIT(1)
> > +
> >   struct qcom_cpufreq_drv;
> >
> >   struct qcom_cpufreq_match_data {
> > @@ -204,6 +207,41 @@ static int qcom_cpufreq_krait_name_version(struct device *cpu_dev,
> >       return ret;
> >   }
> >
> > +static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
> > +                                          struct nvmem_cell *speedbin_nvmem,
> > +                                          char **pvs_name,
> > +                                          struct qcom_cpufreq_drv *drv)
>
>
> Most of the IPQ SoCs also supports the fuse based frequency selection.
> Can we rename the function name to generic so that all the IPQ chips can
> use the same function?

Well, the only speedbin fuse I was able to dig from downstream is the one from
CPR driver and that one is 0 on all devices so it's not helpful.
Do you maybe know if there is one in the IPQ8074 family?

Function is not supposed to be shared between SoC-s, so I dont see a point in it
having a generic name cause for example IPQ6018 has a working fuse and its logic
is completely different for setting the versioning than IPQ8074, I
dont think having a
catch-all would work here.

>
>
> > +{
> > +     u32 msm_id;
>
>
> soc_id please...?

Sure, that is more suitable.

Regards,
Robert
>
>
> > +     int ret;
> > +     *pvs_name = NULL;
> > +
> > +     ret = qcom_smem_get_soc_id(&msm_id);
> > +     if (ret)
> > +             return ret;
> > +
> > +     switch (msm_id) {
> > +     case QCOM_ID_IPQ8070A:
> > +     case QCOM_ID_IPQ8071A:
> > +             drv->versions = IPQ8074_ACORN_VERSION;
> > +             break;
> > +     case QCOM_ID_IPQ8072A:
> > +     case QCOM_ID_IPQ8074A:
> > +     case QCOM_ID_IPQ8076A:
> > +     case QCOM_ID_IPQ8078A:
> > +             drv->versions = IPQ8074_HAWKEYE_VERSION;
> > +             break;
> > +     default:
> > +             dev_err(cpu_dev,
> > +                     "SoC ID %u is not part of IPQ8074 family, limiting to 1.4GHz!\n",
> > +                     msm_id);
> > +             drv->versions = IPQ8074_ACORN_VERSION;
> > +             break;
> > +     }
> > +
> > +     return 0;
> > +}
> > +
> >   static const struct qcom_cpufreq_match_data match_data_kryo = {
> >       .get_version = qcom_cpufreq_kryo_name_version,
> >   };
> > @@ -218,6 +256,10 @@ static const struct qcom_cpufreq_match_data match_data_qcs404 = {
> >       .genpd_names = qcs404_genpd_names,
> >   };
> >
> > +static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
> > +     .get_version = qcom_cpufreq_ipq8074_name_version,
> > +};
> > +
> >   static int qcom_cpufreq_probe(struct platform_device *pdev)
> >   {
> >       struct qcom_cpufreq_drv *drv;
> > @@ -363,6 +405,7 @@ static const struct of_device_id qcom_cpufreq_match_list[] __initconst = {
> >       { .compatible = "qcom,msm8996", .data = &match_data_kryo },
> >       { .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
> >       { .compatible = "qcom,ipq8064", .data = &match_data_krait },
> > +     { .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
> >       { .compatible = "qcom,apq8064", .data = &match_data_krait },
> >       { .compatible = "qcom,msm8974", .data = &match_data_krait },
> >       { .compatible = "qcom,msm8960", .data = &match_data_krait },
