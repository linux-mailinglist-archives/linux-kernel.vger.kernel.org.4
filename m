Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BEE146C87EF
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 23:02:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232329AbjCXWCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 18:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231693AbjCXWCr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 18:02:47 -0400
X-Greylist: delayed 95 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 24 Mar 2023 15:02:44 PDT
Received: from gmmr-4.centrum.cz (gmmr-4.centrum.cz [46.255.227.205])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E8569144A9
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 15:02:44 -0700 (PDT)
Received: from gmmr-4.centrum.cz (localhost [127.0.0.1])
        by gmmr-4.centrum.cz (Postfix) with ESMTP id E601FABBA
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:01:07 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=atlas.cz; s=mail;
        t=1679695267; bh=wG+MCIOgalYaCRwp5w4NLK9EPO2p7bcnY4V9JHOzSn0=;
        h=From:To:Cc:Subject:Date:From;
        b=R6N7syRZ4JprrYgEj3wDSz0yvsAqCxe66Cxg9p82/JlndMEIAyGeIWY7Tm9CHjED0
         o1HG+AdqKjbW/ywf5N6qwZNG38Jjne0HQd8Z1pHMugf9IFWn7+RAMfdFPQu/4PWsGG
         YpuELysWcIJ/I9FqqtwKU1PVWhDHF8BlKA4Qaz8E=
Received: from antispam99.centrum.cz (unknown [10.30.208.99])
        by gmmr-4.centrum.cz (Postfix) with ESMTP id E48372011F9B
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 23:01:07 +0100 (CET)
X-IPAS-Result: =?us-ascii?q?A2DeAgDaGx5k/03h/y5aHAEBAQEBAQcBARIBAQQEAQFAC?=
 =?us-ascii?q?YFGgxeBZoRSkS+LXoYbgR+MPQ8BAQEBAQEBAQEJRAQBAYUFhTwmOBMBAgQBA?=
 =?us-ascii?q?QEBAwIDAQEBAQEBAwEBAQUBAQEBAQEGAwGBHYUvRoZYJwQLAUYoAQwCJgJfE?=
 =?us-ascii?q?4J+gigBAzGyLX8zGgJlnhoCSQVTXYEngRQti2+GCIINhH2ECxGEAIJnBJlIC?=
 =?us-ascii?q?oE0dYEgDkpzgQQCCQIRa4ESCGuBfUECDWQLDm+BSwKCHTI3AwkDBwUsHUADC?=
 =?us-ascii?q?xgNFjoTLDUUIQZYawEtEhIFAwsVKkcECDkGThECCA8SDyxDDkI3NBMGXAEpC?=
 =?us-ascii?q?w4RA1BCGWwEggsHJiSacAIBgmcBgQ4ImGmtX4QEhDqcMhoylxQeA5IJAZdqo?=
 =?us-ascii?q?0WEVYF6gX4zIjCDIlIZoht0OwIHAQoBAQMJgjuGLwGCWAEB?=
IronPort-Data: A9a23:Nkaqq68/VO5CZpivWzf3DrUDnn+TJUtcMsCJ2f8bNWPcYEJGY0x3x
 zMeUTqBPa6PamX9ft5zbNixp0oD7MPWyIRjGVBs+3wxFiIbosfsO4+Ufxz6V8+wwmwvb67FA
 +E2MISowBUcFyeEzvuVGuG96yM6jMlkf5KkYMbcICd9WAR4fykojBNnioYRj5Vh6TSDK1rlV
 eja/ouOaDdJ5xYuajhPs/nZ9Es11BjPkGpwUmIWNKgjUGD2yCF94KI3fcmZM3b+S49IKe+2L
 86rIGaRows1Vz90Yj+Uuu6Tnn8iG9Y+DiDX4pZiYJVOtzAZzsAEPgbXA9JHAatfo23hc9mcU
 7yhv7ToIesiFvWkdOjwz3C0HgkmVZCq9oMrLlC27+vD8RbaYkDg0vZtK2BmFosR5d9oVDQmG
 fwwcFjhbziMgqetxa6jE7EqjcklMNP2OcUUqBmMzxmFU7B8HM2FGf+Xo4AHtNszrpkm8fL2b
 tAaYD9mdjzJfxlGIREcGvrSmc/x3ymhK2YG9Dp5o4IF/XDIxgN+ioGzE/PYQ92wVZtPhnmX8
 zeuE2PRR0ty2Mak4TOf8Xupj/XnlD//UZlUH6/Q3vVqmlyI2msLCBBQUVahpuiRgVWxQdVCM
 woZ50IGqLA/3EGvStTnWhS+5n+I+BcBM/JWC+w15wCL4qXR6gedQGMDS1ZpbN0gqd8uXTdv2
 lKXt9foHiB09rqHTXuX7fGTtzzaESwUK3ISICwJVw0I5/H9r4wpyBHCVNBuFOiylNKdJN3r6
 2zU6nJj2vNJ15NNiPrTEU37vg9Ab6PhFmYdjjg7lEr8hu+lTOZJv7CV1GU=
IronPort-HdrOrdr: A9a23:ZN8Q76MdczA4YcBcTtCjsMiBIKoaSvp037Dk7SxMoHtuA6mlfq
 GV7ZYmPHDP5gr5NEtLpTniAtjifZqjz/9ICOAqVN/IYOCMggSVxe9ZgLcKuweBJxHD
X-IronPort-Anti-Spam-Filtered: true
X-IronPort-AV: E=Sophos;i="5.98,288,1673910000"; 
   d="scan'208";a="11860364"
Received: from unknown (HELO gm-smtp10.centrum.cz) ([46.255.225.77])
  by antispam99.centrum.cz with ESMTP; 24 Mar 2023 23:01:07 +0100
Received: from localhost.localdomain (ip-213-220-240-96.bb.vodafone.cz [213.220.240.96])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by gm-smtp10.centrum.cz (Postfix) with ESMTPSA id 941A9808B274;
        Fri, 24 Mar 2023 23:01:07 +0100 (CET)
From:   =?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        linux-kernel@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        =?UTF-8?q?Petr=20Van=C4=9Bk?= <arkamar@atlas.cz>
Subject: [PATCH] powerpc/pseries: Add spaces around / operator
Date:   Fri, 24 Mar 2023 23:00:41 +0100
Message-Id: <20230324220041.11378-1-arkamar@atlas.cz>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is follow up change after 14b5d59a261b ("powerpc/pseries: Fix
formatting to make code look more beautiful") to conform to kernel
coding style.

Signed-off-by: Petr Vaněk <arkamar@atlas.cz>
---
 arch/powerpc/platforms/pseries/iommu.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/platforms/pseries/iommu.c b/arch/powerpc/platforms/pseries/iommu.c
index c74b71d4733d..b0cb2fa39cf8 100644
--- a/arch/powerpc/platforms/pseries/iommu.c
+++ b/arch/powerpc/platforms/pseries/iommu.c
@@ -474,7 +474,7 @@ static int tce_setrange_multi_pSeriesLP(unsigned long start_pfn,
 		 * Set up the page with TCE data, looping through and setting
 		 * the values.
 		 */
-		limit = min_t(long, num_tce, 4096/TCE_ENTRY_SIZE);
+		limit = min_t(long, num_tce, 4096 / TCE_ENTRY_SIZE);
 		dma_offset = next + be64_to_cpu(maprange->dma_base);
 
 		for (l = 0; l < limit; l++) {
-- 
2.39.2

