Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D435268DF4C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 18:50:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229447AbjBGRuX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 12:50:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232193AbjBGRuW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 12:50:22 -0500
Received: from mail-io1-xd35.google.com (mail-io1-xd35.google.com [IPv6:2607:f8b0:4864:20::d35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 386BF59D3
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 09:50:21 -0800 (PST)
Received: by mail-io1-xd35.google.com with SMTP id e2so5950372iot.11
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 09:50:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=CBzkf3FCD8x/y9eVd1GA5EoRd79pK0BFSSnyzHt0mXw=;
        b=JbWrCre30UL5YyUvJbrQQKDFP1RIID+kILrl7992LyEkzGYIQ4mC6GsR56nnuyFhlf
         ziKrvWd9u3x2wmNenO54ZokDex9/awcXfwu4l/Uda0kqC8uGb5+rTDsn0VRD/eTcCzZO
         3R2aKlmNS0e0oHxkaVcf+Yj34GNcF56XwQuxU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=CBzkf3FCD8x/y9eVd1GA5EoRd79pK0BFSSnyzHt0mXw=;
        b=l30NffX9GJrFJua3+eDALFIg8nQkc73v0ZBolGYaM6B8P6mf0lYFveubA93WN54IRg
         FjITCmkoDLEgyKixKcbYXUm4Bz+BYIc8sYBjthPBIYdsVSczbHfb7I7iFahM93PWsrRn
         p2kj0OaY8/U3znZEHfYNP5B5x20ibVuldMMCY+mSWoJ8TUTWpBLLUDhtW6B3tE+46WF+
         NWdULYvK3uqAA4zLUT9J0/g5iR3cJUNUp0wEBiXeHgqX8jcooXHl9a2btYNu8ejeBYGX
         2Z3KahOqeDSbAp0loaU1AyBKI73TOEzTQpAtbDe3bP3cvx78ya0kt3DMS25LM19U6GDS
         rOhQ==
X-Gm-Message-State: AO0yUKUo2LbiyaIbebFR4vahO+vHtmzcFe1vo9FQCua1dIMeaEtc59Cl
        eCGn5usjqlh2yJ9sT7+oqEOV1Q==
X-Google-Smtp-Source: AK7set9TA/3RgJK3yUToPWGVriuqQo8s0O7oNuC5X8TOPoTi1ehjK4em9NIq+bjGtSmKozxSMqTYjQ==
X-Received: by 2002:a5e:8914:0:b0:734:e4df:cd04 with SMTP id k20-20020a5e8914000000b00734e4dfcd04mr2436285ioj.12.1675792220580;
        Tue, 07 Feb 2023 09:50:20 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id q3-20020a6bf203000000b00716eb44b97esm4084698ioh.27.2023.02.07.09.50.20
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 09:50:20 -0800 (PST)
Date:   Tue, 7 Feb 2023 17:50:19 +0000
From:   "mka@chromium.org" <mka@chromium.org>
To:     Vikash Garodia <vgarodia@qti.qualcomm.com>
Cc:     Javier Martinez Canillas <javierm@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Albert Esteve <aesteve@redhat.com>,
        "stanimir.varbanov@linaro.org" <stanimir.varbanov@linaro.org>,
        Enric Balletbo i Serra <eballetb@redhat.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        "Vikash Garodia (QUIC)" <quic_vgarodia@quicinc.com>,
        "linux-arm-msm@vger.kernel.org" <linux-arm-msm@vger.kernel.org>,
        "linux-media@vger.kernel.org" <linux-media@vger.kernel.org>,
        Fritz Koenig <frkoenig@google.com>,
        "Dikshita Agarwal (QUIC)" <quic_dikshita@quicinc.com>,
        "Rajeshwar Kurapaty (QUIC)" <quic_rkurapat@quicinc.com>
Subject: Re: [PATCH] Revert "venus: firmware: Correct non-pix start and end
 addresses"
Message-ID: <Y+KPW18o/Da+N8UI@google.com>
References: <20230207102254.1446461-1-javierm@redhat.com>
 <DM8PR02MB8169809493BF2822E6C29EECF3DB9@DM8PR02MB8169.namprd02.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <DM8PR02MB8169809493BF2822E6C29EECF3DB9@DM8PR02MB8169.namprd02.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vikash,

On Tue, Feb 07, 2023 at 04:40:24PM +0000, Vikash Garodia wrote:
> Hi Javier and Matthias,
> Can we try the attached patch if that fixes the suspend issue for sc7180 and sc7280 ?

On my side the patch fixes the issue for sc7280, but not sc7180.

> > -----Original Message-----
> > From: Javier Martinez Canillas <javierm@redhat.com>
> > Sent: Tuesday, February 7, 2023 3:53 PM
> > To: linux-kernel@vger.kernel.org
> > Cc: Albert Esteve <aesteve@redhat.com>; stanimir.varbanov@linaro.org;
> > Matthias Kaehlcke <mka@chromium.org>; Enric Balletbo i Serra
> > <eballetb@redhat.com>; Javier Martinez Canillas <javierm@redhat.com>; Andy
> > Gross <agross@kernel.org>; Bjorn Andersson <andersson@kernel.org>; Konrad
> > Dybcio <konrad.dybcio@linaro.org>; Mauro Carvalho Chehab
> > <mchehab@kernel.org>; Stanimir Varbanov
> > <stanimir.k.varbanov@gmail.com>; Vikash Garodia (QUIC)
> > <quic_vgarodia@quicinc.com>; linux-arm-msm@vger.kernel.org; linux-
> > media@vger.kernel.org
> > Subject: [PATCH] Revert "venus: firmware: Correct non-pix start and end
> > addresses"
> > 
> > WARNING: This email originated from outside of Qualcomm. Please be wary of
> > any links or attachments, and do not enable macros.
> > 
> > This reverts commit a837e5161cfffbb3242cc0eb574f8bf65fd32640, which
> > broke probing of the venus driver, at least on the SC7180 SoC HP X2
> > Chromebook:
> > 
> >   [   11.455782] qcom-venus aa00000.video-codec: Adding to iommu group 11
> >   [   11.506980] qcom-venus aa00000.video-codec: non legacy binding
> >   [   12.143432] qcom-venus aa00000.video-codec: failed to reset venus core
> >   [   12.156440] qcom-venus: probe of aa00000.video-codec failed with error -
> > 110
> > 
> > Matthias Kaehlcke also reported that the same change caused a regression in
> > SC7180 and sc7280, that prevents AOSS from entering sleep mode during
> > system suspend. So let's revert this commit for now to fix both issues.
> > 
> > Fixes: a837e5161cff ("venus: firmware: Correct non-pix start and end
> > addresses")
> > Reported-by: Matthias Kaehlcke <mka@chromium.org>
> > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > ---
> > 
> >  drivers/media/platform/qcom/venus/firmware.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/media/platform/qcom/venus/firmware.c
> > b/drivers/media/platform/qcom/venus/firmware.c
> > index 142d4c74017c..d59ecf776715 100644
> > --- a/drivers/media/platform/qcom/venus/firmware.c
> > +++ b/drivers/media/platform/qcom/venus/firmware.c
> > @@ -38,8 +38,8 @@ static void venus_reset_cpu(struct venus_core *core)
> >         writel(fw_size, wrapper_base + WRAPPER_FW_END_ADDR);
> >         writel(0, wrapper_base + WRAPPER_CPA_START_ADDR);
> >         writel(fw_size, wrapper_base + WRAPPER_CPA_END_ADDR);
> > -       writel(0, wrapper_base + WRAPPER_NONPIX_START_ADDR);
> > -       writel(0, wrapper_base + WRAPPER_NONPIX_END_ADDR);
> > +       writel(fw_size, wrapper_base + WRAPPER_NONPIX_START_ADDR);
> > +       writel(fw_size, wrapper_base + WRAPPER_NONPIX_END_ADDR);
> > 
> >         if (IS_V6(core)) {
> >                 /* Bring XTSS out of reset */
> > --
> > 2.39.1
> 
> Thanks,
> Vikash


