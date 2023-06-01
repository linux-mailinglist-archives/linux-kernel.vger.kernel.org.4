Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A8C571F36A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232031AbjFAUGZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:06:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231724AbjFAUGI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:06:08 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FEE919A;
        Thu,  1 Jun 2023 13:06:07 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 856AE320091A;
        Thu,  1 Jun 2023 16:06:06 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 01 Jun 2023 16:06:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685649966; x=
        1685736366; bh=dxVy3ktA+8k714kk6B+Z5XPnFHTfcK197zZKcwM4lPc=; b=L
        va76V+N+KAZ+6lBIWyzeIKPpaIFxFTDx7itudSnVXPv8WulpZXbFWT1cDdYeuTK7
        WIwjrmsKFmlztMmlhWz4YK+7b4uNWC1mK77aUtJAHtGdFPoU8LMVEOjFGX1FuLux
        XY9dzSdHL5apB8AAY49Cdl1ow03e54l4qACQ6QXUpeiOZT6CiHOxER6z68tmD7/z
        rrntV+fm9opTs25YBRefT4bZg9kRh18XcCjX5HaH9ym4Rr8qdsYo8XWl0BYm/9Zz
        xC1pRTXge8lyLEVzxHBboj6xEuzPmysZ6FpAcD83hTIB7tYEEx/sJDasp2rD/PDS
        AMNvFzw8V0nfZk4KZFHLQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685649966; x=
        1685736366; bh=dxVy3ktA+8k714kk6B+Z5XPnFHTfcK197zZKcwM4lPc=; b=L
        nAG8HDYpRtkNtq1K2UW0LLzpc693JnHIhQkMF3+HRjGZTzuG/vBjBsjmhrQMuIrw
        2XwsJNbJOUwcIeALitkKSXoOsH6EbYK2xsoHZ8Pk5PxzOW39gM0cFHBb5gYs2xBz
        R8omuJTbUf4Nx+qc5TzCfhHGiQiccX5nMJilZIpzonDyaPcVlo6PHafeieyczOab
        UQ3zyywGD4OKHfv09dUb/3yN8h+F4uhVertPp1F7NWoKEPb7dghoHMNCZQHDJLtE
        JBFPoVDarPz3JVoEUeTKpnM25DYl4tIPUM+DT8/MqOTGPeeY6Y69Bi5nrIfwQmOA
        Ec9eu95tAugsT2FnaDLGA==
X-ME-Sender: <xms:Lfp4ZP4NDQbq8AEeht1E0nErjn-P7-SAIznDtqQeupwIYAzIy9YBow>
    <xme:Lfp4ZE5FP8CdEjAays6Lef8D373hLRWkKtJ4p9CyTl8tvmH3MtpKU1TdVSOvU2E_a
    7azHgkB8sv5Dh9D4os>
X-ME-Received: <xmr:Lfp4ZGfufDJ3euyZ75cTtJxGrdFOogZQDzVy_VLM4dIYIoAm6vGb4VeTH3P3g9DXcrqJCSvR7DrGDLuvcn3WYiKk7RudAu9GO4Q8mfbMkt_wraXopsd_oH7tiQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:Lvp4ZAJ4ORsUrlWeiAHQwfwldKyQJZsQrZlE5-5dqZ2gN_CQZGqbwg>
    <xmx:Lvp4ZDKpZdNe34BqdDp-cJbUjzwBH8Y8Q4pl9MZLz3zRrHQ_kNfRYA>
    <xmx:Lvp4ZJySSi-l2K-EYdnGR5AYTpqm-zW91ssmvOzv1VpioJUe44lUGA>
    <xmx:Lvp4ZAHBJ7LOF_PgW6aWc-G6lMATG5uzzleI9847ltES1dSxGn02xA>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 16:06:05 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 7/8] platform/x86: think-lmi: Correct NVME index default
Date:   Thu,  1 Jun 2023 16:05:51 -0400
Message-Id: <20230601200552.4396-7-mpearson-lenovo@squebb.ca>
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

The NVME/HDD index used by WMI starts at 1 so corrected the default
appropriately.
Note, zero index is still permitted in case it is required on future
platforms.
Documentation updated correspondingly

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v4:
 - New patch. Split out changes into separate commit as requested.
 - Update documentation.
 - Details on zero index added to commit message.

 Documentation/ABI/testing/sysfs-class-firmware-attributes | 4 ++--
 drivers/platform/x86/think-lmi.c                          | 4 ++++
 2 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/Documentation/ABI/testing/sysfs-class-firmware-attributes b/Documentation/ABI/testing/sysfs-class-firmware-attributes
index 4cdba3477176..1b3ecae80b3d 100644
--- a/Documentation/ABI/testing/sysfs-class-firmware-attributes
+++ b/Documentation/ABI/testing/sysfs-class-firmware-attributes
@@ -243,8 +243,8 @@ Description:
 
 		index:
 					Used with HDD and NVME authentication to set the drive index
-					that is being referenced (e.g hdd0, hdd1 etc)
-					This attribute defaults to device 0.
+					that is being referenced (e.g hdd1, hdd2 etc)
+					This attribute defaults to device 1.
 
 		certificate, signature, save_signature:
 					These attributes are used for certificate based authentication. This is
diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 71bbe169c77e..2aaaee879488 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -1534,6 +1534,10 @@ static int tlmi_analyze(void)
 		if (!tlmi_priv.pwd_nvme)
 			goto fail_clear_attr;
 
+		/* Set default hdd/nvme index to 1 as there is no device 0 */
+		tlmi_priv.pwd_hdd->index = 1;
+		tlmi_priv.pwd_nvme->index = 1;
+
 		if (tlmi_priv.pwdcfg.core.password_state & TLMI_HDD_PWD) {
 			/* Check if PWD is configured and set index to first drive found */
 			if (tlmi_priv.pwdcfg.ext.hdd_user_password ||
-- 
2.40.1

