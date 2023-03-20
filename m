Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C924E6C08CE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 03:06:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229671AbjCTCGq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Mar 2023 22:06:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229562AbjCTCGo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Mar 2023 22:06:44 -0400
Received: from out162-62-58-211.mail.qq.com (out162-62-58-211.mail.qq.com [162.62.58.211])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A647414E96;
        Sun, 19 Mar 2023 19:06:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1679277991;
        bh=S211RAJThIxH8josnyYpV+6MRnF2vlXkDSIP0aPPtao=;
        h=From:To:Cc:Subject:Date;
        b=wVBJO8EuwxqazyCr7sFldGVdMFCKjRWX9NBTkA1Xr2g6y6Cvi403qat3k1VzyKA3C
         apjWyZCvuYM8l+qQFXfi/07zdw9e0FeRmS/Qdfn6gUIfV2ZgGthmPv/tDyYwA1J/ms
         TxCa/hyNrX9DZrHOxAMAeNYBAMMH3WDivx3iX+xo=
Received: from localhost.localdomain.localdomain ([219.238.10.2])
        by newxmesmtplogicsvrsza12-0.qq.com (NewEsmtp) with SMTP
        id 12F23E0E; Mon, 20 Mar 2023 10:04:47 +0800
X-QQ-mid: xmsmtpt1679277887tiwyn1kbu
Message-ID: <tencent_3EF4F3D0717E80F131BF00B982698C34DF07@qq.com>
X-QQ-XMAILINFO: M5WvXNp9ZPrQRJI6XT8TXIr+WR/pWAMYbEdS/TzMlT8xvJFxUuTOhTqIQs7lOX
         QyiiFaosZCYhU61ZRyudk0F66ahFwIKom87dsp8PKOIj59VBb9owzb/6thQxIO72MCk/bnGrEp1W
         jjYsSoxFfZfGW18Vbkr7KY4F1noQc0FGWJjgj3EJHUvNNpTlSeuz5xBg/hb0H/yj4mBl8egcmFR5
         x/oqhzGrok53vIEa4GAFZlsbNR5IF/ljv/2IM8lsnNIj3rlIjpbzHwym+7ltkAve2vci9EW+yDXb
         MzuRDzCLhtXUKYcUN5BFMH9vgXmRTli+MbLoAMWXV5kkDi2pZQsrOfJKg7bhO7la+FhftUD1LCeR
         fScd1vWu0/wqi7uPiHO1kiORmAAa8BFzgjgaRd0DWx2xhnPp5v7oIim/AB5zoghsvk6xXpDIjGrV
         iOcljFGDWw8iS4sUNHeC3wgH04AfDZliydu5Tu8CEbyfcmNQ8AH9QrH2PesUkFqAJL5rvoy3fJeY
         uwOxhsF7Muh2AbZPaM6RLKuHVyWufqUjkpSkuZL+hNqGDy3a+PJnbJ74M5MdRweZOaPPYwAT29uV
         W4l+pkoiVG2zOdHQ+6QlWiX8xWN/csRU6wIscT1+5lfNW9037vEIPv++Kil+DyNbjqV/qRwGvdu5
         04AeEb0l6PelHN03sYAZ/vdUqWyRRxP/JktUK/Fgwvwu36vYAujp+ezE6KB1KLSqwh1xhPhtOC/k
         nSUiRpEJ3W9D9kzpH6pGhAp8vLuu10FZZcsxTdLECrf6oPalIevXUgP62b9+nudAkFaS9hdYbj4Y
         DicayXt/Aak8e1g8ZrEyjCd8jhTCN0pUBjNo4ylitmTDgsSDDj/tBgyh64W9haB70Psbe2ajvDyG
         OpNNfVerCVZQL67qMyDGSSGGNcLW9xoww/eVhxNpADLv5AGLnXFhtawFk2ycUK/rpUnm3o3tixNK
         Cbs1SSEUI=
From:   Zipeng Zhang <zhangzipeng0@foxmail.com>
To:     code@tyhicks.com
Cc:     herbert@gondor.apana.org.au, ecryptfs@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Zipeng Zhang <zhangzipeng0@foxmail.com>
Subject: [PATCH] fs: ecryptfs: comment typo fix
Date:   Mon, 20 Mar 2023 10:04:28 +0800
X-OQ-MSGID: <20230320020428.13045-1-zhangzipeng0@foxmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,
        SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.6
X-Spam-Level: *
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Comment typo fix "vitual" -> "virtual".

Signed-off-by: Zipeng Zhang <zhangzipeng0@foxmail.com>
---
 fs/ecryptfs/crypto.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/ecryptfs/crypto.c b/fs/ecryptfs/crypto.c
index c16f0d660cb7..faa901cde636 100644
--- a/fs/ecryptfs/crypto.c
+++ b/fs/ecryptfs/crypto.c
@@ -1289,7 +1289,7 @@ static int ecryptfs_read_headers_virt(char *page_virt,
 
 /**
  * ecryptfs_read_xattr_region
- * @page_virt: The vitual address into which to read the xattr data
+ * @page_virt: The virtual address into which to read the xattr data
  * @ecryptfs_inode: The eCryptfs inode
  *
  * Attempts to read the crypto metadata from the extended attribute
-- 
2.39.2


