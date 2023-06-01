Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E45E71A117
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:55:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234274AbjFAOzt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:55:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232776AbjFAOzr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:55:47 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57E9A123;
        Thu,  1 Jun 2023 07:55:46 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id d9443c01a7336-1b041cceb16so7987845ad.2;
        Thu, 01 Jun 2023 07:55:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685631346; x=1688223346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=4pZdoC/20g9zOwcLzXAs2apfb3PaixtoFPSdJ6IW6n0=;
        b=N8dp1iYo3E5hO84dWb4Ei0WEVb5Ma1gchI3zvNNzhi06+inO1GBMyuvgzHq79Xkkhe
         fGmdYdGDfW2TKgz0gHTtN+PRuWK3ki5vrUm9uf/dhmJpPTDpou6L4YLxRT8FOTccgDkW
         9s3TQ6pNrsjvYADZMrKEGvfCflw00Zmdn4m9vBKvPtvbjWZhPLpVHQuDfHKwVW3KXCCv
         jFr+2XNSSx6PcsziUzsQRqt9r7vdo94krdzSrEgVKJqS4rcz4wnQg9TlMT/8HiIA0MK1
         G9SnCrri+3VXZD+WDWj6lWnOAqYm8QXXzmdPG5scUAf1/9uUtF3VvgskkayF0Eq3TASi
         O86w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631346; x=1688223346;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=4pZdoC/20g9zOwcLzXAs2apfb3PaixtoFPSdJ6IW6n0=;
        b=DRju1M6cpfVIWnDq4rtJ3thUXrmdXxkgAs3pAIMI1SZZpF16MMeIC8vNEFfam6jwDt
         zb7/e37SNBdAqQuY6dxG6xH9a8f56TJ8Niz1Wlu/7zE2Q7DcXmlC3lsgnJBmdwgJR9qP
         Ezz3tyFi9DWJ45U6ukAxuiTsNgtNfv6vFhgpjZYE3/o6ZtbgoIkyR6mayh5BxOoP8y6f
         2AAwzbHL3GDGx1mFkclcF8B121VAzMs9aN9vDInq0s+yR6opXTXW8aKgQFikmClNl4FK
         zG2rV3ce/Tg3cEMCaxfLxyQBMMfpM1XjZ6yeRfhJDemOTsJoSqtIakONXDpXkUOtTXt3
         8pCw==
X-Gm-Message-State: AC+VfDxbj6HQV1IZ1Ozt5oDSKRXTR7/7cE9bS0Axv8sAiBhjcj1Kcx/+
        o7EfFGbOQ69+rZzgDaT8iyolYwwKWkzqp2YGxgY=
X-Google-Smtp-Source: ACHHUZ6H/hyjAHMQEdJaTRFvI+F7VrwjRcNvW2kAXvCn/liJPvBJwUVnSXQjJbVoJ15uIZ7IzfHwnLCUZPzJqwVieSw=
X-Received: by 2002:a17:902:6a89:b0:1b0:6544:1d4 with SMTP id
 n9-20020a1709026a8900b001b0654401d4mr7605968plk.27.1685631345692; Thu, 01 Jun
 2023 07:55:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230530165807.642084-1-robimarko@gmail.com> <b565b9b5-d7c1-7779-532e-565c3f5c5cd3@quicinc.com>
 <CAOX2RU6ay_Bc0JYQ6rBcTRadm-71Jie5YH9B0J_1UywkcyqZ8g@mail.gmail.com>
 <70de3314-766d-4c7f-5b1a-41740cfeac8c@quicinc.com> <2a78c9ce-f631-53fd-581f-2e8c906be989@quicinc.com>
In-Reply-To: <2a78c9ce-f631-53fd-581f-2e8c906be989@quicinc.com>
From:   Robert Marko <robimarko@gmail.com>
Date:   Thu, 1 Jun 2023 16:55:34 +0200
Message-ID: <CAOX2RU4k4bDvtU8m4cxA=9x6b2B0mwiKsBWXFV3TY+jvk49vwg@mail.gmail.com>
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

On Thu, 1 Jun 2023 at 16:49, Kathiravan T <quic_kathirav@quicinc.com> wrote:
>
>
> On 6/1/2023 6:54 PM, Kathiravan T wrote:
> >
> > On 6/1/2023 6:40 PM, Robert Marko wrote:
> >> On Thu, 1 Jun 2023 at 14:57, Kathiravan T <quic_kathirav@quicinc.com>
> >> wrote:
> >>>
> >>> On 5/30/2023 10:28 PM, Robert Marko wrote:
> >>>> IPQ8074 comes in 2 families:
> >>>> * IPQ8070A/IPQ8071A (Acorn) up to 1.4GHz
> >>>> * IPQ8072A/IPQ8074A/IPQ8076A/IPQ8078A (Hawkeye) up to 2.2GHz
> >>>>
> >>>> So, in order to be able to share one OPP table lets add support for
> >>>> IPQ8074
> >>>> family based of SMEM SoC ID-s as speedbin fuse is always 0 on IPQ8074.
> >>>>
> >>>> IPQ8074 compatible is blacklisted from DT platdev as the cpufreq
> >>>> device
> >>>> will get created by NVMEM CPUFreq driver.
> >>>>
> >>>> Signed-off-by: Robert Marko <robimarko@gmail.com>
> >>>> ---
> >>>> Changes in v2:
> >>>> * Print an error if SMEM ID is not part of the IPQ8074 family
> >>>> and restrict the speed to Acorn variant (1.4GHz)
> >>>> ---
> >>>>    drivers/cpufreq/cpufreq-dt-platdev.c |  1 +
> >>>>    drivers/cpufreq/qcom-cpufreq-nvmem.c | 43
> >>>> ++++++++++++++++++++++++++++
> >>>>    2 files changed, 44 insertions(+)
> >>>>
> >>>> diff --git a/drivers/cpufreq/cpufreq-dt-platdev.c
> >>>> b/drivers/cpufreq/cpufreq-dt-platdev.c
> >>>> index ea86c9f3ed7a..78f6ff933f93 100644
> >>>> --- a/drivers/cpufreq/cpufreq-dt-platdev.c
> >>>> +++ b/drivers/cpufreq/cpufreq-dt-platdev.c
> >>>> @@ -170,6 +170,7 @@ static const struct of_device_id blocklist[]
> >>>> __initconst = {
> >>>>        { .compatible = "ti,am62a7", },
> >>>>
> >>>>        { .compatible = "qcom,ipq8064", },
> >>>> +     { .compatible = "qcom,ipq8074", },
> >>>>        { .compatible = "qcom,apq8064", },
> >>>>        { .compatible = "qcom,msm8974", },
> >>>>        { .compatible = "qcom,msm8960", },
> >>>> diff --git a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> >>>> b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> >>>> index a88b6fe5db50..ce444b5962f2 100644
> >>>> --- a/drivers/cpufreq/qcom-cpufreq-nvmem.c
> >>>> +++ b/drivers/cpufreq/qcom-cpufreq-nvmem.c
> >>>> @@ -31,6 +31,9 @@
> >>>>
> >>>>    #include <dt-bindings/arm/qcom,ids.h>
> >>>>
> >>>> +#define IPQ8074_HAWKEYE_VERSION              BIT(0)
> >>>> +#define IPQ8074_ACORN_VERSION                BIT(1)
> >>>> +
> >>>>    struct qcom_cpufreq_drv;
> >>>>
> >>>>    struct qcom_cpufreq_match_data {
> >>>> @@ -204,6 +207,41 @@ static int
> >>>> qcom_cpufreq_krait_name_version(struct device *cpu_dev,
> >>>>        return ret;
> >>>>    }
> >>>>
> >>>> +static int qcom_cpufreq_ipq8074_name_version(struct device *cpu_dev,
> >>>> +                                          struct nvmem_cell
> >>>> *speedbin_nvmem,
> >>>> +                                          char **pvs_name,
> >>>> +                                          struct qcom_cpufreq_drv
> >>>> *drv)
> >>>
> >>> Most of the IPQ SoCs also supports the fuse based frequency selection.
> >>> Can we rename the function name to generic so that all the IPQ chips
> >>> can
> >>> use the same function?
> >> Well, the only speedbin fuse I was able to dig from downstream is the
> >> one from
> >> CPR driver and that one is 0 on all devices so it's not helpful.
> >> Do you maybe know if there is one in the IPQ8074 family?
> >
> >
> > Let me check on this and get back to you probably by tomorrow...
>
>
> Robert, checked with the team and IPQ807x doesn't use fuse to determine
> the CPU freq limits. Current approach (SoC ID based) should be fine.
> BTW, are the DTS changes already posted or yet to be posted?

Thanks for checking,
DTS changes are not posted as CPR support is required in order for scaling to
properly work, otherwise, all I could do is try and guess some safe voltages.
There was an effort to get CPR upstreamed, but I think that stalled out for now.

Regards,
Robert
>
>
> >
> >
> >>
> >> Function is not supposed to be shared between SoC-s, so I dont see a
> >> point in it
> >> having a generic name cause for example IPQ6018 has a working fuse
> >> and its logic
> >> is completely different for setting the versioning than IPQ8074, I
> >> dont think having a
> >> catch-all would work here.
> >
> >
> > Makes sense, thanks Robert and Konrad.
> >
> >
> >>
> >>>
> >>>> +{
> >>>> +     u32 msm_id;
> >>>
> >>> soc_id please...?
> >> Sure, that is more suitable.
> >>
> >> Regards,
> >> Robert
> >>>
> >>>> +     int ret;
> >>>> +     *pvs_name = NULL;
> >>>> +
> >>>> +     ret = qcom_smem_get_soc_id(&msm_id);
> >>>> +     if (ret)
> >>>> +             return ret;
> >>>> +
> >>>> +     switch (msm_id) {
> >>>> +     case QCOM_ID_IPQ8070A:
> >>>> +     case QCOM_ID_IPQ8071A:
> >>>> +             drv->versions = IPQ8074_ACORN_VERSION;
> >>>> +             break;
> >>>> +     case QCOM_ID_IPQ8072A:
> >>>> +     case QCOM_ID_IPQ8074A:
> >>>> +     case QCOM_ID_IPQ8076A:
> >>>> +     case QCOM_ID_IPQ8078A:
> >>>> +             drv->versions = IPQ8074_HAWKEYE_VERSION;
> >>>> +             break;
> >>>> +     default:
> >>>> +             dev_err(cpu_dev,
> >>>> +                     "SoC ID %u is not part of IPQ8074 family,
> >>>> limiting to 1.4GHz!\n",
> >>>> +                     msm_id);
> >>>> +             drv->versions = IPQ8074_ACORN_VERSION;
> >>>> +             break;
> >>>> +     }
> >>>> +
> >>>> +     return 0;
> >>>> +}
> >>>> +
> >>>>    static const struct qcom_cpufreq_match_data match_data_kryo = {
> >>>>        .get_version = qcom_cpufreq_kryo_name_version,
> >>>>    };
> >>>> @@ -218,6 +256,10 @@ static const struct qcom_cpufreq_match_data
> >>>> match_data_qcs404 = {
> >>>>        .genpd_names = qcs404_genpd_names,
> >>>>    };
> >>>>
> >>>> +static const struct qcom_cpufreq_match_data match_data_ipq8074 = {
> >>>> +     .get_version = qcom_cpufreq_ipq8074_name_version,
> >>>> +};
> >>>> +
> >>>>    static int qcom_cpufreq_probe(struct platform_device *pdev)
> >>>>    {
> >>>>        struct qcom_cpufreq_drv *drv;
> >>>> @@ -363,6 +405,7 @@ static const struct of_device_id
> >>>> qcom_cpufreq_match_list[] __initconst = {
> >>>>        { .compatible = "qcom,msm8996", .data = &match_data_kryo },
> >>>>        { .compatible = "qcom,qcs404", .data = &match_data_qcs404 },
> >>>>        { .compatible = "qcom,ipq8064", .data = &match_data_krait },
> >>>> +     { .compatible = "qcom,ipq8074", .data = &match_data_ipq8074 },
> >>>>        { .compatible = "qcom,apq8064", .data = &match_data_krait },
> >>>>        { .compatible = "qcom,msm8974", .data = &match_data_krait },
> >>>>        { .compatible = "qcom,msm8960", .data = &match_data_krait },
