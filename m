Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63538712432
	for <lists+linux-kernel@lfdr.de>; Fri, 26 May 2023 12:07:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236917AbjEZKHe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 May 2023 06:07:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229956AbjEZKHa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 May 2023 06:07:30 -0400
Received: from fanzine2.igalia.com (fanzine2.igalia.com [213.97.179.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD0209E
        for <linux-kernel@vger.kernel.org>; Fri, 26 May 2023 03:07:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=igalia.com;
        s=20170329; h=Content-Transfer-Encoding:MIME-Version:Message-Id:Date:Subject:
        Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:Content-Description:
        Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:
        In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=w7acSldxOzIlnfkj7RcaJRC8pdNZ6hdlIPsanjRqHko=; b=llncL6LB1Mv9hqi88ntCMqKI33
        jnE93pMaXDf0Rx8sPGQZb2pTLZhy69jDt9ocCGalHvSqpquIFUSgSJB5JT9xCkeN2mceoTWRlYsW2
        Uo+/iceq6WNP8X5+kF3G5Uwkhss21TIn46FWDKWA5xjfdAj9BR1Y8vDGAqH7Esj3lohwCFsBrIDJE
        iy/f8qfaTyzFC7eA3BTZZHvMHbwuLnsE1X74C5RK9maJOS1wL1rP/LmeEgP7tpj2fC+MOR9rS4SNI
        6y76HtfLGUupDz0tx7HjRI6Jn89/0fNHWl/Ipc5jEaTTK7XMd16I9/gyDGvsDrHwQrpN0OrLObW2g
        b4oDGoRg==;
Received: from cm-81-9-194-118.telecable.es ([81.9.194.118] helo=fourier..)
        by fanzine2.igalia.com with esmtpsa 
        (Cipher TLS1.3:ECDHE_X25519__RSA_PSS_RSAE_SHA256__AES_256_GCM:256) (Exim)
        id 1q2ULz-001tYu-HH; Fri, 26 May 2023 12:07:23 +0200
From:   =?UTF-8?q?Samuel=20Iglesias=20Gons=C3=A1lvez?= 
        <siglesias@igalia.com>
To:     linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Samuel=20Iglesias=20Gons=C3=A1lvez?= 
        <siglesias@igalia.com>, Vaibhav Gupta <vaibhavgupta40@gmail.com>,
        Jens Taprogge <jens.taprogge@taprogge.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        industrypack-devel@lists.sourceforge.net
Subject: [PATCH] MAINTAINERS: Vaibhav Gupta is the new ipack maintainer
Date:   Fri, 26 May 2023 12:07:18 +0200
Message-Id: <20230526100718.35531-1-siglesias@igalia.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PP_MIME_FAKE_ASCII_TEXT,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit

I have no longer access to the HW, nor time to properly maintain it.

Adding Vaibhav as maintainer as he currently has access to the HW, he
is working at CERN (user of these drivers) and he is maintaining them
internally there.

Signed-off-by: Samuel Iglesias Gonsálvez <siglesias@igalia.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 207a65905f5e..49e384399ee3 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -10106,7 +10106,7 @@ S:	Maintained
 F:	Documentation/process/kernel-docs.rst
 
 INDUSTRY PACK SUBSYSTEM (IPACK)
-M:	Samuel Iglesias Gonsalvez <siglesias@igalia.com>
+M:	Vaibhav Gupta <vaibhavgupta40@gmail.com>
 M:	Jens Taprogge <jens.taprogge@taprogge.org>
 M:	Greg Kroah-Hartman <gregkh@linuxfoundation.org>
 L:	industrypack-devel@lists.sourceforge.net
-- 
2.34.1

