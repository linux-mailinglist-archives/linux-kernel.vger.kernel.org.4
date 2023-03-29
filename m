Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA01E6CD5DF
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 11:05:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjC2JFC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 05:05:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230213AbjC2JEm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 05:04:42 -0400
Received: from mail-ed1-x52f.google.com (mail-ed1-x52f.google.com [IPv6:2a00:1450:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27594F3;
        Wed, 29 Mar 2023 02:04:35 -0700 (PDT)
Received: by mail-ed1-x52f.google.com with SMTP id r11so60384255edd.5;
        Wed, 29 Mar 2023 02:04:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680080673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=Ogoln74tD8QCvF+Fgq5X37uzIdWUC0un7yKCLuRT89c=;
        b=X+407f1YY7zQ3zq7MbHOphMeE151PkHpF54DlVEtMrwAu/kckbnPOhwGCtSwa7nwQJ
         /si+Ck0kk98CvHeiGhLPDF1tEDEJYYwjHT43wI+oi/4dCGZkINpo6gmym1YugTq4vgMl
         T9TitlfpTBFE5ciFDj/JhRQUil3ryTsmVvh/OmoCRusI3IjUsyRvpcUkQf+JOUVrii4L
         CK3jnhEeP0pcxl8+S1+gyzZu0usb7Yq3LhjQWZPBE9R7gb08+fKIPZm9Y/5QGkvzijlp
         Mqz25nvpeFenmYWi8AYL6hVcPEqlWMcTGRVfC7FcQKRzhl3MlOSpmZOdWdb3nm20Wmrt
         WGpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680080673;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=Ogoln74tD8QCvF+Fgq5X37uzIdWUC0un7yKCLuRT89c=;
        b=D5EO0VXKQ3w6bi4W/77aT1efy4yc/oVe6p4Jep8zSK9QYbCvHt2aSKcKYaMv7/jMb+
         Mmn0Il2UbKD80Jr+erT1PttUv1BSLx9z34RFiWjMiYJL/dCm0l9K51Cf9A3hBRbD65gS
         LbFxulLyPz2A5+/dFavx9PfrZqtwlkiO96pQHAIii8kpo3DAHC5JFPyryviTcMA0JUwM
         bYSJx3qC5mUOKfPeWitkUHGjIO3rbNfdlDDCYQdIbimocTigkt3F7MjPlTMIrtNvwMhx
         Jc0GDUR7HXjx6KwvtH7xFqs+67YKFVBUnUoFCoGlzRPML7ZBZt9qVBGKTI+bxGPwjZhJ
         DGOw==
X-Gm-Message-State: AAQBX9dX26Ff4BqnjZCihJonoJrBee3cSDUYIPeIjV5VZsNEFmf1+350
        6EW9D/ncz8+Z38bPgnqBXpQ=
X-Google-Smtp-Source: AKy350Y0/fNzahBMPBoV+8mXtZgNW5Rm4cm0Ze0CUtWOAUcMAiNxGCxuqmAeds9U/Aya3JqWUJY8hw==
X-Received: by 2002:a17:906:7817:b0:8ae:11ca:81de with SMTP id u23-20020a170906781700b008ae11ca81demr18906560ejm.34.1680080673212;
        Wed, 29 Mar 2023 02:04:33 -0700 (PDT)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id n3-20020a170906088300b009327ed171f2sm15437127eje.129.2023.03.29.02.04.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Mar 2023 02:04:32 -0700 (PDT)
From:   Svyatoslav Ryhel <clamor95@gmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Svyatoslav Ryhel <clamor95@gmail.com>,
        Maxim Schwalm <maxim.schwalm@gmail.com>,
        Dmitry Osipenko <digetx@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 0/4] Tegra DTS improvements
Date:   Wed, 29 Mar 2023 12:03:59 +0300
Message-Id: <20230329090403.5274-1-clamor95@gmail.com>
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

Path for mmc devices are replaced with labels for
better tree comprehension. CPU paths are replaced with
labels references as well. Fixed accelerometer mount
matrix for TF101. Added 266.5MHz peripheral opp node
for devices which need it.

---
Chandes from v2:
- dropped commits with labels additions
- added mmc path to laber reference switch
- added cpu path to label reference switch

Chandes from v1:
- added missing sign-off
---

Maxim Schwalm (1):
  ARM: tegra30: Use cpu* labels

Svyatoslav Ryhel (3):
  ARM: tegra: transformer: use labels for mmc in aliases
  ARM: tegra: asus-tf101: fix accelerometer mount matrix
  ARM: tegra30: peripherals: add 266.5MHz nodes

 arch/arm/boot/dts/tegra114-asus-tf701t.dts    | 12 +++++------
 arch/arm/boot/dts/tegra20-asus-tf101.dts      |  6 +++---
 .../dts/tegra30-asus-transformer-common.dtsi  | 12 +++++------
 .../arm/boot/dts/tegra30-peripherals-opp.dtsi | 20 +++++++++++++++++++
 arch/arm/boot/dts/tegra30.dtsi                |  5 +----
 5 files changed, 36 insertions(+), 19 deletions(-)

-- 
2.37.2

