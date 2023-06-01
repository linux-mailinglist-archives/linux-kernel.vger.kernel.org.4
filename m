Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E724E71F366
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 22:06:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231955AbjFAUGT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 16:06:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41410 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbjFAUGG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 16:06:06 -0400
Received: from wout2-smtp.messagingengine.com (wout2-smtp.messagingengine.com [64.147.123.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A6196195;
        Thu,  1 Jun 2023 13:06:05 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.west.internal (Postfix) with ESMTP id CF49A32001FC;
        Thu,  1 Jun 2023 16:06:04 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Thu, 01 Jun 2023 16:06:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=squebb.ca; h=cc
        :cc:content-transfer-encoding:content-type:date:date:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to; s=fm2; t=1685649964; x=
        1685736364; bh=Gu+WlP+2bsePT/P2fB0521Gn91OZaDLXsUxYcTQ73gA=; b=G
        CLKakvDROosoZIhS9uesLtHiY9/K2xF8wnhlA7pr72YLGFl4XMm9Vwpf8kU8YZ4w
        VLB4eWcz7DVNGF/wreqhbYtIm+kFDGmwNj6BMb715x+wIS+tLKxqI/XgeCeJ7G+e
        plfGTCbL5hCI3ygPcDSdGR5ftBUFqFvsuB6VlfU6WvYBGInAwPM+fiOQ6rbTY+WC
        YCsOGsLJO9pRylC+TTJgO8CFmY9PSlWG6JmtsKyPRqk2Q2bXAZ8Ix9F+3eYMSLd4
        jOoPD/EiUMo43YMLlHdL5+Eecrvqdcfpj4FUJxZUg7pjSEBFBPFd9Sz8Z5QbANNy
        U+t3QjZ3G8jEtCkGTFnPQ==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:in-reply-to:message-id:mime-version:references
        :reply-to:sender:subject:subject:to:to:x-me-proxy:x-me-proxy
        :x-me-sender:x-me-sender:x-sasl-enc; s=fm1; t=1685649964; x=
        1685736364; bh=Gu+WlP+2bsePT/P2fB0521Gn91OZaDLXsUxYcTQ73gA=; b=u
        iWm9XttH9QCd4fTbstd2YQ8a81N5ltimJSHXQEryNcSEoAEK42t0BijgHYKp3wC+
        1KEnkoh4ZHfAS99NfNG3Jx7cPwGFBcr6L65ARWvqg2SxoWs9SQpbiQUlXlVKoZ4t
        UwUG1ZN/YwkXFmXOYjGOB2tK5Q0qIIRwvEBo0LKsuuRdMzgDpCRcMBRsEJQG/YiN
        zt3hKlf8yB9nRu/6WIcKt6bwNJVRC61Wdyk4JCgXq9a+7riEjj8LWvZqUWAd6hTM
        4qt6EQAV13GF/nIXGuIdqfmDCGRLu7JdzsHOLAKFxlowVKbKGR7fOgSZmaTQVoGi
        fx7OELSOEpNhB9At+50kA==
X-ME-Sender: <xms:LPp4ZIdACL8kIvLUE097kgeBn0MJc32lYv_aIfIRnBMPm2mhxyjC_A>
    <xme:LPp4ZKPf5pZg8CmMEOA3j85UivgcuzNy2p_Fw2YS17E_vnFlcfCkK7bjrPAVJZbIW
    CNYYuNR_nanyA_15eY>
X-ME-Received: <xmr:LPp4ZJgC3ihmQ3lrubbw1cnwNqD26b3P5s61bExtMH4wA5U8usTXSYrtatfs4y94klalmhVtGrRIGe3NNYvEVITjw3LOpamzsWkZUu8LEKvd7LCujiYgvcoHzQ>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeeluddgudeghecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecuogetfedtuddqtdduucdludehmdenucfjughrpe
    fhvfevufffkffojghfggfgsedtkeertdertddtnecuhfhrohhmpeforghrkhcurfgvrghr
    shhonhcuoehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggrqeenucggtf
    frrghtthgvrhhnpeeftddvjeefleffvefhgfejjeehudetteeigeeugfekhffhgeejudeu
    teehgfdvffenucevlhhushhtvghrufhiiigvpedunecurfgrrhgrmhepmhgrihhlfhhroh
    hmpehmphgvrghrshhonhdqlhgvnhhovhhosehsqhhuvggssgdrtggr
X-ME-Proxy: <xmx:LPp4ZN8W31VoVtj1LZtUkNFLXLci45qd3PveXLBFKoawO-jjY0qjaA>
    <xmx:LPp4ZEvbYLIZ4Ncw8Ra1Pf0Q9d0VG1BLs2KQ2tTMpZ3WX2HqAmm71Q>
    <xmx:LPp4ZEFdTawHiCdBeN53wu5b2hRAlE8qaWKTpXjhiXlScraAcHqd9Q>
    <xmx:LPp4ZGJu3N17KHlYtN3_N__Es3nxUuZ4b5Y7JgTetXHkYUn_Epmm5Q>
Feedback-ID: ibe194615:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Thu,
 1 Jun 2023 16:06:03 -0400 (EDT)
From:   Mark Pearson <mpearson-lenovo@squebb.ca>
To:     mpearson-lenovo@squebb.ca
Cc:     hdegoede@redhat.com, markgross@kernel.org,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        ilpo.jarvinen@linux.intel.com
Subject: [PATCH v4 6/8] platform/x86: think-lmi: Correct NVME password handling
Date:   Thu,  1 Jun 2023 16:05:50 -0400
Message-Id: <20230601200552.4396-6-mpearson-lenovo@squebb.ca>
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

NVME passwords identifier have been standardised across the Lenovo
systems and now use udrp and adrp (user and admin level) instead of
unvp and mnvp.

This should apparently be backwards compatible.

Fixes: 640a5fa50a42 ("platform/x86: think-lmi: Opcode support")
Signed-off-by: Mark Pearson <mpearson-lenovo@squebb.ca>
---
Changes in v2 & v3: 
 - None. Version bumped in series.
Changes in v4:
 - This patch was previously #2 and is now #6 in series.
 - index default change split into new patch (next in series).

 drivers/platform/x86/think-lmi.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/platform/x86/think-lmi.c b/drivers/platform/x86/think-lmi.c
index e3be99b44ce0..71bbe169c77e 100644
--- a/drivers/platform/x86/think-lmi.c
+++ b/drivers/platform/x86/think-lmi.c
@@ -461,9 +461,9 @@ static ssize_t new_password_store(struct kobject *kobj,
 				sprintf(pwd_type, "mhdp%d", setting->index);
 		} else if (setting == tlmi_priv.pwd_nvme) {
 			if (setting->level == TLMI_LEVEL_USER)
-				sprintf(pwd_type, "unvp%d", setting->index);
+				sprintf(pwd_type, "udrp%d", setting->index);
 			else
-				sprintf(pwd_type, "mnvp%d", setting->index);
+				sprintf(pwd_type, "adrp%d", setting->index);
 		} else {
 			sprintf(pwd_type, "%s", setting->pwd_type);
 		}
-- 
2.40.1

