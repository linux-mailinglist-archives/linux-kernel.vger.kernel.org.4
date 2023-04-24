Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EA9B6ECB95
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Apr 2023 13:50:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231425AbjDXLul (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Apr 2023 07:50:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231299AbjDXLui (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Apr 2023 07:50:38 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B93EB3A9A;
        Mon, 24 Apr 2023 04:50:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1682337037; x=1713873037;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=japwrMOfXn2KoHprkjEiVHPePnkOiErVHAt4BQCD0/A=;
  b=cKk55et0Hy++psSpIJEjNvmc4FkTXbvkCUKI/EjQLCa7jMG922+QLP1d
   VxLVr08WwtzV7w3+8lsA47fW+lJRrymTA2PCnSfJPwlBuAcUu8srU7LCi
   GF5uBmyXGZHKxCC8VQui02Byh5y9KKNaN4OoLXasMpLXzMwdlJF64DGf9
   gkMakiX1ZCTMiNsjGvbgDcKlbeSSJlz+nkJq9QnIrS+gm62AXAHFc+DcK
   UFE+2yEXnM5TGkZ/kEjjjjLZjIWO7ldmGdiqjMkTz2xF1hnTspKeOkdZE
   8cqIfAwD4R3kKMcPL0c+s1VPbqK4G5bx7gWWwvSK4JwsM39oS1DgF87FE
   w==;
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="348340730"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="348340730"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 24 Apr 2023 04:50:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6600,9927,10689"; a="725660801"
X-IronPort-AV: E=Sophos;i="5.99,222,1677571200"; 
   d="scan'208";a="725660801"
Received: from ubuntu.bj.intel.com ([10.238.155.108])
  by orsmga001.jf.intel.com with ESMTP; 24 Apr 2023 04:50:34 -0700
From:   Zqiang <qiang1.zhang@intel.com>
To:     paulmck@kernel.org, frederic@kernel.org, quic_neeraju@quicinc.com,
        joel@joelfernandes.org, boqun.feng@gmail.com,
        qiang.zhang1211@gmail.com, qiang1.zhang@intel.com
Cc:     rcu@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH] MAINTAINERS: Update qiang1.zhang@intel.com to qiang.zhang1211@gmail.com
Date:   Mon, 24 Apr 2023 19:51:07 +0800
Message-Id: <20230424115107.1627076-1-qiang1.zhang@intel.com>
X-Mailer: git-send-email 2.32.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The qiang1.zhang@intel.com will no longer be used, update to
qiang.zhang1211@gmail.com.

Signed-off-by: Zqiang <qiang1.zhang@intel.com>
---
 MAINTAINERS | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/MAINTAINERS b/MAINTAINERS
index e03067b857a2..72c8efa5bbd5 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -17643,7 +17643,7 @@ M:	Boqun Feng <boqun.feng@gmail.com>
 R:	Steven Rostedt <rostedt@goodmis.org>
 R:	Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
 R:	Lai Jiangshan <jiangshanlai@gmail.com>
-R:	Zqiang <qiang1.zhang@intel.com>
+R:	Zqiang <qiang.zhang1211@gmail.com>
 L:	rcu@vger.kernel.org
 S:	Supported
 W:	http://www.rdrop.com/users/paulmck/RCU/
-- 
2.32.0

