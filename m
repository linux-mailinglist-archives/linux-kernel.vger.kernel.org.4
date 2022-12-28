Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 51FC76573A9
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 08:31:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232605AbiL1Hau (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 02:30:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58424 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232619AbiL1Hac (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 02:30:32 -0500
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51945EA6
        for <linux-kernel@vger.kernel.org>; Tue, 27 Dec 2022 23:30:31 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 1F4963200902;
        Wed, 28 Dec 2022 02:30:30 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 28 Dec 2022 02:30:30 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672212629; x=1672299029; bh=av
        aCv9mDt906Bh4sj41n++Uvq9fM0k+OtKCj4mLejVk=; b=J4MTx/6DSY86I1XPwH
        SXekn71UCI6T3R/aU6g6Y2eZoN/84Mdcb4RaW1vPUY63leUA3w6JqdUQLMe/AFJB
        IoOPqx+AaklEy4fSw5T8e6HP7Vl32AAauRe4zeNshFAlcj3AXc4F/jkk1ojTQ2A/
        vSgE5I1WNK0Y9GIWLO4pvhe2Dap3FBy3rpDmfSqdR/IpljCfseNdZuYuUByME9Wx
        ZMk5qS3i7lybZrRaFG6CV9hONZtHWe2kRVX0cRXMHRNZrAclaEc4T1OhT+1+kTby
        JC2oI2wEhee5T5FUgPqUPmDvFhoCL6V5m+MzCDyp0vMKvFqvUbM0kRym0FVwSFk4
        JjqA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672212629; x=1672299029; bh=avaCv9mDt906B
        h4sj41n++Uvq9fM0k+OtKCj4mLejVk=; b=iC7cLEPbfula0gN/zS5qUdjw70ZZp
        hVo9Dmhkf/OUiPVPDW3Tuupka+cPw6ONJ2Ya//dr4T1+R+UUrwDe7t69ZGLLycCy
        sA7HqJsBckVAx2HYJyJ+nYXnCgqtlvY3QYeq9ZbSl4eGFsRA9+umhYP2mnwHtvbM
        OwUa9jjsT5zcJhuk83ZPVFrsGqwNY156JN4tt7MRBoVnTHO3nYwrQ85V0JPEnZiN
        UL+oRsB4g8KuGUSVslzJtGd1YEp11h3QeI4T3PInDzZvPVHU5bYht894YYWxnjjE
        ETD+8zVT9bKNlM9vx0+za+xaf7sY5kp+lIgLl+2Hb5kPEruZ1zqd29Ciw==
X-ME-Sender: <xms:lfCrYz6ew2gKNY9ixm-qlVwKTbv-m04lLLsCKpJM6VVN0-lVT_gC7A>
    <xme:lfCrY44wlEi-uSY8gh5_yL_f-w_tuLRZETak0S6KMovr9C5EY-J-jbbIg10HH5x85
    uLgb3eV0KI7A-IyHQ>
X-ME-Received: <xmr:lfCrY6eYAOnmzFsGKykCSXuofQ3PKT6OSojkVsd2MHQbwv06VWI1PCqQ2fvlS-At8ffipylxCKnl6RI31zRL6naLz5GbJH8FuZ-hVyTwpKXMyw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedugdduuddtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgfrhhlucfvnfffucdlfedtmdenucfjughrpefhvf
    evufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeftuhhsshgvlhhlucevuhhr
    rhgvhicuoehruhhstghurhesrhhushhsvghllhdrtggtqeenucggtffrrghtthgvrhhnpe
    fhvdeugfdtvdeiieegffefffekieegvdfgiedtjeetffevfefhtdehjeffieeivdenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehruhhstghurh
    esrhhushhsvghllhdrtggt
X-ME-Proxy: <xmx:lfCrY0J1Po9B-WtZ6zijqkrsKO9Fg__7yXw4FxofWaYujd4OZJ1aHQ>
    <xmx:lfCrY3L9DKwDQgpJwlQE1nMMn885j5unT-wkDaw6pQ0cEKhJ3yXGCA>
    <xmx:lfCrY9zxOu_BYzzSKcLjZy1iaUhanugRx7_Vz1wm403olUpSwxKCag>
    <xmx:lfCrY0r6wsgooC-7PhyRz8wqYvjPIblRifNiXnzDwpyIWTQPG_AMAg>
Feedback-ID: i4421424f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Dec 2022 02:30:26 -0500 (EST)
From:   Russell Currey <ruscur@russell.cc>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ajd@linux.ibm.com, zohar@linux.ibm.com, mpe@ellerman.id.au,
        Russell Currey <ruscur@russell.cc>
Subject: [PATCH 2/6] powerpc/secvar: WARN_ON_ONCE() if multiple secvar ops are set
Date:   Wed, 28 Dec 2022 18:29:39 +1100
Message-Id: <20221228072943.429266-3-ruscur@russell.cc>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221228072943.429266-1-ruscur@russell.cc>
References: <20221228072943.429266-1-ruscur@russell.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The secvar code only supports one consumer at a time.

Multiple consumers aren't possible at this point in time, but we'd want
it to be obvious if it ever could happen.

Signed-off-by: Russell Currey <ruscur@russell.cc>
---
 arch/powerpc/kernel/secvar-ops.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/arch/powerpc/kernel/secvar-ops.c b/arch/powerpc/kernel/secvar-ops.c
index 6a29777d6a2d..aa1b2adc2710 100644
--- a/arch/powerpc/kernel/secvar-ops.c
+++ b/arch/powerpc/kernel/secvar-ops.c
@@ -8,10 +8,12 @@
 
 #include <linux/cache.h>
 #include <asm/secvar.h>
+#include <asm/bug.h>
 
-const struct secvar_operations *secvar_ops __ro_after_init;
+const struct secvar_operations *secvar_ops __ro_after_init = NULL;
 
 void set_secvar_ops(const struct secvar_operations *ops)
 {
+	WARN_ON_ONCE(secvar_ops);
 	secvar_ops = ops;
 }
-- 
2.38.1

