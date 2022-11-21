Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7AC40631B1E
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 09:18:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbiKUISq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 03:18:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229576AbiKUISm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 03:18:42 -0500
Received: from mail-vs1-xe36.google.com (mail-vs1-xe36.google.com [IPv6:2607:f8b0:4864:20::e36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F088D193CE
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:18:39 -0800 (PST)
Received: by mail-vs1-xe36.google.com with SMTP id p4so10465926vsa.11
        for <linux-kernel@vger.kernel.org>; Mon, 21 Nov 2022 00:18:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=5FNLqZ3+KdQjzm7Sx3mBq4NxeuMTkAwBYeRYu3X/hpw=;
        b=ZT1IBXqXR8n7CAGsZwETJtXB5s+32HQ0WfDf9ELFM7TnqZKlgWOeBc/bChoGMeTXZI
         DBw5IgWzhYRwwB8q2PlTYpDsgp/Xn0faD8qlQqeqGTzK+LtA5bO4pTSl6VhvOF3XjuUB
         v7cQhUjxPdiSW4o/cUm4GMGrYxkl6E57CDG+DeRbt7ONLQ4PRpM51bw/quQN3Qeh/nRb
         JOozyTr672VPCmMVeXPM/Pap3nqPGUKwDDQvfOazKh7eIRlTkGXUgXoNOSeHNoDkShnQ
         BYjmuzxMjI4p4EU4gVYY8/BJb9B8jMg9lMMiMnAoeTTtQL0QVNNx19/DQH0TeRn3a1mM
         HCZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=5FNLqZ3+KdQjzm7Sx3mBq4NxeuMTkAwBYeRYu3X/hpw=;
        b=Gwx6PrVAYafMoMhKM/6vGBkNxQTz2+x6V7lCa5bx9X/BJHsCB8mUWT/cyr4//8+2Lr
         NDXja82Gmc6jw1GvD7BBm6caSyZPjBaGkj32Ql6q8A4LnU+D5pQdNJMUuuf/JtX51p2J
         aE1GPYXdMIQ2wuazyUTapeWiB+g+705TfKg1yKrZRukzxIaQL1+yTy7ZQEWC5KwvzEh5
         di774cfEHoKB33NqP7rxHW62sn0EJyx3Gvqaz0Yw2/bm5BKYzgomDjAF1ej4dLR5hpK0
         xhLEIRDzwKsJwqnROEHfbEtL3bcITljFXOmoSK1fa27bvCPCAYvkRdD1zTPYkgroHebG
         RDag==
X-Gm-Message-State: ANoB5pkceRhRbhtjp+UF+UEcmHNZ+q/lHpcVDFnBZl3mSdQjIevrY3A2
        blm/48WOAgapEjT6uqYpyW8qXofuxbN8FzHssnqjWKUH45s=
X-Google-Smtp-Source: AA0mqf6QG/XZV0N6cp0tywJ1b6hLNvJyyPYmMjylRsqJ9dVG67YrNCJaKMIbcALAv7PxmXvGlzEcAkmgNqBCPxSecSs=
X-Received: by 2002:a67:c98e:0:b0:3ad:3d65:22b with SMTP id
 y14-20020a67c98e000000b003ad3d65022bmr3275421vsk.65.1669018718896; Mon, 21
 Nov 2022 00:18:38 -0800 (PST)
MIME-Version: 1.0
References: <42579618-f8e2-9fd2-0b6c-f2c87f7c57a6@eikelenboom.it> <99178e0a-ff6a-9bfa-4ade-b4bf6fdc306f@suse.com>
In-Reply-To: <99178e0a-ff6a-9bfa-4ade-b4bf6fdc306f@suse.com>
From:   Yu Zhao <yuzhao@google.com>
Date:   Mon, 21 Nov 2022 01:18:02 -0700
Message-ID: <CAOUHufY8it25rBbV1QeO3-wF3g32VkDwrsT6mL4fQUNZsMGkKw@mail.gmail.com>
Subject: Re: Xen-unstable Linux-6.1.0-rc5 BUG: unable to handle page fault for
 address: ffff8880083374d0
To:     Juergen Gross <jgross@suse.com>,
        Sander Eikelenboom <linux@eikelenboom.it>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Xen-devel <xen-devel@lists.xen.org>
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

On Mon, Nov 21, 2022 at 12:10 AM Juergen Gross <jgross@suse.com> wrote:
>
> On 19.11.22 09:28, Sander Eikelenboom wrote:
> > Hi Yu / Juergen,

Hi Sander / Juergen,

Thanks for the report and the analysis.

> > This night I got a dom0 kernel crash on my new Ryzen box running Xen-unstable
> > and a Linux-6.1.0-rc5 kernel.
> > I did enable the new and shiny MGLRU, could this be related ?
>
> It might be related, but I think it could happen independently from it.

Yes, I think it's related.

> > Nov 19 06:30:11 serveerstertje kernel: [68959.647371] BUG: unable to handle page
> > fault for address: ffff8880083374d0
> > Nov 19 06:30:11 serveerstertje kernel: [68959.663555] #PF: supervisor write
> > access in kernel mode
> > Nov 19 06:30:11 serveerstertje kernel: [68959.677542] #PF: error_code(0x0003) -
> > permissions violation
> > Nov 19 06:30:11 serveerstertje kernel: [68959.691181] PGD 3026067 P4D 3026067
> > PUD 3027067 PMD 7fee5067 PTE 8010000008337065
> > Nov 19 06:30:11 serveerstertje kernel: [68959.705084] Oops: 0003 [#1] PREEMPT
> > SMP NOPTI
> > Nov 19 06:30:11 serveerstertje kernel: [68959.718710] CPU: 7 PID: 158 Comm:
> > kswapd0 Not tainted 6.1.0-rc5-20221118-doflr-mac80211debug+ #1
> > Nov 19 06:30:11 serveerstertje kernel: [68959.732457] Hardware name: To Be
> > Filled By O.E.M. To Be Filled By O.E.M./B450 Pro4 R2.0, BIOS P5.60 10/20/2022
> > Nov 19 06:30:11 serveerstertje kernel: [68959.746391] RIP:
> > e030:pmdp_test_and_clear_young+0x25/0x40
>
> The kernel tired to reset the "accessed" bit in the pmd entry.

Correct.

> It does so only since commit eed9a328aa1ae. Before that
> pmdp_test_and_clear_young() could be called only for huge pages, which are
> disabled in Xen PV guests.

Correct. After that commit, we also can clear the accessed bit in
non-leaf PMD entries (pointing to PTE tables).

> pmdp_test_and_clear_young() does a test_and_clear_bit() of the pmd entry, which
> is failing since the hypervisor is emulating pte entry modifications only (pmd
> and pud entries can be set via hypercalls only).
>
> Could you please test the attached patch whether it fixes the issue for you?

There is a runtime kill switch for ARCH_HAS_NONLEAF_PMD_YOUNG, since I
wasn't able to verify this capability on all x86 varieties. The following
should do it:

  # cat /sys/kernel/mm/lru_gen/enabled
  0x0007
  # echo 3 >/sys/kernel/mm/lru_gen/enabled

Details are in Documentation/admin-guide/mm/multigen_lru.rst.

Alternatively, we could make ARCH_HAS_NONLEAF_PMD_YOUNG a runtime
check similar to arch_has_hw_pte_young() on arm64.
