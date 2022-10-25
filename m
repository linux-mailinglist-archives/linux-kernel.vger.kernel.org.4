Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4BCC60C53E
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 09:33:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231765AbiJYHdZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 03:33:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59766 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231801AbiJYHdM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 03:33:12 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 529C815200C
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:33:09 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id h185so10721823pgc.10
        for <linux-kernel@vger.kernel.org>; Tue, 25 Oct 2022 00:33:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=bQgCaWbgbYow1rgq+ZxN/4mds+e7cc6gBHNrup7NClQ=;
        b=Rma508W6fqDHDy8X+To2mg/1uAtZ5IaQzmUr+YHjGOFAm4K11fJ25xDB9x97fQxp/3
         pAKuwa1y4LTFa8ZDVIeGc19yNb7KXcCb+0AOl/V3heAVwMucficS7vVofz3MjMfyBIrg
         q2snNTbRNOGZZHmSCdmCsxRXmoPl2il6PecioXpJjR3hpNMVYC5QsBqovcnNEEaaISjg
         3xze1FffCERBHcsduLW2v6CbzBJhCgU6sBtADSoqt+uSNbsh2lekpDISmVou0xgQDKyU
         uNBfwCinnyjyrretyJKoOpQt+rtCZr4OvQ/S3WnEjDRoWOx2HKV7moWlSfKVAaOcALwZ
         NuUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=bQgCaWbgbYow1rgq+ZxN/4mds+e7cc6gBHNrup7NClQ=;
        b=1vxbEdnUemPc5rYY9VOn57cTkAMVb9ojxxDDfQZ0rrxNEflnXTRmn4Fu3A7YOL/Ly6
         eBdtSNsKDDjvX9v1ZWlM6lO9cJpGVd/WSkMwYm+2R0sQTDoZf3dCrci8c+p+eRlSRlPW
         f5Ne+UTX+C61qdwFbU/ZkEMrEmHQbronXvSJNG+3It8lSvS2Qux4dR8hPLsTbumx5h/m
         m1Zug9OEiQP34MgonbmnRBzeuyNaH2NLrGT7uErBfdETWzr7YSjDnxMZYsulTOn33MsK
         Js53J8SQu7wD+gGQjAcM9q/TxB0ty0kalVJOB1OgtUT2jz1uFJ6AUAByd8ujnQgPDw+C
         Fxjg==
X-Gm-Message-State: ACrzQf021lYJVyvP3e4QypbLhrYiwXac6lufFjqpMqCizQGF9tSMgefy
        9E1FlVjN0cgJ82RiSMWe9ea2
X-Google-Smtp-Source: AMsMyM4DsarYjZkBTgiETVgHPPe5/NCMxK4F2rPLgYezcHMrAG64Jaa7kPSXcD3GLtirzsSbLhqGzg==
X-Received: by 2002:a05:6a00:1a47:b0:52e:6a8c:5430 with SMTP id h7-20020a056a001a4700b0052e6a8c5430mr36915826pfv.48.1666683189162;
        Tue, 25 Oct 2022 00:33:09 -0700 (PDT)
Received: from localhost.localdomain ([117.193.211.146])
        by smtp.gmail.com with ESMTPSA id c1-20020a17090a4d0100b0020dda7efe61sm5048369pjg.5.2022.10.25.00.33.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Oct 2022 00:33:06 -0700 (PDT)
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     andersson@kernel.org, viresh.kumar@linaro.org,
        krzysztof.kozlowski+dt@linaro.org, rafael@kernel.org,
        robh+dt@kernel.org
Cc:     johan@kernel.org, devicetree@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org,
        Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
Subject: [PATCH v2 0/7] qcom-cpufreq-hw: Add CPU clock provider support
Date:   Tue, 25 Oct 2022 13:02:47 +0530
Message-Id: <20221025073254.1564622-1-manivannan.sadhasivam@linaro.org>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
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

Changes in v2:

* Moved the qcom_cpufreq_data allocation to probe
* Added single clock provider with multiple clks for each freq domain
* Moved soc_data to qcom_cpufreq struct
* Added Rob's review for binding

Manivannan Sadhasivam (7):
  dt-bindings: cpufreq: cpufreq-qcom-hw: Add cpufreq clock provider
  arm64: dts: qcom: sm8450: Supply clock from cpufreq node to CPUs
  cpufreq: qcom-hw: Remove un-necessary cpumask_empty() check
  cpufreq: qcom-hw: Allocate qcom_cpufreq_data during probe
  cpufreq: qcom-hw: Use cached dev pointer in probe()
  cpufreq: qcom-hw: Move soc_data to struct qcom_cpufreq
  cpufreq: qcom-hw: Add CPU clock provider support

 .../bindings/cpufreq/cpufreq-qcom-hw.yaml     |  12 ++
 arch/arm64/boot/dts/qcom/sm8450.dtsi          |   9 +
 drivers/cpufreq/qcom-cpufreq-hw.c             | 166 ++++++++++--------
 3 files changed, 118 insertions(+), 69 deletions(-)

-- 
2.25.1

