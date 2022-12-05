Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0443C642ED6
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Dec 2022 18:32:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232261AbiLERc1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Dec 2022 12:32:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232033AbiLERcV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Dec 2022 12:32:21 -0500
Received: from mail-pg1-x52f.google.com (mail-pg1-x52f.google.com [IPv6:2607:f8b0:4864:20::52f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A0E2218A3
        for <linux-kernel@vger.kernel.org>; Mon,  5 Dec 2022 09:32:20 -0800 (PST)
Received: by mail-pg1-x52f.google.com with SMTP id 62so11068943pgb.13
        for <linux-kernel@vger.kernel.org>; Mon, 05 Dec 2022 09:32:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=wHyd9pKlC9WFHVrwobxVNYq4HVzMFaCc5ME41Vf/DS4=;
        b=tXcuoR9V6zHapsF2k42um/JNMg5G/jsVRshX0CWC9OKMH0uUifRsHiZ+sKnK1ucz6w
         DAr33L1RJNKC7+e0+y/DbbLxBAecH8KqhIcv5cUZQYBwSS+ccmEIQf4CuAa1kXy2DMw3
         SGtsVwaJLyUqmpYhTVg7S8pNptpBQgXO0oYo7ewY847llU0O9xki8GgL+GJmrOJ9+qy3
         Y67t3ex8vH4gDG+Oy4Jrwld+9WhaqXTPbka9JVSf9t3cA98+MEDa3rQZUrBeHq6C8nre
         1V8Q2UZ7oS3aHfTjlFWNv3n4KMWIKpCO9X2SpCm/g780PnpERu52pGZA4g0nhuklu4ig
         oRBA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=wHyd9pKlC9WFHVrwobxVNYq4HVzMFaCc5ME41Vf/DS4=;
        b=iCnHFSTitXrOyjiDWl/sSjiH6s9n/DzjstwWeJ2tDehxkn+NWZmytk2oPV4iMKjuJa
         mJTrIaJmytxYZR83Uhko+HiXLELINIaQ9TPRGrwKNzGdUEQTqho3Ku9ulmyhS8zid6Kw
         SuoaP0Jcw2DzrV//5Ad1bxywmPgQSF0K6F7ZKRY+Iw+oki5Aii7TXHZYwUXghl4QzHW3
         D2A/PmTXvF5qA7zLNF+TGklDlWDQlTI45oOGjqHV8VYcsQKvPkcpaCG+RDTZifoB77hN
         cz6tyBDMAh48pPi258i+WtM/9X+C/Al+leRQLDnEw9KABqL5qYktlxt8SuulhWF73Wza
         AiZw==
X-Gm-Message-State: ANoB5pkEIeb01AyXdL/NS5TF4bom5y8XxqGxc8agARMYsVvpfXeSfwV3
        NlDEwOg0CYRG/5RDbNJdcD2k4g==
X-Google-Smtp-Source: AA0mqf5H6RmfXNSGuyQNg+3Xbnn5UEmDXz9z1UaDNDohTKkpmd3glPZwK/n7+3IkNQFbXk6SVJX+RQ==
X-Received: by 2002:a63:1747:0:b0:478:1391:fd14 with SMTP id 7-20020a631747000000b004781391fd14mr35684881pgx.112.1670261539381;
        Mon, 05 Dec 2022 09:32:19 -0800 (PST)
Received: from google.com (7.104.168.34.bc.googleusercontent.com. [34.168.104.7])
        by smtp.gmail.com with ESMTPSA id s4-20020a17090a764400b0020087d7e778sm11218083pjl.37.2022.12.05.09.32.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Dec 2022 09:32:18 -0800 (PST)
Date:   Mon, 5 Dec 2022 17:32:14 +0000
From:   Sean Christopherson <seanjc@google.com>
To:     kernel test robot <oliver.sang@intel.com>
Cc:     Maxim Levitsky <mlevitsk@redhat.com>, oe-lkp@lists.linux.dev,
        lkp@intel.com, Paolo Bonzini <pbonzini@redhat.com>,
        linux-kernel@vger.kernel.org, kvm@vger.kernel.org,
        xudong.hao@intel.com
Subject: Re: [linus:master] [KVM]  92e7d5c83a:
 kernel-selftests.kvm.triple_fault_event_test.fail
Message-ID: <Y44rHsJU9OdkxCHA@google.com>
References: <202212032146.b0347c81-oliver.sang@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202212032146.b0347c81-oliver.sang@intel.com>
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022, kernel test robot wrote:
> 
> Greeting,
> 
> FYI, we noticed kernel-selftests.kvm.triple_fault_event_test.fail due to commit (built with gcc-11):
> 
> commit: 92e7d5c83aff124f49082585e57939ed24b59c5c ("KVM: x86: allow L1 to not intercept triple fault")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master

Should already be fixed.  Thanks!

commit df0bb47baa95aad133820b149851d5b94cbc6790
Author: Paolo Bonzini <pbonzini@redhat.com>
Date:   Wed Nov 30 11:14:35 2022 -0500

    KVM: x86: fix uninitialized variable use on KVM_REQ_TRIPLE_FAULT
    
    If a triple fault was fixed by kvm_x86_ops.nested_ops->triple_fault (by
    turning it into a vmexit), there is no need to leave vcpu_enter_guest().
    Any vcpu->requests will be caught later before the actual vmentry,
    and in fact vcpu_enter_guest() was not initializing the "r" variable.
    Depending on the compiler's whims, this could cause the
    x86_64/triple_fault_event_test test to fail.
    
    Cc: Maxim Levitsky <mlevitsk@redhat.com>
    Fixes: 92e7d5c83aff ("KVM: x86: allow L1 to not intercept triple fault")
    Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
