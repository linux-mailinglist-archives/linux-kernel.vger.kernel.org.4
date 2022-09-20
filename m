Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B203B5BE5A8
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 14:23:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiITMXa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 08:23:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230511AbiITMXY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 08:23:24 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50E9F74E2C
        for <linux-kernel@vger.kernel.org>; Tue, 20 Sep 2022 05:23:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1663676602;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bJLXUbRPoBL46dcO0XZc1HhT2Y45lUQGJ1HmTGP+Pj8=;
        b=ZT8+rb+piNUAtB7Qp2cajY8gmDIi5mLsKxI0+yvX9CrnzL/sH1+1AOOLr8rz2Xhx0cy7cI
        ZUsWwbvPUTvh6K1mkQaWzgNNXu6OrWh1yTEqEcxdPIo7fUnMdqkGpVUsDUpb3/9zhnpzgu
        oOJdiSd5lshXrSjulSRfKrEFgSVhVfE=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-362-Emjs82K7M7iPfvk_Mfu3Eg-1; Tue, 20 Sep 2022 08:23:18 -0400
X-MC-Unique: Emjs82K7M7iPfvk_Mfu3Eg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.rdu2.redhat.com [10.11.54.8])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 9F8F4862FE2;
        Tue, 20 Sep 2022 12:23:17 +0000 (UTC)
Received: from t480s.redhat.com (unknown [10.39.195.16])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E4ED6C15BB5;
        Tue, 20 Sep 2022 12:23:13 +0000 (UTC)
From:   David Hildenbrand <david@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, linux-doc@vger.kernel.org,
        linuxppc-dev@lists.ozlabs.org,
        David Hildenbrand <david@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>,
        David Laight <David.Laight@ACULAB.COM>,
        Jonathan Corbet <corbet@lwn.net>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Dwaipayan Ray <dwaipayanray1@gmail.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Baoquan He <bhe@redhat.com>, Vivek Goyal <vgoyal@redhat.com>,
        Dave Young <dyoung@redhat.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>
Subject: [PATCH v1 2/3] powerpc/prom_init: drop PROM_BUG()
Date:   Tue, 20 Sep 2022 14:23:01 +0200
Message-Id: <20220920122302.99195-3-david@redhat.com>
In-Reply-To: <20220920122302.99195-1-david@redhat.com>
References: <20220920122302.99195-1-david@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 3.1 on 10.11.54.8
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Unused, let's drop it.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 arch/powerpc/kernel/prom_init.c | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/powerpc/kernel/prom_init.c b/arch/powerpc/kernel/prom_init.c
index a6669c40c1db..d464ba412084 100644
--- a/arch/powerpc/kernel/prom_init.c
+++ b/arch/powerpc/kernel/prom_init.c
@@ -96,12 +96,6 @@ static int of_workarounds __prombss;
 #define OF_WA_CLAIM	1	/* do phys/virt claim separately, then map */
 #define OF_WA_LONGTRAIL	2	/* work around longtrail bugs */
 
-#define PROM_BUG() do {						\
-        prom_printf("kernel BUG at %s line 0x%x!\n",		\
-		    __FILE__, __LINE__);			\
-	__builtin_trap();					\
-} while (0)
-
 #ifdef DEBUG_PROM
 #define prom_debug(x...)	prom_printf(x)
 #else
-- 
2.37.3

