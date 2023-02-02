Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 270AD6884A1
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Feb 2023 17:39:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231716AbjBBQjg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Feb 2023 11:39:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230217AbjBBQje (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Feb 2023 11:39:34 -0500
Received: from mail-il1-x135.google.com (mail-il1-x135.google.com [IPv6:2607:f8b0:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 165871B54E
        for <linux-kernel@vger.kernel.org>; Thu,  2 Feb 2023 08:39:33 -0800 (PST)
Received: by mail-il1-x135.google.com with SMTP id m15so968697ilh.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Feb 2023 08:39:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=ot6L1ecH9+J5351ioCfiXK7b7j3GD/N/gMOwzzurxQE=;
        b=f5j8udaog8zjMPPKGZqIHB3k8DCngfxB2Q7j44u97r9dsxlNmuQgyoyhWWbV0/E1Rv
         9ojM5cksrxhZG8UZOl5OA3CNE72ukkH1UWjHKi2UgvZQ+LT+v8CfOSW1bAaVoLgKsPuT
         00hTXg5TYYSofIAl+McIcTSQwTd2KlEQJBZFw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ot6L1ecH9+J5351ioCfiXK7b7j3GD/N/gMOwzzurxQE=;
        b=ObLh6AL5Kh1JigFPlXvKtFVJVYm23kkDHd/pPnmH68gCNJGqNXWm3JzAi9eWYrzV8+
         pF0BWoxfUm1kMxmfNjJhfT1U+J1KKiRXXRGUXiC9H0dbvCvYFL5+Hje6tq32Vses/ISh
         0rAplPz2tRuMSqBKiiP11BYBRExGrNtp1n18yB5CKnzyyUWpd1ks7E9cz5NIw2928Lnd
         7K83otmYMDgf28OFOPoytbFP03vyxwTjVKqf7os9kXOJJnfJYJUJWIm31Vyxy3heG1vm
         czRfL9ntufSaBEeRjq9c2Xlj5LP18iNdDJfK0MOcH3bRgUqj7AERyjgeIS1BcW8KVxUq
         3WQw==
X-Gm-Message-State: AO0yUKUT9kAVp3KE1qLGcAiE4OnSVA6OnEHjzeNHw5C5cSL9EJ/amKdN
        kht0QuRwTqWYXlafPzbrwO4/ww==
X-Google-Smtp-Source: AK7set8v/Z9VpK+S9jRdYg90eH7l5Y11Tt4SFysEb2res8ONv4zlV1+aY1AtG9vZwR+KIdBTec10Fw==
X-Received: by 2002:a05:6e02:1d03:b0:310:c411:125d with SMTP id i3-20020a056e021d0300b00310c411125dmr5335512ila.12.1675355972412;
        Thu, 02 Feb 2023 08:39:32 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id m14-20020a056e020dee00b0030d6f952221sm25745ilj.75.2023.02.02.08.39.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 02 Feb 2023 08:39:31 -0800 (PST)
Date:   Thu, 2 Feb 2023 16:39:31 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        Vikash Garodia <quic_vgarodia@quicinc.com>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Fritz Koenig <frkoenig@chromium.org>,
        Nathan Hebert <nhebert@chromium.org>,
        regressions@lists.linux.dev
Subject: Re: [REGRESSION][PATCH 2/3] venus: firmware: Correct non-pix start
 and end addresses
Message-ID: <Y9vnQxQlRgVMvowZ@google.com>
References: <20221005083730.963322-1-stanimir.varbanov@linaro.org>
 <20221005083730.963322-3-stanimir.varbanov@linaro.org>
 <Y9LSMap+jRxbtpC8@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <Y9LSMap+jRxbtpC8@google.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 26, 2023 at 07:19:13PM +0000, Matthias Kaehlcke wrote:
> Hi Stanimir,
> 
> On Wed, Oct 05, 2022 at 11:37:29AM +0300, Stanimir Varbanov wrote:
> > The default values for those registers are zero.
> > 
> > Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> > ---
> >  drivers/media/platform/qcom/venus/firmware.c | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> > index 3851cedc3329..71e43611d1cf 100644
> > --- a/drivers/media/platform/qcom/venus/firmware.c
> > +++ b/drivers/media/platform/qcom/venus/firmware.c
> > @@ -38,8 +38,8 @@ static void venus_reset_cpu(struct venus_core *core)
> >  	writel(fw_size, wrapper_base + WRAPPER_FW_END_ADDR);
> >  	writel(0, wrapper_base + WRAPPER_CPA_START_ADDR);
> >  	writel(fw_size, wrapper_base + WRAPPER_CPA_END_ADDR);
> > -	writel(fw_size, wrapper_base + WRAPPER_NONPIX_START_ADDR);
> > -	writel(fw_size, wrapper_base + WRAPPER_NONPIX_END_ADDR);
> > +	writel(0, wrapper_base + WRAPPER_NONPIX_START_ADDR);
> > +	writel(0, wrapper_base + WRAPPER_NONPIX_END_ADDR);
> >  
> >  	if (IS_V6(core)) {
> >  		/* Bring XTSS out of reset */
> 
> I found that this commit prevents the AOSS from entering sleep mode during
> system suspend at least on sc7180 and sc7280. AOSS not entering sleep mode
> leads to a (apparently significant) increase in S3 power consumption, on
> trogdor and herobrine it prevents the system from staying suspended, because
> the embedded controller detect the condition and wakes the sytem up again.
> 
> Testing is slightly involved, since unfortunately this is not the only issue
> in v6.2-rcN that impacts AOSS sleep.
> 
> To reach AOSS sleep you also have to revert this commit:
> 
> 3a39049f88e4 soc: qcom: rpmhpd: Use highest corner until sync_state
> 
> And apply something like the diff below (or enable the bwmon driver).
> 
> On a trogdor device you will see something like this when AOSS doesn't
> enter sleep mode during system suspend:
> 
>   [   32.882869] EC detected sleep transition timeout. Total sleep transitions: 0
>   [   32.882886] WARNING: CPU: 7 PID: 5682 at drivers/platform/chrome/cros_ec.c:146 cros_ec_sleep_event+0x100/0x10c
>   [   32.900393] Modules linked in: uinput veth uvcvideo videobuf2_vmalloc venus_enc venus_dec videobuf2_dma_contig videobuf2_memops onboard_usb_hub cros_ec_typec typec hci_uart btqca xt_MASQUERADE venus_core v4l2_mem2mem videobuf2_v4l2 videobuf2_common qcom_q6v5_mss qcom_pil_v
>   [   32.940015] CPU: 7 PID: 5682 Comm: cat Tainted: G        W          6.1.0-rc2+ #295 d14276115b3f6b03fc99220174e5d7724847cbd6
>   [   32.951525] Hardware name: Google Villager (rev1+) with LTE (DT)
>   [   32.957695] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
>   [   32.964848] pc : cros_ec_sleep_event+0x100/0x10c
>   [   32.969596] lr : cros_ec_sleep_event+0x100/0x10c
> 
> I'm also happy to help with testing if you have a candidate fix.

This change introduced an important regression at least for sc7180 and sc7280,
and probably other QC SoCs, I wonder if it should be reverted unless there is
an obvious better fix.

> diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> index 0adf13399e64..c1f6952764c5 100644
> --- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
> +++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
> @@ -3488,7 +3488,7 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
>                 };
> 
>                 pmu@9091000 {
> 		-                       compatible = "qcom,sc7280-llcc-bwmon";
> 		+                       // compatible = "qcom,sc7280-llcc-bwmon";
> 		                        reg = <0 0x9091000 0 0x1000>;
> 
>                         interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
> 			@@ -3528,7 +3528,7 @@ opp-7 {
> 			                };
> 
>                 pmu@90b6400 {
> 		-                       compatible = "qcom,sc7280-cpu-bwmon", "qcom,msm8998-bwmon";
> 		+                       // compatible = "qcom,sc7280-cpu-bwmon", "qcom,msm8998-bwmon";
> 		                        reg = <0 0x090b6400 0 0x600>;
> 
>                         interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
