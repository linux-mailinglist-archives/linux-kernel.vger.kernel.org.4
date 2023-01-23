Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF5EC67815D
	for <lists+linux-kernel@lfdr.de>; Mon, 23 Jan 2023 17:28:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjAWQ2S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 23 Jan 2023 11:28:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231936AbjAWQ2Q (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Jan 2023 11:28:16 -0500
Received: from mail-yb1-xb2b.google.com (mail-yb1-xb2b.google.com [IPv6:2607:f8b0:4864:20::b2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7845326875
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:28:11 -0800 (PST)
Received: by mail-yb1-xb2b.google.com with SMTP id p15so11873142ybu.7
        for <linux-kernel@vger.kernel.org>; Mon, 23 Jan 2023 08:28:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=swnsWYO3WLFwOfwSTkqdfPT/d57d66LDjYzGih7erMc=;
        b=Hi2ocvKLxoaAi5NunQ3HmLcF0j/bZxXr6VjjdN7696BQKDnev0t0slalgW1Wnd/+wW
         fG42XpLKdRgyEE4azPYkVZj7kBS+RBvNsIZynyJC0nv8qTSatGc6tdFVkW/XyRv1wKSe
         cztiOGKQRh5DR6hnH5EMYalM8phultm0l7dsgY0/IGwVgqab91+Uav6jbrZU5JAfp3m7
         6bTR6MRnNJQcLChD6ATGfobqU9emaMlziKo6NbZnSb2Is4zMd9NcPLg17YrTImOnIgJM
         LZ8O6ckl9ePqn1850OupQwUP8p6/lEj37l2Vsd3h/IUoYCAJxElo1nPDXFSfyJGySHNP
         VOoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=swnsWYO3WLFwOfwSTkqdfPT/d57d66LDjYzGih7erMc=;
        b=HpIO3B6+agvEXdoqm+RLg31xaVssuEwAAzQdHNgxisEvnE49BWIVMy31cCTDAqoMyR
         0RLg6IizKxU21OfeD2qBQ9942g5GUlwcwNlMLHY3nRhKHVw4+ftuN4amVS3iKGotrkWY
         GlPuH2ePUqRb2e1tFPJ90Gjn5ewFAiU13o5pZqUQsmTY74bndMDqYq+iDvk5/PsCiXKj
         CVv5sFIx0Lq1IWTwRjf1eTB+DvPyHoTSbMbvWv/Gw/aWqSlkjAyguwZLwbgL6o7AZvUO
         4/gqaK0JAtAmIPhWr0EbhIJEF6DBL1DM+gJFKQkCE7d+BfBVGTfaoftATEYJMX5ju9cZ
         MsXw==
X-Gm-Message-State: AFqh2kraIF5H7I4Cfc605GiLwvyglmt3W5LStdUpUMGFEcoRFsmoJ5av
        C3NXZWDRA5AWOPOzjGH9hQnyP8jFlVmpgFYMFZhl890Fgnd3S1i7yuA=
X-Google-Smtp-Source: AMrXdXstnO0rCf72SbBog9/UAW1XRPXv8pFQ25+x/LkSv3fL1kEc62oR9e6iB22dAnX99Hzb4YqCpCkwzH6CDx2GnLQ=
X-Received: by 2002:a25:d4e:0:b0:800:9451:c106 with SMTP id
 75-20020a250d4e000000b008009451c106mr1471584ybn.191.1674491290571; Mon, 23
 Jan 2023 08:28:10 -0800 (PST)
MIME-Version: 1.0
References: <20230122090843.3743704-1-pbonzini@redhat.com>
In-Reply-To: <20230122090843.3743704-1-pbonzini@redhat.com>
From:   David Matlack <dmatlack@google.com>
Date:   Mon, 23 Jan 2023 08:27:44 -0800
Message-ID: <CALzav=eLgrHXd78dBayZQLt0Cprm277HCf04SaZ30Th-7M-pHw@mail.gmail.com>
Subject: Re: [PATCH] selftests: kvm: move declaration at the beginning of main()
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Sean Christopherson <seanjc@google.com>
Content-Type: text/plain; charset="UTF-8"
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

On Sun, Jan 22, 2023 at 1:09 AM Paolo Bonzini <pbonzini@redhat.com> wrote:
>
> Placing a declaration of evt_reset is pedantically invalid
> according to the C standard.  While GCC does not really care
> and only warns with -Wpedantic, clang ignores the declaration
> altogether with an error:
>
> x86_64/xen_shinfo_test.c:965:2: error: expected expression
>         struct kvm_xen_hvm_attr evt_reset = {
>         ^
> x86_64/xen_shinfo_test.c:969:38: error: use of undeclared identifier evt_reset
>         vm_ioctl(vm, KVM_XEN_HVM_SET_ATTR, &evt_reset);
>                                             ^
>
> Reported-by: Yu Zhang <yu.c.zhang@linux.intel.com>
> Reported-by: Sean Christopherson <seanjc@google.com>
> Fixes: a79b53aaaab5 ("KVM: x86: fix deadlock for KVM_XEN_EVTCHN_RESET", 2022-12-28)
> Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>

Thanks, I had a similar patch queued up to send out today :)

Can you add clang to your workflow for queueing patches? It's not the
first time a selftest patch that does not build with clang has snuck
into kvm/queue or even an rc [1].

[1] git log --oneline --grep Fixes: --grep clang --all-match
tools/testing/selftests/kvm
