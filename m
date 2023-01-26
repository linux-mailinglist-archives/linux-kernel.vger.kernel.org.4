Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B79A67D544
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 20:19:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232043AbjAZTTU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 14:19:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59876 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229531AbjAZTTR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 14:19:17 -0500
Received: from mail-il1-x12c.google.com (mail-il1-x12c.google.com [IPv6:2607:f8b0:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D38054209
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:19:15 -0800 (PST)
Received: by mail-il1-x12c.google.com with SMTP id g16so1207254ilr.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 11:19:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=cZz77IiOmTXjxpIQn9VIxxQTtn+oWpcv1UvGfAoxk1Y=;
        b=LAWxeYrVBxWMMwcgBsn7pEWXxE4UGESq9f25C2xP9QvowropQk9kAGLyBGg4ce6A8+
         oRpFeyw1zE2Pk34nrLKD+UB9topakGySH5ozV3cwcmOVnnwmAhPX+5epVhYu5X0WKS7b
         3foB3Y9PF88+rA+3huXV9Iub3mQ9bmxGa9ToA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=cZz77IiOmTXjxpIQn9VIxxQTtn+oWpcv1UvGfAoxk1Y=;
        b=w8Oi406D1YLpfwLHURBGnHYjB70NeXaGRwvW1W7jgAbut1JZGrFi02FqPatyJ2h7hZ
         4rBqnVgXONR5u76WxwoXHVcLdKPEddr48EROu1/sFf0QqG8ndej2HN7aNQG1BQB741fZ
         Qypg/EgxUxekpp15IlzdtssxvCeQPpRjQ5prLOAFb7GRif3hPiYVc20dM5Pt/LsoAf53
         DHi0eVLabMT7WlkibnRiQCdrQuzXNMKTrmhtmenUw1EMEeOBHdRwshYZLKVF1eN4J+Jk
         SRc9xX0zXCKqK78cvr5x2H+iOCc71Coj5WUjk8lxS83D457bZNaljAwFjTZ21/yGOUnY
         PbgA==
X-Gm-Message-State: AO0yUKXoHnl05n1luR4XQRAwC6ff2HmlwGqRb/YwWGlhR6l5Wa8OhtcV
        ikOkL+jYofWkLNO6K+uj6Jbi5w==
X-Google-Smtp-Source: AK7set9a3lo30KgC8wBrwxCGVr9Ul78Wd9CZpSjzGhw/+UNEuPpX66X6l8uMOn8Xdwas6+FgH5Jeuw==
X-Received: by 2002:a05:6e02:154e:b0:310:a8a0:338d with SMTP id j14-20020a056e02154e00b00310a8a0338dmr5369211ilu.28.1674760754513;
        Thu, 26 Jan 2023 11:19:14 -0800 (PST)
Received: from localhost (30.23.70.34.bc.googleusercontent.com. [34.70.23.30])
        by smtp.gmail.com with UTF8SMTPSA id l35-20020a026663000000b0039e5418fb01sm686007jaf.73.2023.01.26.11.19.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 11:19:13 -0800 (PST)
Date:   Thu, 26 Jan 2023 19:19:13 +0000
From:   Matthias Kaehlcke <mka@chromium.org>
To:     Stanimir Varbanov <stanimir.varbanov@linaro.org>
Cc:     linux-media@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org,
        Fritz Koenig <frkoenig@chromium.org>,
        Nathan Hebert <nhebert@chromium.org>
Subject: Re: [PATCH 2/3] venus: firmware: Correct non-pix start and end
 addresses
Message-ID: <Y9LSMap+jRxbtpC8@google.com>
References: <20221005083730.963322-1-stanimir.varbanov@linaro.org>
 <20221005083730.963322-3-stanimir.varbanov@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20221005083730.963322-3-stanimir.varbanov@linaro.org>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stanimir,

On Wed, Oct 05, 2022 at 11:37:29AM +0300, Stanimir Varbanov wrote:
> The default values for those registers are zero.
> 
> Signed-off-by: Stanimir Varbanov <stanimir.varbanov@linaro.org>
> ---
>  drivers/media/platform/qcom/venus/firmware.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/media/platform/qcom/venus/firmware.c b/drivers/media/platform/qcom/venus/firmware.c
> index 3851cedc3329..71e43611d1cf 100644
> --- a/drivers/media/platform/qcom/venus/firmware.c
> +++ b/drivers/media/platform/qcom/venus/firmware.c
> @@ -38,8 +38,8 @@ static void venus_reset_cpu(struct venus_core *core)
>  	writel(fw_size, wrapper_base + WRAPPER_FW_END_ADDR);
>  	writel(0, wrapper_base + WRAPPER_CPA_START_ADDR);
>  	writel(fw_size, wrapper_base + WRAPPER_CPA_END_ADDR);
> -	writel(fw_size, wrapper_base + WRAPPER_NONPIX_START_ADDR);
> -	writel(fw_size, wrapper_base + WRAPPER_NONPIX_END_ADDR);
> +	writel(0, wrapper_base + WRAPPER_NONPIX_START_ADDR);
> +	writel(0, wrapper_base + WRAPPER_NONPIX_END_ADDR);
>  
>  	if (IS_V6(core)) {
>  		/* Bring XTSS out of reset */

I found that this commit prevents the AOSS from entering sleep mode during
system suspend at least on sc7180 and sc7280. AOSS not entering sleep mode
leads to a (apparently significant) increase in S3 power consumption, on
trogdor and herobrine it prevents the system from staying suspended, because
the embedded controller detect the condition and wakes the sytem up again.

Testing is slightly involved, since unfortunately this is not the only issue
in v6.2-rcN that impacts AOSS sleep.

To reach AOSS sleep you also have to revert this commit:

3a39049f88e4 soc: qcom: rpmhpd: Use highest corner until sync_state

And apply something like the diff below (or enable the bwmon driver).

On a trogdor device you will see something like this when AOSS doesn't
enter sleep mode during system suspend:

  [   32.882869] EC detected sleep transition timeout. Total sleep transitions: 0
  [   32.882886] WARNING: CPU: 7 PID: 5682 at drivers/platform/chrome/cros_ec.c:146 cros_ec_sleep_event+0x100/0x10c
  [   32.900393] Modules linked in: uinput veth uvcvideo videobuf2_vmalloc venus_enc venus_dec videobuf2_dma_contig videobuf2_memops onboard_usb_hub cros_ec_typec typec hci_uart btqca xt_MASQUERADE venus_core v4l2_mem2mem videobuf2_v4l2 videobuf2_common qcom_q6v5_mss qcom_pil_v
  [   32.940015] CPU: 7 PID: 5682 Comm: cat Tainted: G        W          6.1.0-rc2+ #295 d14276115b3f6b03fc99220174e5d7724847cbd6
  [   32.951525] Hardware name: Google Villager (rev1+) with LTE (DT)
  [   32.957695] pstate: 60400009 (nZCv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  [   32.964848] pc : cros_ec_sleep_event+0x100/0x10c
  [   32.969596] lr : cros_ec_sleep_event+0x100/0x10c

I'm also happy to help with testing if you have a candidate fix.

Thanks

Matthias

--

diff --git a/arch/arm64/boot/dts/qcom/sc7280.dtsi b/arch/arm64/boot/dts/qcom/sc7280.dtsi
index 0adf13399e64..c1f6952764c5 100644
--- a/arch/arm64/boot/dts/qcom/sc7280.dtsi
+++ b/arch/arm64/boot/dts/qcom/sc7280.dtsi
@@ -3488,7 +3488,7 @@ IPCC_MPROC_SIGNAL_GLINK_QMP
                };

                pmu@9091000 {
		-                       compatible = "qcom,sc7280-llcc-bwmon";
		+                       // compatible = "qcom,sc7280-llcc-bwmon";
		                        reg = <0 0x9091000 0 0x1000>;

                        interrupts = <GIC_SPI 81 IRQ_TYPE_LEVEL_HIGH>;
			@@ -3528,7 +3528,7 @@ opp-7 {
			                };

                pmu@90b6400 {
		-                       compatible = "qcom,sc7280-cpu-bwmon", "qcom,msm8998-bwmon";
		+                       // compatible = "qcom,sc7280-cpu-bwmon", "qcom,msm8998-bwmon";
		                        reg = <0 0x090b6400 0 0x600>;

                        interrupts = <GIC_SPI 581 IRQ_TYPE_LEVEL_HIGH>;
