Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B6AEB626950
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 13:04:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234910AbiKLMEz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 07:04:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233962AbiKLMEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 07:04:53 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23F1A17895
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 04:04:53 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id B04E65C00D7;
        Sat, 12 Nov 2022 07:04:50 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 12 Nov 2022 07:04:50 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm1; t=1668254690; x=1668341090; bh=x9FizG+eL/
        8/EI7i81TIdmOdCun6VmkRyznqPByhDis=; b=XoJPG62A97EKGbYvKLrn2BxEfc
        /e1ug9nk80w5t0KyhMnUyameiIsYSIrwpdLZkuDnQaEZgBDP6njcMR5SYjIh8HzT
        BcgCvKrgsv82CpZh+1WY5xaAR6VJEljFPIXVnCaiFEpvEe3xrbGEz4uDYNjMXjSF
        oUtmb/p2IUsaNAoAYSDUsitHMYvKfKiglDrJ2wXW9mptibPaPZt+gRM6E3HM0J8E
        TviFyiKShLo6eJ08gm6X2GYXtQ6dFqf6JBv+6SDxU3Pa4RPkZ3x1c8WlWxgeXkLX
        hoNFE5Nb2WwVGzTiUK1z9TA9cOTaOZ5y/3LJiFTfMecCXfQGJVYiZfpTxoaA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=
        1668254690; x=1668341090; bh=x9FizG+eL/8/EI7i81TIdmOdCun6VmkRyzn
        qPByhDis=; b=C12n0toL5UY1BE0ooeeFIycg0oKY8VmiQyhHJ92+E+DZLWWKVB0
        YfMPX30G4blpX0nQPB+Nz589wFlVM0ybC4K6DKTUEwcAnX+HxreUQqqN1bMXOfSz
        nl2Mb+cAgQFno+ySIbrEHsKCRTomb+sMxUPvldwLYJghzgqq0cmcgr3T/Oo/CKW1
        D9pbYCMMOEm/ElFK0rBig/qUHg8iWEJ15qkfDNUGLWLjjozLZ9ep9aQBztCp5TBI
        Vj3H38w+1h2dKZdVcwMcCx8Cv8E/MraD93C8A+8yCQ1Ex9kIgP1hjP8PttTwGA+k
        ZlFOPjvOnMcLPyNAO1q2EQlUpA6JjgyifbA==
X-ME-Sender: <xms:4otvY9gKu-4vENtRwn7o_CAOfVd8jIq4avpGJKe23mejQFVmwPUaeg>
    <xme:4otvYyDKd0hHhCM4M3rcg2zV-y6vEmVdwmFu6nYzUwZc_zYKpvPISV2XfvTOd_B5r
    XcbIJO5jt7hv7iHfTM>
X-ME-Received: <xmr:4otvY9EneofXnxZIZ_zwwrP4Dmv-IQXItNgl3sA8ai0ajscsUUQvpFD48v5kKV6jKDTPh7lqMXUnLe-1sanW3g7xf8boP53EOBhmuxYc2zODNo6O9heF30SJN-SUGw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeekgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcurfgv
    thgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvghrnh
    epleduffeiheeuvedtffevtdeuleeljeduudfgtedtvefhfeffvdfghfejhefgleelnecu
    vehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvghnse
    hsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:4otvYyQmWKbdHrgADoqe78cHBA1kRVCrqGBL9_j25BRdQAzucwNfSQ>
    <xmx:4otvY6xZQKMA-MPPkTbxO3_3bBP24G75EOkI4xXWgWU-nlpVc2sbXQ>
    <xmx:4otvY45Sbaa0hiTu-DWsUi1RpLFKfyctEMnRDjX_YF4YQP1rXdhJpg>
    <xmx:4otvY_pRmCtoMbiACaklPnFbJ0_gjZYxB3MvGQ3APTBrZ80nCt2bnA>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Nov 2022 07:04:49 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Sven Peter <sven@svenpeter.dev>, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] nvmem: Handle reading cells with bit offset > 8
Date:   Sat, 12 Nov 2022 13:04:46 +0100
Message-Id: <20221112120447.36877-1-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
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

Some nvmem controllers like Apple's eFuses or Nintendo's OTP have a cell
size that's larger than one byte. Consumers may however still need
access to a subset of bits that start after the first byte. Handle this
inside nvmem_shift_read_buffer_in_place().

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/nvmem/core.c | 14 +++++++++++---
 1 file changed, 11 insertions(+), 3 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index 321d7d63e068..a5b8d6989f8e 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -1379,15 +1379,23 @@ EXPORT_SYMBOL_GPL(nvmem_cell_put);
 static void nvmem_shift_read_buffer_in_place(struct nvmem_cell_entry *cell, void *buf)
 {
 	u8 *p, *b;
-	int i, extra, bit_offset = cell->bit_offset;
+	int i, padding, extra, bit_offset = cell->bit_offset;
+	int bytes = cell->bytes;
 
 	p = b = buf;
 	if (bit_offset) {
+		padding = bit_offset/8;
+		if (padding) {
+			memmove(buf, buf + padding, bytes - padding);
+			bit_offset -= BITS_PER_BYTE * padding;
+			bytes -= padding;
+		}
+
 		/* First shift */
 		*b++ >>= bit_offset;
 
 		/* setup rest of the bytes if any */
-		for (i = 1; i < cell->bytes; i++) {
+		for (i = 1; i < bytes; i++) {
 			/* Get bits from next byte and shift them towards msb */
 			*p |= *b << (BITS_PER_BYTE - bit_offset);
 
@@ -1400,7 +1408,7 @@ static void nvmem_shift_read_buffer_in_place(struct nvmem_cell_entry *cell, void
 	}
 
 	/* result fits in less bytes */
-	extra = cell->bytes - DIV_ROUND_UP(cell->nbits, BITS_PER_BYTE);
+	extra = bytes - DIV_ROUND_UP(cell->nbits, BITS_PER_BYTE);
 	while (--extra >= 0)
 		*p-- = 0;
 
-- 
2.25.1

