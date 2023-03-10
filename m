Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF97C6B4BC8
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 16:58:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231276AbjCJP54 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 10:57:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231167AbjCJP51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 10:57:27 -0500
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 216DA11E97
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:51:59 -0800 (PST)
Received: by mail-pj1-x1049.google.com with SMTP id g9-20020a17090a300900b0023a8d6e327dso2489414pjb.9
        for <linux-kernel@vger.kernel.org>; Fri, 10 Mar 2023 07:51:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1678463518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=JWVbW737nKxFCj4MT7r6npOdAHrQ078Zlu0cOQ+zqXE=;
        b=a+Fm2iTltql6hooUjhzjQTNaT6EzSupmnae8tyt0+CpmgPs1phb+xSg8RpkJ17rdl/
         Cu2UqcikT+0nz0Tm1+eCcj7RS6qfWLMA2pn7YdLwzHIgLYyDI1MG7ESCDCjYUVq8DER8
         aZPIzis0bpmg34KmR01ftj+vEvqLPY0femNxEtU5XVUPJlf+dCV9geRrpRmp5DYBIOgn
         /FyqRlkEkNlhShsLMbnwP2EDTwQaHissPJZLiAi8z9FVuOg4R+CvCZgbm2POs8Xwo2Ek
         gc/NlhkKDiI2/jlIB/8shePIgiiKnFs1G5oFCGVz1iNVFUNDWOQzRD4vsLZtlQdaB6Wo
         mxcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678463518;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=JWVbW737nKxFCj4MT7r6npOdAHrQ078Zlu0cOQ+zqXE=;
        b=j9PPFQF0uC3zzk6toJEdM5K3TPI7WRfJ4aAMKWkGprQAEhxgAwzyYRfX/Wl9uVK1Fq
         BWqv5Ho0TbeA7AUQEqH9b5qW/Ye1X40XppOBI7zmSiYWP9TWaHrZHoMzYgLhabuga8Px
         H5oXG06Xquw45ZTxCA79BNqlwyR/E9ivAuvGrcO1cAIrxTcPYW+wtGlDzibVNn2nrchX
         giLomRtKcUUgOEzt8aSuYpjDcvVYE/AK+ljQ+FUJg5QDuQATo04ZFlqpQQ1nZapRRQ84
         m3YeR+sqoPxbqureHQhQMt0JlFfDR6DNbpXMCWShU7CrL5cyJ0XJ0AGH7w5vK+LDy9Kb
         XjNQ==
X-Gm-Message-State: AO0yUKXKZT6999ULhweT8AXRegXgwh4GLxkw4oE1iP83/3Oy8YlBamJc
        VFINKBjmd/a3vR7T8xqMh2/gGu4jfiI=
X-Google-Smtp-Source: AK7set9uZBmMV2Z1i9xlaNUaTJlFzTVMPOsafM0owNkpQTNrjOap8/LeWEt7zkBNsFPhAUCBkmzoOGBo6Yk=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:1a1f:0:b0:4f2:8281:8afb with SMTP id
 a31-20020a631a1f000000b004f282818afbmr8560785pga.4.1678463518479; Fri, 10 Mar
 2023 07:51:58 -0800 (PST)
Date:   Fri, 10 Mar 2023 07:51:57 -0800
In-Reply-To: <81e3e68b02528e1720df5ccb43d960e11de17e3c.camel@linux.intel.com>
Mime-Version: 1.0
References: <20230309010336.519123-1-seanjc@google.com> <20230309010336.519123-3-seanjc@google.com>
 <81e3e68b02528e1720df5ccb43d960e11de17e3c.camel@linux.intel.com>
Message-ID: <ZAtR5kCdUkb8jkoY@google.com>
Subject: Re: [PATCH v2 2/2] Documentation/process: Add a maintainer handbook
 for KVM x86
From:   Sean Christopherson <seanjc@google.com>
To:     Robert Hoo <robert.hu@linux.intel.com>
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
        David Woodhouse <dwmw@amazon.co.uk>,
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
Content-Type: text/plain; charset="us-ascii"
X-Spam-Status: No, score=-9.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 10, 2023, Robert Hoo wrote:
> On Wed, 2023-03-08 at 17:03 -0800, Sean Christopherson wrote:
> (...)
> > +Using reverse fir tree for variable declarations isn't strictly
> > required,
> > +though it is still preferred.
> > +
> I googled, but didn't find what's "fir tree". Shed more light?

Y'all need to improve your Google-fu ;-)

Since many people seem to be surprised by this one, I'll reword this section to:

  Using reverse fir tree, a.k.a. reverse Christmas tree or reverse XMAS tree, for
  variable declarations isn't strictly required, though it is still preferred.
