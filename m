Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDAD66EA9AE
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Apr 2023 13:53:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229882AbjDULxG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 07:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjDULxD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 07:53:03 -0400
X-Greylist: delayed 327 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 21 Apr 2023 04:53:01 PDT
Received: from out203-205-251-73.mail.qq.com (out203-205-251-73.mail.qq.com [203.205.251.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A315549D1;
        Fri, 21 Apr 2023 04:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1682077979;
        bh=EoskHoyf4Sd5jh5mcjpFlnupNvISBm4b7l+C80+CKwY=;
        h=From:To:Cc:Subject:Date;
        b=rX4Aacp93zxmOgWHJ0sQMzy479hq9qpn5aTGBRS/t5bX7r+fY81ObH3rrPJqHm+UU
         lKjepRtPZYBGQjCleGONqNP8ubA2a/V68S6EJh0sVBeEPLaguBXPdmIHgxY8EsfHT3
         171f2cnV8n67EWB9ew1RKCOw2KWWtoB6BKkEdyW0=
Received: from localhost.localdomain ([39.156.73.13])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id D37A2462; Fri, 21 Apr 2023 19:52:55 +0800
X-QQ-mid: xmsmtpt1682077975tn2266q4u
Message-ID: <tencent_1625E21562D40C91CEE047E82E2BFC524305@qq.com>
X-QQ-XMAILINFO: N9/m7ncAytaJ0fq/x2und95zmGSZ3XpXYogw34Rbhd91F/Z0cMqXQ7EMatIKdz
         NrQ1+2A2VX4Qo0n/HxjZyBmlTFTatKw7SWpo/xDTL8Y2YV7RaVbfcqI4Mue/LO/DlPdVyS1DgEHn
         HF0CzSVB77R2lTTPLeAOHO+BgLLQTQ704acdQuQZi85dxxiQK9/AHVSE4kutcb1YTy+XrK5p3XYn
         LoPHkWgFySa5HDvv/QRB6w/QSH2v26pvQHhLIu/kfRW3GRTwi6GmVZrsTjGIxc1lczkNhFgH/gY3
         jW2oxFefYeVuTE0LGS7jyuACG1u6kduXryxefYRn88vWb6dvkGpiTunWr6FKOv33wuW6cs4JrMe/
         R3wDEhjUT68U9BpEauyuFi0TyAAfHSOYRWoXbrxFGhA0Aeh9VObi8f1Qq3oDRpRgaD1wMuhu0VWI
         lOlwbY3AdIgjq8OvPX5YgqLiJ0SpAWtLmyHrddsSdMt3Eg0l0tZbF6OHPLXIkv4sxqQp502CotIj
         XUDRWRnx5ZK1H7xaSY0k0E1K7+FFsep2Mc/Tb6CNySM/WJ+HYerRy2GFKR6CVLF81Ss4uzqBvMVS
         /b5L+MQ/lpYcBCGfxJkaFPpAODKM07aA3n94HhuvP75sPgt8uoZXWh+i00+xvJFeYZfL5uwieTsy
         dl91u7pITAncoMy2J5HK6i0t/OwY9vQoSsV3FSOiGCWhLfeRh7C91xB8rCPfrywAhpnVweprRKSh
         taggPRy153kHEDt8JRFT6EwZz0415WQuC8i3hREDGo4FxZwmbipk0hJirxvT5F7s1+dbvvlRNEij
         0+xf7bjLZN7QsprM09RH7YzL1yj7NWw2alKLc/QaWNl4nodUAaHMsNR7q2eBrPfWHtGvjF7HqqER
         nKCqK8wKmKgwhF/uC4DhCj8xLQf/xNA3x/LDVtb7lw1TsT1TFHUx3hzP0bxbqj04R+mKoA5QfMOj
         TzHbl3NY8Ufk+DOPRZkpl5og89r2Km4dMroRuVL2k=
From:   Rong Tao <rtoax@foxmail.com>
To:     william.gray@linaro.org
Cc:     rongtao@cestc.cn, linux-kernel@vger.kernel.org (open list),
        linux-iio@vger.kernel.org (open list:COUNTER SUBSYSTEM)
Subject: [PATCH] tools/counter: Add .gitignore
Date:   Fri, 21 Apr 2023 19:52:52 +0800
X-OQ-MSGID: <20230421115253.236600-1-rtoax@foxmail.com>
X-Mailer: git-send-email 2.39.1
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

From: Rong Tao <rongtao@cestc.cn>

Ignore counter_example and include directory.

Signed-off-by: Rong Tao <rongtao@cestc.cn>
---
 tools/counter/.gitignore | 2 ++
 1 file changed, 2 insertions(+)
 create mode 100644 tools/counter/.gitignore

diff --git a/tools/counter/.gitignore b/tools/counter/.gitignore
new file mode 100644
index 000000000000..e1f34db02a91
--- /dev/null
+++ b/tools/counter/.gitignore
@@ -0,0 +1,2 @@
+/counter_example
+/include/
-- 
2.39.1

