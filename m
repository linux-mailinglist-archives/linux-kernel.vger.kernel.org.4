Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D98F5EF21F
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:33:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235572AbiI2JdG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:33:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235492AbiI2Jco (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:32:44 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8896072696;
        Thu, 29 Sep 2022 02:32:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664443927; x=1695979927;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=LbMSsxMcmlMfWsO5riNK7BpBDXgyRdAAcSbOnynbhCA=;
  b=JceHIE1faiq9ZlvVU7UsSQY+ns99NwBrojawVnkeLFG6V2BnKCBLcupD
   Aj744e70Cw7pMRe/PuYiTmxi5UxAoR755Kfii1ko6IF2+q5cRxB0zC7fM
   G2Lvh/EbOPScaojA7BvGZDTlWAleCWfm6ykmLnjcvShKfQTCqBmBioI7F
   SIpfTFnFOvkFUGDJcsu85dHp4kpBw0nOz6JJUXXGT3wR4phERjyuvNSfi
   RXVkhtX4kKWpEGyiCyQ8tgNPWQaTy4Uky/azfjngx/d0mF95Nw3R+On5M
   XwZHGlVawu9Z6yLCwncEzeat9vTp13OMwCW5Cv/WokHqS1iA/4c9N6ITE
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="299444125"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="299444125"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 02:32:06 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10484"; a="867320008"
X-IronPort-AV: E=Sophos;i="5.93,354,1654585200"; 
   d="scan'208";a="867320008"
Received: from pramona-mobl1.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.252.60.139])
  by fmsmga006-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 29 Sep 2022 02:32:03 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        linux-doc@vger.kernel.org, Jonathan Corbet <corbet@lwn.net>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v4 2/4] Documentation: rs485: Link reference properly
Date:   Thu, 29 Sep 2022 12:31:46 +0300
Message-Id: <20220929093148.9468-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220929093148.9468-1-ilpo.jarvinen@linux.intel.com>
References: <20220929093148.9468-1-ilpo.jarvinen@linux.intel.com>
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

