Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E71E6A8221
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Mar 2023 13:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229649AbjCBM13 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Mar 2023 07:27:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229639AbjCBM12 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Mar 2023 07:27:28 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C83E4615E;
        Thu,  2 Mar 2023 04:27:27 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id f13so66879058edz.6;
        Thu, 02 Mar 2023 04:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1677760046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UCzu+CfYoO6L/88b2EATsbmRsnxpl5XJojzf9dpIYbM=;
        b=nMWeYaQK6N2n+tcRBZmsETp9VrbSsWitZpxfoLVg9dzNOrnd/hoxPvxWQvmPhV/Lcz
         FiF0pr0nw8IU4Dbscq9aSQVa5jbCFXsGAZrerRZM+L3OtZCBV/hMjW4QzN2csYOfCqhF
         NY9UN9AvbZWXbCBBcZypwKWVjV0pFBhqdL1tIkz7ntdJvqxtsz1kHCXjLltF7i5QRxMc
         ojfNwCdwyyqaH1kRZX/hVTUmdYTmbTEONcJDBtcjUX5l9BYhRbpztFvkv0N3ZSmlRWPv
         sZ0ugavlEGWk7oC7qqgydCV/UJ41I7q6DzTZCgbZ/5e5QwBnV5KIK2C9JWgSq1oQh4lL
         9mfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1677760046;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UCzu+CfYoO6L/88b2EATsbmRsnxpl5XJojzf9dpIYbM=;
        b=4+jts75uwcvZ96V4XgH9laiUgWCZ2NrKerLgHzavypnB4dk0Cz3uqvG5HVVB82X5w3
         ra313mSkW15DtoozIqT55ShB4qcyzKEYZFgrdcKDWc7UNaljYpwednBXU3zSN80TMbii
         7luEz0451Z3or0SJz2eBNLOAg9OlfUKbMSZQNAxRTA0nbAxSkd8whaLTV+77/K4eXaNt
         2RhRM5opKkL7tyi+l48Jh0LK/wtEpwuiVZ5oPllmb9FtdsbrEnc9IjjIoeeoFwgCIy+J
         qo3VqmVK+Ww0q8eDQxhBADwpHJIHD0IP92EzDqO8wQjywdB8QuM63pzhcJigIN/dE318
         FCcQ==
X-Gm-Message-State: AO0yUKXSKJHR5z6CNvP/N4rX1pfoDUn8ENokX5xKCQZ5qcthumlovYvv
        2KNwFksCQZNMEcs/OED7+z8=
X-Google-Smtp-Source: AK7set88KNYQCJ8xnXU4YX6cMBd1m+CfpbxjYXG8W1sUvhQ4bXwI2FO/XpIVWpYvF0lT7Xgkx10HGQ==
X-Received: by 2002:a17:906:9156:b0:8d7:6699:3ba9 with SMTP id y22-20020a170906915600b008d766993ba9mr9434114ejw.29.1677760045782;
        Thu, 02 Mar 2023 04:27:25 -0800 (PST)
Received: from localhost.localdomain ([95.183.227.97])
        by smtp.gmail.com with ESMTPSA id qc17-20020a170906d8b100b008ca37f3eae9sm7038375ejb.131.2023.03.02.04.27.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Mar 2023 04:27:25 -0800 (PST)
From:   Yassine Oudjana <yassine.oudjana@gmail.com>
X-Google-Original-From: Yassine Oudjana <y.oudjana@protonmail.com>
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Tinghan Shen <tinghan.shen@mediatek.com>,
        "Garmin.Chang" <Garmin.Chang@mediatek.com>,
        MandyJH Liu <mandyjh.liu@mediatek.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        Yassine Oudjana <yassine.oudjana@gmail.com>,
        devicetree@vger.kernel.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/2] MediaTek MT6735 SCPSYS support
Date:   Thu,  2 Mar 2023 15:27:06 +0300
Message-Id: <20230302122708.73848-1-y.oudjana@protonmail.com>
X-Mailer: git-send-email 2.39.2
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

From: Yassine Oudjana <y.oudjana@protonmail.com>

These patches are part of a larger effort to support the MT6735 SoC family in
mainline Linux. More patches (unsent or sent and pending review or revision)
can be found here[1].

This series adds support for most SCPSYS power domains on MT6735. See patches
for details.

Changes since v1:
- Squash DT binding patches
- Dual-licence DT binding as GPL/BSD
- Switch to mtk-pm-domains driver
- Add MFG bus protection bit

[1] https://gitlab.com/mt6735-mainline/linux/-/commits/mt6735-staging

Yassine Oudjana (2):
  dt-bindings: power: Add binding for MediaTek MT6735 power controller
  soc: mediatek: pm-domains: Add support for MT6735

 .../power/mediatek,power-controller.yaml      |  2 +
 .../bindings/soc/mediatek/scpsys.txt          |  1 +
 drivers/soc/mediatek/mt6735-pm-domains.h      | 96 +++++++++++++++++++
 drivers/soc/mediatek/mtk-pm-domains.c         |  5 +
 drivers/soc/mediatek/mtk-pm-domains.h         |  2 +
 include/dt-bindings/power/mt6735-power.h      | 14 +++
 include/linux/soc/mediatek/infracfg.h         |  5 +
 7 files changed, 125 insertions(+)
 create mode 100644 drivers/soc/mediatek/mt6735-pm-domains.h
 create mode 100644 include/dt-bindings/power/mt6735-power.h

-- 
2.39.2

