Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6CBF16BBEEF
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 22:22:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232364AbjCOVWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 17:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232427AbjCOVWj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 17:22:39 -0400
Received: from mail-pg1-x54a.google.com (mail-pg1-x54a.google.com [IPv6:2607:f8b0:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28E332822F
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:22:13 -0700 (PDT)
Received: by mail-pg1-x54a.google.com with SMTP id 29-20020a63125d000000b005039a1e2a17so4692226pgs.8
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 14:22:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678915332;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=cp9nv06NbI2Fid5pTo27ILMQlxLOr6f3iei6ZMERVBQ=;
        b=YLuvA/Ub9RxxKRg2VgHMEkxqyyo+OmtNkQF2hN7rBdhs3+Kj9HvI7dOlK5teMFFzwl
         lo0EKACD4K6mhJy7HrC5ziiMCUUGMrvzQUn26JVDv06CLZunayA5clYjJ8dVKa6hVvjN
         cAUzhwHTyfJuipOeDtf2175wT201j73KcCTkBwZIqtFpmxMTCOMZ8L25xm329hFW1sSG
         hmLdFFY6tAipmU1cl1lakPNNd2EenM77tk3uBCN7LWBydKT63Ln2fZwueH2d4H+Webch
         YKWAFQmCJOCO+D0a/g9060DfiU+sutIjmj7bZsaTwHdiJnWaqugCGEHZrKforPGntIvj
         m1Ug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678915332;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=cp9nv06NbI2Fid5pTo27ILMQlxLOr6f3iei6ZMERVBQ=;
        b=Ew7bGOfDQ+tXs1nwW2cQG9m2v1PU0CmKHZTiD5/BPQCRyRdr3d4msvgpukaWlV6IJt
         RJ2pZ3/bumRsilD1Z3CwW54dgaYcXN0yQBJO5FaJrDJk2apn60SnE++Sl53Dy4IhQ2er
         0DYv3Q3BiCcuGNXRG2TReskKXK6FuzxJNc54eDf0/kNQQiLfj5vdZmu5+iRzL6eJEMqY
         HJIiYbswXQdYGbGoETnQohsAzb1MZIZ8NqT4PrAtXzMRIoAULlPpib/NrNDG5gfBXHwp
         5eQxLyBiqAMYcmBXfaNOajE4Nr2IxC2z8u8zy15cn6+20l+RnWbZXn0/W3rA8OQzscz+
         3uCA==
X-Gm-Message-State: AO0yUKX34hI/tD3coqes55JuIGttV+T2BUefKqTFdH5i4/9r9w2ufmqx
        ASmHnjsrFsL/LJZJ3NVHzwQktzVwFgs=
X-Google-Smtp-Source: AK7set83gkP0P/QVsDIrmCQGOtXC4fEk4g/g9teLQtAJIPCeJ6eVDSp3Urecr1YQl2dDf3D4x9ikn8Kh5dc=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:1752:b0:5eb:e0e0:d650 with SMTP id
 j18-20020a056a00175200b005ebe0e0d650mr387856pfc.6.1678915331799; Wed, 15 Mar
 2023 14:22:11 -0700 (PDT)
Date:   Wed, 15 Mar 2023 14:22:10 -0700
In-Reply-To: <0ac184a7-4325-a1f7-b533-41a7e590c66c@grsecurity.net>
Mime-Version: 1.0
References: <20230201194604.11135-1-minipli@grsecurity.net>
 <20230201194604.11135-4-minipli@grsecurity.net> <20230207153651.000067f8@gmail.com>
 <0ac184a7-4325-a1f7-b533-41a7e590c66c@grsecurity.net>
Message-ID: <ZBI3AtIvMXEK3Csc@google.com>
Subject: Re: [PATCH v3 3/6] KVM: x86: Do not unload MMU roots when only
 toggling CR0.WP
From:   Sean Christopherson <seanjc@google.com>
To:     Mathias Krause <minipli@grsecurity.net>
Cc:     Zhi Wang <zhi.wang.linux@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
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

On Wed, Feb 08, 2023, Mathias Krause wrote:
> On 07.02.23 14:36, Zhi Wang wrote:
> > On Wed,  1 Feb 2023 20:46:01 +0100
> > Mathias Krause <minipli@grsecurity.net> wrote:
> > I suppose this is a critical path according to the patch comments and
> > kvm_init_mmu() is a non-critical path. Is it better to seperate 
> > them now for saving the maintanence efforts in future? E.g. something heavier 
> > might be introduced into the kvm_init_mmu() path and slows down this path.
> 
> I'll look into what can be done about it. But this change is a first
> step that can be further optimized via follow up changes.
> 
> As you can see from the numbers below, it's already way faster that what
> we have right now, so I'd rather land this (imperfect) change sooner
> than later and gradually improve on it. This will, however, likely only
> bring minor speedups compared to this change, so they're less important,
> IMHO.
> 
> The question is really what's better from a maintenance point of view:
> Keeping the call to the commonly used kvm_init_mmu() function or special
> case even further? I fear the latter might regress easier, but YMMV, of
> course.

Agreed.  Unless the performance benefits of getting super precise are significant,
I would much rather keep things simpler and reduce the risk of introducing bugs.
Bugs in this area in particular have a nasty habit of being really good at hiding.
