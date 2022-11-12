Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E5124626951
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Nov 2022 13:05:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234915AbiKLME5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Nov 2022 07:04:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231534AbiKLMEx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Nov 2022 07:04:53 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FBF1789F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Nov 2022 04:04:53 -0800 (PST)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id ADEA55C00D9;
        Sat, 12 Nov 2022 07:04:51 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Sat, 12 Nov 2022 07:04:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=svenpeter.dev;
         h=cc:cc:content-transfer-encoding:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1668254691; x=
        1668341091; bh=igfPzLZ+nsYXDcd0iC5P+vvdO2NXmHjJ5YJY8H2HHmo=; b=L
        p0a244iTn5L+2cSWaU3yOB2iYxD9pCB2533PT/bkDh9zySFlEo8jjvwXAYRrJlVb
        cVgWam8V0IGDw3wtb9JXH4PoxKc+xaD/PRQOVMWAHiy48Tz5ks/r5C+I59WSa4JJ
        iMKsnY1o3Svjb14Z/tBLqcSYMm0DnuT07rV9p9sejlKHn7zoU6uWXRffYIPSbxNZ
        zhFqst9U5leIHuYj3ArewuJoUg26uyXwEiGIGXRPXfPl+6Wzp+y0PCoxJL09ZM+w
        dPUSdnzI/yH0Voc246ZqgMR34nrF938BRr56jlq18/k+cqzDanpEq9XxpvtAojdS
        X84WljKF7lgWxj8HDhZtg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1668254691; x=1668341091; bh=igfPzLZ+nsYXD
        cd0iC5P+vvdO2NXmHjJ5YJY8H2HHmo=; b=MlbwPAFYQvSPvUgBkBkrKrZD30aXG
        yqsg7s59OYRpOIMCVDXgwTP3OzDmBiJCyvKxe9+0CIBzIV1Jq6zCXMcj3wAKL35Q
        XSAj91FWdufIzDZgZuAKfueaH3dOE+uTQ+iRpOpj8lFPLh9F1E/DIGFYTGgX+3Nd
        EH+KilAD24iW0hJo+WMmU5auvRvrHPU1S/iTHJwmQnZmTRB0qV6E7r16Cf5vdhq/
        rnBk35GJy0QltZ/o7uY/377o1Vl6hqTiU3+x67G95nw8N4abJxE9XZUAjkBCJTiJ
        n1tGiffuCDLYTSDGqVwO3Bj2hxZvnSaq0aWSDAC/oRdRLI8kWJZnuEgdA==
X-ME-Sender: <xms:44tvY1jJL2d5CyI20aHBajM1uUCBQp1ej4vp1Aaodiod756vhvXqJA>
    <xme:44tvY6DmUxNIRpPe2u4ik2996rIIDFgMl1XPHnXqm-gfg9U7c2iJXyPEdHRb6kpLz
    AFQ-DZq3oViq0KZR8Q>
X-ME-Received: <xmr:44tvY1FKze4lTebpxl65tiGADvhQZmyJZ53kdEid5nBs0PXW2WXhjoEourgOpoFtpJBdYn7qzYs19rsr0gXETnm2SkKKt-MXi2lYK2hUP8074d4wKWY--dAFPcw0QQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrfeekgdefjecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpefuvhgvnhcu
    rfgvthgvrhcuoehsvhgvnhesshhvvghnphgvthgvrhdruggvvheqnecuggftrfgrthhtvg
    hrnhepjeeiheehkeegvdejhfevkeejgfdutdefhfethedtieffleekieeuudefleekjeeg
    necuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepshhvvg
    hnsehsvhgvnhhpvghtvghrrdguvghv
X-ME-Proxy: <xmx:44tvY6TWvCOIt4Ebk4tHmfVS-zAdqX69PpSOEME6SaIySfNkRnAkSw>
    <xmx:44tvYyyAsjNdFUEF4v31JqgOfWOjefQhZU-bQYqhLX1MoZ1qALpn7w>
    <xmx:44tvYw63njNDnIpcbEz6OSvFU5kM3k8jsL39TQnQ72a9fE03WBSddw>
    <xmx:44tvY3qSsuGoDEUxgpuStRzxNb8Q7guGQWm_wLl7HcNWmkbDpmDoSA>
Feedback-ID: i51094778:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 12 Nov 2022 07:04:50 -0500 (EST)
From:   Sven Peter <sven@svenpeter.dev>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Sven Peter <sven@svenpeter.dev>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] nvmem: Handle reading nbits from cells with word_size > 8 correctly
Date:   Sat, 12 Nov 2022 13:04:47 +0100
Message-Id: <20221112120447.36877-2-sven@svenpeter.dev>
X-Mailer: git-send-email 2.30.1 (Apple Git-130)
In-Reply-To: <20221112120447.36877-1-sven@svenpeter.dev>
References: <20221112120447.36877-1-sven@svenpeter.dev>
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
word size that's larger than one byte and cannot read anything smaller.
Round up cell->bytes correctly when accessing a subset of bits.

Signed-off-by: Sven Peter <sven@svenpeter.dev>
---
 drivers/nvmem/core.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
index a5b8d6989f8e..6906de15b9b8 100644
--- a/drivers/nvmem/core.c
+++ b/drivers/nvmem/core.c
@@ -470,8 +470,8 @@ static int nvmem_cell_info_to_nvmem_cell_entry_nodup(struct nvmem_device *nvmem,
 	cell->np = info->np;
 
 	if (cell->nbits)
-		cell->bytes = DIV_ROUND_UP(cell->nbits + cell->bit_offset,
-					   BITS_PER_BYTE);
+		cell->bytes = round_up(DIV_ROUND_UP(cell->nbits + cell->bit_offset,
+					   BITS_PER_BYTE), nvmem->word_size);
 
 	if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
 		dev_err(&nvmem->dev,
@@ -718,9 +718,9 @@ static int nvmem_add_cells_from_of(struct nvmem_device *nvmem)
 		}
 
 		if (cell->nbits)
-			cell->bytes = DIV_ROUND_UP(
+			cell->bytes = round_up(DIV_ROUND_UP(
 					cell->nbits + cell->bit_offset,
-					BITS_PER_BYTE);
+					BITS_PER_BYTE), nvmem->word_size);
 
 		if (!IS_ALIGNED(cell->offset, nvmem->stride)) {
 			dev_err(dev, "cell %s unaligned to nvmem stride %d\n",
-- 
2.25.1

