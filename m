Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 77E6C62D924
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Nov 2022 12:13:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239589AbiKQLNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Nov 2022 06:13:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239197AbiKQLMy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Nov 2022 06:12:54 -0500
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79A0B6E57B
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:12:13 -0800 (PST)
Received: by mail-pf1-x429.google.com with SMTP id q9so1455212pfg.5
        for <linux-kernel@vger.kernel.org>; Thu, 17 Nov 2022 03:12:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=Q+kPL7DweqXbKMabPBGw/QquMyJ1RbDYYXHcwaM0FwE=;
        b=xprhSrnqe6iVLXMApQ5QvCcwrBxqm0R01HXWBbPqkBFs9M7mjOS7d10cd+5E51Zr4n
         sDEvAPv61XD4S3qCVR3NFwN7MAFe1b9SO8yNZbjwglG7bw5u2seooim3q9e963O1gMfO
         Z5nqMf3Vq2k7Dh36l8fl9pBQLITauO45x3JIpGk50MjogQGLXo10HVk/nf6xCPNd4h4b
         lBGCpUaH9d79CzDqK5iCaoMHbt34XuaWaBQP2H13uY4/de55YRDzCFHlYG+2JZXrTajb
         qcJAdehldjbVZnmP31rJToKQMWiiUbylQPuFvod7c+bE+hKKJWKKIQ2OdIpjdctlSxKU
         Wxtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q+kPL7DweqXbKMabPBGw/QquMyJ1RbDYYXHcwaM0FwE=;
        b=G60uFNUi5v4/eGGs5S4NLb3iqV1qyw7uafF1cSUKq6w7itc55mfr71Mss6d51Pr4jS
         Y75L45o41yll2gJ0OMvfhSmSDTHk+cHvYtUu3vn45W2opq2hPdC4k57IWewHQg7kxoax
         TY8n3BBfN0WaXNT4B4J0yxgPhyElSlOGyYRFbgl8APug4BfGOKHtjRgtNjL+qpYKFrYj
         +oz01eKoLAVcrtUIThPPi9owL4CiVzFrDbAv6llmyTrWBXVYvTeLu1f9+iu51QBJOaMH
         kHAXr+jvWdDGRoRjyDHO0K568Gm6AVhZRIZwPieSuCMneyOkacNbwseemD6q/oBtnLBS
         rybA==
X-Gm-Message-State: ANoB5pk7raFnqqBwo34E6sSYhqWeZhjy2lqPbvZLf7Z80tcjokiCBxCz
        ZgIU3P02ln9qVL5aEOEVXdAj
X-Google-Smtp-Source: AA0mqf6CraUNrRwf8N5tkLMdMOdPO6OeR4eFNGBoT19MrB1AZjOoCTTo46xc4jSH3J5S+EtnXIHBQg==
X-Received: by 2002:a05:6a00:e0f:b0:563:312d:745b with SMTP id bq15-20020a056a000e0f00b00563312d745bmr2400267pfb.69.1668683533264;
        Thu, 17 Nov 2022 03:12:13 -0800 (PST)
Received: from thinkpad ([117.193.208.31])
        by smtp.gmail.com with ESMTPSA id q12-20020a17090311cc00b001888cadf8f6sm1081416plh.49.2022.11.17.03.12.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 17 Nov 2022 03:12:12 -0800 (PST)
Date:   Thu, 17 Nov 2022 16:42:07 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org, johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v7 0/4] qcom-cpufreq-hw: Add CPU clock provider support
Message-ID: <20221117111207.GA93179@thinkpad>
References: <20221117053145.10409-1-manivannan.sadhasivam@linaro.org>
 <20221117101903.sw3hxaruj5sfhybw@bogus>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221117101903.sw3hxaruj5sfhybw@bogus>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Nov 17, 2022 at 10:19:03AM +0000, Sudeep Holla wrote:
> On Thu, Nov 17, 2022 at 11:01:41AM +0530, Manivannan Sadhasivam wrote:
> > Hello,
> > 
> > This series adds clock provider support to the Qcom CPUFreq driver for
> > supplying the clocks to the CPU cores in Qcom SoCs.
> > 
> > The Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply
> > clocks to the CPU cores. But this is not represented clearly in devicetree.
> > There is no clock coming out of the CPUFreq HW node to the CPU. This created
> > an issue [1] with the OPP core when a recent enhancement series was submitted.
> > Eventhough the issue got fixed in the OPP framework in the meantime, that's
> > not a proper solution and this series aims to fix it properly.
> > 
> > There was also an attempt made by Viresh [2] to fix the issue by moving the
> > clocks supplied to the CPUFreq HW node to the CPU. But that was not accepted
> > since those clocks belong to the CPUFreq HW node only.
> > 
> > The proposal here is to add clock provider support to the Qcom CPUFreq HW
> > driver to supply clocks to the CPUs that comes out of the EPSS/OSM block.
> > This correctly reflects the hardware implementation.
> > 
> > The clock provider is a simple one that just provides the frequency of the
> > clocks supplied to each frequency domain in the SoC using .recalc_rate()
> > callback. The frequency supplied by the driver will be the actual frequency
> > that comes out of the EPSS/OSM block after the DCVS operation. This frequency
> > is not same as what the CPUFreq framework has set but it is the one that gets
> > supplied to the CPUs after throttling by LMh.
> > 
> > This series has been tested on SM8450 based dev board with the OPP hack removed
> > and hence there is a DTS change only for that platform. Once this series gets
> > accepted, rest of the platform DTS can also be modified and finally the hack on
> > the OPP core can be dropped.
> > 
> > Thanks,
> > Mani
> > 
> > [1] https://lore.kernel.org/lkml/YsxSkswzsqgMOc0l@hovoldconsulting.com/
> > [2] https://lore.kernel.org/lkml/20220801054255.GA12039@thinkpad/t/
> > 
> > Changes in v7:
> > 
> > * Added a patch that returns the throttled frequency for cpufreq_driver->get()
> >   callback (Sudeep & Viresh)
> > * Added error check for kasprintf and allocated the clk name locally
> > 
> > Changes in v6:
> > 
> > * Removed the local variable clk_name (Matthias)
> > * Added the clock id to the error message of devm_clk_hw_register()
> > 
> > Changes in v5:
> > 
> > * Switched to Hz unit for the CPU clocks
> > 
> > Changes in v4:
> > 
> > * Rebased on top of cpufreq/arm/linux-next branch
> > 
> > Changes in v3:
> > 
> > * Submitted the cpufreq driver cleanup patches as a separate series as
> >   suggested by Viresh
> > * Removed static keyword from clk_init_data declaration
> > 
> > Changes in v2:
> > 
> > * Moved the qcom_cpufreq_data allocation to probe
> > * Added single clock provider with multiple clks for each freq domain
> > * Moved soc_data to qcom_cpufreq struct
> > * Added Rob's review for binding
> > 
> > Manivannan Sadhasivam (4):
> >   dt-bindings: cpufreq: cpufreq-qcom-hw: Add cpufreq clock provider
> >   arm64: dts: qcom: sm8450: Supply clock from cpufreq node to CPUs
> >   cpufreq: qcom-hw: Add CPU clock provider support
> 
> Why do you need the above 3 changes if the below(4/4) will ensure
> cpufreq_get(cpu) returns the clock frequency. I was expecting to drop the
> whole "confusing" clock bindings and the unnecessary clock provider.
> 
> Can't we just use cpufreq_get(cpu) ?
> 

This can be possible for OPP implementations for the CPUs but not for other
peripherals making use of OPP framework like GPU etc... Moreover this may end
up with different code path for CPUs and other peripherals inside OPP framework.

So I don't think it is applicable. But I'll defer it to Viresh.

Thanks,
Mani

> -- 
> Regards,
> Sudeep

-- 
மணிவண்ணன் சதாசிவம்
