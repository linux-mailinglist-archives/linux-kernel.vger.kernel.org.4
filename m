Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F2EB71F368
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:06:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231838AbjFAUGP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:06:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231605AbjFAUGD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:06:03 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7ADC7133;
        Thu,  1 Jun 2023 13:06:02 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailout.west.internal (Postfix) with ESMTP id 9F68632001FC;
        Thu,  1 Jun 2023 16:06:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute3.internal (MEProxy); Thu, 01 Jun 2023 16:06:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685649961; x=
        1685736361; bh=rsnvI6ZEp/JoaUhAmxQlv079Dx9MuMsySoRPjlJZ+pM=; b=K
        FF8XJIVr5n6Lz38MWifQ9Tdz7OCINt4PZoioIkSQi3a2sY/e7pRQ1rBpUfS6FetT
        iUG4CpcffnXIdsuth/mdBIl0vWUJ7gT1Kh4RgEbVb6l+RpPHulPoEzKk8YC7m/02
        bsC5xk/n2/tU2ZzjPdz2T9tazzPpKeMfD4ORSXSPIMCb7Zn1nrFRiB5laSOy4OPR
        UJv3MzYE0L167rQrDNMWLLx2ZzFAvIvEaqfe8SdajUyw92FBYD9geit/NTbG/qC/
        voLHWOkw/1oMHaMHxMVGQbPCblh8EXYpOF5lDuF1/0Mrtbc0CzjiWK5dVDaa7ta0
        AUz/8bHXWVacy+qghE+qQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685649961; x=
        1685736361; bh=rsnvI6ZEp/JoaUhAmxQlv079Dx9MuMsySoRPjlJZ+pM=; b=x
        prHedPveuDoLuTck2jbZWnGzbszvRSALvtisZ5K4ngeeQY0GJF0ofMXjugrWt2EP
        Kck52VghWMj2sNZLgWJdl2Ggxjr6XTHV6ess96QaYx5PEuivM6urr7mXfEcmbWNM
        0sB8l509q2kAT5oCRkMqUz+dc/BY6Agq1LuGTyxVGK0b9IQByu/TIl3kCoo7kzOR
        fpleESsAQ8Gc+MM55UkD0vTiGGpvv9bBzxQ91dxAzqdnu6DP3Sl8L3DQsVWYBx03
        DvBqCAXp+Bt5IyOe6aPi5dHAuhqljKP1zG7g9mJ1jhhYrjGCfrZ0TPeua1l5QWC+
        0UKTE7sOXsJ5IaamU2ofA==
X-ME-Sender: <xms:Kfp4ZGHbAIGpMRpnEyH6DG9rTjuz_JnLYw8UIPGBDiXG99eeVc3Q2w>
    <xme:Kfp4ZHWq2FVYLe5Y9oBILdonihGx2xxBIvTNhdAS9ZuS1XSu-QmdgeYW5PlHeKl8Q
    1GkZqp6RTbiUleAPrg>
X-ME-Received: <xmr:Kfp4ZAIKosfbsIU1OrMHe5c5ko8l6VFT0vzPNzkFSANlEaQdePyi1-5WzASa9t7X9xhf0hu_7zhbHdWtcupvKX8de_ExdTIUST3jTPw0vegoYC3m5Eb536Z4ag>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgudeggecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:Kfp4ZAF7t88LCE_dBO6X4Z0Cit9u0EhEryS1LR_EzpyY7WShS-GRsg>
    <xmx:Kfp4ZMUJ0siPu7r8AnPwpgX3GRBSS5oX7fS2OfCn3E4X8ipuGNhSNA>
    <xmx:Kfp4ZDPDt450MI5AXi7OwIGwil3KCwFU_kCOMCgJmAP4nDzPR3WssA>
    <xmx:Kfp4ZKz5l1bBJGth7lEGVfasTe0a8M9pFxKrHZDf0vDMQc4ZlcIkbQ>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 16:06:00 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 4/8] platform/x86: think-lmi: Update password attribute comments
Date:   Thu,  1 Jun 2023 16:05:48 -0400
Message-Id: <20230601200552.4396-4-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230601200552.4396-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20230601200552.4396-1-mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add comments to clarify what the different password attributes
are (as requested).

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v4:
 - New patch split out from previous patch #2.

 drivers/platform/x86/think-lmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index f6d1931540f1..564e3fc33cfb 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -169,11 +169,11 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
  */
 #define LENOVO_CERT_THUMBPRINT_GUID "C59119ED-1C0D-4806-A8E9-59AA318176C4"
 
-#define TLMI_POP_PWD (1 << 0)
-#define TLMI_PAP_PWD (1 << 1)
-#define TLMI_HDD_PWD (1 << 2)
+#define TLMI_POP_PWD (1 << 0) /* Supervisor */
+#define TLMI_PAP_PWD (1 << 1) /* Power-on */
+#define TLMI_HDD_PWD (1 << 2) /* HDD/NVME */
 #define TLMI_SMP_PWD (1 << 6) /* System Management */
-#define TLMI_CERT    (1 << 7)
+#define TLMI_CERT    (1 << 7) /* Certificate Based */
 
 #define to_tlmi_pwd_setting(kobj)  container_of(kobj, struct tlmi_pwd_setting, kobj)
 #define to_tlmi_attr_setting(kobj)  container_of(kobj, struct tlmi_attr_setting, kobj)
-- 
2.40.1

