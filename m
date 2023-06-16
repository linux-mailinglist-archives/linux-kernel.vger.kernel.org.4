Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 893E073342A
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:02:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344856AbjFPPCj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:02:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345832AbjFPPCH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:02:07 -0400
Received: from mail-oa1-x2a.google.com (mail-oa1-x2a.google.com [IPv6:2001:4860:4864:20::2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4541A3A9E;
        Fri, 16 Jun 2023 08:01:58 -0700 (PDT)
Received: by mail-oa1-x2a.google.com with SMTP id 586e51a60fabf-1a49716e9c5so922474fac.1;
        Fri, 16 Jun 2023 08:01:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686927717; x=1689519717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=dRcxXeLT1Jidp1YuQQcBi4VOs63S4oCIaCSoEGYplmw=;
        b=U55lKpSv4wxQWh4ybFDgFR24RjtdrByvyp1gYQKwCKozZx8QBVsd/BbuOpxEq/CGMX
         VMpMc7EgOuYR+CNa+Go8lM81tpF/8X8FkgwmSb8k5xP+mnAN6UirX1xu1kPTws11c0Dg
         Hsnan7rRfGppI2OYJiSQAU3w1I3Kiu6vwKwviZWnmz9Mwfzg45zmGhAH5bS/nef/0AHC
         uAy/ddilnfSG65/1+MT045cKlqPS5tubyrTtdXpkx06MxvL6qNwRyQPzOF6fD435/Al3
         yudVfX/MQOK2mrAqZkIFJmMB8jrMeH76Y51RuqlW/Vzw5hwHjgsurnhEQNcYRivYCtcp
         3muw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686927717; x=1689519717;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=dRcxXeLT1Jidp1YuQQcBi4VOs63S4oCIaCSoEGYplmw=;
        b=lBVxwxtkGWOse6tZ24LZcph10eEUgwUqqU7r2B91dl0B6sh5id4kdl3suxLaVcgvtk
         7Z71TURrCr7JIakKMd7Ix+eZgQGupRNPH2Za/vEdIoo2CPWdeBT2aWDrrYgIMIhr5tpn
         bNCrKDrUW0mz6xk19UwFTHDyOgU2twoUhSSN0VeMxwRhSxdJaLwCgcL8PDChZiKjYDIQ
         8h0m4JL9l2IUL6dFrGW9wFgAeGJB+X7EiGWTO3n8M6gmK1M+L5g/L5JwJQ+143cQWZTr
         URQrCRc4c0IN2bno42BhMEz9gdw/Lj71GxtJiFy0p2A1hfUrOMfeAkcYvpb+XEm7oILO
         Fugw==
X-Gm-Message-State: AC+VfDzTi7VxXLlbwA4Me0lXG7tT9ZJ0KWWXHUhvz6u7Fy9KrOJez9Xf
        81KjXUOjx/QH6WtzNHfCFxs=
X-Google-Smtp-Source: ACHHUZ5/iYdSXWj23TWLkv87RnWd7sL8N2fIpt8OrYc9krBD/0du53BXzas8RJnT0bcx4/ipIQRDRw==
X-Received: by 2002:a05:6870:d416:b0:19f:7b5b:2855 with SMTP id i22-20020a056870d41600b0019f7b5b2855mr2055436oag.15.1686927717282;
        Fri, 16 Jun 2023 08:01:57 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id os12-20020a0568707d0c00b001802d3e181fsm11640984oab.14.2023.06.16.08.01.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 08:01:56 -0700 (PDT)
Message-ID: <8044dea1-3bd4-d3d1-0a7b-316df38f3276@gmail.com>
Date:   Fri, 16 Jun 2023 11:16:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 10/11] kbuild: rust_is_available: check that output
 looks as expected
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
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230616001631.463536-1-ojeda@kernel.org>
 <20230616001631.463536-11-ojeda@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230616001631.463536-11-ojeda@kernel.org>
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
> The script already checks for `$RUSTC` and `$BINDGEN` existing
> and exiting without failure. However, one may still pass an
> unexpected binary that does not output what the later parsing
> expects. The script still successfully reports a failure as
> expected, but the error is confusing. For instance:
> 
>      $ RUSTC=true BINDGEN=bindgen CC=clang scripts/rust_is_available.sh
>      scripts/rust_is_available.sh: 19: arithmetic expression: expecting primary: "100000 *  + 100 *  + "
>      ***
>      *** Please see Documentation/rust/quick-start.rst for details
>      *** on how to set up the Rust support.
>      ***
> 
> Thus add an explicit check and a proper message for unexpected
> output from the called command.
> 
> Similarly, do so for the `libclang` version parsing, too.
> 
> Link: https://lore.kernel.org/rust-for-linux/CAK7LNAQYk6s11MASRHW6oxtkqF00EJVqhHOP=5rynWt-QDUsXw@mail.gmail.com/
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
