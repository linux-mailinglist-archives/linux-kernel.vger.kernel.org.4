Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A058E60407F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 11:59:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231238AbiJSJ7h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 05:59:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234450AbiJSJ7B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 05:59:01 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D429B1162CD;
        Wed, 19 Oct 2022 02:36:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666172185; x=1697708185;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1zjPVApNUqKaU7OTFzXOU/zZQjHo3VHZphG8EjiTomo=;
  b=GXbqsrlvSY1TzbVJiPP5JVA1B9C/Q5yUOgLxKeQEmi5MK2XAYTZAombU
   3E9L5sWRpMzYw1t3YgAq82WfzZYZOAOSDQhxzoet95I1UMoIHZ88QwXZD
   xz+0/i/OurXIxAZhtkvVGUF3TJHYm+mKqX7WKSmJ0nTVIcYWKRIo7bmZJ
   dXq48/ZGV8qkSjgIesgMcAkkAOQTS7U+YfwYF2JSvw484yyhyUKR0A/5q
   HsDLGhlw62tHg+KJT6a9mF/3hf8iPisssXHGS9TmynXQVdg1H02NwlN93
   RuvJccx9Bk2w+yUwxK0nAqhMSzOQfnUS+OyowQhs7algu8G0We54WqaIC
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="293756489"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="293756489"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:33:56 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734127822"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734127822"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:33:52 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>, linux-doc@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v5 0/5] serial: RS485 kerneldoc/documentation improvements
Date:   Wed, 19 Oct 2022 12:33:38 +0300
Message-Id: <20221019093343.9546-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

RS485 documentation improvements. While doing the kerneldoc conversion,
a few other items came up so they're now included in this series.

v5:
- Make formatting of names more consistent
- serial_rs485::flags bits are: -> The flag bits are:

v4:
- Remove wrong private: markers
- Fix grammar problems

v3:
- More fixes to kernel doc formatting (thanks to Jiri)
- Added a few other related improvements

v2:
- Include serial_rs485 into documentation
- Add * to multi-line flag descriptions

Ilpo Järvinen (5):
  serial: Convert serial_rs485 to kernel doc
  Documentation: rs485: Link reference properly
  Documentation: rs485: Mention uart_get_rs485_mode()
  Documentation: rs485: Fix struct referencing
  Documentation: Make formatting consistent for rs485 docs

 .../driver-api/serial/serial-rs485.rst        | 56 ++++++++++---------
 include/uapi/linux/serial.h                   | 55 +++++++++++-------
 2 files changed, 66 insertions(+), 45 deletions(-)

-- 
2.30.2

