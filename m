Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00A266C8C8D
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Mar 2023 09:20:36 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231871AbjCYIUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Mar 2023 04:20:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230062AbjCYIUc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Mar 2023 04:20:32 -0400
Received: from mail-wr1-x42e.google.com (mail-wr1-x42e.google.com [IPv6:2a00:1450:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8F76E16AD5;
        Sat, 25 Mar 2023 01:20:29 -0700 (PDT)
Received: by mail-wr1-x42e.google.com with SMTP id e18so3847495wra.9;
        Sat, 25 Mar 2023 01:20:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679732428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UbR9BD+mMBi4l1rXs1ccrWieqpTtxXFXw8kLIEeWGp0=;
        b=An4ZN2rtznICgFJfIo4XkmDwB4CycNcRUWWNfNAULL9qrW+O/JcaBlHsAKIYPqaefD
         8On4qG1V5Af8BLqnk/UaJjwg8Uq94DmMQCKk4Fv4Astz6w0qF88EoOA8YpofMa5rQXTs
         aywqvh1DMtNpUcTUJLz6SO75pyfOzj/TfTxlpPV9sm++Rch+izeNbOH68hgdkmBhaxwR
         SqFwnJTW6EjukXi9Abp6tvaS174tV6WcERRE2XkU34U21w3AflMn8Zn3fFjp3z5Dt/Er
         8OPz9zKblecvUnWUNZ1rDx5043H5GkZ3qkBbaTU9iBkmA85H+GQ1tzPYhYCdEG4zIAPV
         xXWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679732428;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UbR9BD+mMBi4l1rXs1ccrWieqpTtxXFXw8kLIEeWGp0=;
        b=3j7T2Ur3zTf0S29njpLrKZN/QlKyRscBurVeCeSgLf+v4jV+h264JOYT2b9TW1uSNa
         VZgMuGGwG6hSJ6jU6K76J8PnD80RtQzQmsaDfy8YMFH0QwZ8u3kr4fz6VnvBhBoqdMeZ
         NvnHZhirnIU3otTf1FCVpchgTFMKf97lXPwR+/dDQGHgWFEbpnFF/1J1HAuEmsV5FfU7
         FYDGg0pUt1Q4UjOx5MWQ1jxBkpOMKWTxA3TiUv98726QuOhZrkbUGBeMdyTzMaOxWnfU
         WjIlgyHVqi2tkAnbwJiw7I0ytmFFZZDp5dT931xDzo1QWgyxtMfN+LWD/nNij1jpnuSY
         dPug==
X-Gm-Message-State: AAQBX9dqmV8gc7KCxsHqyKMF+sMlglgzS6OXFS7S7dFc7NU/XfE56PEU
        YSbubU9lESwviz2lsvgUOS9s9VXrQm8=
X-Google-Smtp-Source: AKy350ZN5BIafcAadP4NiYS62jDVTbekHpNVYB/VMMXOrTus08MxTU+olFAsJDq94splQ9q/IExrlg==
X-Received: by 2002:a5d:6187:0:b0:2ce:5056:7220 with SMTP id j7-20020a5d6187000000b002ce50567220mr3663846wru.51.1679732427728;
        Sat, 25 Mar 2023 01:20:27 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id n12-20020a5d484c000000b002c59f18674asm20175918wrs.22.2023.03.25.01.20.26
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 25 Mar 2023 01:20:27 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-tegra@vger.kernel.org
Subject: [PATCH v3 0/2] Fix sound on ASUS Transformers
Date:   Sat, 25 Mar 2023 10:20:09 +0200
Message-Id: <20230325082011.6985-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- update dts bindings

---
Changes from v2
- dropped already picked patches
- adjustments in binding updates (tf101 and tf300t require wm8903
  codec patch to properly work with internal mic)

Changes from v1
- fm34 dropped for re-work
- quirk for headset detection and rt5631 bringup splitted
- minor adjustments in binding updates
- improvement of rt5631 rate asignment
---

Svyatoslav Ryhel (2):
  ARM: tegra: transformers: update sound nodes
  ARM: tegra: transformers: bind RT5631 sound nodes

 arch/arm/boot/dts/tegra20-asus-tf101.dts        | 13 +++++++------
 arch/arm/boot/dts/tegra30-asus-tf201.dts        | 17 +++++++++++++++++
 arch/arm/boot/dts/tegra30-asus-tf300t.dts       |  8 +++-----
 arch/arm/boot/dts/tegra30-asus-tf300tg.dts      | 17 +++++++++++++++++
 arch/arm/boot/dts/tegra30-asus-tf700t.dts       | 17 +++++++++++++++++
 .../dts/tegra30-asus-transformer-common.dtsi    |  9 +++++----
 6 files changed, 66 insertions(+), 15 deletions(-)

-- 
2.37.2

