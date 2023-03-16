Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1CCC76BCCB7
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 11:26:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbjCPK0M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 06:26:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231219AbjCPKZu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 06:25:50 -0400
Received: from out-7.mta0.migadu.com (out-7.mta0.migadu.com [IPv6:2001:41d0:1004:224b::7])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C02726C13
        for <linux-kernel@vger.kernel.org>; Thu, 16 Mar 2023 03:25:32 -0700 (PDT)
X-Report-Abuse: Please report any abuse attempt to abuse@migadu.com and include these headers.
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.dev; s=key1;
        t=1678962330;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding;
        bh=T0LlouiaaJCTY/nLAMjlbcAIUIL3clukrpmqFl+EWEM=;
        b=K7vZrmd9NSQH98rEGOA5fodzxyTtiD+/8p+ZujHULt4pTlKP9NRKQHFchH+vWDtMaZ6dMx
        orxdovPWJwwKjjECKyeSRxHzTQ24/5ZeM9tCm+Al0juPNRMVLcu9vM1+QyvxdNCYRujbdM
        DwzdH1WrWwvPAfOqkx3pr5MV0hHVwzw=
From:   Richard Leitner <richard.leitner@linux.dev>
Date:   Thu, 16 Mar 2023 11:25:25 +0100
Subject: [PATCH] mailmap: add entries for Richard Leitner
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
Message-Id: <20230316-my-mailmap-v1-1-76bc3a36ba41@linux.dev>
X-B4-Tracking: v=1; b=H4sIAJTuEmQC/x2N0QrCMAwAf2Xk2UDTQkV/RXzItugCto5ExDH27
 +t8PI7jVnAxFYdrt4LJV13ftQGdOhgmrk9BHRtDDDGFRBnLgoX1VXjGwPmSKJ4p0wgt6NkFe+M
 6TEdS2D9ih5hNHvr7X273bdsBUHcsH3UAAAA=
To:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Cc:     Richard Leitner <richard.leitner@linux.dev>
X-Developer-Signature: v=1; a=openpgp-sha256; l=1118;
 i=richard.leitner@linux.dev; h=from:subject:message-id;
 bh=kV9ErzOSMtvPVbrDIxkswd7IgZVUY3RBXY/NbWS8XSA=;
 b=owGbwMvMwCX2R2KahkXN7wuMp9WSGFKE3s1KDn48i32DR/Cc4Cv7tf9FpW+cFscUGJX3hOHujKdR
 S87md5SyMIhxMciKKbLYG3O1u+eWva9U1MmFmcPKBDKEgYtTACZi9JORYf7CL7f32Iu4BFszfpFP2s
 tz19WMY83zJs/u9um2eb7LGBn+Rzw4LKO4ac+lkPsGP5MYRHbwvwydY/+9LIpt2p6nDA3feQA=
X-Developer-Key: i=richard.leitner@linux.dev; a=openpgp;
 fpr=3F330A87476D76EF79212C6DFC189628387CFBD0
X-Migadu-Flow: FLOW_OUT
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Map all my old email addresses to my current address.

Signed-off-by: Richard Leitner <richard.leitner@linux.dev>
---
 .mailmap | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/.mailmap b/.mailmap
index 86a6307dd824..a442825fa9d9 100644
--- a/.mailmap
+++ b/.mailmap
@@ -384,6 +384,9 @@ Rémi Denis-Courmont <rdenis@simphalempin.com>
 Ricardo Ribalda <ribalda@kernel.org> <ricardo@ribalda.com>
 Ricardo Ribalda <ribalda@kernel.org> Ricardo Ribalda Delgado <ribalda@kernel.org>
 Ricardo Ribalda <ribalda@kernel.org> <ricardo.ribalda@gmail.com>
+Richard Leitner <richard.leitner@linux.dev> <dev@g0hl1n.net>
+Richard Leitner <richard.leitner@linux.dev> <me@g0hl1n.net>
+Richard Leitner <richard.leitner@linux.dev> <richard.leitner@skidata.com>
 Robert Foss <rfoss@kernel.org> <robert.foss@linaro.org>
 Roman Gushchin <roman.gushchin@linux.dev> <guro@fb.com>
 Roman Gushchin <roman.gushchin@linux.dev> <guroan@gmail.com>

---
base-commit: 9c1bec9c0b08abeac72ed6214b723adc224013bf
change-id: 20230316-my-mailmap-0a693127161d

Best regards,
-- 
Richard Leitner <richard.leitner@linux.dev>

