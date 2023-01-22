Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94FA0676CB4
	for <lists+linux-kernel@lfdr.de>; Sun, 22 Jan 2023 13:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230002AbjAVMPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 Jan 2023 07:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229985AbjAVMPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 Jan 2023 07:15:48 -0500
Received: from mail-wm1-x32c.google.com (mail-wm1-x32c.google.com [IPv6:2a00:1450:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 378021ABCA
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 04:15:47 -0800 (PST)
Received: by mail-wm1-x32c.google.com with SMTP id iv8-20020a05600c548800b003db04a0a46bso3228407wmb.0
        for <linux-kernel@vger.kernel.org>; Sun, 22 Jan 2023 04:15:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=1tGaV/vVqSe7j5jHscTpb4g/SPxvj1PFsDHZ7F3jeUE=;
        b=BkYrz6odRMNCNMp9kPc0Ffg9qh8Xex6eIYZ/Zw3lR9wRnVIXDY2K9fQSj6mgdI3hE8
         4X/r1EdLYgTwZg/82E+CTSUEQbDv1qvbCwFxN98iVd1HfgkjySgyqUBq5jumi2U3890P
         IONGlbI7SK4anAurrWgToBfAtvH2s4zUvyMf8LY/RJFpjel35GNiZzMCRHqxznZaw/DE
         MR+/ldN/UqFC+0NSd5t9bGcl2jEblcsP0cMfVK57MJK++tJtU9dl1Lub7hhOTRo4DG3m
         gTGcvVJBdW99T/in0Ejhar1d5pFYQ4Z0+k1sX602/x9ve0EWXK5zNZ8Tv6QXiuJSSNCj
         D63A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=1tGaV/vVqSe7j5jHscTpb4g/SPxvj1PFsDHZ7F3jeUE=;
        b=hpeTuURHRbLT2oH7RMM3VweimjfXwH9MioymrHK4jeaer830rhTB4pIfwc3C+zKjTj
         ECKbS9A2yGawZrLG63ejBI2N8X4fHeybVPJu62C5oDwzWnMbsTOXPt+En3m61dcIO47W
         Vn2/7J7MNo/amEGXo/9cFgmSTg+A1yOZG1bOFQwmFwiTS5zqlpRQRyivYUf/RP6uMmPD
         e6YwTHUpefXplnn43gBWh7MD9LKMAa0cLwKprhVSBZeFhZeKE1OKG627+w1GzaqpK+/M
         efuxc9exm9L14G3KKRqIUwx7ghbw+Gsu0l+0S5OIzvtEzNJAqhlNZoZ8LZfKqOYidERv
         bOLw==
X-Gm-Message-State: AFqh2kp8BXTBxX8Fqwza7tRTlwIFlxmKalxECBoaLzy0/Arn2PgqXUII
        lXyAgKhGgn2u3QGRxfuirmegjA==
X-Google-Smtp-Source: AMrXdXu2ngAApBUjdl+X0iQODuuOctW1xFD2HBQEjn9ESCYNGbuk/KECrZmQ6uFWU+OoL3ix2RG8nw==
X-Received: by 2002:a05:600c:1c2a:b0:3cf:d0b1:8aa1 with SMTP id j42-20020a05600c1c2a00b003cfd0b18aa1mr20036181wms.0.1674389745818;
        Sun, 22 Jan 2023 04:15:45 -0800 (PST)
Received: from krzk-bin.. ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id o28-20020a05600c511c00b003dab40f9eafsm8543663wms.35.2023.01.22.04.15.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 22 Jan 2023 04:15:45 -0800 (PST)
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
To:     Olof Johansson <olof@lixom.net>, Arnd Bergmann <arnd@arndb.de>,
        arm@kernel.org, soc@kernel.org
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzk@kernel.org>
Subject: [GIT PULL] arm64: dts: Cleanup for v6.3
Date:   Sun, 22 Jan 2023 13:15:40 +0100
Message-Id: <20230122121541.29312-1-krzysztof.kozlowski@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following changes since commit 1b929c02afd37871d5afb9d498426f83432e71c2:

  Linux 6.2-rc1 (2022-12-25 13:41:39 -0800)

are available in the Git repository at:

  https://git.kernel.org/pub/scm/linux/kernel/git/krzk/linux-dt.git tags/dt64-cleanup-6.3

for you to fetch changes up to d0931f1d5e9c1655cfa8128edd14e813b4044801:

  arm64: dts: hisilicon: align LED node names with dtschema (2023-01-13 11:38:56 +0100)

----------------------------------------------------------------
Minor improvements in ARM64 DTS for v6.3

1. Drop 0x from unit address (microchip).
2. Align HDMI CEC and LED nodes with bindings (hisilicon).

----------------------------------------------------------------
Krzysztof Kozlowski (2):
      arm64: dts: microchip: drop 0x from unit address
      arm64: dts: hisilicon: align LED node names with dtschema

 arch/arm64/boot/dts/hisilicon/hi3660-hikey960.dts | 12 ++++++------
 arch/arm64/boot/dts/hisilicon/hi6220-hikey.dts    | 12 ++++++------
 arch/arm64/boot/dts/microchip/sparx5.dtsi         |  2 +-
 3 files changed, 13 insertions(+), 13 deletions(-)
