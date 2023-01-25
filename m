Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB8B167BE9F
	for <lists+linux-kernel@lfdr.de>; Wed, 25 Jan 2023 22:34:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235303AbjAYVeS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 Jan 2023 16:34:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236735AbjAYVeQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Jan 2023 16:34:16 -0500
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B872E5BB6;
        Wed, 25 Jan 2023 13:33:50 -0800 (PST)
Received: by mail-ej1-x62d.google.com with SMTP id ss4so31137ejb.11;
        Wed, 25 Jan 2023 13:33:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:to:from:date:from:to:cc:subject
         :date:message-id:reply-to;
        bh=6n5jLL5ph6VO5rm/KwnIygzlxq5cwf2QkTHEzDecDts=;
        b=RZj4rDmYVuT9ph4Y5/AOAu1pjAAq4x5heKsFkBfAzWMHPneMLJBqYvOcYKEehbZFdl
         BL8mM1xxQv8ZVxP5bi8zJxfacnnCEjzK4NGIJ/I8+twgB/su7K3vXBw7+N1Tp2emvPw3
         neq9ipUVtJKF0/iuXuGu7aTZFe6lTkZ8vvinJz0+mADTjfbCItATuZnQzrutV+OlmtUD
         w+Z2lCigim9WjrTTkopr7UGRtB/xjipDhk88a5dlww9INArOXj7vd+TssyCLOK+lrbZt
         kVJDCyTkf8fALXEfPy2dbsfEZ6hNLbYEs32nL6k3IlTe+l2MCZKSo0m3knQBqGoQql89
         39MQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:message-id:subject:to:from:date:x-gm-message-state
         :from:to:cc:subject:date:message-id:reply-to;
        bh=6n5jLL5ph6VO5rm/KwnIygzlxq5cwf2QkTHEzDecDts=;
        b=lMwcHm/+8bCGLulbw3zuS6K3V7ZsBcIfCUv81LwhMRqCW8Rj4LmGn6h55njXwfXBo4
         B4eVsIH2I0SEjg1+GSyCXoeqmvfYqQ9pOkIVob/f8VAU874nqWqRInNCDvC67MFvjTWZ
         XNDi0wjYKGlToCLpj53gbgYzY25xQD37FH1BXk9D5aGHH4TN2E/0y3nVPcYNGXtZmBZc
         g1wl+SIvY46gJe4pc5xhFvBNTs8pwDdHSZy+Bmky3SlF+aeoKsCFOlO8hZ8rI3WUyguh
         hKSTqvDRjXP73DMMfJ2ql9Flt1ixZrOHRYS+kDwGq/aJwfqjljaj92b4YdFkVA+Wdn8w
         NN8w==
X-Gm-Message-State: AFqh2ko83jXb64VvgCGxmaQH6oohuuGIJIXN45MsqKB2zayjphZbDzjb
        uvgyXFtuk0XFSaXr/ZPWmffAm92gy20=
X-Google-Smtp-Source: AMrXdXtFJ9dHCoW34mPFTdH5ix7Zv6ywMoyj24QFi8jRZYbPbY8oLn6P/0ku7HN0wP/vimKdzwOzEw==
X-Received: by 2002:a17:906:f0d1:b0:84d:450b:8767 with SMTP id dk17-20020a170906f0d100b0084d450b8767mr34657883ejb.21.1674682428818;
        Wed, 25 Jan 2023 13:33:48 -0800 (PST)
Received: from jo-einhundert ([2a02:908:13d6:2180:956c:5c0b:c22:76b8])
        by smtp.gmail.com with ESMTPSA id i25-20020a170906265900b007ae10525550sm2885474ejc.47.2023.01.25.13.33.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 25 Jan 2023 13:33:48 -0800 (PST)
Date:   Wed, 25 Jan 2023 22:33:47 +0100
From:   =?iso-8859-1?Q?J=F3_=C1gila?= Bitsch <jgilab@gmail.com>
To:     Greg KH <greg@kroah.com>, Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: [PATCH v1] usb: gadget: add doc to struct usb_composite_dev
Message-ID: <Y9FmWVF+J08V4RbP@jo-einhundert>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Y9Fokec99g+c31P2@kroah.com>
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
Reported-By: Stephen Rothwell <sfr@canb.auug.org.au>
Signed-off-by: Jó Ágila Bitsch <jgilab@gmail.com>
---
V0 -> V1: added Tested-By and Fixes Tags


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

