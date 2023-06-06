Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1C53A724774
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237822AbjFFPSO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45032 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233032AbjFFPSN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:18:13 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5071212D;
        Tue,  6 Jun 2023 08:18:11 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.nyi.internal (Postfix) with ESMTP id D4E5B5C00FC;
        Tue,  6 Jun 2023 11:18:09 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Tue, 06 Jun 2023 11:18:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1686064689; x=
        1686151089; bh=XUEmBDCReC+iW6QvdzWSDKkyTa4N1Kwt8dfbbxuqV5I=; b=y
        COfpzqAi1T3NWAepSCnPrAgkbySq/QQsWMngR0K9TRd334ymeGL/lWSlBnUG25yf
        t4KBcbXz6MChAl0QfPpE1xyKxR2AKgCQcWwDab4ab5y9f7ujimB0RWbJ0fjwJqon
        o73RHYfaIXvhuubMImfaIFWsZpHV6cLJAWj6qjmPif6hJxJBiyYV3A0od4w6AETB
        gLwvSpvbgWK1Pi11ZEOr3xpdo+kWC4lta1bjmkRgu0x3AIFfCHIblHp8aYhctj3L
        4bE+LNK42pF6Xj2H5tRKnHqh/JGRBfr3XC62COi0IqErY21riM2Cbmn8nQ78K6MF
        /57kq/uVHtVh62NHWMR4Q==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1686064689; x=
        1686151089; bh=XUEmBDCReC+iW6QvdzWSDKkyTa4N1Kwt8dfbbxuqV5I=; b=x
        sMvMhy1c87L9tCq2Y0wKd8xvw1CKHR9WVC2ZrlTUZKvIizYc/+x0NYfHLCTzWNl/
        mQE8ZTF3egQnFuwydDUhUbhheRsCHOFeAo1hj3bAcQisbFGD3fSFfHJB4DeJOsxG
        J+hIe9TxCR8nPYhLZ4WUn3XH70H/4jPPUwGXVJLZtikJzRilS4faHUPaevXw6YEd
        NWgn02kp8114P9dj9EiiUhgNxgsAQ7c1rmpJMsZYuN4WY0hYwRKpYtG5djeZw3gi
        mBqP3IZadidkudGzmcc5XxbVwyKW1XYn12/YT3rG6LkVyElFAnhM28NGZy63m7PD
        ctWD61hohCV7dB5W0eP7Q==
X-ME-Sender: <xms:MU5_ZAr60rNCdTxBhgOrp0pZegRVQ4oaTRVDudyN5HchNdmPiCcmWA>
    <xme:MU5_ZGqOp5Jt5wna3n6xRlfS4Zf3sMu11aD4iyazQlLowgxC6xc0azK2_bKQd204y
    WC4OXu9Jy42TQ78XVk>
X-ME-Received: <xmr:MU5_ZFM3Yygl64vb2Ip-lc_1I227Sq-FbCMlLBtlSmVI2EoObcyptq-_g66RRBXNsbRZVJTkZJB858KzUSj7SOS7hLMRdKEhUl68mi3YPIGWKVDYVQHMxj_Spg>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrgedtuddgkeekucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhhkucfrvggrrhhs
    ohhnuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrf
    grthhtvghrnhepvedtlefggefgjeettddvgfekhfeugfeutdekfeefudeuuddvieeutdel
    jedvhfdvnecuffhomhgrihhnpehkvghrnhgvlhdrohhrghenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhho
    sehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:MU5_ZH6MWpXHRIlK0xIxV5CnoST3noCdjQ3z5jYkfjbFJ4HlpcnoCA>
    <xmx:MU5_ZP7JMvY4d1PH7MharVteXbYroUlXbKAot6bcDBOHYjEMBoIa2A>
    <xmx:MU5_ZHjRKHDn45r7Q7nQVzrjB3wO8_RGEqH4MUA36_dO7291MeEhmw>
    <xmx:MU5_ZCaHGcY0_C1U4gegDoq_AwZ4sd3UYHe18NtEE-Sy7LLqSTORWg>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 6 Jun 2023 11:18:08 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, platform-driver-x86@vger.kernel.org,
        linux-kernel@vger.kernel.org, dan.carpenter@linaro.org,
        mario.limonciello@amd.com, lkp@intel.com,
        oe-kbuild-all@lists.linux.dev, Dan Carpenter <error27@gmail.com>
Subject: [PATCH] platform/x86: thinkpad_acpi: Fix lkp-tests warnings for platform profiles
Date:   Tue,  6 Jun 2023 11:18:04 -0400
Message-Id: <20230606151804.8819-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix issues identified in dytc_profile_refresh identified by lkp-tests.
drivers/platform/x86/thinkpad_acpi.c:10538
	dytc_profile_refresh() error: uninitialized symbol 'funcmode'.
drivers/platform/x86/thinkpad_acpi.c:10531
	dytc_profile_refresh() error: uninitialized symbol 'output'.
drivers/platform/x86/thinkpad_acpi.c:10537
	dytc_profile_refresh() error: uninitialized symbol 'output'.

These issues should not lead to real problems in the field as the refresh
function should only be called if MMC or PSC mode enabled. But good to fix.

Thanks to Dan Carpenter and the lkp-tests project for flagging these.

Reported-by: kernel test robot <lkp@intel.com>
Reported-by: Dan Carpenter <error27@gmail.com>
Closes: https://lore.kernel.org/r/202306011202.1hbgLRD4-lkp@intel.com/
Fixes: 1bc5d819f0b9 ("platform/x86: thinkpad_acpi: Fix profile modes on Intel platforms")
Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
 drivers/platform/x86/thinkpad_acpi.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index b3808ad77278..4b89f42de723 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10524,7 +10524,7 @@ static int dytc_profile_set(struct platform_profile_handler *pprof,
 static void dytc_profile_refresh(void)
 {
 	enum platform_profile_option profile;
-	int output, err = 0;
+	int output = 0, err = 0;
 	int perfmode, funcmode;
 
 	mutex_lock(&dytc_mutex);
@@ -10538,6 +10538,8 @@ static void dytc_profile_refresh(void)
 		err = dytc_command(DYTC_CMD_GET, &output);
 		/* Check if we are PSC mode, or have AMT enabled */
 		funcmode = (output >> DYTC_GET_FUNCTION_BIT) & 0xF;
+	} else { /* Unknown profile mode */
+		err = -ENODEV;
 	}
 	mutex_unlock(&dytc_mutex);
 	if (err)
-- 
2.40.1

