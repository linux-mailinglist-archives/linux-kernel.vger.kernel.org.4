Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1E915E9601
	for <lists+linux-kernel@lfdr.de>; Sun, 25 Sep 2022 22:47:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231175AbiIYUrQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 16:47:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiIYUrN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 16:47:13 -0400
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4064B2A40C;
        Sun, 25 Sep 2022 13:47:12 -0700 (PDT)
Received: by mail-lf1-x135.google.com with SMTP id j16so8012431lfg.1;
        Sun, 25 Sep 2022 13:47:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=ze0sgkEqYNpxFlC6K21X02aw639CdQB9WWgMCs9YN2U=;
        b=EaQ04E030NdK3tY3YU1Job+6RQxcvtUWCY72BUy3SF5O5u5Nb0H85ymqNvOl+0eWqV
         Th9xSCApsQFfoE3TP+Fn05NqboFgEEviA98f2iNZuERlUbj33GUKqsq+eppdfUpZrkTR
         +yfplKSkkxnfEJ/oHE6WVHjYw3S3KfuncWJjTIe205kIfW26tcrPotC3bb1GKernfVGy
         Cf3tZ5GEAHIbiB/u5tfdteQtnYavB7+thYQoRSJDS0+rLSkdidYLl3uyr73EJWygAGdw
         I7wZ/ZG6HsSXOKW/t22Dwt3h5FzldWJKpm8dhhbXHiDtKT8Q+RBu+m1ppWQl6GatryyH
         jb4A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=ze0sgkEqYNpxFlC6K21X02aw639CdQB9WWgMCs9YN2U=;
        b=aAnaMIHg0SH9vffuooop5n0Uz7RBoJubfuVjf7yEUv0gp3aC5lN14rCiRT8E7NIDoW
         ZZhplZunsyEQlQ66RT1cy4ZYP5jTmnDn+7my2O0BzupNDUHkwHLdlB/HL8BW49LGrTE6
         LUCU+TWx1RJwqSQqtSODFml3JX+qlXbMTFSLO0ksjYpTKaxgnQQy1Qs+W9uSD/et6doe
         3S7478HhuCnhAFMCCco9JpjYWoZ/pLQoUWZ1n1YJxxpaay4gPWAf1ns8TH2zaDMg7Lho
         VM68dkypvRnmL/u2Nzurn+Gn9hLDrazdNMUA9He/VRgeJbVOnxqQWZZk5WXRwUreqnDk
         YWcA==
X-Gm-Message-State: ACrzQf0794ZmgMRoXnxjpD+KdZlkwjMjKOGA818uLLJJ84VrULDeJYtP
        ALaNF1vp3FDx2j5C4lhGtreb+BDKegv4hw==
X-Google-Smtp-Source: AMsMyM7bjRzVHgY1ERqdsJoQ+L3KVarwB6OglnPAUBKrKfCDBi1tF9tg3rjuKM89Gol1iGgSfDvwoA==
X-Received: by 2002:a05:6512:3b2a:b0:499:44ba:e295 with SMTP id f42-20020a0565123b2a00b0049944bae295mr7084397lfv.626.1664138830462;
        Sun, 25 Sep 2022 13:47:10 -0700 (PDT)
Received: from i-vetokaappi.home.lan (dsl-hkibng42-5673c7-93.dhcp.inet.fi. [86.115.199.93])
        by smtp.gmail.com with ESMTPSA id c24-20020a196558000000b0049472efaf7asm2297667lfj.244.2022.09.25.13.47.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 25 Sep 2022 13:47:09 -0700 (PDT)
From:   =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>
To:     linux-arm-msm@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        =?UTF-8?q?Matti=20Lehtim=C3=A4ki?= <matti.lehtimaki@gmail.com>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        devicetree@vger.kernel.org,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 0/3] Initial Samsung Galaxy Tab 4 10.1 (SM-T530) support
Date:   Sun, 25 Sep 2022 23:44:12 +0300
Message-Id: <20220925204416.715687-1-matti.lehtimaki@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add device tree node for pm8226 GPIOs and support for the Samsung Galaxy
Tab 4 10.1 (SM-T530) tablet which is based on apq8026.

Changes in v5:
  - Rename pm8226-regulators node to fix issue reported by make dtbs_check

Changes in v4:
  - Move delete-node to memory-region
  - Move usb-switch node to blsp_i2c4

Changes in v3:
  - Fix sdhc_2 bus width
  - Reorder includes

Changes in v2:
  - Change codename to matisse-wifi
  - Remove msm-id from device dts
  - Rename pm8226 gpio node

Matti Lehtimäki (3):
  ARM: dts: qcom: pm8226: Add node for the GPIOs
  dt-bindings: arm: qcom: Document samsung,matisse-wifi device
  ARM: dts: qcom: Add support for Samsung Galaxy Tab 4 10.1 (SM-T530)

 .../devicetree/bindings/arm/qcom.yaml         |   1 +
 arch/arm/boot/dts/Makefile                    |   1 +
 .../dts/qcom-apq8026-samsung-matisse-wifi.dts | 453 ++++++++++++++++++
 arch/arm/boot/dts/qcom-pm8226.dtsi            |  10 +
 4 files changed, 465 insertions(+)
 create mode 100644 arch/arm/boot/dts/qcom-apq8026-samsung-matisse-wifi.dts

-- 
2.34.1

