Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A01A76941CC
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 10:47:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231144AbjBMJrE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 04:47:04 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230514AbjBMJqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 04:46:53 -0500
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E129C10410;
        Mon, 13 Feb 2023 01:46:49 -0800 (PST)
Received: by mail-yb1-xb35.google.com with SMTP id q4so13644733ybu.7;
        Mon, 13 Feb 2023 01:46:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=DBU/ezuP0GVZ71fNKByQduOfc1Jj+Dyhk2z5lN1UcHI=;
        b=NBNUxdc/tTsxKJOc6uvnhDC66rqqxbTcmzHQHYKxiKlnyjUoKke8b8ewwvKGwzf4Su
         nSG1DAsLuyPBut5fsyONjm7AegpbSeVD3ap5eoGrzk/fp5mNQhNqGrwBNjVStR2SRdVZ
         SEI2b2VyAGSyt7gS3sAb6rSMTIcGyR4Jhi6hkIzgz7QEo+DoUtV1vB9DM8ohVWYJ2q+m
         tB1EmPwjo4V0VpazP1j32PMbeHFzaPQFdcxHPeZM0U+0D+vTfTootUkiyfcKKMtZ/6ZH
         VfwIfCjMoBOw/U1JrGsN5nFvRFj5EfuVgU6rT0hGV1ZTtYSpw7WbqqdB7vw4yVhevse/
         +0Tw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=DBU/ezuP0GVZ71fNKByQduOfc1Jj+Dyhk2z5lN1UcHI=;
        b=UEJjVTOIBVuB4WR2BR+uXFy6D27IhS027yNOaY+/uKB6Fp0clpQWoCLBAnfCE2FzyM
         XJ26yNjANomLXXxwC1XT2eRNAypBi7hyVbcbyl5iJ1SFGOofIEIWewCdNXk22zrUmPgK
         IwXMSdZtxJby0o5Vlfe182kLH99HvVf0aanosPzLAGHsS86Y9Rd/Fv955Us9VKow/pat
         PsMZ1A6nVQ1BAYctUMNMqf7mwunSX9A8J0ruawxXhwRNf6eTByulL/JggDxDb4ku65Ig
         aErSKkXqRAYBKR9IkaosFeKrgBT8z483XLyaJpfU9lFM9dj7PUoUCyV6iEiu/RiJWfYF
         gRXg==
X-Gm-Message-State: AO0yUKUyB0nB5YBXI//4m/3BFbhaeq7Hr1k5hbLIZEIM6mfQq8ISWseI
        glgMY9lBEVKLfZYUPhLD/BmDZifA2rFe3O5M7Qc=
X-Google-Smtp-Source: AK7set8PJjCEMwd12n25PFAgAl0ylUJ2NdJ5pPMq70cAwtxduPOojHj+XQ7nKVWAqmRMjVH4gSV1uUmUmyNw9SFelD0=
X-Received: by 2002:a5b:3cb:0:b0:8e3:28a8:bb5c with SMTP id
 t11-20020a5b03cb000000b008e328a8bb5cmr1410452ybp.154.1676281609042; Mon, 13
 Feb 2023 01:46:49 -0800 (PST)
MIME-Version: 1.0
References: <20230213152714.78b844f4@canb.auug.org.au> <20230213085920.19726-1-bagasdotme@gmail.com>
 <1058405569.122806.1676279498018.JavaMail.zimbra@nod.at>
In-Reply-To: <1058405569.122806.1676279498018.JavaMail.zimbra@nod.at>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 13 Feb 2023 10:46:38 +0100
Message-ID: <CANiq72m46N-85C+djWk6iYzWxk5fYGqfzD3wxfH+n=aD-Am46A@mail.gmail.com>
Subject: Re: [PATCH] Documentation: rust: Fix arch support table
To:     Richard Weinberger <richard@nod.at>
Cc:     Bagas Sanjaya <bagasdotme@gmail.com>,
        Rust for Linux Kernel <rust-for-linux@vger.kernel.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Jonathan Corbet <corbet@lwn.net>,
        =?UTF-8?Q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
        davidgow <davidgow@google.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 13, 2023 at 10:11 AM Richard Weinberger <richard@nod.at> wrote:
>
> Applied to linux-um next. :-)

Ah, I didn't notice you picked the series (I think there was no
message) -- thanks Richard!

Since it is still unsorted, I am taking the chance to add a "good
first issue" for that:
https://github.com/Rust-for-Linux/linux/issues/965

Cheers,
Miguel
