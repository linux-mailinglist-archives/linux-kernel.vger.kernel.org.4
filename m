Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64945F53D8
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Oct 2022 13:42:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230405AbiJELmj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Oct 2022 07:42:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230400AbiJELmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Oct 2022 07:42:21 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5406C52FD3;
        Wed,  5 Oct 2022 04:40:25 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id 10so11549568pli.0;
        Wed, 05 Oct 2022 04:40:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date;
        bh=znMOl22374pORc8UR+fjDFOF9UoWx3t/mYpcoIHV5PA=;
        b=nsmmYzYoEAbO0RJL0Kx7lAopDl8omrn9ccxvreynLy6wv52pKAgt9DXb6XQgpsdl7P
         FKpWmMclWtQRMcz7XcMMziONiz7DTsnF4iYEkvmaYjsMWcAxkUnAIzT49u3h/DHBcD8/
         l4Qe2D7i7X4CTInKkIwpNyRrgsWnF+n95S1B137JVmbMF6oh/Q+FrgB0ulzSn/q3HQC6
         TbTjqj0MuRd31EuosCVDbzVOkplLIFJB790Iyz61qOyEZrZFvV+cq2TQZ9f9wiyGuZ1z
         fWbDeT0lTV7kdGHbiUTlyFZg0lL09P6Jp/TNZCrOdfZ//8Q3d85IhWpvKBti7/UJQNwQ
         KSjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date;
        bh=znMOl22374pORc8UR+fjDFOF9UoWx3t/mYpcoIHV5PA=;
        b=dYQtMlPrwfGjXkl6pQCZd52h4RqfSsyE8FIE1Am8oME4imspDPUmB/bJrgnNMmHLpi
         H4/gV56gosvB0byFZ42cAB8VpKl1P+mVXpsWv45D22Vb6msg8IeetFv4Jh992I2c/Bew
         /2ccHJj4q5TGyoScr4srYAKlnEwkY337AxHRugAmEg98d0JHCk2U3j4YBVc0d6Vm/t3D
         PbyqNdtYa+5VPYgz4HK0BFIo5JtURUNLecEHC+Q2bAi3XzNANI8GFEziqbXQzvDU7ds/
         wCr4hJR10FPiTDA67gmnzoBylsIkekmPGGiOX3cS8LDLBgjtyI97/nYZQbItu3pAaTEA
         B8xA==
X-Gm-Message-State: ACrzQf0kkK+zRFDTYSDSl/IoADbKQLI0hMlbS15ZgOom/RLICuPYAcz5
        YVC4NA42TVlHyyLIVfBsMatki/xC3rFDpg==
X-Google-Smtp-Source: AMsMyM4iUSJvuWgEPc53cKYUoWcrsnGPz8R1JVmTfgvEM9exIKZUHbP1IDD7vPXX9smtkIOynN4HZw==
X-Received: by 2002:a17:90a:10d6:b0:20a:46a7:beb9 with SMTP id b22-20020a17090a10d600b0020a46a7beb9mr4707837pje.49.1664969881496;
        Wed, 05 Oct 2022 04:38:01 -0700 (PDT)
Received: from RD-3580-24288.rt.l (42-73-126-108.emome-ip.hinet.net. [42.73.126.108])
        by smtp.gmail.com with ESMTPSA id v9-20020a17090a4ec900b00200b2894648sm979202pjl.52.2022.10.05.04.37.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 05 Oct 2022 04:38:01 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     sre@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org
Cc:     chiaen_wu@richtek.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: [PATCH v2 0/3] Add Richtek RT9467 5A Battery Charger support
Date:   Wed,  5 Oct 2022 19:37:19 +0800
Message-Id: <cover.1664997251.git.chiaen_wu@richtek.com>
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

This charger driver is based on a 'linear_ranger' queued patch which adds
'LINEAR_RANGE_IDX' macro for declaring the linear_range struct simply.
https://lore.kernel.org/all/20220920161218.dkkfvfomrruebahi@mercury.elektranox.org/

Thank you,
ChiaEn Wu
---
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
	- New file since v2 patchset

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

