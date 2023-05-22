Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E3A170C316
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 18:13:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231724AbjEVQNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 May 2023 12:13:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233062AbjEVQN1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 May 2023 12:13:27 -0400
Received: from smtp-relay-internal-1.canonical.com (smtp-relay-internal-1.canonical.com [185.125.188.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB196E9
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:13:26 -0700 (PDT)
Received: from mail-ed1-f69.google.com (mail-ed1-f69.google.com [209.85.208.69])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by smtp-relay-internal-1.canonical.com (Postfix) with ESMTPS id 61EFC41B53
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 16:13:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canonical.com;
        s=20210705; t=1684772003;
        bh=yEoXhOv9392G4YyVtPika8TuddyFutw1yuUvDKTMDXc=;
        h=From:To:Cc:Subject:Date:Message-Id:In-Reply-To:References:
         MIME-Version:Content-Type;
        b=TP0Ncy9/9VU/db5w+O0Yol+Hl0ShJCAJoBPlyVJZ+Tfjuf92uGL9uksa0qqDnNxrM
         cqGWToN3b82t4+SXWtwBF4myIioUGlU/fRynAZnDRNem6J2M8GqZe8c8/Tb4fR87WV
         9w5QqJEwFoqPCfdXbSnodzlAWJrQQESovwzULCpY4oU0NnSW0RFecvmIJ0ko2UM1bW
         VV9DxmqOQHWJVFUY83CIeisBgFMNiQ2MVSwJ2mlfTFYG+SOdmjT0Gp+uasOBoUBU15
         Rc9a/gqpAXWyy6kj4dSWg4zluXNbaYGcTwvFMzp0BPXflL8ym3wvpyGL4Fl4uPNGMX
         UHD/q0BHUOhMQ==
Received: by mail-ed1-f69.google.com with SMTP id 4fb4d7f45d1cf-512937f82b2so2416650a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 22 May 2023 09:13:23 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684772001; x=1687364001;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=yEoXhOv9392G4YyVtPika8TuddyFutw1yuUvDKTMDXc=;
        b=PmOcmeFlt6qZA7kpc5gNbTRgWjNbgXxk2D0P/u7QkrQB3kgtUFr3iUqNuvuVZYEndn
         VkbLyKmJNY3de41Z4lQPdxm5XM6EsvcWEUtJX435sItTpLqCbtk9WKXpLT2YcHKFYI1N
         G240xu9CMOXrZOUt2fKDTB2MB0tGCI6ItFINZ/WhRdXSJ44qb7r4fLgxqaWh3eVj3WYW
         X9e2sb7A7W0aZ+BLRxFyUjfa3MZr78se17lgVOLcVFoQ2C9xsBdMh4l/8sCPqTv1kCAz
         cyAr+pn1czmwOQm9dNCE9M6F47QBBFl3lggnHEMXcQNm042OFUdKf9NwKGge88Ay2ktX
         jFYw==
X-Gm-Message-State: AC+VfDwMqH7ajPGjlBF7QdnPdewVHvISl/eHQR2LJKXkuGf/gRbKDj94
        YinJ3UBFZyaP4w2JtuHsYNGkJQJpcRm9F8XA1vf1n+Wat2f3EcW0twuaePW2vTlTkDiCNlLeK0n
        M6SyCnBqoDTpwaTIxF4fS/Xhz4l7mbJlHzHIs7jhB1g==
X-Received: by 2002:a17:906:58c7:b0:96b:e93:3a9f with SMTP id e7-20020a17090658c700b0096b0e933a9fmr11141503ejs.20.1684772001416;
        Mon, 22 May 2023 09:13:21 -0700 (PDT)
X-Google-Smtp-Source: ACHHUZ6dUWTXh+XjI7wSktkwgjubPt+RAL8UbOeWuwZfD0kG6B2OVu9hYOQ/teuL04KXyyfGDkSquQ==
X-Received: by 2002:a17:906:58c7:b0:96b:e93:3a9f with SMTP id e7-20020a17090658c700b0096b0e933a9fmr11141482ejs.20.1684772001173;
        Mon, 22 May 2023 09:13:21 -0700 (PDT)
Received: from amikhalitsyn.local (dslb-088-074-206-207.088.074.pools.vodafone-ip.de. [88.74.206.207])
        by smtp.gmail.com with ESMTPSA id a7-20020a17090682c700b009658475919csm3225039ejy.188.2023.05.22.09.13.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 May 2023 09:13:20 -0700 (PDT)
From:   Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
To:     pbonzini@redhat.com
Cc:     Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>,
        Sean Christopherson <seanjc@google.com>,
        =?UTF-8?q?St=C3=A9phane=20Graber?= <stgraber@ubuntu.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>
Subject: [PATCH v2 2/2] KVM: SVM: enhance info printk's in SEV init
Date:   Mon, 22 May 2023 18:12:48 +0200
Message-Id: <20230522161249.800829-3-aleksandr.mikhalitsyn@canonical.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20230522161249.800829-1-aleksandr.mikhalitsyn@canonical.com>
References: <20230522161249.800829-1-aleksandr.mikhalitsyn@canonical.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Let's print available ASID ranges for SEV/SEV-ES guests.
This information can be useful for system administrator
to debug if SEV/SEV-ES fails to enable.

There are a few reasons.
SEV:
- NPT is disabled (module parameter)
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
Suggested-by: Sean Christopherson <seanjc@google.com>
Signed-off-by: Alexander Mikhalitsyn <aleksandr.mikhalitsyn@canonical.com>
---
v2:
	- print only the ASID ranges according to Sean's suggestion
---
 arch/x86/kvm/svm/sev.c | 9 +++++++--
 1 file changed, 7 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/sev.c b/arch/x86/kvm/svm/sev.c
index cc832a8d1bca..fff63d1f2a34 100644
--- a/arch/x86/kvm/svm/sev.c
+++ b/arch/x86/kvm/svm/sev.c
@@ -2224,7 +2224,6 @@ void __init sev_hardware_setup(void)
 		goto out;
 	}
 
-	pr_info("SEV supported: %u ASIDs\n", sev_asid_count);
 	sev_supported = true;
 
 	/* SEV-ES support requested? */
@@ -2252,10 +2251,16 @@ void __init sev_hardware_setup(void)
 	if (misc_cg_set_capacity(MISC_CG_RES_SEV_ES, sev_es_asid_count))
 		goto out;
 
-	pr_info("SEV-ES supported: %u ASIDs\n", sev_es_asid_count);
 	sev_es_supported = true;
 
 out:
+	if (boot_cpu_has(X86_FEATURE_SEV))
+		pr_info("SEV %s (ASIDs %u - %u)\n",
+			sev_supported ? "enabled" : "disabled", min_sev_asid, max_sev_asid);
+	if (boot_cpu_has(X86_FEATURE_SEV_ES))
+		pr_info("SEV-ES %s (ASIDs %u - %u)\n",
+			sev_es_supported ? "enabled" : "disabled", 1, min_sev_asid - 1);
+
 	sev_enabled = sev_supported;
 	sev_es_enabled = sev_es_supported;
 #endif
-- 
2.34.1

