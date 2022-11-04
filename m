Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CD9461A31C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Nov 2022 22:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229629AbiKDVRP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Nov 2022 17:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57772 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiKDVRH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Nov 2022 17:17:07 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E586A2700
        for <linux-kernel@vger.kernel.org>; Fri,  4 Nov 2022 14:17:06 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id n85so1602089yba.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Nov 2022 14:17:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=pyGds6Hg1ZCJpXSt9b953qf8BGwVMn84FDUpPupYsPA=;
        b=DssSrfVlC3iSSNTKeeDHt8VNgTSi5VuuN0su+R3SWycgfn/MKXXDOSE3gj83VHj9cl
         HrcoYCHYVAfb1wbgNsGa68z+V456TnMfPIT+EWX1A3hvJA/y97t/hSXShCZHpAd8xdqx
         qTIh8O0CZ6+qBXguTqj2gcIVxJzVVFi8qg2OlMU5BHM3ZGOyhfU60YFUTTnbgQiDVrIp
         Wz6zJ1INTZtvm0/sZ/ImQPWgnnMzAS1PkvA5/N8CuSHTNsKF0Ut11gL4z0iziR9dStwo
         jvo60f0Su6wLkC44wUyx1gW8XdHwqtDcMrVuoVfluOlT7V7Ddh7BsQtyAPevahbOC6o6
         uDKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=pyGds6Hg1ZCJpXSt9b953qf8BGwVMn84FDUpPupYsPA=;
        b=koHtxOIMXei7wwfJ2IdxR0ZzA7jT1hVni5M1NDOprZQKW0JWu8elkfQ1Nt/+7JVBNO
         LYNAXs5vmev12NNtQAQmujW48C9xrWotHm5Bn2fPTs/hqqFwZp/fuMeRHqQ8z3wE72dt
         d0Xm9NhFlchUp6Na7lWgHjxRUtgOiYD32JzwwPPz4/hX7DHOXHESocgXLz9WAGCl1TY0
         Zy6671rZlX8DoEQt+BslAN5qTWVQqoIFFcTEFS/qj2EzqHYWvuyeQQ5WQG+SLjfDpIJO
         MzGMuHCb9WIU9GSl7yvAx0rG0M2bT404+g9UMWMdd+Tg0UhYnFIO8CKGLWal1ya6jp8W
         6y2g==
X-Gm-Message-State: ANoB5pk6Be6J8RHIrcWwDwGqMBRSsf/RxU+NCbFTGkVyKlpWS7B9orwi
        ChikhZlhPwhf+3dQy2uoIH2hS+Lm8KDKRxd36eBi4g==
X-Google-Smtp-Source: AA0mqf5GaczFdCkzkNzAZDKj1QHfSwJuiNQKKfgZLEkbhvf/8ad5OCKF9RnkskhAcJNNr1lKt2Duwh8y0sswHirdtBY=
X-Received: by 2002:a25:3b90:0:b0:6d3:5464:8338 with SMTP id
 i138-20020a253b90000000b006d354648338mr4703120yba.288.1667596626192; Fri, 04
 Nov 2022 14:17:06 -0700 (PDT)
MIME-Version: 1.0
References: <20221104133452.131227-1-angelogioacchino.delregno@collabora.com>
 <20221104133452.131227-3-angelogioacchino.delregno@collabora.com> <20221104143202.nps2iwqjcwug6mij@SoMainline.org>
In-Reply-To: <20221104143202.nps2iwqjcwug6mij@SoMainline.org>
From:   Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
Date:   Sat, 5 Nov 2022 00:16:55 +0300
Message-ID: <CAA8EJprOUmFKHr91qAmmKjXn0Q6EX7pgpaMp4J53jsF+5E_M8Q@mail.gmail.com>
Subject: Re: [PATCH 2/2] soc: qcom: spm: Implement support for SAWv2.3,
 MSM8976 L2 PM
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, agross@kernel.org,
        andersson@kernel.org, konrad.dybcio@somainline.org,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@collabora.com,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 at 17:34, Marijn Suijten
<marijn.suijten@somainline.org> wrote:
>
> On 2022-11-04 14:34:52, AngeloGioacchino Del Regno wrote:
> > From: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> >
> > Implement the support for SAW v2.3, used in at least MSM8976, MSM8956
> > and APQ variants and while at it also add the configuration for the
> > MSM8976's little (a53) and big (a72) clusters cache power management.
> >
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@somainline.org>
> > [Marijn: reorder struct definitions to follow high-to-low order]
>
> Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>

With this sign-off in place,

Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>

>
> > Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> > ---
> >  drivers/soc/qcom/spm.c | 33 +++++++++++++++++++++++++++++++++
> >  1 file changed, 33 insertions(+)
> >
> > diff --git a/drivers/soc/qcom/spm.c b/drivers/soc/qcom/spm.c
> > index 484b42b7454e..bfcd321d7837 100644
> > --- a/drivers/soc/qcom/spm.c
> > +++ b/drivers/soc/qcom/spm.c
> > @@ -98,6 +98,35 @@ static const struct spm_reg_data spm_reg_8916_cpu = {
> >       .start_index[PM_SLEEP_MODE_SPC] = 5,
> >  };
> >
> > +static const u16 spm_reg_offset_v2_3[SPM_REG_NR] = {
> > +     [SPM_REG_CFG]           = 0x08,
> > +     [SPM_REG_SPM_CTL]       = 0x30,
> > +     [SPM_REG_DLY]           = 0x34,
> > +     [SPM_REG_PMIC_DATA_0]   = 0x40,
> > +     [SPM_REG_PMIC_DATA_1]   = 0x44,
> > +};
> > +
> > +/* SPM register data for 8976 */
> > +static const struct spm_reg_data spm_reg_8976_gold_l2 = {
> > +     .reg_offset = spm_reg_offset_v2_3,
> > +     .spm_cfg = 0x14,
> > +     .spm_dly = 0x3c11840a,
> > +     .pmic_data[0] = 0x03030080,
> > +     .pmic_data[1] = 0x00030000,
> > +     .start_index[PM_SLEEP_MODE_STBY] = 0,
> > +     .start_index[PM_SLEEP_MODE_SPC] = 3,
> > +};
> > +
> > +static const struct spm_reg_data spm_reg_8976_silver_l2 = {
> > +     .reg_offset = spm_reg_offset_v2_3,
> > +     .spm_cfg = 0x14,
> > +     .spm_dly = 0x3c102800,
> > +     .pmic_data[0] = 0x03030080,
> > +     .pmic_data[1] = 0x00030000,
> > +     .start_index[PM_SLEEP_MODE_STBY] = 0,
> > +     .start_index[PM_SLEEP_MODE_SPC] = 2,
> > +};
> > +
> >  static const u16 spm_reg_offset_v2_1[SPM_REG_NR] = {
> >       [SPM_REG_CFG]           = 0x08,
> >       [SPM_REG_SPM_CTL]       = 0x30,
> > @@ -213,6 +242,10 @@ static const struct of_device_id spm_match_table[] = {
> >         .data = &spm_reg_8916_cpu },
> >       { .compatible = "qcom,msm8974-saw2-v2.1-cpu",
> >         .data = &spm_reg_8974_8084_cpu },
> > +     { .compatible = "qcom,msm8976-gold-saw2-v2.3-l2",
> > +       .data = &spm_reg_8976_gold_l2 },
> > +     { .compatible = "qcom,msm8976-silver-saw2-v2.3-l2",
> > +       .data = &spm_reg_8976_silver_l2 },
> >       { .compatible = "qcom,msm8998-gold-saw2-v4.1-l2",
> >         .data = &spm_reg_8998_gold_l2 },
> >       { .compatible = "qcom,msm8998-silver-saw2-v4.1-l2",
> > --
> > 2.37.2
> >



-- 
With best wishes
Dmitry
