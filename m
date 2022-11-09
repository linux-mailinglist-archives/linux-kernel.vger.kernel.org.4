Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1216E6224FE
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Nov 2022 09:01:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229731AbiKIIBl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Nov 2022 03:01:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbiKIIBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Nov 2022 03:01:38 -0500
Received: from mail-wm1-x332.google.com (mail-wm1-x332.google.com [IPv6:2a00:1450:4864:20::332])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1516167D3
        for <linux-kernel@vger.kernel.org>; Wed,  9 Nov 2022 00:01:36 -0800 (PST)
Received: by mail-wm1-x332.google.com with SMTP id t25-20020a1c7719000000b003cfa34ea516so2050967wmi.1
        for <linux-kernel@vger.kernel.org>; Wed, 09 Nov 2022 00:01:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=yhDGMUAJ/8+pgpJNQg1TQbjn1AXs8DB1HpGyR9GVzcs=;
        b=VxroMqW0lKOYqYNetofEu6ca+iX/+spminKk/i6p/iX8XmzD9TjYhFrInOjtZ65viO
         iZYVAZW3E4ATiN462+oNO/9P/9lmSaXxHaIlGVzSjEU0LQPV9C/4cqDiUiBQ9t6saq6L
         kWNVj0FJ0uEpdXtoI5pT0YZB/jyj9OUgFrO6Xa6sKeA1jAWGp3RbS/ENKalT1i1exLrc
         ldcho/1VU1/DIikxijZ0xbF4covuiiT5fVUP9c5t2olVRcQB+sDXBRnzo8stezzPMdjE
         P24/2fSXu2MAOV2JAM/IClFJQItws9+33/X+IqjvjpFO6qNfjHegr/yGGmt0J/k/shAn
         NnsA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=yhDGMUAJ/8+pgpJNQg1TQbjn1AXs8DB1HpGyR9GVzcs=;
        b=cr4gUBflEzTNVH531wCgxg9eV8lltp5bkn9CkMQ1/jhu84jSt6rXOBiCqSZwKNqJkU
         7KgBjFr32p5ITUVAPod31LUU7WCZMzvVDA2u4q/AeLChUTO4/IXJ7I2W3ZAfP3//YNpj
         T8RCJkssVtPpe4CUGMOaWMCyl0gECpjbrse32YVXJ1cBzO3iUYtmSGmA/sFIKhzoAuAF
         FYlaN375Yl6+/zG00DtOIoPWWoz8GPRMke82E/u439RvA/aI446jJnirHdNmnxIDoKWC
         E9c5MCbV9sFivAXFRFTVMuCz8JVN6MRnehoirdZmtGJ79jO8bBRUiD93DWHSoXk5+yQ8
         ns4w==
X-Gm-Message-State: ACrzQf2cnns2NCJjLiYuVCiCmkI2RHL+tUY4TmeKqpj7C7hxRCbtv0Tf
        Pja/J6VgMn6D61qFSNURWXc/
X-Google-Smtp-Source: AMsMyM4TH5hrY0p/CREqR3/LAKWyI/Ih9vAEa88lR6VMnzKNsSGiSdeV/K/bKfxtY8p/tHgiY29SZg==
X-Received: by 2002:a7b:cb87:0:b0:3cf:6af4:c509 with SMTP id m7-20020a7bcb87000000b003cf6af4c509mr36538317wmi.140.1667980895367;
        Wed, 09 Nov 2022 00:01:35 -0800 (PST)
Received: from localhost.localdomain ([117.202.189.229])
        by smtp.gmail.com with ESMTPSA id l26-20020a05600c2cda00b003cf774c31a0sm769427wmc.16.2022.11.09.00.01.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 09 Nov 2022 00:01:33 -0800 (PST)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v6 0/3] qcom-cpufreq-hw: Add CPU clock provider support
Date:   Wed,  9 Nov 2022 13:31:17 +0530
Message-Id: <20221109080120.19078-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello,

This series adds clock provider support to the Qcom CPUFreq driver for
supplying the clocks to the CPU cores in Qcom SoCs.

The Qualcomm platforms making use of CPUFreq HW Engine (EPSS/OSM) supply
clocks to the CPU cores. But this is not represented clearly in devicetree.
There is no clock coming out of the CPUFreq HW node to the CPU. This created
an issue [1] with the OPP core when a recent enhancement series was submitted.
Eventhough the issue got fixed in the OPP framework in the meantime, that's
not a proper solution and this series aims to fix it properly.

There was also an attempt made by Viresh [2] to fix the issue by moving the
clocks supplied to the CPUFreq HW node to the CPU. But that was not accepted
since those clocks belong to the CPUFreq HW node only.

The proposal here is to add clock provider support to the Qcom CPUFreq HW
driver to supply clocks to the CPUs that comes out of the EPSS/OSM block.
This correctly reflects the hardware implementation.

The clock provider is a simple one that just provides the frequency of the
clocks supplied to each frequency domain in the SoC using .recalc_rate()
callback. The frequency supplied by the driver will be the actual frequency
that comes out of the EPSS/OSM block after the DCVS operation. This frequency
is not same as what the CPUFreq framework has set but it is the one that gets
supplied to the CPUs after throttling by LMh.

This series has been tested on SM8450 based dev board with the OPP hack removed
and hence there is a DTS change only for that platform. Once this series gets
accepted, rest of the platform DTS can also be modified and finally the hack on
the OPP core can be dropped.

Thanks,
Mani

[1] https://lore.kernel.org/lkml/YsxSkswzsqgMOc0l@hovoldconsulting.com/
[2] https://lore.kernel.org/lkml/20220801054255.GA12039@thinkpad/t/

Changes in v6:

* Removed the local variable clk_name (Matthias)
* Added the clock id to the error message of devm_clk_hw_register()

Changes in v5:

* Switched to Hz unit for the CPU clocks

Changes in v4:

* Rebased on top of cpufreq/arm/linux-next branch

Changes in v3:

* Submitted the cpufreq driver cleanup patches as a separate series as
  suggested by Viresh
* Removed static keyword from clk_init_data declaration

Changes in v2:

* Moved the qcom_cpufreq_data allocation to probe
* Added single clock provider with multiple clks for each freq domain
* Moved soc_data to qcom_cpufreq struct
* Added Rob's review for binding

Manivannan Sadhasivam (3):
  dt-bindings: cpufreq: cpufreq-qcom-hw: Add cpufreq clock provider
  arm64: dts: qcom: sm8450: Supply clock from cpufreq node to CPUs
  cpufreq: qcom-hw: Add CPU clock provider support

 .../bindings/cpufreq/cpufreq-qcom-hw.yaml     | 12 ++++++
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |  9 ++++
 drivers/cpufreq/qcom-cpufreq-hw.c             | 41 +++++++++++++++++++
 3 files changed, 62 insertions(+)

-- 
2.25.1

