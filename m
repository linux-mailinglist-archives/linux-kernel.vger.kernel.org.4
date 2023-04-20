Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EF4E6E95AC
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Apr 2023 15:20:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjDTNUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Apr 2023 09:20:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229671AbjDTNUH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Apr 2023 09:20:07 -0400
Received: from mail-yw1-x1134.google.com (mail-yw1-x1134.google.com [IPv6:2607:f8b0:4864:20::1134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3A49730EE;
        Thu, 20 Apr 2023 06:20:06 -0700 (PDT)
Received: by mail-yw1-x1134.google.com with SMTP id 00721157ae682-54fc337a650so41181157b3.4;
        Thu, 20 Apr 2023 06:20:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681996805; x=1684588805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=GNWH6oFsPxt4uPBf5ZSd4rkNU90YfqXsmZC9RT6Nk4w=;
        b=iBt7XnIlW5ja5FIDgbzbXy90Z5dz+WEqL1GT5rddfr4IDXDBglyDQqL4MB3d5wV79O
         72WaiSC031h4s62DtdESzUHchGzdGsLEEZB3gkKiHP4P4QE6zXkkNfBsK/y91Wg1j6We
         p7AIjuCPht+pvxNVK++2byKRkYY48tFcv2pbfG0lW6jCN+vV6VtQiwt7sYxpRxr1N3BI
         Lvv4EeickuOUPtUEQb0T1dkxPCFzPtUueuiozLiIPscAtaIuop9+mk/+qln+j5blJS6R
         SCq13GOqi/uUtHoAw40p4I8fQE8DVKqpzbdWYqn4U+Qn77EhdAzZOvoGgHmLRHQBHDux
         MLjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681996805; x=1684588805;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=GNWH6oFsPxt4uPBf5ZSd4rkNU90YfqXsmZC9RT6Nk4w=;
        b=jH4cGy9iKZ+6Z/DHsBK1Afqp/Bdlrf4bzk6yGUov1XkXUyFivqaS4VG4Qz5g+qwAll
         4BkpnLO2bD1npx5wQldPY44zA67tJybDtUYZ7rNEJ8ADSHnBbkOvYcfqi6aFrBdK6zDc
         p2Av8u5MF3slIyk76RNegF6lrfIXoEheFsRcnN3nQPnihPzNTOP4ZxFrWPI+OVmwy9RP
         s1Ip97NlBuKnz0rUvjgCW3pTTJsGEN1RFZAENwa1GDbo4G08Bl9Ce+VAczXhAGbwtjf+
         Ptac5B1Rir245i8AwcLi+dbAy6aCqfaQQVM15vhxGXaxS6nOdmUPCRuIB15kOVpY+hpn
         XYeg==
X-Gm-Message-State: AAQBX9fFWVTqRk6cszy20dl6bNLFE1f/AjTxC3eQbkxo77MMAWpd4oCi
        N9BkrJ1BzpLrwEBQFYPXB8b2kqvDvywLw8rFoT8=
X-Google-Smtp-Source: AKy350Yna17ciObxlr7T445+ng1yrw5kvVgZMoxKaKzazogoVuc+cNXRmbuMczDLtoYwXPnB4yL2NRiFKi3fLM1VgfE=
X-Received: by 2002:a0d:df50:0:b0:54f:a5ed:1978 with SMTP id
 i77-20020a0ddf50000000b0054fa5ed1978mr754804ywe.38.1681996805473; Thu, 20 Apr
 2023 06:20:05 -0700 (PDT)
MIME-Version: 1.0
References: <20230418214347.324156-1-ojeda@kernel.org> <CAPDJoNsG1E25yYM+L_H21vVCt-5S16etx3KMxx8ySZtWMQt4FQ@mail.gmail.com>
In-Reply-To: <CAPDJoNsG1E25yYM+L_H21vVCt-5S16etx3KMxx8ySZtWMQt4FQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 20 Apr 2023 15:19:54 +0200
Message-ID: <CANiq72mtb9V+1a7nPEHBCeg_fob4rpPTWJZjdahnGL2Mg3uoUA@mail.gmail.com>
Subject: Re: [PATCH 0/3] Rust 1.68.2 upgrade
To:     Ariel Miculas <ariel.miculas@gmail.com>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
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

On Thu, Apr 20, 2023 at 3:13=E2=80=AFPM Ariel Miculas <ariel.miculas@gmail.=
com> wrote:
>
> $ make LLVM=3D1 rustavailable

Since you showed the output of the other commands, did this one show
"Rust is available!"? I guess so -- I imagine you edited the commands
for the email, e.g. the config changed too.

That is fine, as long as it works as expected :) Thanks a lot for testing!

Cheers,
Miguel
