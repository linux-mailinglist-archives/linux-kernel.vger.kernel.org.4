Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D97A071F36C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:06:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231376AbjFAUGc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:06:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41430 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231669AbjFAUGR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:06:17 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 049361A4;
        Thu,  1 Jun 2023 13:06:09 -0700 (PDT)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailout.west.internal (Postfix) with ESMTP id 28A5A32003CE;
        Thu,  1 Jun 2023 16:06:08 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Thu, 01 Jun 2023 16:06:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685649967; x=
        1685736367; bh=o+3ik6sPv/8JEzwolLx/y3xpaXAaNLnim4nqn40eZqA=; b=a
        s5b4FENdBlIJPyV69bgZMeNamdRI+ULrDkC6tZj9i0kswy/gG2OKlbJMHX6YT+SV
        Umx7PM++fNj/74SEHbHhvJNFjnYRwdLyT06O3IUOLA1XCjqjyQ6AZstPv7t1zFY3
        RdQ0KfW3yMH/3vcUPB1bBCOPOaiJ496vjInvx5b/pxR+yxf8MCq+uxHkdY6O1Spy
        QwdUQytjgjwm03xVEGvaJNNUb+LPL4NEXyoqavSGoQjULu371MYrsH0+WWrVgt6w
        fkoxGw2WTAeTa9cxPd6UoHAS00J8Nc2Re9b3OBs7jn4hx9kkCVKuUDjWSNJPSmAx
        hpd1/CjnPo7jOxWMxjRFg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685649967; x=
        1685736367; bh=o+3ik6sPv/8JEzwolLx/y3xpaXAaNLnim4nqn40eZqA=; b=p
        IDHkdtbEH3euih4Dchnq0FAnUTsq2/5I09VaSTZ7c2TEed4gMy8rq6bcVVFfPTqL
        oE4ntgKrAQ3gaLgIvTbqisueyUSeY3fsFVIL5/p+ZD+ffpAy2BC5bXqQLX0JJiIZ
        ppJMf3HGBA2d6PrtqAYl4hsUvGOAw/Bsgvlhf2qyKV5diUmZBogxT2u7RjWvCalG
        4qy0y+tmm+b9srBGG35i4jjrlNeNQt0gAeYGPTolOit0IP8Ylq/vrucAe5NuZgIb
        eHLB9gCDWIdFG52Qy0vbAxjFrBs6djIFahYePyhbvPGAab3gxfpQhMluZNXg3kYC
        PscbR+nCFvHr/mC4MkSVw==
X-ME-Sender: <xms:L_p4ZD2ivhL0Mp-GDz9pT4QLxIvN-3J2oRCFVDnHCHl6RTHUsQBwUQ>
    <xme:L_p4ZCH-H_-29VhowhpbEuwkWXzL6Q4luzG69JLMlYi9ETakM5LMSrgd270mhIiH-
    b-NFnjrJCeRRSc5gL4>
X-ME-Received: <xmr:L_p4ZD4yvTo_-3MQYirgDHfpY4sbPCOT_N9DJyEr7noR_uIcgHRYNtNq2PZzw63CwRdlKd6VDHqwo2yOTtv6J9o5F1mmLpH02vlTLFIhc6Mpxx0d86avNobw6A>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:L_p4ZI2EvVdLLWtHO_Neu6yud332iK2BW4TIoXTr6yqrEtmiB8yOdA>
    <xmx:L_p4ZGHiB1Wu-bL6iCQWe35C4UWn7WGyjf0uxfjPeD_al2x2mfCz9A>
    <xmx:L_p4ZJ8lEZrteTORX84w2Kp4EUK_d7MNKTxc9cWQ2DkuUIdlSZBhEw>
    <xmx:L_p4ZChtm1x2XSVnv4EFTF60DEWkUnYKJrduV9J0_JusKKun7mqS6Q>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 16:06:07 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 8/8] platform/x86: think-lmi: Don't display unnecessary authentication settings
Date:   Thu,  1 Jun 2023 16:05:52 -0400
Message-Id: <20230601200552.4396-8-mpearson-lenovo@squebb.ca>
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

If Opcode support is available (which is the standard for all platforms
going forward) then there is no need to have the encoding and kbdlang
attributes visible.

Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v2 & v3:
 - None. Version bumped in series.
Changes in v4:
 - Fixed code alignment as requested.
 - This patch was previously #4 and is now #8 in series.

 drivers/platform/x86/think-lmi.c | 5 +++++
 1 file changed, 5 insertions(+)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index 2aaaee879488..52d1ce8dfe44 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -885,6 +885,11 @@ static umode_t auth_attr_is_visible(struct kobject *kobj,
 		return 0;
 	}
 
+	/* Don't display un-needed settings if opcode available */
+	if ((attr == &auth_encoding.attr || attr == &auth_kbdlang.attr) &&
+	    tlmi_priv.opcode_support)
+		return 0;
+
 	return attr->mode;
 }
 
-- 
2.40.1

