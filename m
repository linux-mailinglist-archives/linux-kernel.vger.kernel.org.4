Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DBCF47187FF
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 19:04:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230013AbjEaREn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 13:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230025AbjEaREk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 13:04:40 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D10E185;
        Wed, 31 May 2023 10:04:18 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id 3f1490d57ef6-bad1ae90c2eso7807317276.2;
        Wed, 31 May 2023 10:04:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685552647; x=1688144647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=8KXdktmKQSTfg49U3Ho2uouVM63rMaQ3xxjCwRVDkuA=;
        b=ZW9TJc8e5wW40L2EWaaanO2FC2j67mAPBfqnvCuQ8BSAsGyxg9zbYAnnQQQKiQSVv1
         pvISI6kcIgeLGNGg7/AdfDRNaofDpwhMCGeAIK6ro2JBgq58eU97/1cgYFMvQWR7CzJU
         xwoA12qihjPMP/lZdJyp+OsTrUz1ssjITCHgkYhA62UAdXSaHvVr1sY5O0rqm86DeeVM
         be4ZjGdImPqMihtqE5rjtcanNQMt86JU1uHQgNTayhumLF1y7grq1oRzk4xl1BEWdqPy
         CjT+vxiRr2all8AJPT4by9jgL1nhLhDuDEha3snm6XT1o16s9ncrce1rF0ruR8MULn8L
         p7Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685552647; x=1688144647;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=8KXdktmKQSTfg49U3Ho2uouVM63rMaQ3xxjCwRVDkuA=;
        b=I6wM1Qa0mR7fxnHpYPfgBGDo4FoJsNOiAdtVhbB4ArXWxM07BWuIw9vLdR4J9ZWSDP
         le1ZmDhQXiHOwHvN2YF8ZyjxN4XrN3fTD6xZjXq5DiIbKpjKezIs9LeKxkZ86NyXpttw
         yV2xRam/YQj3E3MlagnMLGp4GwTP/eaYptIsCUJXkAQlSsCRr3W1m7Iu9icog1jJZwMS
         hdsWCjwMJsKRcgKj9MeteCSN6OiGx8QCQiE2DUlPbwGr4RGelhsyQxVPglaBdDEk7l2f
         5fN5xXbJXLDxpgDRMP1oNWA5Vbx7b6Y01ffP9A5yScmzcR93izalIpYUlqRzV7GtI3j3
         dipw==
X-Gm-Message-State: AC+VfDzmA7SP0jEF49U3fJAtKlO7XVcxli9UxQ5WvaIqKtIKjHD9EKsB
        QzU4hRlayDfLKbeTtcxODdlapHfLvLljWY85TC8=
X-Google-Smtp-Source: ACHHUZ5pB1GtDTEFqlJRc3BAMpPDaoSK6i0zWlcLo+S/LKo7Zk/+s3mGnujsY/caFmwOWmyEmIF0OgoNkbIi+4ncAFM=
X-Received: by 2002:a25:2fc1:0:b0:bab:dedb:522d with SMTP id
 v184-20020a252fc1000000b00babdedb522dmr6246137ybv.47.1685552646624; Wed, 31
 May 2023 10:04:06 -0700 (PDT)
MIME-Version: 1.0
References: <20230418233048.335281-1-ojeda@kernel.org>
In-Reply-To: <20230418233048.335281-1-ojeda@kernel.org>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Wed, 31 May 2023 19:03:55 +0200
Message-ID: <CANiq72kR=QzZ9SH-ndnh7oShBJoFCKSiPWSJ88wJKaEmvvCtrQ@mail.gmail.com>
Subject: Re: [PATCH] .gitattributes: set diff driver for Rust source code files
To:     Miguel Ojeda <ojeda@kernel.org>
Cc:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Jean Delvare <jdelvare@suse.de>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 19, 2023 at 1:31=E2=80=AFAM Miguel Ojeda <ojeda@kernel.org> wro=
te:
>
> Thus set the `rust` diff driver for `*.rs` source files.
>
> Link: https://git-scm.com/docs/gitattributes#_defining_a_custom_hunk_head=
er [1]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>

Applied to `rust-next` (with an extra link based on Gary's) -- thanks
everyone for reviewing!

Cheers,
Miguel
