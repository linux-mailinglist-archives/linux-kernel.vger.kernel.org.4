Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BA836C5D9C
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 04:56:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230202AbjCWD4F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Mar 2023 23:56:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230072AbjCWD4C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Mar 2023 23:56:02 -0400
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44BCA14216;
        Wed, 22 Mar 2023 20:55:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1679543757; x=1711079757;
  h=from:to:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=3VeGjc5Z3KoM+dy6+axVz1puzG++MgVzUu2uNijmQhQ=;
  b=cqpE5GRAhxtk+mSvIOsvOYK0s0c/wNfhdEfHJZxjeVl2sXo+BXmZfI3R
   jPHoEe+LPrBtqKxzEGngycLKz8120eunReMZ3FGmTczJcJhnHcz6pDLh2
   vYfVwWWyM59MPMy6lltdELC8EPpSybdzX6ZT+C7nHWSVFTUnEj5/DyHqa
   bZiBDZpnvhTlQGQ8z42UTwtefa4F87D7ybqLqBqlTbJJupu25aBOLTrI3
   zkKWnVmfGYiibqrUOFKxDi7M28/uccZaPRSZwr7/yPnG7hOaE2hiBEx9A
   V+bVDlEDMP2YeKb8VFr6ZdcbuLC45xWOecDkoiLdKg1I1S6i6M9Hy7zkf
   A==;
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="341752247"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="341752247"
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 20:55:46 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10657"; a="771299185"
X-IronPort-AV: E=Sophos;i="5.98,283,1673942400"; 
   d="scan'208";a="771299185"
Received: from zq-optiplex-7090.bj.intel.com ([10.238.156.129])
  by fmsmga003-auth.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Mar 2023 20:55:45 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, joel@joelfernandes.org,
        rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Add Zqiang as a RCU reviewer
Date:   Thu, 23 Mar 2023 12:07:29 +0800
Message-Id: <20230323040729.145154-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I have spent about two years studying and contributing to RCU,
and sharing RCU-related knowledge within my team, if possible,
please consider me as R ;-).

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 MAINTAINERS | 1 +
 1 file changed, 1 insertion(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 8d5bc223f305..b304d3c7b45b 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17642,6 +17642,7 @@ R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 R:	Lai Jiangshan <jiangshanlai@gmail.com>
 R:	Joel Fernandes <joel@joelfernandes.org>
+R:	Zqiang <qiang1.zhang@intel.com>
 L:	rcu@vger.kernel.org
 S:	Supported
 W:	http://www.rdrop.com/users/paulmck/RCU/
-- 
2.25.1

