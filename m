Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D1686C8770
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Mar 2023 22:25:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231561AbjCXVZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Mar 2023 17:25:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231215AbjCXVZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Mar 2023 17:25:29 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EDF5C155
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 14:25:28 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id k3-20020a170902ce0300b0019ca6e66303so1829556plg.18
        for <linux-kernel@vger.kernel.org>; Fri, 24 Mar 2023 14:25:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679693128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=zodHA9qFwPM7FM3/i/LVmpVkVaDmmsdXQrDcFc+B+NY=;
        b=hEVJMNMvymwu0rssShTLoH4LK8MacXdJdWKhEBNGJ5fJmoH82ZlGrK/Fk+T0pxgaUu
         OtAWRqA1yFkoSBC368Issjgg7M1VImQne2uReDy1xBqgjvBIR8A2QGlS8UtvfArOQq9n
         QzrftqFhKr8L6HefQ3S75AS8Z6g4gaoSqeXxf/ZqtYiygrdmviICH90PcpgSlZY5+m+X
         KbZaC42xMHN5UEGht661mPxeYuAeU1fia7xZbnIRzCvJosppj+jZ3b+yXuqNqKJd3CpF
         Sy6dMWLAMXBwNv3R2cQRi0iSfYxISHUgUr4shwVBCcIR/W65oggGf8tb7QKL+cFZ7kfw
         PD1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679693128;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=zodHA9qFwPM7FM3/i/LVmpVkVaDmmsdXQrDcFc+B+NY=;
        b=L7LWkkxHXmqrJcwoLWi5o5umpJRYi9EpiYr5hHi0OD1cbrfyZAFULFpN72E7Qw/x4m
         2jCxlNs8lAhEA+YCwEKHoj2vXBDnBPKnjgRfPb2xa6jGzieq/yv4iHj1wORhwf7U8Y5W
         qY3W28OoeGLm7paJtZAa7XtLbb5EciMslxiLbw+MknUeLMMxbEWpkIu9RKczWvjKONC6
         FAZoveb/Y5m3B2UL1x3ufJx/GKkExEfpBgjjvjeQ25ABihunA1R0FCYljHPMfshmopkL
         bZFXi21mCkEDFuYbOchnyQW5cXFHNwhwcHgeEg/sCNy8OozoG9XlKpxGCirjlkxWDkQX
         nwkg==
X-Gm-Message-State: AAQBX9daFpDbW0msDNoTxonoWU3cEJmJu0+EI0h+xWzFRO8gCK3CItQB
        zXI8XfWq6Mj/plBiLpM3CJxA6W/laI8=
X-Google-Smtp-Source: AKy350aBPofblWh3QIw6tmKvOGplsa5ky59fnNaATx62FJsqq1sXA7XckNvwaTfDCQUwZiU1gGyuGKJyujU=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:aa7:88c9:0:b0:5f1:b1:6dc4 with SMTP id
 k9-20020aa788c9000000b005f100b16dc4mr2211266pff.3.1679693127931; Fri, 24 Mar
 2023 14:25:27 -0700 (PDT)
Date:   Fri, 24 Mar 2023 14:25:26 -0700
In-Reply-To: <167969136143.2756283.9405259236021680651.b4-ty@google.com>
Mime-Version: 1.0
References: <20230214084920.59787-1-likexu@tencent.com> <167969136143.2756283.9405259236021680651.b4-ty@google.com>
Message-ID: <ZB4VRvjUP75kpw71@google.com>
Subject: Re: [PATCH 0/2] KVM: selftests: Report enable_pmu module value when
 test is skipped
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

On Fri, Mar 24, 2023, Sean Christopherson wrote:
> On Tue, 14 Feb 2023 16:49:18 +0800, Like Xu wrote:
> > Adequate info can help developers quickly distinguish whether the cause
> > is a code flaw or a platform limitation when a test fails or is skipped,
> > and this minor patch-set is doing a little work in that direction.
> > 
> > Base: kvm-x86/next
> > 
> > Like Xu (2):
> >   KVM: selftests: Add a helper to read kvm boolean module parameters
> >   KVM: selftests: Report enable_pmu module value when test is skipped
> > 
> > [...]
> 
> Applied to kvm-x86 selftests, thanks!
> 
> [1/2] KVM: selftests: Add a helper to read kvm boolean module parameters
>       https://github.com/kvm-x86/linux/commit/d14d9139c023
> [2/2] KVM: selftests: Report enable_pmu module value when test is skipped
>       https://github.com/kvm-x86/linux/commit/6cf332e8eca6

Replaced patch 2 with your v2:

  KVM: selftests: Report enable_pmu module value when test is skipped
  https://github.com/kvm-x86/linux/commit/5b1abc285a08
