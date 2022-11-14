Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94EAC6285CD
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Nov 2022 17:46:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237958AbiKNQqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Nov 2022 11:46:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235941AbiKNQqR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Nov 2022 11:46:17 -0500
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1C70A2F028;
        Mon, 14 Nov 2022 08:46:17 -0800 (PST)
Received: by mail-yb1-xb2f.google.com with SMTP id o70so14107078yba.7;
        Mon, 14 Nov 2022 08:46:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=6PDWKr1Lico+R6l9kWk21WMB4IP6L9ftmFPgT8rPDko=;
        b=SgkbCIZ0KaM/6mUz/qPDJN6WPOynC0EzEswiXIAhp2nvPH2C+AHIVkTmNuBRkTCEZd
         D9Jt5Hc6kiRV5T5gYd9VZlTdUFggkr/AKZkgj4dPhwzr9fiKnhBfiscRtrweLCqRF6PL
         e4PwmFUtsEtA5k45fYIlPMRzzpgjcmXg0libX3BB4Fr4Td+CQEwG/EDvxAGjd4qlKXqe
         P6QfLOAftwBAklHJ0EDSmmSfYQGkIk5ZWnhEGE0Em2TwBtHgbOgnq5BU+tDQD4oKKtPT
         nAVhX5H7D1AgVgg6ItVj6D9Uycu6aLKdSURb/4SUfehymHwkndbefjuJf3oCz7Sgmwy1
         lxnA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=6PDWKr1Lico+R6l9kWk21WMB4IP6L9ftmFPgT8rPDko=;
        b=xwZDsTzhrT2TT5s58OMk2Xi/O+Yzy3Pl+J12IR1+sYmPyGnWkP/1QMGTbzLB/OdA+0
         uzELber6u0XmFxm6yv6ln9BnETebtEfJGfnlZaSLOMC3l6SVPf8EqPz4Zx6qMCoEEXDj
         r1dd+K/PyPbvnaRgB4fgM1SOTDd4IMBLRTy4Ylv2RZnGHDcOnZATnUlWh4ylupCdieRE
         6bhI3u826Zo/Wklszropfl++mqgY7Cdvlf4/ihU9LqS1x9ZZYf5lHmGjDh8/Oifz8vAS
         93nign0QzKyt22jhOmKoyjioBqFUb19war4m9OzTTpkunoT21GVb8VGDah8LmtdsXxfO
         YhoQ==
X-Gm-Message-State: ANoB5pkGrMF/naNqsMoX/7745E4DqzRhKsOghlztx2+j3qgcbOX/u1DS
        9Ksys1dhovzpip4sw9RrNg4rQSF2/aKJYVP635I=
X-Google-Smtp-Source: AA0mqf4z1gnq/YSPfIwEXyKb6zjnFt9rolNflsgmMyDDkftPESjmz6aCvolB1Ttivp89/7uE+JKd1GOFH3lxM1kn4/g=
X-Received: by 2002:a25:8503:0:b0:6be:9368:4bcd with SMTP id
 w3-20020a258503000000b006be93684bcdmr12983927ybk.632.1668444376320; Mon, 14
 Nov 2022 08:46:16 -0800 (PST)
MIME-Version: 1.0
References: <20221110164152.26136-1-ojeda@kernel.org> <20221110164152.26136-8-ojeda@kernel.org>
 <Y3JU5xAGv3bNG7q2@liuwe-devbox-debian-v2>
In-Reply-To: <Y3JU5xAGv3bNG7q2@liuwe-devbox-debian-v2>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 14 Nov 2022 17:46:05 +0100
Message-ID: <CANiq72mE5=R4fv4Qee+hEkuXSHPjO3RzmOU45mqE3ztJ8XfS4A@mail.gmail.com>
Subject: Re: [PATCH v1 07/28] rust: macros: take string literals in `module!`
To:     Wei Liu <wei.liu@kernel.org>
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 14, 2022 at 3:47 PM Wei Liu <wei.liu@kernel.org> wrote:
>
> What's the rationale behind allowing UTF-8? Why not stick with ASCII
> only?

The reason is that there are already some cases on the C side.

For authors, there are about 158 non-ASCII in the kernel tree (if I
grepped correctly), e.g.:

    MODULE_AUTHOR("=E6=BC=86=E9=B9=8F=E6=8C=AF (Qi Pengzhen) <aric.pzqi@ing=
enic.com>");
    MODULE_AUTHOR("Martin Povi=C5=A1er <povik+lin@cutebit.org>");
    MODULE_AUTHOR("J=C3=A9r=C3=B4me Pouiller <jerome.pouiller@silabs.com>")=
;
    MODULE_AUTHOR("Uwe Kleine-K=C3=B6nig <u.kleine-koenig@pengutronix.de>")=
;

There are also a few descriptions too, e.g.:

    MODULE_DESCRIPTION("NAND flash driver for OLPC CAF=C3=89 chip");
    MODULE_DESCRIPTION("NHPoly1305 =CE=B5-almost-=E2=88=86-universal hash f=
unction");

Cheers,
Miguel
