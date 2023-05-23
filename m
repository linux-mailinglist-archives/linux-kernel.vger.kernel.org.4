Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 558B670E25C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 18:49:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237655AbjEWQmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 12:42:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52248 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229815AbjEWQmU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 12:42:20 -0400
Received: from mail-oi1-x22b.google.com (mail-oi1-x22b.google.com [IPv6:2607:f8b0:4864:20::22b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56AA513E;
        Tue, 23 May 2023 09:42:18 -0700 (PDT)
Received: by mail-oi1-x22b.google.com with SMTP id 5614622812f47-38ef6217221so4329021b6e.3;
        Tue, 23 May 2023 09:42:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684860137; x=1687452137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=oeg/x8ElLxAyFPJ7qiWHT0FiJCrJGSJu6Alu0egt5Uk=;
        b=Cuzse6fc6vWWICPMHp6WOgOCrjVqiwCLDc6cMmV4y6VpglijS/esr7OItyOfLSLFaD
         uzH3zg1NpiuhR1V02vDVsyTrkH5pvYCp44n3f011ZwSDfxi6t28+j+pm/uGMnix4H3J7
         wjgkOr+5ntWdGqLmRPqRIKtn1uQ+IlvSZXs3cZY9mf6oudHL6qMm3n9OI7bKA6EVkxhL
         5p6SfR+y59ac/lcVbmIlGNCFcZU3wfnhAN/AyRLM2Rcfptvo+790f53shNyOy6ciEIhU
         3WjhIvu5glppjnJaQ0WrUU6aZMh4aItHrDAi8rnvjwApp/EcnlcmCgbMe3eSnwDhiRoh
         NsBw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684860137; x=1687452137;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=oeg/x8ElLxAyFPJ7qiWHT0FiJCrJGSJu6Alu0egt5Uk=;
        b=js96n1EigCKeLSkt7JkX/zmJ9BA47V8MUVH8y1ieXUZd50dSOaPxHCaVRI521dcrhO
         1/YFSuVjUHPH891FbXV2zU/2VVKyZfqWJz7HohT6/KXDxWPMtnR2ghnYUcqfAOQtjDLi
         KDFWpNxmAcmRMWMjrOTBcjiz7obDjI45OoFXq07m5rWN4WAHpKuLqUuSghOHMa6NX1bt
         cZZPqig32yDrr4YXhilPJ2WZtdbX1GirIa5xggHKDWlnMLUsBF/4VNQ+f2E+grSGjkVF
         v3RdYtVi24tv2WCR5eRn9DBw3wH6EUuJRSBV05rTY7HyY0WSZulYaAZtM1HeQ/9sW9/7
         GeWg==
X-Gm-Message-State: AC+VfDydigA0idJzofFGLZbOG0Fw1gIEjwu78Qtz7vPwvSbVAJXfnATq
        EmNbZX41ZAFOvoQyZeC6OTk=
X-Google-Smtp-Source: ACHHUZ4KiqUCV5vcGG9La2JI7FtHqJtRDi5PtpsZqmtFy+kGQcvvEiOyY34u3mTt2fU8dnHrZL8C1A==
X-Received: by 2002:a05:6808:191:b0:398:10ad:e857 with SMTP id w17-20020a056808019100b0039810ade857mr3427905oic.48.1684860137521;
        Tue, 23 May 2023 09:42:17 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id w81-20020acadf54000000b00398031b1014sm2887905oig.26.2023.05.23.09.42.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 23 May 2023 09:42:17 -0700 (PDT)
Message-ID: <83f2822e-f36c-0dbf-8226-cef3dc2ba072@gmail.com>
Date:   Tue, 23 May 2023 13:41:35 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 4/4] rust: task: add `Send` marker to `Task`
Content-Language: en-US
To:     Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev, Andreas Hindborg <a.hindborg@samsung.com>
References: <20230523144418.1250547-1-aliceryhl@google.com>
 <20230523144418.1250547-5-aliceryhl@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230523144418.1250547-5-aliceryhl@google.com>
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

On 5/23/23 11:44, Alice Ryhl wrote:
> When a type also implements `Sync`, the meaning of `Send` is just "this
> type may be accessed mutably from threads other than the one it is
> created on". That's ok for this type.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> Reviewed-by: Andreas Hindborg <a.hindborg@samsung.com>
> ---
> [...]
>   
> -// SAFETY: It's OK to access `Task` through references from other threads because we're either
> -// accessing properties that don't change (e.g., `pid`, `group_leader`) or that are properly
> +// SAFETY: By design, the only way to access a `Task` is via the `current` function or via an
> +// `ARef<Task>` obtained through the `AlwaysRefCounted` impl. This means that the only situation in
> +// which a `Task` can be accessed mutably is when the refcount drops to zero and the destructor
> +// runs. It is safe for that to happen on any thread, so it is ok for this type to be `Send`.
> +unsafe impl Send for Task {}
> +
> +// SAFETY: It's OK to access `Task` through shared references from other threads because we're
> +// either accessing properties that don't change (e.g., `pid`, `group_leader`) or that are properly
>   // synchronised by C code (e.g., `signal_pending`).
>   unsafe impl Sync for Task {}
>   

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
