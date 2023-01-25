Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A25D67B87A
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 18:26:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235059AbjAYR04 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 12:26:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229612AbjAYR0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 12:26:55 -0500
Received: from mail-ed1-x52c.google.com (mail-ed1-x52c.google.com [IPv6:2a00:1450:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8809A9F;
        Wed, 25 Jan 2023 09:26:53 -0800 (PST)
Received: by mail-ed1-x52c.google.com with SMTP id z11so22631000ede.1;
        Wed, 25 Jan 2023 09:26:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=CYMEij3rxHWyzgLm7dd5XsZ6vBXXY5YhrQ7zALUGLjk=;
        b=Dv8hdB3DMUVXMukiXrX8R5uayffhTytfjOgnhlH736EMc/WIsAQMKzQ57MnRHeWfFV
         F5n3xRt1KakybWkK45QuYajlkvzPLPosyqXR5rIt0hlMzci8GZPbFFEF3CHAYx8vP+FI
         dODp8tKCEe1ugqJMoxMcZ0nPXGlCRpjb0siys1HlQlai19Q0sgK5VCnv39XzIfMpOX36
         aG0myJGc/o/HGOD2kuxfpc40mLNnhjIFyVhT5+bTcY7BZ32M3VR2MkVBxdkJJ5FSy3GR
         bqnyabPa0HRsK863qhLq+U5WF328x620ZEXXVWii0q+Spxo+bzpjNxZFYnv/PHETxY1g
         8pew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=CYMEij3rxHWyzgLm7dd5XsZ6vBXXY5YhrQ7zALUGLjk=;
        b=O/I/HOnqVuWBC8RMrYaEc8YiiPzTGEWxPjbwiHwnowiJ6iMI79XGskVEYoA7LuDxyn
         rSRv6f9uqLOQiyXOd5dAGG22XCfoEpsU/YGAyWEc9OJKutosQIfE31FriniO9lzn+S1K
         +fwglx/2p7IL/a9yLClcHSrgR98Pqo2P1LgbChk1jwAmrva7uBuMEljLvnVAm32B06Uw
         QeXXgouj4idQM6YBn86mLHWOpg3ejYgmN8Gyh59hhimCMtdKKTtT/RgBZEU4KemfAoeq
         4EMHUFYlq41R42OVyjBPasXKs4hpjJyrdqxZZuXKSqF75mKEdRulWSlDKNja/gzV41eF
         Vn5Q==
X-Gm-Message-State: AFqh2kr/xjknTdK3IMGS2klFpQ6LAB+HlHeFxZpS5HVPJGshBTm9z5kc
        RC6W2mp6Wo9Uba2fXDUkmuoI1memruE=
X-Google-Smtp-Source: AMrXdXsUvLlARBjMXRXjQMdoUzGjSjgvrKOPoFY18DBSj653Pol8v+oWAZdyD2Rlk/XeWRH8j+FQVg==
X-Received: by 2002:a50:ff08:0:b0:49b:7416:e3ff with SMTP id a8-20020a50ff08000000b0049b7416e3ffmr34024896edu.5.1674667611597;
        Wed, 25 Jan 2023 09:26:51 -0800 (PST)
Received: from jo-einhundert ([2a02:908:13d6:2180:36e8:f43a:77c6:b1a2])
        by smtp.gmail.com with ESMTPSA id lf14-20020a170907174e00b007c1633cea13sm2688052ejc.12.2023.01.25.09.26.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 09:26:51 -0800 (PST)
Date:   Wed, 25 Jan 2023 18:26:49 +0100
From:   =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>
To:     Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH] usb: gadget: add doc to struct usb_composite_dev
Message-ID: <Y9FmWVF+J08V4RbP@jo-einhundert>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y86cy1AM4w5ju5A4@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added documentation to the new struct members:
* bcd_webusb_version
* b_webusb_vendor_code
* landing_page
* use_webusb
to avoid warnings in the build of htmldocs

Signed-off-by: Jó Ágila Bitsch <jgilab@gmail.com>
---
 include/linux/usb/composite.h | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/include/linux/usb/composite.h b/include/linux/usb/composite.h
index 91d22c3ed458..7ef8cea67f50 100644
--- a/include/linux/usb/composite.h
+++ b/include/linux/usb/composite.h
@@ -432,6 +432,10 @@ static inline struct usb_composite_driver *to_cdriver(
  * @qw_sign: qwSignature part of the OS string
  * @b_vendor_code: bMS_VendorCode part of the OS string
  * @use_os_string: false by default, interested gadgets set it
+ * @bcd_webusb_version: 0x0100 by default, WebUSB specification version
+ * @b_webusb_vendor_code: 0x0 by default, vendor code for WebUSB
+ * @landing_page: empty by default, landing page to announce in WebUSB
+ * @use_webusb:: false by default, interested gadgets set it
  * @os_desc_config: the configuration to be used with OS descriptors
  * @setup_pending: true when setup request is queued but not completed
  * @os_desc_pending: true when os_desc request is queued but not completed
-- 
2.37.2

