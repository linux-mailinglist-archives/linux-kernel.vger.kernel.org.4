Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1E39F6C1BAE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Mar 2023 17:32:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232033AbjCTQcB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Mar 2023 12:32:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232008AbjCTQbj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Mar 2023 12:31:39 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D0E41B2EC
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:24:25 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id e8-20020a17090a118800b0023d35ae431eso4285003pja.8
        for <linux-kernel@vger.kernel.org>; Mon, 20 Mar 2023 09:24:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112; t=1679329465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:from:to:cc:subject:date:message-id:reply-to;
        bh=aVYMsUe392bOA51AaoYinxkg/ZveVBCWl2uURIaoZUU=;
        b=U++x0RG2aQLbQMI+FZObbfICiQioNipfz53TOkUdevZvfpZuOa5qEQbovybb+DF6Yy
         2+b2YFT1TvrrzI6Xgh0byuCKWVeuWWSyq3qEcGA0O1tVYeHXE011kIzdh0c65SvSsT8B
         DPzWShnEyF3wF06wJRVnmt4HyeCJ65bm8JYx/tNzNfjlNAIoN88WAWwrwBhKgAydZFXK
         ETzlYD/fCphCSmsvjNNvMwIKetngDZ0R0fmxMsRnFjgz2wWI0aDRrvIUV1aO5yyFM/4+
         3tb2rBO3bIg+lnWlakzLfUgke4YWxkyaVK9d8Ds5ea8KRpYlwUQ3esLBLcm+oHULqPDO
         FPuQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679329465;
        h=cc:to:from:subject:message-id:references:mime-version:in-reply-to
         :date:x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=aVYMsUe392bOA51AaoYinxkg/ZveVBCWl2uURIaoZUU=;
        b=POGfaYhMP0EFu6GeOWOGoxKe3I+kCqMQPTtz2Ye+HiawuphOPmLsD/5wgyv/f23JvT
         naHscNeQSe/hLs8ohwgndLzc47ENLTWBPiha2p8apfFOPadAHw92vtz5PyjsDfFy5oFX
         hRfd+qdNDZ3FcghwO++Wc4oauEtl8gm/xi1mpYigQunXQG9GyK41b+QtoATsk9z6/Nw8
         4kHmrfkp/vyYFeK5B9TRqKOuCBvmj63Ef6k4jEfbVhL1/9813P2uhA2mYaxWp8PB6fVt
         CrPSHI9xlCtSSJ1YCNsrjjip7KR4v+dLTuE7zF7fiNMJDUg71pW0odrO+2FxU1HMire9
         81jg==
X-Gm-Message-State: AO0yUKWqcEhLZV9J4VZBDsC+ueCZQk6Niu6wlK87MHzpc1ZcBGWt6Vbw
        RS2mZzeFuArJGMKSoNHJgBJWOWN6UHo=
X-Google-Smtp-Source: AK7set9Dz5tG1ZIPCM3pJnvPFABnvcgBw4GGwXpg+AprPTddlLwNkv9e6+wqSREbZn0nDbHJnaz2viPUmNQ=
X-Received: from zagreus.c.googlers.com ([fda3:e722:ac3:cc00:7f:e700:c0a8:5c37])
 (user=seanjc job=sendgmr) by 2002:a05:6a00:2d0e:b0:625:dc5b:9d1d with SMTP id
 fa14-20020a056a002d0e00b00625dc5b9d1dmr8347160pfb.0.1679329464895; Mon, 20
 Mar 2023 09:24:24 -0700 (PDT)
Date:   Mon, 20 Mar 2023 09:24:23 -0700
In-Reply-To: <301c7527-6319-b993-f43f-dc61b9af4b34@redhat.com>
Mime-Version: 1.0
References: <20230201132905.549148-1-eesposit@redhat.com> <20230201132905.549148-2-eesposit@redhat.com>
 <20230317190432.GA863767@dev-arch.thelio-3990X> <20230317225345.z5chlrursjfbz52o@desk>
 <20230317231401.GA4100817@dev-arch.thelio-3990X> <20230317235959.buk3y25iwllscrbe@desk>
 <ZBhzhPDk+EV1zRf0@google.com> <301c7527-6319-b993-f43f-dc61b9af4b34@redhat.com>
Message-ID: <ZBiIt2LBoogxQ2jP@google.com>
Subject: Re: [PATCH 1/3] kvm: vmx: Add IA32_FLUSH_CMD guest support
From:   Sean Christopherson <seanjc@google.com>
To:     Emanuele Giuseppe Esposito <eesposit@redhat.com>
Cc:     Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Nathan Chancellor <nathan@kernel.org>, kvm@vger.kernel.org,
        Jim Mattson <jmattson@google.com>,
        Ben Serebrin <serebrin@google.com>,
        Peter Shier <pshier@google.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Maxim Levitsky <mlevitsk@redhat.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>, linux-kernel@vger.kernel.org
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

On Mon, Mar 20, 2023, Emanuele Giuseppe Esposito wrote:
> 
> Am 20/03/2023 um 15:53 schrieb Sean Christopherson:
> > The patches obviously weren't tested,
> Well... no. They were tested. Call it wrongly tested, badly tested,
> whatever you want but don't say "obviously weren't tested".

Heh, depends on how you define "tested".  I was defining tested as "tested to
work as expected on systems with and without support for IA32_FLUSH_CMD".

But yeah, I should have said "properly tested".

> I even asked you in a private email why the cpu flag was visible in Linux and
> not in rhel when using the same machine.
>
> So again, my bad with these patches, I sincerely apologize but I would
> prefer that you think I don't know how to test this stuff rather than
> say that I carelessly sent something without checking :)

I didn't intend to imply that you didn't try to do the right thing, nor am I
unhappy with you personally.  My apologies if my response came off that way.

What I am most grumpy about is that this series was queued without tests.  E.g.
unless there's a subtlety I'm missing, a very basic KVM-Unit-Test to verify that
the guest can write MSR_IA32_FLUSH_CMD with L1D_FLUSH when the MSR is supported
would have caught this bug.  One of the reasons for requiring actual testcases is
that dedicated testcases reduce the probability of "testing gone wrong", e.g. a
TEST_SKIPPED would have alerted you that the KVM code wasn't actually being exercised.
