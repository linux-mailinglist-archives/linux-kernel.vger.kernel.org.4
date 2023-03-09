Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E4206B21CC
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 11:46:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230094AbjCIKqF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 05:46:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbjCIKpj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 05:45:39 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A184CB855A;
        Thu,  9 Mar 2023 02:45:38 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id x11so1488511pln.12;
        Thu, 09 Mar 2023 02:45:38 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678358738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=OW6/6lfgOl+/I/V8WVarC0MKHx8gy98nLE1im9EecrI=;
        b=n4g/LLpWMmjOGaqXqJLiKPmyUceGYJcijlFBs6UUum3TZ880fU89PGkkQO15hhiKK8
         hvUWq6JVJ0+X2VXifW8jU7xOrZo55HkmyuoEd3KNUdIh3jUo4B1bxCM+VWwaj51HlfvQ
         JdHZ1At7NphCXnHxiMMQ8JU5YNhISI7ejAvLGQsmesbdXjFV/MiCgXScNVbVk3Fv2TzP
         0DT8omUQ5yuSy/8hqKICp2dvdDVKtbhebw4gesnhFcTZ3SIOyHQfKkaHx+lVc8sAg7GC
         /6EX/SlIhokq2LWF8+j+BQ2dqRqEJZ9EjKIm4XUMKF8T+pZ4bbobZn9TBf9ZteeJxf2w
         EGZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678358738;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=OW6/6lfgOl+/I/V8WVarC0MKHx8gy98nLE1im9EecrI=;
        b=jp1TV142Mp1dDKrCepONfWnDIkkRsMBGeijpECpznJ15J32LJj6Alm2MXRQneHaRMo
         g8od0Wbsy2+JUqxadyxf8qnlY/y+V9qWoGzhhMiJhoFehzg9ZHgmbwuq9rPgv7Wr5FXf
         d/NNwKBAngeg3RsCaLMg3nFYwfZ93cAnmpPNbF72y2Aa3lIsizzvOtPLuq0GUF7iqOAW
         skMRfeGF1CWRkr0sf+Y/E7fZZGicr0kMaX4eSmBpeiTmeLYGFBy/S0wksb1JGTOUlq2B
         ttjGToINphbDpZX1kYFDsEGfxU6wJgzWxzT2WrSgosfrrn+36N5BOTuZdSOrKgSR3h7R
         ulRA==
X-Gm-Message-State: AO0yUKVcUL502KbEppCX2SubODk+ciytyXHW8OrIbr8677OREa249GN0
        VVFBhwl5wxrrKa+nMJ1FllA=
X-Google-Smtp-Source: AK7set8nj8WlbSQzjyZM4sX3CMM6HMy67cT4xHiKp9CsZwF0yG+ucYBuDC94DNrFwTKNQ3zgMTKR6g==
X-Received: by 2002:a05:6a20:9390:b0:cc:a62f:1a9d with SMTP id x16-20020a056a20939000b000cca62f1a9dmr24966707pzh.23.1678358738150;
        Thu, 09 Mar 2023 02:45:38 -0800 (PST)
Received: from localhost.localdomain (124-148-239-17.tpgi.com.au. [124.148.239.17])
        by smtp.gmail.com with ESMTPSA id y24-20020a62b518000000b005a7c892b435sm10949574pfe.25.2023.03.09.02.45.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Mar 2023 02:45:37 -0800 (PST)
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     Mark Gross <markgross@kernel.org>,
        platform-driver-x86@vger.kernel.org, linux-kernel@vger.kernel.org,
        Orlando Chamberlain <orlandoch.dev@gmail.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Subject: [PATCH 1/1] apple-gmux: Update apple_gmux_detect documentation
Date:   Thu,  9 Mar 2023 21:43:54 +1100
Message-Id: <20230309104353.10905-1-orlandoch.dev@gmail.com>
X-Mailer: git-send-email 2.39.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit fc83fbc80e1a ("platform/x86: apple-gmux: refactor gmux types")
neglected to update the documentation of apple_gmux_detect's arguments.
Update the documentation to reflect that commit's changes.

include/linux/apple-gmux.h:99: warning:
	Function parameter or member 'type_ret' not described in 'apple_gmux_detect'
include/linux/apple-gmux.h:99: warning:
	Excess function parameter 'indexed_ret' description in 'apple_gmux_detect'

Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
Link: https://lore.kernel.org/lkml/20230309122822.77435e33@canb.auug.org.au/
Fixes: fc83fbc80e1a ("platform/x86: apple-gmux: refactor gmux types")
Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
---
 include/linux/apple-gmux.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/include/linux/apple-gmux.h b/include/linux/apple-gmux.h
index 272f63f8fd7c..a7a7d430024b 100644
--- a/include/linux/apple-gmux.h
+++ b/include/linux/apple-gmux.h
@@ -86,7 +86,7 @@ static inline bool apple_gmux_is_mmio(unsigned long iostart)
  * apple_gmux_detect() - detect if gmux is built into the machine
  *
  * @pnp_dev:     Device to probe or NULL to use the first matching device
- * @indexed_ret: Returns (by reference) if the gmux is indexed or not
+ * @type_ret: Returns (by reference) the apple_gmux_type of the device
  *
  * Detect if a supported gmux device is present by actually probing it.
  * This avoids the false positives returned on some models by
-- 
2.39.2

