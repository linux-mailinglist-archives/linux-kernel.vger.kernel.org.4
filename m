Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD00C5EF21A
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:33:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235760AbiI2JdA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:33:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234760AbiI2Jcn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:32:43 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C00C3167CD;
        Thu, 29 Sep 2022 02:31:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664443919; x=1695979919;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=CVrwgjfVnaD7pAiTt19k2B8C/YDRfWLEUUpuMO4HPNU=;
  b=dsY5nemyhFq5i2oCW1jJZ7TI6e14XeW5RRrZsZs9ZvCFEwoFMiBsoAOZ
   gOz/nLGAeNSFp8Ty2BJzEGXRyO06bHS+p7/TVS/m0s6p1R/5Pc+msxVEb
   4j49XJi//1ltgK4HclE2OYrQHQRv+1Y3yDE7QuUPOUwXDbsgS50oPwJfF
   Yq6RhiP+IiLyvv4Kasa/xe0AYw5OKgEmEcSGxKyCZEfDZ1WMyQ0YNM3Sh
   BZxQZC+wP5I4b60wsd0r1ErNMo8iov4QKx6KGmT0kutlVDNzHDYx3TSfx
   U0IUaE3egpm0rWNqDPe8RoxVbtkZ27uXFsgK7MlJ0n7XU5F3VykvLElCs
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="299444090"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="299444090"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 02:31:58 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="867319904"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="867319904"
Received: from pramona-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.60.139])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 02:31:55 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 0/4] serial: RS485 kerneldoc/documentation improvements
Date:   Thu, 29 Sep 2022 12:31:44 +0300
Message-Id: <20220929093148.9468-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RS485 documentation improvements. While doing the kerneldoc conversion,
a few other items came up so they're now included in this series.

v4:
- Remove wrong private: markers
- Fix grammar problems

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

 .../driver-api/serial/serial-rs485.rst        | 37 +++++++------
 include/uapi/linux/serial.h                   | 55 ++++++++++++-------
 2 files changed, 56 insertions(+), 36 deletions(-)

-- 
2.30.2

