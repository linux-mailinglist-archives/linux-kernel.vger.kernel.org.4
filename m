Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 831B3732453
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 02:41:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232315AbjFPAls (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 20:41:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229480AbjFPAlq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 20:41:46 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17C3E1BD4;
        Thu, 15 Jun 2023 17:41:46 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id 71dfb90a1353d-460eb67244eso43887e0c.1;
        Thu, 15 Jun 2023 17:41:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686876105; x=1689468105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=Qol4pW950bVrPxMcx9m5G6bgEMEiZH+6L8x+VD8KC8A=;
        b=hzT1SI9cDM7BqgPvmr2VaaxDdIxGT2vQ0D2KW1SseHaFxTrV/HGVivpT4WRGzJRlyh
         4gDwz6Hul54N+HOohx0FuMXuMSfO+rfU8xq3HbMnhgkeCLZp3LzQHSofoCRfjeXxToH6
         M41xOOerk71Y0CBKnCEELEUVkKGpizsfoW6JHSRgAwsTdz14dkWNBZDOzLGD75kf6JlT
         jAlSYACo+rJO3d8VWNDbz0qd6l1lCqNFM7XMBhW9v7Kwrq1FpDFisEYoLsVovIdkqI+C
         GruRNrp67pOlWemOlNK2PRpMVq9QZD/lnl29e8Xn7W8ngF6uquf1qH0fyExAjubvgUpn
         8nJg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686876105; x=1689468105;
        h=content-transfer-encoding:cc:to:subject:message-id:date:from
         :in-reply-to:references:mime-version:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=Qol4pW950bVrPxMcx9m5G6bgEMEiZH+6L8x+VD8KC8A=;
        b=YcbjTSFhkPceNMjhSxnJojD04UWTd7Z1/fo+Tc68vyKiQcnyYPAblrB/GhKcB9aqLd
         HfeOyCxtvn1JlWq8invSQ92wwLIzsyUj/fit1sC8SkGHmG16Q0Dsvge9V1Ko+xi9J+2a
         LTiQXt3rzKFFXdCRVsgkvqIDvVnbs+ZOPLB1BwKoE4tte2Oj9s9JLk8fYqdphjKHf/ie
         Ceu+nkN2Qt62i2XxvfIOiaSRZPZDX7hi8/O0KSCiajkaknwW0IRfuWh2KVPlANYogxDB
         WKR27a4C7vJ+jx3LblRGU65j/bAgvGF35OsdX9ZHnKPg+KmmKaMxzFOA2a8AqBlHwKD+
         OM9Q==
X-Gm-Message-State: AC+VfDx4YwIzfV0V3VZN5x6cgZkbZ//JZ+RwqRR0ia3nx1X8TkUfFg4+
        68Cd4RswERbH4pctBnQLI54XxIRZilIv1H+vzL8=
X-Google-Smtp-Source: ACHHUZ4dpaBRKjiODf3+MZwId8nX7G6NUoJYnfE5Hq4PElCSsMM0Nqc+53GZ0BMXmjNyDcRXMeaeQFSmN0jJgsK2aus=
X-Received: by 2002:a1f:5546:0:b0:443:6db9:24e with SMTP id
 j67-20020a1f5546000000b004436db9024emr707946vkb.15.1686876105146; Thu, 15 Jun
 2023 17:41:45 -0700 (PDT)
MIME-Version: 1.0
References: <20230528131802.6390-1-ethan.twardy@gmail.com> <20230528131802.6390-2-ethan.twardy@gmail.com>
 <525fee98-c694-6a38-cd1e-dd7efd806620@gmail.com> <CTCD11G9NVTB.3SYR2GFA5VAB3@hackbook>
In-Reply-To: <CTCD11G9NVTB.3SYR2GFA5VAB3@hackbook>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Fri, 16 Jun 2023 02:41:34 +0200
Message-ID: <CANiq72=YQyqtpXZ+Hp9oySwfmBS6OJ1ik-zxXx4mSF34hruqbQ@mail.gmail.com>
Subject: Re: [PATCH v2 1/1] scripts/rust_is_available: Fix clang version check
To:     "Ethan D. Twardy" <ethan.twardy@gmail.com>
Cc:     Martin Rodriguez Reboredo <yakoyoku@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Tiago Lam <tiagolam@gmail.com>,
        Kees Cook <keescook@chromium.org>, Finn Behrens <me@kloenk.de>,
        "open list:RUST" <rust-for-linux@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CLANG/LLVM BUILD SUPPORT" <llvm@lists.linux.dev>
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

On Wed, Jun 14, 2023 at 2:08=E2=80=AFPM Ethan D. Twardy <ethan.twardy@gmail=
.com> wrote:
>
> Thanks very much for your testing and review. Do I need to take any
> further action to make this patch ready for review? I sent out a v3
> version of the patch, where the only change was adding Reviewed-By and
> Tested-By tags to my git commit--since this is my first time
> contributing to this community, I wasn't sure whether I needed to do
> that. Thanks!

You did everything well! The patch looked fine to me, and the commit
message is detailed. The tags are all fine too. Thanks a lot for the
effort!

I had v2 of the script improvement patch series in my backlog, which
normalizes to `sed` (rather than use `grep`/`cut` etc.), adds a test
suite, and a few other things; but otherwise we could have easily
taken this one, because it is well done.

So, you did everything right, and you are more than welcome to send
more patches like that :)

Cheers,
Miguel
