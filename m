Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D7CB69E89B
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 20:55:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229869AbjBUTzA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 14:55:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbjBUTy5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 14:54:57 -0500
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D24D32E0C6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:54:55 -0800 (PST)
Received: by mail-yb1-xb4a.google.com with SMTP id r13-20020a25760d000000b0096c886848c9so6342465ybc.3
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 11:54:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GMjxnmNbo7rccpb3LScr9ujBgQh2usRmHS4Hjb61AYU=;
        b=W3m1ryuQRSJ/wYmcUFTAGHVOjOvkuwmFZa/ATJ+Zhl/q1P2zmd10Ky8I3U1Vi1jVqR
         Os1Xiszxq8Jllg7eyTjkmmRjSqfVy79uWshm5fsRPEAriZzx1mYbDCOao9Z1j8GPHsBM
         aIs9zpNlhcVAeolxzUaQIVtzV5YSJ8tncE5Civm4cwQUrM8xkKmAeMZlFpJXrOZXgtkn
         1mvgoO8re73Ud6HQHBKoH6/MRalLky5o4OVLLIoRMvvuJsCdHoTUmf6aCBrIfn2weR92
         cg8IO7eUD8MOgHbG6ABDrrKoq1wr706owPdWp+QXVVxDQNRPZphya0n0LZFFdPJicJ+a
         zhwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:from:subject:message-id:references
         :mime-version:in-reply-to:date:x-gm-message-state:from:to:cc:subject
         :date:message-id:reply-to;
        bh=GMjxnmNbo7rccpb3LScr9ujBgQh2usRmHS4Hjb61AYU=;
        b=LhMv3hXGYdaULv8/UH5Ta0WD2Xf9eO4HN4cBv6YaMdoXUssi2M3bDVMCo3B8rEfxFu
         AH4UIfnjR0/1l39o25ZqLgWlfMytw351tH8D6VdG0z+Lqqmik9A185LL35/p138hsaDa
         E8gKmHMKCtcD6PF3ioGodOYopDPOzgKqNyrOEauObCaJg7hz9thzxsPJcMPsCIhxgcZo
         ETMGuZFgsOqETzo1sh9G33uKW6x0mroFJKETB+AahkRHGjf4eVddiidITKFG1fA1bWhq
         CJz0hrM77g/Y7cjIzGux0JkzDKdhoPFN9Ci354E2G8pafEv7D3hLqCVndN+FylwTqI6O
         auGw==
X-Gm-Message-State: AO0yUKXBSqbAAarhHlr4se9a0bCZ0/+onrFwV3Ss+2HAmWRim8lO7GPV
        a0kDyY3GUZRY7XdxY+Qh8fHslvHbHHM=
X-Google-Smtp-Source: AK7set8SUgSmPQqcX51dDTTA7kwYC3V/xXsn0t8KiCr3/EMtaWiikm+Eb2d/F51tnqvIdchYqAwoXH4D0NE=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6902:1024:b0:8da:3163:224 with SMTP id
 x4-20020a056902102400b008da31630224mr681511ybt.0.1677009294961; Tue, 21 Feb
 2023 11:54:54 -0800 (PST)
Date:   Tue, 21 Feb 2023 11:54:53 -0800
In-Reply-To: <b58da4e7c95f8771dd96a14914c9ead077ff2b3f.camel@infradead.org>
Mime-Version: 1.0
References: <20230217225449.811957-1-seanjc@google.com> <20230217225449.811957-3-seanjc@google.com>
 <b58da4e7c95f8771dd96a14914c9ead077ff2b3f.camel@infradead.org>
Message-ID: <Y/UhjRe4jcM+BXt+@google.com>
Subject: Re: [PATCH 2/2] Documentation/process: Add a maintainer handbook for
 KVM x86
From:   Sean Christopherson <seanjc@google.com>
To:     David Woodhouse <dwmw2@infradead.org>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Sagi Shahar <sagis@google.com>,
        Erdem Aktas <erdemaktas@google.com>,
        Peter Shier <pshier@google.com>,
        Anish Ghulati <aghulati@google.com>,
        Oliver Upton <oliver.upton@linux.dev>,
        James Houghton <jthoughton@google.com>,
        Anish Moorthy <amoorthy@google.com>,
        Ben Gardon <bgardon@google.com>,
        David Matlack <dmatlack@google.com>,
        Ricardo Koller <ricarkol@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Aaron Lewis <aaronlewis@google.com>,
        Ashish Kalra <ashish.kalra@amd.com>,
        Babu Moger <babu.moger@amd.com>, Chao Gao <chao.gao@intel.com>,
        Chao Peng <chao.p.peng@linux.intel.com>,
        Chenyi Qiang <chenyi.qiang@intel.com>,
        Emanuele Giuseppe Esposito <eesposit@redhat.com>,
        Gavin Shan <gshan@redhat.com>,
        Guang Zeng <guang.zeng@intel.com>,
        Hou Wenlong <houwenlong.hwl@antgroup.com>,
        Jiaxi Chen <jiaxi.chen@linux.intel.com>,
        Jim Mattson <jmattson@google.com>,
        Jing Liu <jing2.liu@intel.com>,
        Junaid Shahid <junaids@google.com>,
        Kai Huang <kai.huang@intel.com>,
        Leonardo Bras <leobras@redhat.com>,
        Like Xu <like.xu.linux@gmail.com>,
        Li RongQing <lirongqing@baidu.com>,
        "Maciej S . Szmigiero" <maciej.szmigiero@oracle.com>,
        Maxim Levitsky <mlevitsk@redhat.com>,
        Michael Roth <michael.roth@amd.com>,
        Michal Luczaj <mhal@rbox.co>,
        Mingwei Zhang <mizhang@google.com>,
        Nikunj A Dadhania <nikunj@amd.com>,
        Paul Durrant <pdurrant@amazon.com>,
        Peng Hao <flyingpenghao@gmail.com>,
        Peter Gonda <pgonda@google.com>, Peter Xu <peterx@redhat.com>,
        Robert Hoo <robert.hu@linux.intel.com>,
        Suravee Suthikulpanit <suravee.suthikulpanit@amd.com>,
        Tom Lendacky <thomas.lendacky@amd.com>,
        Vipin Sharma <vipinsh@google.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Wei Wang <wei.w.wang@intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Yu Zhang <yu.c.zhang@linux.intel.com>,
        Zhenzhong Duan <zhenzhong.duan@intel.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023, David Woodhouse wrote:
> On Fri, 2023-02-17 at 14:54 -0800, Sean Christopherson wrote:
> >=20
> > +All topic branches, except for ``next`` and ``fixes``, are rolled into=
 ``next``
> > +via a cthulu merge on an as-needed basis, i.e. when a topic branch is =
updated.
> > +As a result, force pushes to ``next`` are common.
> > +
>=20
> This makes 'next' an unfortunate name, doesn't it? Since branches
> destined for "linux-next", which has been using that name for far
> longer, have exactly the opposite expectation =E2=80=94 that they have st=
able
> commit IDs.

I was coming at it from the viewpoint of linux-next itself, where HEAD is r=
ebuilt
nightly and thus is not stable.  The inputs are stable, just not the merge =
commit.

> Would 'staging' not be more conventional for the branch you describe?

Not really?  It's not a staging area, it really is the branch that contains=
 the
changes for the "next" kernel.

What if I drop the above guidance and instead push a date-stamped tag when =
pushing
to 'next'?  That should ensure the base is reachable for everyone, and woul=
d also
provide a paper trail for what I've done, which is probably a good idea reg=
ardless.
