Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32AB66F832D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 14:44:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232156AbjEEMn7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 08:43:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229570AbjEEMn5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 08:43:57 -0400
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F3DE7DBA
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 05:43:56 -0700 (PDT)
Received: by mail-lj1-x233.google.com with SMTP id 38308e7fff4ca-2ac7ac8a4ffso19473171fa.0
        for <linux-kernel@vger.kernel.org>; Fri, 05 May 2023 05:43:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1683290634; x=1685882634;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:from:to:cc:subject:date:message-id:reply-to;
        bh=SuYX5zR3BqGct76Msm/Q12tOnmEfYOVRBCf1o9KituA=;
        b=pXi1NF2hC8Mlyi9G5+hesmETmbCBHVsqsMSHgBikHhwlsraKEhENeSKFJMnwg/1etQ
         iH9dnNmI3vGwhdOBdV4j5kz6zYkRAjmvJvPmquJUnpELLF5EUteuUDaPNCeA+ya9EqOE
         RH16ymx4qSD873aVaskfmaacoP1yWD6iRXy6fJO0ifJx1pL1wCGMroDgS25UekdXSUDe
         hpHy7fNbjegegMoVERBKZ4krMNjBf3SqwXcefxa2M+1uTbfszNxvU9LcGUhU20q+vN4p
         1sosMX+zrg6dqyDYIsq3wS4uSzjEPDXkvSV6hfR80PvZCOCb1+FDWlCcSH4q1AXyRyMk
         BgiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683290634; x=1685882634;
        h=cc:to:message-id:content-transfer-encoding:mime-version:subject
         :date:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SuYX5zR3BqGct76Msm/Q12tOnmEfYOVRBCf1o9KituA=;
        b=lhtM0WkVucB9Naw9IiW1QtnS6LLbkMbhXxLLiHvLG7SH7rCSz5NmEgTMpCetfI+Kjt
         bl1f9dX6uzlAqgpwAGG1+kttjnUxSo/DVJ/mvppuaA14g7QkTdBjF3rvNdw2yfo1vtIT
         m46dJwqKbYaTi0IoLwCNAGOJmKBoxDUdqysjRrY7aBFLIldpU4WfmngfyJhDW0cc6qUz
         bjLrzJWQG3B2qAjT2Lcgc7dsnj9peRB0JDZQAcVQ5P/vjB7HsJzc90RS1z6PwW+bnt0F
         INjSgCxURVGyGdjQlTBzYI5wVxsBdR4sCv1/pbLlWDrrXF+bU5WmrBI82sf1maxsEEW6
         iTRw==
X-Gm-Message-State: AC+VfDx8TrotFxzl8m/ucV4gVk1ycJU0xZRnvJqU+5vc3xkl6TEp4by8
        pYFqJmHReElfmKafw8jvaiKNnA==
X-Google-Smtp-Source: ACHHUZ4asDX2x0oLz+jAca7e1zelHbDaspA1IEvg3iW85PoBEPjsKMFyfArzyUwWk4dV44SzBStKHA==
X-Received: by 2002:a2e:8945:0:b0:2a8:d39b:1496 with SMTP id b5-20020a2e8945000000b002a8d39b1496mr413793ljk.24.1683290634359;
        Fri, 05 May 2023 05:43:54 -0700 (PDT)
Received: from [127.0.1.1] ([85.235.12.238])
        by smtp.gmail.com with ESMTPSA id p3-20020a2ea403000000b002ac7a25c001sm310838ljn.24.2023.05.05.05.43.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 05 May 2023 05:43:53 -0700 (PDT)
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Fri, 05 May 2023 14:43:53 +0200
Subject: [PATCH v2] docs: dt: Make references and mention kernel
 abstractions
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230505-dt-docs-refresh-v2-1-56bf359c53b4@linaro.org>
X-B4-Tracking: v=1; b=H4sIAAj6VGQC/x3NMQrDMAyF4asEzRU4Dl56ldLBtpRYQ+0glTYQc
 vc4GX94H28HYxU2eA47KP/EpNUe/jFALrEujEK9wTs/ueAC0hepZUPlWdkKhjEwJUqJ3AhdpWi
 MSWPN5XJr+7N+YsYl4CzbtVg7le3+fL2P4wR1vInZgwAAAA==
To:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
Cc:     Grant Likely <grant.likely@linaro.org>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
X-Mailer: b4 0.12.1
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This document is named "Linux and Devicetree" so I think we
should write a bit more about how the device tree fits into
the Linux kernel frameworks these days after we have created
the fwnode and swnode.

Signed-off-by: Linus Walleij <linus.walleij@linaro.org>
---
These docs are old and outdated and need to be edited to
reflect the current situation.
---
ChangeLog v1->v2:
- Spelling mistakes
- Resend because nothing happens
---
 Documentation/devicetree/usage-model.rst | 45 +++++++++++++++++++++++++++++---
 1 file changed, 41 insertions(+), 4 deletions(-)

diff --git a/Documentation/devicetree/usage-model.rst b/Documentation/devicetree/usage-model.rst
index b6a287955ee5..37605cb549cf 100644
--- a/Documentation/devicetree/usage-model.rst
+++ b/Documentation/devicetree/usage-model.rst
@@ -75,7 +75,44 @@ out of mainline (nios) have some level of DT support.
 If you haven't already read the Device Tree Usage\ [1]_ page,
 then go read it now.  It's okay, I'll wait....
 
-2.1 High Level View
+2.1 Linux Kernel Firmware Abstractions
+--------------------------------------
+
+The Linux kernel supports several different hardware description
+frameworks and DT is just one of them. The closest sibling is the
+:ref:`Documentation/firmware-guide/acpi/index.rst ACPI`
+DSDT (Differentiated System Description Table).
+
+To make it possible to write a device driver that will adapt to DT
+or other hardware description models, the kernel has grown some
+abstractions, first and foremost the firmware node API, exposing
+device properties. The firmware node "fwnode" internals can be found
+in ``<linux/fwnode.h>`` while the device driver-facing API can be
+found in ``<linux/property.h>``. The idea is that if a driver is using
+the firmware node API, it should be trivial to support DT and ACPI
+DSDT alike in the same driver.
+
+The fwnode framework also makes it possible to modify and extend the
+Linux in-kernel model with software-managed nodes "swnodes" to apply
+quirks or manage registration of devices that cannot be handled any
+other way. This API can also be found in ``<linux/property.h>``.
+
+Further, when the DT core register devices these need to fold into the
+Linux device driver model, which essentially means that some kind of
+``struct device`` has to be created to match a corresponding
+``struct device_driver``. This API can be explored in
+detail in :ref:`Documentation/driver-api/driver-model/index.rst the driver API documentation`
+but what you need to know is that the Linux DT parser code will on its
+own mostly spawn platform devices and AMBA devices on the platform
+and AMBA bus respectively, and apart from that it will augment devices
+spawn on other buses where applicable.
+
+Every Linux kernel subsystem that want to supply additional data to
+detected devices using the device tree, or that want to provide
+resources to other devices in the DT, will need to implement calls into
+the DT abstractions.
+
+2.2 High Level View
 -------------------
 The most important thing to understand is that the DT is simply a data
 structure that describes the hardware.  There is nothing magical about
@@ -97,7 +134,7 @@ Linux uses DT data for three major purposes:
 2) runtime configuration, and
 3) device population.
 
-2.2 Platform Identification
+2.3 Platform Identification
 ---------------------------
 First and foremost, the kernel will use data in the DT to identify the
 specific machine.  In a perfect world, the specific platform shouldn't
@@ -180,7 +217,7 @@ However, this approach does not take into account the priority of the
 compatible list, and probably should be avoided for new architecture
 support.
 
-2.3 Runtime configuration
+2.4 Runtime configuration
 -------------------------
 In most cases, a DT will be the sole method of communicating data from
 firmware to the kernel, so also gets used to pass in runtime and
@@ -217,7 +254,7 @@ On ARM, the function setup_machine_fdt() is responsible for early
 scanning of the device tree after selecting the correct machine_desc
 that supports the board.
 
-2.4 Device population
+2.5 Device population
 ---------------------
 After the board has been identified, and after the early configuration data
 has been parsed, then kernel initialization can proceed in the normal

---
base-commit: 457391b0380335d5e9a5babdec90ac53928b23b4
change-id: 20230505-dt-docs-refresh-515edbdbbd01

Best regards,
-- 
Linus Walleij <linus.walleij@linaro.org>

