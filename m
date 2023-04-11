Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB8216DD908
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:12:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjDKLMp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:12:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229608AbjDKLMn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:12:43 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2EB6DBA;
        Tue, 11 Apr 2023 04:12:42 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 9A6DF5C012C;
        Tue, 11 Apr 2023 07:12:41 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute6.internal (MEProxy); Tue, 11 Apr 2023 07:12:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1681211561; x=
        1681297961; bh=oJIJyJ+bdZ/ciPnkRGoLTZBvw3GeSSYm0yUguon+n48=; b=r
        P8N37sp3ONYDrApZTo/1vdfzz1VF7mm5C9DoQ9//NvsgEHH4LrRHApkRdtvfOJSl
        hMvMmM+Xlijtwa1uba6DbCaM/bew6c4LiKPVO7/rdijTZUa0t99rznlq3MmF/WVA
        lUOBoNr8By/DoBjYbpn5SGNUFBkQaLAf7c7d23xJiUBuqiSg/Iw4tuNY9EU3u5By
        fjLyhi2B7821acDLKIMrgRuEieN8lgZh0kw3L37txY0dW4+dNkxfsopPoW+qhy0K
        AmSBxDf1R2T4WrSy8QqMIwBYJp9eVsLkuGEdkRx5YY727YCOIkYrEOdFQ3crrclM
        5nLJn7g/FxJOPNGK6EyFw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1681211561; x=
        1681297961; bh=oJIJyJ+bdZ/ciPnkRGoLTZBvw3GeSSYm0yUguon+n48=; b=N
        wS/I9QqISbjgHQot2XCb2Z2fxg/3HEYh8KmQxzRCAeE/WQmePD9kkl2p7f5twAS5
        grzBx2CXxkQLSg7slnVCkoqFoujpEMsk3Iw5jsBhqya0IM0iRPpYgvkv+A/Hoc9T
        I+2O/RjENjwS7veElxutuPkHBkjH/aJnugaqBgLGCBeWsHOXqavLLNouHRhkYPDS
        QqPT8dW5UHgaDeDdEQ+JnmJNApd86LAy5BVWWIZwKGXe+kPBxpW8emJKse+MkfC2
        34PvYJLySQYYR5d6ihhLgp8uohP8TZxJAxrpB7YQxzYg7BkUjXMBIX9SOrkTZRy8
        C3gqY1Jj/9s6AHP6IWq/Q==
X-ME-Sender: <xms:qUA1ZJ9zfnilhKKnZr922GnYiUl17kNgcrjGyQBXu0nvIqHAygwS1A>
    <xme:qUA1ZNswQqoembbqTTOucZS5Al5Q8_XcVtPOFRMNarsBFjeEWNSnAbaBBKyMGR4cM
    FLmK2exCMlB0Mg2o00>
X-ME-Received: <xmr:qUA1ZHDnV-Eubck94sJVZuyByPhDTBUPpi9XlF8LBY3kjl5dBNM7hPmcUxhm>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:qUA1ZNeWf6yNHvhf1ERut30z1ZvxrIarnvUn9vc771k2V-1zINa54Q>
    <xmx:qUA1ZOMnUNAAHh2eE1qE1FgOKmsuFCy4mH4k1rdc8pHs589LZXAJrg>
    <xmx:qUA1ZPmJIdaZZV4Li1nyLna1-BALStSRvlZHaYBrjAQsLSzYbHnWHg>
    <xmx:qUA1ZLrVqex4I8MRXyzUF45zmwtAObiYlRJ60xKNNimOCw-lkD1Xxg>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Apr 2023 07:12:40 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        and@gmx.com, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 2/8] MIPS: Set ISA level for MSA control reg helpers
Date:   Tue, 11 Apr 2023 12:12:19 +0100
Message-Id: <20230411111225.55725-3-jiaxun.yang@flygoat.com>
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

MSA instructions requires at least Release 2 to be available.
Setting ISA level here to make GAS happy when building kernel
for earlier CPUs.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/include/asm/msa.h | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/mips/include/asm/msa.h b/arch/mips/include/asm/msa.h
index a9ca57e3f780..e13e538a7889 100644
--- a/arch/mips/include/asm/msa.h
+++ b/arch/mips/include/asm/msa.h
@@ -175,10 +175,12 @@ static inline void init_msa_upper(void)
 #define _ASM_UNSET_CTCMSA ".purgem ctcmsa\n\t"
 #else /* CONFIG_AS_HAS_MSA */
 #define _ASM_SET_CFCMSA						\
+		".set\t"MIPS_ISA_LEVEL"\n\t"			\
 		".set\tfp=64\n\t"				\
 		".set\tmsa\n\t"
 #define _ASM_UNSET_CFCMSA
 #define _ASM_SET_CTCMSA						\
+		".set\t"MIPS_ISA_LEVEL"\n\t"			\
 		".set\tfp=64\n\t"				\
 		".set\tmsa\n\t"
 #define _ASM_UNSET_CTCMSA
-- 
2.39.2 (Apple Git-143)

