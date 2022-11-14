Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DF6F62883E
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 19:22:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236620AbiKNSWT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 13:22:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237226AbiKNSWO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 13:22:14 -0500
Received: from mail-yw1-x112a.google.com (mail-yw1-x112a.google.com [IPv6:2607:f8b0:4864:20::112a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22D1C1E0;
        Mon, 14 Nov 2022 10:22:14 -0800 (PST)
Received: by mail-yw1-x112a.google.com with SMTP id 00721157ae682-3691e040abaso114499137b3.9;
        Mon, 14 Nov 2022 10:22:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=dJhdvZIL4dk79Y3gG/NcL+fwogDMvYUZLhwwyEHygOE=;
        b=Ghk/bDvtvykckld0AKbfuQzvD+2Rlsr0agjZxZ6786dart7MCb+IoxAaz28aIKu0r5
         jU97rIgPPMsw6Xh0uI5w5qZ92ZLTVqjNaIi7cJWzQl/I2e+gAGjwPHzJ7RsGpj0DvxM8
         XJHgreVIm1xQeI9KLSWdPnka/7A+NFJOVBhXLVlNFCAy5VLSr3pg/2l+fxeF+hZc8FAH
         NIGBtwWBwrc6ZKE4gkCKz3o5zebil7r6zm4f7mR24MurTdNhOmDEAvLJce4GU5aQI3WO
         hEn8oEo5kfR+AMZ8hE1FYEFlm63aAsld6rL57UYGH6zL0eAbmZRgM6aDGbHcXIGJjx4j
         pDnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=dJhdvZIL4dk79Y3gG/NcL+fwogDMvYUZLhwwyEHygOE=;
        b=E4qGdkHh9n+65eYsKYbzmDVpPbV1gO9hHe0d8WzHtPuudCV66InLzt7FsFo9ZW6Zzi
         SnhfcIEt1t6i8CZKLkqzyQUzJwT9JODcZ++4PmsVpoDu5za6mnwk/dBUqe/FV8VPmyoA
         dnp7fpCj84YRJowgVvQDa5RlOHh/B/AJCU/rrK2+9vPvBz8MGoK2lKH3n1FvyetjFK/I
         /Xq5EF3zGXfLCQNuvmWn3yzQCz562ati8++oK/x9/Ewgd/OylqmYMM2p4SVHz+jIsP6b
         4tYaYWazQmQ4zRrg6aZWSB1R2lhA4zX4JqXBMpQB8QRM729d+uiV6CRBrMjNt7sXZ6zl
         AoVg==
X-Gm-Message-State: ANoB5pnbq5mkjvGdzeqtr+7K7MU/XnIH6EwBSEyzEAlUDgZsO4xv7LUM
        twaDRfqq4Dfx7PYjIDgufumlwa/KOoM3ucFKb5I=
X-Google-Smtp-Source: AA0mqf5pgXx9393AjH3cG63sp/dEA3pT6uJPHn4NX8ei4qCoMqb/LVkaMds9N2NrFEeR1h/+POHFoFhG8AHgfc9Gv6o=
X-Received: by 2002:a81:7912:0:b0:342:4d19:c7b with SMTP id
 u18-20020a817912000000b003424d190c7bmr13767068ywc.67.1668450133388; Mon, 14
 Nov 2022 10:22:13 -0800 (PST)
MIME-Version: 1.0
References: <20221110164152.26136-1-ojeda@kernel.org> <20221110164152.26136-26-ojeda@kernel.org>
 <Y3JQ8qsaV/DN3OJ7@liuwe-devbox-debian-v2>
In-Reply-To: <Y3JQ8qsaV/DN3OJ7@liuwe-devbox-debian-v2>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 14 Nov 2022 19:22:02 +0100
Message-ID: <CANiq72ktW2=JCi3YzyrAd=_RioaWGZSyDusMU2f92_aL3tgvUA@mail.gmail.com>
Subject: Re: [PATCH v1 25/28] rust: add `build_error` crate
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 3:30 PM Wei Liu <wei.liu@kernel.org> wrote:
>
> a const function `build_error`
>
> Without this I read it as a "normal non-const function".

Sounds good to me, especially given the sentence that goes after that.

(I think "function" does not imply one or the other in principle. To
me, `const` ones are normal too, in the sense that they can be used as
any other function.)

> I can work out what the code does, but I also happen to know what Rust's
> const means and its behaviour in non-const context. Other kernel
> developers may not. Even so the description is a bit difficult for me to
> parse.
>
> Maybe a few sentences about const and its behaviours can help?

Not sure if we should explain language details in the documentation of
particular functions. But I agree this case is a bit special.

What about linking the Rust reference/book/... (so that those terms
are clickable when rendered)?

Thanks a lot for the reviews, Wei!

Cheers,
Miguel
