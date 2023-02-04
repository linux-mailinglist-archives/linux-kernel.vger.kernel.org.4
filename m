Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9D76968A9BF
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Feb 2023 13:15:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232340AbjBDMPI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Feb 2023 07:15:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44042 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbjBDMPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Feb 2023 07:15:06 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E962613DD3;
        Sat,  4 Feb 2023 04:15:04 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id mf7so22173709ejc.6;
        Sat, 04 Feb 2023 04:15:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=DcLZda2GIW9FF0wLQg8CZVOr2LxDbAuDjShayw2MbDs=;
        b=XUSif1Fp5FlrgbeYWO8T4vmfWe++TAT9Td+cvqsfyqMtthQx0Xoj5FeEkUIEnE/6j5
         Dk9QrMWsjSQR22ef2Q777/XZZ8xfQBUFLxt77eXVR3+ArQbzv+CfjHliDIohcb+FhA+X
         cyrGVEGMcGMb4Vn3r48iBxp2ZN9SkRuPQhfP5YedlgnG+GbYR9mfPkecROK1yA2QtTmf
         0ygi2Q6ptXh7H9hHj/zFGhrndz3RSvcwByLxkHHNdASlDu/x0BNaUQBVD0vHSJLO5ruU
         SDb0x3ZTeDskoiV2uyEFxubWaoVRvEni4TfFOKeqsyIl/2pdcI9Bh0XdPYpj+xNKA492
         mpbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=DcLZda2GIW9FF0wLQg8CZVOr2LxDbAuDjShayw2MbDs=;
        b=v1DNpUdnSiboHLOkLw2X2yjG78YdZ1g606CJ7T5atgSHzHIhaT7A5J7BlAYcpcCE6+
         RU5U5WmwoV7AunavzvlVxgtHTFQa72rQfihpzYWTZZHDORX51ZbesWK3ZrOwsrHOITDb
         vfeTIrvkd4HmuaWtswU/EgC0A1+xwGbmPaeYNncZnCZ67DwN5jFtL3pCjtaNgD0gJO5S
         ehiXrFyJHJRmJsTW1nUGJzVhI9+2+B47DLZwSkDByj6PDUHVvtxMULEdI5wI14RlYdYa
         a8oX9dGuXw7sOR5bXGmLeo2OumdtNA8nJGRKMK8aDUXKQ0fRBj21kUkQUmsnjPwQ8Jra
         H77w==
X-Gm-Message-State: AO0yUKX3uF8TjtCtf8hCX6m8dWvm7I2ZP3bQKBThkhwZGwc012CTMP5d
        yxTEjjdZUjYVnAB1uLHdUm/J/eXp668=
X-Google-Smtp-Source: AK7set+ROpQ9L9O2JG0p0RoOuhi61USNBoaXtEKd1Qx8CuJ6L6SlhQTol1M3dhr6th4/Cnid2s5A1A==
X-Received: by 2002:a17:907:7b99:b0:88d:ba89:1846 with SMTP id ne25-20020a1709077b9900b0088dba891846mr10375569ejc.23.1675512903081;
        Sat, 04 Feb 2023 04:15:03 -0800 (PST)
Received: from jo-einhundert ([2a02:908:13d6:2180:e7f7:5368:343b:83fd])
        by smtp.gmail.com with ESMTPSA id c21-20020a056402101500b004a2440f0150sm2402992edu.97.2023.02.04.04.15.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 04 Feb 2023 04:15:02 -0800 (PST)
Date:   Sat, 4 Feb 2023 13:15:01 +0100
From:   =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>
To:     Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-usb@vger.kernel.org
Subject: [PATCH v2] usb: gadget: add doc to struct usb_composite_dev
Message-ID: <Y95MRZZz3yC5lETB@jo-einhundert>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9kAryJ6Y2lQyKZK@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Added documentation to new struct members for WebUSB:
* bcd_webusb_version
* b_webusb_vendor_code
* landing_page
* use_webusb
to avoid warnings in the build of htmldocs

Fixes: 93c473948c58 ("usb: gadget: add WebUSB landing page support")
Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Jó Ágila Bitsch <jgilab@gmail.com>
---
V0 -> V1: added Reported-By and Fixes Tags
V1 -> V2: fixed Reported-by tag (capitalization of "-by" was wrong)
          also post to linux-usb

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

