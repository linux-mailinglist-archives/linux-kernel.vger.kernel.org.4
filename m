Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C4A8722AFA
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 17:26:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233898AbjFEP0P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 11:26:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233691AbjFEP0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 11:26:13 -0400
Received: from mail-qv1-xf2f.google.com (mail-qv1-xf2f.google.com [IPv6:2607:f8b0:4864:20::f2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 424DED2;
        Mon,  5 Jun 2023 08:26:09 -0700 (PDT)
Received: by mail-qv1-xf2f.google.com with SMTP id 6a1803df08f44-6261cb1208eso34291456d6.0;
        Mon, 05 Jun 2023 08:26:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685978768; x=1688570768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+eTZJaesQgEddfhUw6/wmzf8jeBxuOms7oai97sQq2k=;
        b=NHZtSRQ5uU4okMdEGz/dEAMNO96gXzngsu05M1NcMhqGCbTngUE/ZJ958d1h1OJqv2
         N6x/RSWGDm/fMJ86LJpVUB9GJ3jcK+V91MPWbMv3ciUgsk7O+ren3Wiwn0egy0a2kngu
         zg6pPpIcTw1QdC+r8QIEsdG/lll2wY22o/Hj05VWQM50PSNZQsStuo+VwNVLLGPYCr+g
         jjLfg9FZGJWiFOQyqtvK6qw2ooZT/3FGcLWKmVHRYU9SWZbBVHW6orxnfUT1tqPf0Mfq
         +rh3ShbY4uPRLjueiK++Lwby7PwkiaFHA70sCo9eiWPiqMEQ0MMvRcyMP5SJRfM5C5MR
         T2PQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685978768; x=1688570768;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=+eTZJaesQgEddfhUw6/wmzf8jeBxuOms7oai97sQq2k=;
        b=bacFGcsuQaATwjWVsmH4TOLtSmObsUfZZvPO0G+1YXfRHb6emj5RsuALlfEaB0eXmq
         4dLMXHWSKnjyQ6/leKvFvbIlek+IoIYrNVb0DsCp0RG1Kugl4CqAtclM9i89f56M4lsf
         iQMKQislY2FE4zeWYL2pQeBlgR3AlE3IW7DgNwem0OMVM5qjc6VXFSob+GNBKon2vMF+
         wyGZT+vxD48W1azU/lpJ+XJm3ZSf+HRtf397lpq9Ns0auYgswxkmlitoZU8uvuBkaWrm
         8MG4uI0PO3xKH3GhEu0PvSrnqqmMzqAup34DN1jg7bCD8dTLeoFHt0dFDUXa5V5EZCrn
         QN1g==
X-Gm-Message-State: AC+VfDwo/UvuyGcv1bSmewxYMu9kGU/bm+5LtiJPPnw9tGi7+1Hj1VcB
        1QvGurAA+GuyW5fIaGsFOc0=
X-Google-Smtp-Source: ACHHUZ6wXMafXI1hTByfErDZvwWVy1ltulaWCZ8vTktcr6yFmoG+8whyg3dFFWFoM8U65OlC65dugA==
X-Received: by 2002:a05:6214:5194:b0:61b:714f:73f8 with SMTP id kl20-20020a056214519400b0061b714f73f8mr7360816qvb.0.1685978768343;
        Mon, 05 Jun 2023 08:26:08 -0700 (PDT)
Received: from auth2-smtp.messagingengine.com (auth2-smtp.messagingengine.com. [66.111.4.228])
        by smtp.gmail.com with ESMTPSA id n1-20020a0cec41000000b00619adb4b66asm4725098qvq.95.2023.06.05.08.26.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 05 Jun 2023 08:26:07 -0700 (PDT)
Received: from compute2.internal (compute2.nyi.internal [10.202.2.46])
        by mailauth.nyi.internal (Postfix) with ESMTP id 4D17C27C0054;
        Mon,  5 Jun 2023 11:26:07 -0400 (EDT)
Received: from mailfrontend1 ([10.202.2.162])
  by compute2.internal (MEProxy); Mon, 05 Jun 2023 11:26:07 -0400
X-ME-Sender: <xms:jv59ZLDukSEPN4HOY4Bvcw79G0QLjGz3A8oAioooGi3L3K-3Joel0g>
    <xme:jv59ZBjdylld1Q0grHd2JEHzP0gOt_fMX_3CpeRmkes1qiUQ0xTXHf-7yOyG9pdli
    np_6_UIGo7DG23LfA>
X-ME-Received: <xmr:jv59ZGkLhBdSfoWRoKAR-HB8ocHTOvvmZVDoxb5Xj4DTmDnfJrPux1Wgy9jdV7X6ASeisAp5ozOalks1iyGaOwv90AKYfzypfhE>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrfeelledgkeelucetufdoteggodetrfdotf
    fvucfrrhhofhhilhgvmecuhfgrshhtofgrihhlpdfqfgfvpdfurfetoffkrfgpnffqhgen
    uceurghilhhouhhtmecufedttdenucesvcftvggtihhpihgvnhhtshculddquddttddmne
    cujfgurhepfffhvfevuffkfhggtggujgesthdtredttddtvdenucfhrhhomhepuehoqhhu
    nhcuhfgvnhhguceosghoqhhunhdrfhgvnhhgsehgmhgrihhlrdgtohhmqeenucggtffrrg
    htthgvrhhnpeejiefhtdeuvdegvddtudffgfegfeehgfdtiedvveevleevhfekhefftdek
    ieehvdenucffohhmrghinheprhhushhtqdhlrghnghdrohhrghenucevlhhushhtvghruf
    hiiigvpedtnecurfgrrhgrmhepmhgrihhlfhhrohhmpegsohhquhhnodhmvghsmhhtphgr
    uhhthhhpvghrshhonhgrlhhithihqdeiledvgeehtdeigedqudejjeekheehhedvqdgsoh
    hquhhnrdhfvghngheppehgmhgrihhlrdgtohhmsehfihigmhgvrdhnrghmvg
X-ME-Proxy: <xmx:jv59ZNydKH2nuVH3HMIriWlJkvqR74dufyy5AiPfWHIu0yLrehDyhA>
    <xmx:jv59ZASjMlN7yeZUHsKs9E1CPgylv8jJbVfycr2ssgNOMW_tyHK7RQ>
    <xmx:jv59ZAadmys0NTauN4lwajZsToMJSpJeOsz7c2px4JQYAzvtcoCY6w>
    <xmx:j_59ZHI-jcDWNdY24kEFN4PPBekHoqi9315am_Y6EdwwNeGaWJoVAQ>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Mon,
 5 Jun 2023 11:26:05 -0400 (EDT)
Date:   Mon, 5 Jun 2023 08:26:04 -0700
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Qingsong Chen <changxian.cqs@antgroup.com>
Cc:     linux-kernel@vger.kernel.org,
        =?utf-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Alice Ryhl <aliceryhl@google.com>,
        Asahi Lina <lina@asahilina.net>, rust-for-linux@vger.kernel.org
Subject: Re: [PATCH v2 1/3] rust: kernel: add ScatterList abstraction
Message-ID: <ZH3+jARBbn2iG1dW@Boquns-Mac-mini.local>
References: <20230602101819.2134194-1-changxian.cqs@antgroup.com>
 <20230602101819.2134194-2-changxian.cqs@antgroup.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230602101819.2134194-2-changxian.cqs@antgroup.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 02, 2023 at 06:18:17PM +0800, Qingsong Chen wrote:
[...]
> +impl<'a> ScatterList<'a> {
> +    /// Construct a new initializer.
> +    pub fn new(buf: &'a Pin<&mut [u8]>) -> impl PinInit<ScatterList<'a>> {
> +        // SAFETY: `slot` is valid while the closure is called, the memory
> +        // buffer is pinned and valid.
> +        unsafe {
> +            init::pin_init_from_closure(move |slot: *mut Self| {
> +                (*slot).set_buf(buf);
> +                (*slot).mark_end();

Benno can provide more information, but you cannot dereference or create
a reference to `*slot`, since `slot` points to an uninitialized object
(see `try_pin_init` implementations), and referencing uninitialized
objects is UB (or may cause UB).

Note that you could do the following for `set_buf`:

	// `addr_of!`[1] is special since it won't create references
	// (even temporary onces).
	let opaque = addr_of!((*slot).opaque); // <- *const Opaque<bindings::scatterlist>

	let ptr = Opaque::raw_get(opaque); // <- *mut bindings::scatterlist

	// Maybe this can be wrapped as a Rust function with a
	// parameter: *mut bindings::scatterlist.
	unsafe {
		bindings::sg_set_buf(ptr, buf.as_ptr(), buf.len());
	}

[1]: https://doc.rust-lang.org/core/ptr/macro.addr_of.html

Regards,
Boqun

> +                Ok(())
> +            })
> +        }
> +    }
> +
[...]
