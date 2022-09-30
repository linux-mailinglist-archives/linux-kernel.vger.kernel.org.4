Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2EB8B5F0E09
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 16:53:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231831AbiI3OxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 10:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232094AbiI3Ow2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 10:52:28 -0400
Received: from mail-pg1-x531.google.com (mail-pg1-x531.google.com [IPv6:2607:f8b0:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FCA4A2862;
        Fri, 30 Sep 2022 07:50:27 -0700 (PDT)
Received: by mail-pg1-x531.google.com with SMTP id c7so4367829pgt.11;
        Fri, 30 Sep 2022 07:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=X6fGy4hcZaM4AVZur13EPDN9Tq5BheZdR247i/8BoLA=;
        b=AdcZKVJT7UC4RNzawMWRvtf86ZKf6qG0xLVN1lbHo2ffHEIbSsZI18dnqOG6Yz3Tgu
         QkEOA5sXjbuxeI0/Y6gQpgshMwcQ+BUGgn9MIg0NpKyN9xx9qMzqblPt5DyoGPBzRVLB
         uaxl1RkhvoEahBumrWOWJAFYsp+j+Vz9TPLCg8ThsOYFgysmla1W80gtrea6JNcltnZf
         e5pHbUuaA3usgIr10fJiahVP4co//Y8yiDwTeEfouqArOkxQ/d7lmXC5D2mgIgJmUK/6
         1iPSQkYshiaeO9fHTAZKeKncvYCEF2/jw4hVMCKC6LI83vFPzY5c3EmfQZTYZQTWSHmq
         BoMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=X6fGy4hcZaM4AVZur13EPDN9Tq5BheZdR247i/8BoLA=;
        b=YM1PwfuFlgJDC3Y6jubG8IT0YhjEaF/yS3D5C00VNRoeO95P0fnqYrSO6vgII8S1eJ
         5zdVEAsFt3Z9XkClaQjKZdj61r3urQqmvvzd3OIKddGJpL30Fq+YA/Jun0MX/CVl8ULA
         MslpSGn408Ly5L0HwbyjA3qjBaNUcMTnTY6f1SHqh1wZkC9ffm2VlLb3EO0NFyRuerh6
         qIrMuniv8wp3BNPXNHl8Ta7PqjQJKM/qjcDsX5W+1wNKG5SPbHoHsWtG9PVooOe98wT8
         MIcM3bpY5DGzxrSXzdS+nhyQsvsLY/TPaKfKP+LQL/XKM2Hku6AE/aHsRtxnoUjC6WaM
         mq6Q==
X-Gm-Message-State: ACrzQf2u4Yl87BWQD3n2M1+G45YxtfBaZm+bCr06ocFVd2fM5Ad9BVND
        NZmggAhzr/0P80q/I4/n3Q597D0nNd5gHA==
X-Google-Smtp-Source: AMsMyM7kma92jVrM2f69qj+7fc1GMluFjnUGfCwOn/iHMxR6M/D711WadP1yY3WIsz15xPakE4aNtA==
X-Received: by 2002:a05:6a00:99c:b0:54c:27c4:3acb with SMTP id u28-20020a056a00099c00b0054c27c43acbmr9163449pfg.22.1664549420693;
        Fri, 30 Sep 2022 07:50:20 -0700 (PDT)
Received: from localhost.localdomain (1-171-4-69.dynamic-ip.hinet.net. [1.171.4.69])
        by smtp.gmail.com with ESMTPSA id 3-20020a17090a01c300b001fb1de10a4dsm1731608pjd.33.2022.09.30.07.50.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 30 Sep 2022 07:50:19 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v8 0/3] Add Richtek RT9471 3A battery charger support
Date:   Fri, 30 Sep 2022 22:50:06 +0800
Message-Id: <1664549409-4280-1-git-send-email-u0084500@gmail.com>
X-Mailer: git-send-email 2.7.4
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

This patch set is to add Richtek RT9471 charger support.

The RT9471/D is a highly-integrated 3A switch mode battery charge management
and system power path management device for single cell Li-Ion and Li-polymer
battery. The low impedance power path optimizes switch-mode operation
efficiency, reduces battery charging time and extends battery life during
discharging phase.

Since v8:
- revert v7 for adding irq wakeup capable, i2c core already did it.

Since v7:
- Add irq wakeup capable.
- Add missing header 'module.h' for MODULE_DEVICE_TABLE.

Since v6:
- Use 'ATTRIBUTE_GROUPS' macro to simplify the attribute coding.
- Explain more details for sysoff_enable attribute.

Since v5:
- Remove one line wrapper.
- Merge header content into source file, remove header file.
- Remove 'charge_term_enable' sysfs entry and merge it into
  'charge_term_current' property control.
- Change MODULE_LICENSE from 'GPL v2' to 'GPL'.
  Following by the below discussion
  https://lore.kernel.org/all/YxAVAt2eWB3NFlrk@google.com/
- Recover all the change in sysfs-class-power.
- New a sysfs-class-power-rt9471 file.
- Remove 'charge_term_enable' sysfs entry, directly integrate it in
  'charge_term_current' power supply property control.

Since v4:
- Remove the line for the owner field in driver.
- Add the documentation for sysfs entries.

Since v3:
- Move unevaluatedProperties line after $ref for binding patch.
- Add Reviewed-by tag for binding patch.

Since v2:
- Remove the properties for interrupt controller things in the binding documentation.
- Fix dtc error for typo, it's 'regulator-name', not 'regulator-compatible'.
- Add regulator min/max microamp to allow otg vbus current adjustable in example.
- Specify the active-level for charge-enable-gpios in binding example.
- Fix checkpatch error about 'foo * bar' to 'foo *bar' in psy_device_to_chip function.
- Specify the member name directly for the use of linear range.

ChiYuan Huang (3):
  dt-bindings: power: supply: Add Richtek RT9471 battery charger
  power: supply: rt9471: Add Richtek RT9471 charger driver
  Documentation: power: rt9471: Document exported sysfs entries

 Documentation/ABI/testing/sysfs-class-power-rt9471 |  32 +
 .../bindings/power/supply/richtek,rt9471.yaml      |  73 ++
 drivers/power/supply/Kconfig                       |  16 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/rt9471.c                      | 931 +++++++++++++++++++++
 5 files changed, 1053 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9471
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
 create mode 100644 drivers/power/supply/rt9471.c

-- 
2.7.4

