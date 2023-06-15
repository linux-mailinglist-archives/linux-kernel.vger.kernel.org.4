Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78EB17323FB
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 01:58:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240517AbjFOX6a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 19:58:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240466AbjFOX63 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 19:58:29 -0400
Received: from mail-yw1-x114a.google.com (mail-yw1-x114a.google.com [IPv6:2607:f8b0:4864:20::114a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 188CC2953
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:58:25 -0700 (PDT)
Received: by mail-yw1-x114a.google.com with SMTP id 00721157ae682-5701b4d6ef3so3280387b3.3
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 16:58:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20221208; t=1686873504; x=1689465504;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=2JGwGtheDvdmEXVQOAzwkfJJFvQFel3N1nvsrUgeg4s=;
        b=a5V6Bi5+LUPhGmMSNZrYUe+i0L1wJvkbBKVigdOLfXgL0KyvgOZWaF6We0NSwhbHqM
         DXtSsa93RR62HXCouDZLPn7jArxyx6Fq1Y/clmFYbtBjTa1/8pNyObKMiseGIIu4XUAd
         S+9isvOilL94TfazUNQ2L80sY1HvjN+iihhGDLd9jXveyd8EU+Srl3LD/QA0zyG9h4ZS
         lVDlHuIYazBj7dRx32X7ejvY2ZRkKl/TO79CzWDPgQR0dUfGGeta3cxD/A/5SD8Onq7m
         C9X+xei/T1tWPby9cphRz5f5ThvM0hJZKpUZbelbDeAQSDFmEwuNvGtYzpnGzP1cMe/R
         lIMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686873504; x=1689465504;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=2JGwGtheDvdmEXVQOAzwkfJJFvQFel3N1nvsrUgeg4s=;
        b=W9EHaNCh3hRxUuZKWJjloFw84cBWOhwrV7kA4flMXzZApWJvnKAo1nKLjKdWQ7tV0d
         AM8crfgzT050bZTVLT+4dYh74KYaJ+RbGucLAlFCMOkeFnp3esdHUy49jllIAh8cmneP
         IKwN27ruH5i4+ezeJ8ETO2+QAXWtrMehtcfkMun64MDASn5jelOAPbfF88MA/jRv4898
         qLxg3L0tQjxYA8UiCXor6edSyDnDY4s0dDMB9KedM7gH8xcW9l91rBVkzrmzsjCvnSK5
         k8SVrNTn87DP2EaD4SFgNI0ZqsdQHKjZqmQVsetz4J+4H0s6WfD3TavIiugNuK9strc2
         /kCg==
X-Gm-Message-State: AC+VfDy67xGJphc4cQ5YbkkWLrPVdnqx5NkF9N1CEPBZlHkwRwDQsPff
        FkTrU1kFEJeH1RQ4H+rW17m/o4+d6w8=
X-Google-Smtp-Source: ACHHUZ7TA6PXDTpUy7HtrcTo7V2uQ3JKd/mX2ALr2Y51CEQmm/8kPRKkJw/mBHOmKhj8bOGphsr0zC+58YY=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a81:9f0a:0:b0:56c:e2da:f440 with SMTP id
 s10-20020a819f0a000000b0056ce2daf440mr137130ywn.0.1686873504196; Thu, 15 Jun
 2023 16:58:24 -0700 (PDT)
Date:   Thu, 15 Jun 2023 16:58:22 -0700
In-Reply-To: <21568052-eb0f-a8d6-5225-3b422e9470e9@intel.com>
Mime-Version: 1.0
References: <20230511040857.6094-1-weijiang.yang@intel.com>
 <20230511040857.6094-11-weijiang.yang@intel.com> <ZH73kDx6VCaBFiyh@chao-email>
 <21568052-eb0f-a8d6-5225-3b422e9470e9@intel.com>
Message-ID: <ZIulniryqlj0hLnt@google.com>
Subject: Re: [PATCH v3 10/21] KVM:x86: Add #CP support in guest exception classification
From:   Sean Christopherson <seanjc@google.com>
To:     Weijiang Yang <weijiang.yang@intel.com>
Cc:     Chao Gao <chao.gao@intel.com>, pbonzini@redhat.com,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        peterz@infradead.org, rppt@kernel.org, binbin.wu@linux.intel.com,
        rick.p.edgecombe@intel.com, john.allen@amd.com
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

On Thu, Jun 08, 2023, Weijiang Yang wrote:
> 
> On 6/6/2023 5:08 PM, Chao Gao wrote:
> > On Thu, May 11, 2023 at 12:08:46AM -0400, Yang Weijiang wrote:
> > > Add handling for Control Protection (#CP) exceptions(vector 21).
> > > The new vector is introduced for Intel's Control-Flow Enforcement
> > > Technology (CET) relevant violation cases.
> > > 
> > > Although #CP belongs contributory exception class, but the actual
> > > effect is conditional on CET being exposed to guest. If CET is not
> > > available to guest, #CP falls back to non-contributory and doesn't
> > > have an error code.
> > This sounds weird. is this the hardware behavior? If yes, could you
> > point us to where this behavior is documented?
> 
> It's not SDM documented behavior.

The #CP behavior needs to be documented.  Please pester whoever you need to in
order to make that happen.
