Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C8A525F0AF8
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Sep 2022 13:47:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231259AbiI3Lql (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Sep 2022 07:46:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59714 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231828AbiI3LpU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Sep 2022 07:45:20 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD167E004F;
        Fri, 30 Sep 2022 04:40:48 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 15845CE2521;
        Fri, 30 Sep 2022 11:40:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF76C433C1;
        Fri, 30 Sep 2022 11:40:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664538045;
        bh=ODj57U1oBFsqcsVWfvN6rD3AISNqGbpersK7LYJhirU=;
        h=From:To:Cc:Subject:Date:From;
        b=XULYhcs9TcaNqox3A/Y9eIebEzG5wB0cfL85gQ8Mtt/kDoMkn1V/NgmWE1YiMJi2+
         3FcZwOSbJwmafTtRPRFov9jZpiPTsF57prDQEbo/2dNge2xvlqe4UiheX71Nh9v8Sv
         3ngQepK2u/2rZgAlVUH3o2nRnCcneunUCvwHpyCA=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Felipe Balbi <balbi@kernel.org>
Subject: [PATCH] MAINTAINERS: move USB gadget and phy entries under the main USB entry
Date:   Fri, 30 Sep 2022 13:40:41 +0200
Message-Id: <20220930114041.1306711-1-gregkh@linuxfoundation.org>
X-Mailer: git-send-email 2.37.3
MIME-Version: 1.0
X-Developer-Signature: v=1; a=openpgp-sha256; l=1561; i=gregkh@linuxfoundation.org; h=from:subject; bh=ODj57U1oBFsqcsVWfvN6rD3AISNqGbpersK7LYJhirU=; b=owGbwMvMwCRo6H6F97bub03G02pJDMlmV7evfhb8aaInXwH/3Q8hs1zOv520cl3ko+XNVRVefBc0 fptN7IhlYRBkYpAVU2T5so3n6P6KQ4pehranYeawMoEMYeDiFICJ9L1lmB+75Tzj7ofPFOfcOBp0M8 Zww8wvOhsYFlzrbihKM+VLKtM02R/25/jaFM275QA=
X-Developer-Key: i=gregkh@linuxfoundation.org; a=openpgp; fpr=F4B60CC5BF78C2214A313DCB3147D40DDB2DFB29
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Felipe has done a wonderful job over the years, but now it makes sense
to just maintain all of the USB stack in one tree.  Do so by removing
the current USB gadget and phy entries so that all portions of the stack
are now covered by the main USB maintainer entry.

Cc: Felipe Balbi <balbi@kernel.org>
Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
---
 MAINTAINERS | 16 ----------------
 1 file changed, 16 deletions(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index 2cd29b4add81..c98cb6302249 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -20965,15 +20965,6 @@ S:	Maintained
 F:	Documentation/usb/ehci.rst
 F:	drivers/usb/host/ehci*
 
-USB GADGET/PERIPHERAL SUBSYSTEM
-M:	Felipe Balbi <balbi@kernel.org>
-L:	linux-usb@vger.kernel.org
-S:	Maintained
-W:	http://www.linux-usb.org/gadget
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git
-F:	drivers/usb/gadget/
-F:	include/linux/usb/gadget*
-
 USB HID/HIDBP DRIVERS (USB KEYBOARDS, MICE, REMOTE CONTROLS, ...)
 M:	Jiri Kosina <jikos@kernel.org>
 M:	Benjamin Tissoires <benjamin.tissoires@redhat.com>
@@ -21080,13 +21071,6 @@ W:	https://github.com/petkan/pegasus
 T:	git git://github.com/petkan/pegasus.git
 F:	drivers/net/usb/pegasus.*
 
-USB PHY LAYER
-M:	Felipe Balbi <balbi@kernel.org>
-L:	linux-usb@vger.kernel.org
-S:	Maintained
-T:	git git://git.kernel.org/pub/scm/linux/kernel/git/balbi/usb.git
-F:	drivers/usb/phy/
-
 USB PRINTER DRIVER (usblp)
 M:	Pete Zaitcev <zaitcev@redhat.com>
 L:	linux-usb@vger.kernel.org
-- 
2.37.3

