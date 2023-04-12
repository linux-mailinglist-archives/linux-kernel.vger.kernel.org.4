Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C6CF6DF9CD
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 17:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230371AbjDLPXC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 11:23:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231229AbjDLPW7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 11:22:59 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BD1B83C5
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:22:37 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-54f8b46f399so29165827b3.10
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 08:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1681312955; x=1683904955;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ufi2GxBvuU5BOU0JYHGeP8t4XTiyrZw4k2f0d6jHTA=;
        b=W8kLu2J1WyTCtd+BauQeMmFDXe1ycpcrIvrydUk7vneBkes/R4YX/fsTfanyEKySpa
         Imh18T0HEnR2LLQRzEkJhMXWj5RKuniwKM3edIXBoFrFet9IzkBNoFn7CHPz5WlgN14g
         LFTRcvBYWJifziGHrYRUuYJ3niLLwLHiWoYEWj5PjLjR05/AoxVz3+EvRXJRaKvaIFuD
         yN+WwRcF0i31dIyRnIana+xft8f4Xw6S8VnVrQv2ltMfRrjbGMKa6/0pW/0EQH2HenRz
         5L+HKCHXKxYMXRRO75B0LWvsJIttJ9f+5/ZPT+RiX+fVkeHcvN4Pt/vCyV2CgKCwAAnL
         Kn/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681312955; x=1683904955;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5Ufi2GxBvuU5BOU0JYHGeP8t4XTiyrZw4k2f0d6jHTA=;
        b=YYxA1AQtzUohFWy5tNC7aLrFpYEVuMlB53M7XTAnNnf/oJ1RG2D2vFNZ8VqgRafZTU
         HQbwCgoMdBPIUNx5uIvNsfg02k8Mt19n4B3B9nYF6f4EXGlbeNJA1vFJ3vjHS51ohODb
         JmROcpUzMp73wU/CTEQNoPfCYNgVU/+z8E2aQrKq0ULPj2VTRTxZFsB0rVUEMlMlux6a
         XHtuLGJu6CBDcM+QpCRziW219fNV6E9Lx43a9xBEYjODR9FuyMYKforSKXvIg5B2g/Ma
         buMJWGW4yeaWrGKp7QRqAUlNU8+uCLAoayALls8uJZsSoldNj/nJXdkORC751UHgMhAs
         MNDg==
X-Gm-Message-State: AAQBX9e+JOXmgakVlw6XWqcMgGRSqq3fd+u9rC/G3kiRIUKtPu1KFXYf
        LfGZWvRoOCMKNFxcH0ZmHwfDbkRRc1s=
X-Google-Smtp-Source: AKy350YVQX90EgvK7CMACVl1el4F03lr6ECkMh/lM4G+iDpfS7iwEu9sffrm9XcRU9iFk2pSjBdteumX2vA=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:4001:0:b0:549:1e80:41f9 with SMTP id
 l1-20020a814001000000b005491e8041f9mr1440306ywn.10.1681312955215; Wed, 12 Apr
 2023 08:22:35 -0700 (PDT)
Date:   Wed, 12 Apr 2023 08:22:33 -0700
In-Reply-To: <e1e7a37a29c2c7ad22cd14181f24b06088eca451.camel@intel.com>
Mime-Version: 1.0
References: <20230405005911.423699-1-seanjc@google.com> <d0af618169ebc17722e7019ca620ec22ee0b49c3.camel@intel.com>
 <ZC4qF90l77m3X1Ir@google.com> <20230406130119.000011fe.zhi.wang.linux@gmail.com>
 <e1e7a37a29c2c7ad22cd14181f24b06088eca451.camel@intel.com>
Message-ID: <ZDbMuZKhAUbrkrc7@google.com>
Subject: Re: [PATCH 0/3] KVM: x86: SGX vs. XCR0 cleanups
From:   Sean Christopherson <seanjc@google.com>
To:     Kai Huang <kai.huang@intel.com>
Cc:     "zhi.wang.linux@gmail.com" <zhi.wang.linux@gmail.com>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 12, 2023, Kai Huang wrote:
> On Thu, 2023-04-06 at 13:01 +0300, Zhi Wang wrote:
> > On Wed, 5 Apr 2023 19:10:40 -0700
> > Sean Christopherson <seanjc@google.com> wrote:
> > > TL;DR: trying to enforce "sane" CPUID/feature configuration is a gigantic can of worms.
> > 
> > Interesting point. I was digging the CPUID virtualization OF TDX/SNP.
> > It would be nice to have a conclusion of what is "sane" and what is the
> > proper role for KVM, as firmware/TDX module is going to validate the "sane"
> > CPUID.
> > 
> > TDX/SNP requires the CPUID to be pre-configured and validated before creating
> > a CC guest. (It is done via TDH.MNG.INIT in TDX and inserting a CPUID page in
> > SNP_LAUNCH_UPDATE in SNP).
> > 
> > IIUC according to what you mentioned, KVM should be treated like "CPUID box"
> > for QEMU and the checks in KVM is only to ensure the requirements of a chosen
> > one is literally possible and correct. KVM should not care if the
> > combination, the usage of the chosen ones is insane or not, which gives
> > QEMU flexibility.
> > 
> > As the valid CPUIDs have been decided when creating a CC guest, what should be
> > the proper behavior (basically any new checks?) of KVM for the later
> > SET_CPUID2? My gut feeling is KVM should know the "CPUID box" is reduced
> > at least, because some KVM code paths rely on guest CPUID configuration.
> 
> For TDX guest my preference is KVM to save all CPUID entries in TDH.MNG.INIT and
> manually make vcpu's CPUID point to the saved CPUIDs.  And then KVM just ignore
> the SET_CPUID2 for TDX guest.

It's been a long while since I looked at TDX's CPUID management, but IIRC ignoring
SET_CPUID2 is not an option becuase the TDH.MNG.INIT only allows leafs that are
known to the TDX Module, e.g. KVM's paravirt CPUID leafs can't be communicated via
TDH.MNG.INIT.  KVM's uAPI for initiating TDH.MNG.INIT could obviously filter out
unsupported leafs, but doing so would lead to potential ABI breaks, e.g. if a leaf
that KVM filters out becomes known to the TDX Module, then upgrading the TDX Module
could result in previously allowed input becoming invalid.

Even if that weren't the case, ignoring KVM_SET_CPUID{2} would be a bad option
becuase it doesn't allow KVM to open behavior in the future, i.e. ignoring the
leaf would effectively make _everything_ valid input.  If KVM were to rely solely
on TDH.MNG.INIT, then KVM would want to completely disallow KVM_SET_CPUID{2}.

Back to Zhi's question, the best thing to do for TDX and SNP is likely to require
that overlap between KVM_SET_CPUID{2} and the "trusted" CPUID be consistent.  The
key difference is that KVM would be enforcing consistency, not sanity.  I.e. KVM
isn't making arbitrary decisions on what is/isn't sane, KVM is simply requiring
that userspace provide a CPUID model that's consistent with what userspace provided
earlier.
