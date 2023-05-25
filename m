Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290BC711789
	for <lists+linux-kernel@lfdr.de>; Thu, 25 May 2023 21:42:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241382AbjEYTmd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 25 May 2023 15:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240262AbjEYTmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 May 2023 15:42:31 -0400
Received: from out3-smtp.messagingengine.com (out3-smtp.messagingengine.com [66.111.4.27])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13472E62;
        Thu, 25 May 2023 12:42:06 -0700 (PDT)
Received: from compute1.internal (compute1.nyi.internal [10.202.2.41])
        by mailout.nyi.internal (Postfix) with ESMTP id 2F33A5C0078;
        Thu, 25 May 2023 15:31:38 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute1.internal (MEProxy); Thu, 25 May 2023 15:31:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685043098; x=
        1685129498; bh=MfKBhMsQHnw3DcuLqhPdvyi5pANzNQBNxlUGbArluSQ=; b=N
        zjwyF8/NZVcWC9raID22jjq1rEnuRXJgOz+KOLpSP81sNLD5JUzIXUdDXqYu/tpY
        OUehGu/GhsEqWXmCOGwkU+GE+LptCPsRcxXIbMxwEOgRwXpjxMFNcKvTyiLyJQBF
        vHDJOARp6yPN7ZzQh+/0Jx0MYmSpRUZloNnauEw9sx7YlIJN7W4RwtRVXQxePyAi
        zqFQuYKVdq8LELuOZOxCnQLsoTVlkYe/far1/yyUP1EPpiufXlCzo07rdqE7F1oZ
        3uaG/WJtSvglShPvAaDMY93/TgYQVuyFVT0J09fpL8VafGtC6E3ILAIkuIVRCOXQ
        5ZM4o3DuXnySTfaci/78A==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685043098; x=
        1685129498; bh=MfKBhMsQHnw3DcuLqhPdvyi5pANzNQBNxlUGbArluSQ=; b=K
        44SYzU4yCcDsy0bX7VZOQAsqpsaJPlfBB0YB4im6Z2PU/TWVmSPr1Bxly3OmTVr6
        eSlU93cNvv/hFPv3V2Moi7mVOrgicgJ7yrte7hk9a8ZTrKWhFujWazlSYB8Tbglf
        8VGRNT/o0RffZ+QXu6BXqc3XhHBAryW2+OuwavFwSieuZFWcVcB81cax20vTPZG6
        5326P2Oe81sD1nx6y8lqZmjNchLJehf1cJwO7Q65GptNLFoGXuG2S5nepyQtmgGc
        AEOFk6L1FIlivTx6jPhWyiUgLAcp1QiGYUoXcmGeJBjspuGgCZSl1ERfvwIwR6LY
        a4ziOURcy1X3lcs3E4Dwg==
X-ME-Sender: <xms:mbdvZEr0NvKHJ2VTIvlSVEXkyZMjjtI0fTN_wBT80EL2J3XkwxBO3Q>
    <xme:mbdvZKqbDimR_e5xVLI6XHPkqNz8Zz_3imdKUnFUnVP8nH_Nk0XsIaxs2Jd4zYHCQ
    dVuVqoYGi1Z8dLyBV4>
X-ME-Received: <xmr:mbdvZJNbK3-HxmETsSyIDX7l_JI5y6SwDcX2UZbK_POwPHDwO1ho5caD9RFBXZXOc8D3_zCVAZEmeBC6Ec2nXKTpwBg2_gZqb0cKclmYC1w0A8ieijXv_Kywqw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejjedgudefjecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:mbdvZL57I0TZj3tRQdLYkw7eYRJrZQ9m31VgaUVyIHklymLBni_nng>
    <xmx:mbdvZD4otPdBW7fCvFMcwRW7ajaahOCVXfq_RfwhW8XQYX13C1yGXw>
    <xmx:mbdvZLhy67FOpA005f3zdtgvxuxQQL8KVhgi8pVGxjAEpPiZ_clsAw>
    <xmx:mrdvZFl32u2nIdjxuC6itl2D838JBtexlCZYDx0Bn5nrQUWrUkDE0A>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 25 May 2023 15:31:37 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 4/5] platform/x86: think-lmi: Don't display unnecessary authentication settings
Date:   Thu, 25 May 2023 15:31:31 -0400
Message-Id: <20230525193132.3727-4-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230525193132.3727-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20230525193132.3727-1-mpearson-lenovo@squebb.ca>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
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
Changes in V2: None. Version bumped in series

 drivers/platform/x86/think-lmi.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 1c02958035ad..64cd453d6e7d 100644
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

