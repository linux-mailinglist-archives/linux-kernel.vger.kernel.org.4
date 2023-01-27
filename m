Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775FD67DC1B
	for <lists+linux-kernel@lfdr.de>; Fri, 27 Jan 2023 03:06:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233339AbjA0CGF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 21:06:05 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46304 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233190AbjA0CFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 21:05:43 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3574E4996F
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:03:15 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id o13so3259844pjg.2
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 18:03:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=QlnC2FACLz4TVazdbeeDFs7ZKh+4cFrx8LwVyzMk1F8=;
        b=loBlZtwcLsVlfXwQIERwIJ+CvIOKfjyag+u+fc7ru6Zxx3Fdk5sbWOUYc98VITpEgU
         dfk+Z+14ls4uR+LOpmvabY0SZH22k3D/rg95JtaWxgMKNFOodruDeiw+25R4/6tMVPb2
         gAyCAFCAmwQDN0X0tXZyaHBJnmehybBqSZgdYXH3QHlQ9gfCd+kXH0hNzkGkb8hl6Y1c
         Si2uIeSghkSBj6GSlBIHCwtA0ewSS2odWWIi0evy6WsoHJYjiFRV+bDZu2Hv/P7fsI6X
         xT1nm7jnQ9il8SLu9MU4qeRUAO85eAnTvJmiCpR1DATPSUgw5oLJjE6VWv8eG2U3Md7L
         6IiQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QlnC2FACLz4TVazdbeeDFs7ZKh+4cFrx8LwVyzMk1F8=;
        b=k/WGHa8JFkbCuG4oxT5CZur46jqfdHH0JCmq0cxOMzBnZ4DfbvQ8rVoyiTez7SqgsM
         5nk0Z60/zarjsjBZfom07jK6K/vLkDcFihwc6wgTE35+EYjYsMGh6XYOtl1tMYShVO51
         PN9nZdBtIEe3Ug4+HHvJP2KomVx4lr9OYY3F4kzpTz3cJO9hiNpMA2MZbpBSi+Yb+XWn
         qLLdmb9feWz19rjPXEXWPGHzjFoEzXqZ5CgDss4vq4VZf+eeIN8qoMLpJUxoAtaHoATI
         C+KMZulid01/lTZCfXZ0hGZDrWMsbAy4/JamsTSwjP7iLNrAP/xS3KbEgsatPx1sC27K
         mvpg==
X-Gm-Message-State: AO0yUKVCrKI4vejjDIDfJIBhyAekRtPAl+Ud+S+e3FnKoC6xS3+ExzNJ
        6RbyVsIMnnBoBZoTIQ77CC9rFA==
X-Google-Smtp-Source: AK7set/q3kh0Y5amuDKghvzE2jA+7uNs0NPpCTSEeqflEwH2JIUjGWc2BNZcQcGyU16D8fjoov2vnQ==
X-Received: by 2002:a17:902:c9d2:b0:189:6624:58c0 with SMTP id q18-20020a170902c9d200b00189662458c0mr1152283pld.3.1674784994516;
        Thu, 26 Jan 2023 18:03:14 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id u5-20020a170902e80500b00194974a2b3asm1619966plg.151.2023.01.26.18.03.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 26 Jan 2023 18:03:14 -0800 (PST)
Date:   Fri, 27 Jan 2023 02:03:10 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v3 1/8] KVM: x86/pmu: Rename pmc_is_enabled() to
 pmc_is_globally_enabled()
Message-ID: <Y9Mw3pcW/SL/Mna8@google.com>
References: <20221111102645.82001-1-likexu@tencent.com>
 <20221111102645.82001-2-likexu@tencent.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221111102645.82001-2-likexu@tencent.com>
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

On Fri, Nov 11, 2022, Like Xu wrote:
> From: Like Xu <likexu@tencent.com>
> 
> The name of function pmc_is_enabled() is a bit misleading. A PMC can
> be disabled either by PERF_CLOBAL_CTRL or by its corresponding EVTSEL.
> Add the global semantic to its name.
> 
> Suggested-by: Jim Mattson <jmattson@google.com>
> Signed-off-by: Like Xu <likexu@tencent.com>
> ---

...

> diff --git a/arch/x86/kvm/pmu.c b/arch/x86/kvm/pmu.c
> index 684393c22105..e57f707fb940 100644
> --- a/arch/x86/kvm/pmu.c
> +++ b/arch/x86/kvm/pmu.c
> @@ -83,7 +83,7 @@ void kvm_pmu_ops_update(const struct kvm_pmu_ops *pmu_ops)
>  #undef __KVM_X86_PMU_OP
>  }
>  
> -static inline bool pmc_is_enabled(struct kvm_pmc *pmc)
> +static inline bool pmc_is_globally_enabled(struct kvm_pmc *pmc)
>  {
>  	return static_call(kvm_x86_pmu_pmc_is_enabled)(pmc);

This doesn't compile.  v3, and I'm getting pings, and the very first patch doesn't
compile.
