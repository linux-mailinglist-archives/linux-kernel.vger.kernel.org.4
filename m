Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 944616A1157
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 21:41:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229733AbjBWUld (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 15:41:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57880 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229767AbjBWUlb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 15:41:31 -0500
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01E3E3A851
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 12:41:31 -0800 (PST)
Received: by mail-pl1-x649.google.com with SMTP id j18-20020a170903025200b00198aa765a9dso5799303plh.6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 12:41:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=D/hhXU94L2G+o7ni2sDclregaJFv4BLuQx95BPp9z9Q=;
        b=YQfRQnO25BKO39Nxje2Nn6hZ6jXQlJ8bqpj5AoIHX05ecsqHGgjjChBmaD0XLaItjE
         PXJT2+TsGB98yz3x92aEOECz1JaMKfBPlSkSXysVvcWmJeO09X9G0XV6Ll7mw0xgH4nW
         fbXSXnNa78ogHg6PBmj0u1NyTAJtxuovyZATBkwrwsQ8s058xJyyHLk2bq9hwAnOUzgL
         Onys3TIuniC494ZrjeT9Tme0TmWlLs76ORoKYVHm2jKYixBYSV5rd/CS5KKdqUA58jms
         cDFaz7TxdBxYjlD88mrCw+pj129APBZ+kXA8oQsgHafwBApprWz71QVoE7+NatQo+r+u
         xcSA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D/hhXU94L2G+o7ni2sDclregaJFv4BLuQx95BPp9z9Q=;
        b=zwZZAzGvZC/UcOajTo7BqcYmZfy8fm9Q+RZLIZdRQbER+nMq6FiieeI2Y2LL1bXwp7
         wlSh2x6AAMRhsD9I3ankYMXT+Od40PfsAWQ10SvDnTS4esztNgLS2iNmTeMd4N0GcW5j
         GCOZ9uEmGlxYscqXsIEGeM0nLGAyndKp/84+X5HMboflH3HKf73vortuwmHernvzxyqf
         NTRQAask592Iyp5b5oFDCgHlIlTwGhcC9N4eWtAtee5O9wX6i28/KhiM1aKyLAcEQvA4
         UKtAIvj4T8fNuxQnyRrYhjQBPsaeeriAy5wv6CKskdACaGwzRhSA7RXxAQj87Gt55onn
         c5jA==
X-Gm-Message-State: AO0yUKUnQISHYz21Uq9fHkFNB/2iAJIQKFtmKmmQIC3nNVR0r1KnUP9A
        sY/og9FZx98NQLahvGB4SYI8B/oU5Kc=
X-Google-Smtp-Source: AK7set/Gpi+RQeieEV9ujOdy38fte0Fs3U+Hmys352Tw5nImTosFAyGyPz7wmFlQqa937PsGveMF+hUxsR0=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a63:7a54:0:b0:4fb:3896:a7d4 with SMTP id
 j20-20020a637a54000000b004fb3896a7d4mr1948195pgn.7.1677184890247; Thu, 23 Feb
 2023 12:41:30 -0800 (PST)
Date:   Thu, 23 Feb 2023 12:41:28 -0800
In-Reply-To: <Y8jUom2voLubfqxE@yzhao56-desk.sh.intel.com>
Mime-Version: 1.0
References: <Y6vXTcxDNovrmeVB@yzhao56-desk.sh.intel.com> <Y7SaklDQD0EoIs8l@google.com>
 <Y7Y+759IN2DH5h3h@yzhao56-desk.sh.intel.com> <Y7cLkLUMCy+XLRwm@google.com>
 <Y7e3fT8/V2NoXAUP@yzhao56-desk.sh.intel.com> <Y7ioYegkgKIH8uJL@google.com>
 <Y7vlOCKkJ+QyO3EM@yzhao56-desk.sh.intel.com> <Y773+EB35bAchVTC@google.com>
 <Y8ix4lqk8QYH4g3h@zhen-hp.sh.intel.com> <Y8jUom2voLubfqxE@yzhao56-desk.sh.intel.com>
Message-ID: <Y/fPePRoP6sOiD14@google.com>
Subject: Re: [PATCH 03/27] drm/i915/gvt: Incorporate KVM memslot info into
 check for 2MiB GTT entry
From:   Sean Christopherson <seanjc@google.com>
To:     Yan Zhao <yan.y.zhao@intel.com>
Cc:     Zhenyu Wang <zhenyuw@linux.intel.com>, kvm@vger.kernel.org,
        intel-gfx@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        Ben Gardon <bgardon@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        intel-gvt-dev@lists.freedesktop.org,
        Zhi Wang <zhi.a.wang@intel.com>
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

Apologies for the super slow reply, I put this series on the backburner while I
caught up on other stuff and completely missed your questions.

On Thu, Jan 19, 2023, Yan Zhao wrote:
> On Thu, Jan 19, 2023 at 10:58:42AM +0800, Zhenyu Wang wrote:
> > Current KVMGT usage is mostly in controlled mode, either user is own host admin,
> > or host admin would pre-configure specific limited number of VMs for KVMGT use.
> > I think printk on error should be fine, we don't need rate limit, and adding
> > extra trace monitor for admin might not be necessary. So I'm towards to keep to
> > use current error message.
> > 
> 
> Thanks, Sean and Zhenyu.
> So, could I just post the final fix as below?

No objection here.

> And, Sean, would you like to include it in this series or should I send it out
> first?

I'd like to include it in this series as it's necessary (for some definitions of
necessary) to clean up KVM's APIs, and the main benefactor is KVM, i.e. getting
the patch merged sooner than later doesn't really benefit KVMGT itself.

Thanks much!
