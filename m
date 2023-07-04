Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 671C074774C
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:55:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231565AbjGDQzm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:55:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231533AbjGDQzc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:55:32 -0400
X-Greylist: delayed 319 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 04 Jul 2023 09:55:30 PDT
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD6A71AC;
        Tue,  4 Jul 2023 09:55:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688489728;
        bh=Iqendox+1LHXkQVpxAPqWFk4dta4jv2xlFIP2LLV47s=;
        h=From:To:Cc:Subject:Date;
        b=jIy2Drx2YcffegUqwS3IMNuQUCbHvcWGht1RH5RxEdMCTcx6LVnPzgtFAlcYQHKaH
         ayK5i5xjI1d180VSbBuepQOF0FoR4hIGnzYXopkUsnwmv4vPK1HTYf/6VgMX91cafA
         9+i+G0bXImUULq68GfoKIqXOBWL1oZsk5YLTRAQA=
Received: from localhost.localdomain ([119.136.250.51])
        by newxmesmtplogicsvrsza7-0.qq.com (NewEsmtp) with SMTP
        id DDB1E2B8; Wed, 05 Jul 2023 00:55:27 +0800
X-QQ-mid: xmsmtpt1688489727trrmexhxm
Message-ID: <tencent_54814178D4285CA3D64B8CDC90D49A6CB10A@qq.com>
X-QQ-XMAILINFO: MBoG/Qi9YTl8NiIlDcsjvCb6hKSmKLd70ylrEoH0xeC83dmBWp1C7CU+w6LdjY
         jlfPGb1C8uULbbhMKT9pekl4oeHhfaEx73suD1+kZIcpbPri58BWTi+dsqMLTX3RzIx5eclRbM1m
         XpKb1uam04D98vOcR2NyW1wngpCvXmeidnQXIw4D+0Oit+yQYD7KFGfJd9vl5O18XM5Rt1NT4wtn
         4W3n5LiUw63iBo9x4TvP/J7yecIWMWRg/g4gSrHZ0Gr6wGDA+0dGWgybP7BfDNL2klP1CpKTHqfF
         D7IuQuKAYJ9XwxlXY8lI0EXrGKxr7bTxzOJA70Ag8terYtlAgA77igZV9ul1RwNdBrhCqknUxTmB
         JspgA+8tAyH5Q/EJNLZ/SFPrWBrBls8lQ27M/HH4iznpbDYJxn08vZvs2NuSWcmQ7sfhc+Zh82zz
         4nw3S8KN8aJ4JXl1F6V5y8IYefepZLxyMW4T3l+7DMl3JfEGjc+l1cxNnHILADG01JfRXzW6r9wu
         o6A/RS6lZKJsJDFJkSdRstoJRSKCUgyI/JT3iOECDP+pukB9S9pSTvFi6w0HV8fgKdvhlbkKcoZx
         qrFWWfektLbgEGI3OtrnmC9O8v9YtQCJSukLHmnFd/lCx6lahRcKL1gknh8EpFEbMeplLrkfU36l
         +mwxOaMolqix0R3Wj6Q3P3qxy4gTURbT07I+rZXAJjuPbLY18GR+e9DRVmsY8faQky+hL6p67p/t
         8HPyM+AurZZEs6VXdndwz4HOjwbLAkefGXt9NIyzLCVq0p0ZrgWA8faJDeyYsqr69q0BOug1RLRu
         yB46I53qN9CBcobLwsIwcU6T+zN0ixPpJkpMYRqDwklAsbVaDKCRaQv4XJPbt5IUcdDoX+pfTzPb
         Et+o/stWu8uGioAhRvvfsSXmC87RO4ipYnx+PLSMCDR10fbl7mMYE8k0KpShXRp+my2fA2eFrQ1t
         dqdmdmqsDH2ehyTzRJWe9O4FgJehGf43geW7h3IZUNqlvXmu8lyWmtIMTvmonqYi2WBDQx2xacDG
         Rt6Gdwk9JQBFO5Nrt1D9kYYSmU3P8IEIth07Ao+6c/ypMAv8cG
X-QQ-XMRINFO: Nq+8W0+stu50PRdwbJxPCL0=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     pkshih@realtek.com
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH v2] wifi: rtw89: debug: fix error code in rtw89_debug_priv_send_h2c_set()
Date:   Wed,  5 Jul 2023 00:55:25 +0800
X-OQ-MSGID: <20230704165525.10288-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is a failure during rtw89_fw_h2c_raw() rtw89_debug_priv_send_h2c
should return negative error code instead of a positive value count.

Fix this bug by returning correct error code.

The changes in this version:
- fix some compile error

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>

update
---
 drivers/net/wireless/realtek/rtw89/debug.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 1db2d59d33ff..a679f79b85ec 100644
--- a/drivers/net/wireless/realtek/rtw89/debug.c
+++ b/drivers/net/wireless/realtek/rtw89/debug.c
@@ -3026,17 +3026,18 @@ static ssize_t rtw89_debug_priv_send_h2c_set(struct file *filp,
 	struct rtw89_debugfs_priv *debugfs_priv = filp->private_data;
 	struct rtw89_dev *rtwdev = debugfs_priv->rtwdev;
 	u8 *h2c;
+	int err = 0;
 	u16 h2c_len = count / 2;
 
 	h2c = rtw89_hex2bin_user(rtwdev, user_buf, count);
 	if (IS_ERR(h2c))
 		return -EFAULT;
 
-	rtw89_fw_h2c_raw(rtwdev, h2c, h2c_len);
+	err = rtw89_fw_h2c_raw(rtwdev, h2c, h2c_len);
 
 	kfree(h2c);
 
-	return count;
+	return err ? err : count;
 }
 
 static int
-- 
2.41.0

