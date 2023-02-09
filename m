Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 238A769061B
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 12:07:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229975AbjBILH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 06:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229892AbjBILHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 06:07:25 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF8CB12878
        for <linux-kernel@vger.kernel.org>; Thu,  9 Feb 2023 03:07:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1675940843; x=1707476843;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=w4+EFlzit0+DANLCJ4xPIV92RloRfh8QfxeGjF3pLqA=;
  b=sBNMnvT6tNMvr7I1g8Dyro+XEZwy1A4t/H+OJkuQsesUA15jOVv47fbk
   JBGmZhG1rXXHGqZFKPzN5cIIogrCDGX/yQwqAnMWZH4Civi6DFHGqzINB
   xPYxFFF5Jzu/ei8G7EhEXu4Xv/2tOXMbTw6TrV71l5S3Lw/yCV/E/O7r3
   Hp66Ca29WogRkydpep5LRUziiCRF8YO3hz+ioSx+YLhGH5Q9F2My7C86R
   3iTfjdC7gHp0VNy3kytPl3r2Swz+bJs8XWjND5JPEUvw1PQp2E7IVkAan
   PKBUsvONRq2lAc/0zjhPMOkZYG84gvEgGLdR0jT0gRPVLyGsJSjccRsfi
   w==;
X-IronPort-AV: E=Sophos;i="5.97,283,1669100400"; 
   d="scan'208";a="200225569"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 09 Feb 2023 04:07:20 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Thu, 9 Feb 2023 04:07:18 -0700
Received: from CHE-LT-I17164LX.microchip.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Thu, 9 Feb 2023 04:07:17 -0700
From:   Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
To:     <gregkh@linuxfoundation.org>
CC:     <linux-kernel@vger.kernel.org>, <rdunlap@infradead.org>,
        <christian.gromm@microchip.com>,
        Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
Subject: [PATCH] most: add maintainer entry
Date:   Thu, 9 Feb 2023 16:36:51 +0530
Message-ID: <20230209110651.168962-1-Parthiban.Veerasooran@microchip.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch adds an entry in the MAINTAINERS file for the MOST(R)
Technology driver.

Signed-off-by: Christian Gromm <christian.gromm@microchip.com>
Signed-off-by: Parthiban Veerasooran <Parthiban.Veerasooran@microchip.com>
---
 MAINTAINERS | 10 ++++++++++
 1 file changed, 10 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 69d1e8ad52c5..b9ed88342c3f 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -14178,6 +14178,16 @@ F:	drivers/regulator/mpq7920.c
 F:	drivers/regulator/mpq7920.h
 F:	include/linux/mfd/mp2629.h
 
+MOST(R) TECHNOLOGY DRIVER
+M:	Parthiban Veerasooran <parthiban.veerasooran@microchip.com>
+M:	Christian Gromm <christian.gromm@microchip.com>
+S:	Maintained
+F:	Documentation/ABI/testing/configfs-most
+F:	Documentation/ABI/testing/sysfs-bus-most
+F:	drivers/most/
+F:	drivers/staging/most/
+F:	include/linux/most.h
+
 MOTION EYE VAIO PICTUREBOOK CAMERA DRIVER
 S:	Orphan
 W:	http://popies.net/meye/
-- 
2.20.1

