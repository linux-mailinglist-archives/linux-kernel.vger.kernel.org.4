Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE9A76ADEA6
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Mar 2023 13:25:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231213AbjCGMZD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Mar 2023 07:25:03 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231480AbjCGMY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Mar 2023 07:24:58 -0500
Received: from mail-yb1-xb2e.google.com (mail-yb1-xb2e.google.com [IPv6:2607:f8b0:4864:20::b2e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DBF9C4DE35;
        Tue,  7 Mar 2023 04:24:57 -0800 (PST)
Received: by mail-yb1-xb2e.google.com with SMTP id i6so11151904ybu.8;
        Tue, 07 Mar 2023 04:24:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678191897;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date:message-id:reply-to;
        bh=GpEQa5LQr4Ebi2yIjm00KTBCaif7x7L4argp6haEfHE=;
        b=edxGVUK3xgTtGS7H1wjRbHfs/6JdaPY04qE9IaKVLN2X2qd55X0FT8rz4ra+E0fsvb
         mGsHC/B7KtP1xb2Ll+wd/z/Gq2ioy0BoW2PAs9fdWhaRq7y8b9BlIhRT8YBOO2TjT75n
         579IJXtMCrQ2PyxjD4Lr+PrmCpvgYfqkMGzLIr8h5fsUzK2VrPQMcoWg0ozu2idD06L1
         nynrMEAG3iI77i8ude8nLxiOxXuB1s2OuYbdB0e+d7FSMhL14DbWB24QVk3ZbBDwRfZN
         fgMAbbp09dOsUC3l62ZCPph1KfI3vCELarZFx58nllDlDWib2+FejK4bLpNFHC0l9/1a
         HdFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678191897;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=GpEQa5LQr4Ebi2yIjm00KTBCaif7x7L4argp6haEfHE=;
        b=OY/cm50AHaMke64qm9AGR9GanQK9jkm58Z310OtzuJ9+F79dAMge7S/zmcyN5YJVN2
         zONEvx6DJxGrKcpJegP/4zGb71GBupIN5s5M31W1Q/HaKSLLh62aiLYdO63iyZWnpGUn
         nKIOVf0xg73RzsnQ/h2A0NTIJMD6xwWJCcT9vu0Pgkm1u/iAU1bh0LRAfq9oJ9fyGzY8
         +oHqlVTyzZmsEuNs6BbKIa7MV9TcooC3Q8l3VkCpnCM6LelzB9zNdESm2yxZGweG2c6r
         PSqCJQwkLMqqt+hzYfEf8E+MzQdc29HCmWXDH4dDgwbG9lADU54hi5lyrOPNbFyx4Nx1
         vBmA==
X-Gm-Message-State: AO0yUKUx1zqZfpW/mBX0vntj9OPBacpCarMh5tt7LMlPi0Cp0+NZJVZk
        b74tEdPur0yvsZTo0ZTwHwUDB2ib0xxLEYINSWA=
X-Google-Smtp-Source: AK7set/igNCY1H5Ocdykbu7tR0GiJl5qYzFnvvGsuXFWOnDrbDeu9dD+Db3vZ+5orz8ysFFWitw6gSrbYgYA75KvBcg=
X-Received: by 2002:a5b:b03:0:b0:ad7:b81e:69bd with SMTP id
 z3-20020a5b0b03000000b00ad7b81e69bdmr6455019ybp.2.1678191897100; Tue, 07 Mar
 2023 04:24:57 -0800 (PST)
MIME-Version: 1.0
References: <CANiq72k4cOEOykgUhgqaXPC7xhX2EoC8c4sr1oFEhKMfEdi=wA@mail.gmail.com>
 <20230121052507.885734-1-varmavinaym@gmail.com>
In-Reply-To: <20230121052507.885734-1-varmavinaym@gmail.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Tue, 7 Mar 2023 13:24:46 +0100
Message-ID: <CANiq72k-KhU398KzV0+8DP0AUYkaf_G+5PwXgzYwbbK6AgcCUg@mail.gmail.com>
Subject: Re: [PATCH v2] scripts: `make rust-analyzer` for out-of-tree modules
To:     Vinay Varma <varmavinaym@gmail.com>
Cc:     alicef@alicef.me, Masahiro Yamada <masahiroy@kernel.org>,
        Michal Marek <michal.lkml@markovi.net>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=C3=B6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org,
        rust-for-linux@vger.kernel.org
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

Hi Vinay,

On Sat, Jan 21, 2023 at 6:25 AM Vinay Varma <varmavinaym@gmail.com> wrote:
>
> Adds support for out-of-tree rust modules to use the `rust-analyzer`
> make target to generate the rust-project.json file.

Could you please address (some of) Masahiro's and Alice's feedback in
a new version?

Thanks!

Cheers,
Miguel
