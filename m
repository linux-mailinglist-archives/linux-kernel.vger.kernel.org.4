Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D67DF5E7342
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 07:10:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiIWFKt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 01:10:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbiIWFKr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 01:10:47 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D4BCD574A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:10:45 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id x29so13392005ljq.2
        for <linux-kernel@vger.kernel.org>; Thu, 22 Sep 2022 22:10:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=H2c0hv2ieCNxSdEWPXcGPXlDZHUdAO9roxe+nCV0M+o=;
        b=ko4KXGf7o8DpC3HGaGgL8EZUrFhgruem/OTHR+zk5XP8Z9NzBjUwwhiTAPpeVc64Ks
         bHnMcC6EQeiVV/0HLEIfxbqTFBFqv4EENzJNG1i4XKvYOb4dovp7tIvKYIjwxHMvyY+z
         RVwkE/+hshgTmLCtJDhsJU/12p9JA2GNXrugHeJeG5BmW6OCtVuhrtYFx6QOxHGG/4WM
         dfMaeCuZE26qBF2JLZk7yQM5gNYB0Av2YfqkbKLYJNIR+VP8jIKDSHc0tO4h8EOaO/CD
         paVtkciaLEHG8aT5VSXB6MtTwHMluMQ/MFKZGqKv72tyE4wGtrKJhYULEg26v518hAum
         4PBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=H2c0hv2ieCNxSdEWPXcGPXlDZHUdAO9roxe+nCV0M+o=;
        b=pizQSKOs0Nj0vKN8V6ZSBjXRnMI09M5a7KdX6CwIal1v9KSKN6atT4BIxH1aKKTdz1
         VjpSPM/SlOaKS+lJzC7ktGTpf508hno8ZNoAorH76HJ0UTxkyYHPtc1yrgQs8UXzdRok
         fAYso8SALPT/hJph+BGklsfEcdhoW+4NqFEGuXZIb/PsOLkqz9tmlqxUtUhZfV7eZ6Fr
         2FQ7kiTOa/oByrriQP1WO6CYUPDI7my0wQGnsugPyjm1O/lVpmxacN1ZO/LHP4I+X7lZ
         EPp/vWe+OyoEynrTJ4Ynn2SM2mdS/EACLs6ExR9nBHbzL5Z1rX3LeB4nIUpNPT8IVUAs
         Cw2g==
X-Gm-Message-State: ACrzQf3SToACarIAnnnKPL+QLLEzpyM7TP9aBosZm7w6RMXkP4y/MC6a
        zeto7MzGe6B4WqnnAvRG3yMSGZki0+FZ05cauS5itQ==
X-Google-Smtp-Source: AMsMyM5NBbA1p/O8C5SwbGi0AcNeVinFyL/KvMFQATCH2yesGZ3o6N44PPDjykmrW36mq7lV/cjzxXT8f9+ADa/ddQo=
X-Received: by 2002:a2e:9606:0:b0:26c:442a:40c2 with SMTP id
 v6-20020a2e9606000000b0026c442a40c2mr2302429ljh.458.1663909843228; Thu, 22
 Sep 2022 22:10:43 -0700 (PDT)
MIME-Version: 1.0
References: <20220921030649.1436434-1-bhupesh.sharma@linaro.org>
 <20220921030649.1436434-2-bhupesh.sharma@linaro.org> <YyvKlWgaPVV3su8f@matsya>
In-Reply-To: <YyvKlWgaPVV3su8f@matsya>
From:   Bhupesh Sharma <bhupesh.sharma@linaro.org>
Date:   Fri, 23 Sep 2022 10:40:31 +0530
Message-ID: <CAH=2Ntzi=R9B5rMODfzvriDmxu+7PvRS9f0oT0EYbT8AQkJo0Q@mail.gmail.com>
Subject: Re: [PATCH v7 1/1] dma: qcom: bam_dma: Add support to initialize
 interconnect path
To:     Vinod Koul <vkoul@kernel.org>
Cc:     dmaengine@vger.kernel.org, agross@kernel.org,
        linux-crypto@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, thara.gopinath@gmail.com,
        devicetree@vger.kernel.org, andersson@kernel.org,
        bhupesh.linux@gmail.com, Rob Herring <robh@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 22 Sept 2022 at 08:08, Vinod Koul <vkoul@kernel.org> wrote:
>
> On 21-09-22, 08:36, Bhupesh Sharma wrote:
> > From: Thara Gopinath <thara.gopinath@gmail.com>
> >
> > BAM dma engine associated with certain hardware blocks could require
> > relevant interconnect pieces be initialized prior to the dma engine
> > initialization. For e.g. crypto bam dma engine on sm8250. Such requirement
> > is passed on to the bam dma driver from dt via the "interconnects"
> > property. Add support in bam_dma driver to check whether the interconnect
> > path is accessible/enabled prior to attempting driver intializations.
> >
> > If interconnects are not yet setup, defer the BAM DMA driver probe().
> >
> > Cc: Bjorn Andersson <andersson@kernel.org>
> > Cc: Rob Herring <robh@kernel.org>
> > Signed-off-by: Thara Gopinath <thara.gopinath@gmail.com>
> > Signed-off-by: Bhupesh Sharma <bhupesh.sharma@linaro.org>
> > [Bhupesh: Make header file inclusion alphabetical and use 'devm_of_icc_get()']
> > ---
> >  drivers/dma/qcom/bam_dma.c | 10 ++++++++++
> >  1 file changed, 10 insertions(+)
> >
> > diff --git a/drivers/dma/qcom/bam_dma.c b/drivers/dma/qcom/bam_dma.c
> > index 2ff787df513e..a5b0cf28ffb7 100644
> > --- a/drivers/dma/qcom/bam_dma.c
> > +++ b/drivers/dma/qcom/bam_dma.c
> > @@ -26,6 +26,7 @@
> >  #include <linux/kernel.h>
> >  #include <linux/io.h>
> >  #include <linux/init.h>
> > +#include <linux/interconnect.h>
> >  #include <linux/slab.h>
> >  #include <linux/module.h>
> >  #include <linux/interrupt.h>
> > @@ -394,6 +395,7 @@ struct bam_device {
> >       const struct reg_offset_data *layout;
> >
> >       struct clk *bamclk;
> > +     struct icc_path *mem_path;
> >       int irq;
> >
> >       /* dma start transaction tasklet */
> > @@ -1294,6 +1296,14 @@ static int bam_dma_probe(struct platform_device *pdev)
> >       if (IS_ERR(bdev->bamclk))
> >               return PTR_ERR(bdev->bamclk);
> >
> > +     /* Ensure that interconnects are initialized */
> > +     bdev->mem_path = devm_of_icc_get(bdev->dev, "memory");
> > +     if (IS_ERR(bdev->mem_path)) {
> > +             ret = dev_err_probe(bdev->dev, PTR_ERR(bdev->mem_path),
> > +                                 "failed to acquire icc path\n");
> > +             return ret;
> > +     }
>
> So this makes us fail on older DT where icc path may not be present.
> Should this not be an optional thing?

That's a good point. I am not sure if Thara tried this on platforms
which don't have the icc path available.

I will fix this in v8.

Thanks,
Bhupesh

> > +
> >       ret = clk_prepare_enable(bdev->bamclk);
> >       if (ret) {
> >               dev_err(bdev->dev, "failed to prepare/enable clock\n");
> > --
> > 2.37.1
>
> --
> ~Vinod
