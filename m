Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1035707098
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:20:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229879AbjEQSUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229464AbjEQSUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:20:01 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CC2351739;
        Wed, 17 May 2023 11:20:00 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 3ADC95C00D4;
        Wed, 17 May 2023 14:20:00 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 17 May 2023 14:20:00 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1684347600; x=
        1684434000; bh=9To+EmgUW3U3bAfyN/Fi0ZyDnM5B92IoNonvDRNfTQ8=; b=u
        5pk54aREflRZ5sOV8yRRKYngyY/6zd12WwowW2vj4EAk//Je8pebyziVVrRpmg4j
        9egssOJCoE6nTubYbzkjpwiqb0HG8DgeazxZDPUCH9n6a1Vttt8P37GJOcTXozXc
        tDtLKHdBfmQ1diEj0ngtRDTLKlAMJuBGHv3mwtXlRl3G8A701BvXQYEoKSrydyeH
        5BuMpaxEVpETyQZZp6v4juoUPAYld/TmTonSgjqjizLWRdnwppMfqqImJvbgcqxB
        rzm7m5MNSQg8mYAvPH8td04UgX4V6tp1W97sSsDYZYYaejnENwnwoMv0fDphtpHs
        usNd93nBLP490FsucbCDQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684347600; x=
        1684434000; bh=9To+EmgUW3U3bAfyN/Fi0ZyDnM5B92IoNonvDRNfTQ8=; b=S
        m/C6R1uTVKzgLvmvfLIkXLdR4md3lK+TPEK3cLUc2SvjdRL7lVA0eUIAzYlBUU9/
        2Q7dtGHXtEl6JMekyhp2pKAY6kgq+K/Yvx4GWl6pYGZsUhnzU5THWDlZavaDGWEH
        LfAoj2PduHycBE6DzQTwzKRZK3D3DVhUmJeUYYrK8CCIHXqNezCnJSlsnjQb4u8Z
        YGa2qI37piBmfnMIo1n56TiwBCgV3r9IfPuFx1iTx9HNcgNf2BziiN9prdacWJbl
        Le4lMrL5UKgSiN4BusE1DH64WLIct88U4zceV3vo4sx/YPXSQjIBncOW99pFeJgK
        sRDYA/g4+qu2gCsPOLKbA==
X-ME-Sender: <xms:0BplZCmYHYAum0hYkleZPGFlXQeXO5d9KuGzwB4UWzdSq7jbw37e-Q>
    <xme:0BplZJ27ED_9JnMwCVaCQoFgHL0AkDTvQ2_SnzXPIIKb2R3R2ETK-e4vGmXUq0z_n
    tJz8nt-621n5DckMN8>
X-ME-Received: <xmr:0BplZApIy_Szj21l6mmysEqn55i_DLhe5d07BbcaYpsgSijov-6L1tJyZYFHJLLVgvCgSL4KkHSwMDY-5okaGUbG_YluFyLN-rTzH6NAnZzsvHc1bZIL8-z3yA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:0BplZGkUYjdnHN1DtRF-kkqslXtHO7kHY8BM7LaVkGjul8kN96lmhw>
    <xmx:0BplZA3LKM5XKg4maf5oZIielOKlKWGG5883ocVu_bzq1C_HbnFV8Q>
    <xmx:0BplZNu-rmTSPN3W3lkX11R_X647QML34LTaeduc5As4c_CwTds1aQ>
    <xmx:0BplZNwEYAMjCDzoGtt-m3eEScYv_mO2cDwfYkd6Ow9smPQvT7pxcg>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 May 2023 14:19:59 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/4] platform/x86: think-lmi: Correct System password interface
Date:   Wed, 17 May 2023 14:19:43 -0400
Message-Id: <20230517181945.3725-2-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230517181945.3725-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20230517181945.3725-1-mpearson-lenovo@squebb.ca>
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

The system password identification was incorrect. This means that if
the password was enabled it wouldn't be detected correctly; and setting
it would not work.

Correct these mistakes.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
 drivers/platform/x86/think-lmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index d9341305eba9..b8431d3b137f 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -171,7 +171,7 @@ MODULE_PARM_DESC(debug_support, "Enable debug command support");
 #define TLMI_POP_PWD (1 << 0)
 #define TLMI_PAP_PWD (1 << 1)
 #define TLMI_HDD_PWD (1 << 2)
-#define TLMI_SYS_PWD (1 << 3)
+#define TLMI_SYS_PWD (1 << 6)
 #define TLMI_CERT    (1 << 7)
 
 #define to_tlmi_pwd_setting(kobj)  container_of(kobj, struct tlmi_pwd_setting, kobj)
@@ -1504,7 +1504,7 @@ static int tlmi_analyze(void)
 		tlmi_priv.pwd_power->valid = true;
 
 	if (tlmi_priv.opcode_support) {
-		tlmi_priv.pwd_system = tlmi_create_auth("sys", "system");
+		tlmi_priv.pwd_system = tlmi_create_auth("smp", "system");
 		if (!tlmi_priv.pwd_system)
 			goto fail_clear_attr;
 
-- 
2.40.1

