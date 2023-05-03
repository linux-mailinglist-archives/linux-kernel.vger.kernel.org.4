Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF6A86F5550
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 11:51:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230015AbjECJvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 May 2023 05:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46702 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230057AbjECJvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 May 2023 05:51:14 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E273459C4;
        Wed,  3 May 2023 02:50:21 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id 3f1490d57ef6-b980e16b27bso4089591276.2;
        Wed, 03 May 2023 02:50:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683107415; x=1685699415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=QekGgvtyEzq9qE+03olGY6PTWKf2S/rVt9efjf9645c=;
        b=WsTIAv3bpWOgkPRuIYqZmMp394vBVAZM3e+78YksbATEi6TYx4ncIdBp2gkiI/Dn0J
         g7ixO5LtBI9/wl5AveftdXS3FFfJUZlG3ZPDUWRNTZAUco1T6IOhftsb8O0Phf4PLbgA
         jjf5T5P5bnKzXbDMgnMcT4iAIUWEgY1idOvKAvnRH1hH5Nk7wVFwUM0XfSA8zkPzm0hj
         Pd29/tulY9tynfFbxQonA2XD6aZuFBLLAdm/7o8xG73OCngG2GFgpQHlD/jTeRh8ubpE
         LLUQpwqrePx3HWMl53EnRxveDxItayIq9LHi4Sr89Rf/E5mZnk6YjVILEsbRFG1gxqGy
         tLGg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683107415; x=1685699415;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=QekGgvtyEzq9qE+03olGY6PTWKf2S/rVt9efjf9645c=;
        b=Mv7i7cD6wz3/2RaFL0gzErchwgTDh6M7uDzJn6rETH7Ju/hP9l4ZfAn7RWdwdhQLLG
         MMX1FCaPJPq2dTEDHA+rY8nzsjtDMlpObjvft8gGzTEiDOJaZjmG0z5KjGWe141Q9K1F
         oCER1oCZ8HWYFnMODX/0yTDfco6kUPnely9WTJiKk1mi9UyQxdkqw6lz4nzdQki4H73g
         Umthfu5admlMyXAyxv9tJ/A9h8FLgozpJh2iVtU7WAu2hlfPidKWeLr5uQX5bTqFj90d
         Hnx3uuSjQX+bmsLxMO31Bnj1A/fWrXCByWQP/tSIsR/+p4ZzrdkOytfkWd/bL/2X31IB
         RhZw==
X-Gm-Message-State: AC+VfDwJ0miSGO5EDJcudYciJBEmn6OkpUC/rlD9wpljmowXaqWgYEax
        cWX00X66RR8eJZSfaRJlKCd1zGpXYm8OA6aCx1A=
X-Google-Smtp-Source: ACHHUZ51tM2esQU/LFCG4LG2gkjQEPdQQLrnENbaAmdLcdpeRoGlsvShOAlPwpg360fmYxWwDUfBitbPDNG576Eefko=
X-Received: by 2002:a05:6902:723:b0:b99:8359:b485 with SMTP id
 l3-20020a056902072300b00b998359b485mr22675047ybt.18.1683107415347; Wed, 03
 May 2023 02:50:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230503083941.499090-1-aliceryhl@google.com>
In-Reply-To: <20230503083941.499090-1-aliceryhl@google.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 3 May 2023 11:50:04 +0200
Message-ID: <CANiq72mz7rjsQ6kP4ttsMwSozwFWk-CUzChYf+vkKtTV6QtSOg@mail.gmail.com>
Subject: Re: [PATCH v1] rust: error: add ERESTARTSYS error code
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

On Wed, May 3, 2023 at 10:40=E2=80=AFAM Alice Ryhl <aliceryhl@google.com> w=
rote:
>
> This error code was probably excluded here originally because it never
> actually reaches user programs when a syscall returns it. However, from

The reason is that commit 266def2a0f5b ("rust: error: add codes from
`errno-base.h`") only introduced the ones from
`include/uapi/asm-generic/errno-base.h`, but not the ones from
`include/linux/errno.h` (or `include/uapi/asm-generic/errno.h`).

Given this is an independent patch, should we introduce the rest too, at on=
ce?

Cheers,
Miguel
