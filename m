Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFBE95BB4F8
	for <lists+linux-kernel@lfdr.de>; Sat, 17 Sep 2022 02:25:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229505AbiIQAZo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Sep 2022 20:25:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229487AbiIQAZb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Sep 2022 20:25:31 -0400
Received: from mail-pg1-x52d.google.com (mail-pg1-x52d.google.com [IPv6:2607:f8b0:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE04A8971
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 17:25:30 -0700 (PDT)
Received: by mail-pg1-x52d.google.com with SMTP id h188so21757860pgc.12
        for <linux-kernel@vger.kernel.org>; Fri, 16 Sep 2022 17:25:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=lOQrTxUJm567glNqAFTRqQtEy/E3imFjc2nOGw55170=;
        b=SF+Zl7Pa8nRhFiriwc4wIzb0VcUTTjyh5OID729CqM/dHQs+bQbzhukAN2MiIyNWth
         3Tsj4CVSGyTpIUxKMyUJZftQVNurQOhgV5dMJWhjot6vF6DeVTrWUh3Tyt7DGTKE0WHO
         PBvUZekVIIelJR0+2FNry8iQBy49uqe60f25ragByeT/YwOWcnaPjiQSgcHx7bUNuPvq
         T2r8qaUKQdbbhvfhxA6+9sD3Krm/fcfRDM7OUCJIII9xQumlOJp1RJyt95tKTUpNfJw5
         9/tFzz9yPaRsW1WOYk2Cay4IrGY7zZQYTLdRmVDdmjnAgkSwAnvR93aDZRqqdGZiAt7s
         Y70A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=lOQrTxUJm567glNqAFTRqQtEy/E3imFjc2nOGw55170=;
        b=Uq60kL3PPJh4NmNdNwx6vhGEc+YRCSkfrGvoHNNmaqc9POM0jB78I/DsJD/IbCoZdb
         e7RT89kYffMd2EYrbre6ZEhiLd/0mB6KCulaRthQzrVZlwFrz8b0TwIfl2w8JJ96TdkD
         MomaCtKJMUecfVE6TDzKlk7RV+QoYOtvBEh+0i9EBfADQVxWSYKJKjl8AzGRcT06pW2X
         oCDEUaKeZ/Hm9q9tdo7TvM4iYNkq5sf8JyTVHJfLmvlXjpi37D3cEO6eit5bCiC/uCIG
         3GRTUPNaoDS46Pp/Afgi09ogAW0hwp3cnPjgUc3MknKx4C7V6wW/gJHiSD603IuUSlCN
         5b8A==
X-Gm-Message-State: ACrzQf1ZSOXMrLVF/8fnxWDvuPg4fhhFe0kR9pkWkU4cZ/ZCsBdgqjQ9
        iv5OiBW7MEe1kExfuqv84nnSlHehD1rolg==
X-Google-Smtp-Source: AMsMyM6vXPW7iIcNRztvUQH3bZ1oS9Epfo2bsKO8twLXhNtmfPfvVLzQa0EhOo9mvl0g0T41mFaZWQ==
X-Received: by 2002:a05:6a00:1484:b0:547:89e:272c with SMTP id v4-20020a056a00148400b00547089e272cmr7491601pfu.0.1663374329907;
        Fri, 16 Sep 2022 17:25:29 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id b2-20020a170902d50200b0017315b11bb8sm15672322plg.213.2022.09.16.17.25.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 16 Sep 2022 17:25:29 -0700 (PDT)
Date:   Sat, 17 Sep 2022 00:25:25 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     "Chang S. Bae" <chang.seok.bae@intel.com>
Cc:     linux-kernel@vger.kernel.org, x86@kernel.org, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, dave.hansen@linux.intel.com,
        hpa@zytor.com, avagin@gmail.com, kvm@vger.kernel.org
Subject: Re: [PATCH 3/4] x86/fpu: Clarify the XSTATE clearing only for
 extended components
Message-ID: <YyUT9VlEuXWMfsrP@google.com>
References: <20220916201158.8072-1-chang.seok.bae@intel.com>
 <20220916201158.8072-4-chang.seok.bae@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220916201158.8072-4-chang.seok.bae@intel.com>
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

On Fri, Sep 16, 2022, Chang S. Bae wrote:
> Commit 087df48c298c ("x86/fpu: Replace KVMs xstate component clearing")
> refactored the MPX state clearing code.
> 
> But, legacy states are not warranted in this routine.

Why not?  I could probably figure it out eventually, but that info should be
provided in the changelog.

> Rename the function to clarify that only extended components are acceptable.

The function rename isn't the interesting part of the patch, explicitly disallowing
"legacy" states is what's interesting.  The shortlog+changelog should reflect that.

> Signed-off-by: Chang S. Bae <chang.seok.bae@intel.com>
> Cc: x86@kernel.org
> Cc: kvm@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> ---
>  arch/x86/include/asm/fpu/api.h | 2 +-
>  arch/x86/kernel/fpu/xstate.c   | 7 +++++--
>  arch/x86/kvm/x86.c             | 4 ++--
>  3 files changed, 8 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/include/asm/fpu/api.h b/arch/x86/include/asm/fpu/api.h
> index 503a577814b2..c9d5dc85ca06 100644
> --- a/arch/x86/include/asm/fpu/api.h
> +++ b/arch/x86/include/asm/fpu/api.h
> @@ -130,7 +130,7 @@ static inline void fpstate_free(struct fpu *fpu) { }
>  #endif
>  
>  /* fpstate-related functions which are exported to KVM */
> -extern void fpstate_clear_xstate_component(struct fpstate *fps, unsigned int xfeature);
> +extern void fpstate_clear_extended_xstate(struct fpstate *fps, unsigned int xfeature);
>  
>  extern u64 xstate_get_guest_group_perm(void);
>  
> diff --git a/arch/x86/kernel/fpu/xstate.c b/arch/x86/kernel/fpu/xstate.c
> index d7676cfc32eb..a35f91360e3f 100644
> --- a/arch/x86/kernel/fpu/xstate.c
> +++ b/arch/x86/kernel/fpu/xstate.c
> @@ -1371,14 +1371,17 @@ void xrstors(struct xregs_state *xstate, u64 mask)
>  }
>  
>  #if IS_ENABLED(CONFIG_KVM)
> -void fpstate_clear_xstate_component(struct fpstate *fps, unsigned int xfeature)
> +void fpstate_clear_extended_xstate(struct fpstate *fps, unsigned int xfeature)
>  {
>  	void *addr = get_xsave_addr(&fps->regs.xsave, xfeature);
>  
> +	if (xfeature <= XFEATURE_SSE)

This should WARN_ON_ONCE(), silently doing nothing in the presence of buggy code
isn't much better than clobbering state.

> +		return;
> +
>  	if (addr)
>  		memset(addr, 0, xstate_sizes[xfeature]);
>  }
> -EXPORT_SYMBOL_GPL(fpstate_clear_xstate_component);
> +EXPORT_SYMBOL_GPL(fpstate_clear_extended_xstate);
>  #endif
>  
>  #ifdef CONFIG_X86_64
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 43a6a7efc6ec..82ab270ea734 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -11760,8 +11760,8 @@ void kvm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
>  		if (init_event)
>  			kvm_put_guest_fpu(vcpu);
>  
> -		fpstate_clear_xstate_component(fpstate, XFEATURE_BNDREGS);
> -		fpstate_clear_xstate_component(fpstate, XFEATURE_BNDCSR);
> +		fpstate_clear_extended_xstate(fpstate, XFEATURE_BNDREGS);
> +		fpstate_clear_extended_xstate(fpstate, XFEATURE_BNDCSR);

From a KVM perspective, I strongly prefer the existing name.  The "component"
part makes it very clear that the helper clears a single component, whereas it's
not obvious at first glances that the version without "component" only affects
the specified feature.

The obvious alternative is something like fpstate_clear_extended_xstate_component(),
but I don't really see the point.  "xstate" is "extended state" after all, which
is partly why I find fpstate_clear_extended_xstate() confusing; it makes me think
the helper is for some fancy "extended extended state".
