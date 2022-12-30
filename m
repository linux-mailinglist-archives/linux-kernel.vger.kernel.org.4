Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF9F16594A1
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 05:21:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234419AbiL3EVe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 23:21:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234024AbiL3EVO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 23:21:14 -0500
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C00F10FD
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 20:21:13 -0800 (PST)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.nyi.internal (Postfix) with ESMTP id E5B9C5C034B;
        Thu, 29 Dec 2022 23:21:12 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Thu, 29 Dec 2022 23:21:12 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=russell.cc; h=cc
        :cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672374072; x=1672460472; bh=av
        aCv9mDt906Bh4sj41n++Uvq9fM0k+OtKCj4mLejVk=; b=AdfnUSDcvhkNMT5qCO
        AGnXPlAaZOOHNImBd5bJ/NIwV2xgkd+58jc1AoriH5xNS6O3fRcoE6SNRuqLlxaC
        cK3q7xPoVNJ/o5hpxB1azDqdGxLQgPNxThdDaRbb+DyUP/DynwEuZEMKYpdsAAG5
        PYMMGjVpK4SeMEkHZ9Sw7s30jbdUZOiJUuUNGaeD8PvSv8kNtDis/XU7D7endoJF
        BO0lhG9sD2t3Zj6TpS//5ramOMbnDMAoxhPBXe6aJHOTmSE/78l6fHrJAhnlIRqX
        iqq0GwF330APEiWRq5gb2p9SsJl46Ntwuwp04/9bm3vpH8hyKfwIOnvM84rx4ahx
        2Ucg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672374072; x=1672460472; bh=avaCv9mDt906B
        h4sj41n++Uvq9fM0k+OtKCj4mLejVk=; b=ZbpGheFs815c1clpgDCXEJB+Kvsq2
        78bKBhR5qE0TTh0YcJGHAK43gEupTOcCfHdBwBxzEEq+9VQ1Ff+HNH7Zzv6Ro7wT
        jlOXwTxq7aWnVRCGlQ5hsH53iHaPdHApDrqR5LKkAbGJTbKbkjZJHsILoECooYuf
        T3LbJe06dlYXy1k9J2UCo8FCjJbTVSYRfK659IuDx7/vKVEJEz2Pj8eR6NYsQQ0y
        MGu3U5OrfayvY4YNSknH2QIhe4AL37llflnp8sxXgPFggduMkGv5lDrM+8i3NYMV
        2vVTNpBcYNTZEQZjiX7jI+zAS5cxAMpjnxa4LcRigjwF1CUg/BqOOw5eA==
X-ME-Sender: <xms:OGeuY4vsrS_QNTPBH2IR2LrsnH-E74P6SmmQjVM2vQHeCm_Fy1YKyA>
    <xme:OGeuY1e1rHGLoi_TXOHGy7SAhcnN2EycHE-rq05kwW4grfLb52zpjn-2WBmjTvdxu
    KvhBd9Me-F_ETLPGA>
X-ME-Received: <xmr:OGeuYzy4CScfhYUUVnr5uEgdfyzryF5vYRf0zTdUYivBD9taQ0Ir7XAHHbvKsoCjfwh_9g4KN75ZFFyPyuGFRTRkGXxgjXcgU-_FVovoSvy8xA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieehgdejtdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecufghrlhcuvffnffculdeftddmnecujfgurhephffvve
    fufffkofgjfhgggfestdekredtredttdenucfhrhhomheptfhushhsvghllhcuvehurhhr
    vgihuceorhhushgtuhhrsehruhhsshgvlhhlrdgttgeqnecuggftrfgrthhtvghrnhephf
    dvuefgtddvieeigefffeffkeeigedvgfeitdejteffveefhfdtheejffeiiedvnecuvehl
    uhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomheprhhushgtuhhrse
    hruhhsshgvlhhlrdgttg
X-ME-Proxy: <xmx:OGeuY7PF3H5NEqrW6QjUfPgNef-6JdZLDDWFxX7Gq3rsa1uPqpbwdw>
    <xmx:OGeuY4_D5hQjvYpypyZWawxZgzS4PgpFmbK0Aa84y3Rwbsna-pxYEQ>
    <xmx:OGeuYzVargSKTX_DMyhDjforEeSOUWhr0QoUY0p2-4mr85M_pRazbQ>
    <xmx:OGeuY1NDGvSaZ-lGDXMZiv7sTr7ShrTme1UiWM4gW1f1W46GS5ipkg>
Feedback-ID: i4421424f:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Dec 2022 23:21:09 -0500 (EST)
From:   Russell Currey <ruscur@russell.cc>
To:     linuxppc-dev@lists.ozlabs.org
Cc:     gregkh@linuxfoundation.org, gcwilson@linux.ibm.com,
        linux-kernel@vger.kernel.org, nayna@linux.ibm.com,
        ajd@linux.ibm.com, zohar@linux.ibm.com, mpe@ellerman.id.au,
        Russell Currey <ruscur@russell.cc>
Subject: [PATCH v2 2/7] powerpc/secvar: WARN_ON_ONCE() if multiple secvar ops are set
Date:   Fri, 30 Dec 2022 15:20:09 +1100
Message-Id: <20221230042014.154483-3-ruscur@russell.cc>
X-Mailer: git-send-email 2.38.1
In-Reply-To: <20221230042014.154483-1-ruscur@russell.cc>
References: <20221230042014.154483-1-ruscur@russell.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
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

