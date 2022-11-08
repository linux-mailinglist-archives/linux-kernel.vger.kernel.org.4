Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24ACB62090E
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Nov 2022 06:49:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232919AbiKHFtN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Nov 2022 00:49:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiKHFtI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Nov 2022 00:49:08 -0500
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27C892CDD0;
        Mon,  7 Nov 2022 21:49:08 -0800 (PST)
Received: by mail-pj1-x1031.google.com with SMTP id b11so12804977pjp.2;
        Mon, 07 Nov 2022 21:49:08 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=H3KQf7TxXqsfJQzf4Azgdjk/AZBsBCgazSy7YY7DQbs=;
        b=ij9WmqAk3cdoqxFVsF4y4GP66li66hUxgCgrsvFiZ3++j45KENqe5gHNEmHbIORBod
         YWVZMXl1bFhqBP1B6+wXmRvhTzkTJw9eXZ+DM2YC9PaNsLKF245ZpEe/3cguVS/8r75p
         9NfRN3C2ZxkTrGIJjMhJE6AjyzGKJh0ao7RGO8LqDiygVivrVfQ7lsw4Toc5sIXjBDR/
         L4qxBKH0e16r8nOSjWC/41yXSbUimYFVo0YIVVkCsz65jSV/fvBKn4mHLxztCdyn9oyg
         KZaC+Y+Ngki0/J0PNCvxbNNsDzwd+NBD9espdPxA3ayMfwH98ylzVsU/QMHOZBv9h0g/
         aegg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H3KQf7TxXqsfJQzf4Azgdjk/AZBsBCgazSy7YY7DQbs=;
        b=Li7FCgYQCXfF2e7nri9juPgH/CGTppnSrj45SNsSbgLjoKbnvik55M4yPvDnIeXTaM
         7m7oxerR8OiZ0p4B99EoeeJDJgVnw55Z7WoO4GtYYKByyBerY0wwsFDycKT6fAkWAQSL
         WJ/QV5SprV/q3ru57en4hQhamwlop9yzGJBgwFQCf7WCdHmRIb+jSNknXtKGbihkh6gO
         jtjTt2omyRSrKyMam71f11/VgyiTkSXgeVkHnN36EJZzhMjJHRYk7KAXHn5wp/ipCwVh
         9ads9aZH0X6Y0jk7HskajD4JnVpHSYPlbuaUoQXQ4tNrFC02HgNg9572v7az8trI7YFq
         USYQ==
X-Gm-Message-State: ACrzQf3avAqm/3R5JVtWDJ8xMB7OjeflX69C1CmwEMBJdMUHtRtFYGfA
        DGoRi6+2exLLbT6DbtPLw0MwNh6KuiC4Kw==
X-Google-Smtp-Source: AMsMyM5TUpV3V+6/QLOTTFlnQ/TPxjp1FYWJNCMLVH13m2GeL3Kyqv9ZNRPtzyHcERlP37q4FsbEbA==
X-Received: by 2002:a17:902:8e85:b0:186:6ef8:181e with SMTP id bg5-20020a1709028e8500b001866ef8181emr953488plb.43.1667886545512;
        Mon, 07 Nov 2022 21:49:05 -0800 (PST)
Received: from RD-3580-24288.rt.l (42-72-183-173.emome-ip.hinet.net. [42.72.183.173])
        by smtp.gmail.com with ESMTPSA id q10-20020aa7982a000000b005618189b0ffsm5482163pfl.104.2022.11.07.21.49.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 21:49:05 -0800 (PST)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     chiaen_wu@richtek.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v3 RESEND 0/3] Add Richtek RT9467 5A Battery Charger support
Date:   Tue,  8 Nov 2022 13:48:50 +0800
Message-Id: <cover.1667886055.git.chiaen_wu@richtek.com>
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

