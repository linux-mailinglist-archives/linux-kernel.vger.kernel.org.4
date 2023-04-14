Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AEBE26E22B1
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Apr 2023 13:55:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230167AbjDNLzF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Apr 2023 07:55:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229752AbjDNLzE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Apr 2023 07:55:04 -0400
Received: from out4-smtp.messagingengine.com (out4-smtp.messagingengine.com [66.111.4.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F71530FA;
        Fri, 14 Apr 2023 04:55:02 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailout.nyi.internal (Postfix) with ESMTP id 6CF745C0060;
        Fri, 14 Apr 2023 07:55:01 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute2.internal (MEProxy); Fri, 14 Apr 2023 07:55:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ryhl.io; h=cc:cc
        :content-transfer-encoding:content-type:content-type:date:date
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to; s=fm3; t=
        1681473301; x=1681559701; bh=2I4MzMrmxZMH1ZdqLmrFqtevk4RMUqxEQ3b
        kyYHe2wU=; b=Vyq2vmJcTpxKjTN6uQWHwHuka1/yjJcUNUecMDbRCmDy0AIPpgn
        RGo4jiyr2+uEW5m8kXyStOHZQqsHw9cwg/PWmrNjbLNizzj3ZkhPmqkviD8kedK+
        XcMyFdgOZLOY79y+/QOtpbsmaCQzLx3Czs2Bc4/8oByFhWrW7JvA6sE76+DzzXhA
        wgHOPqjXLQYW/6fnA6tlJW8ghq1DvhyjzeBmgwWla1wD2j2SGqjphzj+RG/exwB/
        DqjJ8pWCbzA98skxarxEcguhJ/nzMSQbXgJBVnrKcJTW0dVpUZWlg6J4ldjjQ+6L
        sIF0vauVFJha4FCVd/JpPY4mygnADnOdy9g==
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=
        messagingengine.com; h=cc:cc:content-transfer-encoding
        :content-type:content-type:date:date:feedback-id:feedback-id
        :from:from:in-reply-to:in-reply-to:message-id:mime-version
        :references:reply-to:sender:subject:subject:to:to:x-me-proxy
        :x-me-proxy:x-me-sender:x-me-sender:x-sasl-enc; s=fm3; t=
        1681473301; x=1681559701; bh=2I4MzMrmxZMH1ZdqLmrFqtevk4RMUqxEQ3b
        kyYHe2wU=; b=gOvywEzYW2kLxtKU6vBtR33APK/e2IMy7UOz0mzGhej4EC2LqG5
        E5RsPuNE1irskwS2RxdYxNcIYLwprWksj4GRXaxmt9z7qxxPYh+wRcva3vmMOamU
        t3XepIOpY6ZNbx8UgVnM6YB502BYhp6UL3wBSkYXNfGsuGnqVx90K7+1FzcwlPF2
        KPI+x/AVo9ivMivjKrfO6p96juiaLbo2uhu4g6TxNskFFPXYxuEfbQHdDGYS8wfk
        YwV8qTcW49oMT6R854QzNgz3wSXnzjTVdt0r36SwN9IzO6mXKu7qrqSnPRvHabRp
        Y/lorbdtkQnqZMpau6FVGVyCLnIHFa6Q0ng==
X-ME-Sender: <xms:FT85ZOMX6NVnh9l8MG-lHdl3fPAtJFj5VHCtbh8SefnupEn0d2OQAg>
    <xme:FT85ZM85gsCbScp3pjVJrWcNJMmQx4kTFlPzrj9oxGYEDNvMSuG04AlUVTAzVVJFg
    9KWxU_0WApfNG4xNA>
X-ME-Received: <xmr:FT85ZFTvlrs6ZyEnOWhyaglbeRS2TKxclyOFJXxBIzdvreAB8RKI827cpJbQzh1Vf5WV6N9-jgmTrdRQLt_zHtXtb2R8w-IKol2aeCJNHU8b>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdeltddggeegucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepkfffgggfuffvvehfhfgjtgfgsehtjeertddtfeejnecuhfhrohhmpeetlhhi
    tggvucfthihhlhcuoegrlhhitggvsehrhihhlhdrihhoqeenucggtffrrghtthgvrhhnpe
    ehudduvdetkedvkedtudeludfgfffhudegjeeguedvvedtteevjeehheeiffefgeenucev
    lhhushhtvghrufhiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegrlhhitggvse
    hrhihhlhdrihho
X-ME-Proxy: <xmx:FT85ZOvKnDiNZjuSE5VAK2IFEUOI709LOT22KmfKwENU32av1Vdmew>
    <xmx:FT85ZGdM-Q9Xjt3j3ImLNXt7c70ddiew1uG1JK7NvxrT176cqWfieQ>
    <xmx:FT85ZC2upAnlAxCACz_iQWi-HBn-6W_ASnxojg-j-MxECL1YA7GtVQ>
    <xmx:FT85ZM2yB6UGDV2T4WZwpiWE49voktYOMPXTYjlDXedL1H8q2q__6g>
Feedback-ID: i56684263:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 14 Apr 2023 07:54:57 -0400 (EDT)
Message-ID: <433dcb57-e5d6-bb2b-5c5a-74768cccecab@ryhl.io>
Date:   Fri, 14 Apr 2023 13:55:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v4 12/13] rust: sync: introduce `CondVar`
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
References: <20230411054543.21278-1-wedsonaf@gmail.com>
 <20230411054543.21278-12-wedsonaf@gmail.com>
Content-Language: en-US
From:   Alice Ryhl <alice@ryhl.io>
In-Reply-To: <20230411054543.21278-12-wedsonaf@gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/11/23 07:45, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This is the traditional condition variable or monitor synchronisation
> primitive. It is implemented with C's `wait_queue_head_t`.
> 
> It allows users to release a lock and go to sleep while guaranteeing
> that notifications won't be missed. This is achieved by enqueuing a wait
> entry before releasing the lock.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>

Reviewed-by: Alice Ryhl <aliceryhl@google.com>

I have a few methods below that the binder driver will need on the 
condvar. I'll let it be up to you whether you wish to include them in 
this patch. Otherwise, we will add them when we start upstreaming binder.

> +    /// Releases the lock and waits for a notification in interruptible mode.
> +    ///
> +    /// Atomically releases the given lock (whose ownership is proven by the guard) and puts the
> +    /// thread to sleep, reacquiring the lock on wake up. It wakes up when notified by
> +    /// [`CondVar::notify_one`] or [`CondVar::notify_all`], or when the thread receives a signal.
> +    /// It may also wake up spuriously.
> +    ///
> +    /// Returns whether there is a signal pending.
> +    #[must_use = "wait returns if a signal is pending, so the caller must check the return value"]
> +    pub fn wait<T: ?Sized, B: Backend>(&self, guard: &mut Guard<'_, T, B>) -> bool {
> +        self.wait_internal(bindings::TASK_INTERRUPTIBLE, guard);
> +        crate::current!().signal_pending()
> +    }

The binder driver will need a `wait_timeout` method.

> +    /// Calls the kernel function to notify the appropriate number of threads with the given flags.
> +    fn notify(&self, count: i32, flags: u32) {
> +        // SAFETY: `wait_list` points to valid memory.
> +        unsafe {
> +            bindings::__wake_up(
> +                self.wait_list.get(),
> +                bindings::TASK_NORMAL,
> +                count,
> +                flags as _,
> +            )
> +        };
> +    }
> +
> +    /// Wakes a single waiter up, if any.
> +    ///
> +    /// This is not 'sticky' in the sense that if no thread is waiting, the notification is lost
> +    /// completely (as opposed to automatically waking up the next waiter).
> +    pub fn notify_one(&self) {
> +        self.notify(1, 0);
> +    }
> +
> +    /// Wakes all waiters up, if any.
> +    ///
> +    /// This is not 'sticky' in the sense that if no thread is waiting, the notification is lost
> +    /// completely (as opposed to automatically waking up the next waiter).
> +    pub fn notify_all(&self) {
> +        self.notify(0, 0);
> +    }

Android binder will also need a `notify_sync` method. It could be 
implemented like this:

/// Calls the kernel function to notify one thread synchronously.
pub fn notify_sync(&self) {
     // SAFETY: `wait_list` points to valid memory.
     unsafe { bindings::__wake_up_sync(self.wait_list.get(), 
bindings::TASK_NORMAL) };
}
