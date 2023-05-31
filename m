Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2BBE47187FB
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:03:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229978AbjEaRDx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:03:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229998AbjEaRDu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:03:50 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 064EC1A8;
        Wed, 31 May 2023 10:03:31 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id 3f1490d57ef6-bacf5b89da7so8630635276.2;
        Wed, 31 May 2023 10:03:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685552610; x=1688144610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Le5txtN+vXlkc1zaxXhjQiMsM93MRJ25LBvYo+mP45Y=;
        b=djKnNwcLL/efJ5Pk7pXVYfsHtSdffoNzj2IJRAaHP3MCrI6gxT+2gkP0w7UUNrWmJl
         lbc2Eps+jrJtZJt5ZCmV0E1NGun0EYmcjAl8eORPPkndCiH1OVmhfA4ZTcNIdh2rjT+d
         ozEXq8c7TztpD6NbtqvnJJ6FbRsaOU1Sah304sunvqWml+E0r3uw+SnTSOLFUMNgzYR1
         l68rijeFX90q3csQGzfMHkxRE8QHuy9GHa8CCyUahbC82lHV3qdNN/uPTNIx5tGr8/1I
         Oy4AM5kZznGYqw+iFM1RlAO40mhPsWwuQES1HpKQmy5CNzJDuX87nvniZMwpQP3KW8DA
         OB3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685552610; x=1688144610;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Le5txtN+vXlkc1zaxXhjQiMsM93MRJ25LBvYo+mP45Y=;
        b=TXjpogUmKnGH0dulqR3Rv/Lt1/gTJA78TbR2zHc6xDTaLG4sB44ZwEXLHt4Sx8Y3j2
         OVPPBlIvrjvMV59WGvPmEdqfnAsgreazw0DRoTOSU8K+xTH+dYCU+WsqLrwh3DK3JAOh
         k9XKfhipD6jhGdg5N/zthYaPxOJE+JXdlhzdR4twvlnAvQmUbfQ7e4ImCU0bVNywtWN7
         1MezykJ/ajeAKsJTpuHkhpzGWiunKqnnnU4LHp8GZVCGrNOH52pN3RVryo2A43DCyYkJ
         nCghn4pxTxJ8nM9ciC3jfZ7/0idmlftEP9OgN75yn7aRIQbTJ9Nes8atzXnkQ6GFmq/R
         qh1A==
X-Gm-Message-State: AC+VfDx2kTI5VL07VyhR80L0tmoCwASB2jqlrWS51lO+Sy5RfYxWOYR8
        qKcrf6MbW+lCo0pzpgg+zGMUX63Hoq077tPgZOI=
X-Google-Smtp-Source: ACHHUZ51Qh2dDR6cFedpHJtPzSS/QhdQuRfe/bLQNiMxwyNurdDRVzRDb0IH/R/G/idS/CVjPTM9lWx22TkKZTvAo3s=
X-Received: by 2002:a25:d18e:0:b0:ba8:58b5:71aa with SMTP id
 i136-20020a25d18e000000b00ba858b571aamr6883846ybg.9.1685552610126; Wed, 31
 May 2023 10:03:30 -0700 (PDT)
MIME-Version: 1.0
References: <20230418214347.324156-1-ojeda@kernel.org>
In-Reply-To: <20230418214347.324156-1-ojeda@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 31 May 2023 19:03:19 +0200
Message-ID: <CANiq72mNWBTTwg0a-+V02eV3u3qKA-sBMrxsrvk=yPERg0p3EA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Rust 1.68.2 upgrade
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Josh Stone <jistone@redhat.com>,
        William Brown <william.brown@suse.com>,
        Georgy Yakovlev <gyakovlev@gentoo.org>,
        Jan Alexander Steffens <jan.steffens@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
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

On Tue, Apr 18, 2023 at 11:44=E2=80=AFPM Miguel Ojeda <ojeda@kernel.org> wr=
ote:
>
> This is the first upgrade to the Rust toolchain since the initial Rust
> merge, from 1.62.0 to 1.68.2 (i.e. the latest).
>
> Please see the last patch message for a long explanation of the upgrade,
> the policy for future upgrades and some indications on how to easily
> review this.
>
> The series is based on `rust-next`.

Applied to `rust-next` (with the `core_ffi_c` removal in the `uapi` crate).

Thanks a lot to all reviewers and testers (and thanks Gary for
re-reviewing our diff with respect to upstream `alloc`).

Cheers,
Miguel
