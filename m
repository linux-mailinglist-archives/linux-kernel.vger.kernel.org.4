Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 512AE718843
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:14:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229628AbjEaROh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:14:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229557AbjEaROd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:14:33 -0400
Received: from mail-yb1-xb34.google.com (mail-yb1-xb34.google.com [IPv6:2607:f8b0:4864:20::b34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50345BE;
        Wed, 31 May 2023 10:14:26 -0700 (PDT)
Received: by mail-yb1-xb34.google.com with SMTP id 3f1490d57ef6-bab8f66d3a2so8315583276.3;
        Wed, 31 May 2023 10:14:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685553265; x=1688145265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=4b+59wHppr/MAOrrv0BsVtn85WuHM6SCc3RDy+wBhi0=;
        b=Y6cXHiWV3Gs9cuepa2WxnKaPjGCwbYQTMFoHjqK+g74plHZujuJpbPzESnkxOfiAPT
         mZ4ULJ0H7/hZqKrfDdDERjEXYjqnn6kow0Ea1qjPOaDkOYyJd5ChnHTk1wMC48o3XLwv
         jdywqbh5ECXqEBPUvwZSCMmDXGriQF25Ia+BLS1K1Rq7kAWvJFW2DkrE7VCgGl7UjlIQ
         X7vvSMQNjdaSurpJN47xQ3RNHVWFqXprr+WTXzMxURNYskU+OtM2cKRkttznHOqCa4lO
         1NOcIeTnd8sOr2NprileDC5s8qsQwc7QjNR7J6o2tT6yt/TyTNj9Fjc8ajPA3nktewk3
         Gkzg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685553265; x=1688145265;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=4b+59wHppr/MAOrrv0BsVtn85WuHM6SCc3RDy+wBhi0=;
        b=Cu3Nw2p3QTwyrdUKbOdG2SCW0BsrhWdtC430y9B0ZBirVj/nyjy75ML10+T52nsei1
         +ryA1x09cghZ0EKgMJXJO9f5J3RdLxZSTq3S8JYpY0P+ACvc05cEd11aIuz45rFIizCk
         wZpzZ3ay09d64CJAm5KgVZK9FVFAA/ZQo9XwovlQ304EtgJyPjOYcD2CDHyAs074Sgah
         E0crKQ265d5KOLpoU4NwYCDkf1fAGwi1i0lcyiKHLklQCOC+nbeThE9JDBtGYSF09Vaa
         7xnCZw1IZTourmpBHf7dtydaeAv+mPo7sYpLdc96Ov85rAjnTlx/JlyjZMsL4LEgUYRl
         Ke4Q==
X-Gm-Message-State: AC+VfDyXzeoyJ7rHvzttYzwcji3JB4pAHvFbolHHL7Ovw/UiUoDYek2I
        QePIOLC+uSYr8r6myAenRpm7Dqqa81V6HPgXUhc=
X-Google-Smtp-Source: ACHHUZ7T4rgiA3BO0y3KMEaoS9f/bCxbQDFGFDD5kLRyYagdle/SOfcwNa33gkxYPqyovM3MESJfqFVeGKj4+GafDVc=
X-Received: by 2002:a05:6902:102d:b0:ba8:6c1f:f5ad with SMTP id
 x13-20020a056902102d00b00ba86c1ff5admr8001103ybt.29.1685553263977; Wed, 31
 May 2023 10:14:23 -0700 (PDT)
MIME-Version: 1.0
References: <20230531145939.3714886-1-aliceryhl@google.com>
In-Reply-To: <20230531145939.3714886-1-aliceryhl@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 31 May 2023 19:14:13 +0200
Message-ID: <CANiq72k6YKjPDqcT9g5BT5pYwypH5rLjwafcEEhddTfErcnNDA@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] Update thread safety markers
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     rust-for-linux@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 31, 2023 at 5:00=E2=80=AFPM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> In Rust, the `Send` and `Sync` traits are used to mark in what ways a
> specific type is thread safe. In this patch series, I add some missing
> thread safety markers and improve the documentation related to them.
> This change will let you compile some code that would currently fail to
> compile even though it doesn't actually violate any thread safety rules.
>
> You can find a definition of what these marker traits mean at [1].
>
> Changes since v2:
>
>  * Removed "for example" as suggested in [2].
>  * Added Reviewed-by annotations from v2 review.
>
> [1]: https://stackoverflow.com/a/68708557/1704411
> [2]: https://lore.kernel.org/all/20230523165027.71600b4b.gary@garyguo.net=
/

Applied to `rust-next` -- thanks everyone (and Alice for taking the
effort to send this v3 even for the small change)!

Cheers,
Miguel
