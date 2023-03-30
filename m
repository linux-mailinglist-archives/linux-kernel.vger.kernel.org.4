Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 217516D08E5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Mar 2023 16:57:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232585AbjC3O5R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Mar 2023 10:57:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232664AbjC3O5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Mar 2023 10:57:04 -0400
Received: from mail-ot1-x334.google.com (mail-ot1-x334.google.com [IPv6:2607:f8b0:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD40ECDCF;
        Thu, 30 Mar 2023 07:56:44 -0700 (PDT)
Received: by mail-ot1-x334.google.com with SMTP id f4-20020a9d0384000000b0069fab3f4cafso10127624otf.9;
        Thu, 30 Mar 2023 07:56:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680188202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=33ML0sCiZsmNYfIFvzdCr7eA6//B/DCyhkc4DfMG7yU=;
        b=hhjyyGJ5Z0Z9yX+gD6bwCy3N0MKqvKQvuAKssumxFM6eTwIyp5Oo20vI2M48SmAnwc
         OGKJJ/EKx/osI6bXWGgXsawSSeJI/xNBk826LDFym/449NtzxHgDgQx+v+7YHl6taobR
         w8gR5lsLuk+8uf+VTcf7e4kiGKagtMAIUdnouhZuFSljwm3XZN2Y3iEpAfiJIxfW5Umi
         aV2I3c8AbUY8F8ZodWmx3LMt7RmTkOJbtjpS/kUd2Yk4xr5KGrhRfYVoAGX3nhWgGwpc
         sPFJ4vnxIIvmQOrxFf3TWPxwIsNH6ZT7vJZQNEhhiYn2p+POO94/i1Q7myXLnWb+ya92
         b6Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680188202;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=33ML0sCiZsmNYfIFvzdCr7eA6//B/DCyhkc4DfMG7yU=;
        b=4Wn88KRGra19tiC5KTWra5EMvKefIEqVNEbo7uxVVDsHJgGF1x/kd8jjf36qQApB9J
         PRLDYvdpQywLLIS8L+KBqt3P4ti41Vhu79crhJx8J8S8epnbf8HCgwJAoF72b/B3EV6s
         ZBWV7a0006f6iCyUXcOSrApZ0k7epwXTv4npZdcapMwQYFZ5nHLxyD5pXXWHQY6DClkD
         QCjMqSyoWLFAAvrcRR7C2fOMak6cp+mxATolFbwVQXMTsDPGSxyrkHmFCWrCan2Gr4gH
         LKo9lvmGaeUr1V8fDqTKzEyjyVVaE8rpCVNEe/kipcs/KANG0Px97ft5tM0nEpZjVOT9
         c+mw==
X-Gm-Message-State: AAQBX9fGJITOspvkhMYf7A0KP7W5pD2kA7PpdBxwYJJqkGPikbEg0J6J
        wKgr9A0ZuzG3sk8P9GeLJGo=
X-Google-Smtp-Source: AKy350YMbqNcniqsqDGNpoQIaqTLdf6LjevJjKOilBkazQbxdkPIpJF6FeKur4gcsonWQu9dRqAzyA==
X-Received: by 2002:a05:6830:1644:b0:6a1:7eaa:3836 with SMTP id h4-20020a056830164400b006a17eaa3836mr591188otr.5.1680188202533;
        Thu, 30 Mar 2023 07:56:42 -0700 (PDT)
Received: from wedsonaf-dev ([189.124.190.154])
        by smtp.gmail.com with ESMTPSA id d11-20020a05683018eb00b0069f1774cde8sm8625555otf.71.2023.03.30.07.56.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Mar 2023 07:56:42 -0700 (PDT)
Date:   Thu, 30 Mar 2023 11:56:33 -0300
From:   Wedson Almeida Filho <wedsonaf@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
Subject: Re: [PATCH 12/13] rust: sync: introduce `CondVar`
Message-ID: <ZCWjIaByRHDhdCud@wedsonaf-dev>
References: <20230330043954.562237-1-wedsonaf@gmail.com>
 <20230330043954.562237-12-wedsonaf@gmail.com>
 <20230330125927.GD124812@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230330125927.GD124812@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 02:59:27PM +0200, Peter Zijlstra wrote:
> On Thu, Mar 30, 2023 at 01:39:53AM -0300, Wedson Almeida Filho wrote:
> 
> > +    fn wait_internal<T: ?Sized, B: Backend>(&self, wait_state: u32, guard: &mut Guard<'_, T, B>) {
> > +        let wait = Opaque::<bindings::wait_queue_entry>::uninit();
> > +
> > +        // SAFETY: `wait` points to valid memory.
> > +        unsafe { bindings::init_wait(wait.get()) };
> > +
> > +        // SAFETY: Both `wait` and `wait_list` point to valid memory.
> > +        unsafe {
> > +            bindings::prepare_to_wait_exclusive(self.wait_list.get(), wait.get(), wait_state as _)
> > +        };
> 
> I can't read this rust gunk, but where is the condition test gone?
> 
> Also, where is the loop gone to?

They're both at the caller. The usage of condition variables is something like:

while guard.value != v {
    condvar.wait_uninterruptible(&mut guard);
}

(Note that this is not specific to the kernel or to Rust: this is how condvars
work in general. You'll find this in any textbook on the topic.)

In the implementation of wait_internal(), we add the local wait entry to the
wait queue _before_ releasing the lock (i.e., before the test result can
change), so we guarantee that we don't miss wake up attempts.

Thanks,
-Wedson
