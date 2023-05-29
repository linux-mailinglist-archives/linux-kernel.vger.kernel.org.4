Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C058A714B17
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:54:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230106AbjE2NyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229951AbjE2Nx2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:53:28 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E33DE131;
        Mon, 29 May 2023 06:52:59 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id F3CD65C0126;
        Mon, 29 May 2023 09:52:54 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Mon, 29 May 2023 09:52:55 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to; s=fm2; t=1685368374; x=1685454774; bh=cWL+ydqAXL
        J30NEjXy53IDGA3PgBjHHLDwDyHIEE/5I=; b=oIuNInrOtpAOQzZLbD3v5AFSN9
        wutegbZ/U5SfeEbORvQQhtNW6bPWpN8Q52nfnapxf8uYDv7RKKUzLudF5HwmQhRW
        mxAROGGCvczWGmeHdYUp5mian4SsLWtzsTUJFa3uhZcK+YGQg2niUGgw3AnXQjwn
        RXcFSKWzXUjiv/H4LEbrXDUPVAQKM6GF+AfDVv+6jD7KT9C1EbT2s9wNdUGL8L4j
        z+V1ui+cEDs8n1Lx9ncJjLQhoprh+Tg0FyyVfyhYMRKu85wawezOC0TlIzGPr479
        uA7UR5mnm+esj0BRZNbVDiS+tPNTyMPn9Mz46FKNtnPtvYO25wbVj7dupRRg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685368374; x=1685454774; bh=cWL+ydqAXLJ30
        NEjXy53IDGA3PgBjHHLDwDyHIEE/5I=; b=HE8oGDLZwc2VA82joUBHhO3NCvfKV
        gY/KsLPzdO0DdYXB3N+6fRQVDIYXVJ5Jb+2b0ATKUJ6avPGZYq2fS9oFQZ+Kr8+G
        BtX8r2fH8Dbh6ARptyzO7OmRMy7uJ+kSAqYqxAH1OfLntJxVQIZS17lh1UD5PLlM
        RQnbKy683qe8E3DiEClzw/uvNrhcI6dzpsQcomrtccs9DPfkDcy66TOFffAlpQ0I
        uaJsYipIPlU/sTRkkZ2rulKSOu5E89C/4C3J3WzKGL+H1vb+q9y0IrEo0eGHIa3I
        6LbGz6qJHYsk1iUl/z9VSF6Xf9Py7buzUFmz29oSS93WOoVfO1gppBkxA==
X-ME-Sender: <xms:Nq50ZJGRe-CXv2pHQhkiJBqJWLrN3YZiqppu-LEWgLA4gGV8h0U0nw>
    <xme:Nq50ZOVcB9FjfHtDTNhbAC0T5A9K-kzxeYHjUfuIf3oGuVQnFTQWeneEqngt7zw-l
    WJ44Y7UDrFpG8nbHwc>
X-ME-Received: <xmr:Nq50ZLKjFM6F_UHK9fcPsRjz8Nd3Wc4TzPMhsK7Nxd-bCUboPMETxD4aNb5X>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekhedgieelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghnghes
    fhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhephfetuddtudevieeljeejte
    ffheeujeduhefgffejudfhueelleduffefgfffveeknecuvehluhhsthgvrhfuihiivgep
    tdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhihgoh
    grthdrtghomh
X-ME-Proxy: <xmx:Nq50ZPEK19IXHTefgzihs4Z-F0qg0GkRCZK-QlPp7qc4jmdrYW_71Q>
    <xmx:Nq50ZPXy00mzXGfID5k4ol6fmBVIwPJ5lJk8R4Euegd05O8orQh_mA>
    <xmx:Nq50ZKMsSczKDcgM-M-eBPQV6UwzAeO3xF9zPigkFOa2bvhYlI_oJw>
    <xmx:Nq50ZMiJbC16ZNqxwMXDDC_sEhLnGhmFy5IiV7KolwFKKEDHgedLmQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 29 May 2023 09:52:53 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 1/2] MIPS: Allow MIPS32R2 kernel to run on P5600 and M5150
Date:   Mon, 29 May 2023 14:52:44 +0100
Message-Id: <20230529135245.4085-1-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.39.2 (Apple Git-143)
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

M5150 and P5600 are two MIPS32R5 kernels, however as MIPS32R5 is
backward compatible with MIPS32R2 there is no reason to forbid
M5150 and P5600 on MIPS32R2 kernel.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/cpu-type.h | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/mips/include/asm/cpu-type.h b/arch/mips/include/asm/cpu-type.h
index a4a66bd93748..4032cd90ea30 100644
--- a/arch/mips/include/asm/cpu-type.h
+++ b/arch/mips/include/asm/cpu-type.h
@@ -54,7 +54,8 @@ static inline int __pure __get_cpu_type(const int cpu_type)
 	case CPU_PROAPTIV:
 #endif
 
-#ifdef CONFIG_SYS_HAS_CPU_MIPS32_R5
+#if defined(CONFIG_SYS_HAS_CPU_MIPS32_R2) || \
+    defined(CONFIG_SYS_HAS_CPU_MIPS32_R5)
 	case CPU_M5150:
 	case CPU_P5600:
 #endif
-- 
2.39.2 (Apple Git-143)

