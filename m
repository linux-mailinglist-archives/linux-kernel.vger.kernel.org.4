Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C77271A14A
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233719AbjFAO7I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:59:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234261AbjFAO65 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:58:57 -0400
Received: from mail-oi1-x233.google.com (mail-oi1-x233.google.com [IPv6:2607:f8b0:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DED0DE64;
        Thu,  1 Jun 2023 07:58:27 -0700 (PDT)
Received: by mail-oi1-x233.google.com with SMTP id 5614622812f47-39a3f2668bdso764113b6e.2;
        Thu, 01 Jun 2023 07:58:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685631506; x=1688223506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Z5oZUj4BYKrYj6C7jgvhC/0+X5rQBbpEc43xWYXfb/U=;
        b=XpocVGWaQaH7hZ1qQXktHst2OfMpF2MYFFtqMgh7rNtfKBftvJlk6Rak6hg+4uqwSS
         +mNWfJJoFH7vJAUf+OGs4znG+e0xZpMKIADb0D0AUd3rCZj08qbc7cgmfnZAbMTEE1M8
         Jv6S3oYSchdsPXEPz1+HrnJDp1o2Ls4BTRhDPdiCE5WX8LudSB/sJoZL7gdwSmjj0KM2
         qaYLaBMnyNLlUr7/0qYyojcLFxFiLAabaxxueI3Q53dVaGOA6xNcAL0hvlaB0lvzTqRw
         lsDeJ3T9gQ6tfmooUSTulkrUzxwX13sqOHuFc5zTfv/e5uM4W/vWhRoW4I9aD0MgAaav
         +nRQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631506; x=1688223506;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Z5oZUj4BYKrYj6C7jgvhC/0+X5rQBbpEc43xWYXfb/U=;
        b=cDqDOtN/YmxWxj6UFPbOq6R1CZ1mVZQv+0PZ5nyj5qebiVt7kzwjaLqvCsc5ucU6XP
         aGJFACVLKuJAO/8Zer1bDBjl7jjQQmRh/fnNeWyiD+L9XyuqVC0lliyjLbI4azzsfH3B
         Bh2SbroJ1PXGS0pYovhQGPj1gUjWhGhFpfS6MjOhCSyvis0ygtndQhbbqzKBIK7HTBBj
         5Q4oL5hBQYGSOtBHcHVvddZrd2PghHk0WLxZiIVivR8MMDNpTfZI9ILYjVI+PguYg6DR
         ILvAhBzkCLKUW4OxPSCc4o91odr3VlWv7A6u78FhpTxCHlAa0No19vTAEK3NMXHBAatM
         r3XA==
X-Gm-Message-State: AC+VfDx5UFIy5a1AGeFkCHdmYnIo0Kk+WZ0974HXT5uIXunKud8wLdzs
        ui8EOpfv6Tai2pwV2ETzeWY=
X-Google-Smtp-Source: ACHHUZ7MUVW4BH/e/4fAJO7/o//9I5SsPNDyrMCqnuoPtnvdBnyUeYLgcNuBIidEY0gR6WFFd7JGsg==
X-Received: by 2002:a05:6808:2a63:b0:398:4870:d2ed with SMTP id fu3-20020a0568082a6300b003984870d2edmr7739673oib.13.1685631506012;
        Thu, 01 Jun 2023 07:58:26 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id z13-20020a056808064d00b0039a4f37eaf4sm1705146oih.55.2023.06.01.07.58.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 07:58:25 -0700 (PDT)
Message-ID: <4f2915e9-270e-a2a8-d73e-32f8935d27a0@gmail.com>
Date:   Thu, 1 Jun 2023 11:51:45 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 6/8] rust: workqueue: implement `WorkItemPointer` for
 pointer types
Content-Language: en-US
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
References: <20230601134946.3887870-1-aliceryhl@google.com>
 <20230601134946.3887870-7-aliceryhl@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230601134946.3887870-7-aliceryhl@google.com>
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

On 6/1/23 10:49, Alice Ryhl wrote:
> This implements the `WorkItemPointer` trait for the pointer types that
> you are likely to use the workqueue with. The `Arc` type is for
> reference counted objects, and the `Pin<Box<T>>` type is for objects
> where the caller has exclusive ownership of the object.
> 
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
