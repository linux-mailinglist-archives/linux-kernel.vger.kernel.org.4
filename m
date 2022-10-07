Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6DC7A5F7EE6
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 22:35:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiJGUfN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 16:35:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiJGUfG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 16:35:06 -0400
Received: from mail-wm1-x32a.google.com (mail-wm1-x32a.google.com [IPv6:2a00:1450:4864:20::32a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07E84151C;
        Fri,  7 Oct 2022 13:35:02 -0700 (PDT)
Received: by mail-wm1-x32a.google.com with SMTP id iv17so3542287wmb.4;
        Fri, 07 Oct 2022 13:35:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:from:to:cc:subject:date:message-id:reply-to;
        bh=eAZ+qkXDXQxhybmpEVudKGXqy+FOYvvtvTW3/3P6xc4=;
        b=OEH5qQ9HbftMfggzW1MXzuzAbSXlsGWSI8v2Y7HW6NJ9gyPAy+DbHUdn1YOVoE7Q2S
         OeEwH6yXMTGDC8b998q7Lp4o9s1oMt4K6pu04HBI7G9D/XdocUnSMjVv8OGoXNWGRMBN
         qW15Whnb5fAgQH47L/TMvxX2wMYtZZGe2uk8R8DMBv5YAhUDhOmnNk0w2/4Xw8DYE5A3
         Oqxt2KEBMxFf+j+quLL+QW/2W3JUZoUv0SXZHZiZI+MGnLSkEZQWV8UHB6plAwQ1iIb4
         8FI4xY2mUJjcRF6ASxESDbP6leSAmZc36/agmiv7gsD3wT8d6+DeAAxdmk9+bEz94Ffg
         tI/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc
         :to:from:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=eAZ+qkXDXQxhybmpEVudKGXqy+FOYvvtvTW3/3P6xc4=;
        b=BHoJItFATMXt0O6w8O39JmiHeHjE30hi1spPQA19GpjAZ/qnQia8G3XfYG5izpr77+
         lpysOaQvixtJ2LBrn9TlOJu/mSOMU8AgQ48lsD9Iyx5DJ5T5BHo5pO+CnwceSPbcIKyu
         cX6xWThVFkEDq/VY6f8agv9+psama9EAk9Ts6Q7egFAURvvb6/G6n+Oa36uqV3PCYEyC
         N6QWXbq2xpNbPTTc3WvKQs/ukt1U+DByEDx64hGwSv60/3nBRRcq0cbdPC9lIlGmrDML
         ePtQpQTJPUctdYKOf/hrt8zUj2TIXP3wFP5GJ8VKX/7oM5fAgNW7yDN06tpIW66tAzMJ
         z+Aw==
X-Gm-Message-State: ACrzQf1nXKgxonbBfpgV9aOXsUMimJspdoKVU3Rshk2FSgpXiuSnZ9+T
        nvONQhJhXyjcRt0kzBtM07Q=
X-Google-Smtp-Source: AMsMyM4CKIHDZoGddh2wMguI39VshoESTcUZatEZKQ9RPfSxxCAvYDZIiTWTWyr5m5Cyec5F076sYg==
X-Received: by 2002:a05:600c:524b:b0:3b4:8c0c:f3b6 with SMTP id fc11-20020a05600c524b00b003b48c0cf3b6mr12110120wmb.50.1665174901421;
        Fri, 07 Oct 2022 13:35:01 -0700 (PDT)
Received: from localhost (cpc154979-craw9-2-0-cust193.16-3.cable.virginm.net. [80.193.200.194])
        by smtp.gmail.com with ESMTPSA id q6-20020a05600c46c600b003c3c2df83ddsm1603609wmo.26.2022.10.07.13.35.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Oct 2022 13:35:00 -0700 (PDT)
From:   Colin Ian King <colin.i.king@gmail.com>
To:     Juergen Gross <jgross@suse.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        xen-devel@lists.xenproject.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] xen: Kconfig: Fix spelling mistake "Maxmium" -> "Maximum"
Date:   Fri,  7 Oct 2022 21:35:00 +0100
Message-Id: <20221007203500.2756787-1-colin.i.king@gmail.com>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
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

There is a spelling mistake in a Kconfig description. Fix it.

Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
---
 drivers/xen/Kconfig | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index a65bd92121a5..d5d7c402b651 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -56,7 +56,7 @@ config XEN_MEMORY_HOTPLUG_LIMIT
 	depends on XEN_HAVE_PVMMU
 	depends on MEMORY_HOTPLUG
 	help
-	  Maxmium amount of memory (in GiB) that a PV guest can be
+	  Maximum amount of memory (in GiB) that a PV guest can be
 	  expanded to when using memory hotplug.
 
 	  A PV guest can have more memory than this limit if is
-- 
2.37.3

