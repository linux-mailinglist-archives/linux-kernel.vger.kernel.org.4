Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DC13717D06
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 12:17:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234452AbjEaKRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 06:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234649AbjEaKR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 06:17:26 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E02FD12B;
        Wed, 31 May 2023 03:17:24 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-5659d85876dso71139207b3.2;
        Wed, 31 May 2023 03:17:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685528244; x=1688120244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8aJTVJ6fsmZqPnk0Qc6OHM7P7yQlmbjh/uepd5OnvJw=;
        b=DYjgBrL2nYR3qv6j2S/k3/jGlIvaW+DCGyO7AR+oQswHCG27NtkxuG93RejYRZ1FhV
         fH1U9ecA2DIaXmxezNbkyrPr0UdrNH0/KOdT/qh24vXgKdEtelWjRf6K2GX5gvUXWnjL
         08Yv4o2aN9v37axJSRw9fIE3sGDngNNivogwD+AUe8P79NfNxszoFh6PxJ8xYsUlRPAQ
         pMabT2hdp5Sgs4PCJGU07mGnA2PHZJ5k6Bd14H+ffKlcXVML6s0QGF/h2p60bfWd3KWb
         sty1BAWoiCIL+0EU+1HzP/NFrIIqdsJlNHscQcbHUAhReV6K/w+m9WDFV9B3SwDzV3Fs
         2JIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685528244; x=1688120244;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8aJTVJ6fsmZqPnk0Qc6OHM7P7yQlmbjh/uepd5OnvJw=;
        b=aNr9IiQ8QYr6QbrRNwruD9uiOQEvKY5/MuMFxRW7J8lmnO0khFPF2Rk02yCOm4LLxN
         arT/wnQIcEFy0f54xxy0/QBW1pvWOeDInk/Hdc1RkckXd4I52ypyfAazAKohkAQTvX96
         gPwGNLBW0FWhGiONb3k9RijkiHJGl42feKGYnosrmPS0GBQynQyIj2rHDMLQwYyJiM7u
         zvEshwbZLONFcogTpYowF7w/0qFHxlZWrZQ83WmgNAfQqkxKDmaOriQPj1jm9NoZVPDb
         1s5qrRUZW4zB26lSOc+hIeiqtxfCgRjohwX86sY3S+Kc9pGoGoofc8HqLeYW0vLQDoLD
         waUg==
X-Gm-Message-State: AC+VfDy1uRZ/9iMf/kxgeqQhVgordZMOWO7CYagO2KLX+2rsfedmsSIg
        rimZWkSeviCDRO1AvJ/br4AMQtAewwMxD5k54To=
X-Google-Smtp-Source: ACHHUZ5zItvcup3RKZId4mS1Hz0hyLAha9VSHp0tlG73QaY4jil9Ir/LmdK4uzlEt3wPS//HG8R1Q3pAm0dVcCWRqJ0=
X-Received: by 2002:a0d:dd82:0:b0:556:ceb2:c462 with SMTP id
 g124-20020a0ddd82000000b00556ceb2c462mr5406527ywe.2.1685528244054; Wed, 31
 May 2023 03:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20230530064821.1222290-1-changxian.cqs@antgroup.com>
 <20230530064821.1222290-3-changxian.cqs@antgroup.com> <2023053003-antitoxic-popcorn-b1ab@gregkh>
 <ZHZBacreRpd0D/FV@boqun-archlinux> <170fa8d4-7851-cc1a-14ba-7213d0a5da0c@antgroup.com>
In-Reply-To: <170fa8d4-7851-cc1a-14ba-7213d0a5da0c@antgroup.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 31 May 2023 12:17:13 +0200
Message-ID: <CANiq72mghZMnDFcAgjxu0swMYEbpkWS5vLMpA4zThH0KbtLwxw@mail.gmail.com>
Subject: Re: [PATCH 2/2] samples: rust: add `SgTable` and `ScatterList` selftests
To:     Qingsong Chen <changxian.cqs@antgroup.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>,
        Greg KH <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org,
        =?UTF-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Asahi Lina <lina@asahilina.net>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Viktor Garske <viktor@v-gar.de>, Finn Behrens <me@kloenk.dev>,
        rust-for-linux@vger.kernel.org
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

On Wed, May 31, 2023 at 7:35=E2=80=AFAM Qingsong Chen
<changxian.cqs@antgroup.com> wrote:
>
> Maybe I should place those use cases in the doc ( `Examples` section)
> and remove this commit

If you think they would help readers of the docs, then that is
definitely the best approach, because they double as tests and docs at
the same time.

Cheers,
Miguel
