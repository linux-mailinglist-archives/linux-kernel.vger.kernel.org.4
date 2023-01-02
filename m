Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0731C65B5F4
	for <lists+linux-kernel@lfdr.de>; Mon,  2 Jan 2023 18:34:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236159AbjABRe1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 Jan 2023 12:34:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232419AbjABReX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Jan 2023 12:34:23 -0500
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503FD203;
        Mon,  2 Jan 2023 09:34:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1672680863; x=1704216863;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=1nRR3VNrl7EJ0au8ldRmcribgW30IxDoTp9sK1xGEbM=;
  b=Oqf8mwlDQFOBA6J1kDd8CwsoPfIsGnnEOLrnWoplE/XZBRhwCOjMi3p7
   1vHH2aEf0w8tXtjMIFe8iOBAVtrusF2e3pfbdpqOzvMVjhjTaTEfiMSkk
   EMC05IX1fPtRvFHK9FGynYhSEj8FyAXd08HQ2BkOD5mmD3ApVSphyvtFU
   6kKZhUU6iA64hvWtLMkav0kd0VpGtchO9FDKNQLewKu0jiHkuNur0CnPi
   h1SDBrNgIroZiNB3hEo0liq0RwtD40yw5N+pfSEk45RVW6RWZC5QFdxgl
   fRVoBgBGzEEOO1RelxvDt9GH8BRLWfffpsdP7b0McdUjUxeUyatJ8jIjy
   w==;
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="321583637"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="321583637"
Received: from fmsmga008.fm.intel.com ([10.253.24.58])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Jan 2023 09:34:23 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10578"; a="717862165"
X-IronPort-AV: E=Sophos;i="5.96,294,1665471600"; 
   d="scan'208";a="717862165"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga008.fm.intel.com with ESMTP; 02 Jan 2023 09:34:21 -0800
Received: by black.fi.intel.com (Postfix, from userid 1003)
        id 9D44CF4; Mon,  2 Jan 2023 19:34:53 +0200 (EET)
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>
Subject: [PATCH v2 0/3] iio: adc: ti-adc128s052: Some refactorings
Date:   Mon,  2 Jan 2023 19:34:47 +0200
Message-Id: <20230102173450.29882-1-andriy.shevchenko@linux.intel.com>
X-Mailer: git-send-email 2.35.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Refactor driver to use newest API and drop ACPI_PTR() which is rather
useless.

Changelog v2:
- united two previously sent series into a single one
- dropped for now the endianess patch
- fixed compilation issues (Jonathan, LKP)

Andy Shevchenko (3):
  iio: adc: ti-adc128s052: Switch to use spi_get_device_match_data()
  iio: adc: ti-adc128s052: Drop anti-pattern of ACPI_PTR() use
  iio: adc: ti-adc128s052: Sort headers

 drivers/iio/adc/ti-adc128s052.c | 54 +++++++++++++++------------------
 1 file changed, 24 insertions(+), 30 deletions(-)

-- 
2.35.1

