Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5AC4A6DD90D
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Apr 2023 13:12:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjDKLMu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Apr 2023 07:12:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229643AbjDKLMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Apr 2023 07:12:44 -0400
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8C5E5F;
        Tue, 11 Apr 2023 04:12:43 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id CB4705C00CD;
        Tue, 11 Apr 2023 07:12:42 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 11 Apr 2023 07:12:42 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=flygoat.com; h=
        cc:cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1681211562; x=
        1681297962; bh=V7r1LKhTijisrmsj/fVHeC7m0VCsTE7Lg6Deu9KVD90=; b=A
        uiQZVStLm6fSHjLPnwRV4rZYFFwcxcaZASVqGJfUVu42YIQ1feaE9f/26Xb73oY/
        bDDy0VFy31P4O3lay9M5x+LXr0bioM+Jk6snrs7yKcn9z/Y633q3+YWwic8+gXUM
        GLnmcdbkB/bvfu6K8BflFcE5M+vTV+5I3vvIFttW61xaD3SEJ26hv+aVP5kWDM7e
        tnUC7Wb1PRAk02pAYAyZktVU/SyRJs/HUglRbad7kcYJAGkgy7ZeLkizMRphL4BA
        B8QkBDHEuqNxDJOhJKXr+ZuU3vnpN6gsaJobvfyTHv6/ENCGjg5rFzfSRzFGfjwE
        OblIkZtj+7S93hRbn6ecQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1681211562; x=
        1681297962; bh=V7r1LKhTijisrmsj/fVHeC7m0VCsTE7Lg6Deu9KVD90=; b=h
        XSzgnZ9DTlpnm9sY+s74+pxLx0A/Cv1Hzx5U9l9TnQqsgq9LmNUO5T3QrjptekMk
        S0IUfPODZtLE40BLPwnst7p9gVY5MY8y8bA7ErVf2wG80woC42QhmRcHZoWli3mT
        Ezybp/j8teGu/UHkDYoFd2ul7UHdZtq3IrQsxdkedE/T+JCoDws6YKzNGjqtSds6
        NAD0083g2fFv0IWgbSDllcLj6KIqEW0+8/8XlDEmm9YBGHE7FHAm5pod0RVzXhhp
        l+5smYnyOqjvnle2z+YvOTfk1yU5PeU8TAyCQl80vjA5Tp+Nj2woAxRxYVL+rzOa
        uywlxMp+T4mLiwYXwdWiQ==
X-ME-Sender: <xms:qkA1ZG59BpliEOUfrQ_2EblDgnT3J2B6NmZW7PBoOSokL_ZICPmkSg>
    <xme:qkA1ZP5X0kmPgqTG7SMd-Xg2VMEbE0H_n_5kc4fpjKj8XKYNqZuSPWNaiT3YJ8vMc
    vmT5AHKPpq7E7b8iNs>
X-ME-Received: <xmr:qkA1ZFcDJsPdSmQJGa5Vo15u9ao2GZSAAKKaD8fa7LLCsnCUsSjVlw7CJaXH>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekgedgfeejucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffojghfggfgsedtke
    ertdertddtnecuhfhrohhmpeflihgrgihunhcujggrnhhguceojhhirgiguhhnrdihrghn
    ghesfhhlhihgohgrthdrtghomheqnecuggftrfgrthhtvghrnhepfeeludefheegvdeuvd
    dvgeekgfdvtdettdelieeihfegtedugeekhfdvhfejfedtnecuvehluhhsthgvrhfuihii
    vgeptdenucfrrghrrghmpehmrghilhhfrhhomhepjhhirgiguhhnrdihrghnghesfhhlhi
    hgohgrthdrtghomh
X-ME-Proxy: <xmx:qkA1ZDICRwnY6Cf2hAeBtzy6K-JyfNS_v9lUS3nZQPNfMhmIJ8xa7Q>
    <xmx:qkA1ZKKfkF2OehUvQ_RQsVQkOdOkDBnAHwfzJveYXlqEHoDZRK6jyQ>
    <xmx:qkA1ZEwgPuzNUsVLtFJit6UjE-R012vH5kOXmxaoEh2nfgx7L1ZPfQ>
    <xmx:qkA1ZG3Dtc5NgHwGaZfZVK9Rf8FNHJsxMlPTGZIjsJVsmCERWQEeTw>
Feedback-ID: ifd894703:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 11 Apr 2023 07:12:41 -0400 (EDT)
From:   Jiaxun Yang <jiaxun.yang@flygoat.com>
To:     linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, tsbogend@alpha.franken.de,
        and@gmx.com, Jiaxun Yang <jiaxun.yang@flygoat.com>
Subject: [PATCH 3/8] MIPS: loongson2ef: Add missing break in cs5536_isa
Date:   Tue, 11 Apr 2023 12:12:20 +0100
Message-Id: <20230411111225.55725-4-jiaxun.yang@flygoat.com>
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

Fixes build error:

arch/mips/loongson2ef/common/cs5536/cs5536_isa.c:217:2: error:
unannotated fall-through between switch labels [-Werror,-Wimplicit-fallthrough]
        default:
        ^
arch/mips/loongson2ef/common/cs5536/cs5536_isa.c:217:2:
note: insert 'break;' to avoid fall-through
        default:
        ^
        break;

Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
---
 arch/mips/loongson2ef/common/cs5536/cs5536_isa.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/mips/loongson2ef/common/cs5536/cs5536_isa.c b/arch/mips/loongson2ef/common/cs5536/cs5536_isa.c
index 5ad38f86ee62..d60dd9992377 100644
--- a/arch/mips/loongson2ef/common/cs5536/cs5536_isa.c
+++ b/arch/mips/loongson2ef/common/cs5536/cs5536_isa.c
@@ -213,7 +213,7 @@ void pci_isa_write_reg(int reg, u32 value)
 			lo |= 0x00000063;
 			_wrmsr(SB_MSR_REG(SB_ERROR), hi, lo);
 		}
-
+		break;
 	default:
 		/* ALL OTHER PCI CONFIG SPACE HEADER IS NOT IMPLEMENTED. */
 		break;
-- 
2.39.2 (Apple Git-143)

