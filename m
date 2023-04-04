Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AAFDA6D5CD6
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 12:14:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234199AbjDDKOm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 06:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46384 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbjDDKOh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 06:14:37 -0400
Received: from smtp-fw-6001.amazon.com (smtp-fw-6001.amazon.com [52.95.48.154])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AB491FDB;
        Tue,  4 Apr 2023 03:14:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1680603272; x=1712139272;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=IyWFenEADgmbE/NXe8L+sSh8N8k+vwA5Bdo4yFRkR74=;
  b=jHrkXqVu86WBi4V9bCldGFJxMyhRPK40QoEw8tBAdItcOQKmSw1uaJn+
   40vuo05HGuusSxOy/Fu4/bNLCkJjyza80MMzpEl9dK8mSw6dJqoIU1Jyi
   YZgtbkrEIeWml2cEfm3ujMb0vYQkEn00gEs5uSxumBc6y3RDuGxYmT2Ea
   U=;
X-IronPort-AV: E=Sophos;i="5.98,317,1673913600"; 
   d="scan'208";a="316543388"
Received: from iad12-co-svc-p1-lb1-vlan2.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com) ([10.43.8.2])
  by smtp-border-fw-6001.iad6.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Apr 2023 10:14:26 +0000
Received: from EX19MTAUWC002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan3.iad.amazon.com [10.40.163.38])
        by email-inbound-relay-iad-1a-m6i4x-b5bd57cf.us-east-1.amazon.com (Postfix) with ESMTPS id 77F8445367;
        Tue,  4 Apr 2023 10:14:23 +0000 (UTC)
Received: from EX19D002ANA003.ant.amazon.com (10.37.240.141) by
 EX19MTAUWC002.ant.amazon.com (10.250.64.143) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.25; Tue, 4 Apr 2023 10:14:22 +0000
Received: from b0f1d8753182.ant.amazon.com (10.95.136.176) by
 EX19D002ANA003.ant.amazon.com (10.37.240.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.26;
 Tue, 4 Apr 2023 10:14:18 +0000
From:   Takahiro Itazuri <itazur@amazon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-doc@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        David Dunn <daviddunn@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Takahiro Itazuri <zulinx86@gmail.com>,
        "Takahiro Itazuri" <itazur@amazon.com>,
        kernel test robot <lkp@intel.com>
Subject: [PATCH v4] docs: kvm: x86: Fix broken field list
Date:   Tue, 4 Apr 2023 11:14:01 +0100
Message-ID: <20230404101401.25012-1-itazur@amazon.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.95.136.176]
X-ClientProxiedBy: EX19D036UWB002.ant.amazon.com (10.13.139.139) To
 EX19D002ANA003.ant.amazon.com (10.37.240.141)
X-Spam-Status: No, score=-9.7 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_SPF_WL autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add missing ":" to fix a broken field list.

Fixes: ba7bb663f554 ("KVM: x86: Provide per VM capability for disabling PMU virtualization")
Reported-by: kernel test robot <lkp@intel.com>
Link: https://lore.kernel.org/oe-kbuild-all/202304041708.siWlxmyD-lkp@intel.com/
Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
---
v3 -> v4
* Add "Reported-by:" tag.
* Link to v3: https://lore.kernel.org/all/20230404090052.9872-1-itazur@amazon.com/

v2 -> v3
* Add another missing ":"
* Link to v2: https://lore.kernel.org/all/20230331093116.99820-1-itazur@amazon.com/

v1 -> v2
* Fix commit message to say "Do foo" instead of "This commit does foo".
* Add "Fixes:" tag.
* Link to v1: https://lore.kernel.org/all/20230330233956.78246-1-itazur@amazon.com/

 Documentation/virt/kvm/api.rst | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 62de0768d6aa..a5c803f39832 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8296,11 +8296,11 @@ ENOSYS for the others.
 8.35 KVM_CAP_PMU_CAPABILITY
 ---------------------------
 
-:Capability KVM_CAP_PMU_CAPABILITY
+:Capability: KVM_CAP_PMU_CAPABILITY
 :Architectures: x86
 :Type: vm
 :Parameters: arg[0] is bitmask of PMU virtualization capabilities.
-:Returns 0 on success, -EINVAL when arg[0] contains invalid bits
+:Returns: 0 on success, -EINVAL when arg[0] contains invalid bits
 
 This capability alters PMU virtualization in KVM.
 
-- 
2.38.0

