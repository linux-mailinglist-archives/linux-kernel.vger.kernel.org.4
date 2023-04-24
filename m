Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C0D16D031B
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 13:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231479AbjC3L1K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 07:27:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231400AbjC3L1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 07:27:09 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 996979010
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:27:06 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id v20-20020a05600c471400b003ed8826253aso3266997wmo.0
        for <linux-kernel@vger.kernel.org>; Thu, 30 Mar 2023 04:27:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1680175625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=4vLEjge4HC/634Sy2dddnGDaWfI68t9NSMMgZoB4ES4=;
        b=g23YxoWA/fdtoGi5Q8S1/UcET//4AfBMLJu5tWLh1R2KuOwpv1pstZZk+bFrkTt4Eb
         uj+eoGEjvFEDFDm7XM3qUPA+gh9vwByQ1YBP8zqeXtkfClKKYBMqLrhUbD14shvZ6ba8
         oMgZXlA/9G294Cw9A16FWwxTK+9ZWbZlU1EpelS7WvPrIUkaeRfwZuLruvGNhLr8kA9V
         LuAHZbVQiJKNegh0W3g8sYTuRRM16AXCGh1EXVTHQqdO24g82t52RCGyyP7O4jLHJvbr
         OdGVxxbUPTPJPjhWO0Mu0mmWr5rkyB+ptUnsh/Wtuf9VTd+OtiPianvw3yunHRwm0SNg
         YWXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680175625;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=4vLEjge4HC/634Sy2dddnGDaWfI68t9NSMMgZoB4ES4=;
        b=7N7UX2u0fU1gLomaY0TARGoQi5vRuir0N+k5xqLUikg/W+dlDANd/WT+bT6s64JXUT
         44SAe2QNsgpkPEfuMWOmy6ILmnnt33/iCQRu6JbdbViqADm1abmC/XrT6XZdfqGXObwu
         Ss2JGU/96fPt86LoDdiymfSfqyKQD3Oa88QwVzR+n8Clq1F1SHSgE1IfW+DJabq5llYN
         VwkekMoRHWk9P6urGTI4zj2DnWbwlHh0T1rkXTM2wVH1yelI2J/ARMpGLNCE0JEMNZCH
         9tAGbdg4z2gVZGgBsamDTKSyFLWEr9e7w3AmUSPKHx0lQ6RjjJ7hsF2PQHSVQCi/+GPi
         skXg==
X-Gm-Message-State: AO0yUKWnBoUJs7rg3qiomnyVlXD9sEXG6k+b4qN72NVWYVhRb+2v+fND
        f188wisDr6HiAPiZbUxta/LhiA==
X-Google-Smtp-Source: AK7set9o58YWOYgN220KtvaM8vjDT4dxLR7AUi+GpfC1NMvHLZkw/jqx7JuRI7wtoep+Wt+/t5sTDw==
X-Received: by 2002:a05:600c:2254:b0:3df:e41f:8396 with SMTP id a20-20020a05600c225400b003dfe41f8396mr17182048wmm.37.1680175624740;
        Thu, 30 Mar 2023 04:27:04 -0700 (PDT)
Received: from linaro.org ([94.52.112.99])
        by smtp.gmail.com with ESMTPSA id h7-20020a05600c314700b003ef66c89af0sm12310680wmo.0.2023.03.30.04.27.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 04:27:04 -0700 (PDT)
Date:   Thu, 30 Mar 2023 14:27:02 +0300
From:   Abel Vesa <abel.vesa@linaro.org>
To:     Saravana Kannan <saravanak@google.com>,
        Ulf Hansson <ulf.hansson@linaro.org>
Cc:     "Rafael J. Wysocki" <rafael@kernel.org>,
        Kevin Hilman <khilman@kernel.org>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-pm@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        Doug Anderson <dianders@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Android Kernel Team <kernel-team@android.com>
Subject: Re: [PATCH v3 0/4] Allow genpd providers to power off domains on
 sync state
Message-ID: <ZCVyBuKMvDV0gQPW@linaro.org>
References: <20230327193829.3756640-1-abel.vesa@linaro.org>
 <CAGETcx9f1p2esfyzyfU04EAB1FXh=d9-U81DaGyZNjL_Vti3oQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAGETcx9f1p2esfyzyfU04EAB1FXh=d9-U81DaGyZNjL_Vti3oQ@mail.gmail.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23-03-27 17:17:28, Saravana Kannan wrote:
> On Mon, Mar 27, 2023 at 12:38 PM Abel Vesa <abel.vesa@linaro.org> wrote:
> >
> > There have been already a couple of tries to make the genpd "disable
> > unused" late initcall skip the powering off of domains that might be
> > needed until later on (i.e. until some consumer probes). The conclusion
> > was that the provider could return -EBUSY from the power_off callback
> > until the provider's sync state has been reached. This patch series tries
> > to provide a proof-of-concept that is working on Qualcomm platforms.
> 
> I'm giving my thoughts in the cover letter instead of spreading it
> around all the patches so that there's context between the comments.
> 
> 1) Why can't all the logic in this patch series be implemented at the
> framework level? And then allow the drivers to opt into this behavior
> by setting the sync_state() callback.
> 
> That way, you can land it only for QC drivers by setting up
> sync_state() callback only for QC drivers, but actually have the same
> code function correctly for non-QC drivers too. And then once we have
> this functionality working properly for QC drivers for one kernel
> version (or two), we'll just have the framework set the device's
> driver's sync_state() if it doesn't have one already.

I think Ulf has already NACK'ed that approach here:
[1] https://lore.kernel.org/lkml/CAPDyKFon35wcQ+5kx3QZb-awN_S_q8y1Sir-G+GoxkCvpN=iiA@mail.gmail.com/

And suggested this new approach that this patch series proposes.
(Unless I missunderstood his point)

> 
> 2) sync_state() is not just about power on/off. It's also about the
> power domain level. Can you handle that too please?

Well, this patchset only tries to delay the disabling of unused power
domains until all consumers have had a chance to probe. So we use sync
state only to queue up a power-off request to make sure those unused
ones get disabled.

> 
> 3) In your GDSC drivers, it's not clear to me if you are preventing
> power off until sync_state() only for GDSCs that were already on at
> boot. So if an off-at-boot GDSC gets turned on, and then you attempt
> to turn it off before all its consumers have probed, it'll fail to
> power it off even though that wasn't necessary?

I think we can circumvent looking at a GDSC by knowing it there was ever
a power on request since boot. I'll try to come up with something in the
new version.

> 
> 4) The returning -EBUSY when a power off is attempted seems to be
> quite wasteful. The framework will go through the whole sequence of
> trying to power down, send the notifications and then fail and then
> send the undo notifications. Combined with point (2) I think this can
> be handled better at the aggregation level in the framework to avoid
> even going that far into the power off sequence.

Again, have a look at [1] (above).

Ulf, any thoughts on this 4th point?

> 
> -Saravana
> 
> >
> > I've been doing extensive testing on SM8450, but I've also spinned this
> > on my X13s (SC8280XP). Both patches that add the sync state callback to
> > the SC8280XP and SM8450 are here to provide context. Once we agree on
> > the form, I intend to add the sync state callback to all gdsc providers.
> >
> > Currently, some of the gdsc providers might not reach sync state due to
> > list of consumers not probing yet (or at all). The sync state can be
> > enforced by writing 1 to the state_synced sysfs attribute of the
> > provider, thanks to Saravana's commit [1] which has been already merged.
> >
> > [1] https://lore.kernel.org/r/20230304005355.746421-3-saravanak@google.com
> >
> > V2 (RFC) of this patchset was here:
> > https://lore.kernel.org/all/20230320134217.1685781-1-abel.vesa@linaro.org/
> >
> > Changes since v2:
> >  * renamed genpd_queue_power_off_work to pm_genpd_queue_power_off and added
> >    comment about its purpose w.r.t. it being exported.
> >  * added the qcom_cc generic sync state callback to all providers that
> >    register GDSCs, instead of SM8450 and SC8280XP
> >
> > Changes since v1:
> >  * Added the qcom_cc sync state callback which calls in turn the gdsc one
> >  * dropped extra semicolon from pm_domain.h
> >
> > Abel Vesa (4):
> >   PM: domains: Allow power off queuing from providers
> >   soc: qcom: rpmhpd: Do proper power off when state synced
> >   clk: qcom: gdsc: Avoid actual power off until sync state
> >   clk: qcom: Add sync state callback to all providers
> >
> >  drivers/base/power/domain.c            | 18 ++++++++++--------
> >  drivers/clk/qcom/apss-ipq6018.c        |  1 +
> >  drivers/clk/qcom/camcc-sc7180.c        |  1 +
> >  drivers/clk/qcom/camcc-sc7280.c        |  1 +
> >  drivers/clk/qcom/camcc-sdm845.c        |  1 +
> >  drivers/clk/qcom/camcc-sm6350.c        |  1 +
> >  drivers/clk/qcom/camcc-sm8250.c        |  1 +
> >  drivers/clk/qcom/camcc-sm8450.c        |  1 +
> >  drivers/clk/qcom/common.c              | 19 +++++++++++++++++++
> >  drivers/clk/qcom/common.h              |  2 ++
> >  drivers/clk/qcom/dispcc-qcm2290.c      |  1 +
> >  drivers/clk/qcom/dispcc-sc7180.c       |  1 +
> >  drivers/clk/qcom/dispcc-sc7280.c       |  1 +
> >  drivers/clk/qcom/dispcc-sc8280xp.c     |  1 +
> >  drivers/clk/qcom/dispcc-sdm845.c       |  1 +
> >  drivers/clk/qcom/dispcc-sm6115.c       |  1 +
> >  drivers/clk/qcom/dispcc-sm6125.c       |  1 +
> >  drivers/clk/qcom/dispcc-sm6350.c       |  1 +
> >  drivers/clk/qcom/dispcc-sm6375.c       |  1 +
> >  drivers/clk/qcom/dispcc-sm8250.c       |  1 +
> >  drivers/clk/qcom/dispcc-sm8450.c       |  1 +
> >  drivers/clk/qcom/dispcc-sm8550.c       |  1 +
> >  drivers/clk/qcom/gcc-apq8084.c         |  1 +
> >  drivers/clk/qcom/gcc-ipq806x.c         |  1 +
> >  drivers/clk/qcom/gcc-ipq8074.c         |  1 +
> >  drivers/clk/qcom/gcc-mdm9615.c         |  1 +
> >  drivers/clk/qcom/gcc-msm8660.c         |  1 +
> >  drivers/clk/qcom/gcc-msm8909.c         |  1 +
> >  drivers/clk/qcom/gcc-msm8916.c         |  1 +
> >  drivers/clk/qcom/gcc-msm8939.c         |  1 +
> >  drivers/clk/qcom/gcc-msm8953.c         |  1 +
> >  drivers/clk/qcom/gcc-msm8960.c         |  1 +
> >  drivers/clk/qcom/gcc-msm8974.c         |  1 +
> >  drivers/clk/qcom/gcc-msm8976.c         |  1 +
> >  drivers/clk/qcom/gcc-msm8994.c         |  1 +
> >  drivers/clk/qcom/gcc-msm8996.c         |  1 +
> >  drivers/clk/qcom/gcc-msm8998.c         |  1 +
> >  drivers/clk/qcom/gcc-qcm2290.c         |  1 +
> >  drivers/clk/qcom/gcc-qcs404.c          |  1 +
> >  drivers/clk/qcom/gcc-qdu1000.c         |  1 +
> >  drivers/clk/qcom/gcc-sa8775p.c         |  1 +
> >  drivers/clk/qcom/gcc-sc7180.c          |  1 +
> >  drivers/clk/qcom/gcc-sc7280.c          |  1 +
> >  drivers/clk/qcom/gcc-sc8180x.c         |  1 +
> >  drivers/clk/qcom/gcc-sc8280xp.c        |  1 +
> >  drivers/clk/qcom/gcc-sdm660.c          |  1 +
> >  drivers/clk/qcom/gcc-sdm845.c          |  1 +
> >  drivers/clk/qcom/gcc-sdx55.c           |  1 +
> >  drivers/clk/qcom/gcc-sdx65.c           |  1 +
> >  drivers/clk/qcom/gcc-sm6115.c          |  1 +
> >  drivers/clk/qcom/gcc-sm6125.c          |  1 +
> >  drivers/clk/qcom/gcc-sm6350.c          |  1 +
> >  drivers/clk/qcom/gcc-sm6375.c          |  1 +
> >  drivers/clk/qcom/gcc-sm7150.c          |  1 +
> >  drivers/clk/qcom/gcc-sm8150.c          |  1 +
> >  drivers/clk/qcom/gcc-sm8250.c          |  1 +
> >  drivers/clk/qcom/gcc-sm8350.c          |  1 +
> >  drivers/clk/qcom/gcc-sm8450.c          |  1 +
> >  drivers/clk/qcom/gcc-sm8550.c          |  1 +
> >  drivers/clk/qcom/gdsc.c                | 26 ++++++++++++++++++++++++++
> >  drivers/clk/qcom/gdsc.h                |  6 ++++++
> >  drivers/clk/qcom/gpucc-msm8998.c       |  1 +
> >  drivers/clk/qcom/gpucc-sc7180.c        |  1 +
> >  drivers/clk/qcom/gpucc-sc7280.c        |  1 +
> >  drivers/clk/qcom/gpucc-sc8280xp.c      |  1 +
> >  drivers/clk/qcom/gpucc-sdm660.c        |  1 +
> >  drivers/clk/qcom/gpucc-sdm845.c        |  1 +
> >  drivers/clk/qcom/gpucc-sm6115.c        |  1 +
> >  drivers/clk/qcom/gpucc-sm6125.c        |  1 +
> >  drivers/clk/qcom/gpucc-sm6350.c        |  1 +
> >  drivers/clk/qcom/gpucc-sm6375.c        |  1 +
> >  drivers/clk/qcom/gpucc-sm8150.c        |  1 +
> >  drivers/clk/qcom/gpucc-sm8250.c        |  1 +
> >  drivers/clk/qcom/gpucc-sm8350.c        |  1 +
> >  drivers/clk/qcom/lcc-ipq806x.c         |  1 +
> >  drivers/clk/qcom/lpassaudiocc-sc7280.c |  1 +
> >  drivers/clk/qcom/lpasscc-sc7280.c      |  1 +
> >  drivers/clk/qcom/lpasscorecc-sc7180.c  |  2 ++
> >  drivers/clk/qcom/lpasscorecc-sc7280.c  |  2 ++
> >  drivers/clk/qcom/mmcc-apq8084.c        |  1 +
> >  drivers/clk/qcom/mmcc-msm8974.c        |  1 +
> >  drivers/clk/qcom/mmcc-msm8994.c        |  1 +
> >  drivers/clk/qcom/mmcc-msm8996.c        |  1 +
> >  drivers/clk/qcom/mmcc-msm8998.c        |  1 +
> >  drivers/clk/qcom/mmcc-sdm660.c         |  1 +
> >  drivers/clk/qcom/videocc-sc7180.c      |  1 +
> >  drivers/clk/qcom/videocc-sc7280.c      |  1 +
> >  drivers/clk/qcom/videocc-sdm845.c      |  1 +
> >  drivers/clk/qcom/videocc-sm8150.c      |  1 +
> >  drivers/clk/qcom/videocc-sm8250.c      |  1 +
> >  drivers/soc/qcom/rpmhpd.c              | 19 +++++++------------
> >  include/linux/pm_domain.h              |  4 ++++
> >  92 files changed, 161 insertions(+), 20 deletions(-)
> >
> > --
> > 2.34.1
> >
