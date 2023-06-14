Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20F5372FDE6
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 14:09:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244443AbjFNMI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 08:08:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236519AbjFNMI5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 08:08:57 -0400
Received: from mail-qt1-x830.google.com (mail-qt1-x830.google.com [IPv6:2607:f8b0:4864:20::830])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A70451BF3;
        Wed, 14 Jun 2023 05:08:56 -0700 (PDT)
Received: by mail-qt1-x830.google.com with SMTP id d75a77b69052e-3f9b5ec058aso18571571cf.0;
        Wed, 14 Jun 2023 05:08:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686744536; x=1689336536;
        h=in-reply-to:references:message-id:from:subject:to:date
         :content-transfer-encoding:mime-version:from:to:cc:subject:date
         :message-id:reply-to;
        bh=ICyOrpP9yZ8UNQouKztYfYpCQHNzL6t2U9KVRuzbBV4=;
        b=CVttXEgcnxek3hQKtlR8hsjF23X01S5bgOt7ZLYziuJ8d/zESBQC1GJtAryd+G6Ra8
         NiRdZ4DJhO0E23mqq0HJk/IhAnok/2l/6yZAvMAGxW9GgWWabRYRBG47i6AvJYWc1Qst
         dHqkHaWIqs1pHhEgq1e/5T4TPSk76zUFqpJBBdVP63mM+XCeMP8XQwM9o9HaG5Gcu0IC
         2toIH0v5Te0+zu5iNdQxaHNPvqcxBt7nuq1pCorFshQQZvtAwvztpvAQ5KyMaPJbjTOF
         clssKGom4EwSFfBrAKp3NKk7uXUOL6rCSExmVUQL3+NlEfZwJvOGbgTyYZTGW61Lp6Hr
         wvIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686744536; x=1689336536;
        h=in-reply-to:references:message-id:from:subject:to:date
         :content-transfer-encoding:mime-version:x-gm-message-state:from:to
         :cc:subject:date:message-id:reply-to;
        bh=ICyOrpP9yZ8UNQouKztYfYpCQHNzL6t2U9KVRuzbBV4=;
        b=F5roR1pWEcUIxklfatuiCp/RfUqW83RTCqFVxYcgs1o+VNISWY/kYXx93amc4Q36Mn
         4lSOh6afRlbgkc/8378aSDjVq+Xhgg6kyzOCD128soSJrBMCJTnMzzWV4TdUm3PD4EAa
         BoP7OFWvZ4Zsh10s/CC9AILtjusvJgSff/cn8w/fiNWv1ctStNIsqRuuPaAUHVHPTaAZ
         A7zAYvT0M7OcfZGNTMesP4C892Jdz6yO4OYbfZLiz8mOC5WxnlZZZQzaKDIsEHuR2CrT
         ttFggnY0NFv8tlf5f8FkztbHBAc/u9GU6riqTBbOkFb9Ah2wsXCOQdcam3Y1GJiT2tqu
         Zg/g==
X-Gm-Message-State: AC+VfDzYcjGhnqWYLh2+geotTM/K6nwfSN1xsPiRnde5ZKPDOp1iyXPf
        Xhfvc2swvTjvgdCZbiqO1xNV5UeXp1AOkDSm
X-Google-Smtp-Source: ACHHUZ6hxmTpEnrPsU0Ea16L7G6meCduItfLC5GnO65BPUihWPKuwA51vM4DK6qE0dZ4TkoPHD5CKw==
X-Received: by 2002:a05:622a:1888:b0:3ef:6c09:edcc with SMTP id v8-20020a05622a188800b003ef6c09edccmr2399709qtc.22.1686744535717;
        Wed, 14 Jun 2023 05:08:55 -0700 (PDT)
Received: from localhost (2603-6000-8100-7fd4-0000-0000-0000-0619.res6.spectrum.com. [2603:6000:8100:7fd4::619])
        by smtp.gmail.com with ESMTPSA id a22-20020ac844b6000000b003f6c9f8f0a8sm4931656qto.68.2023.06.14.05.08.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 05:08:55 -0700 (PDT)
Mime-Version: 1.0
Content-Transfer-Encoding: quoted-printable
Content-Type: text/plain; charset=UTF-8
Date:   Wed, 14 Jun 2023 07:08:53 -0500
To:     "Martin Rodriguez Reboredo" <yakoyoku@gmail.com>,
        "Miguel Ojeda" <ojeda@kernel.org>,
        "Alex Gaynor" <alex.gaynor@gmail.com>,
        "Wedson Almeida Filho" <wedsonaf@gmail.com>,
        "Boqun Feng" <boqun.feng@gmail.com>, "Gary Guo" <gary@garyguo.net>,
        =?utf-8?q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        "Benno Lossin" <benno.lossin@proton.me>,
        "Nathan Chancellor" <nathan@kernel.org>,
        "Nick Desaulniers" <ndesaulniers@google.com>,
        "Tom Rix" <trix@redhat.com>, "Tiago Lam" <tiagolam@gmail.com>,
        "Kees Cook" <keescook@chromium.org>, "Finn Behrens" <me@kloenk.de>,
        "open list:RUST" <rust-for-linux@vger.kernel.org>,
        "open list" <linux-kernel@vger.kernel.org>,
        "open list:CLANG/LLVM BUILD SUPPORT" <llvm@lists.linux.dev>
Subject: Re: [PATCH v2 1/1] scripts/rust_is_available: Fix clang version
 check
From:   "Ethan D. Twardy" <ethan.twardy@gmail.com>
Message-Id: <CTCD11G9NVTB.3SYR2GFA5VAB3@hackbook>
X-Mailer: aerc 9999
References: <20230528131802.6390-1-ethan.twardy@gmail.com>
 <20230528131802.6390-2-ethan.twardy@gmail.com>
 <525fee98-c694-6a38-cd1e-dd7efd806620@gmail.com>
In-Reply-To: <525fee98-c694-6a38-cd1e-dd7efd806620@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greetings, Martin!

Thanks very much for your testing and review. Do I need to take any
further action to make this patch ready for review? I sent out a v3
version of the patch, where the only change was adding Reviewed-By and
Tested-By tags to my git commit--since this is my first time
contributing to this community, I wasn't sure whether I needed to do
that. Thanks!

Sincerely,

Ethan Twardy
