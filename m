Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2F936CA888
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 17:03:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230287AbjC0PDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 11:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231740AbjC0PDt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 11:03:49 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE2C30EB;
        Mon, 27 Mar 2023 08:03:01 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id i13so11847686lfe.9;
        Mon, 27 Mar 2023 08:03:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679929354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=e6VQOUIWhV+wzBeCHjyQhOVLLGvk7Jpv4IJCO1YwaE8=;
        b=SV0/rmbVDc+FyLq9iNVrGTQH8FfyPie8Cw6BehWUy+V9LhJ2fGd4leTIhqMLL/Rlek
         13Eae2PNehBIMTU2rzkDpWBvDsxculMHX5uTXeEnqdeRnWdgQjZPWm8jAgqUlZeqjuuP
         ozbAuBg6IJCwF0sJltDt+GYh1WuAaxaWBYgWJ3EhDosghHTlQh+PdJ1vK6v8PGKR21kq
         IXQjc6dgNTXNZA7p6ON3h8E+04nTWvwgolYknZTaNq02md3fDDTOVKbuZi2DccJz1ojI
         ySgc16+4AdeaYI5oQvneFcJJlTB0IUH0T4Y6WCp6CWs9gJxSd+QVzgC1xma7eYzgsYmM
         JmWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679929354;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=e6VQOUIWhV+wzBeCHjyQhOVLLGvk7Jpv4IJCO1YwaE8=;
        b=HWhBYUHxTdd06Dr5oJJ10KxXLiUVbdaNoj9+uv4FmGtfdpfuTgn5x5jqhb8JCPvxEY
         EqeWZ92VuBMcFxXrF6MsFwxJJ3QK3aus3N4G5LASeEGt9P/at/nqJmzj+yAEKpc3JgbU
         DV5+LD+9PvoQt0sUQJBZ1vVW36ZN5xiRXn1vfsu8S8zqeJ4ywsXpR8rxdtm6G4a0lo+2
         6sYL4V8Ag/FYVFV3CNxJSk2c36Hi1+Aqjh9cJvYbb3Bfb/gZkz0xfThmNvT6TW8t1SpR
         SIEa5RVmN9zsyfl0OXvNquZ1keUtEZ8VNhDAhrCUi2muwZYkvdpiAoR8/kgkUokFAV12
         wvZA==
X-Gm-Message-State: AAQBX9dAN1zBmuYbyfBezCEVU/LoLDLE7M03z7ccbW3M/jzTCdJbpwko
        zEaEG+WJsXZPs668e53LttM=
X-Google-Smtp-Source: AKy350YWeYIpIf267Srs3CZ2MraXr6TEeCcgO7WyQgwRur/vNjrPCbZELyimnI7YAg50x7HloUjKZQ==
X-Received: by 2002:ac2:4467:0:b0:4e8:a0a3:e242 with SMTP id y7-20020ac24467000000b004e8a0a3e242mr3374758lfl.7.1679929354102;
        Mon, 27 Mar 2023 08:02:34 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id f4-20020a19ae04000000b0049ad2619becsm4706923lfc.131.2023.03.27.08.02.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 08:02:33 -0700 (PDT)
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
Subject: [PATCH v4 0/2] Fix sound on ASUS Transformers
Date:   Mon, 27 Mar 2023 18:02:17 +0300
Message-Id: <20230327150219.13636-1-clamor95@gmail.com>
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
Changes from v3
- fixed typo in wm8903 audio-routing

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
  ARM: tegra: transformers: update WM8903 sound nodes
  ARM: tegra: transformers: bind RT5631 sound nodes

 arch/arm/boot/dts/tegra20-asus-tf101.dts        | 13 +++++++------
 arch/arm/boot/dts/tegra30-asus-tf201.dts        | 17 +++++++++++++++++
 arch/arm/boot/dts/tegra30-asus-tf300t.dts       |  6 ++----
 arch/arm/boot/dts/tegra30-asus-tf300tg.dts      | 17 +++++++++++++++++
 arch/arm/boot/dts/tegra30-asus-tf700t.dts       | 17 +++++++++++++++++
 .../dts/tegra30-asus-transformer-common.dtsi    |  9 +++++----
 6 files changed, 65 insertions(+), 14 deletions(-)

-- 
2.37.2

