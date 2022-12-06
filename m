Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 206DF644245
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Dec 2022 12:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233713AbiLFLjG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Dec 2022 06:39:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234042AbiLFLi6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Dec 2022 06:38:58 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [213.167.242.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5823B65E7
        for <linux-kernel@vger.kernel.org>; Tue,  6 Dec 2022 03:38:56 -0800 (PST)
Received: from mail.ideasonboard.com (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id B7A4B480;
        Tue,  6 Dec 2022 12:38:54 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1670326735;
        bh=H/IrkXe9jGT0S7wSAabgW6IlIS41Cs3wo1R7I16l9jU=;
        h=From:To:Cc:Subject:Date:From;
        b=jkqk9zlQWEtFIAsImPNk4/IW65MB9YRToOpZjS3wkGdz0XMHzH9cZy6y1rlXptkP8
         EIY2W6EkQ+W5EGV+CUvTrPG6E+f6gHS7lKRXT75lZZvYncG2kXBJgUrlMyEjxJGjXA
         KPJIRwQZaydCV/VPQSPz0UbHytF6lFNPVcaH6w1s=
From:   Daniel Scally <dan.scally@ideasonboard.com>
To:     linux-kernel@vger.kernel.org
Cc:     laurent.pinchart@ideasonboard.com,
        Daniel Scally <dan.scally@ideasonboard.com>
Subject: [PATCH] MAINTAINERS: Add myself as UVC Gadget Maintainer
Date:   Tue,  6 Dec 2022 11:38:41 +0000
Message-Id: <20221206113841.1359976-1-dan.scally@ideasonboard.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add myself as a second maintainer for the UVC Gadget

Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 1daadaa4d48b..36b58ccc9a32 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21441,6 +21441,7 @@ F:	include/uapi/linux/uvcvideo.h
 
 USB WEBCAM GADGET
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+M:	Daniel Scally <dan.scally@ideasonboard.com>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
 F:	drivers/usb/gadget/function/*uvc*
-- 
2.34.1

