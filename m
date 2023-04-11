Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DDF6DD90E
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:12:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229924AbjDKLMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:12:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbjDKLMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:12:45 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 924EF3AAB;
        Tue, 11 Apr 2023 04:12:44 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 08E1E5C00DD;
        Tue, 11 Apr 2023 07:12:44 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute1.internal (MEProxy); Tue, 11 Apr 2023 07:12:44 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1681211564; x=
        1681297964; bh=GnOjAlW4cFLZB5e9fEbCpcj/9ZFTx5uDLBq5V/Tp2os=; b=Q
        OSGlwexUjNVIregAIWh1tGyM1SWlrvF0nbRTagbV3kW2dBwcHNYWXnM6uvkljuAP
        wjHJty+rSaTyQUuWkRC3ZE6zaMG9qQqlRSVEZxsDc8w/0dL7RdDrB0U0LzR61vX5
        4dvsPUAmJ14nUTDxGGeXlKtebNSFEI6+8CsKVTx4cDg3sOG5S48c6knKV5+xygiI
        Qv8A+VgWAq+0W2OoR4xfXM6pJBKF67COO/d5wP6uOgPydrnpoKhtDnv1hQQJxJ5f
        UnvFdVX/DaLF8zrNEQKaXQo1JfgkIV9GVH6XiaIVQMK6T4PL1oNHPK6b/voZUe3l
        lfTnkspB0/KDtI8tH/Flw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1681211564; x=
        1681297964; bh=GnOjAlW4cFLZB5e9fEbCpcj/9ZFTx5uDLBq5V/Tp2os=; b=F
        hxuDEfjA1+wYY8Io5RSw5kmxLpSxQVJ+Y1PCe82gq/D+dnUZavBZnwqyvlCF7t48
        YjPh73nIJRTW1vznQ+Luq68+eVZpP09HrmkwG1HCzepfBJnxBh8197YVO6zO1L57
        fAZTpSu1Y9K1oRqq2hYL1OMeClESS1nZKrTfHQaDnP66+YGE/04l5QfTMn6oDZ8k
        xBVdsSDbimH/VyCrU7qcy/Svizidfkgi9zjET6pDUBWK7Vrx/O4Ml4OhyELqltQJ
        SB/UAbiTsEid8fhI0x5BklvWDDjSrANjGUhUUsk2jyQ3xf0a1gMc4Js+vBVgfeRY
        79uCzRJfp7x1jp2vxEAvA==
X-ME-Sender: <xms:q0A1ZIeQ6GZnGgB5buT_wxPGFBTGvYlDXCb299G6QxgGJya_rvOC3w>
    <xme:q0A1ZKPvSFnZ5OSCSh3YqR5Cbn6MWzbuQ-bU2OPaYDrcSsge-ZmF1_awlA3T0nTj6
    4REB2YHOSODwkGt_Wg>
X-ME-Received: <xmr:q0A1ZJjS_sY7Fo9P3VVQsOcgxRbEkm-UJpmdwbjMbdXPUPyTOGk6SU9J_tZu>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:q0A1ZN-mt-SBbczLnEi7M-LUJFEpd--TkLyVUj139kUrMvSQXUsnqw>
    <xmx:q0A1ZEsr9tWBa--390qEX67wsPuql0M_0bd-kvijqDV_fyNHV30Y2w>
    <xmx:q0A1ZEFtwLigtNaZklahRxZNNE7xiAN6nLHGdmSsA6RCYpU-C1wpVg>
    <xmx:rEA1ZALatmOmVLOXmx058B48LSDuUuCWF84j5Dn_SWW0XJMd931_oQ>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Apr 2023 07:12:42 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        and@gmx.com, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 4/8] MIPS: asmmacro: Restore fp macro after undef
Date:   Tue, 11 Apr 2023 12:12:21 +0100
Message-Id: <20230411111225.55725-5-jiaxun.yang@flygoat.com>
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

fp macro is used by several place to reference frame pointer.
Restore macro at end of file with {push,pop}_macro pragma to
avoid break other assembly files.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/asmmacro.h | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/arch/mips/include/asm/asmmacro.h b/arch/mips/include/asm/asmmacro.h
index 2491a6c68390..de9688911cae 100644
--- a/arch/mips/include/asm/asmmacro.h
+++ b/arch/mips/include/asm/asmmacro.h
@@ -20,6 +20,7 @@
 #endif
 
 /* preprocessor replaces the fp in ".set fp=64" with $30 otherwise */
+#pragma push_macro("fp")
 #undef fp
 
 /*
@@ -655,4 +656,6 @@
 	.set	pop
 	.endm
 
+#pragma pop_macro("fp")
+
 #endif /* _ASM_ASMMACRO_H */
-- 
2.39.2 (Apple Git-143)

