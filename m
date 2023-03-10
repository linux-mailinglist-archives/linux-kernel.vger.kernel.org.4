Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96E906B5069
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Mar 2023 19:57:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230256AbjCJS5n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Mar 2023 13:57:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229800AbjCJS5l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Mar 2023 13:57:41 -0500
Received: from mail-qt1-x834.google.com (mail-qt1-x834.google.com [IPv6:2607:f8b0:4864:20::834])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33DEA12B671;
        Fri, 10 Mar 2023 10:57:40 -0800 (PST)
Received: by mail-qt1-x834.google.com with SMTP id cf14so6813135qtb.10;
        Fri, 10 Mar 2023 10:57:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678474659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iYsCaNsSgngNKZcdLQcf6Ufpk9ToxZLFdwVZ9rpQa4I=;
        b=X08bB+yklbWwlcTtt2aeNgmaxess2TPKnELiAEk9OTqJPHuz+3/M9Tmq+KpCSIfM0f
         jD0APM2OhnjVRgXxux5Jran0ExHQPN0mQlneMTl6sIrkmKBwNPbgnNqDlrZ0e9vmTRda
         vjNSQQJBQJ+r7zirpHMIeDU/udZbkxHbku0star9P0mSAMUORFbrWFRMAJcJzUAcYotm
         Uti2604Hf+UKs07gy9+nPPywgNaEIbCrcDdotdF7kCvsZH9Eapmykh+3okNVcDPNrDdi
         OD9nWY2u/J4phmSp18O6CqUa5+TewrEkVAjwF7LWgvHms4ak00DKbbJpNhxXOO7NCOM/
         XZmg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678474659;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:feedback-id:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iYsCaNsSgngNKZcdLQcf6Ufpk9ToxZLFdwVZ9rpQa4I=;
        b=OBcX9bkB6YtUT8kUCBe78uPukkXgyOYVxoa+OP4PPMJoojySqzhgVYLnBVvriimSVb
         e+Cn11dd19AQLI+EzAFcTjXT3bNi+NQCvfr7WCnJ3ZUNrpUdI8EtplVPyOw9xshy9q7n
         /CBLHCXx9cgLWrVb8mcNg61K6ZvDzY/vgqgrRKLspaqBqI28jlwlBsOQz3ZF0ZcXqg+j
         NCQIkGuaH4raVtG4OwNxVwQzo54nxjjnxBjYKtg/0b5SG7R0zSYQ27r0hbcnwT/SYQxW
         VsK24+9rLCwuvXb4qRFSdJjdnqyiz52MkyETtSiNmGInCBvjpUR2Aiq00DG1EWzs6z5O
         IGAg==
X-Gm-Message-State: AO0yUKVXnjcyt0NwS0T9Vi2TRa+luiAoEuX+bdRfG8hvmtsQIrD+TrCQ
        L9YQh4VlAxVK4pJECsHZNCY=
X-Google-Smtp-Source: AK7set+4zSWuXwAS3gf17d063Xj+Ph3v0EPqWJGTs3qx7Dqyh0WAYgbNyBItJeOyToWCKILdkt9WAA==
X-Received: by 2002:ac8:5e4a:0:b0:3b8:2ea9:a09c with SMTP id i10-20020ac85e4a000000b003b82ea9a09cmr11028163qtx.1.1678474659251;
        Fri, 10 Mar 2023 10:57:39 -0800 (PST)
Received: from auth1-smtp.messagingengine.com (auth1-smtp.messagingengine.com. [66.111.4.227])
        by smtp.gmail.com with ESMTPSA id a8-20020aed2788000000b003b62e8b77e7sm342021qtd.68.2023.03.10.10.57.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Mar 2023 10:57:38 -0800 (PST)
Received: from compute4.internal (compute4.nyi.internal [10.202.2.44])
        by mailauth.nyi.internal (Postfix) with ESMTP id BD05F27C0054;
        Fri, 10 Mar 2023 13:57:37 -0500 (EST)
Received: from mailfrontend1 ([10.202.2.162])
  by compute4.internal (MEProxy); Fri, 10 Mar 2023 13:57:37 -0500
X-ME-Sender: <xms:oH0LZKRLdsP7S-ODRUr5NQxPKLRM043tk4HBpFPML5ny56aOMc1WKA>
    <xme:oH0LZPyoebzZatMZAuu6P_73GVuEHtNN69KxZr64O2-UPfZdk1ohaIHA1YNTOmA_r
    KAkwArw5YzolSql6g>
X-ME-Received: <xmr:oH0LZH2zT9VTIey8ILSfvM1iTiewrf9ia19JsONvub11ZyqXtExdx7oEEi8>
X-ME-Proxy-Cause: gggruggvucftvghtrhhoucdtuddrgedvhedrvddukedguddujecutefuodetggdotefrod
    ftvfcurfhrohhfihhlvgemucfhrghsthforghilhdpqfgfvfdpuffrtefokffrpgfnqfgh
    necuuegrihhlohhuthemuceftddtnecusecvtfgvtghiphhivghnthhsucdlqddutddtmd
    enucfjughrpeffhffvvefukfhfgggtuggjsehttdertddttddvnecuhfhrohhmpeeuohhq
    uhhnucfhvghnghcuoegsohhquhhnrdhfvghnghesghhmrghilhdrtghomheqnecuggftrf
    grthhtvghrnhepfeduvddvleeigeeugfevffdvffduieeujeeivdduhfeljeeghfegffev
    fffhkeffnecuffhomhgrihhnpehpthhrrdguvghvnecuvehluhhsthgvrhfuihiivgeptd
    enucfrrghrrghmpehmrghilhhfrhhomhepsghoqhhunhdomhgvshhmthhprghuthhhphgv
    rhhsohhnrghlihhthidqieelvdeghedtieegqddujeejkeehheehvddqsghoqhhunhdrfh
    gvnhhgpeepghhmrghilhdrtghomhesfhhigihmvgdrnhgrmhgv
X-ME-Proxy: <xmx:oH0LZGAmUZAA0WaAkOpaN91r1NTQfHex41rDqaXOgp7XltObtE-y4Q>
    <xmx:oH0LZDhbyzfoZ9B-1L4Zs_Qb4Brv9uR5ds8IbGPyn9TAqabJ4deWLw>
    <xmx:oH0LZCrDEJ4ut9DJmmL9U5wz_K5XqnyQlUZYnc_Ay2xgLVJ4PQ1cMQ>
    <xmx:oX0LZPDMVZoKkaOWLRxjIng7KbgqOLDTOoYJ_0CZLCFD9tpM_5bBfg>
Feedback-ID: iad51458e:Fastmail
Received: by mail.messagingengine.com (Postfix) with ESMTPA; Fri,
 10 Mar 2023 13:57:36 -0500 (EST)
Date:   Fri, 10 Mar 2023 10:56:31 -0800
From:   Boqun Feng <boqun.feng@gmail.com>
To:     Asahi Lina <lina@asahilina.net>
Cc:     Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?iso-8859-1?Q?Bj=F6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Sumit Semwal <sumit.semwal@linaro.org>,
        Christian =?iso-8859-1?Q?K=F6nig?= <christian.koenig@amd.com>,
        Luben Tuikov <luben.tuikov@amd.com>,
        Jarkko Sakkinen <jarkko@kernel.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Alyssa Rosenzweig <alyssa@rosenzweig.io>,
        Karol Herbst <kherbst@redhat.com>,
        Ella Stanforth <ella@iglunix.org>,
        Faith Ekstrand <faith.ekstrand@collabora.com>,
        Mary <mary@mary.zone>, linux-kernel@vger.kernel.org,
        dri-devel@lists.freedesktop.org, rust-for-linux@vger.kernel.org,
        linux-media@vger.kernel.org, linaro-mm-sig@lists.linaro.org,
        linux-sgx@vger.kernel.org, asahi@lists.linux.dev
Subject: Re: [PATCH RFC 02/18] rust: drm: Add Device and Driver abstractions
Message-ID: <ZAt9X8qDUHQ/YnW8@boqun-archlinux>
References: <20230307-rust-drm-v1-0-917ff5bc80a8@asahilina.net>
 <20230307-rust-drm-v1-2-917ff5bc80a8@asahilina.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230307-rust-drm-v1-2-917ff5bc80a8@asahilina.net>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 07, 2023 at 11:25:27PM +0900, Asahi Lina wrote:
[...]
> +
> +// SAFETY: `Device` only holds a pointer to a C device, which is safe to be used from any thread.
> +unsafe impl<T: drm::drv::Driver> Send for Device<T> {}
> +
> +// SAFETY: `Device` only holds a pointer to a C device, references to which are safe to be used
> +// from any thread.
> +unsafe impl<T: drm::drv::Driver> Sync for Device<T> {}
> +

Here is the mind model I use to check whether a type is `Send` or
`Sync`

*	If an object of a type can be created on one thread and dropped
	on the another thread, then it's `Send`.

*	If multiple threads can call the immutable functions (i.e.
	functions with `&self`) of the same object of a type, then the
	it's `Sync`.

Maybe it's incomplete, but at least I find it useful to determine
whether a type is `Send` or `Sync`: it's not just the struct
representation, the behaviors (functions) of the struct also matter.

If that looks reasonable to you, maybe update the "SAFETY" comments in
the future version? Thanks ;-)

(I know you brought this up in the meeting, sorry I guess I wasn't fully
woken when answering you ;-))

Regards,
Boqun

> +// Make drm::Device work for dev_info!() and friends
> +unsafe impl<T: drm::drv::Driver> device::RawDevice for Device<T> {
> +    fn raw_device(&self) -> *mut bindings::device {
> +        // SAFETY: ptr must be valid per the type invariant
> +        unsafe { (*self.ptr).dev }
> +    }
> +}
[...]
