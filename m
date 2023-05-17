Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D779070709A
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 20:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230011AbjEQSUL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 14:20:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229775AbjEQSUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 14:20:03 -0400
Received: from out2-smtp.messagingengine.com (out2-smtp.messagingengine.com [66.111.4.26])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E27201708;
        Wed, 17 May 2023 11:20:01 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.nyi.internal (Postfix) with ESMTP id 5A1995C00CF;
        Wed, 17 May 2023 14:20:01 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Wed, 17 May 2023 14:20:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1684347601; x=
        1684434001; bh=+82eXvQj/5RebZRCTI0l45z9r2QlOLsinwQcEFJrwa8=; b=c
        cAn1S9xi5hKJORFlrRzdSxw9wBU18ZAr2cHLoTvZHd1QmNEmYDSegPDVMX+WeGO3
        pqYDicdACEsmJ4HYI3p3LkTf+IqGJZA9xFPhu2enhspXNiAa55hc2Oc3G2GDIv+p
        noZZ60T3YQv1vPkGz6I/KxLTR29pFNCsU42IunRk7mqmXOHax5DKAXP88JLVGkfA
        FFfU6vDM8EIjVYzmsq7Xv2BlBiTdsnP1S67UFYC+/+7B+lXk8ThfKVxd1eiK+vqf
        yfkzm6v+BHAH5b8KOYicNi89WygrbJjHuYcA3aGedUJ956QDU3RcVOqsp4VFyXtV
        5qHTsJ9LrNMsaAhmFc3VQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1684347601; x=
        1684434001; bh=+82eXvQj/5RebZRCTI0l45z9r2QlOLsinwQcEFJrwa8=; b=h
        HVnbXq6wQRbOxW8gXAqCpZ2hAT6GLFTzfWxX/9dw2DLRYqYCbF1+LnzhXZS2eav5
        otz/SE0aun5qV1pJBPpfi/wjSdJze//ASz6SD6yAUZlKxKDxa1n6dOLHPY0j4656
        N28CdbHkHR67zGe6Gw6fhMeuUvDFWZ9vi/MecaCjvyEl5W7ZJJcRKXIYbbH7T2tz
        jTLT64jyDqQt1BtVVFRDr0jrtZ63gSupre+KgxTR2OQ74Zv1aFQeV+A3xVjUuJtX
        j0uVyXAxcnNgWbMdMFUf16oFf9DbQjCd/eQL+IV1QEgofqn7M+CaA24v9FFzKBUs
        TQSvbDGOHfHv1LM7C86MA==
X-ME-Sender: <xms:0RplZBrjowRY7_ur0I7PStcwANtOzboQds9Tb85SvzhdNI2P3bO7AA>
    <xme:0RplZDoqv2d8mmvy0purLnDNQCwRR5kQLPVLzHjejuqAQaM_kaY67fxEPirw6lTnJ
    Mkg1BReqAFWVEGbptI>
X-ME-Received: <xmr:0RplZONuLR30yM88Hxt9kbgqRpzwQJwhxCUZgypHxy_JhJXpEwXmdCpirD_aULlH4_7JkbyYyR9bR32a-A0Gy5cL-wtMPS0BCP83clr0TZQUiB5LWHhL7eN6tA>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeiuddguddvfecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:0RplZM6UH5aN_kFWioEVCO7y9-3z9WZ_yTx0WUoO0mJ2EAHZtzznoQ>
    <xmx:0RplZA40T1nsLgq2INnVW2mPfzTX1cjLGilgSQZWY9z4uLvLtVXUdA>
    <xmx:0RplZEhaTNHk2SiwDn4SuaEVi-lxwm1PC8jTtbEX_592riA5O5PK4w>
    <xmx:0RplZOnA-hBeCoQVkMmCDY7OiqmUFUkbz4vHgj3nNgP-iwY-R4uqQQ>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 17 May 2023 14:20:00 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] platform/x86: think-lmi: Don't display unnecessary authentication settings
Date:   Wed, 17 May 2023 14:19:45 -0400
Message-Id: <20230517181945.3725-4-mpearson-lenovo@squebb.ca>
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

If Opcode support is available (which is the standard for all platforms
going forward) then there is no need to have the encoding and kbdlang
attributes visible

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
 drivers/platform/x86/think-lmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 2d95b1a199fa..46500707f939 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -879,6 +879,12 @@ static umode_t auth_attr_is_visible(struct kobject *kobj,
 		return 0;
 	}
 
+	/* Don't display un-needed settings if opcode available */
+	if ((attr == &auth_encoding.attr ||
+	    attr == &auth_kbdlang.attr) &&
+	    tlmi_priv.opcode_support)
+		return 0;
+
 	return attr->mode;
 }
 
-- 
2.40.1

