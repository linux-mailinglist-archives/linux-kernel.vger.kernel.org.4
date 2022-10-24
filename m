Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78AB6609F7A
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:57:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230071AbiJXK5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:57:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229707AbiJXK5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:57:24 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A109017431;
        Mon, 24 Oct 2022 03:57:01 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id 192so1491731pfx.5;
        Mon, 24 Oct 2022 03:57:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=UikcnIir68Gg7jAGa1ZQ2RsVDg3ZFdrs8Hn3MmBqfQE=;
        b=oI9D3OTI21D7mTjKfwDvNngd5mssglBIeHiyZiN1iHD3ZeyIwr6kTqsE37bjRpH/RX
         uI7GI/+k548eIbpTFhPno1BRvmr1aVLMA+BC9e3wlJT3Mc+0kMywhlDrZqXVrlG+wbS6
         8R8l+itlqz2Xd1sf7/4KTeSF41rWjHxsDWND23CDQ3wb6RuoUluyYT5mwRBtk/aZ+rwm
         lAxb4xwUoqc4Xa/kDnenA4CBpwy4igzSkUWkGSjE2YIKun6RPw2G1+TZoLXnYp5pLldB
         OIoJjjydtrVAvtpI6LmORI/Cq4sV0u752r40zQlvSeiPhsQb82aR+0jwF7F+eZWZ3C1Z
         Mctw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=UikcnIir68Gg7jAGa1ZQ2RsVDg3ZFdrs8Hn3MmBqfQE=;
        b=M72rDuLZUtMJU7DTajKYfXZobKa/ISELpptzFgqrehxTOwaTqdnL/Yi6tNssvbE1x0
         4K3AH7pQ05RHRNP154JCt7bwNWeY6mh8sm/gUaCrCQgCcH/lakzb3oapPzzwKhjvNuJc
         fenuBphmcmJZ8s4GnbBmVT7o4WCHSyp3tgtOO0DDIfLIJgVY6QW64tF1eWwIppJwVChi
         pXKwTIeeRyD4GR99thdSM8MbWjfrrQoJz1M51S6TQLrDpHmI7ftIPBgwNnQilBaNGcBl
         z5lQ0oBzkLiirNpJqUe3Ir3Mu6vA+Z35cw77psFUuI7iSnUMnVVBlu7QZET6EzHaNhzV
         4P6A==
X-Gm-Message-State: ACrzQf0IUtwoXyNfd6NoOYapKCYvn+4+EBIaPh/jMmmRXiD5yvzxPPsF
        wHB1IHVL9U9YwbpLks/TAFg=
X-Google-Smtp-Source: AMsMyM78e2ncpzE6psSy4B7MWzgD25cLDSaMI3i0DTFnGFw+E3K5YIHnKpjSWdPny8vcuL0Xd7wmVg==
X-Received: by 2002:a05:6a00:8d0:b0:53b:2cbd:fab6 with SMTP id s16-20020a056a0008d000b0053b2cbdfab6mr32834633pfu.3.1666609011328;
        Mon, 24 Oct 2022 03:56:51 -0700 (PDT)
Received: from RD-3580-24288.rt.l (111-82-141-7.emome-ip.hinet.net. [111.82.141.7])
        by smtp.gmail.com with ESMTPSA id a15-20020a631a4f000000b0045751ef6423sm1366696pgm.87.2022.10.24.03.56.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 03:56:51 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     chiaen_wu@richtek.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 0/3] Add Richtek RT9467 5A Battery Charger support
Date:   Mon, 24 Oct 2022 18:55:45 +0800
Message-Id: <cover.1666633143.git.chiaen_wu@richtek.com>
X-Mailer: git-send-email 2.25.1
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

From: ChiaEn Wu <chiaen_wu@richtek.com>

This patch set is to add Richtek RT9467 5A Battery Charger support.

RT9467 is a switch-mode single cell Li-Ion/Li-Polymer battery charger
for portable applications.

It integrates a synchronous PWM controller, power MOSFETs,
input current sensing and regulation, high-accuracy voltage regulation,
and charge termination. The charge current is regulated through
integrated sensing resistors.

The RT9467 also features USB On-The-Go (OTG) support. It also integrates
D+/D- pin for USB host/charging port detection.

Thank you,
ChiaEn Wu
---
Change in v3:
- In Patch 1/3 (dt-bindings: RT9467 Charger DTS)
	- Add 'Reviewed-By' tag


Change in v2:
- In Patch 1/3 (dt-bindings: RT9467 Charger DTS)
	- Revise the definition of 'enable-gpios'
	- Revise the node name to generic name in the example
	  ('rt9467@5b' --> 'charger@5b')
	- Revise the example usage of 'charge-enable-gpios' with GPIO flags

- In Patch 2/3 (power: supply: RT9467 Charger Driver)
	- Add missing header file <linux/bitfied.h>
	- Add new header files <linux/sysfs.h> and <linux/kstrtox.h> for adding
	  'sysoff' sysfs feature
	- Add assign 'rt9467_sysfs_groups' to '.attr_grp' of psy config
	- Remove unused varible 'rt9467_port_stat_names[]'

- In Patch 3/3 (ABI Documentation for RT9467 sysfs attribute)
	- New file since v2 patch


ChiaEn Wu (3):
  dt-bindings: power: supply: Add Richtek RT9467 battery charger
  power: supply: rt9467: Add Richtek RT9467 charger driver
  Documentation: power: rt9467: Document exported sysfs entries

 Documentation/ABI/testing/sysfs-class-power-rt9467 |   19 +
 .../power/supply/richtek,rt9467-charger.yaml       |   82 ++
 drivers/power/supply/Kconfig                       |   19 +
 drivers/power/supply/Makefile                      |    1 +
 drivers/power/supply/rt9467-charger.c              | 1282 ++++++++++++++++++++
 5 files changed, 1403 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9467
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml
 create mode 100644 drivers/power/supply/rt9467-charger.c

-- 
2.7.4

