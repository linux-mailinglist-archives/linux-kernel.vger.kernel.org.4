Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A27D873341A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:01:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344990AbjFPPB2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:01:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345765AbjFPPBS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:01:18 -0400
Received: from mail-oo1-xc33.google.com (mail-oo1-xc33.google.com [IPv6:2607:f8b0:4864:20::c33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF3A30F3;
        Fri, 16 Jun 2023 08:01:15 -0700 (PDT)
Received: by mail-oo1-xc33.google.com with SMTP id 006d021491bc7-558b6cffe03so549314eaf.3;
        Fri, 16 Jun 2023 08:01:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686927675; x=1689519675;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=WGHt/QDDQOZJGM066N9ylOufaPjJ+HtzMC9oK+LJi5c=;
        b=KxAOPsH6E2Ite4AI8/DdesMmX01IZxbefne6/QQn7FzziBqQ0sN5Z8tvMKBedGUtrF
         4IxsPAP89gHArykUEbfZ+sC8yd5L8fsBBOUrCjBlnoHk4XFdMXd9Gpx3KI7USK0Kyjwi
         ypL1PulTQ8veQ1khnJV+GgHioGPupXsMdVckmT5oiC6gTp6e0YEIDpcWxT4QZmss+lPT
         asG/NQ6S6y9g9H3gromB/JB0R90LnRuUqvoCYul3ZB3BmE8WXCJGtu4FXViQxSYe9aLw
         3XVsyZidlAc4TUlDXCBNvy6kvTtJJGTP5YrCr+c2Xks8fD/g6k8f73BZCJMR+QJlhChs
         5anw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686927675; x=1689519675;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=WGHt/QDDQOZJGM066N9ylOufaPjJ+HtzMC9oK+LJi5c=;
        b=KD8LRbfuyNcHyQ+47YFhkAXMdwyu2yOh68d9TF/poyvm5AGwFtR42zipoZfSC8iCVC
         KiVvwaa14oSz3LcDsEhMZ7KDAbAY5WYf9YnAYgqVk18xZRdQGDdMLzS81w5KCCXI4hPW
         rHWciK8Iz5OTOMXWWXa3rlAjtxHCc1Leed9NKliV7d7saqgvdKiitqlw38H/FaBgRuXQ
         O4TrO3tjv5Mi1MAtfjf4OQ2Di+fkf5qk1c1XGLL3Q8XfanRCJkWvmuWentbMiBLnEhUY
         ZA8S0ZQDunB0eQtyB4BZhtPQ7dWPgsrijujJ+5aZvJvDboOU/mBry3Go1bmWoej2+4I3
         FJGQ==
X-Gm-Message-State: AC+VfDz7q4FMhQ8sh0wu7cJxxiDUi2ZRl22ebejT8nGgS8tG9K2hnc55
        a6xGeycWp6OXi7pSchKMdyQ=
X-Google-Smtp-Source: ACHHUZ4OMdlY/ls33UJZOe2Uz9fJrjczjBLItHq54u+07m8/XbCRBG6awQejlhf2IPpANwZIZuj+hQ==
X-Received: by 2002:a4a:e1c5:0:b0:558:b703:b9f with SMTP id n5-20020a4ae1c5000000b00558b7030b9fmr2213981oot.8.1686927673894;
        Fri, 16 Jun 2023 08:01:13 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id cb10-20020a0568201b8a00b0055ab0abaf31sm6846720oob.19.2023.06.16.08.01.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 08:01:13 -0700 (PDT)
Message-ID: <132e00d5-9568-7c8b-b1f3-f192a8a8368b@gmail.com>
Date:   Fri, 16 Jun 2023 11:02:38 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 04/11] kbuild: rust_is_available: print docs reference
Content-Language: en-US
To:     Miguel Ojeda <ojeda@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Andreas Hindborg <nmi@metaspace.dk>,
        linux-kbuild@vger.kernel.org, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Finn Behrens <fin@nyantec.com>
References: <20230616001631.463536-1-ojeda@kernel.org>
 <20230616001631.463536-5-ojeda@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230616001631.463536-5-ojeda@kernel.org>
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

On 6/15/23 21:16, Miguel Ojeda wrote:
> People trying out the Rust support in the kernel may get
> warnings and errors from `scripts/rust_is_available.sh`
> from the `rustavailable` target or the build step.
> 
> Some of those users may be following the Quick Start guide,
> but others may not (likely those getting warnings from
> the build step instead of the target).
> 
> While the messages are fairly clear on what the problem is,
> it may not be clear how to solve the particular issue,
> especially for those not aware of the documentation.
> 
> We could add all sorts of details on the script for each one,
> but it is better to point users to the documentation instead,
> where it is easily readable in different formats. It also
> avoids duplication.
> 
> Thus add a reference to the documentation whenever the script
> fails or there is at least a warning.
> 
> Reviewed-by: Finn Behrens <fin@nyantec.com>
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
