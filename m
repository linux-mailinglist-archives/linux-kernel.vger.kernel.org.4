Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33146DAFD3
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Apr 2023 17:44:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231289AbjDGPoD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Apr 2023 11:44:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51010 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231422AbjDGPoC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Apr 2023 11:44:02 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBADB6A74
        for <linux-kernel@vger.kernel.org>; Fri,  7 Apr 2023 08:44:00 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id g5-20020a25a485000000b009419f64f6afso42277174ybi.2
        for <linux-kernel@vger.kernel.org>; Fri, 07 Apr 2023 08:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1680882240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=QrSg/BMPAE5SgDyFLe+GJWATUYwVq9m/07ZFQV/pgIM=;
        b=j/46f7Pl8wPRiRdY9mZIKmKorvJRsWxM2uow0fs/iOJN7PnoWGLpQN1kTuWYrIX9nE
         CQJ9n6Hl3gtws74pFy0LGjxZyHFHAear1v0aBJThlXJTFVKzX9/m2WIOZ+1Ou0ljlTzS
         pKvjgT0AmesclVv1iijOl/fXBribr9mWtlv1KpKiMEX+fFpverhnC183z0uDVGkhbsmI
         Tq/knJ93xsBS50femZFIMUEOHWbB6geNc8m+nbii/D0h7HAvvjOxi35TheB/XuBoOEzn
         mC63zcBQOlMSa5c88tFwU4uf/FTU+soUp6tgrPagh9LsOsXC95c+lT0rRl0SBZxJr3uc
         xHWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680882240;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=QrSg/BMPAE5SgDyFLe+GJWATUYwVq9m/07ZFQV/pgIM=;
        b=d5rh0xB3x5D37qztnSj4azKBBh9X7MMYMlLdHaVN6KbzuHR6k4C6CsCTZZDg8iK8mQ
         123FoxOZZ7rG7l5LYTggnqVpO15H9rLbMPJKOr9CqY0of8AuslE8hH3FC49Oy4ng3ro8
         KyHFX7hL6Dh76ZB4WCjV9feMi2NArYDgI/ETSRq66IV/GjfiReZ1hLZB0YtXWxkBkZTs
         gaQatZPLESSUGXvtiUJi4UQVGyGZoQ9QDb4Q1iFT+D/MTpRzBn1ghDh/QkZl6nDbXKaf
         V8LQ+Q/tzdwrDWqmU64MTweLRVw+Zp0fTroTTrXH2UfeKSlEiql+Q3/uMNxqxSfiaADU
         fYRQ==
X-Gm-Message-State: AAQBX9c7nM1zflFlB1zkZFSaPIjq/BxKcPk4Bw8kT9SYpKTloRzlresP
        2SIZ/dd2BJ3HI5DkAJjRlw0AvZpngsE=
X-Google-Smtp-Source: AKy350bCLbRNGmyqxLryHU0Q5arxfdImdLoRNJrYAw+YMmFrtssq2sKnFPiTtLp4/SYbtscSIBmxG26bnno=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:ad09:0:b0:544:8ac7:2608 with SMTP id
 l9-20020a81ad09000000b005448ac72608mr1293296ywh.6.1680882240229; Fri, 07 Apr
 2023 08:44:00 -0700 (PDT)
Date:   Fri, 7 Apr 2023 08:43:58 -0700
In-Reply-To: <37a18b89-c0c3-4c88-7f07-072573ac0c92@gmail.com>
Mime-Version: 1.0
References: <20230214050757.9623-1-likexu@tencent.com> <20230214050757.9623-6-likexu@tencent.com>
 <ZC9Zqn/+J5vaXKfo@google.com> <37a18b89-c0c3-4c88-7f07-072573ac0c92@gmail.com>
Message-ID: <ZDA6PrzUR2rsrCQI@google.com>
Subject: Re: [PATCH v4 05/12] KVM: x86/pmu: Error when user sets the
 GLOBAL_STATUS reserved bits
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-7.7 required=5.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 07, 2023, Like Xu wrote:
> On 7/4/2023 7:45 am, Sean Christopherson wrote:
> > On Tue, Feb 14, 2023, Like Xu wrote:
> > > From: Like Xu <likexu@tencent.com>
> > > 
> > > If the user space sets reserved bits when restoring the MSR_CORE_
> > > PERF_GLOBAL_STATUS register, these bits will be accidentally returned
> > > when the guest runs a read access to this register, and cannot be cleared
> > > up inside the guest, which makes the guest's PMI handler very confused.
> > 
> > The changelog needs to state what the patch actually does.
> > 
> > > Signed-off-by: Like Xu <likexu@tencent.com>
> > > ---
> > >   arch/x86/kvm/vmx/pmu_intel.c | 2 +-
> > >   1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/arch/x86/kvm/vmx/pmu_intel.c b/arch/x86/kvm/vmx/pmu_intel.c
> > > index 904f832fc55d..aaea25d2cae8 100644
> > > --- a/arch/x86/kvm/vmx/pmu_intel.c
> > > +++ b/arch/x86/kvm/vmx/pmu_intel.c
> > > @@ -397,7 +397,7 @@ static int intel_pmu_set_msr(struct kvm_vcpu *vcpu, struct msr_data *msr_info)
> > >   			reprogram_fixed_counters(pmu, data);
> > >   		break;
> > >   	case MSR_CORE_PERF_GLOBAL_STATUS:
> > > -		if (!msr_info->host_initiated)
> > > +		if (!msr_info->host_initiated || (data & pmu->global_ovf_ctrl_mask))
> > 
> > This is wrong.  Bits 60:58 are reserved in IA32_PERF_GLOBAL_OVF_CTRL, but are
> > ASCI, CTR_FREEZE, and LBR_FREEZE respectively in MSR_CORE_PERF_GLOBAL_STATUS.
> 
> CTR_FREEZE and LBR_FREEZE are only required for the guest CPUID.0AH: EAX[7:0]>3.
> PMU support (ASCI bit) for guest SGX isn't supported either.
> 
> So for now, reusing pmu->global_ovf_ctrl_mask here is effective enough.

And "good enough for now" is exactly how we end up with bugs, especially when
"good enough" relies on assumptions that aren't well documented.
