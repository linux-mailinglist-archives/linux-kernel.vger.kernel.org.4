Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40F096CA68A
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Mar 2023 15:54:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232506AbjC0Nyn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Mar 2023 09:54:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232440AbjC0Nyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Mar 2023 09:54:40 -0400
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EEE840CB;
        Mon, 27 Mar 2023 06:54:39 -0700 (PDT)
Received: by mail-wm1-x334.google.com with SMTP id j18-20020a05600c1c1200b003ee5157346cso7443221wms.1;
        Mon, 27 Mar 2023 06:54:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679925278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc:subject:date
         :message-id:reply-to;
        bh=0+PBefwwA/8SDowfJGLvUl2uQWAWydxb8mElV9hUD3w=;
        b=bq2SoY9RGw78zJV4Vk+d+s7AF12STxfknIf73mFQb1ftDrifYYIPvgVe9EQrQaADZf
         uOfV8lmRpSTbYhe8QYdMZkrgIZdw8ghjxobiMvQrojzOLsnMtUPh5z2y1ssDGlzg1JoD
         dyq5p6v9KE6PKlX2aBHblirxLIvTZpzzkrQqqmjQ8UszV6+W0M1FmzsWBPjdhTrY89Z8
         Nl0DUt2hurBv7/Wmb16t1TSxihKivXD7mMsflCfjLdMzssPdCFAj7PyVHIrRBEF+KE2p
         1sPx6Lx2ovAfPprq1YAsNQDd1DnBRmb8IpL69BTsw1Cg3TCW7KDv6oDTdJ6Eksl1oz/F
         37Ew==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679925278;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=0+PBefwwA/8SDowfJGLvUl2uQWAWydxb8mElV9hUD3w=;
        b=PHMUgk0pEUVKcJpgjWwjOouBXnWga524tH1nJBBxdBVeFxwh0QkXURYHAL6f6rPpLY
         +Kvq9VcZR0p61OaXYYNl/LW7cebmaKLQpvVq98zyvTUlKszX27WExi26FcrHYNf+HslB
         uxSBst/exAREqB0JN8Y9KVpfl8fdnOWH9vlMXbMaAkjJSlpyyDJGWzn18O71T4X50uAM
         CLbnx0w6+UWjE7OrqcTVQgfWKyJXfbeakxFyz0YK3kQ5syNh9Fh+SG8kYhMKrWFkRSyo
         bia/LL8TfMR9XcNoHkLwIsKe9Rd5w99A5s+roCri1pCtUEmaXWeZt9Y8jxitTXlf7Wrc
         HdMg==
X-Gm-Message-State: AO0yUKXR3AClCxVJXgDjbDKjOg4NK6WFV3DamaAp2r1h7WMEzJJl/D9I
        pTJCiOntqoowU9fktQGs8gI=
X-Google-Smtp-Source: AK7set82w54kCKwi0rbXLRUzsG0cZqQY02Pr84jjvrie+fMfGLGh0OIDdv8NdWLsu+1A+3Lez41o5Q==
X-Received: by 2002:a05:600c:378d:b0:3ea:f6c4:5f3d with SMTP id o13-20020a05600c378d00b003eaf6c45f3dmr9670402wmr.2.1679925277821;
        Mon, 27 Mar 2023 06:54:37 -0700 (PDT)
Received: from localhost.localdomain (212-59-15-122.static.zebra.lt. [212.59.15.122])
        by smtp.gmail.com with ESMTPSA id u11-20020a05600c00cb00b003ef64affec7sm7371244wmm.22.2023.03.27.06.54.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Mar 2023 06:54:37 -0700 (PDT)
From:   Yaroslav Furman <yaro330@gmail.com>
X-Google-Original-From: Yaroslav Furman <Yaroslav.Furman@verifone.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     yaro330@gmail.com, Alan Stern <stern@rowland.harvard.edu>,
        linux-usb@vger.kernel.org, usb-storage@lists.one-eyed-alien.net,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3] uas: Add US_FL_NO_REPORT_OPCODES for JMicron JMS583Gen 2
Date:   Mon, 27 Mar 2023 16:54:23 +0300
Message-Id: <20230327135423.607033-2-Yaroslav.Furman@verifone.com>
X-Mailer: git-send-email 2.39.2
In-Reply-To: <20230327135423.607033-1-Yaroslav.Furman@verifone.com>
References: <ZA12pMgwA/8CguYd@kroah.com>
 <20230327135423.607033-1-Yaroslav.Furman@verifone.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Yaroslav Furman <yaro330@gmail.com>

Just like other JMicron JMS5xx enclosures, it chokes on report-opcodes,
let's avoid them.

Signed-off-by: Yaroslav Furman <yaro330@gmail.com>

---

V3: Moved the code in the appropriate place, after the 0x0578 device,
as pointed out by Alan Stern
---
 drivers/usb/storage/unusual_uas.h | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/drivers/usb/storage/unusual_uas.h b/drivers/usb/storage/unusual_uas.h
index c7b763d6d102..1f8c9b16a0fb 100644
--- a/drivers/usb/storage/unusual_uas.h
+++ b/drivers/usb/storage/unusual_uas.h
@@ -111,6 +111,13 @@ UNUSUAL_DEV(0x152d, 0x0578, 0x0000, 0x9999,
 		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
 		US_FL_BROKEN_FUA),
 
+/* Reported by: Yaroslav Furman <yaro330@gmail.com> */
+UNUSUAL_DEV(0x152d, 0x0583, 0x0000, 0x9999,
+		"JMicron",
+		"JMS583Gen 2",
+		USB_SC_DEVICE, USB_PR_DEVICE, NULL,
+		US_FL_NO_REPORT_OPCODES),
+
 /* Reported-by: Thinh Nguyen <thinhn@synopsys.com> */
 UNUSUAL_DEV(0x154b, 0xf00b, 0x0000, 0x9999,
 		"PNY",
-- 
2.39.2

