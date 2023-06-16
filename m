Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 20FA073340F
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 17:00:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345523AbjFPPAz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 11:00:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345172AbjFPPAx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 11:00:53 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E61330F4;
        Fri, 16 Jun 2023 08:00:52 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6b2e1023f30so757627a34.1;
        Fri, 16 Jun 2023 08:00:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686927651; x=1689519651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gbcAX6a1eicu6d3jk33i1zAfmDcjTd2pa8lrf0SUGvQ=;
        b=oAot7/Zp5mILgXcqyrtRgc6bTBbIhbsoKJj73kFHgJuD4WrzbiBkBme2A6CQZsaNtT
         rVcwh87oTEq+kXIpqLgMQ2MbuWIEAY3DcSuYM28gcKaIj7JX5K3c1Km9HZvHCY/qw4dW
         jk3Xl4iYIhAm/typevshEm9jvZOBddkT3JYk1qAqxhUjfiWLSCJLoeytOl74B8Po3Zpt
         1xSt+NXAJPiE2qHtHWwwibfvK26ffcFPpOi5b+YU3SzJV+FD8oM3zd0738qFeO8U/OEf
         rNB8kTD73ZQQR5EI3ubXI9cbisd8Ukl+xoiwOX3V4r8rfMx4Mlqtw7U9mxC2DSMBCSQj
         ItUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686927651; x=1689519651;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gbcAX6a1eicu6d3jk33i1zAfmDcjTd2pa8lrf0SUGvQ=;
        b=QP1AFWvV26UKpJfDdkK0utyLyXac+22MoHBYpdcn4cCTabGe+rcAJ257PABRy3xZGU
         21fyFYwY26liD6gvwwb1cYXNtnlmoi1kE7jc1S/f8dLWy0q3esMiHZlfj5LpcUckd06t
         48R/RIIZRBxmETVevl7sEzSuVFYtF0702f8ERxfxnx0s1l4q3zda18z/CfnNB5WhnXUr
         gLkaV6zpmjRvHWhM2O/EslqcuFl4ZPt0lq/qSCjvsyQrGjIjsO/VQbJUKFr7zdL+Oc2H
         S7ge90mrVt9gDP/jlCJ8SvNNCqAqAxlw52UoIAr2v/kXhHqNLwds6kdq/Uzn6cJtQmgX
         BcyQ==
X-Gm-Message-State: AC+VfDwTZ4rSgiw5uSSZrdAvHr4TWD2olwOTr9o1siuWaBvbvHNZpQmS
        7anbTI6kZVRARIMXLMk6278=
X-Google-Smtp-Source: ACHHUZ466j1P5f7zSgTKQ27WFq3EVgQ+S7RfZBJhvqWaa4/+rm+bKYxB4YpejS+9SlXqCVx5d0hrtQ==
X-Received: by 2002:a05:6870:5b28:b0:1a6:4eb9:d10b with SMTP id ds40-20020a0568705b2800b001a64eb9d10bmr2147868oab.16.1686927651338;
        Fri, 16 Jun 2023 08:00:51 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id ve17-20020a0568710c1100b001a6a3f99691sm6211975oab.27.2023.06.16.08.00.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 16 Jun 2023 08:00:50 -0700 (PDT)
Message-ID: <022fc9e1-692f-754c-061a-0e4e7c380731@gmail.com>
Date:   Fri, 16 Jun 2023 10:56:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v2 01/11] kbuild: rust_is_available: remove -v option
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
 <20230616001631.463536-2-ojeda@kernel.org>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230616001631.463536-2-ojeda@kernel.org>
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
> From: Masahiro Yamada <masahiroy@kernel.org>
> 
> The -v option is passed when this script is invoked from Makefile,
> but not when invoked from Kconfig.
> 
> As you can see in scripts/Kconfig.include, the 'success' macro suppresses
> stdout and stderr anyway, so this script does not need to be quiet.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> Reviewed-by: Miguel Ojeda <ojeda@kernel.org>
> Tested-by: Miguel Ojeda <ojeda@kernel.org>
> Reviewed-by: Nathan Chancellor <nathan@kernel.org>
> Link: https://lore.kernel.org/r/20230109061436.3146442-1-masahiroy@kernel.org
> [ Reworded prefix to match the others in the patch series. ]
> Signed-off-by: Miguel Ojeda <ojeda@kernel.org>
> ---
> 

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
