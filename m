Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BE9F46A5BA6
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Feb 2023 16:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229866AbjB1PYj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Feb 2023 10:24:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229589AbjB1PYi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Feb 2023 10:24:38 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93D8F23DA0
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:24:36 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id t11so13740520lfr.1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Feb 2023 07:24:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1677597874;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=aI56kuSWxT4TrsLktrCrgX22+GnDNJwi2SymVz5W1rM=;
        b=CKRKEOazx9RYMP3ZHh9CuU4bkfKJxVlXG6s1tkT3XzB6Fkpo+u232E9v1VrqQ/+1mL
         lncAZfYrZQCD40Cdwn8PD5tJm73OwXr9Zpys1jcriNvFCJiwJ2mYDCcPXNcXB2NHDY2n
         edoTxN7lISaYgqgcv+9dpnRxfUIaz9DCzqKZTfp46TPcm8F2MGfXV5U/wCcESyn/SaVz
         MntmPvtM90TYb/GRXvMzOeX6y8feRlSVRwt0lWR+2ZstdeOWNF03clcyxEbm/D3KLMml
         onSE/4v4XxywBfHMp3M0WOSPA48+bq18Tdk+qSy9QUn970aaj0kKBm9dm4/eWKCqh95h
         qlkA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677597874;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=aI56kuSWxT4TrsLktrCrgX22+GnDNJwi2SymVz5W1rM=;
        b=1oZeqChBthxR8CjhXFZPDj6IvqIpedYJMEo0tPDNM7f+Z4O6sNZkSEvuBjO7Mj8h4s
         vaxXi3R7EA4Y3eSYDnNe3XYUglwdrZGI34SBBpGVQQtFtY3kFZ+PzWl3W2Ui2DTFHWQ3
         dfM8leg0D0gm7VJzzJV3+Zj27N3BVvIfAyKn0INHJI8QEJuUQN4eNn8qzBnQf9su5Dve
         u/znTfEZfLMDhr8AjasFPyefJMa2/oC3R2LBbCD0SLCe7Z9+2FComEDTAhzh3WOJjtpG
         FFjP25uPDc13vsnwoK7zR5o2ALepp+uDs7pNi8CcE40wJo4hpvJLq9jLIytxU2ZKecDM
         ZoQg==
X-Gm-Message-State: AO0yUKWL9eFUvWRvfrOsQ/RuKix0gwL4l/MoDw0DaE41dOGuKjGmy+0Z
        B3+jvjrVGSmnES2xxJ02d8vOT9uyY7Z8EbV0
X-Google-Smtp-Source: AK7set8DRZKi9ihH+cPAgVxlOU5aLACvrdDluRPzRkzKIxnXdJqurdaHmBpL+VVM8gdHkIEQnGTv+g==
X-Received: by 2002:ac2:4827:0:b0:4df:51a7:a92 with SMTP id 7-20020ac24827000000b004df51a70a92mr739011lft.11.1677597873874;
        Tue, 28 Feb 2023 07:24:33 -0800 (PST)
Received: from [192.168.1.101] (abym99.neoplus.adsl.tpnet.pl. [83.9.32.99])
        by smtp.gmail.com with ESMTPSA id h17-20020ac250d1000000b004db3aa3c542sm1363688lfm.47.2023.02.28.07.24.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Feb 2023 07:24:33 -0800 (PST)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH 00/18] Venus QoL / maintainability fixes
Date:   Tue, 28 Feb 2023 16:24:24 +0100
Message-Id: <20230228-topic-venus-v1-0-58c2c88384e9@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIAKgc/mMC/x2N0QqDMAwAf0XybKCrYMt+Zeyh7bI1IFEaFUH8d
 8Me7+C4E5Qak8KzO6HRzsqzGDz6DkpN8iPkjzF45wfnfcR1XrjgTrIpBkdpyCWMY4xgRU5KmFu
 SUq2RbZpMLo2+fPwXr/d13Xw07GRyAAAA
To:     Stanimir Varbanov <stanimir.k.varbanov@gmail.com>,
        Vikash Garodia <quic_vgarodia@quicinc.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Dikshita Agarwal <dikshita@qti.qualcomm.com>,
        Bryan O'Donoghue <bryan.odonoghue@linaro.org>,
        Dikshita Agarwal <dikshita@codeaurora.org>,
        Mansur Alisha Shaik <mansur@codeaurora.org>,
        Jonathan Marek <jonathan@marek.ca>
Cc:     Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        Stanimir Varbanov <stanimir.varbanov@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Vikash Garodia <vgarodia@codeaurora.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.1
X-Developer-Signature: v=1; a=ed25519-sha256; t=1677597872; l=3038;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=8AvVVQF7f0Tqu+/GJiDr3Nyrd59p4wMcFcXD+zOKav0=;
 b=ZBD9ff3RDBest+K5oqwkr1GqvYmkJ11ewLwwYbPOl78YiIU4kgPZhIx/SfaKC2pYAreIIGr5AJsI
 U/Mn2MxwBLYwPCfys7+mZ7lh11RmBpYFlHL/wIm4csGJHirVmqY6
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently upstream assumes all (well, almost all - see 7280 or CrOS
specific checks) Venus implementations using the same version of the
Hardware Firmware Interface can be treated the same way. This is
however not the case.

This series tries to introduce the groundwork to start differentiating
them based on the VPU (Video Processing Unit) hardware type, fixes a
couple of issues that were an effect of that generalized assumption
and lays the foundation for supporting 8150 (IRIS1) and SM6115/QCM2290
(AR50 Lite), which will hopefully come soon.

Tested on 8250, but pretty please test it on your boards too!

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (18):
      media: venus: hfi_venus: Set venus_sys_idle_indicator to false on V6
      media: venus: Introduce VPU version distinction
      media: venus: Add vpu_version to most SoCs
      media: venus: firmware: Leave a clue for homegrown porters
      media: venus: hfi_venus: Sanitize venus_boot_core() per-VPU-version
      media: venus: hfi_venus: Write to VIDC_CTRL_INIT after unmasking interrupts
      media: venus: core: Assign registers based on VPU version
      media: venus: hfi_venus: Fix version checks in venus_halt_axi()
      media: venus: hfi_venus: Fix version checks in venus_isr()
      media: venus: hfi_venus: Fix version check in venus_cpu_and_video_core_idle()
      media: venus: hfi_venus: Fix version check in venus_cpu_idle_and_pc_ready()
      media: venus: firmware: Correct IS_V6() checks
      media: venus: hfi_platform: Check vpu_version instead of device compatible
      media: venus: vdec: Fix version check in vdec_set_work_route()
      media: venus: Remap bufreq fields on HFI6XX
      media: venus: Introduce accessors for remapped hfi_buffer_reqs members
      media: venus: Use newly-introduced hfi_buffer_requirements accessors
      media: venus: hfi_venus: Restrict writing SCIACMDARG3 to Venus V1/V2

 drivers/media/platform/qcom/venus/core.c           |  7 ++-
 drivers/media/platform/qcom/venus/core.h           | 15 ++++++
 drivers/media/platform/qcom/venus/firmware.c       | 20 +++++--
 drivers/media/platform/qcom/venus/helpers.c        |  7 +--
 drivers/media/platform/qcom/venus/hfi_helper.h     | 61 +++++++++++++++++++---
 drivers/media/platform/qcom/venus/hfi_msgs.c       |  2 +-
 .../media/platform/qcom/venus/hfi_plat_bufs_v6.c   | 22 ++++----
 drivers/media/platform/qcom/venus/hfi_platform.c   |  2 +-
 drivers/media/platform/qcom/venus/hfi_venus.c      | 29 +++++-----
 drivers/media/platform/qcom/venus/vdec.c           | 10 ++--
 drivers/media/platform/qcom/venus/vdec_ctrls.c     |  2 +-
 drivers/media/platform/qcom/venus/venc.c           |  4 +-
 drivers/media/platform/qcom/venus/venc_ctrls.c     |  2 +-
 13 files changed, 132 insertions(+), 51 deletions(-)
---
base-commit: 058f4df42121baadbb8a980c06011e912784dbd2
change-id: 20230228-topic-venus-70ea3bc76688

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

