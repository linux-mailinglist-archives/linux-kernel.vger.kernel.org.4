Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C4186F1EB0
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 21:17:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346272AbjD1TRk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 15:17:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229862AbjD1TRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 15:17:37 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D28F92134
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 12:17:35 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-52503bfeb07so74646a12.3
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 12:17:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1682709455; x=1685301455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=V/c8uRbwwP0oktN8Q6FJxvMxpBfclwld1hCDkRXWUfs=;
        b=R1bgskUAKm7pZ0pTjkgtdtw25rXseg0tc16RNncwq38lXHWBUxwGm101B8qPs3Y3Y/
         jg6fBoFWV2Y1bLYNb8WU6EpqqAjEZ7GPBPMH8QoJPWx5PHrETQ57XPRF+EZ0HTmDNOu+
         brvIzLIN0BVmCb9z3c3V0TJ2ErjKMf88mtnhxUpFb8jUeD2wqRa4PKbl+6H8N4EYzntG
         MCQA247alzQLcmxsZMaTpCUXCVSOVmShzpYKwsT5PHawZXc+HaZHKc/vSOXoX0ldOEBD
         z/FR6C3rz9y5rFI7QoDsrnkpQrba+mqwBtFmWkRlrGqAoYmKMy90yNldPu3yGAcT/YNs
         Vd8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682709455; x=1685301455;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=V/c8uRbwwP0oktN8Q6FJxvMxpBfclwld1hCDkRXWUfs=;
        b=OT0gmmsZnH87sPcdoWblCW6akuuzsOM27fQ2UoR89MHEWt3084dw9VI/phjJ1wGgdn
         CED9U/rX4+W1SnVAOudOPpF7nG2jIwTQBGkivxCwrEktEu51ljhJ0q3+6rXm2rrywfLs
         KIoWm6ecSwQMsQvuxmRls6PclppRgAaKCNlg5hlo44OLN/DUcTg52Ka+SJBP9R/UBlfM
         HAjgiiOq3A17KNFK6qs20v4gWIEwYomJLk7bqecrPHd2x6tNPsMnrptYNSvgiVWIZ6/6
         uBucGr7LCVVAy2CxwnPzc8i3MBw9APMQfNxnY63ld3poSgeZNLgTDiAmeO5zz1NYfXkS
         C38A==
X-Gm-Message-State: AC+VfDy/zdaHmHxK/zqxFVLQn1K5dPOmvDSl7m//WI5RQtc5+d1faEru
        rY2UGOliywg/inTEQRhnAs2rfy8SMQrC
X-Google-Smtp-Source: ACHHUZ4Yyd0J5IkUzl+hyIYWXIb+BUDOewb39TixIiRUykOoC333UVQCfMT0xH6V/L9mhCD3w8UVP3wWo4h5
X-Received: from afranji.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:47f1])
 (user=afranji job=sendgmr) by 2002:a63:8a4b:0:b0:51b:70c9:c1e0 with SMTP id
 y72-20020a638a4b000000b0051b70c9c1e0mr1562202pgd.12.1682709455253; Fri, 28
 Apr 2023 12:17:35 -0700 (PDT)
Date:   Fri, 28 Apr 2023 19:17:33 +0000
In-Reply-To: <c49aa7b7bbc016b6c8b698ac2ce3b9d866b551f9.1678643052.git.isaku.yamahata@intel.com>
Mime-Version: 1.0
References: <c49aa7b7bbc016b6c8b698ac2ce3b9d866b551f9.1678643052.git.isaku.yamahata@intel.com>
X-Mailer: git-send-email 2.40.1.495.gc816e09b53d-goog
Message-ID: <20230428191733.3428555-1-afranji@google.com>
Subject: Re: [PATCH v13 098/113] KVM: TDX: Handle TDX PV map_gpa hypercall
From:   Ryan Afranji <afranji@google.com>
To:     isaku.yamahata@intel.com
Cc:     dmatlack@google.com, erdemaktas@google.com,
        isaku.yamahata@gmail.com, kai.huang@intel.com, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com,
        sagis@google.com, seanjc@google.com, zhi.wang.linux@gmail.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+static int tdx_map_gpa(struct kvm_vcpu *vcpu)
+{
+	struct kvm *kvm = vcpu->kvm;
+	gpa_t gpa = tdvmcall_a0_read(vcpu);
+	gpa_t size = tdvmcall_a1_read(vcpu);
+	gpa_t end = gpa + size;
+
+	if (!IS_ALIGNED(gpa, PAGE_SIZE) || !IS_ALIGNED(size, PAGE_SIZE) ||
+	    end < gpa ||
+	    end > kvm_gfn_shared_mask(kvm) << (PAGE_SHIFT + 1) ||
+	    kvm_is_private_gpa(kvm, gpa) != kvm_is_private_gpa(kvm, end)) {
+		tdvmcall_set_return_code(vcpu, TDG_VP_VMCALL_INVALID_OPERAND);

According to table 3-6 of the GHCI spec, TDG.VP.VMCALL_ALIGN_ERROR should be
returned if there is an alignment error for the size or start GPA. Right now,
TDG_VP_VMCALL_INVALID_OPERAND is being returned instead. Can this be updated?

+		return 1;
+	}
+
+	return tdx_vp_vmcall_to_user(vcpu);
+}
+
