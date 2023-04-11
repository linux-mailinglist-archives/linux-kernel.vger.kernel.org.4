Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD8506DD90F
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:12:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229955AbjDKLM5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229754AbjDKLMq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:12:46 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1C17421F;
        Tue, 11 Apr 2023 04:12:45 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 35F525C0071;
        Tue, 11 Apr 2023 07:12:45 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 11 Apr 2023 07:12:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1681211565; x=
        1681297965; bh=GICeuC5Na6dEOkT9RFxmFTSwUiB6wXXr5dWatVKt1SI=; b=p
        kcPqLOTDXDiX/CMkh31n1tqROjNO2IlD7uclASqF30oAVVIYvPZA/YEuphtzk+yJ
        rJSKO459pNf0JipcEe6gQJCKtFG/dTuSfCe1ss/hZoWSP3LetsDZ9E1w43kxDUrk
        ewgz9T/bpYBsK7Is29NJ1v8am8Ybv3LcLAZOOWCkadb+1B/oslKcmKcy+LtJg9eI
        h2iC53zc/RitRIhCg6Lkb7UgcnwDCMG8pO+kNMOtJ3I4NEW01oNf4h70T17E+9OP
        kh/24pt7AfKw3JHUWQIcCxfHXII3+HE4ib7dRXSHN94yf7BLVq8zUjLOaHZg1QHR
        aKuzvlHbQiIo/NIRKynrw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1681211565; x=
        1681297965; bh=GICeuC5Na6dEOkT9RFxmFTSwUiB6wXXr5dWatVKt1SI=; b=M
        +Knq3AoE1AfC0IokuH8rIhjOXIH6cUnlpwz8NM87QNJ8Ldybx0IVGWJKJx3WKg8q
        lI2aEZpZE/0z+b3DMFMYjYv8wg5zlceHktIToLp1ucci2/JHR9e5uwpKh733DKhv
        XQCSEXKmlepWtBVvAsvrOQPgVTDE1DcWjHWqHNU9jQQPeuPhcmfaQbYSIHVWdV9e
        V6LT9AggOdTZLaKog+v4lTZlp1a9ULg4uioN9HgMveiqOqVwiPpaeTpx1CPrFeJd
        UaRPQxr6mZBYmr7uT4IxKiepwTcw2m0FNblTxaShidtY3kNIUIgDztruzjUIyFZE
        wd/urtpsJk3ZETtpruG6Q==
X-ME-Sender: <xms:rUA1ZPEnQ5kBXTgz01HXAtPbg0fHqwkkeMab6psUeZ3UCYpVtR2ZKw>
    <xme:rUA1ZMWjnK81BbL51SLnyJdaXmfW8PaUtbshRUBqqVFYpH3pGtBq0lUe_Zfaxts3c
    AMGi7nf0oMVq23EA2g>
X-ME-Received: <xmr:rUA1ZBIR0UfjlnnVMOER_k5hvBbCXCUJc2gg5bmXPLAFROl3y5FNFjp3DePg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:rUA1ZNHc1QbtTIJm-hwdI1wuoFfsfWgVa5hMaii-8FM8qD6EQP1W9Q>
    <xmx:rUA1ZFWPYhhC60GkTNZarw4ao5sXLVzq-zU6o4ANb0q2n6Eq4V3fMA>
    <xmx:rUA1ZIMBAEgsuay-54F5msQ0GkpRvP9M_yh_ITzhr3jgxIfk9VdzNg>
    <xmx:rUA1ZIT0h8POjCzfJuRkynwVvr1c5BPYkPKmJETyuufP9Emk_K_jjg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Apr 2023 07:12:44 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        and@gmx.com, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 5/8] MIPS: mipsregs: Parse fp and sp register by name in parse_r
Date:   Tue, 11 Apr 2023 12:12:22 +0100
Message-Id: <20230411111225.55725-6-jiaxun.yang@flygoat.com>
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

parse_r helper is used to parse register number from oprand,
it only handles oprand which use number to refer register before.

However compiler may use $gp and $sp to reference register 29 and
30. Handle this situation by adding relevant match name.

Fixes compilation error:
{standard input}: Assembler messages:
{standard input}:1937: Error: Unable to parse register name $fp

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/mipsregs.h | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/arch/mips/include/asm/mipsregs.h b/arch/mips/include/asm/mipsregs.h
index 9d928b952abf..7d2c1c90fa10 100644
--- a/arch/mips/include/asm/mipsregs.h
+++ b/arch/mips/include/asm/mipsregs.h
@@ -1277,11 +1277,13 @@ static inline int mm_insn_16bit(u16 insn)
  */
 
 /* Match an individual register number and assign to \var */
-#define _IFC_REG(n)				\
-	".ifc	\\r, $" #n "\n\t"		\
+#define _IFC_REG_NAME(name, n)			\
+	".ifc	\\r, $" #name "\n\t"		\
 	"\\var	= " #n "\n\t"			\
 	".endif\n\t"
 
+#define _IFC_REG(n)	_IFC_REG_NAME(n, n)
+
 #define _ASM_SET_PARSE_R						\
 	".macro	parse_r var r\n\t"					\
 	"\\var	= -1\n\t"						\
@@ -1293,6 +1295,7 @@ static inline int mm_insn_16bit(u16 insn)
 	_IFC_REG(20) _IFC_REG(21) _IFC_REG(22) _IFC_REG(23)		\
 	_IFC_REG(24) _IFC_REG(25) _IFC_REG(26) _IFC_REG(27)		\
 	_IFC_REG(28) _IFC_REG(29) _IFC_REG(30) _IFC_REG(31)		\
+	_IFC_REG_NAME(sp, 29) _IFC_REG_NAME(fp, 30)			\
 	".iflt	\\var\n\t"						\
 	".error	\"Unable to parse register name \\r\"\n\t"		\
 	".endif\n\t"							\
-- 
2.39.2 (Apple Git-143)

