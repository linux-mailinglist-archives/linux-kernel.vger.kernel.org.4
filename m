Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2340615EF9
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Nov 2022 10:09:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiKBJJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Nov 2022 05:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229650AbiKBJIk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Nov 2022 05:08:40 -0400
Received: from mail-pg1-x533.google.com (mail-pg1-x533.google.com [IPv6:2607:f8b0:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6C7F2037D
        for <linux-kernel@vger.kernel.org>; Wed,  2 Nov 2022 02:08:38 -0700 (PDT)
Received: by mail-pg1-x533.google.com with SMTP id s196so15703429pgs.3
        for <linux-kernel@vger.kernel.org>; Wed, 02 Nov 2022 02:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=HD0bdYs4uYk5v3EHw8KUqVXfFnsjPtpcr4RW87EyNM8=;
        b=psOLh3CR2Munijk8osqBwWon2rheb999k0sR7fQWluVBKKVs4zYnIBNVqm0o7zBmrW
         Jb6hMszS7kp5PfuAVaz4w2xRPDMK4n6IVJT3PVa0xaFZ71A+Wq339qVIW3Rg8E2iv3we
         k77qxRwfP/+h7PRm5AL3004NoD5soLS/IveE6Z6MwnXsaczcF1ZyuqB5hDxaEs3xVk6Q
         XPMeBPQJDC2rKKLtKm6DRNzrU5aVUlyCnjydsMUFPOjChohdREwQ4yocz8pstzCvVdgt
         d7OPsNEqV+e9g1LkdrqV5v8YJ7GO8isnVj1axjPbpnrTKklvPvCRWaRzRwNVNeVzOOzD
         E1dg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=HD0bdYs4uYk5v3EHw8KUqVXfFnsjPtpcr4RW87EyNM8=;
        b=ZvjQKnrIE1cguOuq2mHzQKI8QshekEXatfNxAofFYrhBdu26WcCbq6GELchjBgs+9Z
         wknbsUADQnp/kmqcpUS50RtHHHXKu3LoMrfl81+KY8o2w+OxtrbnqaRNEZuSSxykIs9B
         mJDRt1hWqkh4xWnsQ0hWixlw5LWQRsNRByIJrGs24w/lh1996a31XVwi7VMfg8n52tMk
         af7X4eDn6jZ+sEIlPrhY0sbZxY5IjZpqJe3ihhMbH0kx5dhxZdDrMztSoEKh+Xq4YCXy
         tVcCfgyADWrRkJNMfFy4th6WVbjWtjZPi6HBKL7CAMdMnuqmnHcvulnzIp5WuPxFvfNy
         XR2g==
X-Gm-Message-State: ACrzQf2KXY1+jRfEIysHQjOwOVyiUiblXk5jbrHuvNW4O7gu8CoBmY6e
        JVJvFQbdkrGJs9/Vhgoyih6u
X-Google-Smtp-Source: AMsMyM4WNTqySmX6NVkI0Wj/L6h7nVPA0AUcGX0BpHNKlQUsAVkkgNmAnj59q4LStiF8nqewZM7ViA==
X-Received: by 2002:a05:6a00:2402:b0:52c:81cf:8df8 with SMTP id z2-20020a056a00240200b0052c81cf8df8mr24606462pfh.60.1667380118322;
        Wed, 02 Nov 2022 02:08:38 -0700 (PDT)
Received: from localhost.localdomain ([117.193.209.178])
        by smtp.gmail.com with ESMTPSA id c12-20020a170902d48c00b0017f36638010sm7856126plg.276.2022.11.02.02.08.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 02 Nov 2022 02:08:37 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v4 0/3] qcom-cpufreq-hw: Add CPU clock provider support
Date:   Wed,  2 Nov 2022 14:38:15 +0530
Message-Id: <20221102090818.65321-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS autolearn=no
        autolearn_force=no version=3.4.6
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
 drivers/cpufreq/qcom-cpufreq-hw.c             | 43 +++++++++++++++++++
 3 files changed, 64 insertions(+)

-- 
2.25.1

