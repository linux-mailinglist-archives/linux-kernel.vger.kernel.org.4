Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75C7C63245F
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:54:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231168AbiKUNyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:54:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiKUNyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:54:36 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A4B9BF801
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:54:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669038873; x=1700574873;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=61pbH5JHMe/ZX6fjwi4xYBFiQ9bqofl3472cjyN55V4=;
  b=teoedUpGI39IZo6SdrPGEKxk4ACACtlU5Dz2D9RgG5l3FyeozhJEvfHA
   b1e75EJ1D9GODkxvHdFOa4/Mr8Zi1qqYXUIEwZkVWxTMdCklb9h189RxM
   9MOJiOqAJxxSAoHWI/lZjX5Gc1DSGFcY3K21klK3iGGqD5wNOeDF2qMaN
   aFt20NNYcEYiWUN9lTt1B0nl0wheUOVZVoDa5KXTZyoiOMbpSznwGTrd/
   sXg/Bsbd8wfzMMKcy3L69ru09df7Ycfb1HZ63fKPtI2gFTIW1r9MyTbcC
   e/kMSSPoGAZnuK58QGbE3sT/S6KLB57KTFejcjFp0rv6i7j0GjJHhQWNg
   Q==;
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="184485482"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Nov 2022 06:54:33 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.85.144) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 21 Nov 2022 06:54:27 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 21 Nov 2022 06:54:25 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <j.neuschaefer@gmx.net>, <linux-kernel@vger.kernel.org>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>,
        <linux-mtd@lists.infradead.org>, <vigneshr@ti.com>,
        <pratyush@kernel.org>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <michael@walle.cc>
Subject: Re: [PATCH] mtd: spi-nor: Fix formatting in spi_nor_read_raw() kerneldoc comment
Date:   Mon, 21 Nov 2022 15:54:24 +0200
Message-ID: <166903885771.86637.15775253700273937900.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20221101162906.990125-1-j.neuschaefer@gmx.net>
References: <20221101162906.990125-1-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,T_SPF_TEMPERROR autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 1 Nov 2022 17:29:06 +0100, Jonathan Neuschäfer wrote:
> It doesn't make sense to put "set" on its own line like that.
> 
> 

Applied to spi-nor/next, thanks!

[1/1] mtd: spi-nor: Fix formatting in spi_nor_read_raw() kerneldoc comment
      https://git.kernel.org/mtd/c/270450a1b6d8

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
