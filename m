Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EE1C65C490
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 18:06:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238305AbjACRGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 12:06:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238532AbjACRGS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 12:06:18 -0500
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA7681403E
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 09:02:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Date:Sender:Message-Id:Content-Type:
        Content-Transfer-Encoding:MIME-Version:Subject:Cc:To:From:Reply-To:Content-ID
        :Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:
        Resent-Cc:Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:
        List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=5bTeRA7Wa+rMuUkDwEr19koGJ9Y1JZKX6IAbWnhONOs=; b=buzyU+DwrFY83OetkEiJnc7Crf
        mtPoJtIdVVFzS2cfv8+wM9EJlpeUzfzzHblOsLlKZEpfXdqa5y4oJCWH7XOEipAZ41u2Am0NJyTck
        wE2q63qzPDE2AWatqJUD72A8Bw+t0qATOjfQLIOUYKqVLua1hOthLYUB4PERuZ3TYQ/HniKWkHZAO
        2+jeydnaCQ20LTpHLinIKyP18Hqee/AWWDK4gk7iIZ9XuGpfASHWEh0UtPrCoeZ85wK2ikMBDFNYa
        XmJVsnHVCiB83ajJ/oRXOpyxSiS/7OalPMeRikQYDHCi8mo7jge1yPQmcqPguNSA+gOypv6hLR0VQ
        GZnahUBQ==;
Received: from e0022681537dd.dyn.armlinux.org.uk ([fd8f:7570:feb6:1:222:68ff:fe15:37dd]:51294 helo=rmk-PC.armlinux.org.uk)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <rmk@armlinux.org.uk>)
        id 1pCkft-0005dK-US; Tue, 03 Jan 2023 17:02:05 +0000
Received: from rmk by rmk-PC.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <rmk@rmk-PC.armlinux.org.uk>)
        id 1pCkft-004hzL-0Q; Tue, 03 Jan 2023 17:02:05 +0000
From:   "Russell King (Oracle)" <rmk+kernel@armlinux.org.uk>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Keith Busch <kbusch@kernel.org>, Jens Axboe <axboe@fb.com>,
        Christoph Hellwig <hch@lst.de>,
        Sagi Grimberg <sagi@grimberg.me>
Cc:     linux-nvme@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: stop nvme matching for nvmem files
MIME-Version: 1.0
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
Content-Type: text/plain; charset="utf-8"
Message-Id: <E1pCkft-004hzL-0Q@rmk-PC.armlinux.org.uk>
Sender: Russell King <rmk@armlinux.org.uk>
Date:   Tue, 03 Jan 2023 17:02:05 +0000
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The nvme patterns detect all include files starting with nvme, which
also picks up the nvmem subsystem header files. Fix this by excluding
the nvmem subsystem header files from the nvme subsystem entry.

Signed-off-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 0cccd40d7801..64cc6947099e 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14711,6 +14711,7 @@ T:	git://git.infradead.org/nvme.git
 F:	drivers/nvme/host/
 F:	drivers/nvme/common/
 F:	include/linux/nvme*
+X:	include/linux/nvmem*
 F:	include/uapi/linux/nvme_ioctl.h
 
 NVM EXPRESS FABRICS AUTHENTICATION
-- 
2.30.2

