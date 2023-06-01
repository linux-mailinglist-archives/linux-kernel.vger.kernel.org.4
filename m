Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 875BB71A14B
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 16:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234671AbjFAO7S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 10:59:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233806AbjFAO7O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 10:59:14 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F95B10C1;
        Thu,  1 Jun 2023 07:58:36 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-1a1fa977667so1077066fac.1;
        Thu, 01 Jun 2023 07:58:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685631512; x=1688223512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=Q1PzCp5p/rvf4kSiJkiDCK+IFfQHrtapNUn7i04+cHk=;
        b=LfyI1grSwMs7fTAWnYBYdm8L198ljPsLAzS537iEvi7Nrp1L9VW/4QFOjBgbWeoZwE
         WjfKFQ5eeANG9bwUCVE8Io2n+9CkiEs3mDHWeGVG1qPPzd7A6N1WXm3T45neKD/EZPhz
         ie9f4ZzedU0H+qhn1kafyQjD1XQCHea76XPyoBbbONwtbXXnI8a4yLsdVeuGLzAHfM8d
         IGv5Xp+KrDGRbo/yyaIuzs6eeT95k5tD8rfwGEYOc3iCaPf3oBUkN8MoYRZxZb3TyMo9
         faDaxal3yot3T3pVx8X8lhPzDaUND1uYjNU/8qDFeq0cB+S6gfCatU/IqEcf4jRP3d9c
         lzrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685631512; x=1688223512;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=Q1PzCp5p/rvf4kSiJkiDCK+IFfQHrtapNUn7i04+cHk=;
        b=h7vgBnoobZdGmWR9x8eFudGpE+hXVIOQLxSZ8FG2dQag8O5rlrqpc22SiL2WxOn6xk
         0imcy4acWH5XiaQwdrP9nokNOcAw/7+RPtyb59uEvzLd3m4W7hfUs25yMw0jbTkkIZ/N
         GivrhdDoD+QmIn0uwbJStKvlV/Wfmk+QCm3+7VMH1CUjurE8b9LG3mTqMCsO8eTUPnI9
         TPBIesdG9YeQkNq7mOqM2fJY4ROi3RvYh+54JgaNgcsLRpBzJhagxYophd3RxU6rw7te
         qmnNdRJINB5lEd3IJQsq9B6hTBKmreeJ16GUbJW/kPRVWWR75mlrMDnZrrHyvM5ugmZ8
         3kWg==
X-Gm-Message-State: AC+VfDz0LYhaAOMKI+YbLlmO5cM1rv8MP3ghoHa+O7IiBNCSDZtVp+jT
        d6iOs49jAsjqqOAoaEcN7g8=
X-Google-Smtp-Source: ACHHUZ6BaHH9bv8aUrjOFDl/HHR2HWNrtoBmIfI763T4M9M1LJO7w/KU0E9X7QBpUdvCil4MizBZZg==
X-Received: by 2002:a05:6870:6287:b0:187:d229:2781 with SMTP id s7-20020a056870628700b00187d2292781mr7493236oan.6.1685631511579;
        Thu, 01 Jun 2023 07:58:31 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id v7-20020a9d4e87000000b006a44338c8efsm1624177otk.44.2023.06.01.07.58.28
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 01 Jun 2023 07:58:31 -0700 (PDT)
Message-ID: <f9108f3b-3d2c-47d8-8ab6-d8896c27d9c0@gmail.com>
Date:   Thu, 1 Jun 2023 11:53:49 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 7/8] rust: workqueue: add `try_spawn` helper method
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
 <20230601134946.3887870-8-aliceryhl@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230601134946.3887870-8-aliceryhl@google.com>
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
> This adds a convenience method that lets you spawn a closure for
> execution on a workqueue. This will be the most convenient way to use
> workqueues, but it is fallible because it needs to allocate memory.
> 
> Co-developed-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Gary Guo <gary@garyguo.net>
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
