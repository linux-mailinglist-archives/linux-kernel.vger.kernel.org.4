Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D94DC69E667
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 18:54:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230215AbjBURyT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 12:54:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40782 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232613AbjBURyQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 12:54:16 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8488427D5E;
        Tue, 21 Feb 2023 09:54:14 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id eg37so16753832edb.12;
        Tue, 21 Feb 2023 09:54:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=46MKtm0kEaNdnFxLw+ZVHv2iv3ITk3WR03ilOnM6pwU=;
        b=Kd+69eaZ2bJTiRkyKmAigUMZCBdzCQD2rVVxf9CPntK22hwx9suVaCXJLY7pJzCGJ7
         /r1CY3HbkOKPd2os0QifPWgd3MNc9b5uQgORUWUBkUoLxF6e2+WxyzZlh0aN7fIeGT12
         d1xJTPJErkh1PPwm+kBjxOHC6Usoesl71sPdc9fg1Cv+FWPGOO0Wxf85HIC6oNo8heSA
         WK03Uzxz3k1Y+iS8fxFoO7gqo2wCRyN6kkV5prhtwH9XRV3nb9I3PFEOsCKvzFM28zht
         RfoWU3nQrlDO4SjH/k1/4Bs88LjtJRU6eEYiUqIvKjsR6gnaK3emDWfsqznz0g5615ID
         nhUA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=46MKtm0kEaNdnFxLw+ZVHv2iv3ITk3WR03ilOnM6pwU=;
        b=ShY0Zm9FCqDTlTUrDL5CfPb7lIwt/SQXRkuKjIrzPm6Rb5/7u/2pMBpDTvDWwinVZy
         vygP8pYkkT+mg65j18VFDqOs+CgSpNlasydXxcwxj9SHptOBdTY+USpQgHVzBnTdLxw4
         GK4qmDfRzKjj6FRDvPpPjhTnD4n9IFNNAvBV3KlujfTp3ah3CkWKU8v09rNXnGQCWora
         5g14iIOZdYaAdGIP3xqqCtq+bPoQh5YTsjJqF21FOToYKYFpceNjNPcAmaAy1pJnma7U
         jqSsj2wFPZr3TD4FT+/hsIO4RCZZJ8tSPEV9GvQonwiR4SrUzWxI5WOa3+CLZyMq5pp+
         TK0w==
X-Gm-Message-State: AO0yUKV1IC1+dD4/mYhUrQY21osQHlEyyLWXGbHqWBQJdXvTuwQBTcu5
        WbV0rPMv2+pGtSyegzXg8pKJU6tMt4g=
X-Google-Smtp-Source: AK7set+kfU5i6pU775JGjcMKazmOfY2wNZ3dsTzE9nZckGPyQ7xnFbfyyUVq+VMoTwoEcpgfz2tvGA==
X-Received: by 2002:a17:906:847a:b0:885:6a2e:f941 with SMTP id hx26-20020a170906847a00b008856a2ef941mr11858743ejc.54.1677002052882;
        Tue, 21 Feb 2023 09:54:12 -0800 (PST)
Received: from xeon.. ([188.163.112.76])
        by smtp.gmail.com with ESMTPSA id b3-20020a170906660300b008e493b7bb61sm236357ejp.153.2023.02.21.09.54.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Feb 2023 09:54:12 -0800 (PST)
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
Subject: [PATCH v1 0/5] Tegra DTS improvements
Date:   Tue, 21 Feb 2023 19:53:43 +0200
Message-Id: <20230221175348.15681-1-clamor95@gmail.com>
X-Mailer: git-send-email 2.37.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Patches add labels into t30 and t114 dtsi for easier
node referencing. Quotes for mmc devices are replaced
with labels for better tree comprehension. Fixed 
accelerometer mount matrix for TF101. Added 266.5MHz
peripheral opp node for devices which may need it.

Anton Bambura (1):
  ARM: tegra: Add labels to tegra114.dtsi

Michał Mirosław (1):
  ARM: tegra: Add labels to tegra30.dtsi

Svyatoslav Ryhel (3):
  ARM: tegra: transformer: use labels for mmc in aliases
  ARM: tegra: asus-tf101: fix accelerometer mount matrix
  tegra30: peripherals: add 266.5MHz nodes

 arch/arm/boot/dts/tegra114.dtsi               | 48 +++++++++----------
 arch/arm/boot/dts/tegra20-asus-tf101.dts      |  6 +--
 .../dts/tegra30-asus-transformer-common.dtsi  |  6 +--
 .../arm/boot/dts/tegra30-peripherals-opp.dtsi | 20 ++++++++
 arch/arm/boot/dts/tegra30.dtsi                | 36 +++++++-------
 5 files changed, 68 insertions(+), 48 deletions(-)

-- 
2.37.2

