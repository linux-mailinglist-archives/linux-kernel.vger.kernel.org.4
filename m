Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 857E66F83EC
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:25:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232536AbjEENZj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:25:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232065AbjEENZh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:25:37 -0400
Received: from out1-smtp.messagingengine.com (out1-smtp.messagingengine.com [66.111.4.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FAAA1F4B9;
        Fri,  5 May 2023 06:25:36 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id CD56E5C0314;
        Fri,  5 May 2023 09:25:35 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 05 May 2023 09:25:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm1; t=1683293135; x=
        1683379535; bh=7t+/lIxhqlgnlEBYwfT2xXhyCdqZvuaeWIN7vpHYLAI=; b=k
        oAn0tSE2cwE/I/11d2hDIDF/GVjIvJOP1byJzpKIad9fJSaTOcuSEYY9MO299OYn
        /WkYaLXUt9uH9viJXopHdVupX59beGHD+RNMrtjFo+HIMq5D9EtssPim8CGh+gp7
        8ACTf9KpAgSNNTqiqoQnXkXEgfpVvZY2MzDMuIE68AdaCQgt8WfRDvBxYOEe2QKK
        F9XBLpt3BYXoEkSXEUXi6brJozAL5XNm/iJ3TyXCuQko2iRAy9ivx5s4za83Ij1A
        725wTxeUOkdWBRjhtd+CPkn06uvDrbmHozeKmf4v6MNIiWRRfwK6jfEsVZomMMs0
        vWZdeNXA5XCK4r2l2qgyA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=1683293135; x=
        1683379535; bh=7t+/lIxhqlgnlEBYwfT2xXhyCdqZvuaeWIN7vpHYLAI=; b=J
        1RgSkhR5Vd4V3MJiHcGT3pIsADbScMo7opwlybEp1qzKeaJ/ufEKT+kwGW7hR9wp
        ywk8QbvzwbJ2gdg0WrqSCXzcZW9MH5WvXAWkV0a/3kraHL2AgQmnYvKjvtg2Q4Zw
        /1oYhMZZ2RNglx+s/81I0kFb/G4e7Cj4cinKlzXWGmD5d1qZjOmwEO6SOYOrgX0A
        jWbfNIXbb7kl6ujUqH1YACBPi64YHFPC2ZiQiTtqDJ9BTiL8doHF51rWbIxm45dk
        bvTLKgk1B0qTQ4Qnc/RBAeLErCxZJMOwTY181B3v9xaDWQBwiYrQ5ISOIwoaS7Xz
        uhfdXBqfJmtPkLfzDEOMQ==
X-ME-Sender: <xms:zwNVZHdSHWmPdCrwOS8DI_aTUWBIHsOZqJGIL4iml7u-oCSU01D5nw>
    <xme:zwNVZNMiPZmtOY5y0Gs_61ATCKe-n4oWTlRkAKc_mg_Q0NsxTQGrpJlbmcq2oj-2k
    GK-CvaoR6dmQNk2wlI>
X-ME-Received: <xmr:zwNVZAi-NTia1oeHsjNmfnQpQOUqvCPimSzbg2YXRGfMEFr24VU5oGNqPd3ltWgkh9ld4T1rFzLgr4Xvkh_UibpVv-ckGxfZ0AKwoBt26eU_54V-Uk-vKQF5tXK_S3_o_ntROWujlA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeefvddgieehucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucgoteeftdduqddtudculdduhedmnecujfgurhephf
    fvvefufffkofgjfhgggfestdekredtredttdenucfhrhhomhepofgrrhhkucfrvggrrhhs
    ohhnuceomhhpvggrrhhsohhnqdhlvghnohhvohesshhquhgvsggsrdgtrgeqnecuggftrf
    grthhtvghrnhepvedvtdejlefgvdeffeefgfefieduvdejledtgfeludffleeivedugeei
    jedtuedtnecuffhomhgrihhnpehrvgguhhgrthdrtghomhenucevlhhushhtvghrufhiii
    gvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpehmphgvrghrshhonhdqlhgvnhhovhho
    sehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:zwNVZI-F4JssSio2WVl6DQWmyKY46WDw9Tazlolh1tJvpHD91bBnXA>
    <xmx:zwNVZDscr3Q-myETuESxwWQ9ukQemVtEZj9WBV3LFtUt5BTBxm7OcA>
    <xmx:zwNVZHGjNrNeAjcg-81WX3EqlJbMupVjL71Mh_64IllY4sQVM2spuA>
    <xmx:zwNVZNJOcpZHl2w3R9yTY3_wOxIJ4aXI05vxPC_URi88P2K-Iwr0bA>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 5 May 2023 09:25:35 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        stable@vger.kernel.org
Subject: [PATCH 1/2] platform/x86: thinkpad_acpi: Fix platform profiles on T490
Date:   Fri,  5 May 2023 09:25:22 -0400
Message-Id: <20230505132523.214338-1-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I had incorrectly thought that PSC profiles were not usable on Intel
platforms so had blocked them in the driver initialistion. This broke
platform profiles on the T490.

After discussion with the FW team PSC does work on Intel platforms and
should be allowed.

Note - it's possible this may impact other platforms where it is advertised
but special driver support that only Windows has is needed. But if it does
then they will need fixing via quirks. Please report any issues to me so I
can get them addressed - but I haven't found any problems in testing...yet

Fixes: bce6243f767f ("platform/x86: thinkpad_acpi: do not use PSC mode on Intel platforms")
Link: https://bugzilla.redhat.com/show_bug.cgi?id=2177962
Cc: stable@vger.kernel.org
Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
 drivers/platform/x86/thinkpad_acpi.c | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/platform/x86/thinkpad_acpi.c b/drivers/platform/x86/thinkpad_acpi.c
index 826c522ed1c0..d84a4c7e3c35 100644
--- a/drivers/platform/x86/thinkpad_acpi.c
+++ b/drivers/platform/x86/thinkpad_acpi.c
@@ -10585,11 +10585,6 @@ static int tpacpi_dytc_profile_init(struct ibm_init_struct *iibm)
 				dytc_mmc_get_available = true;
 		}
 	} else if (dytc_capabilities & BIT(DYTC_FC_PSC)) { /* PSC MODE */
-		/* Support for this only works on AMD platforms */
-		if (boot_cpu_data.x86_vendor != X86_VENDOR_AMD) {
-			dbg_printk(TPACPI_DBG_INIT, "PSC not support on Intel platforms\n");
-			return -ENODEV;
-		}
 		pr_debug("PSC is supported\n");
 	} else {
 		dbg_printk(TPACPI_DBG_INIT, "No DYTC support available\n");
-- 
2.40.0

