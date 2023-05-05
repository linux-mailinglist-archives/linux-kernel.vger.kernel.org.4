Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCABF6F8076
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:59:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231902AbjEEJ7X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:59:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57754 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbjEEJ7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:59:18 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5C021816A;
        Fri,  5 May 2023 02:59:16 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id 3f1490d57ef6-ba1815e12efso1391843276.3;
        Fri, 05 May 2023 02:59:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683280756; x=1685872756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=5d14VMN/dsF84pYxIA+HqaO2W48hhJ6NH76UKybrOHI=;
        b=WhLJfFKieiNArlBXBw8k4VHZ/gQd6jJfyapaDf5LZ8depVowiY48yU9MB8qKG363Yh
         dvPU6ODE0dykQlianl3bbpt6FHeJ8Ph56WmSAtwIWsjlk1I8q0BckQti2OxsdRrVTCpI
         vlQkwJwURbE6QHR1jxhzr6GhUEz+iWjkaDv5ZikyqOE3oBmgaJkrrG7H6J3I/qIHKzS4
         BP5rpCjVh7qNTw+HJv2vkJ9InryWiHgkSqz2G+gyxw58FTvj/eBj4ozsP+Lo2bUmMaA6
         yZLOGRaiOv3pTdatHSs3zpx38vOWBCk6u/TP7ir79d8XCm2vw0wjRRe87LpJNcb0fOwJ
         Ge9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683280756; x=1685872756;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=5d14VMN/dsF84pYxIA+HqaO2W48hhJ6NH76UKybrOHI=;
        b=KecRbVX6bAshzKfaeT0Y+a1FH/HU3KMKCFdzcwRUzDLfz52DtS2eTAOJd9x98rcuxv
         t85GChM9FmE/78RqheAJbvfsZWjMZCb0f5HC5hP6QK/RxxlxZEsIjJiD1J+Nzq1xwYML
         zQEUmu0eyd1q/2iEpoAdFpGx/3rV4uy1L1383c7S2tie4ursH7N94EyquRAxICzfZ4Je
         Q4ZlN+Q9ZEE6vDgzELpmGwW9bpdJRF48Viv6W6q3WLbOhjLdqVVoS3OCf3AQIZy+AMdT
         6cUL/klYsUI+GWKIQ0rSyt+FBYA5PIIFmt7HnBGT9djw90shG5Z/9FYwaWg27QLe8V68
         eH+Q==
X-Gm-Message-State: AC+VfDx2bJ9z2ShE1+1T5H7qhNvdB7YgR3N7SZKJ+rOKu7Vvcx7cMSaN
        /Ip7szljAFziBy6xjQ64d9mXbXEUYLfaDyC1f/0=
X-Google-Smtp-Source: ACHHUZ598taEicUanJWBqC5xD3xyd3QwAlvZRfXr/O+pf/peYRpl819lf6glbrOTTHFtXPeY54wv6krCM6jXRtuDkkk=
X-Received: by 2002:a25:38c:0:b0:b8f:5340:b052 with SMTP id
 134-20020a25038c000000b00b8f5340b052mr1134211ybd.15.1683280755967; Fri, 05
 May 2023 02:59:15 -0700 (PDT)
MIME-Version: 1.0
References: <20230418214347.324156-1-ojeda@kernel.org> <CAPDJoNsG1E25yYM+L_H21vVCt-5S16etx3KMxx8ySZtWMQt4FQ@mail.gmail.com>
 <CANiq72mtb9V+1a7nPEHBCeg_fob4rpPTWJZjdahnGL2Mg3uoUA@mail.gmail.com>
 <CAPDJoNvGQBNN6X6fs26tjUy7LbpJjWwPvQuf=1+nSwj94aa6LA@mail.gmail.com>
 <CANiq72m7zdYo566PxX3g03+XPpHnrQy7GG9WkgEP82mK_2JBpw@mail.gmail.com> <CAPFo5VJpGq70X6efWESDoCYE3J0pjgMB1c7X_ACA4Q9MxnoHQw@mail.gmail.com>
In-Reply-To: <CAPFo5VJpGq70X6efWESDoCYE3J0pjgMB1c7X_ACA4Q9MxnoHQw@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 5 May 2023 11:59:05 +0200
Message-ID: <CANiq72ma+kGPWVGocuPoY6YL13PzCwEMgKN2Yi2Ok42jxBQdTg@mail.gmail.com>
Subject: Re: [PATCH 0/3] Rust 1.68.2 upgrade
To:     Fabien Parent <fabien.parent@linaro.org>
Cc:     Ariel Miculas <ariel.miculas@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
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

Hi Fabien,

On Fri, May 5, 2023 at 12:28=E2=80=AFAM Fabien Parent <fabien.parent@linaro=
.org> wrote:
>
> I'm getting the following error when running rusttest on top of your patc=
hset:

Yeah, it is expected: the series was based on `rust-next` which gained
the `uapi` crate later on.

Thanks for reporting it!

Cheers,
Miguel
