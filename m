Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3206718830
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:11:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229889AbjEaRLt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:11:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50202 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229890AbjEaRLo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:11:44 -0400
Received: from mail-yb1-xb2d.google.com (mail-yb1-xb2d.google.com [IPv6:2607:f8b0:4864:20::b2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CDC49191;
        Wed, 31 May 2023 10:11:42 -0700 (PDT)
Received: by mail-yb1-xb2d.google.com with SMTP id 3f1490d57ef6-ba81ded8d3eso8632007276.3;
        Wed, 31 May 2023 10:11:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685553102; x=1688145102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ebXJVsSOUn2ugmT4rghMz7fEudpo4P8yANA/KrthHSQ=;
        b=rWOXBBOyOrBpuPMg0lDoyufRLZkgu0GznDnPFyWVtJFifHw7Tw6NjeMYjynx7qz/46
         SbPowBCnn5Lk0cECatibpEFOHYw25O9dkF8KZTssbGCQvS2bETkGgaFsDoPaVQFCgFF8
         1Ag+EMJveJF1qPYsr7gYEYsuMPnSYtYucxdk8ZEODhO03hSbn8SKM+wKE5ZTsAfKfoGz
         TRKvv0kCsk4cQuTvEyzYhPpwcN13N2MsgYpBhyqaUG77IHqcoPNzESguACv0Xag1z7x+
         2rNMIFLpeUGL9PyE50gUuhWvoXnhXrmkTinHm30tpSKqm/dDqJU2GcxhmqFSrmAG1rnM
         xVJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685553102; x=1688145102;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=ebXJVsSOUn2ugmT4rghMz7fEudpo4P8yANA/KrthHSQ=;
        b=ctrcaN9uy4H6uvOlk0huAfk96bxg2hDJSy6PGEMyPHEK0BkrKWuS1AHw++3n8Xqaik
         wGXEfNCJ0IAPUalVjctSCXM/2cyTPOC/py2NvUO+o/pcclFaIp9Tv9dzYEkD6wxTI13Z
         zGNLyNdRo9RjwOxiyL6LEt03a4Uoqe9Y+HgPSG+EYYlJXjzTw+J46BAGYepTOqTN/1km
         yungQicd4WSU6FtW+0DduHJirWgE1k0khnY4C3Ltc4nW+3EanpJ36+zQC7NJZiZBIDG5
         koW7cHgJ7r3F8+qytvm51sx8RCFzVCNNZkEVf+4kEsuspOGzAgLxlniCz5hZenU7Becw
         KXQw==
X-Gm-Message-State: AC+VfDzY0nm+JaSN3KcfuXCcVucFK7DHQlP4I6SO3nm6bp6Rf2+Y7evm
        h8YHsDIRJ10tRpF1oBH8EaLKI3p/6UeZDOzR4gHYj9b4McAJTW0E6CM=
X-Google-Smtp-Source: ACHHUZ70MMpnGtaiZiK8Wa0uRar/BTF3XWEcNJkZ9HluytIz1Q1g/E693M33BQVNFcwmkJ0i279u/zrdRM/51wlt1/8=
X-Received: by 2002:a25:af54:0:b0:bad:13c4:3070 with SMTP id
 c20-20020a25af54000000b00bad13c43070mr6775546ybj.47.1685553101927; Wed, 31
 May 2023 10:11:41 -0700 (PDT)
MIME-Version: 1.0
References: <20230504064854.774820-1-aliceryhl@google.com>
In-Reply-To: <20230504064854.774820-1-aliceryhl@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 31 May 2023 19:11:31 +0200
Message-ID: <CANiq72=S+gUXcsp1k1ZUnRbsecnP5KCKVW-tJoqZB_NsT-2K+A@mail.gmail.com>
Subject: Re: [PATCH v2] rust: error: add missing error codes
To:     Alice Ryhl <aliceryhl@google.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
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

On Thu, May 4, 2023 at 8:49=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> wr=
ote:
>
> This adds the error codes from `include/linux/errno.h` to the list of
> Rust error constants. These errors were not included originally, because
> they are not supposed to be visible from userspace. However, they are
> still a perfectly valid error to use when writing a kernel driver. For
> example, you might want to return ERESTARTSYS if you receive a signal
> during a call to `schedule`.
>
> This patch inserts an annotation to skip rustfmt on the list of error
> codes. Without it, three of the error codes are split over several
> lines, which looks terribly inconsistent.
>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>

Applied to `rust-next` -- thanks everyone!

Cheers,
Miguel
