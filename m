Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 872146B4D91
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 17:50:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231817AbjCJQuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 11:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231408AbjCJQuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 11:50:09 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB00A12CBA2;
        Fri, 10 Mar 2023 08:47:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1678466833; x=1710002833;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3DsGu1jwco8wmdWAk/QWXYjdi9zG7FhO1g6n5CcqOjE=;
  b=De8azeCbnLdsZf8XeiS5QKsQ7KsKdl3XIvH65ywgzFNVG14HJFwrAjBu
   I8Fhm3oLm7lBLpkGMnH8odAgByCBZRQeu3Ot45rkon3SlXymLesDs9jvQ
   SI7jOlgRWmrL8ehWsQaUbH1A6U7CRkOlmNMwQ/uGnS7rVKrTKft0i97Qr
   LX5WWniQNKkdPupCethuX8CKameviPCUjyljGyfuFtxHu79MAQBoRYdPf
   AoFFa6sE7oyiRY5Fk3ASYEqvr9BJK8qQZLf10u3hCUrRoz1DKrDu+YePe
   io4WNv/wxsaKA13smPo/2AmLR+MsIIzB8DyNfC8ao9Idi1QdMH5oDD3N3
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="320621127"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="320621127"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Mar 2023 08:45:11 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10645"; a="746778622"
X-IronPort-AV: E=Sophos;i="5.98,250,1673942400"; 
   d="scan'208";a="746778622"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 10 Mar 2023 08:45:08 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 050B6143; Fri, 10 Mar 2023 18:45:52 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jens Axboe <axboe@kernel.dk>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-block@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 0/9] pktdvd: Clean up the driver
Date:   Fri, 10 Mar 2023 18:45:40 +0200
Message-Id: <20230310164549.22133-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.39.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,SPF_HELO_NONE,SPF_NONE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some cleanups to the recently resurrected driver.

v2:
- added tags (Greg)

Andy Shevchenko (9):
  pktcdvd: Get rid of custom printing macros
  pktcdvd: replace sscanf() by kstrtoul()
  pktcdvd: use sysfs_emit() to instead of scnprintf()
  pktcdvd: Get rid of pkt_seq_show() forward declaration
  pktcdvd: Drop redundant castings for sector_t
  pktcdvd: Use DEFINE_SHOW_ATTRIBUTE() to simplify code
  pktcdvd: Use put_unaligned_be16() and get_unaligned_be16()
  pktcdvd: Get rid of redundant 'else'
  pktcdvd: Sort headers

 drivers/block/pktcdvd.c      | 525 +++++++++++++++++------------------
 include/linux/pktcdvd.h      |   1 -
 include/uapi/linux/pktcdvd.h |   1 +
 3 files changed, 257 insertions(+), 270 deletions(-)

-- 
2.39.1

