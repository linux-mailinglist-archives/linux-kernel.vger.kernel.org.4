Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901D7606A59
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Oct 2022 23:32:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229875AbiJTVc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Oct 2022 17:32:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229718AbiJTVcw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Oct 2022 17:32:52 -0400
Received: from msg-2.mailo.com (msg-2.mailo.com [213.182.54.12])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 218052248DA
        for <linux-kernel@vger.kernel.org>; Thu, 20 Oct 2022 14:32:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=mailo.com; s=mailo;
        t=1666301560; bh=iR8iS0E42jvZihmNWcy5ZgDuA+WaFkQWN7g/UwsI0sI=;
        h=X-EA-Auth:Date:From:To:Subject:Message-ID:References:MIME-Version:
         Content-Type:In-Reply-To;
        b=kxU2ys+gQ6R0R+50QSAynn18+mTFsPmtGVcoBHOLXlbby41oePD5vWzFTFwdMduis
         dpX5xVacYtPWv2QqApIMUUJ2SlbOyFu78i+5XsdxGCDIPZ2kwOv+pFPRkIJ01iBwv0
         wvSBU23d7CaK+kLS63xDjo/GbwO1qN0sE459qxsg=
Received: by b-1.in.mailobj.net [192.168.90.11] with ESMTP
        via [213.182.55.206]
        Thu, 20 Oct 2022 23:32:40 +0200 (CEST)
X-EA-Auth: Dt4nhsBn5czK+gafsjybVL/VmW4oP0/+6jSeb68vEDo5kKu6wTGxOpNR8JLuAwSkwgL2u+Jn9qipdtcbqtU4/ntrFLJMURnW
Date:   Fri, 21 Oct 2022 03:02:35 +0530
From:   Deepak R Varma <drv@mailo.com>
To:     outreachy@lists.linux.dev, Larry.Finger@lwfinger.net,
        phil@philpotter.co.uk, paskripkin@gmail.com,
        gregkh@linuxfoundation.org, linux-staging@lists.linux.dev,
        linux-kernel@vger.kernel.org, kumarpraveen@linux.microsoft.com,
        saurabh.truth@gmail.com
Subject: [PATCH v4 11/11] staging: r8188eu: Remove unused macros
Message-ID: <efaf637a14b6f7fdd0178e2aecf8abf17e6922f6.1666299151.git.drv@mailo.com>
References: <cover.1666299151.git.drv@mailo.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1666299151.git.drv@mailo.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple variants of macros PlatformEFIOWrite and PlatformEFIORead are
defined but never used. As they do not appear to be designed for anything
significant, we can remove them to avoid unexpected usage.

Suggested-by: Julia Lawall <julia.lawall@inria.fr>
Signed-off-by: Deepak R Varma <drv@mailo.com>
---

Changes in v4:
   1. Patch newly added to the patch set.


 drivers/staging/r8188eu/include/rtw_io.h | 14 --------------
 1 file changed, 14 deletions(-)

diff --git a/drivers/staging/r8188eu/include/rtw_io.h b/drivers/staging/r8188eu/include/rtw_io.h
index 87fcf6c94ff3..e9744694204b 100644
--- a/drivers/staging/r8188eu/include/rtw_io.h
+++ b/drivers/staging/r8188eu/include/rtw_io.h
@@ -285,18 +285,4 @@ void bus_sync_io(struct io_queue *pio_q);
 u32 _ioreq2rwmem(struct io_queue *pio_q);
 void dev_power_down(struct adapter *Adapter, u8 bpwrup);

-#define PlatformEFIOWrite1Byte(_a, _b, _c)		\
-	rtw_write8(_a, _b, _c)
-#define PlatformEFIOWrite2Byte(_a, _b, _c)		\
-	rtw_write16(_a, _b, _c)
-#define PlatformEFIOWrite4Byte(_a, _b, _c)		\
-	rtw_write32(_a, _b, _c)
-
-#define PlatformEFIORead1Byte(_a, _b)		\
-		rtw_read8(_a, _b)
-#define PlatformEFIORead2Byte(_a, _b)		\
-		rtw_read16(_a, _b)
-#define PlatformEFIORead4Byte(_a, _b)		\
-		rtw_read32(_a, _b)
-
 #endif	/* _RTL8711_IO_H_ */
--
2.30.2



