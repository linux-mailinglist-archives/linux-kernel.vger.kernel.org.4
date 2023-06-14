Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6622672F29B
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 04:34:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239815AbjFNCew (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 22:34:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34516 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232258AbjFNCeu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 22:34:50 -0400
Received: from mail.208.org (unknown [183.242.55.162])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBB54123
        for <linux-kernel@vger.kernel.org>; Tue, 13 Jun 2023 19:34:48 -0700 (PDT)
Received: from mail.208.org (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTP id 4QgqJP5RyszBJL9v
        for <linux-kernel@vger.kernel.org>; Wed, 14 Jun 2023 10:34:45 +0800 (CST)
Authentication-Results: mail.208.org (amavisd-new); dkim=pass
        reason="pass (just generated, assumed good)" header.d=208.org
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=208.org; h=
        content-transfer-encoding:content-type:message-id:user-agent
        :references:in-reply-to:subject:to:from:date:mime-version; s=
        dkim; t=1686710085; x=1689302086; bh=/153KFImgT+gktyfP9V8RqyB2R8
        agRq0rd6nSMh42WI=; b=c6jHFt+8uhaVx8AgCb70a/2HxXNGL3cV1/olgvE6wsM
        b/Nc7kYIM+dhAFrRDhaABSDg2lUujKDHq+BsZxMs1SazTBEeXbIS0FvG1ayEk3t+
        4YnM7iK9LskVvxahleYV2o23Bpa7DvM9Kwd08hBI0JW1QeUAI4zs+tbkLX/8OmOt
        ZztmzXwJSKkoOioKlzuZ3EbBAZyjZ8i0ot+vR/oO11O7YmwFW+CWF1T/9/HdZPKo
        t0s+ocM1sVA1guZRPlzBOLPIh19EnVvbwV4M3/3OC+f3vKdZBJdg4XH3/TLzrpMC
        sGrV5RCaHsceH055a+TawgjEDXyo3P2db9ADeIqMLIA==
X-Virus-Scanned: amavisd-new at mail.208.org
Received: from mail.208.org ([127.0.0.1])
        by mail.208.org (mail.208.org [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id z5A0iNglBpst for <linux-kernel@vger.kernel.org>;
        Wed, 14 Jun 2023 10:34:45 +0800 (CST)
Received: from localhost (email.208.org [127.0.0.1])
        by mail.208.org (Postfix) with ESMTPSA id 4QgqJP2FFCzBJCMY;
        Wed, 14 Jun 2023 10:34:45 +0800 (CST)
MIME-Version: 1.0
Date:   Wed, 14 Jun 2023 10:34:45 +0800
From:   baomingtong001@208suo.com
To:     mpe@ellerman.id.au, npiggin@gmail.com, christophe.leroy@csgroup.eu,
        pbonzini@redhat.com, paulus@ozlabs.org, seanjc@google.com,
        thuth@redhat.com
Cc:     linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: PPC: remove unneeded variable
In-Reply-To: <20230614023206.3865-1-luojianhong@cdjrlc.com>
References: <20230614023206.3865-1-luojianhong@cdjrlc.com>
User-Agent: Roundcube Webmail
Message-ID: <de7ae31f88510a6b04f29fc01ab44854@208suo.com>
X-Sender: baomingtong001@208suo.com
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.9 required=5.0 tests=BAYES_00,DKIM_INVALID,
        DKIM_SIGNED,RDNS_NONE,SPF_HELO_FAIL,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

fix the following coccicheck warning:

arch/powerpc/kvm/book3s_pr.c:424:5-6: Unneeded variable: "r".

Signed-off-by: Mingtong Bao <baomingtong001@208suo.com>
---
  arch/powerpc/kvm/book3s_pr.c | 4 ++--
  1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/powerpc/kvm/book3s_pr.c b/arch/powerpc/kvm/book3s_pr.c
index 9118242063fb..d03b31b240d7 100644
--- a/arch/powerpc/kvm/book3s_pr.c
+++ b/arch/powerpc/kvm/book3s_pr.c
@@ -421,14 +421,14 @@ void kvmppc_restore_tm_pr(struct kvm_vcpu *vcpu)

  static int kvmppc_core_check_requests_pr(struct kvm_vcpu *vcpu)
  {
-    int r = 1; /* Indicate we want to get back into the guest */
+    /* Indicate we want to get back into the guest */

      /* We misuse TLB_FLUSH to indicate that we want to clear
         all shadow cache entries */
      if (kvm_check_request(KVM_REQ_TLB_FLUSH, vcpu))
          kvmppc_mmu_pte_flush(vcpu, 0, 0);

-    return r;
+    return 1;
  }

  /************* MMU Notifiers *************/
