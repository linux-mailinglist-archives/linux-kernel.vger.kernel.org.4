Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B24F624CA8
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Nov 2022 22:13:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232141AbiKJVM7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 16:12:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbiKJVM5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 16:12:57 -0500
X-Greylist: delayed 62 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Thu, 10 Nov 2022 13:12:56 PST
Received: from mailfilter05-out40.webhostingserver.nl (mailfilter05-out40.webhostingserver.nl [195.211.74.36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43F2358003
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 13:12:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=exalondelft.nl; s=whs1;
        h=content-transfer-encoding:mime-version:message-id:date:subject:cc:to:from:
         from;
        bh=HVPhfYr7DNSpFtVrBK6cs5Ear7GeE+3dyp5oKyJUU7g=;
        b=a7MkH5ss9Yvvp2qaaaDRqUwYtPAgWixQ+563+Z3Wb4t2mJ780vNO//BwaPaRJY7AywE9b4hhx2h01
         qtY2mHCzwF5mWMm+fCdrQoC1GLRcxV/SqvrX3dvcCQS+5GsbwxH3Ux+I4Yfb4fWcoqxnQFNVF7tGqR
         Vni7V4hCZi6chNwoxh6wAs7Y0Ba5oL5brhfhKCFF/pIx3HnJfEsMFfgOx05dd8x31M3q+LnH2BGneu
         /wNc2ex6gLqOgvxA1Ha+6h9kIrfm+7x9THFX38Mv6WZS2GSzlBtk3HNPXSNQcHNSSIfoQ4j9a8lXPd
         89uQt/OD9yRabUhqu81L0iNRioBZW7A==
X-Halon-ID: 4bf3f4ca-613c-11ed-9686-001a4a4cb933
Received: from s198.webhostingserver.nl (s198.webhostingserver.nl [141.138.168.154])
        by mailfilter05.webhostingserver.nl (Halon) with ESMTPSA
        id 4bf3f4ca-613c-11ed-9686-001a4a4cb933;
        Thu, 10 Nov 2022 22:11:51 +0100 (CET)
Received: from 2a02-a466-68ed-1-7ff6-3899-7171-85b5.fixed6.kpn.net ([2a02:a466:68ed:1:7ff6:3899:7171:85b5] helo=delfion.fritz.box)
        by s198.webhostingserver.nl with esmtpa (Exim 4.96)
        (envelope-from <ftoth@exalondelft.nl>)
        id 1otEpz-005Dpg-26;
        Thu, 10 Nov 2022 22:11:51 +0100
From:   Ferry Toth <ftoth@exalondelft.nl>
To:     linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thinh Nguyen <Thinh.Nguyen@synopsys.com>,
        Sean Anderson <sean.anderson@seco.com>,
        Liu Shixin <liushixin2@huawei.com>,
        Ferry Toth <fntoth@gmail.com>,
        Andrey Smirnov <andrew.smirnov@gmail.com>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Ferry Toth <ftoth@exalondelft.nl>
Subject: [PATCH v2 0/2] usb: dwc3: core: defer probe on ulpi_read_id timeout
Date:   Thu, 10 Nov 2022 22:11:30 +0100
Message-Id: <20221110211132.297512-1-ftoth@exalondelft.nl>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Antivirus-Scanner: Clean mail though you should still use an Antivirus
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

v2:
- Split into separate commits (Thinh)
- One defer probe on -ETIMEDOUT (Thinh)
- Loose curly brackets (Heikki)

Ferry Toth (2):
  usb: ulpi: defer ulpi_register on ulpi_read_id timeout
  usb: dwc3: core: defer probe on ulpi_read_id timeout

 drivers/usb/common/ulpi.c | 2 +-
 drivers/usb/dwc3/core.c   | 7 ++++++-
 2 files changed, 7 insertions(+), 2 deletions(-)

-- 
2.34.1

