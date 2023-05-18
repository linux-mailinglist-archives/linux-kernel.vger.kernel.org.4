Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CBA12708CEB
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:28:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231250AbjESA2v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:28:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231149AbjESA2r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:28:47 -0400
Received: from mail-ot1-x32c.google.com (mail-ot1-x32c.google.com [IPv6:2607:f8b0:4864:20::32c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 700C3E0;
        Thu, 18 May 2023 17:28:46 -0700 (PDT)
Received: by mail-ot1-x32c.google.com with SMTP id 46e09a7af769-6ab0c70801dso1189520a34.0;
        Thu, 18 May 2023 17:28:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684456125; x=1687048125;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=g0FW87Ad2wDL1UfeV2RlzAG0cVfqHerhHQgQeOdxHK4=;
        b=WLApfqNQH/ETesilNBi6QxjO3TlZ/XBRyrkQMVK9P3pLHy8ePwx6VybPFIibyYE6P6
         mBqjA+EXm6G6UCPDLsbXxOgXoOcwBoofn4OET/dvVV1YFVfMNJEOoQ1iwFQrWclWYsxj
         NUVTg61kp/cQUGhqo2h9/+MdDouI5diQf9ih/ITMS+Nd5qLgNy0MSNbkIlVI8oMjmeaT
         /WEg6wEB/6xwYcP9kaheO6aOYtHeeuB83pNFrJvyTco4LRMwYbsmBR3UJbyoY7NgYOsv
         UFqWbcB4439XheWeRZTnSJQWGoOca+exKC6fitHmfnR8CCgvoVYs5D/HbV9sZSdnj946
         98Bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684456125; x=1687048125;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=g0FW87Ad2wDL1UfeV2RlzAG0cVfqHerhHQgQeOdxHK4=;
        b=fYeomMoiq3o/wqRt0feRBlgHtbHx7+jqdcL1OEwyulYq+pKhSTs6ArLhV8u1frZGxg
         68z+n3kznCpBA819ff6A5B/oihUR89danCOAAWmmUjasXrhEK/gKHwTjEqFdVst6QmjI
         ihUzbDfO79xOrvNECZu7ossYig50fesKXPCEGqjFk/OWHYo1uH8QhcuZ/4PRAeW9sCsd
         U7jMLFzgAp7yi8LAsI3P/DiRcDzT6IPAqXgmkqpLP1gjK90DH3y0Zn0oGmros8Xo1eKz
         vCJ/CucO1Hi8SWaoNAk/APfqIMhuQEA5OG0xNboOPkcsRHL2L5Ik/5u/2grCKDH0J9L0
         3lDA==
X-Gm-Message-State: AC+VfDwq5UMxrGYcp8I9KS0vvkkdqY53sIi6fOBCgalb2QHRv7bC9Nj4
        36lEgfOrmAwP7jQzUAJoPA0=
X-Google-Smtp-Source: ACHHUZ4aY+D9M3ZLWMlGNCruJ9dojNg3iJsmIhdgDtLKKuECuHKjpanQhyKUmpFjxxieBeb0WCZSFQ==
X-Received: by 2002:aca:2303:0:b0:383:e7c8:4000 with SMTP id e3-20020aca2303000000b00383e7c84000mr301287oie.13.1684456125715;
        Thu, 18 May 2023 17:28:45 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id x14-20020a4ae78e000000b0054c9382b871sm975602oov.12.2023.05.18.17.28.42
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 17:28:45 -0700 (PDT)
Message-ID: <eaab4e67-5a29-4914-3306-b09b21c4b46a@gmail.com>
Date:   Thu, 18 May 2023 11:51:40 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v1 2/7] rust: add offset_of! macro
To:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Tejun Heo <tj@kernel.org>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230517203119.3160435-1-aliceryhl@google.com>
 <20230517203119.3160435-3-aliceryhl@google.com>
Content-Language: en-US
In-Reply-To: <20230517203119.3160435-3-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=BAYES_00,DATE_IN_PAST_06_12,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 17:31, Alice Ryhl wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> This macro is used to compute the offset of a field in a struct.
> 
> This commit enables two unstable features that are necessary for using
> the macro in a constant. However, this is not a problem as the macro
> will become available from the Rust standard library soon [1]. The
> unstable features can be disabled again once that happens.
> 
> The macro in this patch does not support sub-fields. That is, you cannot
> write `offset_of!(MyStruct, field.sub_field)` to get the offset of
> `sub_field` with `field`'s type being a struct with a field called
> `sub_field`. This is because `field` might be a `Box<SubStruct>`, which
> means that you would be trying to compute the offset to something in an
> entirely different allocation. There's no easy way to fix the current
> macro to support subfields, but the version being added to the standard
> library should support it, so the limitation is temporary and not a big
> deal.
> 
> Link: https://github.com/rust-lang/rust/issues/106655 [1]
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
