Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84F8B6DA09A
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Apr 2023 21:02:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240544AbjDFTB4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Apr 2023 15:01:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240386AbjDFTBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Apr 2023 15:01:32 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86BE8AD08
        for <linux-kernel@vger.kernel.org>; Thu,  6 Apr 2023 12:01:08 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54bfc4e0330so48451257b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 06 Apr 2023 12:01:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680807667;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=M+j5aQ/96ezpNDW1vgfpLxhNNS1dVHH3UOwyvtk8Itw=;
        b=HgrdJsMEOQPONPSR/Gb7+Is6FMUn6IWRnMnV/yUeEnh9uu0LZ2hdI58AZun+fEfq85
         56LiwK9S6fceIM6v9s3vEBVF57PerYY32kMf0s7egW/xPmg3O7NCHUhLURdTFjIkJHar
         fx19aLOd1cqYDPTWFpT0o7ic73WoYVXPvWcbBo6hmuKyL9rrkGVMofD+uh8lAPLyI8Rk
         1xUS5G9H9IddFzzrRVUOTB7GlRX0gqwpxniORH5FrVG7jlZpVZkr7+GGgGje7u2PJxEf
         9iiL8N4eQBlRopxXgJVrHAB/6K8INKutqicQk1VMw/ljc89khh1DhFrL2L+vVFKvojZk
         EYiw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680807667;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M+j5aQ/96ezpNDW1vgfpLxhNNS1dVHH3UOwyvtk8Itw=;
        b=kNZ+ICaXVoM0yeicTjGGz1bzdVoq5j/hZE4nr4YEF+YbA+t0xdd+94zle5yNOYKN+V
         SKH2GYK0X/4o/jXRMGQtyCK/d7mc5+fT2TUo4rFaz/q99eGW6O7G5pz2EE0DBJd4eF1E
         MRZJ8hZL82vlKTjNHwTGZeqgtDRH6LvCEzvEDeYRV14BVuomSbGBRrRUpVc7gchFCyd4
         oFJ3Um3+547HXFiSd3+Nzw+O7/SmcCnByhuNmrI/IL4chfVCBdFwNty0MMeXgAY+S7cB
         n2umPPIZ2NjPlHzxC86ZQacFIP3rIzwyV74ZjeNVe8skAwdcX3WCDDl9vd3Vs8VK6b53
         qwHA==
X-Gm-Message-State: AAQBX9dB1zZ8/kgsRHQo4t2O/wpAc6xf+gp5zs2LpzTIOMraJiLS1Ybh
        DWghkEPoiKPWJhhza1F+h31RUiuuieOopRo=
X-Google-Smtp-Source: AKy350ZPBPvYArlTUHfBAIsSIdCLRqDyqZwRoWsoQhyrepd+MVYiDIkO59WJizadi3iwpqKF3i7yQRnRE3QGOEQ=
X-Received: from allenwebb.c.googlers.com ([fda3:e722:ac3:cc00:2b:ff92:c0a8:12e8])
 (user=allenwebb job=sendgmr) by 2002:a25:76c6:0:b0:b8b:ee74:c9d4 with SMTP id
 r189-20020a2576c6000000b00b8bee74c9d4mr251123ybc.12.1680807667734; Thu, 06
 Apr 2023 12:01:07 -0700 (PDT)
Date:   Thu,  6 Apr 2023 14:00:29 -0500
In-Reply-To: <20230406190030.968972-1-allenwebb@google.com>
Mime-Version: 1.0
References: <20221219204619.2205248-1-allenwebb@google.com> <20230406190030.968972-1-allenwebb@google.com>
X-Mailer: git-send-email 2.40.0.577.gac1e443424-goog
Message-ID: <20230406190030.968972-11-allenwebb@google.com>
Subject: [PATCH v10 10/11] Documentation: Update writing_usb_driver for
 built-in modules
From:   Allen Webb <allenwebb@google.com>
To:     "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc:     gregkh@linuxfoundation.org, mcgrof@kernel.org,
        christophe.leroy@csgroup.eu, nick.alcock@oracle.com,
        Allen Webb <allenwebb@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Built-in modules that set id_table need to set MODULE_DEVICE_TABLE so
update the documentation accordingly.

Signed-off-by: Allen Webb <allenwebb@google.com>
---
 Documentation/driver-api/usb/writing_usb_driver.rst | 3 +++
 1 file changed, 3 insertions(+)

diff --git a/Documentation/driver-api/usb/writing_usb_driver.rst b/Documentation/driver-api/usb/writing_usb_driver.rst
index 95c4f5d14052..5f38e3bd469a 100644
--- a/Documentation/driver-api/usb/writing_usb_driver.rst
+++ b/Documentation/driver-api/usb/writing_usb_driver.rst
@@ -128,6 +128,9 @@ single device with a specific vendor and product ID::
     };
     MODULE_DEVICE_TABLE (usb, skel_table);
 
+The ``MODULE_DEVICE_TABLE`` should also be set for built-in USB drivers
+that provide an id_table, so that tools like USBGuard can properly
+associate devices with your driver.
 
 There are other macros that can be used in describing a struct
 :c:type:`usb_device_id` for drivers that support a whole class of USB
-- 
2.39.2

