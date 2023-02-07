Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DBD668E37F
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 23:39:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229897AbjBGWjU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 17:39:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229628AbjBGWjT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 17:39:19 -0500
Received: from mail-io1-xd2f.google.com (mail-io1-xd2f.google.com [IPv6:2607:f8b0:4864:20::d2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB0A21CF55
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 14:39:17 -0800 (PST)
Received: by mail-io1-xd2f.google.com with SMTP id y2so6264613iot.4
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 14:39:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=IBeKLhexhVuIlFyB10k/azAK7S7zX+ZcRczDxkPJDDI=;
        b=HoJWERAQKDdMQjEcI2tlSxHyq4MUC7bkjaa9YykcTtOhNR8KornBl0aG3dpK2DcUdZ
         +zuf5gpJorE/rhCBxZxgl0AIx5Y8Hm9f6Jt+kdQaeWTy30uySZRF3K8Q6u1ARZByomxQ
         2Ux1wllwCRSglzxZGad4a/VuxwZv/0VEmQOJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=IBeKLhexhVuIlFyB10k/azAK7S7zX+ZcRczDxkPJDDI=;
        b=Gst5qiQhcGYZb4G+04CrAx/rkjAyvTNmlpQqeJiuBlCtuKFzifGPZPCPL3wbb2urlP
         ribvPq7xDFgdP24b2OqiOCqGP+m0K/H3CMMROuTKvnLqXKjNp63zTCFliuvsgXh7n9N+
         rJDjI05elcQ/Ii1Q0Rp51ONe+JqljKYz3MbmZiDnY+D9KnvJsvLwieyoEZxP5u9aY54M
         p95fgABJjDwd1C39reQzpVO/bfbc7/0kct56LrpvHXH6nt5u/TRGAMECPAGqzqwF6L58
         L5kXH0w7TpRvaBp9syxScO8DYsiVj99fFXkMocIf8IS2XZ4WPXJPXEzaTj1hQj5wmqbM
         91nQ==
X-Gm-Message-State: AO0yUKWcQwH+NGOQucbS60fzVWvL/noDV9IG12oJzQrnTJFN+H3sdOQO
        qwDfjW12zWYnJYT4e0FrpTlCvA==
X-Google-Smtp-Source: AK7set/SnFWn789GkuEuf3XipiBmjDHv1H0+VJXst89oJGDc1dt8OHqJdibXPTZNzRwRbcC56P4Zow==
X-Received: by 2002:a6b:1585:0:b0:721:90c5:7d0e with SMTP id 127-20020a6b1585000000b0072190c57d0emr3928577iov.9.1675809557082;
        Tue, 07 Feb 2023 14:39:17 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id c7-20020a5e8f07000000b00713d437afe8sm4208866iok.26.2023.02.07.14.39.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 07 Feb 2023 14:39:16 -0800 (PST)
Date:   Tue, 7 Feb 2023 22:39:16 +0000
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
Message-ID: <Y+LTFL+ncIJS38Sk@google.com>
References: <20230207102254.1446461-1-javierm@redhat.com>
 <DM8PR02MB8169809493BF2822E6C29EECF3DB9@DM8PR02MB8169.namprd02.prod.outlook.com>
 <Y+KPW18o/Da+N8UI@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y+KPW18o/Da+N8UI@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 07, 2023 at 05:50:19PM +0000, mka@chromium.org wrote:
> Hi Vikash,
> 
> On Tue, Feb 07, 2023 at 04:40:24PM +0000, Vikash Garodia wrote:
> > Hi Javier and Matthias,
> > Can we try the attached patch if that fixes the suspend issue for sc7180 and sc7280 ?
> 
> On my side the patch fixes the issue for sc7280, but not sc7180.

Some more info for sc7180:

[   10.313055] qcom-venus aa00000.video-codec: failed to reset venus core
[   10.331454] qcom-venus: probe of aa00000.video-codec failed with error -110

So venus didn't probe successfully. As a result sync_state() of its rpmhpd and
interconnects isn't called and they keep running at max speed, which prevents
the Always-On subsystem from suspending:

[   30.171148] qcom-rpmhpd 18200000.rsc:power-controller: Consumer 'aa00000.video-codec' did not probe (successfully)
[   30.682950] qnoc-sc7180 9680000.interconnect: Consumer 'aa00000.video-codec' did not probe (successfully)
[   30.701843] qnoc-sc7180 1740000.interconnect: Consumer 'aa00000.video-codec' did not probe (successfully)
[   30.720168] qnoc-sc7180 1638000.interconnect: Consumer 'aa00000.video-codec' did not probe (successfully)
[   30.738478] qnoc-sc7180 1500000.interconnect: Consumer 'aa00000.video-codec' did not probe (successfully)

(these debug logs are not upstream)

> > > -----Original Message-----
> > > From: Javier Martinez Canillas <javierm@redhat.com>
> > > Sent: Tuesday, February 7, 2023 3:53 PM
> > > To: linux-kernel@vger.kernel.org
> > > Cc: Albert Esteve <aesteve@redhat.com>; stanimir.varbanov@linaro.org;
> > > Matthias Kaehlcke <mka@chromium.org>; Enric Balletbo i Serra
> > > <eballetb@redhat.com>; Javier Martinez Canillas <javierm@redhat.com>; Andy
> > > Gross <agross@kernel.org>; Bjorn Andersson <andersson@kernel.org>; Konrad
> > > Dybcio <konrad.dybcio@linaro.org>; Mauro Carvalho Chehab
> > > <mchehab@kernel.org>; Stanimir Varbanov
> > > <stanimir.k.varbanov@gmail.com>; Vikash Garodia (QUIC)
> > > <quic_vgarodia@quicinc.com>; linux-arm-msm@vger.kernel.org; linux-
> > > media@vger.kernel.org
> > > Subject: [PATCH] Revert "venus: firmware: Correct non-pix start and end
> > > addresses"
> > > 
> > > WARNING: This email originated from outside of Qualcomm. Please be wary of
> > > any links or attachments, and do not enable macros.
> > > 
> > > This reverts commit a837e5161cfffbb3242cc0eb574f8bf65fd32640, which
> > > broke probing of the venus driver, at least on the SC7180 SoC HP X2
> > > Chromebook:
> > > 
> > >   [   11.455782] qcom-venus aa00000.video-codec: Adding to iommu group 11
> > >   [   11.506980] qcom-venus aa00000.video-codec: non legacy binding
> > >   [   12.143432] qcom-venus aa00000.video-codec: failed to reset venus core
> > >   [   12.156440] qcom-venus: probe of aa00000.video-codec failed with error -
> > > 110
> > > 
> > > Matthias Kaehlcke also reported that the same change caused a regression in
> > > SC7180 and sc7280, that prevents AOSS from entering sleep mode during
> > > system suspend. So let's revert this commit for now to fix both issues.
> > > 
> > > Fixes: a837e5161cff ("venus: firmware: Correct non-pix start and end
> > > addresses")
> > > Reported-by: Matthias Kaehlcke <mka@chromium.org>
> > > Signed-off-by: Javier Martinez Canillas <javierm@redhat.com>
> > > ---
> > > 
> > >  drivers/media/platform/qcom/venus/firmware.c | 4 ++--
> > >  1 file changed, 2 insertions(+), 2 deletions(-)
> > > 
> > > diff --git a/drivers/media/platform/qcom/venus/firmware.c
> > > b/drivers/media/platform/qcom/venus/firmware.c
> > > index 142d4c74017c..d59ecf776715 100644
> > > --- a/drivers/media/platform/qcom/venus/firmware.c
> > > +++ b/drivers/media/platform/qcom/venus/firmware.c
> > > @@ -38,8 +38,8 @@ static void venus_reset_cpu(struct venus_core *core)
> > >         writel(fw_size, wrapper_base + WRAPPER_FW_END_ADDR);
> > >         writel(0, wrapper_base + WRAPPER_CPA_START_ADDR);
> > >         writel(fw_size, wrapper_base + WRAPPER_CPA_END_ADDR);
> > > -       writel(0, wrapper_base + WRAPPER_NONPIX_START_ADDR);
> > > -       writel(0, wrapper_base + WRAPPER_NONPIX_END_ADDR);
> > > +       writel(fw_size, wrapper_base + WRAPPER_NONPIX_START_ADDR);
> > > +       writel(fw_size, wrapper_base + WRAPPER_NONPIX_END_ADDR);
> > > 
> > >         if (IS_V6(core)) {
> > >                 /* Bring XTSS out of reset */
> > > --
> > > 2.39.1
> > 
> > Thanks,
> > Vikash
> 
> 
