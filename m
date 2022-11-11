Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 75AB6625008
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 03:14:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231824AbiKKCOq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Nov 2022 21:14:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiKKCOp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Nov 2022 21:14:45 -0500
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EAE1057C
        for <linux-kernel@vger.kernel.org>; Thu, 10 Nov 2022 18:14:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1668132884; x=1699668884;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=7xegAUbZpkrU7W44Zn4R5tO1p9I94hcYLtcpaHdKlHc=;
  b=kAhKzemU0cUzy8JL281K7ivvaMqXp4fqQpzU567iYLkeBUnIjFf2LvLm
   M1IL8A8oJ56JMKZceBWUKOEuG6xTC/hu2IrigTIpO8mKcdqkhI0sfKMFn
   NPBNxeJZVPViHu7+VoSTIHMBwtnJBi3igG7q8h86lWvdllXak4fYQkGEg
   aAYgCpWlJ1JL9BASFZGJBkeFsUw42Bq/UXRBkoiWamfXWrezUDYr4kxsk
   cwnYuFqARqu5chj5c1SDhxKNGXU+nNTXLUSVZzA7MG0v3xoZT+aJeHtzc
   F2CuTXUJIq2K7xRNSOIRmSwvCIYV2wylta06Nek6DBeylQQWet2WHosiQ
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="299007573"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="299007573"
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 18:14:44 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10527"; a="615335544"
X-IronPort-AV: E=Sophos;i="5.96,155,1665471600"; 
   d="scan'208";a="615335544"
Received: from bard-ubuntu.sh.intel.com ([10.239.185.57])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Nov 2022 18:14:42 -0800
From:   Bard Liao <yung-chuan.liao@linux.intel.com>
To:     alsa-devel@alsa-project.org, vkoul@kernel.org
Cc:     vinod.koul@linaro.org, linux-kernel@vger.kernel.org,
        pierre-louis.bossart@linux.intel.com, bard.liao@intel.com
Subject: [PATCH 0/2] soundwire: revisit support for clock registers
Date:   Fri, 11 Nov 2022 10:16:31 +0800
Message-Id: <20221111021633.39908-1-yung-chuan.liao@linux.intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

SoundWire clock base and scale registers are only supported for SDCA
devices. That's fine, but that leaves SoundWire 1.2 with optional
registers not supported. This is a corner case that needs to be supported.

Pierre-Louis Bossart (2):
  soundwire: remove is_sdca boolean property
  soundwire: enable optional clock registers for SoundWire 1.2 devices

 drivers/soundwire/bus.c           | 11 ++++++-----
 include/linux/soundwire/sdw.h     |  6 ++++--
 sound/soc/codecs/rt1316-sdw.c     |  1 -
 sound/soc/codecs/rt711-sdca-sdw.c |  1 -
 4 files changed, 10 insertions(+), 9 deletions(-)

-- 
2.25.1

