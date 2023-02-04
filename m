Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6809968AA98
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 15:36:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233614AbjBDOf7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 09:35:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233860AbjBDOfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 09:35:42 -0500
Received: from out5-smtp.messagingengine.com (out5-smtp.messagingengine.com [66.111.4.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 134BF303C6
        for <linux-kernel@vger.kernel.org>; Sat,  4 Feb 2023 06:35:19 -0800 (PST)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 9AF2D5C00B2;
        Sat,  4 Feb 2023 09:35:17 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Sat, 04 Feb 2023 09:35:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1675521317; x=1675607717; bh=xQ+77WxDcU7LsWzVt9+SldMRg
        mN28mhoYTDjd14rlqg=; b=c2Gy5mL8aq4qjm1aNmxy7JKWI4UbVsp0hyXDTUzTm
        MyQaPxKUoj0InfI4ZV+ieo0UgxFbz4EMIInGLkiD1jceqbooJDtSh4dYZ0GDGXY+
        4t8HjczBkrTWZBUwXKHaU+CxyN3nXueJ77CYA2yEE0eNABnczgl7d/tVnuMeiRmY
        kvgphu32n30p0xoiU+AjFmzEU39NF7c9pDLcBpe8wKEqVauoN0Qib2ppPy79P/bo
        UePQyJrIqZlYhVF8SSMyOrl0UzqsdfJjwe/iC1jpSfH1O+0pa5mBBS5eFlSMovZH
        xIXGM7le/yKBIRxyRqH1ESvsrSKuhe3tLI1c5TCZ9/QvA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1675521317; x=1675607717; bh=xQ+77WxDcU7LsWzVt9+SldMRgmN28mhoYTD
        jd14rlqg=; b=m1hnD1sVpWB0RRFfS/7k2abqgp8vWLdoimv5XrWE7sRHRoe3ohA
        RlN4Q5EJnKzRkNK4aE1xw3XOby4F2g7YZxKHa6PVm79KWgYYcVUjx7l6jrLgxxob
        JWK/MKD8RAAt0YdnT/79kl8N9f3zJB24YxjsMNKxoBtYdSXUHmyjhVDH65JM6dgr
        rQAPUo2XgTIru2I/3fZsyoL8hZOuK8rCBennjEVBPNlEHOOloP3cWJyaGdQz1tC0
        kyzUdeS+lRMd+YNbExAiwJqnEX38wP4aYBj+2lVw9hScS6SNNx23yOWWCRVMa3f+
        Y8ykhSSRJe2nmIDXqT8zVVU80n+z0pNTxQg==
X-ME-Sender: <xms:JG3eY5PD4jZOZl-KeHCkqsdChQ5JT5Mf-rZMpC70HU4WaZs8rA6cyg>
    <xme:JG3eY79zvServTzlVn3Gu3w1nx4qsdvie4coT2sz6NbAKHY6IQ1yxM-C88fz03kOC
    jQdxrAksWSrxKPCDQ>
X-ME-Received: <xmr:JG3eY4Q6HG-iyYW5MB50kak0vmydb8Y7vdfYDUg6FELL02I7tzxh0hBfSmwUufZ5ktNXN2zoz1x8VJ8QFWtYJpsGDUWJZ-_z4f6Jo1YMcLIgrbsE80QE1f7aDC8ePWKNABmk9A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrudegvddgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgggfestdekredtredttdenucfhrhhomhepufgrmhhuvghl
    ucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecuggftrf
    grthhtvghrnhepkeehffethedtteffgfefteetjedvfeelueevudffgfeutdejvdehledv
    vdffhfevnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehsrghmuhgvlhesshhhohhllhgrnhgu
    rdhorhhg
X-ME-Proxy: <xmx:JG3eY1vuKlrIu7-ySLvHe64iI47-2yFmUEWoJhPWicdUaL8KbD9fTw>
    <xmx:JG3eYxcDldiiUcymve0EzomL7Px_pfKIMCXqE0xQl_oZt4K0M62HDA>
    <xmx:JG3eYx2XU2RxdNTabFuRjKvoIcz1SielsiZxpON0ZZHnEZaX_Po9IA>
    <xmx:JW3eY95bFHkqAqa4MrkjYX9LhMEwS951M8OOv6-lVtJRzZhbQX907A>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 4 Feb 2023 09:35:16 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>
Cc:     Boris Brezillon <bbrezillon@kernel.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Chen-Yu Tsai <wens@csie.org>,
        Samuel Holland <samuel@sholland.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org, linux-sunxi@lists.linux.dev
Subject: [PATCH v2 0/3] mtd: rawnand: sunxi: Some cleanup
Date:   Sat,  4 Feb 2023 08:35:17 -0600
Message-Id: <20230204143520.9682-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
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

(Apologies for the delay in sending v2. As discussed previously[1],
the first patch needs to be merged in the same merge window as commit
34569d869532 from v1 of the series, even if the others don't make it.)

I have an A33 tablet with MLC NAND, and I wanted to use mainline Linux
to dump the NAND. To do that, I updated this driver's ECC ops to fully
utilize the hardware for ECC and scrambling. This made the driver
compatible with the existing (scrambled) on-flash bad block map, and I
was able to read the full NAND contents.

This series contains some cleanup from that effort. The first patch
ensures we can make good use of the hardware ECC/descrambler. The other
two patches simplify some code for managing the ECC engine.

[1]: https://lore.kernel.org/linux-mtd/20230102175351.64690aaf@xps-13/

Changes in v2:
 - Update commit message to address backward-compatibility concerns
 - Keep `struct sunxi_nand_hw_ecc` but change the pointer to a value
 - Split ECC_CTL precomputation and structure updates to two patches

Samuel Holland (3):
  mtd: rawnand: sunxi: Update OOB layout to match hardware
  mtd: rawnand: sunxi: Embed sunxi_nand_hw_ecc by value
  mtd: rawnand: sunxi: Precompute the ECC_CTL register value

 drivers/mtd/nand/raw/sunxi_nand.c | 73 +++++++++----------------------
 1 file changed, 20 insertions(+), 53 deletions(-)

-- 
2.37.4

