Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 803466577B6
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Dec 2022 15:24:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229964AbiL1OYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Dec 2022 09:24:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232942AbiL1OYM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Dec 2022 09:24:12 -0500
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 108D311802;
        Wed, 28 Dec 2022 06:24:12 -0800 (PST)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.west.internal (Postfix) with ESMTP id 5972D320089C;
        Wed, 28 Dec 2022 09:24:11 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Wed, 28 Dec 2022 09:24:11 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        tom-fitzhenry.me.uk; h=cc:cc:content-transfer-encoding:date:date
        :from:from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm2; t=1672237450; x=1672323850; bh=rc
        9LQ2VnjlNpc5ngluEvEJZ7v2bNRtgKMYRSZLT19sU=; b=NiACEhsEw6qjL45wZX
        Kte5sJfngYzkdgfKHkSrY8wTrdhrIWzk2rpZNy6afr2N7sJe3nAbSSdQQak5CFLZ
        sHra7P2MUAwv+hVqSJgSZSYatrkzw/pNStvFd2nQY+oQvLDI3e/vez44sjlvM+bl
        PN+JsEImwXqupErb40qh79RYANizZCiKKWMIOU06bGRnsRiSmF4vxnpXzdgafGbR
        DM8IcECGiIRggUaYmQvvvWaTOufL8X/NclAGsxF9O1dvD/4ijZkXsoXxqszW+mw/
        sa+wU/8HaHtXFXFm2gA2BDKthfxEC24gQDfnEoEGBy4TgPINhVarSpq9jmxg4/Bx
        7gTg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm2; t=
        1672237450; x=1672323850; bh=rc9LQ2VnjlNpc5ngluEvEJZ7v2bNRtgKMYR
        SZLT19sU=; b=BRdp6oLEjhSSYsqclKJ3QQ3VijaxPbjk13UycUaFGTmNOwxvPbJ
        p5mHHB1y/Y/Zg4B9/k8qxRu9D3uFsfSZuCuND6x2kFnFsGPqbuSnaAFjrTB8zFIa
        AMZVcwk0dJJvI0mEKnU1PPxTW+lTnrjmVVZmrZoZuuHCKpJKlbvjD7xFGsO1uNGR
        HKWs9FFk0D8HNJgiAU77efvUpByscCoiu9SebcVs7D0E40tY643HJX7kCJugT63T
        h+iSkJmGi5puonVBjD3rYqjZgG5onwrZpk08uS/MTmzN8Y4jai0q8CFlrIolcmmg
        Uw0zpY/NwyqhxsrZOGXunUgcR16TGxQ6oeQ==
X-ME-Sender: <xms:ilGsY3h2gk8wMRfXanaM0xKtwSx2hu-zxzruo_sbi1yCwVEKuRliuw>
    <xme:ilGsY0Bdkp_HshiEn_Zd8Bz-iSCywr1eXQ0qNaCFP7pO8ZDs4DSLoalkMlkoVcLWu
    wS68hDV2YJ6mIjABQ>
X-ME-Received: <xmr:ilGsY3GMed9F9aBPBQd9XN2J2KpDdZyaE7YQrMZQwFJczGQVsu6MDS7MqAz-t9KTiT7es2xFVUqCb7dpRLc3BlUWIDfKo-KO3o4>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedriedvgdeihecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefvohhmucfhihht
    iihhvghnrhihuceothhomhesthhomhdqfhhithiihhgvnhhrhidrmhgvrdhukheqnecugg
    ftrfgrthhtvghrnhepgeduvdetteeivefhtdeuudeuvdeltdfhjeduleekudegleeutedu
    veejffeludeknecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehtohhmsehtohhmqdhfihhtiihh
    vghnrhihrdhmvgdruhhk
X-ME-Proxy: <xmx:ilGsY0S-_RWJDyLM-xPf3JQdeG0Ydgj7hknMm1juPkcC9O5MC6VkCw>
    <xmx:ilGsY0zf7vALVRoJJozvU-4DybJSFapwtX6lg3_tul1t7Ma8EeY-vA>
    <xmx:ilGsY673SXVevjpkxwfqFAi6mjBynozprxCaQhJNfvKNTk6FN9VQ0A>
    <xmx:ilGsY7lp2o6rPpnHuPZ6X9nwa7p1TWOuv8MzBASEzlRd_I4fMyVyqw>
Feedback-ID: iefc945ae:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 28 Dec 2022 09:24:09 -0500 (EST)
From:   Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
To:     Ulf Hansson <ulf.hansson@linaro.org>
Cc:     Tom Fitzhenry <tom@tom-fitzhenry.me.uk>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mmc: pwrseq_simple: include deferred probe reasons
Date:   Thu, 29 Dec 2022 01:23:54 +1100
Message-Id: <20221228142354.28454-1-tom@tom-fitzhenry.me.uk>
X-Mailer: git-send-email 2.38.1
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

This adds a reason to /sys/kernel/debug/devices_deferred, which makes
it easier to debug deferred probes such as [0].

0. https://lore.kernel.org/all/20221228140708.26431-1-tom@tom-fitzhenry.me.uk/

Signed-off-by: Tom Fitzhenry <tom@tom-fitzhenry.me.uk>
---
 drivers/mmc/core/pwrseq_simple.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/mmc/core/pwrseq_simple.c b/drivers/mmc/core/pwrseq_simple.c
index 988467fbb621..3bac1e71411b 100644
--- a/drivers/mmc/core/pwrseq_simple.c
+++ b/drivers/mmc/core/pwrseq_simple.c
@@ -119,14 +119,14 @@ static int mmc_pwrseq_simple_probe(struct platform_device *pdev)
 
 	pwrseq->ext_clk = devm_clk_get(dev, "ext_clock");
 	if (IS_ERR(pwrseq->ext_clk) && PTR_ERR(pwrseq->ext_clk) != -ENOENT)
-		return PTR_ERR(pwrseq->ext_clk);
+		return dev_err_probe(dev, PTR_ERR(pwrseq->ext_clk), "external clock not ready\n");
 
 	pwrseq->reset_gpios = devm_gpiod_get_array(dev, "reset",
 							GPIOD_OUT_HIGH);
 	if (IS_ERR(pwrseq->reset_gpios) &&
 	    PTR_ERR(pwrseq->reset_gpios) != -ENOENT &&
 	    PTR_ERR(pwrseq->reset_gpios) != -ENOSYS) {
-		return PTR_ERR(pwrseq->reset_gpios);
+		return dev_err_probe(dev, PTR_ERR(pwrseq->reset_gpios), "reset GPIOs not ready\n");
 	}
 
 	device_property_read_u32(dev, "post-power-on-delay-ms",

base-commit: c76083fac3bae1a87ae3d005b5cb1cbc761e31d5
-- 
2.38.1

