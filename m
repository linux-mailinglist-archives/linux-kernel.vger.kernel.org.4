Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0336328B4
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:54:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230176AbiKUPyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:54:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230083AbiKUPy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:54:28 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79974CB95F
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:54:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=13bL6LNTHjc49hw1t8dd+cr8coUyb0jg/mTexC5rZYA=; b=LcYJEoDuLEA+iEp2XldIp0x6sO
        cDK4ViwOPzWS0atHVRmRJIYugx1i71XJQTD3UD6xEv7YKU5H3+68xoDQ4ydlenqRUWLXsq6MVzbMq
        NHk2YvgQz5znt9jedC2wmP7fhgee9cuI9YoHT/YdDUD35fFshRGEPYwry6YYF1WVlkWsSxyWo5lXL
        NusRF5QwzT1c1Www6dY/rE13Xz82CXwMu/oOzPOw5tPtkZt1oXMNNJrFPcT7zOe3rhm03NiHUnORn
        i/fFa/63F7+6TSN/nO9vZ4omDuV0E7raom7v8GBZhTi5ktCX3Qpg0bSvgMtpaBRzHsk/JpPrwYWMB
        ME3Xf2xg==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:35360)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1ox97j-0000H6-L8; Mon, 21 Nov 2022 15:54:19 +0000
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1ox97h-0002UN-VG; Mon, 21 Nov 2022 15:54:17 +0000
Date:   Mon, 21 Nov 2022 15:54:17 +0000
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Geert Uytterhoeven <geert+renesas@glider.be>
Cc:     David Airlie <airlied@gmail.com>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH resend] drm/armada: Fix off-by-one error in
 armada_overlay_get_property()
Message-ID: <Y3ufKdApJGj6f97b@shell.armlinux.org.uk>
References: <788e97ac9b2aeee1941f274bf7b279b68c7592b6.1669045360.git.geert+renesas@glider.be>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <788e97ac9b2aeee1941f274bf7b279b68c7592b6.1669045360.git.geert+renesas@glider.be>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 21, 2022 at 04:43:14PM +0100, Geert Uytterhoeven wrote:
> As ffs() returns one more than the index of the first bit set (zero
> means no bits set), the color key mode value is shifted one position too
> much.
> 
> Fix this by using FIELD_GET() instead.

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 40Mbps down 10Mbps up. Decent connectivity at last!
