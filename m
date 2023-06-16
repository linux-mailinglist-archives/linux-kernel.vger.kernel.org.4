Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D037973342C
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:02:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345891AbjFPPCt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:02:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344623AbjFPPC0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:02:26 -0400
Received: from mail-oa1-x2f.google.com (mail-oa1-x2f.google.com [IPv6:2001:4860:4864:20::2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51EA73A86;
        Fri, 16 Jun 2023 08:02:06 -0700 (PDT)
Received: by mail-oa1-x2f.google.com with SMTP id 586e51a60fabf-1a83bfe7ca0so766324fac.0;
        Fri, 16 Jun 2023 08:02:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686927725; x=1689519725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=/TQ/NBF9u3IBn3xcHORueLNPUOIL2wwIG5fESfTCbFI=;
        b=W5bZQhbvvf1ysouwrUosFRxybLDJEya2JAdz3G5mSSV8K/TGKTVSoWQzteqrGAuvck
         sh8bAqtvFmu3uhOGCHY6V3wueOudvp1aQ9/XK/SlHyrYB7D086K7b+83VJlQG8bStXxC
         ekf3U4rWSQPW8tFhKlno1I3zugyW9jAVCa2Gye+GinkIJIk9FLnPxKyrdRY4KdYGUbhE
         V3jvTVfaTejNfc9Qs7OzjOdhw3rmTjSJz1glTZw+Jo2Ie8SsoNdTtUahLx7IdYXwPqXI
         QgOZnjuyRL2+au0HdgzuXlAhgLwPGqZthrb/e+0VvHqSTH5KigwBe65//t5C32NvPIIk
         rMOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686927725; x=1689519725;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=/TQ/NBF9u3IBn3xcHORueLNPUOIL2wwIG5fESfTCbFI=;
        b=AqSOWQBYdoQxeNWMcM0zgmsc2XcaD8vSBAoo4yqi31WML7TV5IeVgWIItJjrKLnJZv
         t+LPhccuGECVcCO4NaMd8apiDd84N0t8uCE4FxcBleycRdiwDJWLy97I4Gl5jo/la1xO
         FMjAXR4YdeizPb2HTqFBiU7fXW32SBGO/YZT6qb5ZPNuAqbdSOt9y8Pwssrb5tt1Rg/d
         jsF1iSXCRl71ogjRh5B5VFYWJZFISFWQCM1Nlmc4KNSSD8jbf9fYxCX5fgnpjzQkWHZz
         eIJDiE7Y8uB3p3jObGdVInkAmk+3mlrE0UYuvXXousX4DKGqBiO3jugR/rCByxbNNnMn
         W6DA==
X-Gm-Message-State: AC+VfDzE2Y4fUqD4ayguAu1LjSzbp4hs0xUHwaW95cHB7bkU0f3xIsev
        hAhQjwtqom2Q9Cy06+Mq1xaVo0XbfF0=
X-Google-Smtp-Source: ACHHUZ5Q45EQty3POoVZW3lQZ5/x8Yz3t9MLsAWheq87HRmCHM+FPkqxUwdt0Oo8jeVB6dXKPIAFuA==
X-Received: by 2002:a05:6870:1a85:b0:1a3:100f:bf41 with SMTP id ef5-20020a0568701a8500b001a3100fbf41mr2136892oab.23.1686927725364;
        Fri, 16 Jun 2023 08:02:05 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id le13-20020a0568700c0d00b001a8f6be7debsm3411187oab.28.2023.06.16.08.02.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 08:02:04 -0700 (PDT)
Message-ID: <22d8e3b2-4759-2b82-cdd3-aca9bf9afd74@gmail.com>
Date:   Fri, 16 Jun 2023 12:00:15 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 11/11] kbuild: rust_is_available: add test suite
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
 <20230616001631.463536-12-ojeda@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230616001631.463536-12-ojeda@kernel.org>
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
> The `rust_is_available.sh` script runs for everybody compiling the
> kernel, even if not using Rust. Therefore, it is important to ensure
> that the script is correct to avoid breaking people's compilation.
> 
> In addition, the script needs to be able to handle a set of subtle
> cases, including parsing version strings of different tools.
> 
> Therefore, maintenance of this script can be greatly eased with
> a set of tests.
> 
> Thus add a test suite to cover hopefully most of the setups that
> the script may encounter in the wild. Extra setups can be easily
> added later on if missing.
> 
> The script currently covers all the branches of the shell script,
> including several ways in which they may be entered.
> 
> Python is used for this script, since the script under test
> does not depend on Rust, thus hopefully making it easier for others
> to use if the need arises.
> 
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
