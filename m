Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA43B69B9C4
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Feb 2023 12:27:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjBRL1G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Feb 2023 06:27:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229708AbjBRL0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Feb 2023 06:26:55 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD75C1714C
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 03:26:54 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 597F160B75
        for <linux-kernel@vger.kernel.org>; Sat, 18 Feb 2023 11:26:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9E9DEC4339B;
        Sat, 18 Feb 2023 11:26:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1676719613;
        bh=5jg2jqGPIyL6vN19Ng9QZ/xR8UUjQOy1EGr++zpbTmM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CQRyzWHzrkxJ03GZ8egiJEl13aeI8SFTPT6ryxKMdrLNwGNPhVoVVIMcOIbfbv01y
         r8leIqNsTYTpUOBDlWOtZS/LRi93keSh5by0i6Qv0HJ1S9CjVEzfx6iVdQc/GraWJ8
         nuoiygLirqQyEHVFTi+9wS+VXgM+CEwyjtg6LvPpN2C49iBDedHD9TIlI5PJC3Esm7
         voAZLWaMayUVmN8ycPb5R365kHKXlEQda6tRToBJFZ1gqsZu7skM+qch3yO0ldz7tc
         nXsUWr3PD4GWGXLA0/CQYa/P9ZVJTNZKfavNw4lhVwUcuMSjNQeyj+l5qqRKFrfrjN
         SUrEt/fnERu3Q==
Received: by pali.im (Postfix)
        id E93DA2761; Sat, 18 Feb 2023 12:26:49 +0100 (CET)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Scott Wood <oss@buserror.net>, Sinan Akman <sinan@writeme.com>,
        Martin Kennedy <hurricos@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 8/8] powerpc: dts: turris1x.dts: Remove "fsl,P2020RDB-PC" compatible string
Date:   Sat, 18 Feb 2023 12:14:05 +0100
Message-Id: <20230218111405.27688-9-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230218111405.27688-1-pali@kernel.org>
References: <20230218111405.27688-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"fsl,P2020RDB-PC" compatible string was present in Turris 1.x DTS file just
because Linux kernel required it for proper detection of P2020 processor
during boot.

This was quite a hack as CZ.NIC Turris 1.x is not compatible with
Freescale P2020-RDB-PC board.

Now when kernel has generic unified support for boards with P2020
processors, there is no need to have this "hack" in turris1x.dts file.

So remove incorrect "fsl,P2020RDB-PC" compatible string from turris1x.dts.

Signed-off-by: Pali Rohár <pali@kernel.org>
---
 arch/powerpc/boot/dts/turris1x.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
index e9cda34a140e..a95857de6858 100644
--- a/arch/powerpc/boot/dts/turris1x.dts
+++ b/arch/powerpc/boot/dts/turris1x.dts
@@ -15,7 +15,7 @@
 
 / {
 	model = "Turris 1.x";
-	compatible = "cznic,turris1x", "fsl,P2020RDB-PC"; /* fsl,P2020RDB-PC is required for booting Linux */
+	compatible = "cznic,turris1x";
 
 	aliases {
 		ethernet0 = &enet0;
-- 
2.20.1

