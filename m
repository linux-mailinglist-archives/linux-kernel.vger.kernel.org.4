Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 63671669104
	for <lists+linux-kernel@lfdr.de>; Fri, 13 Jan 2023 09:32:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240463AbjAMIcD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 Jan 2023 03:32:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232661AbjAMIba (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 Jan 2023 03:31:30 -0500
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55E483FA31;
        Fri, 13 Jan 2023 00:31:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1673598689; x=1705134689;
  h=from:to:cc:subject:date:message-id;
  bh=awSDlfTlRp5iFfPWTx9Q63oj0kMeq2yfrqLk/bXSyzg=;
  b=XNjTJwASU3LO28VdTyZgVWJ6kasl5U4f1gKCSmz9pF6bYMTqqVCC/1k1
   Qx8K8WzWWDKOImB1CITmQGHjD+2cPKFB6K5ngtMA0Isu2aWmDe0FUyCcO
   Y7GJOixRXx3nVjmY7tuyHWpPquDtID+X/3BwRLItygJqejmJQynQa6Xi0
   tinkpi0eqaJLmTPp4J9JrGW/JDyzTeGtf4g3XPSXNQsKM2vN5uvTpraGu
   jwlxviknRRT9jP61YerKs8shGV5lttElJxiFgJhcr1ecC69amK5oT7Fe5
   xKcAQMCKaf9BPTmUuy8pHMYCPVXz6oqV1zIOCpJ2vVZQpHUMd0LGxrMC8
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="410183272"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="410183272"
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 00:31:28 -0800
X-IronPort-AV: E=McAfee;i="6500,9779,10588"; a="658157661"
X-IronPort-AV: E=Sophos;i="5.97,213,1669104000"; 
   d="scan'208";a="658157661"
Received: from qiuxu-clx.sh.intel.com ([10.239.53.105])
  by orsmga002-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 13 Jan 2023 00:31:25 -0800
From:   Qiuxu Zhuo <qiuxu.zhuo@intel.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Steven Rostedt <rostedt@goodmis.org>
Cc:     Qiuxu Zhuo <qiuxu.zhuo@intel.com>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>, rcu@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/1] Documentation/RCU: Fix a typo in checklist.rst
Date:   Fri, 13 Jan 2023 16:31:08 +0800
Message-Id: <20230113083108.59302-1-qiuxu.zhuo@intel.com>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

"Please not that you *cannot* rely..." probably has a typo.
Fix it.

Signed-off-by: Qiuxu Zhuo <qiuxu.zhuo@intel.com>
---
Not sure whether it's a too small typo to need this patch.
If so, sorry for the noise. :-)

 Documentation/RCU/checklist.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/RCU/checklist.rst b/Documentation/RCU/checklist.rst
index cc361fb01ed4..bd3c58c44bef 100644
--- a/Documentation/RCU/checklist.rst
+++ b/Documentation/RCU/checklist.rst
@@ -70,7 +70,7 @@ over a rather long period of time, but improvements are always welcome!
 	can serve as rcu_read_lock_sched(), but is less readable and
 	prevents lockdep from detecting locking issues.
 
-	Please not that you *cannot* rely on code known to be built
+	Please note that you *cannot* rely on code known to be built
 	only in non-preemptible kernels.  Such code can and will break,
 	especially in kernels built with CONFIG_PREEMPT_COUNT=y.
 
-- 
2.17.1

