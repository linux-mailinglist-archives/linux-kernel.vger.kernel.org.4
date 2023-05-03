Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 635B66F523C
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 09:50:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229665AbjECHuQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 03:50:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229813AbjECHuG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 03:50:06 -0400
Received: from nautica.notk.org (nautica.notk.org [91.121.71.147])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23D9A44AD;
        Wed,  3 May 2023 00:50:02 -0700 (PDT)
Received: by nautica.notk.org (Postfix, from userid 108)
        id C67B8C01E; Wed,  3 May 2023 09:50:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1683100200; bh=STk00GLf3dBT1BAQ4Vfvpm/JgGYNx5KVfN2QOVrKrFA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=DKMfb6A+mPwlJYreZAWzsenvNYbD+7HreCiqg885fdtQRZtl3S3NADCPI0ZM8Gan4
         5tDoUWBg1xewb9q5c2U2H8kM3HdxegR7yKD4rmx7IX50xviDGIVULEHMBbKQfhp5ZJ
         +4EsZjnLv/mLikrw4Cdz90wYZEVAW4wZCNu+RJOPNEdw5Y0O7OEI0n1FP9C485PCvu
         aGByIMkiwW6RU7EdflBC9jA0nhDtElTIbdzLOHvpwL6tUb1XwFF9EOE4UuPCOl9qLA
         lGOX3KcgpDi3LOgYq6B8HbdSr8UGLXn4SSAErTKmN2vIXjbk0y6m9IaZbGogBTTVAh
         lz4T7llCRDanQ==
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
Received: from odin.codewreck.org (localhost [127.0.0.1])
        by nautica.notk.org (Postfix) with ESMTPS id 840F2C025;
        Wed,  3 May 2023 09:49:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=codewreck.org; s=2;
        t=1683100200; bh=STk00GLf3dBT1BAQ4Vfvpm/JgGYNx5KVfN2QOVrKrFA=;
        h=From:Date:Subject:References:In-Reply-To:To:Cc:From;
        b=DKMfb6A+mPwlJYreZAWzsenvNYbD+7HreCiqg885fdtQRZtl3S3NADCPI0ZM8Gan4
         5tDoUWBg1xewb9q5c2U2H8kM3HdxegR7yKD4rmx7IX50xviDGIVULEHMBbKQfhp5ZJ
         +4EsZjnLv/mLikrw4Cdz90wYZEVAW4wZCNu+RJOPNEdw5Y0O7OEI0n1FP9C485PCvu
         aGByIMkiwW6RU7EdflBC9jA0nhDtElTIbdzLOHvpwL6tUb1XwFF9EOE4UuPCOl9qLA
         lGOX3KcgpDi3LOgYq6B8HbdSr8UGLXn4SSAErTKmN2vIXjbk0y6m9IaZbGogBTTVAh
         lz4T7llCRDanQ==
Received: from [127.0.0.2] (localhost [::1])
        by odin.codewreck.org (OpenSMTPD) with ESMTP id 61229dc9;
        Wed, 3 May 2023 07:49:37 +0000 (UTC)
From:   Dominique Martinet <asmadeus@codewreck.org>
Date:   Wed, 03 May 2023 16:49:28 +0900
Subject: [PATCH v2 4/5] 9p: virtio: skip incrementing unused variable
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Message-Id: <20230427-scan-build-v2-4-bb96a6e6a33b@codewreck.org>
References: <20230427-scan-build-v2-0-bb96a6e6a33b@codewreck.org>
In-Reply-To: <20230427-scan-build-v2-0-bb96a6e6a33b@codewreck.org>
To:     Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Christian Schoenebeck <linux_oss@crudebyte.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Cc:     Simon Horman <simon.horman@corigine.com>, v9fs@lists.linux.dev,
        linux-kernel@vger.kernel.org, netdev@vger.kernel.org,
        Dominique Martinet <asmadeus@codewreck.org>
X-Mailer: b4 0.13-dev-f371f
X-Developer-Signature: v=1; a=openpgp-sha256; l=1501;
 i=asmadeus@codewreck.org; h=from:subject:message-id;
 bh=yIvIlyYdte2aD4M+nwUw7i10WOSRD+BBZXKURFMfUiY=;
 b=owEBbQKS/ZANAwAIAatOm+xqmOZwAcsmYgBkUhIRjyn3bKEcahIRg5jp+rPyxrU+yyhaY/UMo
 mzzp5/HKbCJAjMEAAEIAB0WIQT8g9txgG5a3TOhiE6rTpvsapjmcAUCZFISEQAKCRCrTpvsapjm
 cDtMD/43S+r+yQYPp13CgDJPXxiuToYdylFo+o4civPO6RBVF5uxyzUaGWE/NThzkh9EWLUWSho
 d8IleOaEje4+9gY50+P81w2ufmZk2Mf5lyO9d4g6vJ/zuksEmx+K20s0qFfohEZSX9sXGmauBog
 M67qek25C8gisov1sjvIVOUMHR/wLLMpuqP2zsY2NwfvB3fNQdvGUFd3atuskWCB5/4ZAMXlHAe
 K5TBTvcQBxCD2fTu8HjFyENlki4eJTJFw2uJ2uQ7nMiqH/T6aFYh4HU5244qzM2lXDLeoDZZjoh
 7uRNbII4Amp/j7f10Tp9lrTyR7eTh6yRCfHR2ItYoCdTHzcXRoCSMUIIkcUw7y+7e7iSPD6r5Kp
 aAi/E7yZm+YOBaqAAbA+olaQY1FhBTjfhpTQCvtWNyhfz+mPJhBwzjJoWk+Ps6Dbeju16yuyact
 OGEs12QpXTMrpTqfqB1imOtz2uqfQ3n/Hw814B5EI1FVwM4OiPvbBBvtDcKp41LIH9xI7BP0ERu
 UG4luuMlz0dYpCYL1cYU7PJlFE8wQtY0C0xEIA06a3RZwwOFBvtEFUKKXQSivb64vs97JTJUTS4
 PGIzXiOa/k1Ru0+v4eChQ9QxcEMNiY49lbUQH32M8ETOQ6EfX6S8Q2hoquZSrp2zwJ1z2AiOkmi
 TbKVgBzoULoUUnQ==
X-Developer-Key: i=asmadeus@codewreck.org; a=openpgp;
 fpr=B894379F662089525B3FB1B9333F1F391BBBB00A
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the following scan-build warning:
net/9p/trans_virtio.c:504:3: warning: Value stored to 'in' is never read [deadcode.DeadStores]
                in += pack_sg_list_p(chan->sg, out + in, VIRTQUEUE_NUM,
                ^     ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

I'm honestly not 100% sure about this one; I'm tempted to think we
could (should?) just check the return value of pack_sg_list_p to skip
the in_sgs++ and setting sgs[] if it didn't process anything, but I'm
not sure it should ever happen so this is probably fine as is.

Just removing the assignment at least makes it clear the return value
isn't used, so it's an improvement in terms of readability.

Reviewed-by: Simon Horman <simon.horman@corigine.com>
Signed-off-by: Dominique Martinet <asmadeus@codewreck.org>
---
 net/9p/trans_virtio.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/net/9p/trans_virtio.c b/net/9p/trans_virtio.c
index f3f678289423..e305071eb7b8 100644
--- a/net/9p/trans_virtio.c
+++ b/net/9p/trans_virtio.c
@@ -501,8 +501,8 @@ p9_virtio_zc_request(struct p9_client *client, struct p9_req_t *req,
 
 	if (in_pages) {
 		sgs[out_sgs + in_sgs++] = chan->sg + out + in;
-		in += pack_sg_list_p(chan->sg, out + in, VIRTQUEUE_NUM,
-				     in_pages, in_nr_pages, offs, inlen);
+		pack_sg_list_p(chan->sg, out + in, VIRTQUEUE_NUM,
+			       in_pages, in_nr_pages, offs, inlen);
 	}
 
 	BUG_ON(out_sgs + in_sgs > ARRAY_SIZE(sgs));

-- 
2.39.2

