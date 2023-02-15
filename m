Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDB106987EA
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 23:32:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229710AbjBOWb6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 17:31:58 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229651AbjBOWb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 17:31:57 -0500
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5FE530295;
        Wed, 15 Feb 2023 14:31:55 -0800 (PST)
Received: by mail-wm1-x333.google.com with SMTP id p5so204663wmg.4;
        Wed, 15 Feb 2023 14:31:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=+NP6F+mj0B0zHcKL+YzogA4xteh+fNIdLHg/UKv8Hk8=;
        b=PD3RAS8NmDzpGsEbXOD/rQTLRgTaJKbE6PggBpwqQbQGNp1GRdzKoiTSbIZ1Genvtd
         auq3kbWgXMLcoqytGgSoA3d5/8oaDyZRtYkPFudliqgZrqC1T1RTXtbvoUvlAsu5ZPZv
         P3pLOvmN8ngE/c56NfxgZRCUtGxGAYPf8kI0zPU0LYLTY6J94ohGj2B3Xvpar5ouBQJR
         ZWkmDf6O0asGlKhJRLA6yAO21hViYlIo2j+0OPz+cQCT+I3npvGDjCLZNNc7285ewyer
         Pv/uiafmYqFuxgap9kkljIN1+BdMBBB27Hj3CGKKHnV1JSGgucyuRYZZ+pM1LXpM09YN
         occQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:references:to:from:subject:cc:message-id:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=+NP6F+mj0B0zHcKL+YzogA4xteh+fNIdLHg/UKv8Hk8=;
        b=3E6qwP38OanPL6APrt4O9WOjjfaXWbYwiBuFxQL2A5dKVPDwgLZEP/Cc5c0mYAB948
         OFlgzp9LAtishZGVf2IbCllj9KEl+rC+cmLNfojeDrqOIzU8HdqNtxfiiqkXtqz10ad9
         H3cBlr1/UCHjq4G9hDUHQJs3jEymmlml9k9/DOP7x9adW86XvNzniOkXUB9u/ZQb5ytA
         fXWH82gFjO7gBcYbgEkqE9Dse4r1CkgKFhVdh5OO64f3fHK2WxO7Xfm1FTcTCUPRK65X
         lDmQw56XCTpWo81hyT4ZXsiolUVnomPKnHgOqCNN4asR9pJc5OXW+h3j41Cee3ucup09
         NPPw==
X-Gm-Message-State: AO0yUKWktbXvzbXMBzGuhesuOhptZBSuJAv0fx3GX4YKqX9dpYZ/Ahn0
        TvcQNntxgyco+Sk2/488J7c=
X-Google-Smtp-Source: AK7set9GOpxqnABztlQ3C4s8ZHiFqwZTEk/Va5+GKkEK6i6xpG7YYElxntI4AqF07Uriqvn8rFoMpA==
X-Received: by 2002:a05:600c:318f:b0:3dd:af7a:53db with SMTP id s15-20020a05600c318f00b003ddaf7a53dbmr3198565wmp.11.1676500314218;
        Wed, 15 Feb 2023 14:31:54 -0800 (PST)
Received: from localhost ([2001:b07:5d37:537d:5e25:9ef5:7977:d60c])
        by smtp.gmail.com with ESMTPSA id x14-20020a1c7c0e000000b003e20970175dsm708665wmc.32.2023.02.15.14.31.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Feb 2023 14:31:53 -0800 (PST)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 15 Feb 2023 23:31:52 +0100
Message-Id: <CQJHRF1Y2JPK.24C1KAF449PJR@vincent-arch>
Cc:     "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        "Jonathan Corbet" <corbet@lwn.net>,
        "Richard Weinberger" <richard@nod.at>,
        =?utf-8?q?Sergio_Gonz=C3=A1lez_Collado?= <sergio.collado@gmail.com>,
        "David Gow" <davidgow@google.com>,
        "Stephen Rothwell" <sfr@canb.auug.org.au>
Subject: Re: [PATCH] Documentation: rust: Fix arch support table
From:   "Vincenzo Palazzo" <vincenzopalazzodev@gmail.com>
To:     "Bagas Sanjaya" <bagasdotme@gmail.com>,
        "Rust for Linux Kernel" <rust-for-linux@vger.kernel.org>,
        "Linux Documentation" <linux-doc@vger.kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
References: <20230213152714.78b844f4@canb.auug.org.au>
 <20230213085920.19726-1-bagasdotme@gmail.com>
In-Reply-To: <20230213085920.19726-1-bagasdotme@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Stephen Rothwell reported htmldocs warning when merging uml tree:
>
> Documentation/rust/arch-support.rst:20: WARNING: Blank line required afte=
r table.
>
> Fix the arch support table by removing extraneous simple table marker.
>
> Link: https://lore.kernel.org/linux-next/20230213152714.78b844f4@canb.auu=
g.org.au/
> Fixes: 0438aadfa69a34 ("rust: arch/um: Add support for CONFIG_RUST under =
x86_64 UML")
> Reported-by: Stephen Rothwell <sfr@canb.auug.org.au>
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>
> ---

Reviewed-by: Vincenzo Palazzo <vincenzopalazzodev@gmail.com>
