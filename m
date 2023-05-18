Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BDD05708CED
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:29:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231211AbjESA3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:29:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230001AbjESA3E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:29:04 -0400
Received: from mail-ot1-x329.google.com (mail-ot1-x329.google.com [IPv6:2607:f8b0:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2C551723;
        Thu, 18 May 2023 17:28:56 -0700 (PDT)
Received: by mail-ot1-x329.google.com with SMTP id 46e09a7af769-6adf1f9f71bso190939a34.0;
        Thu, 18 May 2023 17:28:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684456136; x=1687048136;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Dq0FTVWooeZ0MmoylekKJR1AQVSvVPUAWt00zgin1Uw=;
        b=SZf9Na22C+M/jtuC85Csez3HCYGKuN0jP9otW+MR3lrbMEy8XecPsmmdr+6h3azL7b
         Rw1dGgzzTNx6Ipplr1QeQwPWWzTeL7zlhLa2ywaaX31gZ36Z8HVEwL+npw99mMrlkkGm
         uQc/37vZBCzCRhz1QRryjmep5dTaITXW9fr/Y/KZKCruCCsz8gN4tu8eOYcB2CPmvhTR
         aHRIuHo5G3IbBUDrEdmmYM3eJTHGZ0WyR0Dt0OVdgQtjgaJ2nOMlQ+1nqXb23sKmTpZV
         vCFDV+kAdiPLKzqpr5w9eHPNIenFQAiAWu2HZqj+yyoagGNVz3BdkB7kCZFcfiUtDlPZ
         5Rhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684456136; x=1687048136;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Dq0FTVWooeZ0MmoylekKJR1AQVSvVPUAWt00zgin1Uw=;
        b=Gwdsl7TM7wNGTuRYExIyd0Z/BoTjsFcoG8YkPkxWa4kpegip0eJntcH8CZKis1E3Wo
         RZHt7hIk5y00xDMJjKIZmlV81eJc/Ik1bj0lK/12C1ZySbmGX5eN3b/uoOYOZjfepslZ
         /lpNbMsQptpXnrWjxnNvVcwvcbfbzvgCHbbeupDGGWNyUx7l8QeOuAcgIrnC0dk917yI
         b4ieaxvUb5eZ3HwDLiETxwhd93t8bw+U1QTy6e7HBkGMC5FLTqgswChxqAD44fo+W5Gb
         CVEyTUCcLD9x2SVRiV246BoLSE2g1s+IaLluyvauuNXQdHA/LMG6gNVEfUlUAcxJZdV7
         wORA==
X-Gm-Message-State: AC+VfDyQFtleUzUXt+q40Ureja1dMoZ8r8Bo6CNxcx+zLfs/nMLzMHj2
        Td1xGfbadjgml6n9ByKhXi9qJwXlwIQ=
X-Google-Smtp-Source: ACHHUZ74J8xojzdM8meZH8KrNn0aVMzxCEucfljOc4OUYpjOUwRAiM3rDUsaxuO4aYRDl8RzuxeN7A==
X-Received: by 2002:a05:6830:1d6c:b0:6a6:814:4789 with SMTP id l12-20020a0568301d6c00b006a608144789mr314924oti.11.1684456135756;
        Thu, 18 May 2023 17:28:55 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id l19-20020a9d7a93000000b006864b5f4650sm1205672otn.46.2023.05.18.17.28.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 17:28:55 -0700 (PDT)
Message-ID: <4d4f0e55-c703-3fed-b162-dfd09c488779@gmail.com>
Date:   Thu, 18 May 2023 11:52:12 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 4/7] rust: workqueue: define built-in queues
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
References: <20230517203119.3160435-1-aliceryhl@google.com>
 <20230517203119.3160435-5-aliceryhl@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230517203119.3160435-5-aliceryhl@google.com>
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
> We provide these methods because it lets us access these queues from
> Rust without using unsafe code.
> 
> These methods return `&'static Queue`. References annotated with the
> 'static lifetime are used when the referent will stay alive forever.
> That is ok for these queues because they are global variables and cannot
> be destroyed.
> 
> Signed-off-by: Wedson Almeida Filho <walmeida@microsoft.com>
> Co-developed-by: Alice Ryhl <aliceryhl@google.com>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
