Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 361076298A7
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Nov 2022 13:21:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238337AbiKOMVR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Nov 2022 07:21:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238220AbiKOMU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Nov 2022 07:20:57 -0500
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8860029C98
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:20:20 -0800 (PST)
Received: by mail-wm1-x329.google.com with SMTP id 5so9545204wmo.1
        for <linux-kernel@vger.kernel.org>; Tue, 15 Nov 2022 04:20:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=G4CwzUDPI8BFp1FhB5WPo5aqvpH21jtoAPzMzWAnvUo=;
        b=SBDrWcpdDInlU4msR5E2SFNE7G9leBJE5rADLMlJh8e6XKOfR9xtoLObo4euSN1Mqx
         aNWlW5ZKJnPy+UCOoZGvUn72B69MNORKnlOGUyCvQ6OlkrIUON9NRMOKCVMuXc9xIFo7
         jSMGXIS23HRD+nJ1q9LSC92g7PSG1jkVP+8j62+Yz+s9o3ZfdZyeoUttLgJ4/exABjCy
         lJUXJq1ZcfeKcR2Ol/GO/CF5C+rDP8OGH33nTIysCTgNy3G/QA3B5UH6PUKhgdLzoBt6
         kIDorvwZRZvdD++1ah22cRRu/TS6QLWUV/N16vT2BvS20KoqLKlG9BBO78G/1g4zF6yT
         bh/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=G4CwzUDPI8BFp1FhB5WPo5aqvpH21jtoAPzMzWAnvUo=;
        b=63bA94suuS31UULJdW3cJxoFdRINko8sCD4tKw+Ew3YxqEp5ncXSE90Y7xXkISkP0P
         ogceaBI72JLrBqis/SWE/4IlhLZZiyIuRxfNaqHLT0cM7N4UViXflTC6jF05sci4tLE1
         0CfPF/uFe45f8zqEDjTW8bV6OteyLhqfRnh3/g39bTTeGJUejjdWPJhw+xc8fVHexCa4
         a00f7xKPSPsu8qo16zu4XvFU2OXTPMF96FS7B2j9pUQ9NgcGsBqwlyOV64B3yLIjxXS2
         eu/YdrCZIJwVZhX8Raadze1cCr1NsHsI7vQpBqawZwStg/3WFlCrjN2gYCjwmiY5feh7
         fViw==
X-Gm-Message-State: ANoB5pkc9yswK+J1jdZm/p2yunSHoLXTl8lnRbOFsUY5cwMiRde7+7WE
        qvOj3LpBLIXm+3Q2ivGKflsE7w==
X-Google-Smtp-Source: AA0mqf4m+fCQ4odCISEIk8cMJZGwsbxaAB/23kYau0MzilPO5yq3Adw1x6p9hF59Fgq7Nesu3UkP+Q==
X-Received: by 2002:a1c:f003:0:b0:3c6:7abb:9d2b with SMTP id a3-20020a1cf003000000b003c67abb9d2bmr1242227wmb.182.1668514818989;
        Tue, 15 Nov 2022 04:20:18 -0800 (PST)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id w12-20020a05600c474c00b003b435c41103sm27108954wmo.0.2022.11.15.04.20.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 15 Nov 2022 04:20:18 -0800 (PST)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     devicetree@vger.kernel.org, Guenter Roeck <linux@roeck-us.net>,
        Jean Delvare <jdelvare@suse.com>
Cc:     linux-kernel@vger.kernel.org, linux-hwmon@vger.kernel.org,
        Patrick Rudolph <patrick.rudolph@9elements.com>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH v5 0/3] Add devicetree support for max6639
Date:   Tue, 15 Nov 2022 13:20:02 +0100
Message-Id: <20221115122005.758519-1-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

These patches adds devicetree support for MAX6639.

Changes in V5:
- Add pwms support
Changes V4:
- Fix dt error
- update comment
Changes V3:
- correct fan dt property name
- remove unrelevent changes
Changes V2:
- Fix dt schema error.
Changes:
- Add fan-common dt schema.
- add dt-binding support for max6639
- add max6639 specific property

Marcello Sylvester Bauer (1):
  dt-bindings: hwmon: Add binding for max6639

Naresh Solanki (2):
  dt-bindings: hwmon: fan: Add fan binding to schema
  hwmon: (max6639) Change from pdata to dt configuration

 .../devicetree/bindings/hwmon/fan-common.yaml |  42 ++
 .../bindings/hwmon/maxim,max6639.yaml         |  93 ++++
 drivers/hwmon/Kconfig                         |   1 +
 drivers/hwmon/max6639.c                       | 465 +++++++++++++++---
 4 files changed, 527 insertions(+), 74 deletions(-)
 create mode 100644 Documentation/devicetree/bindings/hwmon/fan-common.yaml
 create mode 100644 Documentation/devicetree/bindings/hwmon/maxim,max6639.yaml


base-commit: 0cf46a653bdae56683fece68dc50340f7520e6c4
-- 
2.37.3

