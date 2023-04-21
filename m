Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D0D06EB526
	for <lists+linux-kernel@lfdr.de>; Sat, 22 Apr 2023 00:46:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233909AbjDUWqY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Apr 2023 18:46:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229543AbjDUWqW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Apr 2023 18:46:22 -0400
Received: from mail-yw1-x1131.google.com (mail-yw1-x1131.google.com [IPv6:2607:f8b0:4864:20::1131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E35871FCD;
        Fri, 21 Apr 2023 15:46:21 -0700 (PDT)
Received: by mail-yw1-x1131.google.com with SMTP id 00721157ae682-5562c93f140so690567b3.1;
        Fri, 21 Apr 2023 15:46:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1682117181; x=1684709181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=N8J/G7dB6fCp2xG0xoJDui4DL2plxJGL8yp09N3bKW4=;
        b=gB2eMgT6zWwAiSi67l6PzypippJp7OT/IOWEB7PCGz6MH5cxWm/7b/nr2F6Zrgu8NG
         Y4yvqSW8GbF+gpDeIGrRfRBfHJMpp8ysLmxDL1OQVzl/Jdww0cL6Z5S0TBwEgnMPWQXR
         4VjW/+Wu+jJgSKfWcMh/QrBigO2iCCK+iCV6dKIXIF6LTNSA/t9xGsHk1qbwww7lVRjN
         A5fFUKgvjtg1xNpr6ex4MLTRbVj0ML1O95Id0iJsHCIc0L5ut/k9MlLBC7qan6zYVbRf
         EUjcDBmzgb5CwYSDyj1OcE/n/kvlQFVDgOqLhyyczfON2RoM/mfpVZ2IU2zIRVLGn+tL
         DZAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1682117181; x=1684709181;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=N8J/G7dB6fCp2xG0xoJDui4DL2plxJGL8yp09N3bKW4=;
        b=LkF8L/omZbkIPetZ6WyKari/TaD0QM09DYaOc8FFCyAi7pV11c8zbcboX7gniCyu5a
         TOg17srjRu1BcGouTQ9OekfbO6nw89U0H8DzuV4fMN6XCEVPaeQIf1cDDWq7FUDNVK2Y
         EaGfU5UIWtiyqrTXTXlmv+v0LLNzJfAJU05Iu3nCLMRvk/QXM7YjdtCY/RLFRsBIur+D
         AxeF4aXChzj6m9oE1/R2arWAaJ/7q56QHt31mYYXG6nwpnvCb2zpu7H3+muXp2JyH6kb
         ta140Nb3FRhVFZlC/SIdQHTQJ70wdepk3pBnFrgIDt1ebI7m2PjMVj3/56PTA+gvLvB7
         iVDQ==
X-Gm-Message-State: AAQBX9f+3hW2sVnW3ms3VUDYNNT8AMBLXyHfxPfdDcChD//bVp6Fur4c
        YTKEbcmc6PgpHaJMEpLsazHHuEZz6LRWfnPjdB4=
X-Google-Smtp-Source: AKy350aszP8cZ00/JsNBnpsbsv/FVIPIsSNMgOkdQvwGWf4dPX0KcyvMOTtmYL0KqMWU85US7GqYqJZcvsBxeVeB2JY=
X-Received: by 2002:a0d:d742:0:b0:555:d20f:6572 with SMTP id
 z63-20020a0dd742000000b00555d20f6572mr3014437ywd.12.1682117181137; Fri, 21
 Apr 2023 15:46:21 -0700 (PDT)
MIME-Version: 1.0
References: <20230412221823.830135-1-ojeda@kernel.org>
In-Reply-To: <20230412221823.830135-1-ojeda@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 22 Apr 2023 00:46:09 +0200
Message-ID: <CANiq72kXNi+bKxnVy7NcogvA8b4KbVD7zBf29oC5EE5VbF_YvQ@mail.gmail.com>
Subject: Re: [PATCH] MAINTAINERS: add Benno Lossin as Rust reviewer
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Benno Lossin <benno.lossin@proton.me>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 13, 2023 at 12:18=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> Benno has been involved with the Rust for Linux project for
> the better part of a year now. He has been working on solving
> the safe pinned initialization problem [1], which resulted in
> the pin-init API patch series [2] that allows to reduce the
> need for `unsafe` code in the kernel. He is also working on
> the field projection RFC for Rust [3] to bring pin-init as
> a language feature.
>
> His expertise with the language will be very useful to have
> around in the future if Rust grows within the kernel, thus
> add him to the `RUST` entry as reviewer.

Applied to `rust-next`.

Cheers,
Miguel
