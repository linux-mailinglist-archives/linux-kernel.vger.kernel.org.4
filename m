Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28D6173AF48
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Jun 2023 06:13:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231178AbjFWENG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Jun 2023 00:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229847AbjFWENC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Jun 2023 00:13:02 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9337D2116
        for <linux-kernel@vger.kernel.org>; Thu, 22 Jun 2023 21:12:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1687493573; x=1719029573;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=c0NyFfAN3XEX2t+/vYaYRvi3YXz90cLfHHANNoJGWcQ=;
  b=Sy/J+7my+InsJNuiR4b9jJbjx320ar5lHdQ3Qtv9Iy7NTHELr6Dr1NV+
   KhHMmT8Bhzs5yO+tHzBnx4nQMVDU92ZwrFXKNF/lSIufPha+2c+3MuqsY
   gzSDy+O5zNRaAZJWNRPXCiGZNPewx55KRu+eMl7pvR/eT+NhC5kEmK4NE
   GbrQWHKaPxnmPoNpwviteyRKbmko6IdVS5/yWKta1rUQh1w2+g9b0tQiU
   jmkChQ7J7KnFHH8iATBrIBtuQfMG08S2riT9KT775hLaUflA/+B1ItTUD
   jGc7eaBQPeFqJolcsW/EFBFgW1F/NMpvYOTdmnLriahmIw0G70IhwAyZx
   g==;
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="360705346"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="360705346"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Jun 2023 21:12:53 -0700
X-IronPort-AV: E=McAfee;i="6600,9927,10749"; a="749627063"
X-IronPort-AV: E=Sophos;i="6.01,150,1684825200"; 
   d="scan'208";a="749627063"
Received: from unknown (HELO localhost.localdomain) ([10.226.216.90])
  by orsmga001.jf.intel.com with ESMTP; 22 Jun 2023 21:12:50 -0700
From:   tien.sung.ang@intel.com
To:     Dinh Nguyen <dinguyen@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Ang Tien Sung <tien.sung.ang@intel.com>
Subject: [PATCH 0/1] fix bug in saving controller data
Date:   Fri, 23 Jun 2023 12:12:18 +0800
Message-Id: <20230623041219.1865239-1-tien.sung.ang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ang Tien Sung <tien.sung.ang@intel.com>

hi Dinh,
As requested by you, i have created this patch first to be upstream.
This patch fixes the incorrect usage of the drvdata storage in the
driver.

Ang Tien Sung (1):
  firmware: stratix10-svc: fix bug in saving controller data

 drivers/firmware/stratix10-svc.c | 7 ++++---
 1 file changed, 4 insertions(+), 3 deletions(-)

-- 
2.25.1

