Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F34E703C6A
	for <lists+linux-kernel@lfdr.de>; Mon, 15 May 2023 20:19:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243020AbjEOSTZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 May 2023 14:19:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245203AbjEOSSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 May 2023 14:18:24 -0400
Received: from mail-ed1-x536.google.com (mail-ed1-x536.google.com [IPv6:2a00:1450:4864:20::536])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C05501B0A7
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:17:33 -0700 (PDT)
Received: by mail-ed1-x536.google.com with SMTP id 4fb4d7f45d1cf-50bc394919cso19317755a12.2
        for <linux-kernel@vger.kernel.org>; Mon, 15 May 2023 11:17:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=metaspace-dk.20221208.gappssmtp.com; s=20221208; t=1684174652; x=1686766652;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:from:to:cc:subject:date:message-id:reply-to;
        bh=6/nxqu6qJWqfBLblCuT6TWexFdaNEzmO1+L6cVrLZqU=;
        b=bhLCsPmABWiM8vruD3TVtItT0sfR4SUIuL9qLKUOj1woP+qL06EEQLgNNTc9AisnS7
         FRhm3jAg3pRhNnAPsR0paOD+v2MJtpR/anrJmj/6xul6xqa/BaWKHb8Yi1s5Di7Agewa
         sYMThGN7q9E0PS2xUZNmWDXTteYasUljNENjTTo/ZjoDurl27DZJUV4Ez2JHT18yBWkV
         dioum9PGBrXuijzxwQoiReJP/HKTOJ9cH+T8msYb6a8PmpTqJARS/zaAk6FuStRLXmI1
         PR3u0+bFj2PfkcFKNTETzTwg0jHmhAAYXlNKFWxXPp31gYUszpnA8w/HkjlN1NUrdhJB
         HJoA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684174652; x=1686766652;
        h=mime-version:message-id:in-reply-to:date:subject:cc:to:from
         :user-agent:references:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6/nxqu6qJWqfBLblCuT6TWexFdaNEzmO1+L6cVrLZqU=;
        b=PYUu6WPNSdrXXiK9JGa895ByMGRWXl7LxT12OqmN59VF1idVISZnNOQeS8VR2jegjx
         p9tpPJajkYpahYKspZclWjL9mmsj3nqbOZNsPLJRYfDW/10ndZFQgUOMkNhFKTCa1QYw
         MghjzxUZ7rHSGAhQqqk9ZntEf/wsDGaNk/Bn5RRCZjsgYnvKvK+AX+gb60KYpZ0WIxJq
         nRjnku9P8tm+KssmDsupxmKKNbq2+o76v7jOh8GRLky0Afg+utzbjXuAAhO7QJzwzhvB
         IMvawTirBZZTcbzlayoNkc6YPv4AVDUNg8GUBIHeelGczB7Clxu1Yz248P8UFzh4p6IR
         UVNw==
X-Gm-Message-State: AC+VfDy7/3/8So7Zv+CRzRM7kgPVRSH9+8670Q9QYZU/5tm4RQ+vmyRW
        Ui89oRGTbgYWzt6Ngyffqn6VgQ==
X-Google-Smtp-Source: ACHHUZ6mvBgvPodUdE7nvAliZU7yYsJPsfUsfq9CvzMl9RmUzRf3NYGfERotBPkU5xormssom4WaOA==
X-Received: by 2002:a17:907:25c8:b0:94a:ac4b:e11b with SMTP id ae8-20020a17090725c800b0094aac4be11bmr26777061ejc.39.1684174652125;
        Mon, 15 May 2023 11:17:32 -0700 (PDT)
Received: from localhost ([79.142.230.34])
        by smtp.gmail.com with ESMTPSA id jx26-20020a170907761a00b0096629607bb2sm9823804ejc.98.2023.05.15.11.17.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 15 May 2023 11:17:31 -0700 (PDT)
References: <20230503141016.683634-1-aliceryhl@google.com>
 <20230508124127.77a97c54.gary@garyguo.net>
 <bb3bfbfb-0761-23b2-24e9-e5b4cb3ffac6@ryhl.io>
User-agent: mu4e 1.10.3; emacs 28.2.50
From:   Andreas Hindborg <nmi@metaspace.dk>
To:     Alice Ryhl <alice@ryhl.io>
Cc:     Gary Guo <gary@garyguo.net>, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        =?utf-8?Q?Bj=C3=B6rn?= Roy Baron <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Subject: Re: [PATCH v2] rust: str: add conversion from `CStr` to `CString`
Date:   Mon, 15 May 2023 20:12:57 +0200
In-reply-to: <bb3bfbfb-0761-23b2-24e9-e5b4cb3ffac6@ryhl.io>
Message-ID: <871qjhe9xh.fsf@metaspace.dk>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Alice Ryhl <alice@ryhl.io> writes:

> On 5/8/23 13:41, Gary Guo wrote:
>> On Wed,  3 May 2023 14:10:16 +0000
>> Alice Ryhl <aliceryhl@google.com> wrote:
>> 
>>> These methods can be used to copy the data in a temporary c string into
>>> a separate allocation, so that it can be accessed later even if the
>>> original is deallocated.
>>>
>>> The API in this change mirrors the standard library API for the `&str`
>>> and `String` types. The `ToOwned` trait is not implemented because it
>>> assumes that allocations are infallible.
>> How about add a `TryToOwned` trait to the kernel crate and implement
>> that trait for `CStr` instead?
>
> Eh, I don't think it's worth it. It doesn't give anything new to the CStr api,
> and I think it's rather unlikely that someone will actually need to be generic
> over such a trait any time soon.

It is just as valid as having `From<&str>` and `ToOwned<&str>`. While it
does not add anything in terms of function, it carries intention. I
think we should consider adding it at some point.

BR Andreas
