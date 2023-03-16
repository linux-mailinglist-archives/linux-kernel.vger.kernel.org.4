Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B572E6BC659
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 07:53:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229873AbjCPGxC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Mar 2023 02:53:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229501AbjCPGxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Mar 2023 02:53:00 -0400
X-Greylist: delayed 259 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 15 Mar 2023 23:52:57 PDT
Received: from out203-205-221-202.mail.qq.com (out203-205-221-202.mail.qq.com [203.205.221.202])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 061845FA61
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 23:52:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1678949574;
        bh=Tcw+Uaz4jmYJYTEGQ3g1Ymn8QjyG70IsgsaexHt8djA=;
        h=From:To:Cc:Subject:Date;
        b=NLDkEsih0R+7rO9I1NCC2NnvJMmBI6AMpgdzmYSapn/tlsHQboD2BZRDm+iVJTIYJ
         UhVS4L0qYXRJpNk5kAFizK1+jFXsnooWTjQtLaupY78VYw3SRdqYu5tdOxZfHeyT98
         GJ6H8XGoD283MuHVkfEPLKUU/ciVUkKfliDCE7WE=
Received: from localhost.localdomain.localdomain ([219.238.10.2])
        by newxmesmtplogicsvrszc5-0.qq.com (NewEsmtp) with SMTP
        id A008F881; Thu, 16 Mar 2023 14:40:00 +0800
X-QQ-mid: xmsmtpt1678948800tuc59ps8v
Message-ID: <tencent_F0BFF85BC7C1FC84E440A7B7D364D2ED4209@qq.com>
X-QQ-XMAILINFO: NItgtg8VQuv+u93fN1PFS96KirnG7gsW9RKrBuGi7M3ehQ4WN+tRGW+PSflOWt
         MrGn2M9QbJkqFp3H/LOKf10W03KOWv8Dmdp4CimTMGvIFL5I2tDtFfm9kMmNKV1498fhaiehz/0r
         kcukkKpDxaL4PiIr91DWWGvVBn5VAuPRIfBuYReg0NmOTR6/1GKvHC7r7jYQiIfqlwxlikSpztcY
         x/Ah3aM31gp7YYC4BTArvlTvhOT+UX1pDAJMc6rnyKEo/UVOELz8RrkhyPatBqgzR5FwVxx7s8Cv
         Y4xkCIuG49SxGQjTjL5X1FpGDekwuqgeKZP2EYvJ5SSE76E03Ozggai0ZwitEscQkdajv1YYDnMN
         9AHU6+YxoFARJ2e4VKDO3xekeyG9B60y2NjqAAb8EPZXZxymj1yBkDfr5bCFjHxo5+dG4LEH1ViO
         BEWyLBan7/PGGwlGa45Blq/5h5nAZTCKjeetzyAzYqP3GvUdY4JTgJQpSVXOdivgs6G1JAFoZ7xS
         bPfTIdKZn7CSEk+CRbF1e/B45dA5juGvjvontZ/y6qFuCVtylJaJ4JU3oTJYoxWEtgtBJDOeNQUl
         CPqdxABibnlh64Hq81MvQF7JbRXDRS9JNCOcnpzzyqdC685vVQkMWXe6o1ixHybPe3iIhuac/iK/
         U4Q0+wvXBqWTPkpBHh21wFTxvAhjUK/D3D5rh2ZzOcw2DnWY/Q/hmSQj8RFIV2kcMxG25kTnSCjm
         WMOnOHuTW+w97DcGZ/EHzPJPH1FaX6qmNX+QjG6Ril/YRRxMTHsQg+jxRUokrCXiKXcPejcR2PRk
         H5mglI3IqgiDiV9UkbOenBeoFNlTDxuyxwxR+IYCUBgG3BFpBehE8yyq+QAMxN9zzVoTOPBGsi2Y
         Z0VnjvufM7wr3bB7xHUQSi6uRzi4nkb1ePL6dp5gb0RrfgFXVn0QKBTFrK9gD5B2ze1MAgQcVHnL
         j9AcDroFdg3lMU5rK81RFiBZX+03K+
From:   zipeng zhang <zhangzipeng0@foxmail.com>
To:     minyard@acm.org
Cc:     openipmi-developer@lists.sourceforge.net,
        linux-kernel@vger.kernel.org,
        zipeng zhang <zhangzipeng0@foxmail.com>
Subject: [PATCH] char:ipmi:Fix spelling mistake "asychronously" -> "asynchronously"
Date:   Thu, 16 Mar 2023 14:39:58 +0800
X-OQ-MSGID: <20230316063958.30417-1-zhangzipeng0@foxmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,
        RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a spelling mistake in the comment information. Fix it.

Signed-off-by: zipeng zhang <zhangzipeng0@foxmail.com>
---
 drivers/char/ipmi/ipmi_ssif.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/char/ipmi/ipmi_ssif.c b/drivers/char/ipmi/ipmi_ssif.c
index a5ddebb1edea..1a85b400e929 100644
--- a/drivers/char/ipmi/ipmi_ssif.c
+++ b/drivers/char/ipmi/ipmi_ssif.c
@@ -1283,7 +1283,7 @@ static void ssif_remove(struct i2c_client *client)
 		return;
 
 	/*
-	 * After this point, we won't deliver anything asychronously
+	 * After this point, we won't deliver anything asynchronously
 	 * to the message handler.  We can unregister ourself.
 	 */
 	ipmi_unregister_smi(ssif_info->intf);
-- 
2.39.2


