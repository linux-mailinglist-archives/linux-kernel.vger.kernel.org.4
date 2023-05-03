Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C21D16F5168
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:28:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229799AbjECH2Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:28:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229766AbjECH1r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:27:47 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 024D249F9;
        Wed,  3 May 2023 00:27:18 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-959a3e2dd27so926788066b.3;
        Wed, 03 May 2023 00:27:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683098836; x=1685690836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=kwi9ORlZc7hKI5IKGQjv7FwDWDdxvIkp9fio8PSzkaI=;
        b=MDztZQnlaHhSODJX4osvghLx5ApZw4yayLTFza8uZUYiRFNvX7qw9timaQ3BH+OsAf
         330kd2SVJZscnXbTTKX8hsZh6bO1rVSifGDFSsoaa64G4m7TxDYJiSrppODqTlcmYZGT
         14mjI3uB9d787JBSLcOHsf8YiI7G2FpRWky+BU+DYO+MrfpgSstcRpHAcV5MixIrkK6Y
         3CttbqMBotM6oN7KBtR+bhC67JruKko7FDxXHmteLP+pANOvP8S/cuiRH7Qb1GfgvHS/
         JqhUCG8hfGQGAIOyBD8cTFU/ElEyf04XPhGEC2PXA9Tj2k5YK1QjY/kYkavfAQy3Stbl
         Mh9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683098836; x=1685690836;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=kwi9ORlZc7hKI5IKGQjv7FwDWDdxvIkp9fio8PSzkaI=;
        b=MbPDzxu0XWLO9B0MqFRQZ4AxmhB8yPUbJzD0zZ8/caRsKKx8c66T9MF7WowBTkcUjZ
         66wpEnFtDC6frEyuHhQUVfpopeT1DxxU9gMdxKsP/lDHDs0l0havJ2SUgE/cFerru5n5
         bbMCMgX+lRxgHt/lFEapM9meO6ATRPqcWBQSoD06IuTWrzHcoETIkcxu0UH5dMgMyKh7
         2OUhRGecHuEDR43w+w0tHVTiyfI9065sJrRgb2r4/rHap8FfszFEAd67slQMMvcLGq3L
         UdQjH/cMmRWToCz1GbMahS/eOba0wFx+1JbzPBtGilInOE2pUQCQPP/FI5Idq9e6Bo9s
         j+EQ==
X-Gm-Message-State: AC+VfDxnEfxREddpiB67tM4wLQXvEb1AlYbjJvSTnQg4eyFzHhAxOcoD
        Q8w+WRbi3/uJRQaQzM4aBxY=
X-Google-Smtp-Source: ACHHUZ7BdwcbgAAtyizy0n7UtpDwVm66pU7k/DmSvFnp2U3uXMUoXj8ns5pRVoywu5iJP0770DMYyQ==
X-Received: by 2002:a17:907:a088:b0:957:758e:df57 with SMTP id hu8-20020a170907a08800b00957758edf57mr2595941ejc.65.1683098836130;
        Wed, 03 May 2023 00:27:16 -0700 (PDT)
Received: from localhost.localdomain ([95.183.227.33])
        by smtp.gmail.com with ESMTPSA id t26-20020a1709064f1a00b0094f34fe27c6sm17072009eju.170.2023.05.03.00.27.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 03 May 2023 00:27:15 -0700 (PDT)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Robert Foss <rfoss@kernel.org>, Todor Tomov <todor.too@gmail.com>,
        "Bryan O'Donoghue" <bryan.odonoghue@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Hans Verkuil <hansverk@cisco.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        Vladimir Zapolskiy <vladimir.zapolskiy@linaro.org>,
        linux-media@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] media: camss: Link CAMSS power domain on MSM8996
Date:   Wed,  3 May 2023 10:25:40 +0300
Message-Id: <20230503072543.4837-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.40.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yassine Oudjana <y.oudjana@protonmail.com>

CAMSS on MSM8996 has been broken since commit
46cc03175498 (media: camss: Split power domain management, 2022-07-04).

This would happen when trying to start streaming:

[  199.097810] ------------[ cut here ]------------
[  199.097893] camss_top_ahb_clk status stuck at 'off'
[  199.097913] WARNING: CPU: 3 PID: 728 at drivers/clk/qcom/clk-branch.c:91 clk_branch_wait+0x140/0x160
...
[  199.100064]  clk_branch_wait+0x140/0x160
[  199.100112]  clk_branch2_enable+0x30/0x40
[  199.100159]  clk_core_enable+0x6c/0xb0
[  199.100211]  clk_enable+0x2c/0x50
[  199.100257]  camss_enable_clocks+0x94/0xe0 [qcom_camss]
[  199.100342]  csiphy_set_power+0x154/0x2a0 [qcom_camss]
...
[  199.101594] ---[ end trace 0000000000000000 ]---
[  199.101736] qcom-camss a34000.camss: clock enable failed: -16
[  199.101813] qcom-camss a34000.camss: Failed to power up pipeline: -16

Turns out camss_top_ahb_clk needs the CAMSS power domain to be on. Before the change,
VFE power domains were enabled before CSIPHY enabled clocks, and since the CAMSS power
domain was their parent, it got enabled as well. With the VFE power domains now enabled
after CSIPHY is powered on, the CAMSS power domain remains off and things go south when
CSIPHY tries to enable camss_top_ahb_clk.

Link the CAMSS power domain in camss_configure_pd to make sure it gets enabled before
CSIPHY tries to enable clocks.

Yassine Oudjana (3):
  media: dt-bindings: media: camss: qcom,msm8996-camss: Add CAMSS power
    domain and power-domain-names
  arm64: dts: qcom: msm8996: Add CAMSS power domain and
    power-domain-names to CAMSS
  media: camss: Link CAMSS power domain

 .../bindings/media/qcom,msm8996-camss.yaml          | 13 ++++++++++++-
 arch/arm64/boot/dts/qcom/msm8996.dtsi               |  4 +++-
 drivers/media/platform/qcom/camss/camss.c           |  9 ++++++++-
 3 files changed, 23 insertions(+), 3 deletions(-)

-- 
2.40.0

