Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 26CF673FF46
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:07:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229790AbjF0PHM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:07:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230423AbjF0PHK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:07:10 -0400
Received: from mail-pf1-x44a.google.com (mail-pf1-x44a.google.com [IPv6:2607:f8b0:4864:20::44a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FA6010CC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:07:09 -0700 (PDT)
Received: by mail-pf1-x44a.google.com with SMTP id d2e1a72fcca58-666ecb21fb8so3838641b3a.1
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:07:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1687878428; x=1690470428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=+4NeRXczD7gGlQyEmL4cAL0joikv2lUIDN2yHcDJeA8=;
        b=VObHiFCGmoYjzOAcDlZZrTzBtB5q+60Uun/FvVcrztnM+UX9dTyr62+hgbDKh/SNWF
         Jn9yfc3kCD7WjJx4QzbK2cEmvOia172MBkFDseQmEWoZykLY/AYdCqrjqiO+px1me7UZ
         PLvwrPf+3yuRw31wVi5e4LzyLE074st3ppuknQLd055glGDa/za5S/iib7lfQgmjwWTY
         mLDVHXKMEVBS51wHxSSzd9nUYJi0Gin2e2ewjLoTwMoO3Yp0CTc6SKtyAkSLqcXkKWqF
         QfuRxqyPVt4CNPjYAUx15M1gOqx2GNt2nt/sbUPalRY+1m6qZqdVT50OkRJWQFw4b81R
         26/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687878428; x=1690470428;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=+4NeRXczD7gGlQyEmL4cAL0joikv2lUIDN2yHcDJeA8=;
        b=ZodOZ/ZK/EvJUKuT61cfcZlLc7YtixJcsZZ1ukeO5bcgXcg9XsxW5YIpuXi4q8Od04
         IXJlaY4uCFNvXxWwy6cQdkVBmTUCJDRpNy3jot8/N4bV0cmLkOjuvPKQOdt5tX/NJsQw
         NHrXkjOI+BVntdYGvooYlx0gtekV4cmDcQe500rsCmBOSXNWgoHvH9aCPETgufXyk9/W
         limGmveiLiDt0Cn9qaARMN2oeVyuFg2z2VdcIzjP3o2n5YN+3dFIvIapn/39ZemnRWYf
         JIAcr+McAyS+BQdZm7tYdrCXmOC+1vWeBETLZYvBJbt3M9yfetMHjX2bxbz2FtApLc4s
         jddA==
X-Gm-Message-State: AC+VfDx7Oryt/RRZTIX9Vhc+VvPsCjSUo7G6nF1/z1ebMiYYxLKZLLOJ
        Qhw3kff+udOCgafE7ZfWRQo14FyxW1w=
X-Google-Smtp-Source: ACHHUZ47B6cZdW7yZxMDDmNpKPEXGCLMm9LmiUYWeZnxI8BDzBZCIUXgAG6E4W8ek+pUhab/t1JIxb8wiI0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:248c:b0:66e:4df5:6c15 with SMTP id
 c12-20020a056a00248c00b0066e4df56c15mr2380674pfv.4.1687878428601; Tue, 27 Jun
 2023 08:07:08 -0700 (PDT)
Date:   Tue, 27 Jun 2023 08:07:07 -0700
In-Reply-To: <MW4PR11MB5824B76276020C1A33A26A72BB27A@MW4PR11MB5824.namprd11.prod.outlook.com>
Mime-Version: 1.0
References: <20230616113353.45202-1-xiong.y.zhang@intel.com>
 <20230616113353.45202-4-xiong.y.zhang@intel.com> <ZJYCtDN+ITmrgCUs@google.com>
 <MW4PR11MB5824653862500CB4F9EE4519BB21A@MW4PR11MB5824.namprd11.prod.outlook.com>
 <ZJnEFTXMpQkXdHRj@google.com> <MW4PR11MB5824B76276020C1A33A26A72BB27A@MW4PR11MB5824.namprd11.prod.outlook.com>
Message-ID: <ZJr7GtTFg2uzck1c@google.com>
Subject: Re: [PATCH 3/4] KVM: VMX/pmu: Enable inactive vLBR event in guest LBR
 MSR emulation
From:   Sean Christopherson <seanjc@google.com>
To:     Xiong Y Zhang <xiong.y.zhang@intel.com>
Cc:     "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pbonzini@redhat.com" <pbonzini@redhat.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "like.xu.linux@gmail.com" <like.xu.linux@gmail.com>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "zhenyuw@linux.intel.com" <zhenyuw@linux.intel.com>,
        Zhiyuan Lv <zhiyuan.lv@intel.com>,
        Weijiang Yang <weijiang.yang@intel.com>
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 27, 2023, Xiong Y Zhang wrote:
> > On Sun, Jun 25, 2023, Xiong Y Zhang wrote:
> > > > > On Fri, Jun 16, 2023, Xiong Zhang wrote:
> > > > 	/*
> > > > 	 * Attempt to re-enable the vLBR event if it was disabled due to
> > > > 	 * contention with host LBR usage, i.e. was put into an error state.
> > > > 	 * Perf doesn't notify KVM if the host stops using LBRs, i.e. KVM needs
> > > > 	 * to manually re-enable the event.
> > > > 	 */
> > > >
> > > > Which begs the question, why can't there be a notification of some
> > > > form that the LBRs are once again available?
> > > This is perf scheduler rule. If pinned event couldn't get resource as
> > > resource limitation, perf will put it into error state and exclude it
> > > from perf scheduler, even if resource available later, perf won't
> > > schedule it again as it is in error state, the only way to reschedule
> > > it is to enable it again.  If non-pinned event couldn't get resource
> > > as resource limitation, perf will put it into inactive state, perf
> > > will reschedule it automatically once resource is available.  vLBR event is per
> > process pinned event.
> > 
> > That doesn't answer my question.  I get that all of this is subject to perf
> > scheduling, I'm asking why perf doesn't communicate directly with KVM to
> > coordinate access to LBRs instead of pulling the rug out from under KVM.
> Perf doesn't need such notification interface currently, as non-pinned event
> will be active automatically once resource available, only pinned event is
> still in inactive even if resource available, perf may refuse to add such
> interface for KVM usage only.

Or maybe perf will be overjoyed that someone is finally proposing a coherent
interface.  Until we actually try/ask, we'll never know.

> > Your other response[1] mostly answered that question, but I want explicit
> > documentation on the contract between perf and KVM with respect to LBRs.  In
> > short, please work with Weijiang to fulfill my request/demand[*] that someone
> > document KVM's LBR support, and justify the "design".  I am simply not willing to
> > take KVM LBR patches until that documentation is provided.
> Sure, I will work with Weijiang to supply such documentation. Will this
> document be put in Documentation/virt/kvm/x86/ ?

Ya, Documentation/virt/kvm/x86/pmu.rst please.
