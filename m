Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E26A4646D49
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Dec 2022 11:42:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230143AbiLHKmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Dec 2022 05:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45696 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230302AbiLHKl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Dec 2022 05:41:57 -0500
Received: from mail-pg1-x52e.google.com (mail-pg1-x52e.google.com [IPv6:2607:f8b0:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EED97BC28
        for <linux-kernel@vger.kernel.org>; Thu,  8 Dec 2022 02:38:16 -0800 (PST)
Received: by mail-pg1-x52e.google.com with SMTP id q71so859379pgq.8
        for <linux-kernel@vger.kernel.org>; Thu, 08 Dec 2022 02:38:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=M2lPZXNnYaZfXCBCRIUyZWDNQjylf0hbf0UBlJrfz/k=;
        b=M5jMNnZc0kpzh1W89vr2cSHx8iB0ZQMi+Baymvf9KmFoLsJSqN2hkuhM6brjFdTl2r
         4bQJPCkGA2+9oYxQd0nLa8YA25Dx4R8RJ/538YUF3Jkv1AISb6Z6F7X2ihtWDFnrVtM6
         Qqkx4SJ3f+qcJ3hwVLq65KeokAReyOXjCDeQCL/BJ6rgQEakT3yhQq4OoC8RBEZGlkxn
         EosExUB/j/o2l13labvD/uY/viXxVTN0JfhxOChDjiwxf2FUqkmnH+EPI7gAgAJKhx6m
         KRSDx/POoxAfZvqtn6DtfPrHVpR9tG0kzn85Tv33S/8bA6AHfbbXfpOHZ8WYd4R9/w8q
         KLdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=M2lPZXNnYaZfXCBCRIUyZWDNQjylf0hbf0UBlJrfz/k=;
        b=gLHllAzmIHW41pL9arfTPshK+H6AXR/6EhlGDJ3NhZEPefFzds8a5HVaYq4XxW3Jar
         4WIpQxPK7miAnRWKH0W0BsPGv7edXmdUo+vxCBjBuv4mFXlwIhfbwS4l9FW8kPVhKbOQ
         0mDEW3/uMzjtP6xUhBF7/obROD89S2gsiQBWKUgmIiuLNoUEO6exoDG0sX0V4gzfhznH
         l8WZeuuDYa436c5Kuz8IYVOYYl8CB2Jmoig2X49z1mRS0onow0qjachE6FUfVdoUAnje
         bCwwJ+BSE7InxUIzWUgEd9SUIh4H23Uwp115VkJ6SRqy5RbLF1ZYZd6KwtZvmqaCMbKD
         HIAA==
X-Gm-Message-State: ANoB5plzELCPuPQfS3v1N0vvZsubnJPafrfQIUQcODboqfKOXLrJXDD0
        HoW1biuc87jprsXmHGStBhY=
X-Google-Smtp-Source: AA0mqf5d4knrkzHV7pR4E6vi1T2RFlGiHzlkJi+n9RWFS7YMv7uW5ascxTlKX05fa2mRIswMvBD+Jg==
X-Received: by 2002:a63:5762:0:b0:45f:97e8:d8a7 with SMTP id h34-20020a635762000000b0045f97e8d8a7mr85227822pgm.426.1670495895851;
        Thu, 08 Dec 2022 02:38:15 -0800 (PST)
Received: from zoo868e (1-170-0-91.dynamic-ip.hinet.net. [1.170.0.91])
        by smtp.gmail.com with ESMTPSA id f14-20020a170902684e00b0018699e6afd8sm16214054pln.265.2022.12.08.02.38.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 08 Dec 2022 02:38:15 -0800 (PST)
Date:   Thu, 8 Dec 2022 18:38:13 +0800
From:   Matt Jan <zoo868e@gmail.com>
To:     Martyn Welch <martyn@welchs.me.uk>,
        Manohar Vanga <manohar.vanga@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org, linux-staging@lists.linux.dev
Subject: [PATCH v2 1/3] staging: vme_user: add the spaces around the "*"
Message-ID: <20221208103813.GA100066@zoo868e>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a space around the "*" at vme_bridge.h to clear up a checkpatch
check.

Signed-off-by: Matt Jan <zoo868e@gmail.com>
---
 drivers/staging/vme_user/vme_bridge.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/staging/vme_user/vme_bridge.h b/drivers/staging/vme_user/vme_bridge.h
index 0bbefe9851d7..e17a8f7de165 100644
--- a/drivers/staging/vme_user/vme_bridge.h
+++ b/drivers/staging/vme_user/vme_bridge.h
@@ -4,7 +4,7 @@
 
 #include "vme.h"
 
-#define VME_CRCSR_BUF_SIZE (508*1024)
+#define VME_CRCSR_BUF_SIZE (508 * 1024)
 /*
  * Resource structures
  */
-- 
2.25.1
v2: Resend the correct patch set, noted by Greg Kroah-Hartmamn <gregkh@linuxfoundation.org>
