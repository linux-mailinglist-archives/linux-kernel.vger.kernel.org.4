Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F06D6D4DE7
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 18:33:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232202AbjDCQdB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 12:33:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232291AbjDCQc7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 12:32:59 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8DAF02D44;
        Mon,  3 Apr 2023 09:32:43 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-545cb3c9898so487069637b3.7;
        Mon, 03 Apr 2023 09:32:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680539563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=YVyyKhZhVKFELaIeQcqrXX4LwNgdwjSlp3Qd8NQAQ4Y=;
        b=alovpYhaZ6LPgZSHYZtdkBDDP0URHuvySe8G9XIGLclC488EV1E3u8rlGcp9dZbnFJ
         /i8Lzo6P6svFjgqn96yjhxT0ADCbnoj2Px0Gowwg4kddCMBKZwm3AmjpfV+9Gkh1WaV3
         Z97HoGa5/whNh0FKrEWHg/Svs0YwBmikaDdmu7JOj1JqIRkjxiafRgY58IWwyeOxGfHk
         qxn0OLjqQ1rLbUhR6XiXIjMbK3SGCGFnx64x3b0ilnbiCCWmir8GsI6733wJ47xX31MP
         8LOYK1RonB8ftVBLCb7+O1MaQS79d0rkBJUTkpeJKXOg2rDoN4sEoZgmxBq1BSBKjYCH
         gitQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680539563;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=YVyyKhZhVKFELaIeQcqrXX4LwNgdwjSlp3Qd8NQAQ4Y=;
        b=XjCR5RwvgIsj8lhg3gKeFncsN7nTqbrqhTOXaoLn7E/Xe6EbBulGndGfjUfdSU3XC5
         /WFBIa0Pzs4bIXd4ylQt9JwFtP4nrU5o4VQw/X5dLfE8BGSNUD5l6HK5oJnANlYBjxrK
         87p8euwBulBvyZZPgB7Y5Mf1uI1spYGqOpw7jBrqip98EbstkWBRmxAPSkwWzEFXk0gZ
         30Ox/8kDjVBeDdRDYZHdXc19UEen2umtT6iHkxnPb4jghe4QrvtemgJSzv7jNLl2haOf
         DzIenZuGlEN4UvOL3Ai1afZixXZYLfzkt8QMFOIESWcdzA2aTWj5nHoYvK0h+8RZ3L2N
         sTGw==
X-Gm-Message-State: AAQBX9fE2EM+vc93KKUp2Bj4hTZ8CaQpBIXzomxDRmHZbL4Q5bmw6GRk
        3AxSaZySSRx+2mSMChmHAKTUtpDBF3N6c51HTns=
X-Google-Smtp-Source: AKy350aADD43LM+6Fyr445lMNk19yeKF5hWPrYO4YfT7Tju/V/ectKNIFIvehRrqfUvXOPFrQuLZ31r3hVYGzRsmpTo=
X-Received: by 2002:a81:ac46:0:b0:533:8f19:4576 with SMTP id
 z6-20020a81ac46000000b005338f194576mr18159721ywj.0.1680539562651; Mon, 03 Apr
 2023 09:32:42 -0700 (PDT)
MIME-Version: 1.0
References: <20230307102441.94417-1-conor.dooley@microchip.com>
 <CANiq72=i9je2864iTvZBFnhVLhF7Cema7EPCcdWOJ3mr62SqDg@mail.gmail.com> <a6220e52-9934-422b-9b05-95705b8fd684@spud>
In-Reply-To: <a6220e52-9934-422b-9b05-95705b8fd684@spud>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 3 Apr 2023 18:32:31 +0200
Message-ID: <CANiq72=FN3zB-gajQYDxXmnmx7J0UNstFuexSCOg8Oe2fnG=yw@mail.gmail.com>
Subject: Re: [PATCH v1 0/2] RISC-V: enable rust
To:     Conor Dooley <conor.dooley@microchip.com>
Cc:     linux-riscv@lists.infradead.org, conor@kernel.org,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, rust-for-linux@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Mar 30, 2023 at 10:24=E2=80=AFAM Conor Dooley
<conor.dooley@microchip.com> wrote:
>
> Aye, but that does not mean that I am entitled to add someone else's!

Yeah, definitely! I meant that, from what you said, it sounded like
adding the `Co-developed-by` was OK without the other (i.e. due to the
"too" in your sentence).

Cheers,
Miguel
