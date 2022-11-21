Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EA84B6327DC
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 16:25:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232254AbiKUPY7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 10:24:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54098 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232338AbiKUPYm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 10:24:42 -0500
Received: from esa.microchip.iphmx.com (esa.microchip.iphmx.com [68.232.154.123])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C01EB2E0
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 07:24:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1669044276; x=1700580276;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=6zAPc54Hyj7y1k86bWrWpPjCpi6QsBskBBHCuoWoeF4=;
  b=PaCsNFDJO6aAyus7+vFmak9ARgruAnJmAoOl+jIo+kyBlzyxIiN/3/9B
   uxuUmBOKHUkiTEuEuqpm5g13ZCUbcNbZNayYSfZ1pGJqJikL4MmvF/DfR
   tXXSE86u6qME1aM0hIOz5IPOWuU1YYO66SDcWLvFnWgj5xQetyH/a+37E
   EpVFX7qUauwRRThxrNOOKBO40lRfq57y3ToQce0Pk3yh4ctBuKN0gllkY
   PW8baNU+RWal+ZGbT5al6JcPLGzdwnbEa30KRhS6ftAHgJPiumThu0I1E
   v+4lvE4qdwaci7AYErDeS0JNOJpVmjzPsUreE1hw1GKHgJo0inVtwJFrM
   g==;
X-IronPort-AV: E=Sophos;i="5.96,181,1665471600"; 
   d="scan'208";a="184497757"
Received: from unknown (HELO email.microchip.com) ([170.129.1.10])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 21 Nov 2022 08:24:35 -0700
Received: from chn-vm-ex04.mchp-main.com (10.10.85.152) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2507.12; Mon, 21 Nov 2022 08:24:30 -0700
Received: from ROB-ULT-M18064N.mchp-main.com (10.10.115.15) by
 chn-vm-ex04.mchp-main.com (10.10.85.152) with Microsoft SMTP Server id
 15.1.2507.12 via Frontend Transport; Mon, 21 Nov 2022 08:24:28 -0700
From:   Tudor Ambarus <tudor.ambarus@microchip.com>
To:     <michael@walle.cc>, <quic_jaehyoo@quicinc.com>, <p.yadav@ti.com>
CC:     Tudor Ambarus <tudor.ambarus@microchip.com>, <clg@kaod.org>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <quic_ggregory@quicinc.com>, <quic_jiles@quicinc.com>
Subject: (subset)Re: [PATCH v3 1/2] mtd: spi-nor: fix select_uniform_erase to skip 0 erase size
Date:   Mon, 21 Nov 2022 17:24:27 +0200
Message-ID: <166904400383.115983.13314465270022760559.b4-ty@microchip.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220716000643.3541839-1-quic_jaehyoo@quicinc.com>
References: <20220716000643.3541839-1-quic_jaehyoo@quicinc.com>
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

On Fri, 15 Jul 2022 17:06:42 -0700, Jae Hyun Yoo wrote:
> From: Michael Walle <michael@walle.cc>
> 
> 4bait will set the erase size to 0 if there is no corresponding
> opcode for the 4byte erase. Fix spi_nor_select_uniform_erase to skip
> the 0 erase size to avoid mtd device registration failure cases.
> 
> 
> [...]

Applied [2/2] to spi-nor/next, thanks!
I haven't applied 1/2 as Michael sent a similar patch which
I had already taken at the time I got to your patch set, see:
https://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git/commit/?id=39eece67a3cf
Sorry!

[2/2] mtd: spi-nor: winbond: add support for W25Q512NW-IQ
      https://git.kernel.org/mtd/c/ef434f08b056

Best regards,
-- 
Tudor Ambarus <tudor.ambarus@microchip.com>
