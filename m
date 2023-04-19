Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 277756E7A15
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Apr 2023 14:53:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233104AbjDSMx2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Apr 2023 08:53:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233214AbjDSMxW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Apr 2023 08:53:22 -0400
Received: from mail-lj1-x22c.google.com (mail-lj1-x22c.google.com [IPv6:2a00:1450:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDEA4E6E
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:53:20 -0700 (PDT)
Received: by mail-lj1-x22c.google.com with SMTP id bz21so10167975ljb.11
        for <linux-kernel@vger.kernel.org>; Wed, 19 Apr 2023 05:53:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681908799; x=1684500799;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QMBCA5yw/oGfimd2NHVa6yO5ZZCg77a4Ic/kI2eNphg=;
        b=h9kTrlyKUWFgKDtCZbvRQYWYmyQTTUYjsvtkpewc5Es2vkPhsiI7h7BKbj/TUaKnPb
         4dtVS3BQNDbOrIvLma6Ld2NHKHZhUmVj09rhzhzwItxPv6Kfwm4zBWttXc6qUm3dl4pa
         DS0DTS/Yl0CoL/7dreNtxjIHb0MigC4n1ZxjwWTOsAbTTJwSe8HKEtsMSAr+TphDKXXs
         EJRDlCZ2aGvmO6Age7wSUMjZcIpj25E5b7wHy9OU9MVmBk4lXfd9WoB6CPblJgsOycnV
         SmRJmuHpot7o/BeEj6ylNwbLxHLz685PMMmwKrnbCeO/Bl+gd2r+/NizXrrSqtMbcPJT
         DKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681908799; x=1684500799;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QMBCA5yw/oGfimd2NHVa6yO5ZZCg77a4Ic/kI2eNphg=;
        b=Y3BHkEj2LKBinZwpFya5i4hdj8BRqfk+tW4R1epmP7TJNAM3PnQYzxDfr03XppkNm6
         9rwSwMN04Xn2yzLC7ctGoJh5K/ew+Ql7sGoP9KyJJXiPo1mT5WS0T5rvyATcdTkmA8S4
         8K2MRzGPctoclKjNbdxpDomH16I2YVytw/J9xMUqK/b1/c0iGn3PncrXFUY8ROWLdZMn
         mHXhz195aODqHAidKz5mjilricg1A5sZwOXIV+DbUc4KQnJH/M2WIyF2CskVK8xscK+i
         bR5aZaRilc2zULz7w2n1oU0XF2fRaUvB2LuWPcIb32DtbXcntvUCnJN93iaTkkQehjSR
         Lltg==
X-Gm-Message-State: AAQBX9dzYMkpVrg2K7FNApSJttN64djmqDV0oj9HadQTnWAodCfA1sLq
        NUyY2OD1/lMn7ez0TS4iyIqBfw==
X-Google-Smtp-Source: AKy350aDzkAD3Q/u8kBELBmFxaiO3RXvBBwWX2cp8Kg2z437bXJqkkgU2k+w6M87slL2KBz2TDwUzQ==
X-Received: by 2002:a2e:81c1:0:b0:2a8:c7e0:7764 with SMTP id s1-20020a2e81c1000000b002a8c7e07764mr2002348ljg.18.1681908799134;
        Wed, 19 Apr 2023 05:53:19 -0700 (PDT)
Received: from [192.168.1.101] (abyj144.neoplus.adsl.tpnet.pl. [83.9.29.144])
        by smtp.gmail.com with ESMTPSA id s22-20020a2e98d6000000b002a76c16ad65sm2926079ljj.87.2023.04.19.05.53.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Apr 2023 05:53:18 -0700 (PDT)
From:   Konrad Dybcio <konrad.dybcio@linaro.org>
Subject: [PATCH v3 0/2] SM8350 VIDEOCC
Date:   Wed, 19 Apr 2023 14:53:15 +0200
Message-Id: <20230413-topic-lahaina_vidcc-v3-0-0e404765f945@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIADvkP2QC/42NywrCMBREf6VkbSS5aSi68j9EJK82F0IiSQ1K6
 b+bdudGXM4Mc85CisvoCjl3C8muYsEUWxCHjhiv4uQo2pYJMBCs54LO6YGGBuUVRnWvaI2h2li
 ldT9I2QNpT62KozqraHz7xmcIrXxkN+JrV11vLXssc8rv3Vz51v6WVE4Z5aIfTxpASS0uoY05H
 VOeyAas8AcEGmQcgFvJBiel/IKs6/oBs6YhVxEBAAA=
To:     Bjorn Andersson <andersson@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Marijn Suijten <marijn.suijten@somainline.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@linaro.org>
X-Mailer: b4 0.12.2
X-Developer-Signature: v=1; a=ed25519-sha256; t=1681908797; l=1372;
 i=konrad.dybcio@linaro.org; s=20230215; h=from:subject:message-id;
 bh=6E/NVLCFN0cz1qLPeyVZ6lRKVL5OuGw548pAFCDFvaM=;
 b=TJWMzhD/AM3ES32AO5r4OTxJbqrMbuaix/oHUX0cnA9TOLLeNKUpSXs8lLXt9nu5y065KqL8Oa1a
 ZK7VNXR+B/VFXrykOG0xjMIveZMMwI4NDmq3NGyy5YLWTNV1wC4T
X-Developer-Key: i=konrad.dybcio@linaro.org; a=ed25519;
 pk=iclgkYvtl2w05SSXO5EjjSYlhFKsJ+5OSZBjOkQuEms=
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2 -> v3:
- Use a consistent VIDEO_CC_ prefix for resets
- Separate out the binding (and don't pick up the rb as a consequence)
- drop all pm_clks code

v2: https://lore.kernel.org/r/20230413-topic-lahaina_vidcc-v2-0-f721d507e555@linaro.org

v1 -> v2:
- "){" -> ") {"
- subsys_initcall -> module_platform_driver
- constify lucid_5lpe_vco & .hw.init
- devm_add_action_or_reset -> devm_pm_runtime_enable

v1: https://lore.kernel.org/r/20230413-topic-lahaina_vidcc-v1-0-134f9b22a5b3@linaro.org

This serires brings support for SM8350 videocc and updates the
related dt-bindings.

Signed-off-by: Konrad Dybcio <konrad.dybcio@linaro.org>
---
Konrad Dybcio (2):
      dt-bindings: clock: Add SM8350 VIDEOCC
      clk: qcom: Introduce SM8350 VIDEOCC

 .../bindings/clock/qcom,sm8350-videocc.yaml        |  81 +++
 drivers/clk/qcom/Kconfig                           |   9 +
 drivers/clk/qcom/Makefile                          |   1 +
 drivers/clk/qcom/videocc-sm8350.c                  | 552 +++++++++++++++++++++
 include/dt-bindings/clock/qcom,sm8350-videocc.h    |  35 ++
 include/dt-bindings/reset/qcom,sm8350-videocc.h    |  18 +
 6 files changed, 696 insertions(+)
---
base-commit: 67d5d9f013d6c3829383c08162939cabff14fccc
change-id: 20230413-topic-lahaina_vidcc-bcdabb475542

Best regards,
-- 
Konrad Dybcio <konrad.dybcio@linaro.org>

