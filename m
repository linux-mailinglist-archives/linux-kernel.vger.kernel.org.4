Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D58865BB39
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 08:30:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236905AbjACHaD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 02:30:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236824AbjACHaB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 02:30:01 -0500
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6665BE3C;
        Mon,  2 Jan 2023 23:30:00 -0800 (PST)
Received: by mail-pj1-x1033.google.com with SMTP id v23so32076143pju.3;
        Mon, 02 Jan 2023 23:30:00 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H3KQf7TxXqsfJQzf4Azgdjk/AZBsBCgazSy7YY7DQbs=;
        b=CPxHxBZjVCniNmdtX2ZpHRVSpos5pRWc6GcETrPIxnqyr60/zuKzTqPAHDO6ISsFym
         ympM8iTuCavmDEw+Am4nEknpZ5TRQ0Ct8sN+VePzFjaY0Xv0VKXqaqycSOThNs9O5xaX
         FgSKZIJg0kU1VLgZ4xDW900w/0IzwkFugjzRQJV9PxrQpZTsrlzFoGgEpnC72tQJ6NFY
         CD/JW0UvIjE8uUBOMPmUJSVIUfjZ3GXSsMA9gDN50sMPuQfafQA4K7ZYvc8a81kSscjz
         mHa8aOyZ0psdA3h7txMSx6si0zUTnxeLqNLn2rS3iFZWp8Ta2cV2w0DmeKsGztS8hjid
         IEdw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3KQf7TxXqsfJQzf4Azgdjk/AZBsBCgazSy7YY7DQbs=;
        b=osAF14qjIcar0C91K8meeigWtNMwhPSUEyGyGqCXEMtHQiKAHvRPt5NO1Yl/zrVTxd
         FK/PY9VqKxaeQcewctvpVJ5VeQd/w7NLthKvlyZFgn9Lz8Eie3PecwKivmf2ygbQvPgZ
         kq8mUwc5aPqCbJG/W0bQsZ1y5TeVX555JMnghH+CH1Too47f3ttt2asb9P/lsVNFOgc8
         gYGNzXlhe3EqHOh8OvuBa3zPpahr3BGE42CA0ZQXvdVrSkh2ZNUzQFNDJJBCzkBHyCUc
         ppNcLhKdOtLwujfyixsYJiJaDCIei+td//VrGDsKqJd6UjoUiF7CMD2+kd4AkzdKkLuL
         eJ0A==
X-Gm-Message-State: AFqh2kqtTs4mV7kk2MhzS7u1K/hMymp1jsjXi5/j05pt4Eo7kqAp5Ufm
        9h7MUn4TACwGqdtTueawRmQ=
X-Google-Smtp-Source: AMrXdXsmmuQSiL/uhXwZx+yzfOc/Myq0sul7RhmdvCRF6i35gnC1MVH64iuul8Gcz3SFhfXoXQsebA==
X-Received: by 2002:a17:902:7082:b0:189:aedf:677d with SMTP id z2-20020a170902708200b00189aedf677dmr56893738plk.69.1672731000431;
        Mon, 02 Jan 2023 23:30:00 -0800 (PST)
Received: from RD-3580-24288.rt.l (42-73-255-34.emome-ip.hinet.net. [42.73.255.34])
        by smtp.gmail.com with ESMTPSA id f4-20020a170902684400b00189f69c1aa0sm21449839pln.270.2023.01.02.23.29.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 02 Jan 2023 23:30:00 -0800 (PST)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     chiaen_wu@richtek.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 RESEND 0/3] Add Richtek RT9467 5A Battery Charger support
Date:   Tue,  3 Jan 2023 15:29:55 +0800
Message-Id: <cover.1672730839.git.chiaen_wu@richtek.com>
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

 .../ABI/testing/sysfs-class-power-rt9467      |   19 +
 .../power/supply/richtek,rt9467-charger.yaml  |   82 ++
 drivers/power/supply/Kconfig                  |   19 +
 drivers/power/supply/Makefile                 |    1 +
 drivers/power/supply/rt9467-charger.c         | 1282 +++++++++++++++++
 5 files changed, 1403 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9467
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9467-charger.yaml
 create mode 100644 drivers/power/supply/rt9467-charger.c

-- 
2.25.1

