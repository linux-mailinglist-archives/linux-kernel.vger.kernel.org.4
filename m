Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4532E6043B4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Oct 2022 13:47:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiJSLrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Oct 2022 07:47:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230331AbiJSLqb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Oct 2022 07:46:31 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89D718F932;
        Wed, 19 Oct 2022 04:26:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1666178769; x=1697714769;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LbMSsxMcmlMfWsO5riNK7BpBDXgyRdAAcSbOnynbhCA=;
  b=m2O2yqAmBMChZ+IYtrMxqLV0n3Tf/1oQbzf2VzGj79q0ydpS1I0NJuF5
   SB9TpJ56AdFyyzYahFhZeSczcj3Ub3gSJ6EuZGGZEWBqyRyc1qQIYaMO0
   gIpldcU+S4gYhWWckMUfcVkITTxBGY87GkaZPkVA4xkltacP2340Z7h84
   Kj61nt0wO+NtsIFMSyjeMyGANuM/dvyQZ0NziCuap6InhVLBLHRn9ch3B
   krDJwBZWoOAW6Y9yhQ6Rfi3leueFe4aRd25gd/CJ+ATvWQKJxR+RhAuMx
   WyKpaDe1AqbDXytyLtmonxUPDYNpZhzO6bDWHVf0ZEuwj+bseexBmhns6
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="392661862"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="392661862"
Received: from fmsmga002.fm.intel.com ([10.253.24.26])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:34:07 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10504"; a="734127905"
X-IronPort-AV: E=Sophos;i="5.95,195,1661842800"; 
   d="scan'208";a="734127905"
Received: from sponnura-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.214.35])
  by fmsmga002-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Oct 2022 02:34:02 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org, Greg KH <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: [PATCH v5 2/5] Documentation: rs485: Link reference properly
Date:   Wed, 19 Oct 2022 12:33:40 +0300
Message-Id: <20221019093343.9546-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20221019093343.9546-1-ilpo.jarvinen@linux.intel.com>
References: <20221019093343.9546-1-ilpo.jarvinen@linux.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Link DT bindings reference properly.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
Signed-off-by: Ilpo Järvinen <ilpo.jarvinen@linux.intel.com>
---
 Documentation/driver-api/serial/serial-rs485.rst | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/Documentation/driver-api/serial/serial-rs485.rst b/Documentation/driver-api/serial/serial-rs485.rst
index 264e4b753713..513758a702a6 100644
--- a/Documentation/driver-api/serial/serial-rs485.rst
+++ b/Documentation/driver-api/serial/serial-rs485.rst
@@ -33,9 +33,9 @@ RS485 Serial Communications
    communications. This data structure is used to set and configure RS485
    parameters in the platform data and in ioctls.
 
-   The device tree can also provide RS485 boot time parameters (see [1]
-   for bindings). The driver is in charge of filling this data structure from
-   the values given by the device tree.
+   The device tree can also provide RS485 boot time parameters
+   [#DT-bindings]_. The driver is in charge of filling this data structure
+   from the values given by the device tree.
 
    Any driver for devices capable of working both as RS232 and RS485 should
    implement the rs485_config callback and provide rs485_supported in the
@@ -129,4 +129,4 @@ RS485 Serial Communications
 6. References
 =============
 
- [1]	Documentation/devicetree/bindings/serial/rs485.txt
+.. [#DT-bindings]	Documentation/devicetree/bindings/serial/rs485.txt
-- 
2.30.2

