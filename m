Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EF827189D7
	for <lists+linux-kernel@lfdr.de>; Wed, 31 May 2023 21:08:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230136AbjEaTIl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 May 2023 15:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45204 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230124AbjEaTIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 May 2023 15:08:38 -0400
Received: from mail-oa1-x29.google.com (mail-oa1-x29.google.com [IPv6:2001:4860:4864:20::29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA8A9180;
        Wed, 31 May 2023 12:08:34 -0700 (PDT)
Received: by mail-oa1-x29.google.com with SMTP id 586e51a60fabf-19eb96bffd4so128685fac.3;
        Wed, 31 May 2023 12:08:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685560114; x=1688152114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=VQpBRBiUI2V7LS3F3uEGBbOSqBEboVJ5Y6bOHcSXqj0=;
        b=l7G5U07jd0Hq+nLti5+Q4XkcQ8oPuzIpAHMGCUoor0JOwvKwLXW57cg6gG+v2aHRPI
         sCe3onbbXZ3fm1M4PyfuFRumw8guMMcrTAPqVn8OxwBpM/DsZBF4IG75onMUyU6858Gv
         p7ETmWFvMIu5dpFWabOIqyJXjULkUxexwzKv58HB22GKTJQEpxqocMQottkUV9pf0CnV
         AExF9wQFoeA6RB+UEigPqoX9RNELF40E0yek2WJ/GZsd5kksON1A5W11U0WuyxJ2u67R
         7UVfwiSEjpeJwUUtB9a9LTgxXbUXuR4vq6ydZCNnlh7jYXvfkhOUvV4v22V9R5exBC66
         /C0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685560114; x=1688152114;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=VQpBRBiUI2V7LS3F3uEGBbOSqBEboVJ5Y6bOHcSXqj0=;
        b=QO6Ilj2KDdZW1zrjpk7mBOVbeafyjy/x8KX6ssHTtXTs3v0tiDxodhQqbJu8mAdITT
         BbZsl/lRbX9IWvUQyLlONY0FF2Y4cT35UiV9dwMrr0wgZaBm3irCC86EHVjJ7yOwdD8M
         bMeTuMzvWb9rvB4QpGLAqifhz0DpUq/brzE2yS/7lC5UR4Iidd3XpK4vRRA7Hkqdcidy
         avBqcL5W3a2YUtdV1mK7Kj5lZKjxQOt4v2ZQvAOFsOb3mkcmVIgInZ6PP2DsRTfL5ILS
         kSYImmD2pIINJx+Dsa+JAFUfD8/4FsPxkW7h6OXun7HaWSOSeeLBvkssw+ggAuNS5R99
         3yDw==
X-Gm-Message-State: AC+VfDyKToCQRzlCqvdHiIJWrBVuHUj6Eqn3R9XUz1nulaLgn3McUog0
        lIcGj9QA7aIUtM01mo08qpk=
X-Google-Smtp-Source: ACHHUZ4N/tUMZbG0loQlfqUR/SHUVvNft1dc/NpUkWdBisWgrIM65SU8M0mb3uNClrGMVLOSZp3Xuw==
X-Received: by 2002:a05:6870:9894:b0:18b:1936:30ee with SMTP id eg20-20020a056870989400b0018b193630eemr4883265oab.56.1685560113987;
        Wed, 31 May 2023 12:08:33 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id d7-20020a4a5207000000b0055554a51353sm7114205oob.1.2023.05.31.12.08.30
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 31 May 2023 12:08:33 -0700 (PDT)
Message-ID: <de3a8297-19dd-4854-3311-492ac0875e40@gmail.com>
Date:   Wed, 31 May 2023 16:08:29 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1] rust: error: integrate Rust error type with `errname`
To:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Sven Van Asbroeck <thesven73@gmail.com>
References: <20230531174450.3733220-1-aliceryhl@google.com>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230531174450.3733220-1-aliceryhl@google.com>
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

On 5/31/23 14:44, Alice Ryhl wrote:
> From: Gary Guo <gary@garyguo.net>
> 
> This integrates the `Error` type with the `errname` by making it
> accessible via the `name` method or via the `Debug` trait.
> 
> Co-Developed-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Co-Developed-by: Sven Van Asbroeck <thesven73@gmail.com>
> Signed-off-by: Sven Van Asbroeck <thesven73@gmail.com>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]
Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
