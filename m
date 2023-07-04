Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 707DA747731
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jul 2023 18:51:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230385AbjGDQvp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 12:51:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229595AbjGDQvn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 12:51:43 -0400
Received: from out162-62-57-137.mail.qq.com (out162-62-57-137.mail.qq.com [162.62.57.137])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27CE91AC;
        Tue,  4 Jul 2023 09:51:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1688489496;
        bh=cIg2PICXNPUsFX6awcRmfhx7g4SJNWbhIdMrQNCN3aY=;
        h=From:To:Cc:Subject:Date;
        b=eX+biQaka25vcEH843I6gO/gfaVVGlzdGFZzNFXntPEbqfDTLfLE3TeS/sahRdCxK
         or2kRbIJBN+pdqd/crbgTDDiD831eSNVgnNSqESey6is3ajJbo16cQgzSxJUmJSxzE
         Mqa0AorvmoquItSqnxnlClmjd3ZzCHUZ9QvJMnvE=
Received: from localhost.localdomain ([119.136.250.51])
        by newxmesmtplogicsvrszc2-0.qq.com (NewEsmtp) with SMTP
        id C85AE8D9; Wed, 05 Jul 2023 00:50:05 +0800
X-QQ-mid: xmsmtpt1688489405tni7sipgq
Message-ID: <tencent_75CD234BE106B55B02EE46AAB672AB0DAC05@qq.com>
X-QQ-XMAILINFO: NKDEJ657lpu+v/ezi0CXmzCQFDGl9yP6n/RU6Lw7NJzJcNyukpzws2S2r0HpYQ
         RPr3om061uvHSBXKCuzK4iHvWnNR0Q2NhySymWKWSzo6hYkeDHNpD1vF45Tc0luqov2/3znvI6vs
         y0VFvG1K6uual1lf7OTCF83HJfJajKN5KZ1WuMbdcKUvfZUHWhA+YhW5lUmWR6P5Gir+bPjmPQd4
         six9bd9ITXIA2scOH+IHjo05zPVZKJa2bGGBzNAL7DojmkTZTpfneMqh4JRjUbilXwOQrJgi28Jj
         YEsJ3bi6hsM+d+cdyCdbNOm0w8pp96SCAbiOF5MZm92n1Efr3X9wUAHrje4XGq5eNHwpgSBctJfB
         agNkE7hp4zS1gDRu0inELCLuzTR+6MI2JCKbU3OpLCDeyNGGM4AGDcNqky37Cy2xCHF+fgVEXYI5
         TC1i4AMRDFIpQnkZm/FzI2uN+pa9LQkveqLMhcPJ4bzq29oDkyvN8WmCvTEkmw2MmsZzU96giNpp
         UXmNodqKOGP7wNoWTAx3UMjXE2LTX8vXJ58t3aIAsjzOTXDDU+oIMOLhIKh1CTlj96FniOc58ick
         BXCBiC+N957jx1r0gjClkPzNm85BlQdPBczkF7gDer8SUzZTxktQXhMR8dFFuA8mbulxPwsOjGRn
         OJZupN90QNSw3kwEhBN3KjBaIarVXip0UdpHH7J+8+mFyWOGKHwvDxKAmt6HuKOytVb4+QftzyDD
         xbBOdOdapk2LuLkt05/2MEJ5B7wJOZc2T/OGZerplSrONMNTEFDa2X7j/sQBebrlJfUB3LX3ZQ6R
         hHHdiCP/JWQdMdayAyycViX78XMAVZGvYKZmuDlGFFBohU89QZVuhYGX99jD+h2Vfj10tzcVDZ9L
         gEFLsyAuKRNO5e4M4+ZmtuuEnooBBMuazC0NqCGm7CgyMf3JiE6yxy5vpN2AKL8tOpGuQZpMDuaI
         qQGkdtzKjhVcO5nrjRz5pZ19xqgIUf7jcX+XRSpDXvtufhxfCobA==
X-QQ-XMRINFO: Mp0Kj//9VHAxr69bL5MkOOs=
From:   Zhang Shurong <zhang_shurong@foxmail.com>
To:     pkshih@realtek.com
Cc:     kvalo@kernel.org, linux-wireless@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zhang Shurong <zhang_shurong@foxmail.com>
Subject: [PATCH] wifi: rtw89: debug: fix error code in rtw89_debug_priv_send_h2c_set()
Date:   Wed,  5 Jul 2023 00:50:02 +0800
X-OQ-MSGID: <20230704165002.30911-1-zhang_shurong@foxmail.com>
X-Mailer: git-send-email 2.41.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,
        RCVD_IN_MSPIKE_WL,RDNS_DYNAMIC,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If there is a failure during rtw89_fw_h2c_raw() rtw89_debug_priv_send_h2c
should return negative error code instead of a positive value count.

Fix this bug by returning correct error code.

Signed-off-by: Zhang Shurong <zhang_shurong@foxmail.com>
---
 drivers/net/wireless/realtek/rtw89/debug.c | 5 +++--
 1 file changed, 3 insertions(+), 2 deletions(-)

diff --git a/drivers/net/wireless/realtek/rtw89/debug.c b/drivers/net/wireless/realtek/rtw89/debug.c
index 1db2d59d33ff..96481dd2b1d3 100644
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
+	return err ? ERR_PTR(err) : count;
 }
 
 static int
-- 
2.41.0

