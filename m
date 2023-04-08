Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B01F6DBC71
	for <lists+linux-kernel@lfdr.de>; Sat,  8 Apr 2023 20:25:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229910AbjDHSZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Apr 2023 14:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjDHSZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Apr 2023 14:25:01 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4CEF8689;
        Sat,  8 Apr 2023 11:25:00 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 6-20020a9d0106000000b006a177038dfeso14205778otu.7;
        Sat, 08 Apr 2023 11:25:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680978300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Pwc/3AWMfEaAIvYsDnkVg0ci20u8p4CqXhM8i5egr5o=;
        b=gzDts5q0CNK6aNvIaGy8bjFLBbnMG9p8cNk01Z5ybEt1Ac2fqxvhsL+ev7UKPbPgsQ
         Ud6jJtmqURe2yNpIlyx5i7ytzeLnjRsRxAoogNyFZN5Rk7Mp/nO1uEB0tNS1wVlzX0qO
         MSAPPQU2ywrrAxsUHgt0NzOG+8kN+U7NXJ1LhSPcEUk2z4ZiIIx4vyhmd9ZN0B/HOdKc
         Dv+vfXs/joypJUkSpYTXTS4n4lm/YLiQY6OwIR1C6djuVRH9V6y9zoN1rQAQF8UqsF8i
         j5gk6NCXXV4C0BI885dIhpKri6y36zMVWlaoR8H5D0QdYORnDnANC1oaRmGPxIxK96UQ
         9o/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680978300;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Pwc/3AWMfEaAIvYsDnkVg0ci20u8p4CqXhM8i5egr5o=;
        b=fO67P5NcQ9AKo2VyNSvXZ6gf8sbnKwF0lORvASERWaSV6NTQm35mOXk18j1Au6HMLT
         hBB4rDfjgjX08ng2lA+0LsrrTEBhWtTPDgqqM1BFS3GXsx9UuH7QhaV22p+gQhaIJAGh
         dSTi8TgQ3HnpsZBY1scCsQFRUWyNU6aEK3Lz0goRWXtyVy+XEjYxB2oDV/Am59LZ1uMg
         NiFg82yfNCk8z825V66PD1emmi4Blag2B8kf2g2O0hrhq/OZEqphSpNWYMP4D8sZz2v2
         F6uUJRXhFnrqNMYGNjhVUYtFWA67KfkURJzgxsOFMmBVUffEQiNOcBEFRzQwa+yvETcl
         DP5Q==
X-Gm-Message-State: AAQBX9fcqKot+vluElhTf1ft0q/dCqf5uMgUaBh0IOJOM/qNpOs1N4I0
        Xcwlyc17BPAQ41sgqS5kCpk=
X-Google-Smtp-Source: AKy350YVWWK5LVrcIXkGkfiCOeOtBJu5JBLuctbC9AAS/sN/aoOr5liabuPstmjtoZ5nP3Uz6zCHZg==
X-Received: by 2002:a9d:7443:0:b0:6a1:21fc:653b with SMTP id p3-20020a9d7443000000b006a121fc653bmr2280347otk.14.1680978299895;
        Sat, 08 Apr 2023 11:24:59 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id b17-20020a9d7551000000b006a3bc285eeesm2670716otl.68.2023.04.08.11.24.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 08 Apr 2023 11:24:59 -0700 (PDT)
Message-ID: <c0f47367-6352-e55d-1a87-fe2960a84838@gmail.com>
Date:   Sat, 8 Apr 2023 15:24:53 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH] scripts: rust: drop is_rust_module.sh
Content-Language: en-US
To:     Andrea Righi <andrea.righi@canonical.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        Nicolas Schier <nicolas@fjasle.eu>, Tom Rix <trix@redhat.com>,
        Eric Curtin <ecurtin@redhat.com>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Neal Gompa <neal@gompa.dev>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        rust-for-linux@vger.kernel.org, linux-kbuild@vger.kernel.org,
        llvm@lists.linux.dev, linux-kernel@vger.kernel.org
References: <20230407070517.204676-1-andrea.righi@canonical.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230407070517.204676-1-andrea.righi@canonical.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.3 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/7/23 04:05, Andrea Righi wrote:
> Commit c1177979af9c ("btf, scripts: Exclude Rust CUs with pahole")
> introduced the constraint "!DEBUG_INFO_BTF || PAHOLE_HAS_LANG_EXCLUDE"
> to enable RUST.
> 
> With this constraint we don't need is_rust_module.sh anymore, because
> 'pahole --lang_exclude=rust' already has the capability to exclude Rust
> CUs. If pahole isn't recent enough (< 1.24) to support --lang_exclude,
> then DEBUG_INFO_BTF can't be enabled with RUST and is_rust_module.sh
> isn't used as well.
> 
> In any case is_rust_module.sh is obsolete and we can just drop it.
> 
> Link: https://lore.kernel.org/lkml/Y+p2xKIN6TJnQinK@righiandr-XPS-13-7390/
> Signed-off-by: Andrea Righi <andrea.righi@canonical.com>
> ---
>  [...]

Go on

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
