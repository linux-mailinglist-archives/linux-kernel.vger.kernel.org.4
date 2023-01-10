Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF313664E1D
	for <lists+linux-kernel@lfdr.de>; Tue, 10 Jan 2023 22:37:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231939AbjAJVhu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 Jan 2023 16:37:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbjAJVhs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Jan 2023 16:37:48 -0500
Received: from mail-vs1-xe2b.google.com (mail-vs1-xe2b.google.com [IPv6:2607:f8b0:4864:20::e2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DD47CA;
        Tue, 10 Jan 2023 13:37:47 -0800 (PST)
Received: by mail-vs1-xe2b.google.com with SMTP id v127so9351565vsb.12;
        Tue, 10 Jan 2023 13:37:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=LYm70hZF7lxX+Iq4fbX4lv7bXwpjZT1o5KlvitZ5mkA=;
        b=VbXb0baYdAPvzDR/DPknNiSqyZqoeY7d6/BdSO99h5gwYo15B2g/t9RuF+k53+0G6p
         csetOhRnW7RiQrMXMo5dOM8sDQ6REMA/sFCcq068y4YzGvfvSzB1F2WcHSAri4Lem1pJ
         zGX1wcS1Ce4umVl/eQkFnmescmTUPZLqTyG23ZVF1IoUY/tdAG4dDPWK9CarCS7X5aMT
         fY7WV8rsbOVMiKHSrSZor59VqhS+xp+ng8tq9mhm7bzKmXmOz36n+JWtp0ZIZIWnmA4G
         3pvZ+PPrid1rD8Lml0ldGXomxTAiBLRrEiQ45d8LCCqC5XtACjT5ffSYG1FR5QggUcWU
         A54Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=LYm70hZF7lxX+Iq4fbX4lv7bXwpjZT1o5KlvitZ5mkA=;
        b=PE8N5fERQq4jSEqLMNgnVv15rPWSqoKI7xlbZwjkDmIRqoHDPwbmT46fCYi9rMyAHi
         B7FcTY8NCsyTp7+fxVOy1NhaKyd0x9Uk0WPMf4HZb7cW2vON3rUemWSrshB47QKLUIlg
         vJhUhepVPyw+Fbzo6qCg+Kfjg7psJVqg35oqkFWhdYeJRNMFpSZzh+cJFgnhtjhwu0OT
         lPpoomjnYYoDV/ox6T54PJclILACyVhibuOr6PBfW6SWaBAquc2okgN/e0LeTPXsSXA+
         JJ6K9xhh4Dx/UlouHhzmiX7yVQTET0so82UGbSr8QdiJiVNrMS0tZ7voscDSRz30VmBO
         Pq/g==
X-Gm-Message-State: AFqh2kpYbgO//jVytV1mOL821RQM+MRoc9lxnl7LdWTqRJWK6Gkwzj68
        8A/oVZYTbx0OCqUyuYs46VUUqRDM6NM=
X-Google-Smtp-Source: AMrXdXsw7isMHomtF9IR1JW7RUzX/p/VHzQEi2sCl62Xn4+Jp+7E6uD37nXXKq1mnik0+2YN2yAf/Q==
X-Received: by 2002:a05:6102:dd0:b0:3aa:8a33:ce9f with SMTP id e16-20020a0561020dd000b003aa8a33ce9fmr47022022vst.3.1673386666651;
        Tue, 10 Jan 2023 13:37:46 -0800 (PST)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id ay40-20020a05620a17a800b006f956766f76sm7776264qkb.1.2023.01.10.13.37.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Jan 2023 13:37:46 -0800 (PST)
Received: from compute6.internal (compute6.nyi.internal [10.202.2.47])
        by mailauth.nyi.internal (Postfix) with ESMTP id 9332327C005A;
        Tue, 10 Jan 2023 16:37:45 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute6.internal (MEProxy); Tue, 10 Jan 2023 16:37:45 -0500
X-ME-Sender: <xms:qNq9Y-Ym01O_jxxdWLmaic8yeiIYEGryH51H7Iw4qbUFyCPu0xtE0w>
    <xme:qNq9YxZQ2P1JukXDze22NEB5_SKoC-ExBrhHsnCuiWsvrFqqRMnGm3yiuPMJZq0qY
    2HtJmYSwersA7Ge-Q>
X-ME-Received: <xmr:qNq9Y481tkw79ZLw3VStGAG3n7d96L0sXKa0SZX0KrAjcFR0ohorF7bLRew>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrledvgdeltdcutefuodetggdotefrodftvf
    curfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfghnecu
    uegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmdenuc
    fjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhquhhn
    ucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrfgrth
    htvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveeiudff
    iedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomhepsg
    hoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedtieeg
    qddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfhhigi
    hmvgdrnhgrmhgv
X-ME-Proxy: <xmx:qNq9Ywq0agRD-3YYiN-Y0ljh_uxb554zJar9sVnYoToqOplSzC8V5w>
    <xmx:qNq9Y5poq6CwLDmK-MEIMq7jHwxWcjqVMR1krTCfd5Ef6qf1g6jwuA>
    <xmx:qNq9Y-SB1ONmkeQP-8PVGR-GPcTonot2HdWX1XMatX2NDLbS6YMPtA>
    <xmx:qdq9Y03rHGbEWaJcuCihQ2CP_5F1omfYWbAPk5DI60f0SlqXBaScuA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Tue,
 10 Jan 2023 16:37:44 -0500 (EST)
Date:   Tue, 10 Jan 2023 13:36:25 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: Re: [PATCH 1/7] rust: sync: add `Arc` for ref-counted allocations
Message-ID: <Y73aWaJ8gVHsG/Uq@boqun-archlinux>
References: <20221228060346.352362-1-wedsonaf@gmail.com>
 <Y73JF1rvF/No/JRi@boqun-archlinux>
 <Y73WsvEEIS0jHlVb@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y73WsvEEIS0jHlVb@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 10, 2023 at 10:20:50PM +0100, Peter Zijlstra wrote:
> On Tue, Jan 10, 2023 at 12:22:47PM -0800, Boqun Feng wrote:
> 
> > First, I'd really appreciate it that Will, Peter or Mark can take a look
> > at the series and see if they are happy or not ;-)
> 
> I only have 1 patch, and since I don't speak rust I have very limited
> feedback. Having to use out-of-line functions seems sub-optimal, but
> I suppose that's a limitation of the Rust-C bindings.
> 
> Afaict this is like C++ shared_ptr<> and using refcount_t seems okay for
> that, not sure what else you're asking.
> 

Thanks! I failed to find that you were only Cc for the first patch.. I
cannot speak for Wedson, but the rest of the patchset are all based on
the first patch and purely in Rust, maybe he was avoiding to "spam" your
inbox ;-)

While we are at it, for a general case, say we provide Rust's interface
of task/kthread managament, do you prefer to seeing the whole patchset
(including how Rust side provides the APIs) or seeing only the patch
that interacts with C?

Again, trying to find the sweet spot for collaboration ;-)

Regards,
Boqun
