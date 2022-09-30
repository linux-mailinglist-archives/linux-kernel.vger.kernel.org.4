Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42B165F0EC8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 17:27:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230349AbiI3P1D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 11:27:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230269AbiI3P03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 11:26:29 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5083176AEF
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:26:27 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id w2so4567269pfb.0
        for <linux-kernel@vger.kernel.org>; Fri, 30 Sep 2022 08:26:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=qqaXXPlV6Wdvn0q4C8VxTCjIDz9FmR2A+6qQXG2ZJns=;
        b=gCcfVV/zSnJay0WYnNCCNUWo4DFfs5NuKiTxpuFCphK1JY0qj18utpAEjLilDYgDlt
         cYH4mX3UfFnwfJ3UNxYZqLQCcz98l5gya4240LU6e0o1wXW9HCJdriUAfsdYy2KfAUPs
         0joRdNwNDk9zxUuXrh/yrTARjuxDlOHbbyL78=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=qqaXXPlV6Wdvn0q4C8VxTCjIDz9FmR2A+6qQXG2ZJns=;
        b=jk9EfHBoh0ePF6VCB+WqjvLotrwtUUGZ5rF0dA94+MtHSDfQgJvNCLb3pztREvjw+Y
         EqF3imtXahWI1Vdn1gozHs1lCytN2dTeexzS+YhQr5SieMQKDYy9EY56qbI4DE0IS7hO
         48vFr4Hbzz2ciCWbDW6mzSmEgTPJyjreUAu0e5oO7YZuTS154W1pgcBHhEOhjWGuuRkt
         aeRjjfUZPOu4PizUl8Q7IrT/qYgRlGULUOOYWpuTN3i6MouZPwoACWOLFZKj9aTpi70N
         L66Dv8W8VS13U4dlzxLDkOU228aV3v/8X1FqnYNF+hjsm5b109DFDDQcy7K08KAd9W1D
         EaQg==
X-Gm-Message-State: ACrzQf1VEvNXSXxtJtBQP97rvp3WuAh8lxnEEdvcj/+jgLafxpdEu1mw
        fUPqqoBjOQKHODgjD1l4uDndedZzftYUGQ==
X-Google-Smtp-Source: AMsMyM6LUDVpJhHQIDBlqA+M7jWUWG9GEp4Ez+lDpKjYYFpwjAhG0EUXyiWUcJjEZx6uWqCN5aKg6w==
X-Received: by 2002:aa7:838a:0:b0:536:101a:9ccf with SMTP id u10-20020aa7838a000000b00536101a9ccfmr9693169pfm.18.1664551587429;
        Fri, 30 Sep 2022 08:26:27 -0700 (PDT)
Received: from judyhsiao0523.c.googlers.com.com (21.160.199.104.bc.googleusercontent.com. [104.199.160.21])
        by smtp.gmail.com with ESMTPSA id o9-20020a170902d4c900b0016dbdf7b97bsm2006133plg.266.2022.09.30.08.26.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 30 Sep 2022 08:26:26 -0700 (PDT)
From:   Judy Hsiao <judyhsiao@chromium.org>
To:     bjorn.andersson@linaro.org
Cc:     Andy Gross <agross@kernel.org>, Rob Herring <robh+dt@kernel.org>,
        Srini Kandagatla <srinivas.kandagatla@linaro.org>,
        dianders@chromium.org, mka@chromium.org, cychiang@google.com,
        judyhsiao@google.com, swboyd@chromium.org,
        linux-arm-kernel@lists.infradead.org,
        linux-arm-msm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Judy Hsiao <judyhsiao@chromium.org>
Subject: [PATCH v5 0/3] Add dtsi for sc7280 boards that using rt5682
Date:   Fri, 30 Sep 2022 15:26:10 +0000
Message-Id: <20220930152613.2018360-1-judyhsiao@chromium.org>
X-Mailer: git-send-email 2.38.0.rc1.362.ged0d419d3c-goog
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Put sound node and lpass_cpu node settings for boards that use rt5682
codec in the sc7280-herobrine-audio-rt5682.dtsi as there are different
choices of headset codec for herobrine projects. Common audio setting
for the internal speaker is in sc7280-herobrine.dtsi.

Change Since V4
- Rebase and include sc7280-herobrine-villager-r0.dts change.

Changes Since V3:
- Remove Change-Id in the commit message.
- Add dependency in cover letter.

Changes Since V2:
- Fix sc7280-herobrine-audio-rt5682.dtsi syntax.

Changes Since V1:
- Not to include the herobrine-villager-r0.dts changes in this patch
  series to avoid conflict.

Judy Hsiao (3):
  arm64: dts: qcom: sc7280: herobrine: Add pinconf settings for mi2s1
  arm64: dts: qcom: sc7280: Add sc7280-herobrine-audio-rt5682.dtsi
  arm64: dts: qcom: sc7280: Include sc7280-herobrine-audio-rt5682.dtsi
    in herobrine-r1 and villager-r0

 .../qcom/sc7280-herobrine-audio-rt5682.dtsi   | 122 ++++++++++++++++++
 .../qcom/sc7280-herobrine-herobrine-r1.dts    |   1 +
 .../dts/qcom/sc7280-herobrine-villager-r0.dts |   1 +
 .../arm64/boot/dts/qcom/sc7280-herobrine.dtsi |  30 +++++
 4 files changed, 154 insertions(+)
 create mode 100644 arch/arm64/boot/dts/qcom/sc7280-herobrine-audio-rt5682.dtsi

-- 
2.37.3.998.g577e59143f-goog

