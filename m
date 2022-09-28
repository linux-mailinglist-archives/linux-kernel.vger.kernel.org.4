Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE5F5EDF69
	for <lists+linux-kernel@lfdr.de>; Wed, 28 Sep 2022 16:59:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234587AbiI1O7z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 28 Sep 2022 10:59:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234624AbiI1O7g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 28 Sep 2022 10:59:36 -0400
Received: from mail-pf1-x42c.google.com (mail-pf1-x42c.google.com [IPv6:2607:f8b0:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD92D59
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:59:32 -0700 (PDT)
Received: by mail-pf1-x42c.google.com with SMTP id d10so11638795pfh.6
        for <linux-kernel@vger.kernel.org>; Wed, 28 Sep 2022 07:59:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date;
        bh=rtLpVJID2+QMTHldYgZDoIbF3zW1N73CgEFVwTvPcCs=;
        b=LHi9URl6GqTY8sEDx5mU0KKZZsVriSL9D4xyEm7wWoM+yK7tvmg60FgyONmKqfL+8n
         H1z4KwVQ6ar4X3VYGYKx7lTv+z80LCosLin2N+2UCYcCX7KG0xarhtDbyoRkafvHQ7h5
         KGtNJ5uLAUJy4/kQjJdtHTxW4LyGNzr4cZfO80S8miP2Vdks4Tfs8zKDjCsNyLsD5a0m
         WTr/h1KlRbVXMN4dl1Q1Xe9zHddkoByfy4+QXD8BYpeX28QXG+GISgTOg00FlIc9xTrK
         1GQ5uds5qj9VlBa7qOwBYFtxVsLqQ4oVbAPLA/xh4J4D5VEbEx7mpyd+Zw4IPqjWBr8l
         vRLg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date;
        bh=rtLpVJID2+QMTHldYgZDoIbF3zW1N73CgEFVwTvPcCs=;
        b=dsKOizGS3v5Z+NTGJJFP8FC+JKEs3aXHDoLvLExsNqZf9pMzBensELB8tPSLkLP/bC
         wqmmgLidtmV6M/lnk3YXxcdbDu46uvBLepclcfHMPjdJkRYEG4leSF89ByQmV++p7nlw
         Lmz4Cws+41xa0ZUQhSZ3hHMsoVjxzTVtmp+Oj1XBiBFAN2LRWt3vNuT8Y8jIUpbfWJgA
         gKrmAQO7ZZwSPrW9DLZiwU5uzzpnyybBAz7vFZ2lkbgJgM/Dg+hkQyRve9e4yO7GQQst
         zXr2e+0EyeMdIHoNfo9lNQ95e+Was8deT7ExT/q6ethCDo77CbBvV9A0OHIQXhKtSyFN
         d6eA==
X-Gm-Message-State: ACrzQf1DjjylGBudLZelzM0XPv4l2/Qbj907OG9rYjqe/LLpFltNQ4QV
        6KJ23afQGdl1wG40xSRwZVE5Og==
X-Google-Smtp-Source: AMsMyM60w+Z6xCb6FJ6jiHnoK9u/CHSH8fdFKaDnaE4hchvfaFiEy5VASsf/OulQui69Hhvss5zL1w==
X-Received: by 2002:a05:6a00:1309:b0:535:d421:1347 with SMTP id j9-20020a056a00130900b00535d4211347mr35612135pfu.5.1664377171820;
        Wed, 28 Sep 2022 07:59:31 -0700 (PDT)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id lt4-20020a17090b354400b00205e940614dsm1637493pjb.34.2022.09.28.07.59.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 28 Sep 2022 07:59:31 -0700 (PDT)
Date:   Wed, 28 Sep 2022 14:59:27 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Subject: Re: [PATCH] KVM: allow compiling out SMM support
Message-ID: <YzRhT6DzgDfGU7NC@google.com>
References: <20220927152241.194900-1-pbonzini@redhat.com>
 <YzM55hqavzENQq7I@google.com>
 <f708d769-5d93-351f-ea24-8fa7deb9f689@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <f708d769-5d93-351f-ea24-8fa7deb9f689@redhat.com>
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

On Wed, Sep 28, 2022, Paolo Bonzini wrote:
> On 9/27/22 19:59, Sean Christopherson wrote:
> > >  static int kvm_vcpu_ioctl_smi(struct kvm_vcpu *vcpu)
> > >  {
> > > -	kvm_make_request(KVM_REQ_SMI, vcpu);
> > > -
> > > +	if (IS_ENABLED(CONFIG_KVM_SMM))
> > > +		kvm_make_request(KVM_REQ_SMI, vcpu);
> > >  	return 0;
> > 
> > This should return -EINVAL, not 0.
> 
> I'm a bit wary of changing this in case userspace is relying on it not
> failing, because the paths that lead to the failing ioctl are most likely
> controlled by the guest.

But with CONFIG_KVM_SMM=n, KVM is now reporting that KVM_CAP_X86_SMM is unsupported,
so it's firmly a VMM bug if userspace is blindly firing KVM_SMI.  As long as the
Kconfig is on by default, I don't see any reason to fudge KVM's ABI to try to avoid
breaking buggy userspace.

  /* Available with KVM_CAP_X86_SMM */
  #define KVM_SMI                   _IO(KVMIO,   0xb7)
