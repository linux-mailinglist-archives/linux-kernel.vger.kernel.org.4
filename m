Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EB9D60B1CD
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 18:37:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232231AbiJXQhr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 12:37:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44058 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234277AbiJXQhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 12:37:14 -0400
Received: from mail-pf1-x434.google.com (mail-pf1-x434.google.com [IPv6:2607:f8b0:4864:20::434])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 402F25A3CF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:25:03 -0700 (PDT)
Received: by mail-pf1-x434.google.com with SMTP id b185so3027482pfb.9
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 08:25:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=noL1xjB++BHKxIQ74zu34lPbtV2ZHlwYE3worwYqF+4=;
        b=rzZW0mUO4WL5U9ltiHrYyvTcHY/hw+drJJ8LrSrZ6ByIUFyHa9GQLcXl/QTDhYuWSL
         w93SyVrGiHuvD8PFOCFdO6rkvqciJEIzj01xWY+9ypIebIbGe0jCj8CGiGdE/MQRN3Og
         cH665WRC2sd3N0osVuuV+diqngRFNwv4YR6urTNA6sHNIW4Dcgv51Bojsf3I+zQJvy4z
         MU7mOcaqjwBgCOG9IUOXXtja0IITmnwr+e3jLKmBiJiWVONMziKqWVdAMOR+C1jG5GU/
         37G/9xwyYOAps1td0fhMdQnFn4AuG9cgwYqlE0lRAn+pC8caU1a07qiK05AlhUa5Ytxj
         1qGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=noL1xjB++BHKxIQ74zu34lPbtV2ZHlwYE3worwYqF+4=;
        b=RdR/+z8/ADqtESrZdtLQ4T+fBneF/PxMSC9NY13WQloAJKFo2tc7/MiXcSApYA66LQ
         F0fgxSJrp9G9hiuOl5mZAvtgvbAr0QfdsUhwgV7Zt+3CM9w1242ilq0vqDO+hfv72ca4
         cK4kloVBq6nBarJcolmr8SWER6QM9oldfZoN8x1/hCkad1OVIDoz8W8I+/xnGHYySD1n
         ny1o04fsBct0j6QZk59opJcER7qMmaSdF0he9Y1EhVcJuZp3Z1h3Hv5jU2Tkv7ihqZjC
         g2P0P+4q5q+IFCqse1mJe286PshZ7iqsZbQu4jN5Rq4hnLapw98QdktRCSuSW0lK6LyA
         rNqg==
X-Gm-Message-State: ACrzQf2K0ot6QqN3+tWali6NA1s7KbAF7ptS2ZiRzfNHEwBesr8IZuxl
        9fqqBGtQrDT3r8zoRYj2KXsqVQ==
X-Google-Smtp-Source: AMsMyM7QvPiBAd8HgKZr8YJGCQNkbnlyYYh2aIazRZqncMC+dmNf9NqNJ8v+MPVG3mPwkKzZ6+t3fg==
X-Received: by 2002:a63:1a46:0:b0:464:3966:54b9 with SMTP id a6-20020a631a46000000b00464396654b9mr29031315pgm.390.1666624970185;
        Mon, 24 Oct 2022 08:22:50 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id az1-20020a17090b028100b00212daa6f41dsm61327pjb.28.2022.10.24.08.22.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 24 Oct 2022 08:22:49 -0700 (PDT)
Date:   Mon, 24 Oct 2022 15:22:46 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Vitaly Kuznetsov <vkuznets@redhat.com>
Cc:     Vipin Sharma <vipinsh@google.com>, pbonzini@redhat.com,
        dmatlack@google.com, kvm@vger.kernel.org, shujunxue@google.com,
        terrytaehyun@google.com, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] Add Hyperv extended hypercall support in KVM
Message-ID: <Y1atxgq2SDkHbP9I@google.com>
References: <20221021185916.1494314-1-vipinsh@google.com>
 <Y1L9Z8RgIs8yrU6o@google.com>
 <CAHVum0eoA5j7EPmmuuUb2y7XOU1jRpFwJO90tc+QBy0JNUtBsQ@mail.gmail.com>
 <Y1MXgjtPT9U6Cukk@google.com>
 <87k04pbfqd.fsf@ovpn-193-3.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87k04pbfqd.fsf@ovpn-193-3.brq.redhat.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 24, 2022, Vitaly Kuznetsov wrote:
> While some 'extended' hypercalls may indeed need to be handled in KVM,
> there's no harm done in forwarding all unknown-to-KVM hypercalls to
> userspace. The only issue I envision is how would userspace discover
> which extended hypercalls are supported by KVM in case it (userspace) is
> responsible for handling HvExtCallQueryCapabilities call which returns
> the list of supported hypercalls. E.g. in case we decide to implement
> HvExtCallMemoryHeatHint in KVM, how are we going to communicate this to
> userspace?
> 
> Normally, VMM discovers the availability of Hyper-V features through
> KVM_GET_SUPPORTED_HV_CPUID but extended hypercalls are not listed in
> CPUID. This can be always be solved by adding new KVM CAPs of
> course. Alternatively, we can add a single
> "KVM_CAP_HYPERV_EXT_CALL_QUERY" which will just return the list of
> extended hypercalls supported by KVM (which Vipin's patch adds anyway to
> *set* the list instead).

AIUI, the TLFS uses a 64-bit mask to enumerate which extended hypercalls are
supported, so a single CAP should be a perfect fit.  And KVM can use the capability
to enumerate support for _and_ to allow userspace to enable in-kernel handling.  E.g.

check():
	case KVM_CAP_HYPERV_EXT_CALL:
		return KVM_SUPPORTED_HYPERV_EXT_CALL;


enable():

	case KVM_CAP_HYPERV_EXT_CALL:
		r = -EINVAL;
		if (mask & ~KVM_SUPPORTED_HYPERV_EXT_CALL)
			break;

		mutex_lock(&kvm->lock);
		if (!kvm->created_vcpus) {
			to_kvm_hv(kvm)->ext_call = cap->args[0];
			r = 0;
		}
		mutex_unlock(&kvm->lock);

kvm_hv_hypercall()


	case HV_EXT_CALL_QUERY_CAPABILITIES ... HV_EXT_CALL_MAX:
		if (unlikely(hc.fast)) {
			ret = HV_STATUS_INVALID_PARAMETER;
			break;
		}
		if (!(hc.code & to_kvm_hv(vcpu->kvm)->ext_call))
			goto hypercall_userspace_exit;

		ret = kvm_hv_ext_hypercall(...)
		break;


That maintains backwards compatibility with "exit on everything" as userspace
still needs to opt-in to having KVM handle specific hypercalls in-kernel, and it
provides the necessary knob for userspace to tell KVM which hypercalls should be
allowed, i.e. ensures KVM doesn't violate HV_EXT_CALL_QUERY_CAPABILITIES.
