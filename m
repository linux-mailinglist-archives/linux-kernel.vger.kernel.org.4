Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D601B69EBF8
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 01:29:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229688AbjBVA3I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 19:29:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjBVA3G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 19:29:06 -0500
Received: from mail-pf1-x449.google.com (mail-pf1-x449.google.com [IPv6:2607:f8b0:4864:20::449])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FE3CAD2F
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 16:29:03 -0800 (PST)
Received: by mail-pf1-x449.google.com with SMTP id a23-20020a62bd17000000b0058db55a8d7aso2704474pff.21
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 16:29:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=uIDtQ32zJSVa9EXNJVGMsp6ZglA2e8zL695ZtssIiXs=;
        b=G63UjEfJMICR92XTGkg/IByvVf+5OTGgW7MLAuV5i2ZP1/HdCfJcZXCL42kjG4TWnb
         LXG68O9DzonOIqwczgoSpaBm2l3+gcBA85vnkF+yFdGa0CVX5R3Uxie6hpCafeWf/x0L
         XJle5ehg8LuuXTWUTV8+dQQEQw9rPiqDHwWRxUzb+9/rKF1eqS/9z5A5qFitGaB31guo
         0jT3vO3G834Iywki+Ss9Ew36XwLL5nMF9ySfjO7OegG7CRvN6IZL9DX0PXOTXSJBCPUl
         8SgEQH6V4P4CLCS1dTEssjBGXd8LQqmVWAEsD2sLuSYNbh8jlaYtDDTlxnSCxAFfjT2S
         pdzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=uIDtQ32zJSVa9EXNJVGMsp6ZglA2e8zL695ZtssIiXs=;
        b=haryLRDke7WSNLC3IqiWqhi0JzJccgKNx4xObXUmQsGHCCEtnn1P3zABVB334NsuFZ
         QQac5Fnt7PSEWOoAOt6dOcVXCJNIUpwUWeJqKM94MaQxMOzOChmLQsnPW23OVrJX5TZ8
         ybHjoVzqmczqt5pmbPRY78/bWMKkjW0kFT0EpOnFbhNgsUr/khDw4TZU1hPg/s30rFKz
         TkVgeSZuev0smUYPjZMO+rBIGQKxt/mZuW5DFaKdcT24wGqC+gy3ngSlfaLxuGnvgPU3
         s4nCyYbsyuz/oc96Ps/p5CeabtN7ap1Y9R5XSBZ6xqoMkBEfnAWGwYailszTURY178pF
         YwcQ==
X-Gm-Message-State: AO0yUKUhmHAOa4eDZLKI9Bs+PrXvxOZe1lovUcWBbVDb9rHP5ZF0xBYH
        Xu4Q9vlV84+sXX/fW/hmCy9uaeMbkB0=
X-Google-Smtp-Source: AK7set+T3V+JoyLjkC1wB/5qIdDzF62b7UTt81ngF/bZ+KGq7HO0b475fZgqRwLDPkif80j51AqtvEk7ZI4=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a17:90b:4f8d:b0:232:cc9a:db32 with SMTP id
 qe13-20020a17090b4f8d00b00232cc9adb32mr1774010pjb.94.1677025742780; Tue, 21
 Feb 2023 16:29:02 -0800 (PST)
Date:   Tue, 21 Feb 2023 16:29:01 -0800
In-Reply-To: <Y/AvSjsgLBWECLq2@google.com>
Mime-Version: 1.0
References: <20230217225449.811957-1-seanjc@google.com> <20230217225449.811957-3-seanjc@google.com>
 <Y/AvSjsgLBWECLq2@google.com>
Message-ID: <Y/VhzWCcC7LtGm4D@google.com>
Subject: Re: [PATCH 2/2] Documentation/process: Add a maintainer handbook for
 KVM x86
From:   Sean Christopherson <seanjc@google.com>
To:     Mingwei Zhang <mizhang@google.com>
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

On Sat, Feb 18, 2023, Mingwei Zhang wrote:
> On Fri, Feb 17, 2023, Sean Christopherson wrote:
> > +Coding Style
> > +~~~~~~~~~~~~
> > +When it comes to style, naming, patterns, etc., consistency is the number one
> > +priority in KVM x86.  If all else fails, match what already exists.
> > +
> > +With a few caveats listed below, follow the tip tree maintainers' preferred
> > +:ref:`maintainer-tip-coding-style`, as patches/series often touch both KVM and
> > +non-KVM x86 files, i.e. draw the attention of KVM *and* tip tree maintainers.
> > +
> > +Using reverse fir tree for variable declarations isn't strictly required,
> > +though it is still preferred.
> 
> What is the 'reverse fir tree'? Maybe, "Reverse Christmas Tree" is
> better to understand.

For some parts of the world, but not all.  For this, I want to follow whatever
description the tip tree uses, which as of today is "reverse fir tree", as this
is really a qualifier on the tip tree rules.
