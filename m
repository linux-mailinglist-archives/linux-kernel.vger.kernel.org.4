Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D659717200
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 01:51:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233865AbjE3Xvb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 19:51:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230151AbjE3Xv3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 19:51:29 -0400
Received: from mail-pg1-x549.google.com (mail-pg1-x549.google.com [IPv6:2607:f8b0:4864:20::549])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2165BD9
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:51:28 -0700 (PDT)
Received: by mail-pg1-x549.google.com with SMTP id 41be03b00d2f7-53f460cd829so2574745a12.1
        for <linux-kernel@vger.kernel.org>; Tue, 30 May 2023 16:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1685490687; x=1688082687;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=f3m0pzAsvXlgYHnj6/riFASoiQUxSwf8zHCe8kONnPE=;
        b=i+t8wS8Zzdk/DDGndM0RV6oXvH0DUsW3BQBz0afAbvrvBCZRTnw0QExXM0xewsE4Sc
         Ub7UYGm7yx5RGzcdxOz36sYqrc1R89xtuNCxJJ9FUHyQOurRENSZ6cnga14WQ7Py6VS+
         q5asCqVGEg2CYHANzOFLiOqmNZXP10Wk973Cj0P3XMBDGQq+VIWXKD2qFUtbFHa0E7hJ
         E8xWEHT3UFNEzms/L+4xnlIUixZTFEwsIvf9lJcYNDWnUhIlC/YjnKHTA5DwO8DGzenk
         xZQyA1yKnYAd6bvfA0h8qYxq8iIJ9DzA7pAl/zWAjJovHHO/VfnOiOT0/uuqpvJNMFPh
         yZtg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685490687; x=1688082687;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=f3m0pzAsvXlgYHnj6/riFASoiQUxSwf8zHCe8kONnPE=;
        b=QDlZ7oWXZnfsvaoFWdda7RM97BmiHGETHNET2C1Btm/oC3oVDydZVUPwMcu3z5kCzX
         Qj0av91ZjAXtiP62FTX7DtxPs3TePgT0j+lZ8fBxpA4btcfwBNlrI3DqIcJfYvQHm3Nf
         0ZiyEEcgDboaVNVou4D5XGvmvsfAaLkLpYMOD12FRWdX2txxAFpdafu9TwGWOMGRJlBE
         M8IqZx02OUU4Tvlu9Sagrrf9G9Lf+vsf7otgwdf7Xpk1FyV4ZecmfoTQ4pY7t14uoj/0
         AhfR46uHR+qmb/PvlhNndwDonxnQEt8Ltw4XP2MopSHIEBq9R6B0fbXTpkc3Y17kNKuv
         S8GQ==
X-Gm-Message-State: AC+VfDxsqkAas5PTXF+L/dsrsc8xfU3VbXuYxwlj4xnKFaHUa+mxszuk
        bl2VQ3Qx57/Crnqat7CbgEfZSosZRU8=
X-Google-Smtp-Source: ACHHUZ7xijeo/wqnhPQqi9KgehH2vePJBm6Ksfl+fq79Bxn7xeyKXRn2NH7jTpSS4/+cIogX4Wd1YLt6zWQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:5f16:0:b0:52c:8878:65dd with SMTP id
 t22-20020a635f16000000b0052c887865ddmr739097pgb.0.1685490687289; Tue, 30 May
 2023 16:51:27 -0700 (PDT)
Date:   Tue, 30 May 2023 16:51:25 -0700
In-Reply-To: <ZHXGWsw3ARk2OOjX@yzhao56-desk.sh.intel.com>
Mime-Version: 1.0
References: <20230509134825.1523-1-yan.y.zhao@intel.com> <20230509135006.1604-1-yan.y.zhao@intel.com>
 <ZFsr9TynkA/CyPgg@chao-email> <ZFtQeLNuXP6tDMne@yzhao56-desk.sh.intel.com>
 <ZG1DhSdhpTkxrfCq@google.com> <ZG10zi6YtqGeik7u@yzhao56-desk.sh.intel.com>
 <ZG4kMKXKnQuQOTa7@google.com> <ZG807ECX4TeBcE61@yzhao56-desk.sh.intel.com>
 <ZG+Epwp75nJ7tpXM@google.com> <ZHXGWsw3ARk2OOjX@yzhao56-desk.sh.intel.com>
Message-ID: <ZHaL/d0XhoCmoo3q@google.com>
Subject: Re: [PATCH v2 1/6] KVM: x86/mmu: add a new mmu zap helper to indicate
 memtype changes
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     Chao Gao <chao.gao@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, pbonzini@redhat.com
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 30, 2023, Yan Zhao wrote:
> On Thu, May 25, 2023 at 08:54:15AM -0700, Sean Christopherson wrote:
> And I combined the __kvm_mmu_honors_guest_mtrrs() into
> kvm_mmu_honors_guest_mtrrs(). Not sure if you like it :)

I would prefer to provide a separater inner helper, mainly so that the common
case callers don't need to pass %false.  I don't love passing bools, but it's
tolerable for a one-off use of an inner helper.

> +/*
> + * Returns if KVM honors guest MTRRs
> + * @override_vm_has_noncoherent_dma: Allow caller to override non-coherent DMA
> + *                                   status returned from
> + *                                   kvm_arch_has_noncoherent_dma()
> + */
> +bool kvm_mmu_honors_guest_mtrrs(struct kvm *kvm,
> +                               bool override_vm_has_noncoherent_dma)
> +{
> +       bool noncoherent_dma = override_vm_has_noncoherent_dma ? true :
> +                              kvm_arch_has_noncoherent_dma(kvm);

The "override" name is confusing, e.g. it won't be clear when it's safe/correct
for a new caller to override kvm_arch_has_noncoherent_dma().  If we go with a
single helper, I could live with:

bool kvm_mmu_honors_guest_mtrrs(struct kvm *kvm, bool stopping_noncoherent_dma)
{
	bool noncoherent_dma = stopping_noncoherent_dma ||
			       kvm_arch_has_noncoherent_dma(kvm);

	...
}

but that makes it awkward to use common code for start+stop assignment, and as
above there are three "normal" callers that would have to pass magic %false
values regardless of the name.
