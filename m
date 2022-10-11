Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D5F95FAA85
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Oct 2022 04:15:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229712AbiJKCP4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 22:15:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbiJKCPs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 22:15:48 -0400
Received: from mail-il1-x136.google.com (mail-il1-x136.google.com [IPv6:2607:f8b0:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2918C7F0AC
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:15:48 -0700 (PDT)
Received: by mail-il1-x136.google.com with SMTP id r20so6504271ilt.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Oct 2022 19:15:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=H/xYrhJE+jRHh/6xuRZ4OUPEvZUDe865/O/aakyh1Jc=;
        b=cA3mVR/CGxcV72s28yIpSLl8Ry3QNBNtiqfQRJk1LI87DGdgCtvhtL6ju5NrdFgp0v
         jYbavGUnyyFdJJdSvAc+k/dXxseV1w+wYt7qd2Z+qBFjnBIe0LXWbBKllfNKCbfjAlGe
         4S75Ef/hxbmI7DLha0tUVkEeTJmS1s/2ot+vQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=H/xYrhJE+jRHh/6xuRZ4OUPEvZUDe865/O/aakyh1Jc=;
        b=PHJJzVR9bRQkgvMBTR/3umo/ulOnjmZmrnkbkD/o49HDBVpn+7NqbRgq4tiNIKB66j
         XFTGcK0IB+5VxuwbE3VoBipkCYs9jB7fZtFi1S+E1A8UKTe69inSxNBJZRsh3wvWBssh
         UAuBxjAXV+2sUIrvRn79hvvNd6wK7YhTpUA5TbMctdtoKzJJQ2anQn+Rm6c35FX8IoD3
         PrzbZyLESqAraRNjzijYQ+WNjfD8O87k7ozKUrnezgMH2VkBtI+cs75rS0MQALbTPOOt
         brUjyf9Q+ZMBJ/DqiEZ3cL6vscAHnlZU8EMfeNpmR6HbiIeSuJYLXtJsk4O9+kDnxcC8
         6nhA==
X-Gm-Message-State: ACrzQf1QhFuHJ5O3XKoQfzYaehlTrAnerTJToKcymd2aYI8OdRjDvouy
        PdaF1YAqffgV9qylAXPUrwU802LDGebmYjSSDkVv/XULZ4dU5A==
X-Google-Smtp-Source: AMsMyM5JQvbMqETxKQHEq6txeP+r87znPWfN/6DVQDwiA28XRis95uxqOPRsPOisPJqXnkwrVBqASlH34ysfeq3CL9g=
X-Received: by 2002:a05:6e02:1749:b0:2fa:5de2:4cc9 with SMTP id
 y9-20020a056e02174900b002fa5de24cc9mr10531673ill.214.1665454547546; Mon, 10
 Oct 2022 19:15:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220920082005.2459826-1-denik@chromium.org> <20220922053145.944786-1-denik@chromium.org>
 <87h70zk83g.wl-maz@kernel.org> <CADDJ8CW0QgHtp1rwk=ZqrcuWZ4_L8KQh26VaEfcBQS0Tx9+ZYg@mail.gmail.com>
 <CAH=Qcsi3aQ51AsAE0WmAH9VmpqjOaQQt=ru5Nav4+d8F3fMPwQ@mail.gmail.com>
 <CADDJ8CXObkhMvOx+L29awjtt7tiaTWxFrRxOmhUqvzku1wswHw@mail.gmail.com>
 <CADDJ8CV83d4tYeLnQH-hHjzBfED6EBo4Z70q5A=9cwO+Lp1sNQ@mail.gmail.com> <87sfjxhh4k.wl-maz@kernel.org>
In-Reply-To: <87sfjxhh4k.wl-maz@kernel.org>
From:   Denis Nikitin <denik@chromium.org>
Date:   Mon, 10 Oct 2022 19:15:36 -0700
Message-ID: <CADDJ8CVX5tZU9jL4FvTnvQxxVohhS76TVOoZAyy3k_Uit1efmA@mail.gmail.com>
Subject: Re: [PATCH v2] KVM: arm64: nvhe: Fix build with profile optimization
To:     Marc Zyngier <maz@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        James Morse <james.morse@arm.com>,
        Alexandru Elisei <alexandru.elisei@arm.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        David Brazdil <dbrazdil@google.com>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, Manoj Gupta <manojgupta@google.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Oct 8, 2022 at 7:22 PM Marc Zyngier <maz@kernel.org> wrote:
>
> On Thu, 06 Oct 2022 17:28:17 +0100,
> Denis Nikitin <denik@chromium.org> wrote:
> >
> > Hi Mark,
>
> s/k/c/
>
> >
> > This problem currently blocks the PGO roll on the ChromeOS kernel and
> > we need some kind of a solution.
>
> I'm sorry, but I don't feel constrained by your internal deadlines. I
> have my own...
>
> > Could you please take a look?
>
> I have asked for a reproducer. All I got for an answer is "this is
> hard". Providing a profiling file would help, for example.

Could you please try the following profile on the 5.15 branch?

$ cat <<EOF > prof.txt
kvm_pgtable_walk:100:10
 2: 5
 3: 5
 5: 5
 6: 5
 10: 5
 10: _kvm_pgtable_walk:50
  5: 5
  7: 5
  10: 5
  13.2: 5
  14: 5
  16: 5 __kvm_pgtable_walk:5
  13: kvm_pgd_page_idx:30
   2: __kvm_pgd_page_idx:30
    2: 5
    3: 5
    5: 5
    2: kvm_granule_shift:5
     3: 5
EOF

$ make LLVM=1 ARCH=arm64 KCFLAGS=-fprofile-sample-use=prof.txt -j8 vmlinux

Thanks,
Denis

>
>         M.
>
> --
> Without deviation from the norm, progress is not possible.
