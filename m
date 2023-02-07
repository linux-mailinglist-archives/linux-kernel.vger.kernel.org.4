Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9447768D2E6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Feb 2023 10:34:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231432AbjBGJeM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Feb 2023 04:34:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229992AbjBGJeL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Feb 2023 04:34:11 -0500
Received: from mail-ed1-x532.google.com (mail-ed1-x532.google.com [IPv6:2a00:1450:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1F5BE1EFD2
        for <linux-kernel@vger.kernel.org>; Tue,  7 Feb 2023 01:34:07 -0800 (PST)
Received: by mail-ed1-x532.google.com with SMTP id q19so14621639edd.2
        for <linux-kernel@vger.kernel.org>; Tue, 07 Feb 2023 01:34:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20210112.gappssmtp.com; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=uDFOFGN7sf2+Ai+RMRVBWm4CW15bTwJp4mBVAUWo9XY=;
        b=inbW0VtmixIQRC4S+CuEjGGknQgFXxROoDl/NQ3aqIIesJhfcSDPSGx0x/89FjprjT
         2OQ76T5SnGLZTfeMy8AN8Ft+kKeYqmtLn+z3o5/R8ZbyASgYdzWzgqWzklfNE5IF8STp
         BuWxcAIvPEVCr8x9fXnHahkflPJtZYxcfetc/FkWA7nrqKSQY1fe0ejRV1bnbUNTQaTq
         DkvSWYeCMAlt3N53ebM+lyRdt90USGxvL+ATIVdQeh3sAUG8TbxolgqxhOK6xrhBXfsU
         EWVmBbFgfljF85bc+koHsy4Qbl7G1ZQyvq+N0XISGghMNxfzAQGY8MVqFVruGNwrEH2t
         Y/7g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=uDFOFGN7sf2+Ai+RMRVBWm4CW15bTwJp4mBVAUWo9XY=;
        b=2QiwJR3jNw7ZPamhvedWoPstlIoxoUPrMsU0ZsVwqAKk6RkKCL5J6+oG4b2C+0sOhh
         fiYyoUTpiGCN4LdwCIesX6YrmOwIL0SADwnj9eriu7GY5FnCXVbuwYQO6x5VTH7gHGqI
         TBMXHN0VQ1fU28psjZpGHhJQLvIRpwkTzmkvIczkj2f/h8xWWxKSspHHz+yws7NngiHa
         ZMmeIJDCkLHMBFbUBT1D3YalS2S6czqFZVHsG5gpytVIL+62hQ1s5R2ZPjzT5hdSfQXA
         loLUYd+0PT4cDPIs5+Okx+yFOSEGj8wg059OOJ6bFoPyvSAWHlv0rS9JvhSbko9JpAbd
         UAbw==
X-Gm-Message-State: AO0yUKVLV1fUml3RBu6nSDuJWSWY+cz/zecTxB9pgHsOC/zuX96Py7gH
        jbHEBtQlnD3aEiClZgCuYMN50g==
X-Google-Smtp-Source: AK7set9nJjoKGxU3DzBf3xCb0a8faWphNun1frWIlolJLyTztru0HQCur+E+ZX0R34SqnGN12eCT8Q==
X-Received: by 2002:a50:bac7:0:b0:49e:eb5:ed05 with SMTP id x65-20020a50bac7000000b0049e0eb5ed05mr3058130ede.9.1675762445729;
        Tue, 07 Feb 2023 01:34:05 -0800 (PST)
Received: from localhost ([194.62.217.4])
        by smtp.gmail.com with ESMTPSA id d22-20020a50cd56000000b004aaa8e65d0esm3122923edj.84.2023.02.07.01.34.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 07 Feb 2023 01:34:05 -0800 (PST)
References: <20230130064404.744600-1-wedsonaf@gmail.com>
 <20230130064404.744600-5-wedsonaf@gmail.com> <87h6w5isfq.fsf@metaspace.dk>
 <CANiq72nGh9ypPY2QvJF5oak_1qBBG6z6LhHz8hxgp875HCx48Q@mail.gmail.com>
User-agent: mu4e 1.9.18; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Vincenzo Palazzo <vincenzopalazzodev@gmail.com>,
        Alice Ferrazzi <alice.ferrazzi@miraclelinux.com>
Subject: Re: [PATCH v2 5/5] rust: types: implement `ForeignOwnable` for
 `Arc<T>`
Date:   Tue, 07 Feb 2023 10:32:52 +0100
In-reply-to: <CANiq72nGh9ypPY2QvJF5oak_1qBBG6z6LhHz8hxgp875HCx48Q@mail.gmail.com>
Message-ID: <87357hsttf.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Miguel Ojeda <miguel.ojeda.sandonis@gmail.com> writes:

> On Wed, Feb 1, 2023 at 11:35 AM Andreas Hindborg <nmi@metaspace.dk> wrote:
>>
>> The last part of the sentence does not read clearly to me. Would this
>> make sense instead:
>>
>> // SAFETY: By the safety requirement of this function, we know that `ptr` came from
>> // a previous call to `Arc::into_foreign`, which guarantees that `ptr` is valid and
>> // holds a reference count increment that is transferrable to us.
>
> In a private chat with Wedson he agreed the "owned" was a typo and he
> is fine with this change. Thus I rebased to apply this and avoid a v3
> given it is trivial and almost at the top of the stack. If you want
> the `Reviewed-by`, please let me know!

Sure, if it's no trouble, add my the tag :)

- Andreas

