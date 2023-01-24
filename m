Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFDE679DB1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:39:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235072AbjAXPj3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:39:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234031AbjAXPj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:39:28 -0500
Received: from perceval.ideasonboard.com (perceval.ideasonboard.com [IPv6:2001:4b98:dc2:55:216:3eff:fef7:d647])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 91581474C5;
        Tue, 24 Jan 2023 07:39:27 -0800 (PST)
Received: from mail.ideasonboard.com (cpc141996-chfd3-2-0-cust928.12-3.cable.virginm.net [86.13.91.161])
        by perceval.ideasonboard.com (Postfix) with ESMTPSA id 3F83CA1C;
        Tue, 24 Jan 2023 16:39:25 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=ideasonboard.com;
        s=mail; t=1674574765;
        bh=pARIexCWZAxTEsr0u3n1/ikrnyht8j4KXmiAI8toDAA=;
        h=From:To:Cc:Subject:Date:From;
        b=fF9fM2dG15DYsJNpVWn4AyqwhXxoUxBcj/hhv7WdS5liBgl54LDReskkkHKezvpLs
         Y1L64ENl1GZgE2YXTM80DmiQGfqByLV4wdi1IPBvvwFeg/f7LBA2Y+7H+QULoamnCI
         DtVAaOOYo9Klolb1anJiYrGoVADLGXlwoayMqIpw=
From:   Daniel Scally <dan.scally@ideasonboard.com>
To:     linux-kernel@vger.kernel.org, linux-usb@vger.kernel.org
Cc:     gregkh@linuxfoundation.org,
        Daniel Scally <dan.scally@ideasonboard.com>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Subject: [RESEND] MAINTAINERS: Add myself as UVC Gadget Maintainer
Date:   Tue, 24 Jan 2023 15:39:09 +0000
Message-Id: <20230124153909.867202-1-dan.scally@ideasonboard.com>
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

Add myself as a second maintainer for the UVC Gadget.

Reviewed-by: Laurent Pinchart <laurent.pinchart@ideasonboard.com>
Signed-off-by: Daniel Scally <dan.scally@ideasonboard.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index f781f936ae35..cfac6e58a234 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -21723,6 +21723,7 @@ F:	include/uapi/linux/uvcvideo.h
 
 USB WEBCAM GADGET
 M:	Laurent Pinchart <laurent.pinchart@ideasonboard.com>
+M:	Daniel Scally <dan.scally@ideasonboard.com>
 L:	linux-usb@vger.kernel.org
 S:	Maintained
 F:	drivers/usb/gadget/function/*uvc*
-- 
2.34.1

