Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EC5BB6A493F
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 19:08:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjB0SIJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 13:08:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230228AbjB0SIH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 13:08:07 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.153.233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98FAD24490;
        Mon, 27 Feb 2023 10:07:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1677521257; x=1709057257;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=scY7UonjFChQcjD94QJl2vOVah5UAvdvzWmSDMUa7Ss=;
  b=xg3CvFsV/BejjorWOjs52uL91fLXCdSvmsQuBZvW25fPqGgplprfAmtR
   Xlv8VmX71n4vNtSB3TTegVOcnDU1JxbMiuhKOQqY9tktQUBnQJKoVSu8z
   4cc7PRWP3gvNo1V33Q7ub6iXAd9/nmZz+kqI8GnkitBMfaD+iwG7Mqq5L
   g5z6v/aLRh8Ms3CJb5lN10kP0WcvLuWRCkBQSmNKT5Lr6qJNM2Es04dag
   /j54NEhggr1lXBXTdy4VKdluZ7b/uPYmni70m7msjxJz+pV9b7JqegbUr
   kIh80PQOKxoO8+AJwwGX775j054XfheCw7v1jxAJguVJGTOxGtsk+NAVX
   w==;
X-IronPort-AV: E=Sophos;i="5.98,219,1673938800"; 
   d="scan'208";a="202436815"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa3.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 27 Feb 2023 11:07:25 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.16; Mon, 27 Feb 2023 11:07:19 -0700
Received: from ryan-Precision-3630-Tower.microchip.com (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2507.16 via Frontend Transport; Mon, 27 Feb 2023 11:07:19 -0700
From:   <Ryan.Wanner@microchip.com>
To:     <ludovic.desroches@microchip.com>, <linus.walleij@linaro.org>,
        <nicolas.ferre@microchip.com>, <alexandre.belloni@bootlin.com>,
        <claudiu.beznea@microchip.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-gpio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        Ryan Wanner <Ryan.Wanner@microchip.com>
Subject: [PATCH v3 0/2]Sama7g5 drive strength options updated
Date:   Mon, 27 Feb 2023 11:07:26 -0700
Message-ID: <cover.1677520830.git.Ryan.Wanner@microchip.com>
X-Mailer: git-send-email 2.37.2
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

From: Ryan Wanner <Ryan.Wanner@microchip.com>

This patch set updates drive strength options for the Sama7g5 to align
with drive strength options in the Sama7g5 data sheet.

changes since v1:
- Fix ABI break.
- Add explanation for drive strength macros.

changes since v2:
-Fix subject prefix to match subsystem.
-Add more indepth discription of sama7g5 define values.
-Fix formatting issues.
-Add sama7g5 differences to dbg_show.
-Remove array length for xlate.

Ryan Wanner (2):
  pinctrl: at91-pio4: Implement the correct drive values for sama7g5
  dt-bindings:pinctrl:at91:Adding macros for sama7g5

 drivers/pinctrl/pinctrl-at91-pio4.c | 54 ++++++++++++++++++++++++++---
 include/dt-bindings/pinctrl/at91.h  | 15 +++++++-
 2 files changed, 63 insertions(+), 6 deletions(-)

-- 
2.37.2

