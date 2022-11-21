Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D5F4632416
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:42:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229576AbiKUNm2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:42:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231348AbiKUNmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:42:06 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29C32BF66
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 05:42:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669038123; x=1700574123;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=TGHa1ACMpuK7vWt6H1ZnzKaaUTeqhDv1botyjNXatr4=;
  b=sdkyBcOnaLWhLkLW9IN31UcdXRvkNzW73y2Dy8XqdobFSbXuRF2J9mGh
   46iLPdtPbW+V57jdBh1KB1poH3Bb5AY1s5zJnpSpHn8KVv12Xpy+LuKBM
   MT+hibq/03xl7uaiRIeEw7mOn99iHddSQtpzk1y+jeGQCbr7lgvOxlZu4
   Q8ZMV+oqHq28Okbh/W1HTBZYUmm0GOMiylwKsu4X1gFMomi4OtJAE72By
   qMJUrKRZY1qzTwOi61rCP+HD0nJcHn6qnGXnMiVmv6x66krz47Bdj/f3A
   XQVnFBi5urRbtO4CgJbPvmtQ0bH6zyFCSfQpqqvynmNDvkoLGJk2X7BY6
   w==;
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="184483609"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Nov 2022 06:41:58 -0700
Received: from chn-vm-ex03.mchp-main.com (10.10.85.151) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 21 Nov 2022 06:41:54 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex03.mchp-main.com (10.10.85.151) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 21 Nov 2022 06:41:52 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <michael@walle.cc>, <pratyush@kernel.org>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>, <richard@nod.at>,
        <miquel.raynal@bootlin.com>, <linux-kernel@vger.kernel.org>,
        <linux-mtd@lists.infradead.org>, <vigneshr@ti.com>
Subject: Re: [PATCH v2 0/7] mtd: spi-nor: generic flash driver
Date:   Mon, 21 Nov 2022 15:41:48 +0200
Message-ID: <166903807811.85501.6803386075881922742.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220810220654.1297699-1-michael@walle.cc>
References: <20220810220654.1297699-1-michael@walle.cc>
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

On Thu, 11 Aug 2022 00:06:47 +0200, Michael Walle wrote:
> Add a generic flash driver, which is used when we don't find a matching
> flash in our database. All the basic features of a flash can be discovered
> by SFDP and most (if not all) newer flashes support it.
> 
> changes since v1:
>  - fix doc prototype mistake reported by the kernel test robot
>  - preset page_size to 256 to support flashes which just have
>    SFDP data corresponding to JESD216A
>  - add new patch
>    mtd: spi-nor: fix select_uniform_erase to skip 0 erase size
>  - add function doc to explain wanted_size=0 in
>    spi_nor_select_uniform_erase()
> 
> [...]

Applied to spi-nor/next, thanks!

[1/7] mtd: spi-nor: hide jedec_id sysfs attribute if not present
      https://git.kernel.org/mtd/c/7d388551b688
[2/7] mtd: spi-nor: sysfs: hide manufacturer if it is not set
      https://git.kernel.org/mtd/c/0d9270f2762b
[3/7] mtd: spi-nor: remember full JEDEC flash ID
      https://git.kernel.org/mtd/c/28ef7670414e
[4/7] mtd: spi-nor: move function declaration out of sfdp.h
      https://git.kernel.org/mtd/c/fa06bb26a40c
[5/7] mtd: spi-nor: fix select_uniform_erase to skip 0 erase size
      https://git.kernel.org/mtd/c/39eece67a3cf
[6/7] mtd: spi-nor: add generic flash driver
      https://git.kernel.org/mtd/c/773bbe104497
[7/7] mtd: spi-nor: sysfs: print JEDEC ID for generic flash driver
      https://git.kernel.org/mtd/c/0a92de16b61b

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
