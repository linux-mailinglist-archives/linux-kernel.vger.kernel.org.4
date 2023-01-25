Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A88B67AB7D
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 09:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235103AbjAYIS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 03:18:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234913AbjAYISq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 03:18:46 -0500
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246632ED66
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 00:18:44 -0800 (PST)
Received: by mail-wr1-x435.google.com with SMTP id bk16so16183860wrb.11
        for <linux-kernel@vger.kernel.org>; Wed, 25 Jan 2023 00:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:from:to:cc:subject:date:message-id:reply-to;
        bh=WbD+hf3FdzdoYfGCceQ6HYFxbilvveL00wdzz479bAg=;
        b=TU4IljbPlO/Cu5JIUMlCZ3SK14XQ4s6KPMmklhaXSQ42uMuxnqet82/79UIicE2Q+R
         UxK2bCwTgpGlL5WENRCZe0EedKJUh/IIEPFW7xMPyG+YGvIZHt3cCzpn2Eq41wGMX2/x
         POPZH5/y1aiy/YES1lr93Flbo6Hzeq4UZ3W31Xq3Ccb4Gt+9nYcoZZ/9iZIxrJAaq5uG
         cWjk66Q4e67h6YH+celevxLvumcA8mhPWPyczXo+YpRbmkCXQA0dY7iZ8WAx8gGKijMO
         zXQw3nSbnlDJk8+8EYCgAIT+bnj20xhvpRk03R7iGSiES8205uxhWfVIZyoKSJPVupmG
         1jYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:content-transfer-encoding:mime-version:message-id:date
         :subject:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=WbD+hf3FdzdoYfGCceQ6HYFxbilvveL00wdzz479bAg=;
        b=yxzvFFNK634/CyDR+3CCExhwFGFA8aTp1+lLn2+lcomryChueAuKcQ0t+dZ3kD0TEV
         qWFdOhoPNt3WMj9yaTkpeKXqqkN4xDI4+7DTqZNB2kLmR1CWVDb2size984CbBpGPPJL
         BMsh9qNIooDOVloMJftZH34zeNvPZ00vufQSq3hHsold3DcC/gcgrsr4/irjAAsRiAt4
         4Y5tEmPPF1S8CzcLStPx+LKLRGaT28xrSzIzBeNUsnK1z4XE8hxTfvi3G/yQNVom57hb
         i21WtldSgyDmgzCktb3wHP6Ce6zSCICmQ3oiOsSCmCjaF8BCObb9n78+mwLWRL3EMI3p
         5ikg==
X-Gm-Message-State: AFqh2kqmSMlRj877CL1nWztxKdwhSKWF+BKQj4HxocZ0CgQtUULeppOH
        U7uZTQtbBHcKKOOIYXvxDN7e+A==
X-Google-Smtp-Source: AMrXdXtpdzpnwqRRl/ZPBknIAsI3dT0aYCw6sp/T5m0FkClf8NlpnkPD9KBbymR3GBHpDTU+rz7f8w==
X-Received: by 2002:a5d:404c:0:b0:2be:1258:897d with SMTP id w12-20020a5d404c000000b002be1258897dmr26796348wrp.43.1674634722560;
        Wed, 25 Jan 2023 00:18:42 -0800 (PST)
Received: from arrakeen.starnux.net ([2a01:e0a:982:cbb0:52eb:f6ff:feb3:451a])
        by smtp.gmail.com with ESMTPSA id p7-20020adff207000000b002bdff778d87sm3770343wro.34.2023.01.25.00.18.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 00:18:42 -0800 (PST)
From:   Neil Armstrong <neil.armstrong@linaro.org>
Subject: [PATCH v2 0/3] arm64: meson-g12b: add initial support for
 Odroid-N2L
Date:   Wed, 25 Jan 2023 09:18:36 +0100
Message-Id: <20230122-topic-odroid-n2l-upstream-initial-v2-0-8d3fea6d403d@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-B4-Tracking: v=1; b=H4sIANzl0GMC/5WOQQ6CMBBFr0K6dkxbMIAr72FYlDLAJLUl00I0h
 LtbuYHL9xb//V1EZMIo7sUuGDeKFHwGfSmEnY2fEGjILLTUpVRaQwoLWQgDBxrAawfrEhOjeQF
 5SmQcNFiNdaXqVlsl8k5vIkLPxts5L/nVuSwXxpHeZ/jZZZ4ppsCf88emfvaf5KZAgrJ4Q9nIs
 h3kw5E3HK6BJ9Edx/EFgykUy+gAAAA=
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        Dongjin Kim <tobetter@gmail.com>,
        Neil Armstrong <neil.armstrong@linaro.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
X-Mailer: b4 0.12.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ODROID-N2L is a variant SBC in small form factor and some peripherals
are removed from ODROID-N2PLUS based on S922X SoC.

- On-board ethernet is removed      
- On-board RTC is removed        
- USB 3.0 hub is removed, so one USB 2.0 and one USB 3.0 host ports
are available                                                                               
- Huge heatsink is replaced with 40x40mm heatsink, 5V active heatsink
is recommended or a tall passive sink is optional                  
- 3.5mm earjack is removed                                                                  
- IR remote receiver is removed                                                             
- MIPI DSI port is added

So achieve this the current odroid-n2 dtsi is moved as odroid.dtsi
and only the N2/N2+ changes are kept in the odroid-n2.
With this only a minimal changes are needed to support the Odroid-N2L.

Signed-off-by: Neil Armstrong <neil.armstrong@linaro.org>
---
Changes in v2:
- Fixed include and phy0 supply name on patch 3
- Added review tag on patch 1
- Link to v1: https://lore.kernel.org/r/20230122-topic-odroid-n2l-upstream-initial-v1-0-1ce5e08039d0@linaro.org

---
Neil Armstrong (3):
      dt-bindings: arm: amlogic: document Odroid-N2L
      arm64: dts: meson-g12b: move common node into new odroid.dtsi
      arm64: dts: meson-g12b-odroid: Add initial support for Hardkernel ODROID-N2L

 Documentation/devicetree/bindings/arm/amlogic.yaml |   1 +
 arch/arm64/boot/dts/amlogic/Makefile               |   1 +
 .../boot/dts/amlogic/meson-g12b-odroid-n2.dtsi     | 448 +--------------------
 .../boot/dts/amlogic/meson-g12b-odroid-n2l.dts     | 125 ++++++
 arch/arm64/boot/dts/amlogic/meson-g12b-odroid.dtsi | 445 ++++++++++++++++++++
 5 files changed, 581 insertions(+), 439 deletions(-)
---
base-commit: 1b929c02afd37871d5afb9d498426f83432e71c2
change-id: 20230122-topic-odroid-n2l-upstream-initial-8e4f741792c1

Best regards,
-- 
Neil Armstrong <neil.armstrong@linaro.org>

