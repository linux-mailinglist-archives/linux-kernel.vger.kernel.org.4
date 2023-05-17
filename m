Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 923C570619E
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 09:48:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229867AbjEQHsp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 03:48:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229530AbjEQHso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 03:48:44 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 098D81B7
        for <linux-kernel@vger.kernel.org>; Wed, 17 May 2023 00:48:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4QLlbW37thz4x1f;
        Wed, 17 May 2023 17:48:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ellerman.id.au;
        s=201909; t=1684309719;
        bh=GV51bmIb2WR+LyI2bNRccI9vo2atgork4BZloksI5Tc=;
        h=From:To:Cc:Subject:Date:From;
        b=FXlmYeEQbvLXoH7ZNX7bl5wEvOgtM6JE7G7M3E5hVLSJT8niVBEd9ziUNHYZtqq+m
         9K07TeGrbDLLKybxmBI20UFJO0EKrctS6PBCNnuFoyb/2Xs4+1fEfQ6+QUXit7ONrF
         1SxtGTlovWbe7i81HvBY/Vo/x2ifwo60CE/fDEmDSLy/v9pGu8PO5Av9SPm7bWkqd+
         k4mDWWiluKVRBYCkgw8EJW+LeZxPxJ6PLohGTBRJvv0rtkhXWEjR6jXcToL43MTemN
         RVZXLhQhq8hzoZlDCcFtOJjkBd7n2zUKporugwQ9RZ81NMyH+jpd2O9c4eNlLqu8ND
         wY4e0O4Nmi1UA==
From:   Michael Ellerman <mpe@ellerman.id.au>
To:     <linuxppc-dev@lists.ozlabs.org>
Cc:     <linux-kernel@vger.kernel.org>, <benh@kernel.crashing.org>
Subject: [PATCH] powerpc: Mark powermac as orphan in MAINTAINERS
Date:   Wed, 17 May 2023 17:48:19 +1000
Message-Id: <20230517074819.52546-1-mpe@ellerman.id.au>
X-Mailer: git-send-email 2.40.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ben no longer has time to do any maintenance of the powermac code. Mark
it as orphan.

Signed-off-by: Michael Ellerman <mpe@ellerman.id.au>
---
 MAINTAINERS | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e0ad886d3163..865a50238f44 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -11907,9 +11907,8 @@ F:	lib/linear_ranges.c
 F:	lib/test_linear_ranges.c
 
 LINUX FOR POWER MACINTOSH
-M:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
 L:	linuxppc-dev@lists.ozlabs.org
-S:	Odd Fixes
+S:	Orphan
 F:	arch/powerpc/platforms/powermac/
 F:	drivers/macintosh/
 
-- 
2.40.1

