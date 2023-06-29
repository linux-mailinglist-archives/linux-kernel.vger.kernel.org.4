Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41690742F54
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Jun 2023 23:11:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231267AbjF2VLE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Jun 2023 17:11:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231655AbjF2VKq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Jun 2023 17:10:46 -0400
Received: from mail-yw1-x1149.google.com (mail-yw1-x1149.google.com [IPv6:2607:f8b0:4864:20::1149])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 94EF52D50
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:10:45 -0700 (PDT)
Received: by mail-yw1-x1149.google.com with SMTP id 00721157ae682-5766e49b802so9865257b3.1
        for <linux-kernel@vger.kernel.org>; Thu, 29 Jun 2023 14:10:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1688073045; x=1690665045;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :from:to:cc:subject:date:message-id:reply-to;
        bh=UsEbpxav6ahWUqWRHokyvYOjnwAiA6+4Ey/eDy9iyeU=;
        b=JmeOa/NQ4KueDONJPzGt46ULv/Jx9QjQEPEc2dClt0Ea4EBBgbSFvapBXh1anHJjb8
         vZSrkH9Fav/wClwA+7JKy0RXxPz6qRYJvWCQi+puyQQBgenTzZXqYgB7IZ28knjbyAY6
         R8uCRsS/NVb82NvjnA1LX88cCt92rgaLFEuQjwyMa3rW4j989BAJrg4M1UMRF+eOKLRM
         LNSIGbRGUXck9LY0Wd8nseZoC48wuTh1DnfAknOtlQRuV2HRMb7lMgFCcMJPqSfJUl1J
         flg1KBNKWk415VWIARpC8y+BAvk8F5r0/T8Z6/KRaOi2Wi0wrNrNtGjX+FIaozCGgfwm
         LiKQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688073045; x=1690665045;
        h=to:from:subject:message-id:references:mime-version:in-reply-to:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=UsEbpxav6ahWUqWRHokyvYOjnwAiA6+4Ey/eDy9iyeU=;
        b=fMpzRgtfDa1FcTugf23atRO7q1lDqv4feqXBuKI+Xq3SSwuBoie80AdbRiVX3ISMfC
         DfIXBtz3zcdx9gxHJVM1EMoCswHfQFl2a/adoCItfi/6hqWOirQEhZRCikWcO3/pMveR
         ZL3zVyRtjCbhqZmXLVikbthgTLceURoMSqsPzOR4q9DQ9h8atkY7k9JTLqOvj+/47DBF
         yMoEjSQSCPTkjOeKQeqDVbG0gdvjo42GSn1tWI/Fxsyvno3btDDmEp4DhxHibkerJ5cl
         pQAw171k/W0FoxnQInukdC2QjG0cLsZMPgnS/k+NVKOykUuZCFOVa5xKIttfyfe5ih2D
         jbNg==
X-Gm-Message-State: ABy/qLa5yuTrvrp11Rz3zbvkWGe0dMol3l1EXr84RXcyULcVzY7vJ6de
        3y9TZkRFvqfo3N7WdtLwG7HTgtKJy0E=
X-Google-Smtp-Source: APBJJlEk8/5Ea2X6pRItOxTeUL+Uh//8L0CrzsASNmcIyDjTUxF9X5fS+sl+JJC5fcPXB6Sl9EYJC4G4Y0s=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a25:7412:0:b0:ba6:e7ee:bb99 with SMTP id
 p18-20020a257412000000b00ba6e7eebb99mr5728ybc.12.1688073044874; Thu, 29 Jun
 2023 14:10:44 -0700 (PDT)
Date:   Thu, 29 Jun 2023 14:10:43 -0700
In-Reply-To: <20230627230654.2934968-1-seanjc@google.com>
Mime-Version: 1.0
References: <20230627230654.2934968-1-seanjc@google.com>
Message-ID: <ZJ3zU52uK0N+uoDn@google.com>
Subject: Re: [ANNOUNCE] PUCK Agenda - 2023.06.28 - CANCELED
From:   Sean Christopherson <seanjc@google.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org
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

+maintainers and other interested parties

On Tue, Jun 27, 2023, Sean Christopherson wrote:
> No topic this week, and I need to reclaim some time this week as I will be OOO
> all of next week.
> 
> For future topics, a few things on my radar that I am hoping to discuss in the
> not-too-distant future, but that need additional work before they're worth
> discussing:
> 
>  - Coordinating guest_mem() development.  I need to post patches, plan is to do
>    that the week after I get back.
> 
>  - Overhauling KVM's gfn_to_pfn() APIs.  Need a status update from David S., e.g.
>    I don't even know if this being actively worked.
> 
>    https://lore.kernel.org/all/ZGvUsf7lMkrNDHuE@google.com
> 
>  - KVM + UFFD scalability.  We're not yet at the point where we need a synchronous
>    discussion, but I suspect we'll want a live discussion before merging.
> 
>    https://lore.kernel.org/all/20230602161921.208564-1-amoorthy@google.com
> 
>  - Hiding KVM internals from the kernel at large, e.g. moving kvm_host.h into
>    arch/<arch>/kvm and virt/kvm/, and exporting "internal" KVM symbols if and
>    only if there are vendor modules.  Needs an RFC from us (Google GCE people).

Actually, one semi-urgent topic that I'd like to discuss is the LPC KVM Microconference.
Specifically, how we want to utilize the allotted three hours.  E.g. we can squeeze
in ~9 topics if we do 20 minutes per topic, but 20 minutes feels too short for some
of the "big" topics like guest_mem(), fine-grained permissions, KVM vs. perf, and pKVM.
But I don't want to focus on just 3-4 topics and not leave time to sync on other
things.  IMO, a mix would work well, e.g. use 2 hours for 3-4 big topics, and then
1 hour for 4-6 small topics.

I'm thinking we could use a PUCK session in mid July to get input on what folks
generally want the KVM MC to look like so that we can broadcast rough details.
And then maybe another session in the September timeframe (after submissions have
closed) to go over the "official" schedule before it becomes officially official.

Thoughts?
