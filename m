Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3F056A438C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 14:59:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230029AbjB0N7W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 08:59:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229566AbjB0N7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 08:59:18 -0500
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E10E9EFE;
        Mon, 27 Feb 2023 05:59:16 -0800 (PST)
Received: by mail-ot1-x32b.google.com with SMTP id g6-20020a056830308600b0068d4b30536aso3559814ots.9;
        Mon, 27 Feb 2023 05:59:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=unp+qLGJP8+58YKKISdSfno956lsSwpDkwJ9G7KtJjc=;
        b=bgH1FCe4rig0MtFhhCFj1NGgZUm4UtF77mkd/1Q/HjtjYuksmHVUr/r/Qpzc1o1H8F
         8c5EQrMlkgow5oofpdFWHlHlYYgUO5K7JCEE7Y9Axid1CRyS//HSbPjbcxodfL/G247a
         g/ey4y6JAVgXSsGIEwW73QxFkOBGul+jWM6iBefMoQbSwimkbxR+pR29ROX2jOBlYeqV
         OsZZCjYK4OzRWROtwBfnzqykI8XDYghZwDJ/eFRhWSBQmQoTuREpAruQrdxqKolLzV/E
         tISjRD/OAXqSiWNDJs9JcR6czijxbShGaaoRCNr3Oxyxvtup0M3MK32xxv8nabPrqnR5
         vlkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=unp+qLGJP8+58YKKISdSfno956lsSwpDkwJ9G7KtJjc=;
        b=myr3ItirQ/PVjWSi08k8YiTJEM5L98tlGwp86PViB/ppL4ZUwhFoREvXaIufDCmXJC
         4i8tkR21TDxjh5lqdlRowuvkZBbVa1SFrpCTAUpQiSsSIvQist53Z08XmUAB5KbC7uat
         VWbtjxzbcXGHZKnnR5CQKUi/qOMtrCcMIl8fm9cNg3oDf0Xt9Y/d54PY3r879dT9AJry
         7gYMWAX6qYl81iA1rmG1XG2KccKcJbNSx0uc1JNjtdywNk9/HIj/yiFLUzoYkrI8fQI9
         YSp30+UVqReAvvdelRpShmnWKig2uqUJpCEGnMEiUItkBNfp/63+1I0f/O1quQ9T/cV9
         fJyQ==
X-Gm-Message-State: AO0yUKXzjcAX5lmDHeYxyxzbDYPz8htpQ3h+b0ZRulxUs7XK9pkX1gl0
        pg/n2eonalzQ1cGaEkAGdahyIT7ZMv8=
X-Google-Smtp-Source: AK7set8W4wfK9yMevPg4QyZg5y3a741TO2MJpfMAbvCN2Eyfyg90eSqe24+1IzevZqWCWzrrh+qgQg==
X-Received: by 2002:a05:6830:43a2:b0:68b:e2bc:3f7 with SMTP id s34-20020a05683043a200b0068be2bc03f7mr4427410otv.18.1677506355439;
        Mon, 27 Feb 2023 05:59:15 -0800 (PST)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id z14-20020a9d468e000000b00686a19ffef1sm2606492ote.80.2023.02.27.05.59.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 05:59:15 -0800 (PST)
Message-ID: <066e7233-e248-aad5-7db9-63d009eafa19@gmail.com>
Date:   Mon, 27 Feb 2023 10:59:10 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5/5] rust: error: Add from_kernel_result!() macro
Content-Language: en-US
To:     Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>
Cc:     Gary Guo <gary@garyguo.net>, Asahi Lina <lina@asahilina.net>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>,
        Fox Chen <foxhlchen@gmail.com>, rust-for-linux@vger.kernel.org,
        linux-kernel@vger.kernel.org, asahi@lists.linux.dev
References: <20230224-rust-error-v1-0-f8f9a9a87303@asahilina.net>
 <20230224-rust-error-v1-5-f8f9a9a87303@asahilina.net>
 <Y/lOlcSpc+d9ytq/@boqun-archlinux> <20230225222340.34d749ee.gary@garyguo.net>
 <Y/rCU1S+GDgIojNf@boqun-archlinux> <20230226133606.583cd1d8.gary@garyguo.net>
 <Y/uiAfZnfbbMrQuD@boqun-archlinux>
 <CANiq72kTiHF76T0AycM43qj4rUgQpHzBqXujdvk+H2qoDz22AQ@mail.gmail.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <CANiq72kTiHF76T0AycM43qj4rUgQpHzBqXujdvk+H2qoDz22AQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2/26/23 17:59, Miguel Ojeda wrote:
> On Sun, Feb 26, 2023 at 7:17 PM Boqun Feng <boqun.feng@gmail.com> wrote:
>>
>> My preference to function instead of macro here is because I want to
>> avoid the extra level of abstraction and make things explict, so that
>> users and reviewers can understand the API behavior solely based on
>> Rust's types, functions and closures: they are simpler than macros, at
>> least to me ;-)
> 
> There is one extra problem with the macro: `rustfmt` does not format
> the contents if called with braces (as we currently do).
> 
> So when I was cleaning some things up for v8, one of the things I did
> was run manually `rustfmt` on the blocks by removing the macro
> invocation, in commit 77a1a8c952e1 ("rust: kernel: apply `rustfmt` to
> `from_kernel_result!` blocks").
> 
> Having said that, it does format it when called with parenthesis
> wrapping the block, so we could do that if we end up with the macro.

Also rust-analyzer can't analyze the insides of a from_kernel_result!
block. Only thing it can do is to suggest a macro expansion. Plus, this
macro triggers a clippy lint on a redundant call on a closure. So it's a
bit annoying to work with.
