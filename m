Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 677C3712B99
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 19:18:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242472AbjEZRRb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 13:17:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237404AbjEZRRU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 13:17:20 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 908BA135;
        Fri, 26 May 2023 10:17:16 -0700 (PDT)
Received: from compute5.internal (compute5.nyi.internal [10.202.2.45])
        by mailout.nyi.internal (Postfix) with ESMTP id F3DCF5C012E;
        Fri, 26 May 2023 13:17:15 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute5.internal (MEProxy); Fri, 26 May 2023 13:17:15 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685121435; x=
        1685207835; bh=RNFRaulRZtonrbQIqKCzQ4tfrIbNodUWfk4Zt2pE2sM=; b=D
        +4f5aGhaiKIMIqVN9RVsftqZu1j9FU8KVq+IHarrm7JYfwXjHU/k0ggckSufyYV5
        fP201O0Mpp347Qsz+ZQZ0CnYbyuYvbqXuTRgLNqMqN6R97jujnd5jADkvAnZznah
        vkYI3foLrEWfpExV7chzArDE4zbm+cGw4W3uJoznSrZtj+RdngvI3ZCUOdIMblwg
        /u1E9pDEOABUjWn9C0TSXT6bTwb3L4oSCpCBcvAHbwOSOj7ShqoVef7bk8BYmqv/
        cRhWDdjDAheEEnwe+F3bfZbJwvUL5y52azd1HvgM0Liq4K4jprJcrF6yfTPajG7t
        +b6THK0LQzkWWbtsCmNbA==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685121435; x=
        1685207835; bh=RNFRaulRZtonrbQIqKCzQ4tfrIbNodUWfk4Zt2pE2sM=; b=x
        5MAv+cUqHN67ZiN40Hnj+WczAv6yaqA5VNKYnUg9ST4F3Vqr+Kk+H8vkWJcgN/+4
        gaw3rTT0yMuFaI37HaI3JsDomePCtX3XyOyEo41WsltHk9kh00/G30kW0/GoXF/O
        Z3y7Bef1/PQI9P6Pfk6FmV+VltvbgXHyJtLtZPg2x3gLiuyKN83qx4EsYIgIetkL
        Bnl9T/u7hRsJ2i89Ry2YhiVlhif0drLqsAR97V9g8xJa09NGN4nNvzIt8zygiuAR
        YY8RVuO1/r6MQm5ze0MrH/wAna5Y+jECc9xUlSGw0C3diW43Lk4X6L7B7MzjhBil
        COSb9kIflZf2qOaIN/8sw==
X-ME-Sender: <xms:m-lwZN8vqFmdEk0C6F8z-0alUokGNZIT5E5NU-LTIfLLxa3h9h97GQ>
    <xme:m-lwZBvYKBOLrNc5cFtGw0Gbkzfmo88-uMUsQ0rx8zNwU7taBBbJdSby94x03hOhi
    d3bTlkt6hoSOrEiph0>
X-ME-Received: <xmr:m-lwZLCd0HRWOuKBELb32kg70NJMFyLQZ9Wn3C_Cq3icanR6IJloj6p5Lcij6TGZjCwVCKp4e9i6F2t0TYl98ql4HshaNpduQCD7J8vLvkEDT1cAt6m1w39-5Q>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeejledguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:m-lwZBewom22fUBze1Bb8pBZui7Do__BFEsW1jtnEHv7ngTei8RY8g>
    <xmx:m-lwZCNo8Vsd0i9ON3oihQj7YRzMGYnLYuX3D0JVcELwYNBbK2kfDg>
    <xmx:m-lwZDllg-RCtefWxL4Oi3k9d6gs5HIqouy24TuKPzfArTeVgIixWQ>
    <xmx:m-lwZPrYs_7DIxMEgc9NzjM7ziGDI8sE5tIJeZz02oj9WY-8Ra4xdw>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 26 May 2023 13:17:15 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 4/5] platform/x86: think-lmi: Don't display unnecessary authentication settings
Date:   Fri, 26 May 2023 13:16:57 -0400
Message-Id: <20230526171658.3886-4-mpearson-lenovo@squebb.ca>
X-Mailer: git-send-email 2.40.1
In-Reply-To: <20230526171658.3886-1-mpearson-lenovo@squebb.ca>
References: <mpearson-lenovo@squebb.ca>
 <20230526171658.3886-1-mpearson-lenovo@squebb.ca>
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
Changes in v2 & v3: None. Version bumped in series

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

