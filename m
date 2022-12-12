Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C7DED64A55F
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Dec 2022 17:57:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232616AbiLLQ52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Dec 2022 11:57:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232408AbiLLQ5Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Dec 2022 11:57:25 -0500
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C1976275
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:57:24 -0800 (PST)
Received: by mail-pf1-x42c.google.com with SMTP id 124so337574pfy.0
        for <linux-kernel@vger.kernel.org>; Mon, 12 Dec 2022 08:57:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=70//rQiymp0ta/smjBI+CCfmZf4YlddRM39Xpu2+CnE=;
        b=S+fz7hvh5wmNXyUPTQy6sbeHr+C0U8zIQKg1m0gUKEef6tMQsKVNIt9v1ejCop6/mZ
         2L1WW2wyhmHZ+QA6jceRf9B+aoQutcM4GZczMFRpiQ1rGc8lEHs2RLucqcJGhVxSYv15
         mqZgeTRfyd6ZL81sCK+G2Qb2TCMy76CkfO6LsAq699NIfBUNIXKsdxuhQIGfxj0JahU7
         MtWBT2YtjbIILWpCiCQbFsVsD+lzZqP9IaEITra6outE7/bgtnnu4P5UtGHMj13IANy2
         +6dBU8xa7n9doncnyzReaTpw3wDZyH85HjxgbDQpr3W40l/LCrvs+Wb2wAnb9B5/2yQB
         Hbjg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=70//rQiymp0ta/smjBI+CCfmZf4YlddRM39Xpu2+CnE=;
        b=Yi3ml0XeWUOYXru28RHPTbzNUoYaMJ/m2Cc3ZE6reNJqMkPJQsjSIi6IYbrIuXINn6
         ele4FTY91UajRrQZiibjAbZO2Mk9u7dqQputJNJQ5on04R38IA/7+SYuXk+AtKJT06Fd
         y5CG2VRGPNnZAdvFJHd+SSccoXCvBFS3WfUeiwyi88/nyztIdQLFOSvHWZHYFj9U1U51
         qcn5S2uzBODoAIcewioFBBNRV8oGPoFLOYX0v2Kvq3OZtMlkJ8waSWx7AmZclLA089pw
         Yl/WVbs5dQdeJq5G+kobN2Q1hwEOUxNKhGyoHX5fIiaYHIjQI+B7aEi2qKk4V7AcOSlB
         ex3w==
X-Gm-Message-State: ANoB5pnPBP2RlTQgltKPZmZhLkLU/EcrpFHdsF4JjNi6m8MP1IbRS5ps
        OHFsCQWwyjW9LWetA6x16TscEg==
X-Google-Smtp-Source: AA0mqf6Nqh76P3kBEbww2Y/ua/aEATpdpVeecTVszv6MJgDlGyxFUp8IbNurRCCydoLFt0ZgRXvZ3g==
X-Received: by 2002:a05:6a00:1da0:b0:574:8995:c0d0 with SMTP id z32-20020a056a001da000b005748995c0d0mr612765pfw.1.1670864243780;
        Mon, 12 Dec 2022 08:57:23 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id 62-20020a621741000000b005763c22ea07sm6014467pfx.74.2022.12.12.08.57.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 12 Dec 2022 08:57:23 -0800 (PST)
Date:   Mon, 12 Dec 2022 16:57:19 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        kvm@vger.kernel.org
Subject: Re: [GIT PULL] First batch of KVM changes for Linux 6.2
Message-ID: <Y5ddb+tGS7phN1vc@google.com>
References: <20221212155027.2841892-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221212155027.2841892-1-pbonzini@redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Dec 12, 2022, Paolo Bonzini wrote:
> Linus,
> 
> The following changes since commit 8332f0ed4f187c7b700831bd7cc83ce180a944b9:
> 
>   KVM: Update gfn_to_pfn_cache khva when it moves within the same page (2022-11-23 18:58:46 -0500)
> 
> are available in the Git repository at:
> 
>   https://git.kernel.org/pub/scm/virt/kvm/kvm.git tags/for-linus
> 
> for you to fetch changes up to 1396763d469a83c5d791fa84df7dd17eba83dcf2:
> 
>   Merge remote-tracking branch 'kvm/queue' into HEAD (2022-12-09 09:15:09 +0100)

...

>       KVM: x86: remove unnecessary exports

...

>       KVM: nVMX: hyper-v: Enable L2 TLB flush

As reported a few times[1][2], these two collided and cause a build failure when
building with CONFIG_KVM_AMD=m.

  ERROR: modpost: "kvm_hv_assist_page_enabled" [arch/x86/kvm/kvm-amd.ko] undefined!
  make[2]: *** [scripts/Makefile.modpost:126: Module.symvers] Error 1
  make[1]: *** [Makefile:1944: modpost] Error 2

The fix is simple enough, maybe just squash it into the merge?

---
 arch/x86/kvm/hyperv.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/x86/kvm/hyperv.c b/arch/x86/kvm/hyperv.c
index cc3e8c7d0850..2c7f2a26421e 100644
--- a/arch/x86/kvm/hyperv.c
+++ b/arch/x86/kvm/hyperv.c
@@ -898,6 +898,7 @@ bool kvm_hv_assist_page_enabled(struct kvm_vcpu *vcpu)
 		return false;
 	return vcpu->arch.pv_eoi.msr_val & KVM_MSR_ENABLED;
 }
+EXPORT_SYMBOL_GPL(kvm_hv_assist_page_enabled);
 
 int kvm_hv_get_assist_page(struct kvm_vcpu *vcpu)
 {

base-commit: 9d75a3251adfbcf444681474511b58042a364863
-- 

[1] https://lore.kernel.org/all/05188606-395e-acd0-b821-2526d5808aca@gmail.com
[2] https://lore.kernel.org/all/CAPm50aKbzsMtgb3Cfux2nXOrOcHRZ5MP0ndKg9T0OQCqOsCa_w@mail.gmail.com
