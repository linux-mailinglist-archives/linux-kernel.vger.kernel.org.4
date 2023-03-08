Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 765BE6B0C87
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 16:23:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbjCHPXJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 10:23:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231791AbjCHPWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 10:22:42 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E6F90968CB
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 07:22:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6577961874
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 15:22:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA822C433EF;
        Wed,  8 Mar 2023 15:22:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1678288960;
        bh=4n+J3F3WIeDHl/t1ZjHsybvVlO41tTFlmubE3CbJrKI=;
        h=From:Date:Subject:To:Cc:From;
        b=QoEN2MAePI3fnWetSRVyE1MLHPvnPbaFyCAV3w+eGomFdNOM4puJuzEgoC9R3JNwt
         gKZJ+3wPusCR/a02fF+5c5GV57/kQ5NxYPTQpDysCoaHFDy3ru7ANZP0m26nrJzola
         xrxvJy/JkLm5bg1cOz9MK7RDlgA9wrJIVoI1etedDCdtqPxvoo7BnEZFFqdO7viQuF
         DE1B+fWS0tz5TRHILXXpI5YdbIZnm7DvbO72Ph6EKV2zI5/VHoIKKH9mY7nt5IWrZo
         PFvPjMNPJ9qkN7+KOm7uE6QgU0Uw/a1+hlUngQr5PxLzn3PpGv0KkCLuMvJ7Uk6ImX
         z8vgvImYX4z+A==
From:   Mark Brown <broonie@kernel.org>
Date:   Wed, 08 Mar 2023 15:20:42 +0000
Subject: [PATCH] arm64/sysreg: Update ID_AA64PFR1_EL1 for DDI0601 2022-12
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230308-arm64-aa64pfr1-2022-12-v1-1-f03c1ea39611@kernel.org>
X-B4-Tracking: v=1; b=H4sIAMqnCGQC/x2NywqDQAwAf0VybmBfVdtfkR7iNmqQrpIFLYj/3
 rXHGRjmgMwqnOFZHaC8SZYlFbC3CuJEaWSUd2FwxnnjTYuknzogUR3WQS0W79A6ZBubYO5NbP0
 DStxTZuyVUpyufF90vvSqPMj3/+te5/kD0KWaN38AAAA=
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
X-Mailer: b4 0.13-dev-bd1bf
X-Developer-Signature: v=1; a=openpgp-sha256; l=1200; i=broonie@kernel.org;
 h=from:subject:message-id; bh=4n+J3F3WIeDHl/t1ZjHsybvVlO41tTFlmubE3CbJrKI=;
 b=owEBbQGS/pANAwAKASTWi3JdVIfQAcsmYgBkCKg+1ANRY1G6HvkGky4WZUsgUPTFqSgeBUolly4a
 sgHBPdeJATMEAAEKAB0WIQSt5miqZ1cYtZ/in+ok1otyXVSH0AUCZAioPgAKCRAk1otyXVSH0JLoB/
 9nQbSfNruVLlpSLgV6Di8x+Xe9f6Jk256YjnJsK62kFNH6E2q6nhrI6lq3Su0u7bHx2xDN1jrFuyMN
 t422LMbqVhyWCf+LwSaTjQ9OLqzFa1B0Q3AIK5u8BwpNVTS0U2mn1kxC8LEPx5uzb38ADWPtlqFP9j
 jWGbGvD2HnCFzJaSstzOWIjPmPzb+s+JBDpjVO5G4aqqjaEG7CTIHgeCzY7kDy9rArgDVX7v0u/F/Q
 8u5iwWxCKh108PWZTfEi3u6Arz2rrblwITlOJsDPRP2j5pOCKK7zU4+cAXKNLrRc32E0xBTCKeX9OG
 ccib0BmLnEWmWxCWKq4HP+rR0PULhu
X-Developer-Key: i=broonie@kernel.org; a=openpgp;
 fpr=3F2568AAC26998F9E813A1C5C3F436CA30F5D8EB
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Version 2022-12 of DDI0601 has defined a number of new fields in
previously RES0 space in ID_AA64PFR1_EL1, update our definition to
include them.

No functional changes.

Signed-off-by: Mark Brown <broonie@kernel.org>
---
 arch/arm64/tools/sysreg | 25 ++++++++++++++++++++++++-
 1 file changed, 24 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/tools/sysreg b/arch/arm64/tools/sysreg
index dd5a9c7e310f..e00b351efceb 100644
--- a/arch/arm64/tools/sysreg
+++ b/arch/arm64/tools/sysreg
@@ -879,7 +879,30 @@ EndEnum
 EndSysreg
 
 Sysreg	ID_AA64PFR1_EL1	3	0	0	4	1
-Res0	63:40
+UnsignedEnum	63:60	PFAR
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	59:56	DF2
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	55:52	MTEX
+	0b0000	MTE
+	0b0001	MTE4
+EndEnum
+UnsignedEnum	51:48	THE
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+UnsignedEnum	47:44	GCS
+	0b0000	NI
+	0b0001	IMP
+EndEnum
+Enum	43:40	MTE_frac
+	0b0000	ASYNC
+	0b1111	NI
+EndEnum
 UnsignedEnum	39:36	NMI
 	0b0000	NI
 	0b0001	IMP

---
base-commit: fe15c26ee26efa11741a7b632e9f23b01aca4cc6
change-id: 20230308-arm64-aa64pfr1-2022-12-e1c74057c839

Best regards,
-- 
Mark Brown <broonie@kernel.org>

