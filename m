Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C5B02626069
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Nov 2022 18:31:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233825AbiKKRbf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Nov 2022 12:31:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34968 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232372AbiKKRbd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Nov 2022 12:31:33 -0500
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C049D1A82A;
        Fri, 11 Nov 2022 09:31:32 -0800 (PST)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-367b8adf788so50106437b3.2;
        Fri, 11 Nov 2022 09:31:32 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=prpDIZ3BYZ/cNF9JhJEHd9uz60rT0/OfMxiYhClGJnQ=;
        b=Wzmzth18FIxXSWPYBPIUIIkwKhGTOTObxE85JRHaooraLOoUdTB3Lv4DVZrZC/6Tmm
         E4yj68jnmJSqdA6uDC4woQONc4W8sqmM0Vv71nFr2DN84w7hOUNJqw2R0LK14fko8Ui7
         UlhkULZqxMSsumrcu1IF29cNq8I42ZX4KFR9p1C2j750pr4rcnXIU/MonhlAH2avgY1p
         RgYMe4pdqxa36UndBydIGE55t3nRAaPNBt+WVrz81XI0L45VFAr5YtCmS8RCGQwcSWtV
         9DxrTEIAQLIPUk50dZTIgJWoPg0XK/k91bwxGNGQ4jUgSiNdNb80JkdbOHM8XAWTTsaP
         tUSw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=prpDIZ3BYZ/cNF9JhJEHd9uz60rT0/OfMxiYhClGJnQ=;
        b=oW+CiLgAXmm3Oy0Xw5SFapoBpAwQc87Gwj+4pROKyqsFDEvkduA2JkvbkqfUywu0oR
         tQoLae+6YXOcF7tvv8IOmAZloEPLMgltIf7iErwZJyurZiX9qeYoLj3thAKP88FbzSOL
         oVUmz1JhoEHTDUXpkv/ddWp4JvAeCPym+KtgwzTgE/g37l0JFItMSbQgWI8zz9aFi7Or
         UjJS3jgbl1RWMXdmMJ1PdiUHwU1KaeP11J3efJKJ2FzDn553+m8qQGpLRtf7szEdvLC3
         LoG2XxG4Xk+1EdpL9GTHWtgj66yadOayP/MBYWuo8aq3hDHSmc9UycftPatbtnwCyZme
         lIKQ==
X-Gm-Message-State: ANoB5pmhJuno+2H7rI6UB+TpbVJCiSQmGfnmXPrbmQXdfo5AoNrYNLPR
        9gtgyje9ZA+JGkSt7POiBNEGspEbW6NRnAd7th4=
X-Google-Smtp-Source: AA0mqf4SJPcsFe//JwHzczhAEgtzUngvwNQkjyHOuLKRqKSMivaREWk3rlCM+zC0jC8KQdeC9n6CsjLYsGz43FHF/SE=
X-Received: by 2002:a81:7912:0:b0:342:4d19:c7b with SMTP id
 u18-20020a817912000000b003424d190c7bmr2894140ywc.67.1668187891982; Fri, 11
 Nov 2022 09:31:31 -0800 (PST)
MIME-Version: 1.0
References: <20221110164152.26136-1-ojeda@kernel.org> <20221110164152.26136-5-ojeda@kernel.org>
 <6C48433C-2B12-4D35-A93E-72CC1B41A8C4@kloenk.dev>
In-Reply-To: <6C48433C-2B12-4D35-A93E-72CC1B41A8C4@kloenk.dev>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 11 Nov 2022 18:31:21 +0100
Message-ID: <CANiq72kaqNroTms5fBW9uhPdRVrYkVfMUa+_dqPFVVVBUBeUew@mail.gmail.com>
Subject: Re: [PATCH v1 04/28] rust: samples: add `rust_print` example
To:     Finn Behrens <me@kloenk.dev>
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

On Fri, Nov 11, 2022 at 10:40 AM Finn Behrens <me@kloenk.dev> wrote:
>
> Could be nice, to also have an int or similar as arg, but as internal the same macro is used as above, not really of interest.

Yeah, there are some integers above, but we can add more examples
later on, e.g. with custom kernel types too.

Thanks for the reviews in several patches, by the way!

Cheers,
Miguel
