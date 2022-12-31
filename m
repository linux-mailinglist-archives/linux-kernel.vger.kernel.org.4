Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0E3965A548
	for <lists+linux-kernel@lfdr.de>; Sat, 31 Dec 2022 16:08:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235763AbiLaPIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 31 Dec 2022 10:08:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235694AbiLaPIE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 31 Dec 2022 10:08:04 -0500
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E69763B1;
        Sat, 31 Dec 2022 07:08:02 -0800 (PST)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-46198b81e5eso333475687b3.4;
        Sat, 31 Dec 2022 07:08:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=twLNZ5dF3uUkYx3D2ftZufmrlbnxR2cyL777pTO1PI0=;
        b=LxePxxMkWCk+99u7qDLqrYjNmY+364ybIOtB6ESq1r73+lFr23/RTBoOLkNs/MmFWS
         el6X61EQD++vuM7NR/QMk4Yql/losA1bRvmSnVhZ7vPcujfBztvkRPiAMXaqdtD7o2Pq
         6yMbCbu7+qlPFLO+W+aESL2s6h3TKQ7owLAeQ+++q49CPnXic2u8zXw/U5Q5sahZTw3+
         cZFlnIItk8UPCdYGofXYZg8UecDVDFLMi+kjS/bmWL98JQVaaRYpbWSj/zZsfMZ5o008
         yPd63lVYvb4X/cjrMGDM58mN5GoqNAGoGSXDMY3Em3l0u4avHtHJbueUZKMsfSg7IaRN
         J7rw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=twLNZ5dF3uUkYx3D2ftZufmrlbnxR2cyL777pTO1PI0=;
        b=u8YiNEbHaPEuxAbeKelxK2ZjfAQ56eed9pfo7tF3ZDMuAInJoAq/q0y3u6lhgRsmtC
         y9dQVGOnbtAAkNF8Y7+vBFyXA0Z9TLuZGTjGGC+0jeAquLakNiv2nXhKXsvyK/niyvKF
         vI/5NLjdQ5xXWF68cOk5gBbR6rLrl0HWOKQ4hWrrzy2oPBrkpf+KJA3021avb06d5AKA
         v9a2Vj38L3hoQY3YxMCH2kcl09oN2ogNyul1UvseETV2OcelhviJbSJsr/RzGsZFX52E
         orSRpQgob+VPf/lEmgUO/3iVb3wGStU3RCLPR6wSTsMIo8ZtARiu6ngMclvYwCwizQUz
         i9ZA==
X-Gm-Message-State: AFqh2krQCZIseR7Ak4PE2x7BfibiRaSPjyHuqPoOWdHV9biYXkyVdDiT
        z3vtDuNYn37U/L1eTU4unlTQyJ3FnX9igyeAj8w=
X-Google-Smtp-Source: AMrXdXuOslSTjl7hXGpJN1LRXd+1/2vgbb+tAz606pZMIFj/QJYpTHq1mxR+XNkrxcA6eVkJgndgKrWvH2Zu6xLRJ5w=
X-Received: by 2002:a0d:fc83:0:b0:3ed:90d2:2ab8 with SMTP id
 m125-20020a0dfc83000000b003ed90d22ab8mr3204530ywf.67.1672499281573; Sat, 31
 Dec 2022 07:08:01 -0800 (PST)
MIME-Version: 1.0
References: <20221231083028.1635698-1-masahiroy@kernel.org>
 <CANiq72n3Hs3T5uFXBBCapnopp_EOwkc7n9QVtP3DguEytU9WKg@mail.gmail.com> <CAK7LNARkyqwEf=xte8Q2BjPkkrvO2-c5_6dmrh=MP527TocuLQ@mail.gmail.com>
In-Reply-To: <CAK7LNARkyqwEf=xte8Q2BjPkkrvO2-c5_6dmrh=MP527TocuLQ@mail.gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sat, 31 Dec 2022 16:07:50 +0100
Message-ID: <CANiq72=vgQRsBQO8Wwucj2aEout4hzbecgZcgg-W+e5s2WyaDQ@mail.gmail.com>
Subject: Re: [PATCH] kbuild: rust: move rust/target.json to scripts/
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     linux-kbuild@vger.kernel.org, Miguel Ojeda <ojeda@kernel.org>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Borislav Petkov <bp@suse.de>, David Gow <davidgow@google.com>,
        Helge Deller <deller@gmx.de>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Palmer Dabbelt <palmer@rivosinc.com>,
        Segher Boessenkool <segher@kernel.crashing.org>
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

On Sat, Dec 31, 2022 at 3:57 PM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> No.
> scripts/target.json is a generated file.
> It is generated in objtree, not in srctree.

I meant `$(objtree)`, i.e. I meant if we should use a $(...)` prefix
for clarity/consistency (even if it is just `.`).

Happy New Year!

Cheers,
Miguel
