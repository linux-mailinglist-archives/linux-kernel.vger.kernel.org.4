Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0894727F6F
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:53:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233806AbjFHLxD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:53:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232417AbjFHLxA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:53:00 -0400
Received: from mail-yw1-x1132.google.com (mail-yw1-x1132.google.com [IPv6:2607:f8b0:4864:20::1132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA9CD1FEB;
        Thu,  8 Jun 2023 04:52:59 -0700 (PDT)
Received: by mail-yw1-x1132.google.com with SMTP id 00721157ae682-56ca07b34b1so4387067b3.0;
        Thu, 08 Jun 2023 04:52:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686225179; x=1688817179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=zl1R25aFlMknfZ0TZaTg0XuHD/qftBgk3A9a/qrvBxE=;
        b=JkWwFpUHXV9of/EMlxEglfiJIwG1whJEIcTeXTzj0r1UXBhS3QQTuzkkduG01/PtL+
         Dc6zQvaguzzgwBx7WI0aYdeB7ZdtueyKcmvT7IKVzNRsqhuqwtYMPUyjy1gqCKi7EY23
         SDoM2b1Qy5nIPOupVMsQuZokYSz/qFGraoOECWmgxh0wTrApXG7k5bt7SAB/kFmj9Ux4
         H5IMMf5fkjKmupydwZm55ILHeDzk4y1Otqyjwmj34EZ6NbSwkuOhAZc6ig5rU70vV4i/
         Y8Mwh64R+JCNUx3ml3+xihLvBqH1Ja3Dh1iA1tYZ2SdKKDpJQVjhW0iAhUfUpepA3d1x
         UUKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686225179; x=1688817179;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=zl1R25aFlMknfZ0TZaTg0XuHD/qftBgk3A9a/qrvBxE=;
        b=DhlBh/6mCNcw8V8OMmn/ng8l0eb0wUuOEKbIMBYbXv9wLkue65tCJFZkI29/91rmQG
         NDuxLdfTqWYwBCGxM6nVL2gMAwIhsksoTN60ErZrllYWnTXsYFfi3RWtt92qz2o3l4mk
         IFDTP1jSHJ2sKhgKKfbROsZH6ErJ9iOq7oEolfZPbTzKG6MIzZXGbD7XgqSortxIB3lJ
         XnWmy8ex6QxBT9qHGIt20ncjUofzi7Vs5e6uJOJFZs2DzKkwNTEuQNMd+aeWfOXwXaGY
         lObg1sVZ+UK39QMfoLrkO6uN5ZyjQsO7y31NZ4MYBYsVh+zXP9+bqTtNDSJM3MUIBTbl
         85ZQ==
X-Gm-Message-State: AC+VfDwFc5HjTM2XjZWEhSQj/hqawcAtbpvj1gsPjjwY244ZCuI3gFQ+
        7b/YgjjsIgOWjshyyYpqh7i95s2j9xMaEMKL+QI=
X-Google-Smtp-Source: ACHHUZ6h6dDyv4SxutQEfzo1GDIGkQqE4VT4CGwB81++CdMgJ3EN0Xs26iS4UkX3+1xwEFlXbP9izWEIR2g4zFlOcTk=
X-Received: by 2002:a0d:c584:0:b0:561:b246:77ca with SMTP id
 h126-20020a0dc584000000b00561b24677camr9370671ywd.28.1686225178967; Thu, 08
 Jun 2023 04:52:58 -0700 (PDT)
MIME-Version: 1.0
References: <20230307102441.94417-1-conor.dooley@microchip.com> <20230608-dispatch-sneer-aa09bd7b2eb8@wendy>
In-Reply-To: <20230608-dispatch-sneer-aa09bd7b2eb8@wendy>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Thu, 8 Jun 2023 13:52:47 +0200
Message-ID: <CANiq72nnph7LS1fLRtHz8NJ91PWXPaUnm0EuoV3wrbvK398AnA@mail.gmail.com>
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
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 8, 2023 at 9:01=E2=80=AFAM Conor Dooley <conor.dooley@microchip=
.com> wrote:
>
> I do intend revisting this, probably after the min. version for rust
> gets bumped, I've just been really busy with other work the last weeks.

Thanks Conor! That would be great. We are increasing the minimum
version after the merge window to Rust 1.70.0 (assuming no unexpected
issues).

This is the branch I have in case you want to use it, I will submit it
soon: https://github.com/ojeda/linux/tree/rust-1.70

Cheers,
Miguel
