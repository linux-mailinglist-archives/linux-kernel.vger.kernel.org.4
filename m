Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C518720B40
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 23:51:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236458AbjFBVvx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 17:51:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236128AbjFBVvu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 17:51:50 -0400
Received: from mail-ot1-x32e.google.com (mail-ot1-x32e.google.com [IPv6:2607:f8b0:4864:20::32e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6015B10C6;
        Fri,  2 Jun 2023 14:51:22 -0700 (PDT)
Received: by mail-ot1-x32e.google.com with SMTP id 46e09a7af769-6af7fef214cso1905237a34.0;
        Fri, 02 Jun 2023 14:51:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685742664; x=1688334664;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=9LyhjoS28aUESLXn6ZKM0bdRXh4cqYI4n9WNxwVEOj8=;
        b=LpYGwwBLSVmgNXEL85B7LFpRJ5Y36vn1pkemJFqJLcLVh6qzjgRGl8pDvSords0S8X
         ca+Cs8/qnSGrj2M09z6uyAxXQCVez41QjB+TEWD0wK0SxZEmtl6D+DjvmNSpv4N8l6Ak
         BWyvn+bFQuTZWbujitI6gScpUl1otUY8zfFeh0T0OQOCrrT7Ws8mzHqiZFHSER78H++i
         op9l7g3aCRngWqFx9nrYlu1Upwv/SCTc+vRh0w6PXWSp6TjT3bmRT5fRz/ejaxPkPUQH
         xtq+FOcFRXsBriECDXcy+1HOutZuqJko3PrzKROMcHhviCDbncu+PXZRHW6tkItSZoxZ
         8Egw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685742664; x=1688334664;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=9LyhjoS28aUESLXn6ZKM0bdRXh4cqYI4n9WNxwVEOj8=;
        b=GFN4PJX8U4mK4TKMORqkPatd2TEkE/kTQXau5QG9016xroK/AeaP2nH5T3/dc4D+jI
         MMHp2sJmtBPxQIRWO0/HlhQF1Br9G6/AtLrbEVDeb5aOIEWF6pRfRdtlbKydgcWj5nzt
         qY9PySN5n3S9qtfniQMVHpJ/HsisJ3YlT3DhgTRQU1kUU9Qe3KQHe2kfDkvZOZIhFnO2
         K8wGXgC6+4oGAxBwld9N53dIHB8rdRhXT8OrP3pwBupi9ePMpbEDeyAzgxy173IDzZwY
         c2mcipO2/mxDk8TIQJ/cJFHDuWVOhi94HY9zky0EulRBO62CxkHhJ0gGeXkTQEPog5Y8
         YIfA==
X-Gm-Message-State: AC+VfDxKwAKMXT8OQuaBQKHnUHE5QyGQFuclgl1iJAfhHA9H+b7Ur7dv
        KEGDFMx0P/tevB6X4l1rVD5CXPm/WBeWIw==
X-Google-Smtp-Source: ACHHUZ46Vxon1WXTeWKbHhazSe/lclkMMiBqLCynxDoI400iszcQFoOb5Ezi3x5065rtpWkEdQ31Lg==
X-Received: by 2002:a9d:6255:0:b0:6af:6f7c:843f with SMTP id i21-20020a9d6255000000b006af6f7c843fmr1906673otk.7.1685742664559;
        Fri, 02 Jun 2023 14:51:04 -0700 (PDT)
Received: from madhu-kernel (99-145-207-128.lightspeed.austtx.sbcglobal.net. [99.145.207.128])
        by smtp.gmail.com with ESMTPSA id e17-20020a9d63d1000000b006af9405773dsm1042679otl.35.2023.06.02.14.51.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 02 Jun 2023 14:51:04 -0700 (PDT)
Date:   Fri, 2 Jun 2023 16:51:02 -0500
From:   Madhumitha Prabakaran <madhumithabiw@gmail.com>
To:     rafael@kernel.org, lenb@kernel.org, linux-acpi@vger.kernel.org,
        linux-kernel@vger.kernel.org, skhan@linuxfoundation.org
Cc:     ivan.orlov0322@gmail.com
Subject: [PATCH] docs: Fix warning:Error in "code-block" directive
Message-ID: <20230602215102.GA220958@madhu-kernel>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fix the error in "code-block" directive by providing the
argument as "text".

Signed-off-by: Madhumitha Prabakaran <madhumithabiw@gmail.com>
---
 .../firmware-guide/acpi/chromeos-acpi-device.rst          | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst b/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst
index f37fc90ce340..27292299ad17 100644
--- a/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst
+++ b/Documentation/firmware-guide/acpi/chromeos-acpi-device.rst
@@ -131,7 +131,7 @@ None
 Result code:
 ------------
 
-.. code-block::
+.. code-block:: text
 
    Package {
            Reserved1
@@ -192,7 +192,7 @@ None
 
 Result code:
 ------------
-.. code-block::
+.. code-block:: text
 
         Package {
                 Package {
@@ -265,7 +265,7 @@ None
 
 Result code:
 ------------
-.. code-block::
+.. code-block:: text
 
         Package {
                 NV Storage Block Offset  //DWORD
@@ -347,7 +347,7 @@ A package containing a list of null-terminated ASCII strings, one for each contr
 supported by the Chrome OS hardware device, not including the MLST method itself.
 For this version of the specification, the result is:
 
-.. code-block::
+.. code-block:: text
 
         Package {
                 "CHSW",
-- 
2.25.1

