Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 219A568C947
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Feb 2023 23:22:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229952AbjBFWWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Feb 2023 17:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229918AbjBFWWL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Feb 2023 17:22:11 -0500
Received: from mail-pj1-x102f.google.com (mail-pj1-x102f.google.com [IPv6:2607:f8b0:4864:20::102f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E6A620070
        for <linux-kernel@vger.kernel.org>; Mon,  6 Feb 2023 14:22:11 -0800 (PST)
Received: by mail-pj1-x102f.google.com with SMTP id bg10-20020a17090b0d8a00b00230c7f312d4so3501332pjb.3
        for <linux-kernel@vger.kernel.org>; Mon, 06 Feb 2023 14:22:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=fR53LRdpHsa0OS9J6+InsxvDOeoDJTyfsS7w/2+Vo04=;
        b=dIjvomFzCfTfCALm7zrLSGf4knhPf89tKVnyWlfz5L3vtfpf6U5IFCWI2b5nrZaWvu
         KFtwXa0uqN/oF0SdNpOoX9Ko6CoDnDNQGQlNfM19iNnrnlUqpWs3UGFMxLUmeyfygZK7
         JkdCDSYSpiLMV/Z5DvCAw6N/G2TnXQQmNcdcBoSUfhj27AkkpizRmQIVPXNNPJnvvlVT
         em+4I2qmlT16h2phPtUo+9rESvb7seLGFh5Jib+T1wKemddinQnqx0GwP2//fWkkCPv3
         J7XTYNZHi/hPwyFBl4w2BCUj6QjiH40SUuh76u1FakrsMguz+5Ox8f9YNhy1nT+nuN41
         DiGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=fR53LRdpHsa0OS9J6+InsxvDOeoDJTyfsS7w/2+Vo04=;
        b=Hg4bokGQ6VVlClvLU5oHSnf2OqtF4NrtawgoZhz+mi8vKsiPH3R/K7/iDcoMJUXA3f
         jFY84Z3tH+gF5tA6iv3tqPhyzOpNnTukRtG5FKYCB840DznyN22ZrYGHHorjFbho2xPo
         QLegmgz2D4ovF0sRRaNuG5kQgbCVZZlIaSB0yKjpvlfszb1yPk7PiyEDh0nHNtsnAuRa
         MO+7gPrSnY3nXKoZfFF90rjzef2wpXYPy4kAg5CZBGtKOSFeASS8baK4wnLp3P4LIMFK
         FfLbo6ZYGimodH/xMveOqYwtG4HLDfUINhi84hwoP3HHpUFaWBYRsGfAFWIB9LSvbNqP
         6Bzw==
X-Gm-Message-State: AO0yUKUwgJgApTtkuYEQhkdjw/le0/ojawJNW7NO2bw0vtR2H8WoOe0v
        svvJAD3kGbVELqae6vg5+eEoxw==
X-Google-Smtp-Source: AK7set9evUF5Sl1+pVPcT5IkVnllcvIxGpantRKlTFe76Le6AJpwjflWdP2n5D2r1Do1jnO0+YzTvQ==
X-Received: by 2002:a17:902:c3cc:b0:189:6624:58c0 with SMTP id j12-20020a170902c3cc00b00189662458c0mr2429plj.3.1675722130467;
        Mon, 06 Feb 2023 14:22:10 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id g10-20020a1709026b4a00b001966eaf7365sm7425792plt.17.2023.02.06.14.22.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Feb 2023 14:22:10 -0800 (PST)
Date:   Mon, 6 Feb 2023 22:22:06 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Like Xu <like.xu.linux@gmail.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Sandipan Das <sandipan.das@amd.com>,
        Jim Mattson <jmattson@google.com>
Subject: Re: [PATCH v3 6/8] KVM: x86/svm/pmu: Add AMD PerfMonV2 support
Message-ID: <Y+F9jhfJtHEmVXyg@google.com>
References: <20221111102645.82001-1-likexu@tencent.com>
 <20221111102645.82001-7-likexu@tencent.com>
 <Y9BzYzEjAwUA+wuy@google.com>
 <c7e0a5b1-0fd0-e2b5-20ca-fc86a1d883db@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <c7e0a5b1-0fd0-e2b5-20ca-fc86a1d883db@gmail.com>
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

On Mon, Feb 06, 2023, Like Xu wrote:
> On 25/1/2023 8:10 am, Sean Christopherson wrote:
> > > +     }
> > > +
> > > +     /* Commitment to minimal PMCs, regardless of CPUID.80000022 */
> > 
> > Please expand this comment.  I'm still not entirely sure I've interpreted it correctly,
> > and I'm not sure that I agree with the code.
> 
> In the first version [1], I used almost the same if-elif-else sequence
> but the concerns from JimM[2] has changed my mind:
> 
> "Nonetheless, for compatibility with old software, Fn8000_0022_EBX can never
> report less than four counters (or six, if Fn8000_0001_ECX[PerfCtrExtCore] is set)."
> 
> Both in amd_pmu_refresh() and in __do_cpuid_func(), KVM implements
> this using the override approach of first applying the semantics of
> AMD_PMU_V2 and then implementing a minimum number of counters
> supported based on whether or not guest have  PERFCTR_CORE,
> the proposed if-elif-else does not fulfill this need.

Jim's comments were in the context of __do_cpuid_func(), i.e. KVM_GET_SUPPORTED_CPUID.
As far as guest CPUID is concerned, that's userspace's responsibility to get correct.

And for KVM_GET_SUPPORTED_CPUID, overriding kvm_pmu_cap.num_counters_gp is not
the correct approach.  KVM should sanity check the number of counters enumerated
by perf and explicitly disable vPMU support if the min isn't met.  E.g. if KVM
needs 6 counters and perf says there are 4, then something is wrong and enumerating
6 to the guest is only going to cause more problems.

> [1] 20220905123946.95223-4-likexu@tencent.com/
> [2] CALMp9eQObuiJGV=YrAU9Fw+KoXfJtZMJ-KUs-qCOVd+R9zGBpw@mail.gmail.com
