Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A2D73AF59
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 06:18:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230235AbjFWESO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 00:18:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230186AbjFWERl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 00:17:41 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0737F213A
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:17:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687493836; x=1719029836;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=ch+dkohF1kGn4gVUKxogbvolyJIvPdhN+7DklC7vt6Y=;
  b=fO59eaay9v8F3QmlTsS4D4dEjzgKWL2KU79BStUdcIqt0yqQTnsJp1QK
   /m8gCxcIzmuZ5teV8ZQx6dmoc5CkzpCMgqu25ewzfW6e8oWVwznjSXSOj
   NaDqQm+fwgqcHvhbzcDINDQPOYfwJlRAofiDQP0xn2iSFXIUsirp/urI7
   n3c4S46m3OeXGTEsWxU+bDngvYwugRPzgxOWfB2pA51l5tEtEBoHIJZ0s
   +yDv3mCgTnOq9l56rAfB96Y0rTpMuU8L/NDEAgBGlR9posa/aKYTTz52H
   yzJAZMxcO5vo1jBK2WXF6w6pbhA+UcorSsGGzlDeOcso9o4n3Kvq214YP
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="350445604"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="350445604"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 21:17:10 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="744859469"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="744859469"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga008.jf.intel.com with ESMTP; 22 Jun 2023 21:17:09 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 0/1] fix bug in saving controller data
Date:   Fri, 23 Jun 2023 12:16:40 +0800
Message-Id: <20230623041641.1865437-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ang Tien Sung <tien.sung.ang@intel.com>

hi Dinh,
Re-sending this as i did a mistake to ommit the "Fixes" tag.
As requested by you, i have created this patch first to be upstream.
This patch fixes the incorrect usage of the drvdata storage in the driver.

Ang Tien Sung (1):
  firmware: stratix10-svc: fix bug in saving controller data

 drivers/firmware/stratix10-svc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.25.1

