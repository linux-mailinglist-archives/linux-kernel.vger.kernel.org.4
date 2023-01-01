Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E85365AAFE
	for <lists+linux-kernel@lfdr.de>; Sun,  1 Jan 2023 19:33:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231343AbjAASd2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 1 Jan 2023 13:33:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230505AbjAASdY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 1 Jan 2023 13:33:24 -0500
Received: from wout1-smtp.messagingengine.com (wout1-smtp.messagingengine.com [64.147.123.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C89270A
        for <linux-kernel@vger.kernel.org>; Sun,  1 Jan 2023 10:33:23 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id E1C8732005D8;
        Sun,  1 Jan 2023 13:33:22 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Sun, 01 Jan 2023 13:33:23 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :in-reply-to:message-id:mime-version:references:reply-to:sender
        :subject:subject:to:to; s=fm3; t=1672598002; x=1672684402; bh=gF
        Jp7uQ/NboepQjd9pK1M3B4deROdXdMSMySU0IDyhg=; b=G1bvr603ZRIBxeV9ii
        m58ikTrF4KFUEqluhod1Z/SP4WP3s3e0+HpMPwYpBpHjugkRcKJ9H6/QM8LM1vO/
        t65lRFm0gp516OYvHDF4bhIF3tMKL56T6xTTK6DcTMqZ1Jc5qwnuG1gG5n0NzBZT
        cibCNXixttIgZFKmbYzm5YHHZuc58Qoy+SYXR1zB1fvF2F5dc6Il1MTWOoOs5BEa
        yfK4Hl4eJ+/NpQ7lkKHCr+l4Eu89ZDs9KUh3SExnvD/CBVV5Lu0nRfYeEIFDAuHA
        t2/2JwrusTQY5YxN0vzsqQ19APKtSxA1URgJ6IfB1lHAuqbljGIN0E6U7YckN2+I
        6UPw==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:in-reply-to
        :message-id:mime-version:references:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm2; t=1672598002; x=1672684402; bh=gFJp7uQ/Nboep
        Qjd9pK1M3B4deROdXdMSMySU0IDyhg=; b=BZLrHMJ6yNFS7YrUYJCIPzaX6nal2
        AMdi5SKhAF0Z9Q8BF4euGd7iHadoJcWrME+6pWsPsHiP9nI7LMUFetM5rRxFuzPP
        b8pGjO4O1lidzz9cE7bqiZ+gKvQD6DGEju61PJZlfAKmWFqtemQPs0IrDrp92Na5
        ZAZ7xYo5C3a89CS1KaHrqMQgq1pq3muJ6rTqZae8riVC4ltNP6aiHYVQ4dC9e1IG
        AqyAfT1zsDvEJRe5hdYHuXWqNElxq9bu8k8/MlHzyqahGeUhjwXYZY6xVFrh/ckh
        HXKN3xJ7u/AS8CvWlqutSz9DKH4T/CahaFt8Cgnla40JYl03cmdI+HVKQ==
X-ME-Sender: <xms:8tGxY0SakjOvHmM5SKs8Qi8fhCiwDfKQMjjS0eR6WlftX1F2j2iWow>
    <xme:8tGxYxzjqiJdtEsWKIRwrspndXbu1uywSw6qpO-34D-j1_PT5Y686WumlPHkCPeTT
    St_vQ-eZGwz8zURwQ>
X-ME-Received: <xmr:8tGxYx0z_udRp-YiU4bSKMojRABeqmCIPUw7LEGneAHjc-fIDrd20KaZNwMknWZkje3raYCimCinwABjap0qNO0AOwdiUVtoJKO-ohOJYMlh5BdzIpDu7hSjKTRikklgEt8Dgg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrjedtgdduudduucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephffvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepufgrmhhu
    vghlucfjohhllhgrnhguuceoshgrmhhuvghlsehshhholhhlrghnugdrohhrgheqnecugg
    ftrfgrthhtvghrnhepudekteeuudehtdelteevgfduvddvjefhfedulefgudevgeeghefg
    udefiedtveetnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrh
    homhepshgrmhhuvghlsehshhholhhlrghnugdrohhrgh
X-ME-Proxy: <xmx:8tGxY4A9x7JO-g2spHjr5Jy9xTmyxSYd-abGNhDo-2gUUD48eBeLEQ>
    <xmx:8tGxY9jzWQ4V8yiHCFP8Mw42kmDsT2oh7tGlk4lDTacBqJFcqkZDqg>
    <xmx:8tGxY0p_Z4kOk_kUZtN4EI6xurfx-d_mCftAXO7ZFHt5GJRRWWSoJQ>
    <xmx:8tGxY4UYq08Blbikvwzp5R-AMEcI97oNES8B-f27YfmGK5VRmVu8vA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sun,
 1 Jan 2023 13:33:21 -0500 (EST)
From:   Samuel Holland <samuel@sholland.org>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>
Cc:     Samuel Holland <samuel@sholland.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-sunxi@lists.linux.dev
Subject: [PATCH v2 2/2] nvmem: sunxi_sid: Drop the workaround on A64
Date:   Sun,  1 Jan 2023 12:33:16 -0600
Message-Id: <20230101183316.43642-3-samuel@sholland.org>
X-Mailer: git-send-email 2.37.4
In-Reply-To: <20230101183316.43642-1-samuel@sholland.org>
References: <20230101183316.43642-1-samuel@sholland.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the SRAM readout code is fixed by using 32-bit accesses, it
always returns the same values as register readout, so the A64 variant
no longer needs the workaround. This makes the D1 variant structure
redundant, so remove it.

Signed-off-by: Samuel Holland <samuel@sholland.org>
---

(no changes since v1)

 drivers/nvmem/sunxi_sid.c | 8 +-------
 1 file changed, 1 insertion(+), 7 deletions(-)

diff --git a/drivers/nvmem/sunxi_sid.c b/drivers/nvmem/sunxi_sid.c
index 92dfe4cb10e3..a970f1741cc6 100644
--- a/drivers/nvmem/sunxi_sid.c
+++ b/drivers/nvmem/sunxi_sid.c
@@ -197,15 +197,9 @@ static const struct sunxi_sid_cfg sun8i_h3_cfg = {
 	.need_register_readout = true,
 };
 
-static const struct sunxi_sid_cfg sun20i_d1_cfg = {
-	.value_offset = 0x200,
-	.size = 0x100,
-};
-
 static const struct sunxi_sid_cfg sun50i_a64_cfg = {
 	.value_offset = 0x200,
 	.size = 0x100,
-	.need_register_readout = true,
 };
 
 static const struct sunxi_sid_cfg sun50i_h6_cfg = {
@@ -218,7 +212,7 @@ static const struct of_device_id sunxi_sid_of_match[] = {
 	{ .compatible = "allwinner,sun7i-a20-sid", .data = &sun7i_a20_cfg },
 	{ .compatible = "allwinner,sun8i-a83t-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun8i-h3-sid", .data = &sun8i_h3_cfg },
-	{ .compatible = "allwinner,sun20i-d1-sid", .data = &sun20i_d1_cfg },
+	{ .compatible = "allwinner,sun20i-d1-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-a64-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-h5-sid", .data = &sun50i_a64_cfg },
 	{ .compatible = "allwinner,sun50i-h6-sid", .data = &sun50i_h6_cfg },
-- 
2.37.4

