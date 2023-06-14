Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 78FC5730554
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Jun 2023 18:45:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235571AbjFNQpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Jun 2023 12:45:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236080AbjFNQoq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Jun 2023 12:44:46 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2654A2689;
        Wed, 14 Jun 2023 09:44:36 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-1a6960956d5so3274746fac.3;
        Wed, 14 Jun 2023 09:44:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686761075; x=1689353075;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sGL7yKszvXa2cHQQt1GT6R3oKRDiN6LOViSYfGPWdZo=;
        b=lBQX5SXd0WDA3PYTUq+DPijuVWmtojhq1FptFGztY9lgLFeSHQH/K4mxr6HYUbkwaV
         Rxhv1T6U2qgxuGbubeXSajtOcHfgJdNPQyE8Wdej8d0HgHSdYreUERKq+39go1Gss04V
         UgpbIQYsXgFRU31sfTPAXXoudV2mQppbgiiLSjGzhU4BSQIeEVf1OZPKvYNEHWPtWnsS
         Y9t5+iX7fx8udI37abgmFnKIyte9AUsvjpbv4fyIYX56tSBWb5CGLlwhjoBbGB3vjyRK
         F+UA14eBgKGYnr3jt8zWGEcDtpWMZFzjP4KKwoeXQgO0ECiGPy9pMrIhMnCHHE/SHkBv
         Y7gQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686761075; x=1689353075;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sGL7yKszvXa2cHQQt1GT6R3oKRDiN6LOViSYfGPWdZo=;
        b=Zu9dTzcQy3HZ9KyCOK+u2bh3WQVDPXupX3R17XvVtL33gSw2bnB3qutBK6KgkYYrl4
         uz6zctr8Lf3Km5HPLakWFmFoGBz2qLt1kxm4ZrGkdfz5kpR/pRMivhOqqKireBtvomrd
         OSsZsZnKMu0xkqPLW5kLpYnU1hDzHSxFaW30i2qhVsA9cpKrUiuz5n3Xal1ZBX0GLhbE
         Bju/phhuW4PQ5YI47koTgEZixMb5rrfgFx+qbwtcQTMcBhbVZ71gDkGYRFFRRTjci8qK
         NrxpSHSvyJ7/LwH8QrHMMvPJpyWMr8hgJbRhXOmDQakdej8BULXQQ2VwoPw3+NO+IBti
         1z0g==
X-Gm-Message-State: AC+VfDycl/ByvB7PV4+U2YSmwiNetEfKFS5nWoWF44wU9jeRbrYvHYdy
        ApGOMnit96ODUU+WQVTH1T8=
X-Google-Smtp-Source: ACHHUZ4r1WlTv/EKwLsLnrfaKpz6dKG+rQYC1+TpjBZJkEfor9XmpN+kRPszhoK90YWMTA4IbWSNDg==
X-Received: by 2002:a05:6870:772d:b0:184:39e3:9c85 with SMTP id dw45-20020a056870772d00b0018439e39c85mr11651838oab.29.1686761075300;
        Wed, 14 Jun 2023 09:44:35 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id el18-20020a056870f69200b001a6d15fc52fsm1501154oab.4.2023.06.14.09.44.31
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 14 Jun 2023 09:44:34 -0700 (PDT)
Message-ID: <4a1096e9-500e-d764-0a79-289e6559cfb1@gmail.com>
Date:   Wed, 14 Jun 2023 13:44:30 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 1/1] scripts/rust_is_available: Fix clang version check
Content-Language: en-US
To:     "Ethan D. Twardy" <ethan.twardy@gmail.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Tom Rix <trix@redhat.com>, Tiago Lam <tiagolam@gmail.com>,
        Kees Cook <keescook@chromium.org>, Finn Behrens <me@kloenk.de>,
        "open list:RUST" <rust-for-linux@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CLANG/LLVM BUILD SUPPORT" <llvm@lists.linux.dev>
References: <20230528131802.6390-1-ethan.twardy@gmail.com>
 <20230528131802.6390-2-ethan.twardy@gmail.com>
 <525fee98-c694-6a38-cd1e-dd7efd806620@gmail.com>
 <CTCD11G9NVTB.3SYR2GFA5VAB3@hackbook>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <CTCD11G9NVTB.3SYR2GFA5VAB3@hackbook>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/14/23 09:08, Ethan D. Twardy wrote:
> Greetings, Martin!
> 
> Thanks very much for your testing and review. Do I need to take any
> further action to make this patch ready for review? I sent out a v3
> version of the patch, where the only change was adding Reviewed-By and
> Tested-By tags to my git commit--since this is my first time
> contributing to this community, I wasn't sure whether I needed to do
> that. Thanks!
> 
> Sincerely,
> 
> Ethan Twardy

Unless other reviewers requested changes, you have to rebase your
work or you want to make a modification, it is not necessary to send a
new version of the patch series, generally, maintainers will, and have
to, add any Reviewed-bys or Tested-bys prior to merging.
