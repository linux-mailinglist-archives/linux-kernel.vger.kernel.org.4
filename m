Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44DC36C41FC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Mar 2023 06:17:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229744AbjCVFRl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 01:17:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229664AbjCVFRj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 01:17:39 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF54159E64
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 22:17:07 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id j13so17515264pjd.1
        for <linux-kernel@vger.kernel.org>; Tue, 21 Mar 2023 22:17:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679462227;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=+XW/nloa73RsDbxvXcsiwU/r3yMnxVtzFID97L8lhtk=;
        b=NroJxHZ3oYEHTsjtJdI1uiPOX8c/Uk7CAOrHj26NwJT53hOgfDzI2W+u4LjXXZOBO9
         6nMqaGvBuGjcn5jt98Vl8WZK7zuikadpwiCzK2YTEs0Xl5O2WIWb4GVd2h+kLPApOyoK
         d02EhdJKL+AH6f6PCCTaAkS2igffFDsPgydE19v0gfEyPTXSplrlMdbyilqg8MopSPAj
         7KMcx5/0XvlrQF9vwLd7XADbWEGZQ1bssuDunGZMEyC3ZHMKd/EN21ZZkTdl6HVCL0NX
         v4rA7/rBkbs0jXgsOYwNX/0lh3AFYoshl+YcwniLwqyzEBUA54E69yBAKSB2TkfE4/yN
         eC6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679462227;
        h=content-disposition:mime-version:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+XW/nloa73RsDbxvXcsiwU/r3yMnxVtzFID97L8lhtk=;
        b=J7UFEUgDO93U66Z92wTdKBmA9jOU7GBhaaTpp/Hr/OO3V2UP1+o82GqOjbkH6GOuSj
         SGZfVCVYdY2NicVFmOc9GmW0iRlJHC4AMjyjcs/EQ9/fSaFTjHJiBkcw9AHvPsbzPim7
         +PJnyR9aKFSZzFh80pD2uQzmroaO/AIXTsmABT4awH73WycL8iysBUXSoXWaAPDXdoPN
         +icbTT1dw0fi5IEueKYi1QAm6aIZPkDcNZdtcwPiqz2pkyjMwNEfp1Qozoz7JDjJ1y1o
         1nfFS8bn3/mIIxjQ77wKzmoiZybP71mzgArCa2anIckeNPvVS0c9jZ6sZEri2RfkzkPi
         z3QA==
X-Gm-Message-State: AO0yUKXGzkRn2Kq4IO1zvGA5d/uhGWJOp04RjzoY5AWDcX+wUVidlm4k
        Vjjo3Q8rFoq5ZajfOoZ2IiqwwJW2Kg==
X-Google-Smtp-Source: AK7set8+oAj4xTeKbgtoNa9q/D3k1XzFG3O0u6jHtD+I1kKZd+c9s63e8Z4VOfMfUFgja/Uc432JqA==
X-Received: by 2002:a17:902:e5cf:b0:19d:7a4:4063 with SMTP id u15-20020a170902e5cf00b0019d07a44063mr1796838plf.46.1679462226864;
        Tue, 21 Mar 2023 22:17:06 -0700 (PDT)
Received: from mehmed-HP-Pavilion-Laptop-15-eh2xxx ([2401:4900:1c19:e99d:845:36b:5d36:1b42])
        by smtp.gmail.com with ESMTPSA id g5-20020a170902c38500b0019cbec6c17bsm9618653plg.190.2023.03.21.22.17.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 22:17:06 -0700 (PDT)
Date:   Wed, 22 Mar 2023 10:47:03 +0530
From:   Inshal Khan <kziaul123@gmail.com>
To:     gregkh@linuxfoundation.org
Cc:     linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] Staging: rtl8712: osdep_intf: Remove RND4 macro.
Message-ID: <ZBqPTz9j4tjDxaHo@mehmed-HP-Pavilion-Laptop-15-eh2xxx>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RND4 macro was found to be not used anywhere in the project.
Therefore, it has been removed from rtl8712/osdep_intf.h to
simplify the code and reduce unnecessary overhead. In case the
need for rounding macros arises in the future, kernel rounding
macros will be used instead.

Signed-off-by: Inshal Khan <kziaul123@gmail.com>
---
 drivers/staging/rtl8712/osdep_intf.h | 5 -----
 1 file changed, 5 deletions(-)

diff --git a/drivers/staging/rtl8712/osdep_intf.h b/drivers/staging/rtl8712/osdep_intf.h
index 0e097b4a8670..446ee09159fc 100644
--- a/drivers/staging/rtl8712/osdep_intf.h
+++ b/drivers/staging/rtl8712/osdep_intf.h
@@ -17,11 +17,6 @@
 #include "osdep_service.h"
 #include "drv_types.h"
 
-#define RND4(x)	({ \
-			typeof(x) _x = (x); \
-			(((_x) + 3) & ~3); \
-		})
-
 struct intf_priv {
 	u8 *intf_dev;
 	/* when in USB, IO is through interrupt in/out endpoints */
-- 
2.34.1

