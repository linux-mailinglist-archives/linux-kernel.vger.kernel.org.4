Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CB0D45EDB44
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 13:08:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233577AbiI1LI3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 07:08:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbiI1LH4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 07:07:56 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F8DAF58C;
        Wed, 28 Sep 2022 04:05:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1664363129; x=1695899129;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version:content-transfer-encoding;
  bh=t5FNRVQwwu3uoLntlhppTrjcNUNbPp/bh/RBPv/3nMM=;
  b=XpwsX1Wm469w2xh6oi5Lj8NWfCCR8p4AYTeXSo1kzmzub0NwAD51ev/q
   EDiyYEfwkQ+PnP1RHg8tywP9NN8Zp0UCTOq4HBjlSevDXpHOeHtmctKIs
   3/I84IOVOOa3ENhOapOdwAC4NLcO9kVsJ375iz+SiLieG8fasSsTs/ghI
   k/i6W9L3OEDB44cdxJNI8CdrvSe0qWBy3c7xvQvXjIYw4ti76NNDBwdqp
   oQ0XZSyeWCtgzGFk7GKtXnaFESuLd0EV5O22Qvgb9JYLASHnOtbx7aFaf
   9kd9ZMhqX1wPV3L3vC2d9+HntVOpr0rGql4waI4Ab1tcaldzh8J8RM/b1
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="301548706"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="301548706"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 04:05:28 -0700
X-IronPort-AV: E=McAfee;i="6500,9779,10483"; a="624110565"
X-IronPort-AV: E=Sophos;i="5.93,351,1654585200"; 
   d="scan'208";a="624110565"
Received: from kjurkiew-mobl.ger.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.251.211.248])
  by fmsmga007-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Sep 2022 04:05:26 -0700
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Jiri Slaby <jirislaby@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial <linux-serial@vger.kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH v3 2/4] Documentation: rs485: Link reference properly
Date:   Wed, 28 Sep 2022 14:05:07 +0300
Message-Id: <20220928110509.13544-3-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220928110509.13544-1-ilpo.jarvinen@linux.intel.com>
References: <20220928110509.13544-1-ilpo.jarvinen@linux.intel.com>
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

