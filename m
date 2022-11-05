Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 865C261DE9C
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Nov 2022 22:29:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229809AbiKEV3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 5 Nov 2022 17:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229555AbiKEV3R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 5 Nov 2022 17:29:17 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E43FB9FE7
        for <linux-kernel@vger.kernel.org>; Sat,  5 Nov 2022 14:29:15 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id 4FB0532002E2;
        Sat,  5 Nov 2022 17:29:12 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Sat, 05 Nov 2022 17:29:12 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sholland.org; h=
        cc:cc:content-transfer-encoding:date:date:from:from:in-reply-to
        :message-id:mime-version:reply-to:sender:subject:subject:to:to;
         s=fm1; t=1667683751; x=1667770151; bh=1YxFOzKLb6PepEnje/cpfRYVJ
        j5s6XwpPGi9iTAPYdA=; b=CAGtbpfMa3ugNCnmNOq0OWGFMJzHOE+lVZ+A1Awxa
        EvXKKdKXjZ5X9F1WHzw7rBjFo55TJWON1syXXAz8lvEJ9un+YiTQO9IBEUOBwVvL
        5nrTrpSfXLXbo04Q4cLPETofWnHkGokp+CC8jvlvzi3X3AJmbeiVowOZ5Fujtb2/
        YOKzzOoltrbox4ECOrD9mVfFmEI9D6kW/PCxbeueyv18cyPdxgkfWtx9cyoQcv2O
        6V4xixQoxMNRmnQMyWHJ+BThwaxOmHSqkM85rEpDKDl0ViV3e8KOsOgbZRRMekec
        m6bsRs3KytT6oC28YfQH6ubgzwKOk8B9gP+FQrnzBzo+A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding:date:date
        :feedback-id:feedback-id:from:from:in-reply-to:message-id
        :mime-version:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1667683751; x=1667770151; bh=1YxFOzKLb6PepEnje/cpfRYVJj5s6XwpPGi
        9iTAPYdA=; b=shtJ+RRfCOZ4O8r1bhHrbDAOVM7IHZaZGuxr7XGdYcDWfL29dop
        py17gE7b7uk0VGNf2m3iEKIl3z9Axb4e9G5BMG1X7gJwWbG5SNR2uGzbix5cOMSA
        hMqqBjHcsszoLDSvI+mhc2xaI8MeOxcVyginL3l43yS+CsOCbHNZtflFzhgeffOJ
        rc4zdqKinjlQGw+CCI63rwhzXk9g/zmQ/rsiNNOMDhG9gH6WzCaMuZee/QliywjB
        cUrUzxz+rYFcN6JuljDDm22Z+MzaSPfNEIm0laYm26m0mhNp/BVL7AWP2etjuezd
        huBupQLel7xRCzuMSf1D4pEO6I49Xsn3TmQ==
X-ME-Sender: <xms:ptVmYwvnDFTNsviSvJGWazvOlJnX3nXHjPuUouL2fGdV73911n2Z7w>
    <xme:ptVmY9ddLDEK_yWHyE2aksH0wklDnx_dFioxH61Qh-dcd6lGdk6JTj-s8g8T7obv1
    XZG3VAopehhNWnI2A>
X-ME-Received: <xmr:ptVmY7x2x7eWUwac7ac7GDNNmBxtkM0HsvAgUemZUCpU6Ql-x212G6_5r-HI5S1bMi3oB7R2cFvY0gEygBh7iX15MIy0bQxjn1oLjwtM987YCbyYzjr2L7glsyyalzE6Y2Tvsg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvgedrvdeggdefgecutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpefhvfevufffkffoggfgsedtkeertdertddtnecuhfhrohhmpefurghmuhgvlhcu
    jfholhhlrghnugcuoehsrghmuhgvlhesshhhohhllhgrnhgurdhorhhgqeenucggtffrrg
    htthgvrhhnpeekveelhfejueelleetvdejvdeffeetgeelheeujeffhefgffefkeehhffh
    keekgeenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpe
    hsrghmuhgvlhesshhhohhllhgrnhgurdhorhhg
X-ME-Proxy: <xmx:ptVmYzPizTbotWpF6P-ieL2iVLyVLknwNrFeR_o4QFvBXXqDciL5XA>
    <xmx:ptVmYw_mKky9rKuKW11G-54pV7VNiSArPWndi2nc10wpvIIfzTx8jw>
    <xmx:ptVmY7UKsJGxwNN0xQta00Y2eq8Xc4_SEhSxN6HkmhAj1o7u-qQUIg>
    <xmx:p9VmYwwlfu2eVe4VU3Ll4nycOCt07pteB995zRDBXh8ZUUMI6F_mfA>
Feedback-ID: i0ad843c9:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Sat,
 5 Nov 2022 17:29:10 -0400 (EDT)
From:   Samuel Holland <samuel@sholland.org>
To:     Chen-Yu Tsai <wens@csie.org>, Lee Jones <lee@kernel.org>
Cc:     Samuel Holland <samuel@sholland.org>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        =?UTF-8?q?Micha=C5=82=20Miros=C5=82aw?= <mirq-linux@rere.qmqm.pl>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>,
        linux-kernel@vger.kernel.org
Subject: [PATCH] mfd: axp20x: Do not sleep in the power off handler
Date:   Sat,  5 Nov 2022 16:29:09 -0500
Message-Id: <20221105212909.6526-1-samuel@sholland.org>
X-Mailer: git-send-email 2.37.3
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

Since commit 856c288b0039 ("ARM: Use do_kernel_power_off()"), the
function axp20x_power_off() now runs inside a RCU read-side critical
section, so it is not allowed to call msleep(). Use mdelay() instead.

Fixes: 856c288b0039 ("ARM: Use do_kernel_power_off()")
Signed-off-by: Samuel Holland <samuel@sholland.org>
---

 drivers/mfd/axp20x.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/mfd/axp20x.c b/drivers/mfd/axp20x.c
index 88a212a8168c..880c41fa7021 100644
--- a/drivers/mfd/axp20x.c
+++ b/drivers/mfd/axp20x.c
@@ -842,7 +842,7 @@ static void axp20x_power_off(void)
 		     AXP20X_OFF);
 
 	/* Give capacitors etc. time to drain to avoid kernel panic msg. */
-	msleep(500);
+	mdelay(500);
 }
 
 int axp20x_match_device(struct axp20x_dev *axp20x)
-- 
2.37.3

