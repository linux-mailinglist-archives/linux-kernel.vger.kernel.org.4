Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DD396D6057
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 14:27:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234812AbjDDM1r (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 08:27:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234691AbjDDM1o (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 08:27:44 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975D22723
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 05:27:26 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 8DD803F237
        for <linux-kernel@vger.kernel.org>; Tue,  4 Apr 2023 12:27:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1680611221;
        bh=SBwltSBA1Cuh+CK1UQ1IsW5TPEcKKSWaWSCqZDGcNAU=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=bzHJ6G05nHovdo8R7c+yMRgQBnlYDFR/pBz7o6CITGWJJJFHyhkf055PoF1xWFic2
         foefEmXRFNtrLHumy+3HzyRq4ogOQ7PQtolnB8VWpArUxbIfYCoRV7vbvd28tTZNap
         ReFdzV2QeZo+96vb0w90p/ITx0wFuws/I7j0g+H69QCK6mzVhtAIqtYlWQVgeMtDiM
         IcigXy8Jhdjms3QuJUgchhPAVFNuzusgCeSQT7WsbjwZLuxUXLHCyPxki631D2byOE
         XXkQfSiVpy+uyF96NiPXCAQXl87i4pUFDEGcFgkIX5wLjyqAub8dhPRf6m/uZi+H3s
         Omp5eBUAERdrg==
Received: by mail-ed1-f69.google.com with SMTP id t14-20020a056402240e00b004fb36e6d670so45571951eda.5
        for <linux-kernel@vger.kernel.org>; Tue, 04 Apr 2023 05:27:01 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680611221;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=SBwltSBA1Cuh+CK1UQ1IsW5TPEcKKSWaWSCqZDGcNAU=;
        b=7bgqxGMJPegYIKN3h/+YE8JrX4fFTWJeERWuRzblvkyHg1POnl6Wu5CHBf7s9l5wH7
         oVkulczGulGaW0KWmVfcFj258l1iAHU/SIkOOE9L24d7TP/roRoQPuoj4FQuGeQNTZyG
         xXrdDISSYSjFVXdYpr5uyzxLKw8CE/U8FJeYQ9p1SDkRkXNJhXX0buIgudoR1XHCUEMv
         KilKqCHUizyPXiiwopidFPsur0opHfzPnGUnMS5fN2+IOPDInA4L6O8H295psGWkCTJz
         +TSAcL7GX0JXqRJjrWXaBp3R4f/UedLPbhU1h89+Tj0SjanR51PZR1GyvjnXvrLZB6nK
         f3ZQ==
X-Gm-Message-State: AAQBX9eDAb2ILLgG/zCPPt2o8cBuwRoJqmvEEfEOJKGUy6rYCB3VfFSI
        TY5kf0rUPk8qKu0cuDta7w6PHlpjai45FQedWEd9+RQvQZFiToo1znWFTAPqPlt+TaQbOqEdBV1
        L/IrNinvNBBsrxNrAxwW+et97w6vbhJ5Vzk6UiFE6nPJXNBiTTw==
X-Received: by 2002:a17:906:8a4e:b0:8b2:8876:6a3c with SMTP id gx14-20020a1709068a4e00b008b288766a3cmr2277001ejc.29.1680611221129;
        Tue, 04 Apr 2023 05:27:01 -0700 (PDT)
X-Google-Smtp-Source: AKy350YZ51MzYAAIrgMr9VwyYHkPp3DPTJnVPj4U13sBmqXZOAo6HTDEc9CjNDGSVKq2r+H89Ih5PQ==
X-Received: by 2002:a17:906:8a4e:b0:8b2:8876:6a3c with SMTP id gx14-20020a1709068a4e00b008b288766a3cmr2276986ejc.29.1680611220898;
        Tue, 04 Apr 2023 05:27:00 -0700 (PDT)
Received: from amikhalitsyn.. ([95.91.208.118])
        by smtp.gmail.com with ESMTPSA id p18-20020a170906229200b00930ba362216sm6033056eja.176.2023.04.04.05.27.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Apr 2023 05:27:00 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     pbonzini@redhat.com
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Sean Christopherson <seanjc@google.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] KVM: SVM: add some info prints to SEV init
Date:   Tue,  4 Apr 2023 14:26:52 +0200
Message-Id: <20230404122652.275005-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230404122652.275005-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230404122652.275005-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's add a few pr_info's to sev_hardware_setup to make SEV/SEV-ES
enabling a little bit handier for users. Right now it's too hard
to guess why SEV/SEV-ES are failing to enable.

There are a few reasons.
SEV:
- npt is disabled (module parameter)
- CPU lacks some features (sev, decodeassists)
- Maximum SEV ASID is 0

SEV-ES:
- mmio_caching is disabled (module parameter)
- CPU lacks sev_es feature
- Minimum SEV ASID value is 1 (can be adjusted in BIOS/UEFI)

Cc: Sean Christopherson <seanjc@google.com>
Cc: Paolo Bonzini <pbonzini@redhat.com>
Cc: Stéphane Graber <stgraber@ubuntu.com>
Cc: kvm@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
 arch/x86/kvm/svm/sev.c | 27 +++++++++++++++++++++------
 1 file changed, 21 insertions(+), 6 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index a42536a0681a..14cbb8f14c6b 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2168,17 +2168,24 @@ void __init sev_hardware_setup(void)
 	bool sev_es_supported = false;
 	bool sev_supported = false;
 
-	if (!sev_enabled || !npt_enabled)
+	if (!sev_enabled)
 		goto out;
 
+	if (!npt_enabled) {
+		pr_info("Failed to enable AMD SEV as it requires Nested Paging to be enabled\n");
+		goto out;
+	}
+
 	/*
 	 * SEV must obviously be supported in hardware.  Sanity check that the
 	 * CPU supports decode assists, which is mandatory for SEV guests to
 	 * support instruction emulation.
 	 */
 	if (!boot_cpu_has(X86_FEATURE_SEV) ||
-	    WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_DECODEASSISTS)))
+	    WARN_ON_ONCE(!boot_cpu_has(X86_FEATURE_DECODEASSISTS))) {
+		pr_info("Failed to enable AMD SEV as it requires decodeassists and sev CPU features\n");
 		goto out;
+	}
 
 	/* Retrieve SEV CPUID information */
 	cpuid(0x8000001f, &eax, &ebx, &ecx, &edx);
@@ -2188,8 +2195,10 @@ void __init sev_hardware_setup(void)
 
 	/* Maximum number of encrypted guests supported simultaneously */
 	max_sev_asid = ecx;
-	if (!max_sev_asid)
+	if (!max_sev_asid) {
+		pr_info("Failed to enable SEV as the maximum SEV ASID value is 0.\n");
 		goto out;
+	}
 
 	/* Minimum ASID value that should be used for SEV guest */
 	min_sev_asid = edx;
@@ -2234,16 +2243,22 @@ void __init sev_hardware_setup(void)
 	 * instead relies on #NPF(RSVD) being reflected into the guest as #VC
 	 * (the guest can then do a #VMGEXIT to request MMIO emulation).
 	 */
-	if (!enable_mmio_caching)
+	if (!enable_mmio_caching) {
+		pr_info("Failed to enable SEV-ES as it requires MMIO caching to be enabled\n");
 		goto out;
+	}
 
 	/* Does the CPU support SEV-ES? */
-	if (!boot_cpu_has(X86_FEATURE_SEV_ES))
+	if (!boot_cpu_has(X86_FEATURE_SEV_ES)) {
+		pr_info("Failed to enable SEV-ES as it requires sev_es CPU feature\n");
 		goto out;
+	}
 
 	/* Has the system been allocated ASIDs for SEV-ES? */
-	if (min_sev_asid == 1)
+	if (min_sev_asid == 1) {
+		pr_info("Failed to enable SEV-ES as the minimum SEV ASID value is 1.\n");
 		goto out;
+	}
 
 	sev_es_asid_count = min_sev_asid - 1;
 	if (misc_cg_set_capacity(MISC_CG_RES_SEV_ES, sev_es_asid_count))
-- 
2.34.1

