Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BC5D5B4369
	for <lists+linux-kernel@lfdr.de>; Sat, 10 Sep 2022 02:30:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230251AbiIJAas (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Sep 2022 20:30:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230200AbiIJAaq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Sep 2022 20:30:46 -0400
X-Greylist: delayed 147375 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Fri, 09 Sep 2022 17:30:44 PDT
Received: from out203-205-251-59.mail.qq.com (out203-205-251-59.mail.qq.com [203.205.251.59])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34DD1476DC
        for <linux-kernel@vger.kernel.org>; Fri,  9 Sep 2022 17:30:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foxmail.com;
        s=s201512; t=1662769841;
        bh=Gxe4Ta6FyNOxbWEOTIgsuOptukjbQJHOFt7dTlu1cvI=;
        h=From:To:Cc:Subject:Date;
        b=B+Pladviuc6alJfDptP/HQvYgsHwtU2CK2XORbkeK6KLNPegBzyGZGzWxvwLGgzEH
         qQk0oLu3gbBsmnSymGUnz5u1B6YSEXYWRX+tHPSz7KstJQHM+NZUklPGJkt7/G+ZDh
         fGjCFVtjnA7EPuwAAtxCnWCeY2oEJv+gkqrNbw2M=
Received: from localhost.localdomain ([113.57.80.61])
        by newxmesmtplogicsvrszb7.qq.com (NewEsmtp) with SMTP
        id 7A61F29D; Sat, 10 Sep 2022 08:30:38 +0800
X-QQ-mid: xmsmtpt1662769838tjjkb9w73
Message-ID: <tencent_DD1047278567B897D2CF7F13483573596E06@qq.com>
X-QQ-XMAILINFO: NsEIGfsQmVV+dk0z9nw0FtMWluIhdB6raiTdWZ31XpUDORHhTdNn5KJB3TTmky
         d1iC87h8mPEg4ns+z1URGAVD9MAFvV85Ng/vuAXjlgbWKgwQtofMqAjyBOK6UU1k03d0mDMhP+/v
         EBKrzDImfGI3TZ0tGrSuvrtIdcMcFhMtXppLiOpdftY+Lk65q/2/tzxlbKGFsZEdOPPEcG1PHKVA
         TNMs7TU/5MEHu3BeKEjjVzMCyXjtSKm+8NT18xD2RZAN8gBYaO1XZwf/DyxPet4fVvPOGcOPOX7U
         j9zFi7LK+7SYpBmW07Isq4BisB40E746zYJTjglMiU1RJtGBMGk1MPLOo6ndLZWQx6kQu13+njRF
         +ZCknKOt4LToWiwEdNoajU28OF85RTyBbLmQdOGA4cZ58diTehqGI9bfCxK3xtBmHqTy6KxbZ0FX
         lGsRF9y2t2F0jRqG26Fr14vspMRTIz8za+Vxj+W2J3mQueuGSdCVFGxlqc49oso1gYKO6A/1Ks9a
         W4DUuFy5Z0ddYLK6HHnM31uC756ZF0ea2Ace9X6jZb824AY8Ho5cx8JPkpkHt3UX19gDlc58wY/N
         G6QTMQl6JrWw8JSsKrwbNDcA/RY/cyVDVCxwEnR9D3Zld83UElOZf1AgQ02ZXNHmkBGq1AP6WJaJ
         l9ebz4qk5cu4itiy8IeSctRW65RaeXudmM7WkWSSnGMsqOhU/ApfnrDNg7QTVGFi8v5JZ4U/gBXm
         ZFcT3dCArtyvX80ZQMYXYdtOyWCscjho9xpy70ATEcqyofEDlLPR1f4qZ4ncIDKKorKBo7R1pLy1
         h8vrhXtvEGa6eCXlB2rO6vPt0N4HM0PH5HewxYmEhfg8wUnuRAoNthRCOz/lv/1XQXJToq8/x/dP
         g1sSFioyU/OY0eDLt4rkVdq46ywn6GVwk1p9LA+mKUVM4IwykaB/pHVRlXGlVbdWdyrM0vAVEcvQ
         XIo3c1f1UW865YDPGJmmAuuy7F541fvMYkKdnqfSWelM9+657XvsicIepRVfZNIEuEr7mcYLcN8O
         5qMg0YmLtI4viaM3f+JQ94jt8gLCOzR6oS3UeeKBj1PTmlXiWxfDlllumenpM=
From:   xkernel.wang@foxmail.com
To:     Larry.Finger@lwfinger.net, phil@philpotter.co.uk,
        gregkh@linuxfoundation.org, philipp.g.hortmann@gmail.com
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org,
        Xiaoke Wang <xkernel.wang@foxmail.com>
Subject: [PATCH] staging: r8188eu: add kfree() on an error path of rtw_xmit_resource_alloc()
Date:   Sat, 10 Sep 2022 08:29:56 +0800
X-OQ-MSGID: <20220910002956.3975-1-xkernel.wang@foxmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        HELO_DYNAMIC_IPADDR,RCVD_IN_DNSWL_NONE,RDNS_DYNAMIC,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoke Wang <xkernel.wang@foxmail.com>

In rtw_xmit_resource_alloc(), if usb_alloc_urb() fails, then the memory
`pxmitbuf->pallocated_buf` which is allocated by kzalloc() is not properly
released before returning.

So this patch adds kfree() on the above error path to release it. As there
is no proper device to test with, no runtime testing was performed.

Signed-off-by: Xiaoke Wang <xkernel.wang@foxmail.com>
---
 drivers/staging/r8188eu/core/rtw_xmit.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/drivers/staging/r8188eu/core/rtw_xmit.c b/drivers/staging/r8188eu/core/rtw_xmit.c
index 67f9c05..9c39d08 100644
--- a/drivers/staging/r8188eu/core/rtw_xmit.c
+++ b/drivers/staging/r8188eu/core/rtw_xmit.c
@@ -44,8 +44,10 @@ static int rtw_xmit_resource_alloc(struct adapter *padapter, struct xmit_buf *px
 	pxmitbuf->dma_transfer_addr = 0;
 
 	pxmitbuf->pxmit_urb = usb_alloc_urb(0, GFP_KERNEL);
-	if (!pxmitbuf->pxmit_urb)
+	if (!pxmitbuf->pxmit_urb) {
+		kfree(pxmitbuf->pallocated_buf);
 		return _FAIL;
+	}
 
 	return _SUCCESS;
 }
-- 
