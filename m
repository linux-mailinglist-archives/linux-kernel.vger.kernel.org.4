Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E9A260C1C1
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 04:33:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231196AbiJYCda (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 22:33:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230370AbiJYCd1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 22:33:27 -0400
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C2A211DAA4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 19:33:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1666665206; x=1698201206;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=CtR0Xcu72tjFz5R8+nLQQ/f7nPmRy/8v+lVmRCYk+CU=;
  b=TG00YEbpzJZ3smkkQ6RwrDhQAkj2rSANJ3JfKqlzhle4FBF3g/q4mhDb
   LSpyXuKFcEmQ6u5R80hncuNO7X+heOJtYezSnB34zPMK+xObVIkqg8Sc6
   dktMTTFbxbR1vPP3+0jWN0Zu2kWjfYkEEsGj0vAu1qOwLkb8RTlqyaY1k
   UM9+9FaGvziHn7dvkNKg2HxO+mrQ12YUNrgHS10OS8C4B/m2i+adZ6qtB
   3muSKb1rmawEynSP/AVw06qNDruELvzcjGoSmSR4lOGvlwBC1ZfoRzFAb
   MHMiJBWHpfokvqCO2LkmBAAOvNZ6YOdquTWs9nG7UPZU7ma8HxS9hhvuh
   Q==;
X-IronPort-AV: E=Sophos;i="5.95,210,1661842800"; 
   d="scan'208";a="183740034"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa2.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 24 Oct 2022 19:33:25 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 24 Oct 2022 19:33:21 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 24 Oct 2022 19:33:17 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <michael@walle.cc>, <tudor.ambarus@microchip.com>,
        <pratyush@kernel.org>
CC:     Pratyush Yadav <p.yadav@ti.com>, <linux-mtd@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <miquel.raynal@bootlin.com>,
        <richard@nod.at>, <vigneshr@ti.com>
Subject: Re: [PATCH] mtd: spi-nor: core: Add an error message when failing to exit the 4-byte address mode
Date:   Tue, 25 Oct 2022 05:33:02 +0300
Message-ID: <166666517334.181018.17214909395761574180.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220728030159.68680-1-tudor.ambarus@microchip.com>
References: <20220728030159.68680-1-tudor.ambarus@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 28 Jul 2022 06:01:59 +0300, Tudor Ambarus wrote:
> Add an error message when failing to exit the 4-byte address mode. Do not
> stop the execution and go through the spi_nor_soft_reset() method if used,
> in the hope that the flash will default to 3-byte address mode after the
> reset.
> 
> 

Applied to spi-nor/next, thanks!

[1/1] mtd: spi-nor: core: Add an error message when failing to exit the 4-byte address mode
      https://git.kernel.org/mtd/c/bb0e9c600ce2

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
