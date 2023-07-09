Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D92574C1C6
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jul 2023 11:59:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230244AbjGIJ7Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jul 2023 05:59:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229534AbjGIJ7P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jul 2023 05:59:15 -0400
Received: from out162-62-57-49.mail.qq.com (out162-62-57-49.mail.qq.com [162.62.57.49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F525129;
        Sun,  9 Jul 2023 02:59:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688896749;
        bh=Ok2UwAr6nX11lqE2tuCWc4B2WooiEHa6YY7cWJtYm5c=;
        h=From:To:Cc:Subject:Date;
        b=cQd5gBrxZo7fGbwbn8T4madSXQbDYcfpj+xEqi3vrAmdhK5wJYlOLAvSfIquDdCdw
         ZZhKXSDF6rQRqCb1SOknbbX4PgEWeaIgf8C+yEaDrhE3VADIfjJwp9TMCj1+ZIa0Br
         OvzgCboAkku91IR0wGAxDMXWUIfNdNuTVGyCDwfo=
Received: from KernelDevBox.byted.org ([180.184.51.70])
        by newxmesmtplogicsvrszb6-0.qq.com (NewEsmtp) with SMTP
        id EC6B723B; Sun, 09 Jul 2023 17:59:06 +0800
X-QQ-mid: xmsmtpt1688896746txvus3ima
Message-ID: <tencent_D22D1FB0000F210538D44A09AA9BB6DAB407@qq.com>
X-QQ-XMAILINFO: MiPTq5wGoKOmUZayXFMbPdKq3GyQoIS6wb3ksGfePb/XTg/wF4e/VTzejTczIZ
         qZsjbOgAXkF60VdxvoqdJUSkRMBNao2VOk2M7hYKGxm9qNyrIy6v55ZiO5LW6nOAfBgqGIURQv83
         2af/VAryqaPxSr/+/KYfbqX1l6wI0mVhqZMHHGO+lcYZwhKVr9kUmuFJ8dXGKFvZlBVnDdDzcfFc
         zsjXQ1IBBG2Pz1sNAvsNRmWOqSBLZ/9y4ZIphKUsG3pZfmwsCKrkWKubuMqmIVE04RRKGzUz5nTY
         L/iFJreE5qb3X8NbBc6pnw2CEA/0PRg15tyJ4WBkhl8zMQ8c2pjbPEoIE44fGJRcFc4uvRYdofea
         wLkJ+Es94Uf0zmrjKHv1l8PjOsulU+IXUcEAatF3HPa3DpJdyJ4koehe3xD72KLnhDqTtgz6g9PW
         3ZO3w4NlU20UQ8d4kdKEA1NvUa8bQFD0lg51ZylVD2PagOHml4gFoxq+dyrMydofXo4blu09XZt3
         HsQu5Q0vW1tvk4PVIbvHPmq4DKWn8y/l+CaCzv7tJG/MgN9DBgNxpyQepNYALjQc1nHbJGnoulSY
         IpqBlkbY82Jnhy+aPViDkBQ1xRNQcmf6ehUyXV65rQd6jn8qgqFtJz/GQKE055h2TJPcpowfDQze
         c8c29/tqA2b6i4nQOm7l7nDV0WNykxVuUl92Na7G5iuwtnuI78TjDddBVDwtKa6VuxU6vS2MwTNz
         keKQr1Y3Dxe35P15kIHcYOxCulCkW/hOS7aFJ6pJP2Q1MQAvqz4rn6mTOzNc8NFqcRApd8LRxAkF
         tT3+bpN+M7pxqiILFj551jc6y9tZL6kWwVilir1vkPppIOv4FhcK/MtNBLU+HSKdaJZCLoimRJKV
         Tf5jiP9zrnvDCX809nsc5ardylVyNqtvWhysF+tsSfIDNKFfM8U17TtNxdjOe1tSdS4qgSybF6u6
         6d/IwFeQouAhblg65FYPx9AaSEJiNS59dz+sQ3ojl/HZd1YVDc6D6CnUQ1KmQtTyoiMEPgiQ8=
X-QQ-XMRINFO: OWPUhxQsoeAVDbp3OJHYyFg=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     pkshih@realtek.com
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] wifi: rtw89: debug: fix error code in rtw89_debug_priv_btc_manual_set
Date:   Sun,  9 Jul 2023 17:59:06 +0800
X-OQ-MSGID: <20230709095906.1162670-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_BLOCKED,RCVD_IN_MSPIKE_H5,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is a failure during kstrtobool_from_user()
rtw89_debug_priv_btc_manual_set should return negative error code
instead of a positive value count. Fix this bug by returning
correct error code.

Fixes: e3ec7017f6a2 ("rtw89: add Realtek 802.11ax driver")

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 6 +++++-
 1 file changed, 5 insertions(+), 1 deletion(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 1db2d59d33ff..35fe6b4ad9b3 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3192,9 +3192,13 @@ static ssize_t rtw89_debug_priv_btc_manual_set(struct file *filp,
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	struct rtw89_btc *btc = &rtwdev->btc;
 	bool btc_manual;
+	int ret;
 
-	if (kstrtobool_from_user(user_buf, count, &btc_manual))
+	ret = kstrtobool_from_user(user_buf, count, &btc_manual);
+	if (ret) {
+		count = ret;
 		goto out;
+	}
 
 	btc->ctrl.manual = btc_manual;
 out:
-- 
2.30.2

