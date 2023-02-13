Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AB8CF694EA4
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:02:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230499AbjBMSCw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:02:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230074AbjBMSCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:02:47 -0500
Received: from mail-il1-x14a.google.com (mail-il1-x14a.google.com [IPv6:2607:f8b0:4864:20::14a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12F0D16AE9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:02:41 -0800 (PST)
Received: by mail-il1-x14a.google.com with SMTP id k13-20020a92c24d000000b003127853ef5dso9802338ilo.5
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:02:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=70xvWuvYdaN0RHC9y2y+6cAohvWGNUH5IWQYtqhnjZE=;
        b=URPZnrYEApr1It+IVm3J16L4qUg2cigXzrcfhjuyLm3gPm2LeW9+RwiQI/kFr/6ju1
         QRO6gvU1kY6dLPzMq2+wCiHIcftw3NDrPbCYlTgca1cM2BNmpFb0BRx5X9OGtMV8iMKn
         4GC9+VjpgnH3ZAy+lR+VvnIrWIq2xvRyCFftvMcT7dG5qXF65SenNlCXkyi51D30k9MG
         Abkslkc8PQo9JTtVqLGYkkodvZP1FK5TTm+dDZmUgRPrThCwyXSKOQumFLGyGTRNrShi
         Ag9sAoQFvgZNJPH5i4fSQ1WSw6K2yJobD3ohEm/lMQeQ/f+tIPe4oookQuuonepQMnv3
         WQQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=70xvWuvYdaN0RHC9y2y+6cAohvWGNUH5IWQYtqhnjZE=;
        b=KHJThiRwpnDc8XSyd/u2fGF4rMH03DcvEMRY6T53ig/7OM+3F72P8tJ3/x8hG6JmvP
         UY9tZyQ7v0McdbwRTkbcoke3oPFqT35Mp3LWMgv9HG94EEwr79w7u3w1qPrftbYzxQMg
         iMJgpDP/59WUiCY955Cf+MgyNAszkdSCwVExv9snPq9P56SYd8Mduwf539Ze2EOyfnvd
         ZyAOFF0bIIapdIUz7WGwvA5gO2XcnGQ+J6y1lZ6V7GPaU6GIL2k7v1K9LABwirKL32MY
         t794IJAPcyPB5Ud+luBL2EzuW/OojIdKI2oPgCMwDPN/HjqV+XZ+Gb6v3CahOnu1n+bR
         nCNg==
X-Gm-Message-State: AO0yUKVwOFAWDBRTNlPXwmaALP3dlZxiiPSvoxYLpeMxS186GJFG+5y/
        QO2I3wElfsJYtXATZBGKdGcBGKVlqyTE
X-Google-Smtp-Source: AK7set/8lUVnM/xUxlc5ev5n38xMQU6UonaUcN7oe3E/mMvqt3yuPRKRB7RT8I01SIqBC8WTFb8l0KoRBFtB
X-Received: from rananta-linux.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:22b5])
 (user=rananta job=sendgmr) by 2002:a92:2613:0:b0:310:9afc:aa6 with SMTP id
 n19-20020a922613000000b003109afc0aa6mr2640960ile.0.1676311360373; Mon, 13 Feb
 2023 10:02:40 -0800 (PST)
Date:   Mon, 13 Feb 2023 18:02:22 +0000
In-Reply-To: <20230213180234.2885032-1-rananta@google.com>
Mime-Version: 1.0
References: <20230213180234.2885032-1-rananta@google.com>
X-Mailer: git-send-email 2.39.1.581.gbfd45094c4-goog
Message-ID: <20230213180234.2885032-2-rananta@google.com>
Subject: [PATCH 01/13] selftests: KVM: aarch64: Rename vpmu_counter_access.c
 to vpmu_test.c
From:   Raghavendra Rao Ananta <rananta@google.com>
To:     Oliver Upton <oupton@google.com>,
        Reiji Watanabe <reijiw@google.com>,
        Marc Zyngier <maz@kernel.org>,
        Ricardo Koller <ricarkol@google.com>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jing Zhang <jingzhangos@google.com>,
        Colton Lewis <coltonlewis@google.com>,
        Raghavendra Rao Anata <rananta@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.linux.dev,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The upcoming patches would add more vPMU related tests to the file.
Hence, rename it to be more generic.

Signed-off-by: Raghavendra Rao Ananta <rananta@google.com>
---
 tools/testing/selftests/kvm/Makefile                            | 2 +-
 .../kvm/aarch64/{vpmu_counter_access.c => vpmu_test.c}          | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)
 rename tools/testing/selftests/kvm/aarch64/{vpmu_counter_access.c => vpmu_test.c} (99%)

diff --git a/tools/testing/selftests/kvm/Makefile b/tools/testing/selftests/kvm/Makefile
index b27fea0ce5918..a4d262e139b18 100644
--- a/tools/testing/selftests/kvm/Makefile
+++ b/tools/testing/selftests/kvm/Makefile
@@ -143,7 +143,7 @@ TEST_GEN_PROGS_aarch64 += aarch64/psci_test
 TEST_GEN_PROGS_aarch64 += aarch64/vcpu_width_config
 TEST_GEN_PROGS_aarch64 += aarch64/vgic_init
 TEST_GEN_PROGS_aarch64 += aarch64/vgic_irq
-TEST_GEN_PROGS_aarch64 += aarch64/vpmu_counter_access
+TEST_GEN_PROGS_aarch64 += aarch64/vpmu_test
 TEST_GEN_PROGS_aarch64 += access_tracking_perf_test
 TEST_GEN_PROGS_aarch64 += demand_paging_test
 TEST_GEN_PROGS_aarch64 += dirty_log_test
diff --git a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c b/tools/testing/selftests/kvm/aarch64/vpmu_test.c
similarity index 99%
rename from tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
rename to tools/testing/selftests/kvm/aarch64/vpmu_test.c
index 453f0dd240f44..581be0c463ad1 100644
--- a/tools/testing/selftests/kvm/aarch64/vpmu_counter_access.c
+++ b/tools/testing/selftests/kvm/aarch64/vpmu_test.c
@@ -1,6 +1,6 @@
 // SPDX-License-Identifier: GPL-2.0-only
 /*
- * vpmu_counter_access - Test vPMU event counter access
+ * vpmu_test - Test the vPMU
  *
  * Copyright (c) 2022 Google LLC.
  *
-- 
2.39.1.581.gbfd45094c4-goog

