Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DA0D4602D77
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 15:53:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231280AbiJRNxf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 09:53:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231251AbiJRNxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 09:53:13 -0400
Received: from wout5-smtp.messagingengine.com (wout5-smtp.messagingengine.com [64.147.123.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CFDE5CF849;
        Tue, 18 Oct 2022 06:53:09 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id C982C3200973;
        Tue, 18 Oct 2022 09:53:07 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Tue, 18 Oct 2022 09:53:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cerno.tech; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm3; t=1666101187; x=
        1666187587; bh=zC15H4SSLDkQqZpq7Xp4KXOnBwWt4isnG8QaWwdlOMk=; b=L
        BjRCMBKIUkxLIcjsUnNNdEB4Kp7tt9FyxpDktf7DsYL0O/AIi7EASW0Ab7ZhiAkI
        Q1cV1StyiFtpW3o3j+sUm9OZYDDnrNLNp53W43uqNXT+6jOOL8UM+G+w4U84kvLi
        Q1QLLLRfFSo/aHTacVn19aDY19vJGVvd9CA+MVQ5s9bvC59mDwuEbKtQ3hxvu6lB
        EqJLGc2h4cWyj/U17j8b0VsyHY2tyfJMeZx8exQjyGZWNENP2cAUI9e3iSuIbrBL
        n9IQ3F37HUuhhBgFk98faIdsjRcxgonWfYVUXY+nJIjUyHJ8Mnpl3380ZNUb5lZo
        3jfH/HCWQBxCm0AZGtw5g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1666101187; x=
        1666187587; bh=zC15H4SSLDkQqZpq7Xp4KXOnBwWt4isnG8QaWwdlOMk=; b=P
        o/xgpCsDKQzNYrOVioK7CmTbSlZDVtgut8Dcm3EjbEF1d5F2DfZLZStGGqq+7JtI
        DMNMjvBeZRmRonobaeF1mb1pNHGUr99dslC/ZD8mPjtS3XItrKXPeXPqW4LDgOoo
        QcJs6qm5BUrjc5FWuY6ppK5LTGnJCTeT7odFUIwa7q6/KJ5agcDrRXbhv4IWtTS8
        rrXCprXGmDzhvM0tGZg6jiuZieELhuxkOyvoobxuys4kVELulGCWy4WKVp9wtKpx
        qfZxifB9ATSuial+oWMyXuko7XyjxQP5GcIreLgrRhwXlcaOq/yNxw62tJ2y44T9
        w5CMZrUNFdPdzZWNIFwkA==
X-ME-Sender: <xms:w69OY6CX10G99AXTX9pAH-2_PRI1Dxa-WbKUt32b_xjWm0jHe8_pjA>
    <xme:w69OY0hre4oL5sMjRMY4sfxJs68S7d1e_991X6LqitkToOqr0jtffCsoIGWlDyJio
    70bt6wh1S-Dk9UhnSU>
X-ME-Received: <xmr:w69OY9m1ryZwWIRePb-kJ5uhByst1XNnRK6AVWWu__C43QtT5uFX5wBo1CFq>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvfedrfeelvddggedtucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhephfffufggtgfgkfhfjgfvvefosehtkeertdertdejnecuhfhrohhmpeforgig
    ihhmvgcutfhiphgrrhguuceomhgrgihimhgvsegtvghrnhhordhtvggthheqnecuggftrf
    grthhtvghrnhepudduudfhveejteefgedvffdvvedvjedugedukeejhedtlefhffevtefh
    jeeltdevnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epmhgrgihimhgvsegtvghrnhhordhtvggthh
X-ME-Proxy: <xmx:w69OY4zPIG17Q3rwe_BCKemVe4RxRrNMZC9BXj6pT4Jj0BwzkMP3ww>
    <xmx:w69OY_Tqw-r7OVpO6DD7VkNNK_9iBbxZqJ4XQprlpeXd29xKj5l6ZA>
    <xmx:w69OYzbeWKyJW_m2b4N-43A9zKPbqTn3OcoA5sNxGAUcihPD3s0J7w>
    <xmx:w69OY9ON3EI9TRqcZZXtV3aqE-zoRruGL4HlVIMv7bKqIfqSH8-vZw>
Feedback-ID: i8771445c:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 18 Oct 2022 09:53:06 -0400 (EDT)
From:   Maxime Ripard <maxime@cerno.tech>
Date:   Tue, 18 Oct 2022 15:52:58 +0200
Subject: [PATCH 3/4] clk: Initialize max_rate in struct clk_rate_request
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20221018-clk-range-checks-fixes-v1-3-f3ef80518140@cerno.tech>
References: <20221018-clk-range-checks-fixes-v1-0-f3ef80518140@cerno.tech>
In-Reply-To: <20221018-clk-range-checks-fixes-v1-0-f3ef80518140@cerno.tech>
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Maxime Ripard <maxime@cerno.tech>, linux-clk@vger.kernel.org
X-Mailer: b4 0.11.0-dev-7da52
X-Developer-Signature: v=1; a=openpgp-sha256; l=917; i=maxime@cerno.tech;
 h=from:subject:message-id; bh=KLxniowvB7k1BDJbP1S+8WEzaS8XpK4dLNHTLmCyBkY=;
 b=owGbwMvMwCX2+D1vfrpE4FHG02pJDMl+63dmftq4nj95n16R8bn7TR8fpVjWHfl56O7VgO7s65v0
 tkeJdZSyMIhxMciKKbLECJsviTs163UnG988mDmsTCBDGLg4BWAike4Mf4U6k3ecfq7uysi1T06Q23
 t++63S6nSWiasXrc+71Hnr0DOG/75mlwvMWq+W6+REamywuvLRWm1uvIILi9JCG8GL35v3cQIA
X-Developer-Key: i=maxime@cerno.tech; a=openpgp;
 fpr=BE5675C37E818C8B5764241C254BCFC56BF6CE8D
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since commit b46fd8dbe8ad ("clk: Zero the clk_rate_request structure"),
the clk_core_init_rate_req() function clears the struct clk_rate_request
passed as argument.

However, the default value for max_rate isn't 0 but ULONG_MAX, and we
end up creating a clk_rate_request instance where the maximum rate is 0.

Let's initialize max_rate to ULONG_MAX properly.

Fixes: b46fd8dbe8ad ("clk: Zero the clk_rate_request structure")
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
---
 drivers/clk/clk.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/drivers/clk/clk.c b/drivers/clk/clk.c
index eb2f9be9b9aa..57b83665e5c3 100644
--- a/drivers/clk/clk.c
+++ b/drivers/clk/clk.c
@@ -1463,6 +1463,7 @@ static void clk_core_init_rate_req(struct clk_core * const core,
 		return;
 
 	memset(req, 0, sizeof(*req));
+	req->max_rate = ULONG_MAX;
 
 	if (!core)
 		return;

-- 
b4 0.11.0-dev-7da52
