Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD1805EDB3B
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:08:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231954AbiI1LIW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:08:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233069AbiI1LHy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:07:54 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D9DD6F3935;
        Wed, 28 Sep 2022 04:05:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664363119; x=1695899119;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=VifYzs7527zeG2WGl/W5l/W+DAo94Ubj99Rp2xOev70=;
  b=lOjI+5F5k+j1Ap/PNhkEHILoRdQLTdJLlWUm93zR+JEACGeMrTUzb7UZ
   iec4ZDT4EmWAWt95gdWHTA9Hhk/kEopo6Z6ptZs9UqDgmoN+NFywbiV5D
   A8AYLgqEV5w3zhu68MSv8QdZioqnEWCRBMw/UEQWn0ohDlu/oONIUmSm9
   /tYAuLqDm4t+EDigrbEqk0P+7cyAyANR+ovA+YlXNbbiBKuTZ/X13+TCM
   VzrfjDKdVfsj1oDWWq+mjQrqpWR49K6UsHXgER36r5JMn5eR48b0AxYX4
   VgOT0QFAkC483Y5NZ2xSDvhYeiff2DhH7cl3WRoN0WkoOkH5rY7Xl7Wdm
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="281942829"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="281942829"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 04:05:18 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="624110497"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="624110497"
Received: from kjurkiew-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.211.248])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 04:05:16 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-doc@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 0/4] serial: RS485 kerneldoc/documentation improvements
Date:   Wed, 28 Sep 2022 14:05:05 +0300
Message-Id: <20220928110509.13544-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RS485 documentation improvements. While doing the kerneldoc conversion,
a few other items came up so they're now included to this series.

v3:
- More fixes to kernel doc formatting (thanks to Jiri)
- Added a few other related improvements

v2:
- Include serial_rs485 into documentation
- Add * to multi-line flag descriptions


Ilpo Järvinen (4):
  serial: Convert serial_rs485 to kernel doc
  Documentation: rs485: Link reference properly
  Documentation: rs485: Mention uart_get_rs485_mode()
  Documentation: rs485: Fix struct referencing

 .../driver-api/serial/serial-rs485.rst        | 36 ++++++-----
 include/uapi/linux/serial.h                   | 62 ++++++++++++-------
 2 files changed, 60 insertions(+), 38 deletions(-)

-- 
2.30.2

