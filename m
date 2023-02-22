Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D45369F539
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 14:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231869AbjBVNYn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Feb 2023 08:24:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231689AbjBVNYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Feb 2023 08:24:39 -0500
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45E3F2FCE9;
        Wed, 22 Feb 2023 05:24:38 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id B47D45C011B;
        Wed, 22 Feb 2023 08:24:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 22 Feb 2023 08:24:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1677072277; x=1677158677; bh=EP
        SSc8zmdPgI05TJa3CUPRSOx9d1h71CZw1l3kq4OlU=; b=hgDPnHyaWtUSE6sxDt
        xymQ9ErJ1eijmW28BrMxDDjmTXuJH2ekWMiAMlL4luAtwFrhiwbNE6Zgxkqgz5Xn
        IgfUUuPXh6/CZVe2NyNZ9FbyJRaWiKeAqETJtOF2mEyWcb2TCHMOz5kwKBKv1bjk
        4f/a9hV1MNM31Zk6Z4GtUEDTbhaUBu16TDP346fcLERld52lSDUcHLkG/kZoQ+AN
        nXgSQMTFqROStx4NFztlWHuuKJQTFZQF4dVuYvLK6jZ2vykhYULH/7ZoJHzRTOEK
        BhiIV9vf3aH9YDK/sY9ptH25+eLDIyrXFDhqugiDZgFCa+yS+foJ6vE5Uknb9zcy
        rtAw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1677072277; x=1677158677; bh=EPSSc8zmdPgI0
        5TJa3CUPRSOx9d1h71CZw1l3kq4OlU=; b=pnO03XCQw9tLQOxImyoJIpW1OulUD
        evwXHGkX/68qg93M9FLe9ueBGB7GWNv2GvL7QR6axfNbsFyZuYCmYqAOeF48xmdn
        wwjNBS5QjchW7P91L5AQslWkDQZF83CcPhbnuq/gr0ms9t5XFY30LjTAN2Jq3FL/
        M0dqVYAmNs3bJMFD4MPlAIBHAtlIRXWAPnIFW3yvlxQ7RbmpR9mq9z/3/zi+diQQ
        lv7Bl+vXyuEDEVXtSjgiOTZDo2X3UWsPE9fIOh39ndlXCE2Ftjdn6OQ3l7vU8y9f
        HK3qRlbYjwsehMYfRd6IgUqtalUaEV14jud7J06N06mQLJHGzOAP7gPMw==
X-ME-Sender: <xms:lRf2Y2pVq3Mu8W-AreGEFWzrIIrpC7PJ32nrlX2CAIqdXRYIXbbeaQ>
    <xme:lRf2Y0q2XiCGiS7fw-NF--SfjpmnElHljpJxkQSPMSUfxcKjh2NtAmBSRG7AuAQ9J
    4t38HSIOgkyQCELc1k>
X-ME-Received: <xmr:lRf2Y7Nxsg8Z08uzqZS5IqyT41OdsIkWqKI-8nj89_wCOS1CBWGAtYGQZ43P>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudejledghedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:lRf2Y16nCFEyxdZFeY_orV_X_ktqHL8uQtV1XWnSaXKDtlwREaJWag>
    <xmx:lRf2Y157-VE7f415HizSLF9AnAzvx5OD2TfNeAcpLFmi0Kf6gWTCnA>
    <xmx:lRf2Y1iXnsvGA0KfXmFGxwBocPIBrkOdhUVjFzy4dzNdi-5R6rMkEA>
    <xmx:lRf2Y_mP0Syf5A5-VBtetzmKwgmHS3Jk6vLFOU4DSZFvBpOUSfn0Ag>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 22 Feb 2023 08:24:36 -0500 (EST)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        hch@lst.de, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH v2 1/4] MIPS: Remove DMA_PERDEV_COHERENT
Date:   Wed, 22 Feb 2023 13:24:22 +0000
Message-Id: <20230222132425.7442-2-jiaxun.yang@flygoat.com>
X-Mailer: git-send-email 2.37.1 (Apple Git-137.1)
In-Reply-To: <20230222132425.7442-1-jiaxun.yang@flygoat.com>
References: <20230222132425.7442-1-jiaxun.yang@flygoat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

As now we are always managing DMA coherence on per dev bias,
there is no need to have such option. And it's not selected
by any platform.

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
v2: Remove unrelated change.
---
 arch/mips/Kconfig | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/arch/mips/Kconfig b/arch/mips/Kconfig
index 37072e15b263..a1170f0a0c04 100644
--- a/arch/mips/Kconfig
+++ b/arch/mips/Kconfig
@@ -1080,11 +1080,6 @@ config FW_CFE
 config ARCH_SUPPORTS_UPROBES
 	bool
 
-config DMA_PERDEV_COHERENT
-	bool
-	select ARCH_HAS_SETUP_DMA_OPS
-	select DMA_NONCOHERENT
-
 config DMA_NONCOHERENT
 	bool
 	#
-- 
2.37.1 (Apple Git-137.1)

