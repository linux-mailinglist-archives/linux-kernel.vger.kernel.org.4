Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A5F863A0A2
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 05:40:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229659AbiK1EkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 27 Nov 2022 23:40:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiK1EkO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 27 Nov 2022 23:40:14 -0500
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6110CBE29
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 20:40:13 -0800 (PST)
Received: by mail-pl1-x633.google.com with SMTP id p12so9042354plq.4
        for <linux-kernel@vger.kernel.org>; Sun, 27 Nov 2022 20:40:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=oregonstate-edu.20210112.gappssmtp.com; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=G/9AzJYQfnGBFuJKCpS/EOwpF4BmCDb2G2Md0YyKoN8=;
        b=r/+ASjtBdyMIkIrVJYRjrKRI0h/rUHKiSZfn8eEro0QAEKW+TMKjMK+MbR33Mke743
         PHeYk5s1uinHTcHiXqPvC9RqNLF6GksEJa9a/U+mHF03Rln351l33u+smYV/aWa+rg+V
         LPz8yrEH9TC02uVjgVDGitAsLi/eYiHitLHQCBZR4c0+tjh4+Q6z5JTwCdR33bAe7Yj1
         45TXrUYS9IiemxQf2DRqnJvJ3MnpiKlGGHIu0wE+h6TnqpHftgQ+xYtxOYJwNwPqJman
         R/2hTnNh8yw4xlkTbBnsVRHqwvjsEQhW5CnOMlP2YiIzgUGZex/gRk6iJUqNVJFMQIrw
         F5BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-disposition:mime-version:message-id:subject:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=G/9AzJYQfnGBFuJKCpS/EOwpF4BmCDb2G2Md0YyKoN8=;
        b=EWp/Txg1wS/fNYSm4SPiqbJZCxYm06E6iJZUsMY8GNAslVn115oogLZb5HLPqgWBA2
         kQ4XCmqrFcEhihY+QLbNs7SfOcmsfmJSv5DbgbKLSs+cSYwn4bEyLmzML3ty8INVDOxU
         xaCglpc3KcueOZ+SYFb446/L2tcLz0jauv/uOiZxX32ID/CFHJu7MvpkgRAzG9DXq7YW
         GTeapMzP5lKw79RTjUc/HcPU3YVy3dfjUaSgRfRjLw+zb6NG1t/UbF7VtnV1cG6Tg9xA
         GR5tOv++bBpZ6BVIO6oVR5v7nQR+OrgwiU1SO7T+cP3gGthSpjLEe5jO+9FF7F5ehNQ+
         wMyg==
X-Gm-Message-State: ANoB5pm89tIiJ++gdqzHh7Azg1NC2vug98wfhaCzjUzPkN/6E6+VG0T2
        oOpC1oG+HejVzQgUrTsOov34YQ==
X-Google-Smtp-Source: AA0mqf5v10Ko3O6yyi4Ky8KDwcQdwVFHTKXAvTPwcuGagHrSnR96zCSsegjWmvbT2lP3KTRl7w9NqA==
X-Received: by 2002:a17:90a:b018:b0:214:247a:1932 with SMTP id x24-20020a17090ab01800b00214247a1932mr52659887pjq.187.1669610412939;
        Sun, 27 Nov 2022 20:40:12 -0800 (PST)
Received: from virt ([76.27.231.73])
        by smtp.gmail.com with ESMTPSA id j5-20020a170903024500b0017f9db0236asm7755180plh.82.2022.11.27.20.40.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 27 Nov 2022 20:40:12 -0800 (PST)
Date:   Sun, 27 Nov 2022 20:40:12 -0800
From:   Jack Schofield <schofija@oregonstate.edu>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
Subject: [PATCH] staging: emxx_udc: Remove unneeded parentheses
Message-ID: <20221128044012.GA2028@virt>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Parentheses are not required around condition tests. Remove to follow
Linux Kernel coding style. Issue reported by checkpatch.

Signed-off-by: Jack Schofield <schofija@oregonstate.edu>
---
There are more instances of extra parens to cleanup. If this patch is
welcome I can continue to cleanup this file.

 drivers/staging/emxx_udc/emxx_udc.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/staging/emxx_udc/emxx_udc.c b/drivers/staging/emxx_udc/emxx_udc.c
index b4e19174bef2..1d4ac8374fe2 100644
--- a/drivers/staging/emxx_udc/emxx_udc.c
+++ b/drivers/staging/emxx_udc/emxx_udc.c
@@ -149,8 +149,8 @@ static void _nbu2ss_ep0_complete(struct usb_ep *_ep, struct usb_request *_req)
 			/* SET_FEATURE */
 			recipient = (u8)(p_ctrl->bRequestType & USB_RECIP_MASK);
 			selector  = le16_to_cpu(p_ctrl->wValue);
-			if ((recipient == USB_RECIP_DEVICE) &&
-			    (selector == USB_DEVICE_TEST_MODE)) {
+			if (recipient == USB_RECIP_DEVICE &&
+			    selector == USB_DEVICE_TEST_MODE) {
 				wIndex = le16_to_cpu(p_ctrl->wIndex);
 				test_mode = (u32)(wIndex >> 8);
 				_nbu2ss_set_test_mode(udc, test_mode);
@@ -287,7 +287,7 @@ static int _nbu2ss_epn_exit(struct nbu2ss_udc *udc, struct nbu2ss_ep *ep)
 	u32		num;
 	u32		data;
 
-	if ((ep->epnum == 0) || (udc->vbus_active == 0))
+	if (ep->epnum == 0 || udc->vbus_active == 0)
 		return	-EINVAL;
 
 	num = ep->epnum - 1;
-- 
2.25.1

