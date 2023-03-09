Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 05CE46B1D6A
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Mar 2023 09:10:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230128AbjCIIJs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Mar 2023 03:09:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229875AbjCIIJc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Mar 2023 03:09:32 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7F9C7043F;
        Thu,  9 Mar 2023 00:09:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678349371; x=1709885371;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=v6jpZgdYFEZXNyqMZn4MjEfwAT0ttFdoAXLFP/3hFsE=;
  b=efSKpPhxyKWKpFCG5nsyLbMgDamG35GkLY55v56tKDDBVF3k4TTG3ApC
   jx3Za8KYgaMjLJAKoR2B7bkyUXLbh1sJwEm7rsY8xW0FjWQlBh9nVNrx0
   4g0pdm8jfUgdfkjt87AyznoaBphONqPCqX15JSKY8M17EQaml3uE+X3W7
   GKCJpGHwHHqtbC1BKA1VAjWEEq4uKw55njcNiS9iN9+iLOCVEsrOvezFJ
   P8RUK7yVI4kPLu+xoYVQvb1HnOzbv7SKr9peNXkjtdfEuyK2kcooW/+lf
   fnWjak1L6Y6Xn53I8rVdSGmDNZBaPRyBCnwGbNUdQQUM0GkyEgKn4Faqp
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="333853535"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="333853535"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:31 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10643"; a="746227942"
X-IronPort-AV: E=Sophos;i="5.98,245,1673942400"; 
   d="scan'208";a="746227942"
Received: from unknown (HELO ijarvine-MOBL2.mshome.net) ([10.237.66.35])
  by fmsmga004-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Mar 2023 00:09:30 -0800
From:   =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
To:     linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        =?UTF-8?q?Ilpo=20J=C3=A4rvinen?= <ilpo.jarvinen@linux.intel.com>
Subject: [PATCH 0/8] serial: Core cleanups
Date:   Thu,  9 Mar 2023 10:09:15 +0200
Message-Id: <20230309080923.11778-1-ilpo.jarvinen@linux.intel.com>
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

Serial core cleanups.

Ilpo Järvinen (8):
  serial: Use ARRAY_SIZE() with iso7816 reserved array
  serial: Use B0 instead of implicit zero assumption
  serial: Remove extern from func prototypes in headers
  serial: Move uart_change_speed() earlier
  serial: Rename uart_change_speed() to uart_change_line_settings()
  serial: Make hw_stopped bool
  serial: Rename hw_stopped to old_hw_stopped & improve logic
  serial: Remove uart_wait_until_sent() forward declaration

 drivers/tty/serial/serial_core.c | 113 +++++++++++++++----------------
 include/linux/serial_8250.h      |  41 +++++------
 include/linux/serial_core.h      |  15 ++--
 3 files changed, 80 insertions(+), 89 deletions(-)

-- 
2.30.2

