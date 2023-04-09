Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18BEB6DC16B
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 22:50:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229558AbjDIUuM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 16:50:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbjDIUuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 16:50:10 -0400
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E1B0273A;
        Sun,  9 Apr 2023 13:50:10 -0700 (PDT)
Received: by mail-yb1-xb2e.google.com with SMTP id q5so5809887ybk.7;
        Sun, 09 Apr 2023 13:50:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681073409; x=1683665409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=z4uA/PZhyRMMk5GoB6cHOQ65kanQ/bJwhy2p6O/Zt1w=;
        b=m85HxFaLVT57f7p7AJWuirb46PhbLNPGDGZOD0mfiAiFbmr3Vr/mWzMohnyINwhBr1
         pjv8uuQ+7fxQVId36XdMBSja8k+9Zlq4eS+/b3dAoHyccNYOX4N/Le75xTW74pgDPFqd
         7Dk2FaiZRb0CYxw0/nu3TK15dhEDBCKV0Jf+jeOl0/FGvbDeqkoXlp0sHUgpJf2+zi5l
         ZG7xFaJlN1t0bshkcE/xTNbSOIKRK4fsbhWaTqsFVOsoUmKOz5kNsSB+z1W/7znW1xVS
         LR3DSKIG9jO+W8bN+PCl9kw5lMePFhg90SG5r33l7Ogc5sUUdXeQLiC+Ahtfa7BMFtAk
         ju7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681073409; x=1683665409;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=z4uA/PZhyRMMk5GoB6cHOQ65kanQ/bJwhy2p6O/Zt1w=;
        b=z7bt5GXH8Z4jxlJsiCxNjuak91TJpmn+q2LuKYM40Y7lYci717PCNcU5VHeHGgWOnW
         PqTU8KUY7+bGkUuYXhv48ltRdbS+9NGPAg+kS1eZrLKoA3dWweApjLlSymsZxo2CmPHu
         IrNmA1YKmQ0hPE21EFOzzjQW2wka3MtIwRup4oV8gcZXfwxEGWredITEsADF5pd19rMr
         qc29T+qwVvblfy46VeDb2YhYEQf/GB+rycsqN/fhT/32w6+V7riBK6sO1vr23b8zpF1J
         8/X0QfuSL6DuTj41Dw3A+ir2R3QvRoZcZBRfFkj7Nda7lQ233w+KWvT82Wva/m66nUwc
         cvWg==
X-Gm-Message-State: AAQBX9fqpYsOILBG2+75RpCa2IHbknQJBjM6lydycKjBqc0rVr5ZwViu
        r9kVQSb+i11S5W3rNaThVGJmZw33Pu8XV2ahUZM=
X-Google-Smtp-Source: AKy350aXxIYz9SEDrJ2G6dPDWup8xG3s1+4xG93/9q5aFCJ5W0keCQpDL3qQKdnS7vGaoazrhKE7fc2l/wW1sePO2aI=
X-Received: by 2002:a25:774e:0:b0:b77:81f:42da with SMTP id
 s75-20020a25774e000000b00b77081f42damr5980918ybc.11.1681073409345; Sun, 09
 Apr 2023 13:50:09 -0700 (PDT)
MIME-Version: 1.0
References: <20230210215141.108958-1-andrea.righi@canonical.com>
 <8178319F-4188-4F8E-AD8D-DCC392E26DBF@kernel.org> <Y+daEOZgaiF3IMTX@righiandr-XPS-13-7390>
 <4E6FDE1C-47B6-46A6-AF31-28AEB2348344@kernel.org> <Y+entVlMoV83vyzz@righiandr-XPS-13-7390>
 <CANiq72nQ4-md=KxtUcz3jHDXhLUdw1JxgbSKp7QsN0QKS3pV1A@mail.gmail.com> <ZC+x8pqUVzWQ35fv@righiandr-XPS-13-7390>
In-Reply-To: <ZC+x8pqUVzWQ35fv@righiandr-XPS-13-7390>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 9 Apr 2023 22:49:58 +0200
Message-ID: <CANiq72ngN9bAiWaVVyJkkEK_WAoTQVb5mmYLMqs5PK7pu6gV9A@mail.gmail.com>
Subject: Re: [PATCH v2] rust: allow to use INIT_STACK_ALL_ZERO
To:     Andrea Righi <andrea.righi@canonical.com>
Cc:     Kees Cook <kees@kernel.org>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        bjorn3_gh@protonmail.com, Kees Cook <keescook@chromium.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org
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

On Fri, Apr 7, 2023 at 8:02=E2=80=AFAM Andrea Righi <andrea.righi@canonical=
.com> wrote:
>
> The check (< 16) looks correct and the comment also looks correct to me,
> this option will be removed in clang 18, as mentioned here:
> https://github.com/llvm/llvm-project/blob/llvmorg-16.0.0-rc2/clang/docs/R=
eleaseNotes.rst#deprecated-compiler-flags
>
> (Maybe we could add also this link as a reference)

Thanks for taking a look -- Kees' link added!

I removed "(as the name of the option suggests)" from the commit
message, by the way, since the name of the option suggests the
original `-ftrivial` option was to be removed, not the `-enable` one.
If that understanding is wrong, please let me know!

Cheers,
Miguel
