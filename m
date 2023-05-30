Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C88E8715BB3
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 12:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229920AbjE3K1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 06:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229755AbjE3K10 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 06:27:26 -0400
Received: from wout4-smtp.messagingengine.com (wout4-smtp.messagingengine.com [64.147.123.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C735710EB
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 03:25:38 -0700 (PDT)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailout.west.internal (Postfix) with ESMTP id 040F63200932;
        Tue, 30 May 2023 06:25:37 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 30 May 2023 06:25:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=sakamocchi.jp;
         h=cc:cc:content-transfer-encoding:content-type:date:date:from
        :from:in-reply-to:message-id:mime-version:reply-to:sender
        :subject:subject:to:to; s=fm1; t=1685442337; x=1685528737; bh=AG
        k4n3SGiqeevpI9FxzEEYvh1uhlOZ6fFwDSJrqySoI=; b=gQDPuNKfdOUu5CSOsl
        jQvrCmYuJsFVBba1N1uuGvjkTD2+tQyB9XgqzpmI+bgmS14CvPYlCUYFJjaFDNs/
        nb4sL/s3mENrVX662Ss8eNTAZbJ6KB/0yNg7GipWP7ylUc8CGkmxrmiWAvcosWml
        UdPaXazdZUg/lQ9VkhcdESe12kCVp0So6vZdgwMSOSnuKkF7AaU9TrZ6IAwo+2h9
        Gvqtex5xxu5WRwXXZKwa+tN25W00fdNbEj/GnLKEqmLKXLri75nWMiozKB0bKHaN
        4dAMDni5NukN6P1PzBGPK+43T2USUj4JYq3WP6gUd4QispltOVNpONRc0IJXFWCp
        r9eg==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:date:date:feedback-id:feedback-id:from:from
        :in-reply-to:message-id:mime-version:reply-to:sender:subject
        :subject:to:to:x-me-proxy:x-me-proxy:x-me-sender:x-me-sender
        :x-sasl-enc; s=fm1; t=1685442337; x=1685528737; bh=AGk4n3SGiqeev
        pI9FxzEEYvh1uhlOZ6fFwDSJrqySoI=; b=jBjodJHRRWGYQJ29mNkKiCxVkM5XZ
        CN4LUSzDeee48EbKHRI9Z/RTxxGGbij8Ab5qOhdDOmlxUj+twVOGwSHhtgRvAUn3
        4F4ojTu9xq1OASlB6ypq2twFUT4EwSfPA500pCV/YxEp9FpL+1DRiJwDzZc/lV7+
        DwTT0lxStQZfUQqxWdUqfc9320zdMaAN/5ec9EBAtmtsFInxY1TwXsfoF4uFiZrY
        00sWUApbsLnK3U9YTDwrZxim64VtgeEgw+caZJWnJKwpLcu2fhSxvVP+p7Bjjeq3
        kEC156W3heAeAsDr4HJsWJI6NGSuYgQQyXtueranr3WUpN0HvtlSpjCmw==
X-ME-Sender: <xms:Ic91ZNRGMx7s3ENJGaFX-Z3hEgr-4OacRMGTuJ6w3sBaf16pF64jhQ>
    <xme:Ic91ZGy83VgLQ2UWOF4_ekeRUOY9ZIET8caBiiytdplZM_dMlHwgSzWY0tR7hc_XB
    nepoaexn6pcKGvT5Js>
X-ME-Received: <xmr:Ic91ZC2aomCAez96-y2xa9rd9LcjjZAhQjiRfIBykOuCm1qJxAd8az__e6JNTjEo4F022XuWkwYnHYHNsHoyIzOjb7j9u99mLSsrA6-68FhWVw>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeekjedgvdeiucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucenucfjughrpefhvfevufffkffoggfgsedtkeertd
    ertddtnecuhfhrohhmpefvrghkrghshhhiucfurghkrghmohhtohcuoehoqdhtrghkrghs
    hhhisehsrghkrghmohgttghhihdrjhhpqeenucggtffrrghtthgvrhhnpeeggfehleehje
    eileehveefkefhtdeffedtfeeghfekffetudevjeegkeevhfdvueenucffohhmrghinhep
    khgvrhhnvghlrdhorhhgnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrg
    hilhhfrhhomhepohdqthgrkhgrshhhihesshgrkhgrmhhotggthhhirdhjph
X-ME-Proxy: <xmx:Ic91ZFB_H6iaHxNb1R7VCWpGF9wcIKRvhaP2yK1S7XLOGYyPmSQSxw>
    <xmx:Ic91ZGjZztvfb3aAX7Rjy8tCPAuezHs2vfveKkcWoDGHMnkMA3G4Lw>
    <xmx:Ic91ZJqdLItLLKWRWbcXWLfEBqinPyxm-slEqZBvJ5UYpPBVgR6Agw>
    <xmx:Ic91ZKYkCW7yaS_SzfVDTcm1YWNUynVB-53lx_srjr1_IajY2EtYmQ>
Feedback-ID: ie8e14432:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 30 May 2023 06:25:36 -0400 (EDT)
From:   Takashi Sakamoto <o-takashi@sakamocchi.jp>
To:     linux1394-devel@lists.sourceforge.net, linux-kernel@vger.kernel.org
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH] firewire: fix build failure due to missing module license
Date:   Tue, 30 May 2023 19:25:32 +0900
Message-Id: <20230530102532.56386-1-o-takashi@sakamocchi.jp>
X-Mailer: git-send-email 2.39.2
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

The added KUnit test has no MODULE_LICENSE even if built for tristate. It
brings build failure in linux-next integration.

This commit releases the test under GPL and fixes the bug.

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Closes: https://lore.kernel.org/lkml/20230530122450.1603af75@canb.auug.org.au/
Fixes: dc7c51638f46 ("firewire: add KUnit test to check layout of UAPI structures")
Signed-off-by: Takashi Sakamoto <o-takashi@sakamocchi.jp>
---
 drivers/firewire/uapi-test.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/drivers/firewire/uapi-test.c b/drivers/firewire/uapi-test.c
index c6ebf02e3d45..2fcbede4fab1 100644
--- a/drivers/firewire/uapi-test.c
+++ b/drivers/firewire/uapi-test.c
@@ -85,3 +85,5 @@ static struct kunit_suite structure_layout_test_suite = {
 	.test_cases = structure_layout_test_cases,
 };
 kunit_test_suite(structure_layout_test_suite);
+
+MODULE_LICENSE("GPL");
-- 
2.39.2

