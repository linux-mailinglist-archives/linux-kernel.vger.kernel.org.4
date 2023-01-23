Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E718E67836B
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 18:39:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231948AbjAWRjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 12:39:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230040AbjAWRjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 12:39:08 -0500
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35A98298C0;
        Mon, 23 Jan 2023 09:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1674495547; x=1706031547;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=avO3GBs4iE4I5FQsUjf7dZGcChTCRme8c3/1w9qTRjc=;
  b=iowtkddKtuJ0kWkAnZxlCWj2a0wjRakIZi5sX24/eNuhDqNPahHdQQDK
   0Lf2ra0mHSLNBLhp046YGp1Rmm3zUq5LL9wEm9mFiPc4Lb3KPavhjNhXL
   s7XD0XqYYZsgWquHnChSDGsSKgdwtmwR4S3MATq+YkFH9fvw01C4hAVE8
   dZy8JmqUOnzXNgtEhKMa7PzqDGyJTlYhNt7F4bsjWyZWZdWsuRMHqpDSF
   VEgAjZR3R6CXMfg3BzN5VOMHEnxXga2BTrzWw3MHwcPLLCEaVXG3gONeH
   cluolNhuIJ1Wkytb8ULc8N8lN0JFibdal2jxILOIYzM3ldBNVU6EW8F5G
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="390601959"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="390601959"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 09:39:06 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10599"; a="694017753"
X-IronPort-AV: E=Sophos;i="5.97,240,1669104000"; 
   d="scan'208";a="694017753"
Received: from giangiac-mobl1.amr.corp.intel.com (HELO ijarvine-MOBL2.ger.corp.intel.com) ([10.249.47.71])
  by orsmga001-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Jan 2023 09:39:04 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/2] serial: fix recently introduced problems in tty-next
Date:   Mon, 23 Jan 2023 19:38:55 +0200
Message-Id: <20230123173857.40695-1-ilpo.jarvinen@linux.intel.com>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

One build fail due to tty-linus -> tty-next merge and one problem
smatch found.

Ilpo Järvinen (2):
  serial: qcom_geni: Fix variable naming
  serial: liteuart: Use proper error rollback

 drivers/tty/serial/liteuart.c         |  2 +-
 drivers/tty/serial/qcom_geni_serial.c | 10 +++++-----
 2 files changed, 6 insertions(+), 6 deletions(-)

-- 
2.30.2

