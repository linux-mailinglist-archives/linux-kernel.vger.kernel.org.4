Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F1C036DC0B4
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Apr 2023 18:48:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229581AbjDIQsM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Apr 2023 12:48:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229485AbjDIQsL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Apr 2023 12:48:11 -0400
Received: from mail-ot1-x32b.google.com (mail-ot1-x32b.google.com [IPv6:2607:f8b0:4864:20::32b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8568D3C39;
        Sun,  9 Apr 2023 09:48:01 -0700 (PDT)
Received: by mail-ot1-x32b.google.com with SMTP id w15-20020a056830410f00b006a386a0568dso8793234ott.4;
        Sun, 09 Apr 2023 09:48:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681058881;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id:from:to
         :cc:subject:date:message-id:reply-to;
        bh=hr7IpqkVVvaH5bCublyFVgApREgtsWPOkPRTPgJ+F6M=;
        b=I9abLB1PvolfWqqE8UtbrJ/PP/3MdCP0zMlH1Yr0fFq7V2xIONDjn2GpJfrVcYt1Vt
         pXtX4dYEx6tgfvlEIdnsvCLoFKfEXCpAJopTgCQhM7ps6m/PRMx7vwG3qMUn0Gp+b3Mr
         gfF2O8J14VjwLL+zmtWOFma18SL9M5Nulzy605iQl3wS4HEIxQb4QxOEmhsfgP5RWCHb
         atIwaBA2ZAX99W/ni/enn0fz/Eqi6qbmgFR8jKWBzY6IJWavQcDzC/jRGtU3TqqiH8Cu
         MvDI4C6dI0KdPL8wvioJ812L0/yi4gKQLgiDmOLPi68iAeCObBNoZuH6W1vHVD1kLM4Q
         C+Mw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681058881;
        h=content-transfer-encoding:in-reply-to:content-language:references
         :cc:to:subject:from:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hr7IpqkVVvaH5bCublyFVgApREgtsWPOkPRTPgJ+F6M=;
        b=CKesR1/iErh3UqvscfMFuIB53xGMJNxDVhPbNL3UjBNBR1fQUZt3lAkxmg4T5OH2yj
         W2A/eAOe5Wa80WYEV+GzMpfUsNqTXCGXeowaRVUEnOXAdV8TaRJ/TZGpAEi2R7lUuebw
         GeC/rRnaIrk9CBL2NfYiS/IPoKBNA4btLvLmGvmYfgNm1JPHRCeE36W6raXi5qzNubDg
         J2JmZ/Kri7lYa3LLYwI9YwaQLMqIEDdj0P1xDtsp/XYnnVkU8LvJyeA5ZBiInDHh7zHe
         gqosLYC69wBs6KqGXkn0Hm7IRsikqkScorXWwMQm5CC1yq95f6FfpgLfx3HqXo8/UvkZ
         yEWw==
X-Gm-Message-State: AAQBX9fbtb+TchZsfjToREq1Ckamj8PAOVejgSoOKLXZ3IvXyf7dGQ+t
        D8W3ig4w+/e/bTbv6x7MwBUmXfrV1Ow=
X-Google-Smtp-Source: AKy350bAVagg+2643xuzs3v9IEyzM8C04yBnGY6zpZfCQXpGm60SJNZ/j4XvEbH0ZaPfvp+CawdTHg==
X-Received: by 2002:a9d:6d01:0:b0:6a3:e0bc:86a9 with SMTP id o1-20020a9d6d01000000b006a3e0bc86a9mr2102900otp.33.1681058880873;
        Sun, 09 Apr 2023 09:48:00 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id z22-20020a05683010d600b006a119c75ad8sm3503780oto.55.2023.04.09.09.47.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 09 Apr 2023 09:48:00 -0700 (PDT)
Message-ID: <5956fa17-027a-e5fc-5fcf-f80a1544eac6@gmail.com>
Date:   Sun, 9 Apr 2023 13:47:56 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
Subject: Re: [PATCH v3 04/13] locking/spinlock: introduce
 spin_lock_init_with_key
To:     Wedson Almeida Filho <wedsonaf@gmail.com>,
        rust-for-linux@vger.kernel.org
Cc:     Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        linux-kernel@vger.kernel.org,
        Wedson Almeida Filho <walmeida@microsoft.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Waiman Long <longman@redhat.com>
References: <20230408075340.25237-1-wedsonaf@gmail.com>
 <20230408075340.25237-4-wedsonaf@gmail.com>
Content-Language: en-US
In-Reply-To: <20230408075340.25237-4-wedsonaf@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/8/23 04:53, Wedson Almeida Filho wrote:
> From: Wedson Almeida Filho <walmeida@microsoft.com>
> 
> Rust cannot call C macros, so it has its own macro to create a new lock
> class when a spin lock is initialised. This new function allows Rust
> code to pass the lock class it generates to the C implementation.
> 
> Cc: Peter Zijlstra <peterz@infradead.org>
> Cc: Ingo Molnar <mingo@redhat.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Waiman Long <longman@redhat.com>
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> ---
> v1 -> v2: No changes
> v2 -> v3: No changes
> 
>  include/linux/spinlock.h | 9 +++++++--
>  1 file changed, 7 insertions(+), 2 deletions(-)
> 
> diff --git a/include/linux/spinlock.h b/include/linux/spinlock.h
> index be48f1cb1878..cdc92d095133 100644
> --- a/include/linux/spinlock.h
> +++ b/include/linux/spinlock.h
> @@ -327,12 +327,17 @@ static __always_inline raw_spinlock_t *spinlock_check(spinlock_t *lock)
>  
>  #ifdef CONFIG_DEBUG_SPINLOCK
>  
> +static inline void spin_lock_init_with_key(spinlock_t *lock, const char *name,
> +					   struct lock_class_key *key)
> +{
> +	__raw_spin_lock_init(spinlock_check(lock), name, key, LD_WAIT_CONFIG);
> +}
> +
>  # define spin_lock_init(lock)					\
>  do {								\
>  	static struct lock_class_key __key;			\
>  								\
> -	__raw_spin_lock_init(spinlock_check(lock),		\
> -			     #lock, &__key, LD_WAIT_CONFIG);	\
> +	spin_lock_init_with_key(lock, #lock, &__key);		\
>  } while (0)
>  
>  #else

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
