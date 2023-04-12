Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 881E36DEBC2
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 08:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229699AbjDLGZ1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 02:25:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44504 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229549AbjDLGZX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 02:25:23 -0400
Received: from mail-qv1-xf36.google.com (mail-qv1-xf36.google.com [IPv6:2607:f8b0:4864:20::f36])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF1EC129;
        Tue, 11 Apr 2023 23:25:22 -0700 (PDT)
Received: by mail-qv1-xf36.google.com with SMTP id h14so222427qvr.7;
        Tue, 11 Apr 2023 23:25:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681280722; x=1683872722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=3XP1IEdAW1/2UUojFCGpGs+sDLAz3kCUnv2U6KCFQcc=;
        b=WBwQf1YgAoeklHXYHtSkJ12jBQ3EiYc46fuxlQcBL625G/RMZykzcB1sptjJZtPX8C
         Nm26WM5laj9xX+N7911d5BsAyKs12RnDKFc311OB7QQ5dxuUvSySzYcZ1x9nd/Muip4l
         yBhdI+wPay2vQX0bUeAwAsOvasJg4nUoJ6A6OaUKShceO2F+p5RQuqYbtHleUYrxWg79
         FvnWd9n0S2WKyKgzi5AAAhBSqb7tpcfc9oUWD8uK/Z3d9eaQqkkuhZKnUiMkedXhdDQO
         mvJTMGJkr2mk7JYhM3NWQIdmKEwWd2OQ9Sm1NMuEtaVzkh68BIJ81R9A00Cqz2Sz4p+h
         VmoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681280722; x=1683872722;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=3XP1IEdAW1/2UUojFCGpGs+sDLAz3kCUnv2U6KCFQcc=;
        b=JJU2gTd/aZICriCpBSo5EiBA9oHE7up3nhWsl0NG05QZJqi36LPS7wjfeuxnHNm3Xq
         BkE5w9BDWfa2rY6HMaErA8Q9a0XBy1aLT+VDKsRm3OxLgvgAtdblwsE2AkXOhRCE+mG2
         qgV2+Cfy5/jJE4GUPpD/kPSQcIEHpEtYhqTr1wx4ZHvoJ36ZeU0lPOS4Jq773+IvbZLH
         FRHmYFq40eCL++owAz91BKZ2+Pak/jtLYd+nhrjoho1+qM8teLsbcB0JndeV33sJ72L1
         LiIxRntit/oD+w5IlCJ+327venTsxBSZ9RS5aY5Br4cjCajtxJ8eVeHoCHya6d9amtmn
         kQjw==
X-Gm-Message-State: AAQBX9cxWoEBDvBHkKlsE8J6/ZeigXPUgsKsG9eIxPbAvgfL9lPVnNbX
        8sEoPl7zKhwe6LmEYMqnHizNEQMgq0g=
X-Google-Smtp-Source: AKy350ZaA8NH3A5LpJuiKElAGI50mB+Pfrmg9UDeloYZ3p3Ep37nh0sxUOu2azMRSkN9MG93ZSjmYw==
X-Received: by 2002:a05:6214:e6c:b0:5ed:90ce:ef28 with SMTP id jz12-20020a0562140e6c00b005ed90ceef28mr14313910qvb.39.1681280722005;
        Tue, 11 Apr 2023 23:25:22 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id t186-20020a3746c3000000b00746ae84ea6csm4472717qka.3.2023.04.11.23.25.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Apr 2023 23:25:21 -0700 (PDT)
Received: from compute3.internal (compute3.nyi.internal [10.202.2.43])
        by mailauth.nyi.internal (Postfix) with ESMTP id F389D27C0054;
        Wed, 12 Apr 2023 02:25:20 -0400 (EDT)
Received: from mailfrontend2 ([10.202.2.163])
  by compute3.internal (MEProxy); Wed, 12 Apr 2023 02:25:21 -0400
X-ME-Sender: <xms:0E42ZClr9zBKBCsC7HIlUTkcZluTvboOWBSSQaD-t0vwuOnb0DanlA>
    <xme:0E42ZJ2SYcMjuBSTUGqmUW-Pyyu2BQroqEaljKzbY5lTu2iJ4av04R9uwv2wVP6_c
    uKitNMemv-z2FgQkA>
X-ME-Received: <xmr:0E42ZArTYCAdWERIsQ0LedcPN1BQWa-oYgTMKWIJliR1WrMzDdzTcW38-F0y47Gx7jjShONmU8topD0OkciXU9Cs3hIGU80Z_fc>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvdekhedguddtkecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhephedugfduffffteeutddvheeuveelvdfhleelieevtdeguefhgeeuveei
    udffiedvnecuvehluhhsthgvrhfuihiivgeptdenucfrrghrrghmpehmrghilhhfrhhomh
    epsghoqhhunhdomhgvshhmthhprghuthhhphgvrhhsohhnrghlihhthidqieelvdeghedt
    ieegqddujeejkeehheehvddqsghoqhhunhdrfhgvnhhgpeepghhmrghilhdrtghomhesfh
    higihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:0E42ZGlD8ESz7MEJJpoJ5VM1YZ5HgMx0dyRsBOd6hC1xBSpfs_Bdig>
    <xmx:0E42ZA3O7KXAXHrzMRgFCJoBz2w5Q58SFhIoEtC-O5TTsnerQKVvkw>
    <xmx:0E42ZNsF1iEyBuBljAKqUK-p_n0rFcF1XSYXx70_ScX7Oai7JMPiMw>
    <xmx:0E42ZBKScpLTYoj2rChQZkNH6H1bea9bIUmi19vKu5z0Q4xHCqMbXA>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Wed,
 12 Apr 2023 02:25:20 -0400 (EDT)
Date:   Tue, 11 Apr 2023 23:25:19 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v4 11/13] rust: lock: add `Guard::do_unlocked`
Message-ID: <ZDZOzzMvvxr4rsW4@Boquns-Mac-mini.local>
References: <20230411054543.21278-1-wedsonaf@gmail.com>
 <20230411054543.21278-11-wedsonaf@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230411054543.21278-11-wedsonaf@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 11, 2023 at 02:45:41AM -0300, Wedson Almeida Filho wrote:
[...]
> +
> +    unsafe fn relock(ptr: *mut Self::State, guard_state: &mut Self::GuardState) {
> +        let _ = match guard_state {
> +            // SAFETY: The safety requiments of this function ensure that `ptr` has been
> +            // initialised.
> +            None => unsafe { Self::lock(ptr) },
> +            // SAFETY: The safety requiments of this function ensure that `ptr` has been
> +            // initialised.
> +            Some(_) => unsafe { Self::lock_irqsave(ptr) },
> +        };
> +    }
>  }
>  

One thing I'm little worried about the above is that we don't store back
the new GuardState into `guard_state`, the particular case I'm worried
about is as follow:

	// IRQ is enabled.
	// Disabling IRQ
	unsafe { bindings::local_irq_disable(); }

	let mut g = unsafe { SpinLockBackend::lock(&mut lock as *mut _) };
	// `g` records irq state is "irq disabled"

	unsafe { SpinLockBackend::unlock(&mut lock as *mut _, &g); }
	// restore into "irq disabled" mode.
	// IRQ is disabled.

	// Enabling IRQ
	unsafe { bindings::local_irq_enable(); }
	// IRQ is enabled.

	unsafe { SpinLockBackend::relock(&mut lock as *mut _, &mut g) }
	// `g` still records irq state is "irq disabled"

	unsafe { SpinLockBackend::unlock(&mut lock as *mut _, &g); }
	// restore into "irq disabled" mode.
	// IRQ is disabled.


This looks pretty scary to me, I would expect `relock()` updates the
latest GuardState to the guard. Any reason it's implemented this way?

Regards,
Boqun

>  // SAFETY: The underlying kernel `spinlock_t` object ensures mutual exclusion. We use the `irqsave`
>  // variant of the C lock acquisition functions to disable interrupts and retrieve the original
>  // interrupt state, and the `irqrestore` variant of the lock release functions to restore the state
>  // in `unlock` -- we use the guard context to determine which method was used to acquire the lock.
> -unsafe impl super::IrqSaveBackend for SpinLockBackend {
> +unsafe impl IrqSaveBackend for SpinLockBackend {
>      unsafe fn lock_irqsave(ptr: *mut Self::State) -> Self::GuardState {
>          // SAFETY: The safety requirements of this function ensure that `ptr` points to valid
>          // memory, and that it has been initialised before.
> -- 
> 2.34.1
> 
