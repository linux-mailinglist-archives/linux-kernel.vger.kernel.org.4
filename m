Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F64560BDAE
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 00:44:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231980AbiJXWn6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 18:43:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40978 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231374AbiJXWnY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 18:43:24 -0400
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7922D32ABF
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:06:09 -0700 (PDT)
Received: by mail-wr1-x42b.google.com with SMTP id bk15so17969829wrb.13
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 14:06:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=xGRUq34sY2BcU0VG83zmHayB6ouI/Pi+41LBRR9R888=;
        b=qnmD+76EU90dLFEzox/jjgBgvr3SF/Rt5FT93hrKpS1KJBM13MjuboaAzL/9SiUTGG
         OASLggFFnLpSmhh9u67mBgL78BNej/MSy3WmyWVwX5rta0HB/sq+qPNIxk9D9Wq2R7kp
         xCfHhEd4dUmLgErz6Zhpu/Pv7HCGgTBxootQacnPZ70q5MNI5sIYt7VH0+bxI7dX7MrX
         fqpG2wa0TJ/Xuj2ZQ/QMhl+/7jzzxaLSsORQs1EpKsrZLi8SJft+I6PXxrYwx9xkwq9+
         G094QXH+ulHW4KAs31Xl/8aOnrKnPnZzb82KZIJvDIY+Wk8Mir8E16LB8uxDMK1K1qOo
         YjvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=xGRUq34sY2BcU0VG83zmHayB6ouI/Pi+41LBRR9R888=;
        b=i1A8qHds3Q/FXbiRs3AbwthPAyqAE/K2V5RKcVjCxp0vVkkOSlnZjFAO2WnfhtK2o3
         ccdQhMslBIft6RxpxlzZv4s2OVhaT05v2LRJjM2HFltBou8+u5Jpo3YZ18X+5sHgHqSQ
         cP1q9qjwpphyIJTQL9LZZdKF4HmAAeuq8T2ijOhoyC7Ux2/+lovDBOm7UWfprXAVjIkz
         jL7ju7HNCojALbMnTs7sGmRv/OoQ8s5ogeYB1h/ybkQ+oIPApf11/clKa835qxDqnRh8
         w9gzRfb7bCmWvxmYhwt5aM1JpA8P1fYNa3gVkzaTCScii8yiyepZ7rIK951s250XBnMQ
         QETQ==
X-Gm-Message-State: ACrzQf3HwMsHL87nqBr+w2ZP9b56Wn6mdaG8oMkcUt/rJWEs4T4Lg0q1
        WGvLeJN2fyQnp27d2Iy1kLgMplGYgzDQC1LHMUG730MaIqE=
X-Google-Smtp-Source: AMsMyM5FAUdkTzGBTeY5NjATCk2EFYG5Nn83B7nDB5iDQnymcfT58qDCIKjRWaHAHnfkfpMEJ1ttyDy/0hsf9BDg6Ck=
X-Received: by 2002:adf:f081:0:b0:236:5e7c:4ec2 with SMTP id
 n1-20020adff081000000b002365e7c4ec2mr9086578wro.641.1666643078179; Mon, 24
 Oct 2022 13:24:38 -0700 (PDT)
MIME-Version: 1.0
References: <20221021185916.1494314-1-vipinsh@google.com> <Y1L9Z8RgIs8yrU6o@google.com>
 <CAHVum0eoA5j7EPmmuuUb2y7XOU1jRpFwJO90tc+QBy0JNUtBsQ@mail.gmail.com>
 <Y1MXgjtPT9U6Cukk@google.com> <87k04pbfqd.fsf@ovpn-193-3.brq.redhat.com>
 <Y1atxgq2SDkHbP9I@google.com> <CAHVum0f=gRgrP=rTySn1zwPz65g6jm_3f-=qusmS7jOkKyUMSw@mail.gmail.com>
 <Y1bpSlNGeVkqRYxI@google.com>
In-Reply-To: <Y1bpSlNGeVkqRYxI@google.com>
From:   Vipin Sharma <vipinsh@google.com>
Date:   Mon, 24 Oct 2022 13:24:01 -0700
Message-ID: <CAHVum0cnj+bWwAwDeEj+MrqNNbWEYAW5k=-GWVJpm4g8sQ9-Xw@mail.gmail.com>
Subject: Re: [RFC PATCH] Add Hyperv extended hypercall support in KVM
To:     Sean Christopherson <seanjc@google.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>, pbonzini@redhat.com,
        dmatlack@google.com, kvm@vger.kernel.org, shujunxue@google.com,
        terrytaehyun@google.com, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
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

On Mon, Oct 24, 2022 at 12:36 PM Sean Christopherson <seanjc@google.com> wrote:
>
> On Mon, Oct 24, 2022, Vipin Sharma wrote:
> > On Mon, Oct 24, 2022 at 8:22 AM Sean Christopherson <seanjc@google.com> wrote:
> > >
> > > On Mon, Oct 24, 2022, Vitaly Kuznetsov wrote:
> > > enable():
> > >
> > >         case KVM_CAP_HYPERV_EXT_CALL:
> > >                 r = -EINVAL;
> > >                 if (mask & ~KVM_SUPPORTED_HYPERV_EXT_CALL)
> > >                         break;
> > >
> > >                 mutex_lock(&kvm->lock);
> > >                 if (!kvm->created_vcpus) {
> >
> > Any reason for setting capability only after vcpus are created?
>
> This only allows setting the capability _before_ vCPUs are created.  Attempting
> to set the cap after vCPUs are created gets rejected with -EINVAL.  This
> requirement means vCPUs don't need to take a lock to consume per-VM state, as KVM
> prevents the state from changing once vCPUs are created.

I totally misread the condition and didn't notice the '!' in the if()
statement.

Thanks for the feedback.
