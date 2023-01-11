Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D75266655B
	for <lists+linux-kernel@lfdr.de>; Wed, 11 Jan 2023 22:14:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233689AbjAKVOQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 Jan 2023 16:14:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230296AbjAKVOL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Jan 2023 16:14:11 -0500
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB4D3F105;
        Wed, 11 Jan 2023 13:14:09 -0800 (PST)
Received: by mail-ed1-x530.google.com with SMTP id c17so24198221edj.13;
        Wed, 11 Jan 2023 13:14:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=googlemail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=QhmFViFxYeXhPBfMdH2JMXAQJizOCgQmv4Ir0VlAq7k=;
        b=HyZ869rcIlQC9PV2d6dlnTequSI6pDi7seqna8LRb3bYGHrQezFLCor2NUvqXrJUZQ
         2BVT0sPQ7LZrPMDCy8t3xIh0NsqdqBM0tFSxR+tGUpguo8Sf+qIEnygLHIERZTZ18mhr
         eFWZwHML3h1kcbK7E2JnYvc1iv9pYzCIwAs5kN+n4anX82hzxboTCcwlRwhVLakq65H1
         qD8PUngCAVr82wIcThbnz8RUKvbF+A/EpeeOhQdP4nhoCsfdsUk/nWUJMI5IXiFGBHYX
         yKiML8Zu6rGagpiOSb/oo0aXPlVKTPGFy3ZyEroZkzLnNz7WDEi0+vn36YcaPPUNtO+m
         eYpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=QhmFViFxYeXhPBfMdH2JMXAQJizOCgQmv4Ir0VlAq7k=;
        b=PmiILSfhKZJoifIAQ5LN7TNE6rvlL+klhfUTB4ef2okEc4wboBLxGijE+o8HHNBqbD
         8RrLuTV8+BsV0pwWDEiMESpT4AnGHxvcOxS3s0qOubl2t0oVqmSmgEG4YBnIrQrjh153
         4tPiQnSZmL562lwIRGxBBdsY2iJlyv0UFEVsQsojsZ4FPtD3qA1AKbj2CRQo8SX/4OGq
         8zCsPF8h58lk6xX1Q8CuvQ5Eqg/HV+CYmCSduinnGKSlljomlkf8zr1xTpemeRBhQN4J
         yssybsMCvbO6+NYV+f72ygvUVbRlnCptysAYZzP6C7gLoyZFI/bMZneyCPLV7KyKjl78
         sAig==
X-Gm-Message-State: AFqh2koQ0Kw+A3eYHWSngnanowS/G4+X7vQjQc/1Qdnq4g4NrDcpIXXO
        e3H6WICZwfAyM/wH5rlbYsc=
X-Google-Smtp-Source: AMrXdXuscaZmFnnTyBmB93xjcQuSnIeoJuHRy82sUhdhqEsMXDlcXIaeoOQrADX1xMXThD9aJrj61g==
X-Received: by 2002:a05:6402:390b:b0:465:f6a9:cb7b with SMTP id fe11-20020a056402390b00b00465f6a9cb7bmr64883391edb.12.1673471647478;
        Wed, 11 Jan 2023 13:14:07 -0800 (PST)
Received: from localhost.localdomain (dynamic-2a01-0c22-7325-0300-0000-0000-0000-0e63.c22.pool.telefonica.de. [2a01:c22:7325:300::e63])
        by smtp.googlemail.com with ESMTPSA id l4-20020a056402344400b004822681a671sm6485079edc.37.2023.01.11.13.14.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Jan 2023 13:14:06 -0800 (PST)
From:   Martin Blumenstingl <martin.blumenstingl@googlemail.com>
To:     linux-amlogic@lists.infradead.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        khilman@baylibre.com, neil.armstrong@linaro.org,
        jbrunet@baylibre.com, krzysztof.kozlowski+dt@linaro.org,
        robh+dt@kernel.org, devicetree@vger.kernel.org,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>
Subject: [PATCH v2 0/6] arm64: dts: small .dts fixes
Date:   Wed, 11 Jan 2023 22:13:44 +0100
Message-Id: <20230111211350.1461860-1-martin.blumenstingl@googlemail.com>
X-Mailer: git-send-email 2.39.0
MIME-Version: 1.0
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

This series contains a few .dts fixes which were found during review of
[0] (which is now the first patch in this series).



[0] https://lore.kernel.org/linux-amlogic/20230110215926.1296650-1-martin.blumenstingl@googlemail.com/


Martin Blumenstingl (6):
  arm64: dts: meson-gxl: jethub-j80: Fix WiFi MAC address node
  arm64: dts: meson-gxl: jethub-j80: Fix Bluetooth MAC node name
  arm64: dts: meson-axg: jethub-j1xx: Fix MAC address node names
  arm64: dts: meson-gx: Fix Ethernet MAC address unit name
  arm64: dts: meson-g12a: Fix internal Ethernet PHY unit name
  arm64: dts: meson-gx: Fix the SCPI DVFS node name and unit address

 .../boot/dts/amlogic/meson-axg-jethome-jethub-j1xx.dtsi     | 6 +++---
 arch/arm64/boot/dts/amlogic/meson-g12-common.dtsi           | 2 +-
 arch/arm64/boot/dts/amlogic/meson-gx.dtsi                   | 4 ++--
 .../boot/dts/amlogic/meson-gxl-s905w-jethome-jethub-j80.dts | 4 ++--
 4 files changed, 8 insertions(+), 8 deletions(-)

-- 
2.39.0

