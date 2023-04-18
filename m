Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 151D16E5C07
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Apr 2023 10:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjDRIbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Apr 2023 04:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjDRIbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Apr 2023 04:31:13 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71A341BD8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:31:08 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id ffacd0b85a97d-2f87c5b4635so1934719f8f.1
        for <linux-kernel@vger.kernel.org>; Tue, 18 Apr 2023 01:31:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1681806667; x=1684398667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=T9/vm0NtXEK+KNOSC6UuWH3QK0gtkFq1Z2YAl8dA+C0=;
        b=vUGt/Ep2vPSkk4+EuDkVBQYFoDoIL/OKstOlfZSP61VMZjx6Zs4vjJGJst6X1NCXvN
         BJKYEdxG2Nvn9j5/ktMFRYAc2dV3Lq1QkHAe27BZJag8KDRBtuwYWM8uklV4yXrstKmp
         5fW/lsE6I+JNANJcxOPGE37zARO0PVTsSgwY28v1sbrOQmZkAoY0EFr34GxQJ/F76qsS
         89CeThIaKYhmNXZr/Fy6lrfnm7jw71eTUvyFBOzS3TqY6OOP3vYRsiawfRDZOqecYIbr
         OzzbUVf7O6Ysa2zEtwbZ5QNHM3hupz1ySeBCfOfcLY607RqyHxuLqped6xiXZwRfvzK9
         86Ow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681806667; x=1684398667;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=T9/vm0NtXEK+KNOSC6UuWH3QK0gtkFq1Z2YAl8dA+C0=;
        b=ZCahJLfTsBnl8pYET+BaNAjtKUZ04i+I6z/YPaqCL0ovasCxOtE/YgJxh+jiCWW8rs
         o8HjaBSU2/OQI2V9e+b/i7gNfTVlPA/G+GyQXvQ4cgG/6rkoz9vdtRXGDSDYC0h1F8Fe
         Sud0bPf+vUJHvniu2QSS3zCIzPqTgwc6pDdb/a6pLByzN7NXJgSWL6FMYgYA6W9LqJcR
         sMGViH4iO4RVltzix7TH8OdKwKePGnt9Xuel0oe+Xg0LbS2Yer+aH0Yn7mv0aK0GEWBm
         Kcw4NTPmpw/fxC/mtVWhhcDcsyEYs5Uflpswb/82ALvgJAooMyrWLATChzdadYfYyODq
         HbHg==
X-Gm-Message-State: AAQBX9chI1mWEZGne/dK3fIxuRUbeIZjW3HoZRVpmz2TATluAeJj6i5u
        9uOflZxWmd+tj99+e59aZpsd6Q==
X-Google-Smtp-Source: AKy350aQlYObze1DK9Q9kHXpUV95MNaUkzh6XBEGywF9C7h8qvBsmSUcfOa2Y50JSi/HVETLAwKj1w==
X-Received: by 2002:adf:df03:0:b0:2fe:d52:7ff1 with SMTP id y3-20020adfdf03000000b002fe0d527ff1mr357972wrl.29.1681806666723;
        Tue, 18 Apr 2023 01:31:06 -0700 (PDT)
Received: from mai.box.freepro.com ([2a05:6e02:1041:c10:c25b:18d5:815a:e12b])
        by smtp.gmail.com with ESMTPSA id l37-20020a05600c1d2500b003f1738d0d13sm1805978wms.1.2023.04.18.01.31.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 18 Apr 2023 01:31:06 -0700 (PDT)
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
To:     daniel.lezcano@linaro.org, rafael@kernel.org
Cc:     rui.zhang@intel.com, linux-pm@vger.kernel.org,
        linux-kernel@vger.kernel.org, thierry.reding@gmail.com
Subject: [PATCH v1 0/3] Move the thermal zone device structure in private header
Date:   Tue, 18 Apr 2023 10:30:52 +0200
Message-Id: <20230418083055.3611721-1-daniel.lezcano@linaro.org>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following series applies on top of the changes:

https://lore.kernel.org/all/20230413114647.3878792-1-daniel.lezcano@linaro.org/

There is no functional change, only code reordering and self-encapsulation.

The series adds a macro check in thermal_core.h in order to warn in
case a driver is including the thermal core private headers.

Then the thermal zone device structure is moved from the exported
thermal.h header to the thermal_core.h

Daniel Lezcano (3):
  thermal/core: Hardening the self-encapsulation
  thermal/core: Reorder the headers inclusion
  thermal/core: Move the thermal zone structure to the private core
    header

 drivers/thermal/gov_bang_bang.c       |  1 +
 drivers/thermal/gov_fair_share.c      |  1 +
 drivers/thermal/gov_power_allocator.c |  7 ++-
 drivers/thermal/gov_step_wise.c       |  1 +
 drivers/thermal/gov_user_space.c      |  1 +
 drivers/thermal/thermal_acpi.c        |  1 +
 drivers/thermal/thermal_core.c        |  7 ++-
 drivers/thermal/thermal_core.h        | 79 +++++++++++++++++++++++++++
 drivers/thermal/thermal_helpers.c     |  1 +
 drivers/thermal/thermal_hwmon.c       |  1 +
 drivers/thermal/thermal_netlink.c     |  1 +
 drivers/thermal/thermal_of.c          |  1 +
 drivers/thermal/thermal_sysfs.c       |  1 +
 drivers/thermal/thermal_trip.c        |  1 +
 include/linux/thermal.h               | 75 -------------------------
 15 files changed, 98 insertions(+), 81 deletions(-)

-- 
2.34.1

