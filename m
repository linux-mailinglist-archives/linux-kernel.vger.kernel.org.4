Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5AF56D1C6F
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:32:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232181AbjCaJcs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231718AbjCaJca (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:32:30 -0400
Received: from smtp-fw-9103.amazon.com (smtp-fw-9103.amazon.com [207.171.188.200])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E31E1B372;
        Fri, 31 Mar 2023 02:32:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=amazon.com; i=@amazon.com; q=dns/txt; s=amazon201209;
  t=1680255132; x=1711791132;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=NyBlKbROCGsMWhgK6uOMVGZcqOIwQUHp0D2OyMsRSWQ=;
  b=omA71QLHVve2frxFO7FVf3yhjnLhxI95izUsrMBaeqX86yCyX+sgVMJn
   hkfcwaLlRznVLdm6tgQJ3jIkcPYqBRepOVE6uGR/QKzOkBf7jIrkVIfmn
   7dPwWHXHHG/2qV127InQKj5/xaLM+RW1eRQmTLrCpYzirISXXqW5qY544
   s=;
X-IronPort-AV: E=Sophos;i="5.98,307,1673913600"; 
   d="scan'208";a="1118224456"
Received: from pdx4-co-svc-p1-lb2-vlan3.amazon.com (HELO email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com) ([10.25.36.214])
  by smtp-border-fw-9103.sea19.amazon.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Mar 2023 09:31:46 +0000
Received: from EX19MTAUWA002.ant.amazon.com (iad12-ws-svc-p26-lb9-vlan2.iad.amazon.com [10.40.163.34])
        by email-inbound-relay-iad-1a-m6i4x-96feee09.us-east-1.amazon.com (Postfix) with ESMTPS id 8360F44BE2;
        Fri, 31 Mar 2023 09:31:43 +0000 (UTC)
Received: from EX19D002ANA003.ant.amazon.com (10.37.240.141) by
 EX19MTAUWA002.ant.amazon.com (10.250.64.202) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.1118.22; Fri, 31 Mar 2023 09:31:39 +0000
Received: from b0f1d8753182.ant.amazon.com.com (10.106.83.11) by
 EX19D002ANA003.ant.amazon.com (10.37.240.141) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA) id 15.2.1118.26;
 Fri, 31 Mar 2023 09:31:35 +0000
From:   Takahiro Itazuri <itazur@amazon.com>
To:     <linux-kernel@vger.kernel.org>
CC:     <linux-doc@vger.kernel.org>, Paolo Bonzini <pbonzini@redhat.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        David Dunn <daviddunn@google.com>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Takahiro Itazuri <zulinx86@gmail.com>,
        "Takahiro Itazuri" <itazur@amazon.com>
Subject: [PATCH v2] docs: kvm: x86: Fix broken field list
Date:   Fri, 31 Mar 2023 10:31:16 +0100
Message-ID: <20230331093116.99820-1-itazur@amazon.com>
X-Mailer: git-send-email 2.38.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.106.83.11]
X-ClientProxiedBy: EX19D045UWC002.ant.amazon.com (10.13.139.230) To
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

Add a missing ":" to fix a broken field list.

Signed-off-by: Takahiro Itazuri <itazur@amazon.com>
Fixes: ba7bb663f554 ("KVM: x86: Provide per VM capability for disabling PMU virtualization")
---
v1 -> v2
* Fix commit message to say "Do foo" instead of "This commit does foo".
* Add "Fixes:" tag.
* Link to v1: https://lore.kernel.org/all/20230330233956.78246-1-itazur@amazon.com/

 Documentation/virt/kvm/api.rst | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 62de0768d..f9163590c 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -8296,7 +8296,7 @@ ENOSYS for the others.
 8.35 KVM_CAP_PMU_CAPABILITY
 ---------------------------
 
-:Capability KVM_CAP_PMU_CAPABILITY
+:Capability: KVM_CAP_PMU_CAPABILITY
 :Architectures: x86
 :Type: vm
 :Parameters: arg[0] is bitmask of PMU virtualization capabilities.
-- 
2.38.1

