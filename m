Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 55CDA6590BE
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Dec 2022 20:09:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233877AbiL2TJQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Dec 2022 14:09:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233856AbiL2TJK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Dec 2022 14:09:10 -0500
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D4A714D21
        for <linux-kernel@vger.kernel.org>; Thu, 29 Dec 2022 11:09:09 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id C1BB83200906;
        Thu, 29 Dec 2022 14:09:08 -0500 (EST)
Received: from mailfrontend2 ([10.202.2.163])
  by compute4.internal (MEProxy); Thu, 29 Dec 2022 14:09:09 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm3; t=1672340948; x=1672427348; bh=0RQE8/nTaUDJx2rfTZDgn+HEP
        18KjlUXz+uMmj/1Xf4=; b=T9BbuC+HiYQ10P5oB/PBvffq/N3eXR365yLl+l3N+
        ZHq0/KRiGLN+DkPdoDeesmm3Lymqonl9kAMJifIk0Fo29+Tra4IEkIEikF1NYd/8
        shILVotAK3Z2fxqi/TLQx41MRxI1V3NqWz6ppAqoYxS0RmFnLxSnZRuyNGRQ3ReT
        yx7qfUXRibmL7FAbeoOdlFtFwCDepC8fnkB+WoQOqydRUvpTZDbmxzsd/74T4VGh
        1fOix0uaNDfcgZLFqGqEztNa66EHvhF3LvqGvmqk0JRURO+kTVYCsPAtf5Lo/Hez
        9JnPBTqGOkQ+oulVjQ0uRL/SkBxrPa9fbF61CP+iSdE6w==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1672340948; x=1672427348; bh=0RQE8/nTaUDJx2rfTZDgn+HEP18KjlUXz+u
        Mmj/1Xf4=; b=mL+bYvNCMGh78XX/SW79Ie5O+5bmiRBMIExeEDzSGTXNc0pSwxl
        jjvsFZ+KUWBQ0jUIaEAMDosdq1CUI4crH0BtNdm+Df/0Zf3jUDmUVzmF8ThVe8fm
        TvE4HxpZ2Fv2GK43JWcATWwLYDTvTxQ0lobNKHONHBgPalpM+pNN8ShafZ9bksNt
        d4h/OaIqs4m3ogrzSrLU0hmEB5FjPVpt4KFVnMgwrxe/ZqIrWKWjLoaH/f6h3Is0
        dDaQr+kA48NTRCVDsuTNX13xhg+lMrJayqqLxvk+/ZKnJb8DYQ4fn2JsH6P/AAYf
        8KQakKK7oF3WeDCSbWhrxK2XCPgSCtymY4g==
X-ME-Sender: <xms:0-WtY6cCXEMXezw9B8quno1dTE4qs9TPOddbwMbhXCjUjUHBfvvzhw>
    <xme:0-WtY0NHeeQL2RfIblN0SVb9LD59L-DEpHQ9z30aVRYpnJ1t6N2_O2UuyDHjOkfD1
    GV86mH3OF47PlEuIw>
X-ME-Received: <xmr:0-WtY7jhzQAuFIQzNxv5GL5FTPUL4fyPR6GRotkwPPc3TlTCsZ0rKHz_gWdUaU8HgfBxi0lhQAnSnuxpE84E_kZin0qLDmmJbaeJLFJ3B9lASYA2BnUsd_noAeH6Kqro6dT7HA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrieeggdduvdduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeevlefhjeeuleeltedvjedvfeefteegleehueejffehgffffeekhefh
    hfekkeegnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:1OWtY3_X9zokBMbSNhpha85A0v6nPG3GuzMWi_x03oTPbetgofkn5g>
    <xmx:1OWtY2ufes7Qi1QxihTFEpXej0ONxv_WC9TIbPQeODdcc6nqkmzPBw>
    <xmx:1OWtY-Ge-lZKj0YNckck5JCXrO36pQIvs34FcDMNocZptJezeSyNmg>
    <xmx:1OWtY4IjEOcTWNQJdtRm3FwGfii3mjEKieUnCMtGaWyiUBxnsgvNfA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 29 Dec 2022 14:09:07 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Samuel Holland <samuel@sholland.org>
Subject: [PATCH 0/3] mtd: rawnand: Add H27UCG8T2FTR-BC MLC NAND
Date:   Thu, 29 Dec 2022 13:09:02 -0600
Message-Id: <20221229190906.6467-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,URIBL_BLACK autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This series adds support for the subject NAND chip, found in an
Allwinner A33 tablet, which appears to be a slightly newer revision of
the already-supported H27UCG8T2ETR-BC.

I initially tried declaring the chip with the number of pages from the
datasheet, but it appears the NAND core only supports power-of-two page
counts. I made a change which works for me, but I am marking it as RFC
because I am unsure of any other impacts of this change.


Samuel Holland (3):
  mtd: rawnand: hynix: Add support for H27UCG8T2FTR-BC MLC NAND
  mtd: rawnand: Support non-power-of-two chip sizes
  mtd: rawnand: hynix: Expose the full H27UCG8T2FTR-BC chip size

 drivers/mtd/nand/raw/nand_base.c  | 14 +++++---------
 drivers/mtd/nand/raw/nand_hynix.c |  4 ++++
 drivers/mtd/nand/raw/nand_ids.c   |  4 ++++
 3 files changed, 13 insertions(+), 9 deletions(-)

-- 
2.37.4

