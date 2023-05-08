Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 457F36FB908
	for <lists+linux-kernel@lfdr.de>; Mon,  8 May 2023 22:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233354AbjEHUzo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 May 2023 16:55:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48232 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjEHUzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 May 2023 16:55:41 -0400
Received: from mail-yw1-x1135.google.com (mail-yw1-x1135.google.com [IPv6:2607:f8b0:4864:20::1135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97C237ECB;
        Mon,  8 May 2023 13:55:08 -0700 (PDT)
Received: by mail-yw1-x1135.google.com with SMTP id 00721157ae682-55af4277904so77377507b3.1;
        Mon, 08 May 2023 13:55:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683579307; x=1686171307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=iUL6bZHXpoha3XMlj2IGdVI2usoQwo+74wheB9tvv7w=;
        b=NlliaNkYAzvtQ631h2coCUi6YwPr6BgDKergqt2miNrENMvgTETrafDuEd4Wp3wn5y
         EGHZ42cX+7gp4SLeB/x057XCb0PoZodZl8LcfSOImGCl6Z3dSQYqk2nHr0XHTHCFffZ2
         IrK9KkTuweFGxKvZXPLPwLpxAxdCIFIzOg3KL4chY7rwXnMJqI3tHxZGi4RnHaS8fn8T
         U85MVPueSBQCiu0M77nGmYNfIfe1Yh6hd1Ea/ztzJ0bhjjBufuemxNGltpmb+6wy7zwz
         uEdbWS7d+9f+5E5EmboS0Y7OOnp2CijDodnjRLwNxW40LCK/0XS4Kxnfj+2FTO+eKeuc
         2Jsg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683579307; x=1686171307;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=iUL6bZHXpoha3XMlj2IGdVI2usoQwo+74wheB9tvv7w=;
        b=hNCiVQSnQz7D2i0OCs0Je1AgS4DDJVwnAYNRlKjdEn3eQuh6tphqNdDI9ky3+2jCij
         Xsgq3lHql0kcZE7N6FVnpr8he3AFhnxnql6i0dyg1tqArpyg6c5Ef+08yMxB39dsUbmC
         B441FsU+/lOaXMPnTmtThgaXN6RFvthSBm00KwJv+cvuPd//dkIQ6czgr6BlfOfSpcGy
         5maM/zHF0tL979eFYM7Ic2wSrJwdK+cK/lYQbeRMksA7eV00I+ARAboc3QKAqSRuNqJG
         L7W28afMDgNWk4yXK+ZC19QcH7Fe4/0EN6FdQ5t+KkwJfoPfcEqt4LHegp3YVzTTYx61
         h6tQ==
X-Gm-Message-State: AC+VfDyJBwIex0zzuIj5T0SOFLaX+PRRfmF6BUc2z+phj0LgMOab4m2n
        0g65NqKHRAdBGYnG/qIh9spwZqMU1NbLLslc1lM=
X-Google-Smtp-Source: ACHHUZ5VzkKyzg6GV5YIytOoHQpWRqSwfq7/A38Cw1mMHo3rs77+MNQv0FdyUumN60IDWDW97pc2OwebGtw/DU6kSJw=
X-Received: by 2002:a81:6007:0:b0:55a:9303:1fb4 with SMTP id
 u7-20020a816007000000b0055a93031fb4mr12043243ywb.32.1683579307639; Mon, 08
 May 2023 13:55:07 -0700 (PDT)
MIME-Version: 1.0
References: <20230507152232.803-1-ben.gooding.dev@gmail.com>
In-Reply-To: <20230507152232.803-1-ben.gooding.dev@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 8 May 2023 22:54:56 +0200
Message-ID: <CANiq72n-swO1L1zsPNDz=ZMMm=Ox5MOJHzXBbxgX0f_vWFWDmg@mail.gmail.com>
Subject: Re: [PATCH] rust: lock: Add intra-doc links to the Backend trait
To:     Ben Gooding <ben.gooding.dev@gmail.com>
Cc:     Benno Lossin <benno.lossin@proton.me>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Sun, May 7, 2023 at 5:23=E2=80=AFPM Ben Gooding <ben.gooding.dev@gmail.c=
om> wrote:
>
> Also fix a minor typo in one of the comments

"iff" is not a typo. Even if it were, it is best to avoid mixing
different types of changes in commits, to keep them as small as
possible (though sometimes there are exceptions).

> -/// Exposes one of the kernel locking primitives. Which one is exposed d=
epends on the lock backend
> +/// Exposes one of the kernel locking primitives. Which one is exposed d=
epends on the lock [backend](Backend)

What about simply:

    [`Backend`]

? (assuming it works).

Cheers,
Miguel
