Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F3F325E97FD
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 04:39:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233203AbiIZCjz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 25 Sep 2022 22:39:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56022 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233071AbiIZCjt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 25 Sep 2022 22:39:49 -0400
Received: from mail-pl1-x634.google.com (mail-pl1-x634.google.com [IPv6:2607:f8b0:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6467C1055E;
        Sun, 25 Sep 2022 19:39:43 -0700 (PDT)
Received: by mail-pl1-x634.google.com with SMTP id c24so4983921plo.3;
        Sun, 25 Sep 2022 19:39:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Y/2qP9EuvSyDRcxGMj6/oFp0YDhUw2RdOArQ87n1wDE=;
        b=NWa6IgDa3LrRqtJpTgkEvUUyKEM2xVQP801nGzuJO+2KW8JP+Ycf85voa2jwjHw/nX
         VeRWroBfMWJgMG9oUKT6i26W/d4Qy4WrobW1QGWnpbw4mybdabEnBMh/H8Rgro/WQTGS
         HNn69lHgXiPswF2IL+kh6IBCjwU3nd2VtnUoiET6ZrlQmoucKB16ETve7v3UPn+RCYCu
         BY34Dx4Fg2wG2TRERXbY8STVPpVE1A0/pu6cvIJAqjHh/BwrnHpISnO0gGSjk0o4NpDE
         uu/Vg5osSu8lJTTXpTcY6ouHn43myV1BND4HW9oqDlHu7aGXiT5w5r+HJ/Gx9tEQvJPj
         bCcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Y/2qP9EuvSyDRcxGMj6/oFp0YDhUw2RdOArQ87n1wDE=;
        b=ufAngpTvW7y+1enpEAxVSz81X0u69gbyh9XbGuHstnwdbg5W9nwcg5R2uV/GVUrsUO
         qN+EkiHo8Pu3spguMprOu3QL1tcVNzjaLBGNa8s6RfkLZWf4D2uTIzI4gdscpLVHNACF
         Wrn7QST8v0tejfbD2GeYT4KZmh8NS35BqPojy7trz0ay7ThlB58ED2zeNRZxidIcdFol
         7OBYXu+Z82mrvPKYs6WJo0jNvHwL3lpSy3UN8FEKqnjB9ZbezWNgCEjfZN5QHp0BsRqp
         O06rEPlf2YHBWTkR0ySMc1+RIzrwXEY0RuMoBRlNZJvRnQH0jzAuhNcqpD8Mxpkgaoet
         n9rA==
X-Gm-Message-State: ACrzQf24PwFqX+cuXCVWQg2NauS3x9XyFeTV91EiHUZdxK8QrZ4M3Lvs
        Plt1NY9LqkZUGF0nQH7H8O4lhCwWBTQ=
X-Google-Smtp-Source: AMsMyM5RyuGfmuMCEBOfXEYXZ60o49Y448+xU6Jr9byu3iqD1Wfi5HocMRUfJoHTOmfFYdoGOTZzgA==
X-Received: by 2002:a17:90b:33c9:b0:200:9ec2:f2eb with SMTP id lk9-20020a17090b33c900b002009ec2f2ebmr22908638pjb.29.1664159981943;
        Sun, 25 Sep 2022 19:39:41 -0700 (PDT)
Received: from localhost.localdomain ([49.216.30.246])
        by smtp.gmail.com with ESMTPSA id y3-20020aa793c3000000b005383988ec0fsm10667584pff.162.2022.09.25.19.39.36
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Sun, 25 Sep 2022 19:39:40 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     mazziesaccount@gmail.com, alina_yu@richtek.com,
        cy_huang@richtek.com, alinayu829@gmail.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v6 0/3] Add Richtek RT9471 3A battery charger support
Date:   Mon, 26 Sep 2022 10:39:29 +0800
Message-Id: <1664159972-4391-1-git-send-email-u0084500@gmail.com>
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
 drivers/power/supply/rt9471.c                      | 930 +++++++++++++++++++++
 5 files changed, 1052 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9471
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9471.yaml
 create mode 100644 drivers/power/supply/rt9471.c

-- 
2.7.4

