Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B5A574A7F5
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jul 2023 02:03:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbjGGADR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 20:03:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229748AbjGGADP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 20:03:15 -0400
Received: from mail-oo1-xc2b.google.com (mail-oo1-xc2b.google.com [IPv6:2607:f8b0:4864:20::c2b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D7AF1986;
        Thu,  6 Jul 2023 17:03:15 -0700 (PDT)
Received: by mail-oo1-xc2b.google.com with SMTP id 006d021491bc7-56584266c41so900265eaf.2;
        Thu, 06 Jul 2023 17:03:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1688688194; x=1691280194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z0xeKtw/QKzo9rX8om008UjxAfMA64TNu1z2SedRUUU=;
        b=WE4WfIGHEStb4rbtrszjII2ACnX3KDz6sv1pyDsT1uD5lcWi2z6ZR++awNP7Z7lDnT
         8KoyxNfiCUBEVMLus7BHqz0ZIB5mHzwq3yWD2NKLtbqGxmdITk7BFTU6BcGaUK5aXW/k
         HolzyHN1owEPG/FgPPphenMKaOIcsZozErVkeby6m8knBCAdX6ZiEiBQIRvvKiWX/pN5
         e/kmjNbDcXAiXBKW9npW03NGc9g3Pj2RC+9zUun0VrLJnUGAPZquYGPVQWZBhm0CGxrO
         XVePmvMGRPde5RizHtR2IVsuM8+yBKKrTV/TnZ6pEbhQDK1ik4ZfdSWP18qGgyGjIy/t
         KTKg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1688688194; x=1691280194;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z0xeKtw/QKzo9rX8om008UjxAfMA64TNu1z2SedRUUU=;
        b=Ihx5L1bJyFfYH58klNdPQ2FcHbsXijojwBwxDtUGaCnu4bWPSw3qdkJVTwQWKr2z3U
         jT6GRufTiIvfsrol+2lPuvwS71l4APiFfYZdgorgQFglQlmKxmCJ2UQxhffmyXCL0Qx+
         VQa7vhg4MadX6qGoVWADJGnuG4yK9UVS0gk0NJaBXzOrRPvvQ7F/s8/fTudPiLnd/sCw
         /RasaUKpJr6vaIYeMgPyaaIQoHQUJyXbRviR0SamfMKYjZyh/enZwxQjvwrOFx+4JZoW
         YFFd1oLR6NpfRVxM8KsO//NRaPYhdQCqZp7jsCgeyjmtzpO2+UIClCkhK/Oij4N8rN1Z
         F+eg==
X-Gm-Message-State: ABy/qLYRLQ2f7DupzUe8WkIiQF+J5pRXOL/D+Ui3FDgMEZL8Kr9g/kJy
        xFMkegwGPKLR6ZU8AITHMRI=
X-Google-Smtp-Source: APBJJlFXPrJCt4o7nGUeqRp683jCbt9adEX+CBk/cxVXAoT15ll6Hv8vh4gBsTSocoWhF1ajHOrJTA==
X-Received: by 2002:a4a:4f0a:0:b0:562:eda7:52a4 with SMTP id c10-20020a4a4f0a000000b00562eda752a4mr2382893oob.2.1688688194530;
        Thu, 06 Jul 2023 17:03:14 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id l2-20020a4a4342000000b005634ef4f1c0sm1067284ooj.31.2023.07.06.17.03.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 06 Jul 2023 17:03:14 -0700 (PDT)
Message-ID: <298e5b95-19e4-f2a0-4994-cca17b27213b@gmail.com>
Date:   Thu, 6 Jul 2023 21:03:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH] rust: delete `ForeignOwnable::borrow_mut`
To:     Alice Ryhl <aliceryhl@google.com>, rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev
References: <20230706094615.3080784-1-aliceryhl@google.com>
Content-Language: en-US
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230706094615.3080784-1-aliceryhl@google.com>
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

On 7/6/23 06:46, Alice Ryhl wrote:
> We discovered that the current design of `borrow_mut` is problematic.
> This patch removes it until a better solution can be found.
> 
> Specifically, the current design gives you access to a `&mut T`, which
> lets you change where the `ForeignOwnable` points (e.g., with
> `core::mem::swap`). No upcoming user of this API intended to make that
> possible, making all of them unsound.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
