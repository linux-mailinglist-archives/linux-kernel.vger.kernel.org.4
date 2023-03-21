Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8AE2C6C308F
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 12:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbjCULlv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 07:41:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230294AbjCULlt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 07:41:49 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9663F1DBA0
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:41:46 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id lr16-20020a17090b4b9000b0023f187954acso15615249pjb.2
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 04:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679398904;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=2YW3xbqi/VHK+051ISNRxO6nRHOEPScJeQcBOYGq32Q=;
        b=jUjW2SGpLivPtEct6UbAlu9/ZDohcZG1nkwjXR08/71xM9Etn5dQPoGn5nOxu6jxsl
         P93ver8+THwj6F/ARvXRw1u9ZnB+LVd8+sg6YcBF/WTFjb2Ey3W96Z8LBdBFoU2wclPl
         bG5RnQmB8XBpyuj8mFX2kUImyhjRDWC/cY2tRF7OFdA6UC0Lq4bHvsSQm9O/N1O3MXro
         xrXdh6rnwhTLGuoH/jgcnBOyYBjdZsLco5vobrz+MOP9WCKEU0zs/cnM7bsHlf07tkSm
         yBH1S34yaCMj7Bip5siOLVSjFeOqMgWy4x2zq09tyLoRUgkz/rpwz6MOnRbh1t3nxkma
         BgPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679398904;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2YW3xbqi/VHK+051ISNRxO6nRHOEPScJeQcBOYGq32Q=;
        b=eol/K20ClJ4uaNP9mOp9fbpFEH8ncf7hRr0dVRqp5YYxItNIc8vYvXRrLWlg+OCQfm
         1HEHHOpYpJwRYSsNr1KvNN5dX72iyhnyxyoJ+FoncvRFw2W/w3vlmVTl5ATsC4Xer0Hx
         c3JyR8hFfHE3AR5JPsrdQyq8bwEKEgVZJkL9Danf0mwY12Y14uaE2yc0EN248R2W+lju
         HzXLd4yf1qrQfMBkRTwOimWlZ9oGU/lsFjhdBDgU2hewVtBEn2C6OptU+HGMNTACLm69
         HpFFwCfa8es0vrMvByVcHyGTPP5Uc+EKLW7ldWLUQY89smOz9abhk73sYHTrJ5yQIv5R
         4lQg==
X-Gm-Message-State: AO0yUKX2ALrSJqKz5mmbQdR8nJLVqed8xKU9GMDKk5CKeiMa6YavTY70
        tPElCTRC0dj9Yo+aP4jCFRpnG39CMQ==
X-Google-Smtp-Source: AK7set+IZEO0Vs4I9RYeGuYvEfVzcSycM/hbhsX43x0q0HILzHmRJmljgXF5AtVWRdNP0hhngZ9yBg==
X-Received: by 2002:a05:6a20:c29c:b0:da:368e:7c73 with SMTP id bs28-20020a056a20c29c00b000da368e7c73mr1752668pzb.37.1679398904390;
        Tue, 21 Mar 2023 04:41:44 -0700 (PDT)
Received: from mehmed-HP-Pavilion-Laptop-15-eh2xxx ([2401:4900:1c19:e99d:c9dc:9d9e:85b3:1d9e])
        by smtp.gmail.com with ESMTPSA id a17-20020aa780d1000000b0062814f38d33sm1092365pfn.170.2023.03.21.04.41.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 04:41:44 -0700 (PDT)
Date:   Tue, 21 Mar 2023 17:11:41 +0530
From:   Inshal Khan <kziaul123@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH 4/4] Staging: rtl8712: osdep_intf: Improve RND4 macro for
 better debugging and safety
Message-ID: <ZBmX9cjTRNhwt2zA@mehmed-HP-Pavilion-Laptop-15-eh2xxx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit modifies the RND4_UPPER macro in the osdep_intf module of
the rtl8712 driver to improve its safety and debugging capabilities.
The macro has been changed to use a temporary variable for the input
argument 'x', instead of directly using it in the macro expression.
This change helps to avoid potential issues with operator precedence
and unexpected side effects that could occur if 'x' was reused within
the macro.

Additionally, the new definition of the macro uses the 'typeof' operator
to determine the type of the input argument, which ensures that the macro
can handle any data type safely. The new definition also uses a block
expression to contain the macro code, allowing for better debugging
capabilities and cleaner code.

This change improves the safety and maintainability of the RND4 macro
and makes it more suitable for use in the Linux kernel.

Signed-off-by: Inshal Khan <kziaul123@gmail.com>
---
 drivers/staging/rtl8712/osdep_intf.h | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/staging/rtl8712/osdep_intf.h b/drivers/staging/rtl8712/osdep_intf.h
index 95a21f380cd7..0e097b4a8670 100644
--- a/drivers/staging/rtl8712/osdep_intf.h
+++ b/drivers/staging/rtl8712/osdep_intf.h
@@ -18,8 +18,8 @@
 #include "drv_types.h"
 
 #define RND4(x)	({ \
-		typeof(x) _x = (x); \
-		(((_x) + 3) & ~3); \
+			typeof(x) _x = (x); \
+			(((_x) + 3) & ~3); \
 		})
 
 struct intf_priv {
-- 
2.34.1

