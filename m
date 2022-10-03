Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3DE835F2E71
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 11:49:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230111AbiJCJtS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 05:49:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50920 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229505AbiJCJs7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 05:48:59 -0400
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 254622CE26;
        Mon,  3 Oct 2022 02:48:21 -0700 (PDT)
Received: by mail-pl1-x631.google.com with SMTP id x6so3944006pll.11;
        Mon, 03 Oct 2022 02:48:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=message-id:date:subject:cc:to:from:from:to:cc:subject:date;
        bh=Y0csu8Dh/y4589KJtXmHOk06d4pIvjQiH0RxPVlSXS0=;
        b=C0ZLpnAUMjDAvpF53HGHYtljhaEg216nQEUaFvqQK5cc7SuBDVOp2OngZyX2r7xKJX
         Y8EL16V8pQC6p5r2oqJvPXEegg5lUUjEnXuTD8CR7S4fw04DXNT8IQUGB3vCSvJe0GxO
         T4gay8GmdJAp1lfzTGOJKzoZ6CMVkV1+q2xgz/SPKyibSTL9/gTU4DS0/URQ1dxnXL7m
         cHM1BTvyNl5ms4URm5apqzRzdM14h3t9OW2uk3WfqDm4UDzKzvrgZjodNZCF5ONPvzEA
         pW1I6qDEXhTuZiM5D12s3t9YLRdDZKDrRWDEulL54a+MMTiK2ZaffsJb3CWMsJADdeHV
         I/YQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date;
        bh=Y0csu8Dh/y4589KJtXmHOk06d4pIvjQiH0RxPVlSXS0=;
        b=O5x0CgYRkRxgd1VY8ZF4KlnwWWm/h+zeiano4UuoIR6589n3TrnxyrhTlpLxcz2PCB
         ocAGubHlLOwkRKGTI+PqxmetICGwzpUhsMjhm+iWu2jJboUtX5kAxYiO8c1SGlcyLAW8
         3akzV1imLFEZMZo1JToYJ31PkMDQTqZpeep+sOnGDHo7/JGkRoFFu2ei10qjgjrVYv7Q
         b0PNoOm0onooMo0z72lWAZNTpBLF/M7EUJk33g8b2OCToXaT949j2C4HU1XiKE28qZy6
         OmnDjaUKD5HnN+uZYkK4keqlmnYgjowCGENg/Be2vv983bCusXNCg0m7EyZpdiCMSP8X
         kZFg==
X-Gm-Message-State: ACrzQf3Ogpofy5+ir+LQSDbA/moSMjkWpoYKjT6hfCIREDFW5G2YvU0i
        NrjhePIlPLd1EYWcXA4V8I5essdFPuE=
X-Google-Smtp-Source: AMsMyM4w85/tqOMNPczMZ1+Qs9hjJ9qld1W5ckbcd35t+bg/WN06ZNFonnzNsu+vwylzYPDoZ3cICA==
X-Received: by 2002:a17:90b:3889:b0:200:8255:f0e5 with SMTP id mu9-20020a17090b388900b002008255f0e5mr11478144pjb.51.1664790499938;
        Mon, 03 Oct 2022 02:48:19 -0700 (PDT)
Received: from localhost.localdomain ([2402:7500:587:da00:1dbc:8208:4596:9e9c])
        by smtp.gmail.com with ESMTPSA id t23-20020a6564d7000000b0043014f9a4c9sm6142230pgv.93.2022.10.03.02.48.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 03 Oct 2022 02:48:19 -0700 (PDT)
From:   cy_huang <u0084500@gmail.com>
To:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        sre@kernel.org
Cc:     cy_huang@richtek.com, allen_chiang@richtek.com,
        linux-pm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 0/3] Add Richtek RT9759 smart cap divider charger support
Date:   Mon,  3 Oct 2022 17:48:10 +0800
Message-Id: <1664790493-16386-1-git-send-email-u0084500@gmail.com>
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

This patch set is to add Richtek RT9759 smart cap divider charger.

The RT9759 is a high efficiency and high charge current charger.
The efficiency is up to 97.8% when VBAT=4.2V, IBAT=2.5A, and the maximum
charge current is up to 8A. The device integrates smart cap divider topology
with a dual-phase charge pump core and 9 channel high speed ADCs to monitor
the charging process.

ChiYuan Huang (3):
  dt-bindings: power: supply: Add Richtek RT9759 smart cap divider
    charger
  power: supply: rt9471: Add Richtek RT9759 smart cap divider charger
  Documentation: power: rt9759: Document exported sysfs entries

 Documentation/ABI/testing/sysfs-class-power-rt9759 |  37 ++
 .../bindings/power/supply/richtek,rt9759.yaml      |  61 ++
 drivers/power/supply/Kconfig                       |  15 +
 drivers/power/supply/Makefile                      |   1 +
 drivers/power/supply/rt9759.c                      | 611 +++++++++++++++++++++
 5 files changed, 725 insertions(+)
 create mode 100644 Documentation/ABI/testing/sysfs-class-power-rt9759
 create mode 100644 Documentation/devicetree/bindings/power/supply/richtek,rt9759.yaml
 create mode 100644 drivers/power/supply/rt9759.c

-- 
2.7.4

