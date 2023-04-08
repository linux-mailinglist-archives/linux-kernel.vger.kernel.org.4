Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1F1296DBB66
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 16:03:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230199AbjDHODD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 10:03:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229901AbjDHOCi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 10:02:38 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 310ECFF18
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 07:02:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CBED8615A4
        for <linux-kernel@vger.kernel.org>; Sat,  8 Apr 2023 14:02:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1B476C433D2;
        Sat,  8 Apr 2023 14:02:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680962549;
        bh=rxdkN4YLGOwPjhnByZ2fzE4VRmzioCvI4RldmnDbTms=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=nWZl2aFKl2WIxZCUtVfmGi2La9etvx9LsuSljyNuQuoL8X5936f+Q1GF5Xw/OYzso
         FoYGDjNEkoxs3FEe/k03f8z6pRq9P43xwb2wJzKYuUoeRQYou+Kz50FuehoQlEp4c2
         nlN0MOSzr1iE+MduRUe5lbw2bijz43mTtT5wzHcD+LAsMi1oIzYn9U6pqKEXwVMB9U
         A+q9ipsWk/O/0X78BVNIiv/UdK7aQCw3ly4ZPj66yE+GHhyurB04rzPC3OzgQRYZvu
         a9eH7duN3zthM9eKxAg8e09zilYPDYDhi0JSoLmnZDyY4MMtqF3O0MdxPmamTAR0+v
         0pLHz30dgH1Bw==
Received: by pali.im (Postfix)
        id B461C3ABB; Sat,  8 Apr 2023 16:02:27 +0200 (CEST)
From:   =?UTF-8?q?Pali=20Roh=C3=A1r?= <pali@kernel.org>
To:     Michael Ellerman <mpe@ellerman.id.au>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Nicholas Piggin <npiggin@gmail.com>
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH v5 13/13] powerpc: dts: turris1x.dts: Remove "fsl,P2020RDB-PC" compatible string
Date:   Sat,  8 Apr 2023 16:01:22 +0200
Message-Id: <20230408140122.25293-14-pali@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20230408140122.25293-1-pali@kernel.org>
References: <20230408140122.25293-1-pali@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
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
Signed-off-by: Christophe Leroy <christophe.leroy@csgroup.eu>
---
 arch/powerpc/boot/dts/turris1x.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/powerpc/boot/dts/turris1x.dts b/arch/powerpc/boot/dts/turris1x.dts
index c9b619f6ed5c..6612160c19d5 100644
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

