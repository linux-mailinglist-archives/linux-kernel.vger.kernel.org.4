Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D9876DD912
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:13:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230008AbjDKLND (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:13:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjDKLMt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:12:49 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26A174226;
        Tue, 11 Apr 2023 04:12:48 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 8830F5C017E;
        Tue, 11 Apr 2023 07:12:47 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 11 Apr 2023 07:12:47 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1681211567; x=
        1681297967; bh=JmQWrIyQdY491hqVROXAubhi7zhzH9g73KTJjIcXyOI=; b=s
        AoMKkqAe//yQCuwfbzPptQV/lpkJkj0Wm4+aIM7e7mlnrWeo+akE5FEqgNV3Hm1X
        2qJi1egqaxr1ua6Wqkj3j9i6wAy9Q62YpOTABYndub7tQZy8uxRtIOM0x3JYlVhU
        5JOGVeqDezpcMlHbQYJoatGYZeomdTTukJG17nim85+iKFHyONBW5/u96GtaV1FK
        2bzJjUgjAUIf0IhsByUsh9wGLWZb92wHVzC3ifiwgb8QHchUEoHCNsLQu6zrf3Dc
        f/B3THneSgFnmKMgEs8SQUdJpyXrrZQx0FZDTiMKeidQV1uUosBMqoylVMG/Wyq8
        Qqw+TmSZF43FT3jsgRozg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1681211567; x=
        1681297967; bh=JmQWrIyQdY491hqVROXAubhi7zhzH9g73KTJjIcXyOI=; b=V
        J2ZnqmQM5YFEch+x2eNTChXLtepE4VA3gzcY5Xj7J6nixsDyWICPhkt0PmrcbZaD
        LdlkYzPlRGlXRxpaxzX138GuZAxpB2tYYD+lhPxlkQQRzJ5rpm741Ep8g7F27Pb3
        uUgnFOlNcZgJfOv6G1BwvURKnntXpHaEGe7IKRB/qQGwZfyvUlwitzq9cnAl3H/k
        GS2/rP0s0+WuDlsQNvUOWozcc4jElGYEGWRWvHz7UFf6VseeGqWlq//pIX15vDfb
        SB3sKv4MmU8tOStYiBOQZe+fi5Q6zUN80Wa5irHZalH2Psbfbjtwpwgnm/Qb6Yl0
        dxBl8fVBJgIbfBQhh/PPw==
X-ME-Sender: <xms:r0A1ZDw24GfsiYdUTOtWYcLnigpqTCTToxlgc7bztuJHFAeBEBDGVQ>
    <xme:r0A1ZLQbd_r7kFr-UVlqgXXeZYtHYC7ap3i0aIrXn4CZ51JUsyedvuK_q2P6p5bEX
    OFCiZPZslLKH91j0xE>
X-ME-Received: <xmr:r0A1ZNXb6kCQcXZjxdNodbaqZXpQNnK-6ii0Y44GvEPp93_VgptG1z2uS0Am>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepvdfffeehleekgeegff
    ejgeeijeekveeghfetudegkeegueefhfduudduhfeijeelnecuffhomhgrihhnpehsfihi
    thgthhdrshgsnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepjhhirgiguhhnrdihrghnghesfhhlhihgohgrthdrtghomh
X-ME-Proxy: <xmx:r0A1ZNhjwEjCvAJWrGEIQrnAZsbDYd6PMdrpDYoddXFG9G3S8z7VPw>
    <xmx:r0A1ZFBXAmvwPpEqpUzRrFMy-lsYFd2IZYl4pjid-wEAyHyrFJYO6g>
    <xmx:r0A1ZGKpFwnJADft_Y6i9jmOPpr9OrfxAD8ZT7b9bSgr-46lyB4naA>
    <xmx:r0A1ZEMZEx3MNKQjoDao-RHerkP9VQ4JqnB5C98HaNeANh6u-hE30w>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Apr 2023 07:12:46 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        and@gmx.com, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 7/8] MIPS: octeon_switch: Remove duplicated labels
Date:   Tue, 11 Apr 2023 12:12:24 +0100
Message-Id: <20230411111225.55725-8-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
In-Reply-To: <20230411111225.55725-1-jiaxun.yang@flygoat.com>
References: <20230411111225.55725-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EXPORT macro already have labels defined by itself.
Remove duplicated labels outside to silent assembler warnings.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/kernel/octeon_switch.S | 6 ------
 1 file changed, 6 deletions(-)

diff --git a/arch/mips/kernel/octeon_switch.S b/arch/mips/kernel/octeon_switch.S
index 896080b445c2..9b7c8ab6f08c 100644
--- a/arch/mips/kernel/octeon_switch.S
+++ b/arch/mips/kernel/octeon_switch.S
@@ -428,7 +428,6 @@ done_restore:
 	jr	ra
 	 nop
 	.space 30 * 4, 0
-octeon_mult_save_end:
 	EXPORT(octeon_mult_save_end)
 	END(octeon_mult_save)
 
@@ -448,7 +447,6 @@ octeon_mult_save_end:
 	sd	k0, PT_MPL+8(sp)      /* PT_MPL+8  has MPL1 */
 	jr	ra
 	 sd	k1, PT_MPL+16(sp)     /* PT_MPL+16 has MPL2 */
-octeon_mult_save2_end:
 	EXPORT(octeon_mult_save2_end)
 	END(octeon_mult_save2)
 
@@ -480,7 +478,6 @@ octeon_mult_save2_end:
 	sd	$10, PT_MPL+(4*8)(sp)	/* store MPL4 */
 	jr	ra
 	 sd	$11, PT_MPL+(5*8)(sp)	/* store MPL5 */
-octeon_mult_save3_end:
 	EXPORT(octeon_mult_save3_end)
 	END(octeon_mult_save3)
 	.set pop
@@ -498,7 +495,6 @@ octeon_mult_save3_end:
 	jr	ra
 	 nop
 	.space 30 * 4, 0
-octeon_mult_restore_end:
 	EXPORT(octeon_mult_restore_end)
 	END(octeon_mult_restore)
 
@@ -517,7 +513,6 @@ octeon_mult_restore_end:
 	mtp1	v0			/* P1 */
 	jr	ra
 	 mtp0	v1			/* P0 */
-octeon_mult_restore2_end:
 	EXPORT(octeon_mult_restore2_end)
 	END(octeon_mult_restore2)
 
@@ -548,7 +543,6 @@ octeon_mult_restore2_end:
 	.word	0x714b000b
 	/* mtp2	$10, $11		   restore P2 and P5 */
 
-octeon_mult_restore3_end:
 	EXPORT(octeon_mult_restore3_end)
 	END(octeon_mult_restore3)
 	.set pop
-- 
2.39.2 (Apple Git-143)

