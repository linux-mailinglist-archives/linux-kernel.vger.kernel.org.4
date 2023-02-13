Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 040C7693E9A
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 08:03:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229714AbjBMHDa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 02:03:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjBMHD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 02:03:27 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13F71BDF8
        for <linux-kernel@vger.kernel.org>; Sun, 12 Feb 2023 23:03:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        MIME-Version:Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:
        Content-ID:Content-Description:In-Reply-To:References;
        bh=CAMl6bbB4VBhku/eCWB/73USL/Lw7fBbnEebQaGO7JI=; b=VfDbAeWoe5xctNA++Tc2HaNUer
        FuoNeuqYfG4Vmo/E7G4pbVa+sDQYBkM7aaxFFjdcdzynWmdPOXoezgBvkQ+On+pguoeBG1WeEnpOl
        o9R+kzwyoN7t2pv1Om6UrFTlnTftz4rOOfvmuZ9yuriOpPbCCd6wACMdE8njolPzcWBek2+85cX+f
        eu5mRyMioEsfW+mLrN5WJBsXsrbBRzqYhp+/VtRN9Wi+DcDrkQ5Rtjmvvag3N/rIxDStG9GJfGlTL
        SpUtzx0th4TCOv8ptSvCmLbGDtahZrdA7UVSZ5b+IQz1Q2DrYR9L6fV/JVLBZl0JDiU8B8P+NfYH9
        OtVwWydQ==;
Received: from [2601:1c2:980:9ec0::df2f] (helo=bombadil.infradead.org)
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pRSs1-00DP1S-6k; Mon, 13 Feb 2023 07:03:25 +0000
From:   Randy Dunlap <rdunlap@infradead.org>
To:     linux-kernel@vger.kernel.org
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Boris Brezillon <boris.brezillon@bootlin.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        linux-i3c@lists.infradead.org
Subject: [PATCH -next] i3c: fix device.h kernel-doc warnings
Date:   Sun, 12 Feb 2023 23:03:24 -0800
Message-Id: <20230213070324.1564-1-rdunlap@infradead.org>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix all kernel-doc warnings in <linux/i3c/device.h>:

include/linux/i3c/device.h:27: warning: contents before sections
include/linux/i3c/device.h:196: warning: Excess function parameter 'dev' description in 'dev_to_i3cdev'

Fixes: fa838c8ce537 ("i3c: move dev_to_i3cdev() to use container_of_const()")
Fixes: 3a379bbcea0a ("i3c: Add core I3C infrastructure")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Boris Brezillon <boris.brezillon@bootlin.com>
Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc: Alexandre Belloni <alexandre.belloni@bootlin.com>
Cc: linux-i3c@lists.infradead.org
---
 include/linux/i3c/device.h |   13 +++++++------
 1 file changed, 7 insertions(+), 6 deletions(-)

diff -- a/include/linux/i3c/device.h b/include/linux/i3c/device.h
--- a/include/linux/i3c/device.h
+++ b/include/linux/i3c/device.h
@@ -18,17 +18,18 @@
 /**
  * enum i3c_error_code - I3C error codes
  *
+ * @I3C_ERROR_UNKNOWN: unknown error, usually means the error is not I3C
+ *		       related
+ * @I3C_ERROR_M0: M0 error
+ * @I3C_ERROR_M1: M1 error
+ * @I3C_ERROR_M2: M2 error
+ *
  * These are the standard error codes as defined by the I3C specification.
  * When -EIO is returned by the i3c_device_do_priv_xfers() or
  * i3c_device_send_hdr_cmds() one can check the error code in
  * &struct_i3c_priv_xfer.err or &struct i3c_hdr_cmd.err to get a better idea of
  * what went wrong.
  *
- * @I3C_ERROR_UNKNOWN: unknown error, usually means the error is not I3C
- *		       related
- * @I3C_ERROR_M0: M0 error
- * @I3C_ERROR_M1: M1 error
- * @I3C_ERROR_M2: M2 error
  */
 enum i3c_error_code {
 	I3C_ERROR_UNKNOWN = 0,
@@ -189,7 +190,7 @@ struct device *i3cdev_to_dev(struct i3c_
 
 /**
  * dev_to_i3cdev() - Returns the I3C device containing @dev
- * @dev: device object
+ * @__dev: device object
  *
  * Return: a pointer to an I3C device object.
  */
