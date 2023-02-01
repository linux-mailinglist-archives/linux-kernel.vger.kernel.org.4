Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EE59686ED1
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Feb 2023 20:20:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230487AbjBATUg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Feb 2023 14:20:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231678AbjBATUd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Feb 2023 14:20:33 -0500
Received: from lahtoruutu.iki.fi (lahtoruutu.iki.fi [IPv6:2a0b:5c81:1c1::37])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AD641E5F0;
        Wed,  1 Feb 2023 11:20:32 -0800 (PST)
Received: from darkstar.musicnaut.iki.fi (85-76-35-32-nat.elisa-mobile.fi [85.76.35.32])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: aaro.koskinen)
        by lahtoruutu.iki.fi (Postfix) with ESMTPSA id 5868D1B00248;
        Wed,  1 Feb 2023 21:20:24 +0200 (EET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi; s=lahtoruutu;
        t=1675279224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=fL9xImrt7Nwbx9SFjibJbY2B9hcU+y/1mA5wJqqX76Q=;
        b=NUXRMNdrjoW68pAldoxmdXLZCWQqbYeEw8Nw0+ufmCeLVLa72/tGWsgvWRYRNnZk5sr9We
        A7TWqmrEyUHTfdg2/4D/Aq+sNsvWRqeZKpVOf5gpyrGU637PbWW+DanqcVIfmEDzFPR/iU
        euEdY9CPw+j5SoKbdIwz0zp+5WWJ0C4qDTav3MbD/kVStpqbdHNx0TAvDsZl2DPT5h6VIZ
        jYqko8HVo5AcJkVH+13yZx59KKTGyiFBYKZfONvMPdIXJW7qwXprCkdK4IK2TKPL8RmFUD
        /70iVJ4c2f7Fjw9Tee48+rxmdd9dt0KjilEAV4McXz6os4WwdSRXSGlZh1WoQQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=iki.fi;
        s=lahtoruutu; t=1675279224;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type;
        bh=fL9xImrt7Nwbx9SFjibJbY2B9hcU+y/1mA5wJqqX76Q=;
        b=gwyVN4obzLpHCRV5eAvYtO4UBAVUZoIe6kd8YiQZTkIlGv90Fz2IuYdTNE2HKiL16sfRaF
        dK+uCtX0I8lJTX50S+ZSeDnfHyzhQIVhbiJiwwtV3VcK6XB9gUwcc/PCeXWUwvrLL3rztZ
        ErazERBv2RH06NLl/1x9HBAhrQSY/xI4GB9V+2GFwr1TBYsd5M9rbEY+E5d+fsGbY4d8BM
        NN9eRLGzgMND+8CQ3HrIGUfBcJ0RNPM/yUwPE+eAnZxTRcfdC5ckF/55g9bvckOTV1vb73
        BGFBDXhEdzFK+QJyhAL4ZjkjnzpZHziBYzIsHiOMeG2lAH4mm4NRh3zzvSHIpg==
ARC-Authentication-Results: i=1;
        ORIGINATING;
        auth=pass smtp.auth=aaro.koskinen smtp.mailfrom=aaro.koskinen@iki.fi
ARC-Seal: i=1; s=lahtoruutu; d=iki.fi; t=1675279224; a=rsa-sha256;
        cv=none;
        b=AgbmDJY6om6zPxHf3l/oeSzYvg31l3bnyzeWOIZ+ui1KghqnjKLNdHO1Tjef/1cNnIqjeQ
        DDutFU9LMUmfht3+AxNPZ4/O0KQ+Rjy6jNXoPsgInJbEkdyRTcVzUodW+379TqLHfME4r0
        L+inVYuFEeMR1Ho5UfEBO9+cbWU/LK2dnM5RGmYNxy1oHolCxKiBNMxKh3Ppg+WbiJIIP7
        cK8ObAAOCmW4BRhwlZnIfXX8kfBBxbWUcAt1kgDOhWYDj178ZYxJMAFgp1kogZ4zhhy+4I
        0+m3hqD5KpMrhzwGbYe/HVF7QSceClT9er7DzGSY74V7RoERfBD8Cx5xhIfPiA==
Date:   Wed, 1 Feb 2023 21:20:22 +0200
From:   Aaro Koskinen <aaro.koskinen@iki.fi>
To:     Alan Stern <stern@rowland.harvard.edu>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [BUG REPORT] USB UDC/gadget regression
Message-ID: <20230201192022.GC2415@darkstar.musicnaut.iki.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

After commit fc274c1e9973 ("USB: gadget: Add a new bus for gadgets"),
g_ether started to crash on modprobe when used with OMAP UDC.

It seems that because of drv->bus getting set to NULL in the middle of
bus_add_driver() things go wrong.

The below simple change seems to fix it, but I'm not sure if this is
the correct way? Many drivers seem to be doing the same in UDC start -
are they really all broken?

diff --git a/drivers/usb/gadget/udc/omap_udc.c b/drivers/usb/gadget/udc/omap_udc.c
index 6e9314e95be3..47d83bbb09e3 100644
--- a/drivers/usb/gadget/udc/omap_udc.c
+++ b/drivers/usb/gadget/udc/omap_udc.c
@@ -2062,7 +2062,6 @@ static int omap_udc_start(struct usb_gadget *g,
 	udc->softconnect = 1;
 
 	/* hook up the driver */
-	driver->driver.bus = NULL;
 	udc->driver = driver;
 	spin_unlock_irqrestore(&udc->lock, flags);
 
A.
