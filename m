Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8548708CF3
	for <lists+linux-kernel@lfdr.de>; Fri, 19 May 2023 02:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231209AbjESA3v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 May 2023 20:29:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231356AbjESA3r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 May 2023 20:29:47 -0400
Received: from mail-oa1-x2c.google.com (mail-oa1-x2c.google.com [IPv6:2001:4860:4864:20::2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9BFE198B;
        Thu, 18 May 2023 17:29:16 -0700 (PDT)
Received: by mail-oa1-x2c.google.com with SMTP id 586e51a60fabf-19a08412723so2153334fac.0;
        Thu, 18 May 2023 17:29:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684456152; x=1687048152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=EbAo41j9dwaocJzq5AJ7mE2sUYUnT4TmOl4fPIqDs6s=;
        b=kTOQ732NQvlCQq8Zzwc9xoIYIcSmprkzUZG30JzSBdEgY2MmtaPfV0f3oysoGflmm/
         acHaoeFG/jlLweltf2uVCVj5AulWWpl27cfd/70YzZQc2p/+ok93tpzXCPwU/U7MmIiq
         /C/fmMzbXvca+xixezrYHLNyFW/2EXxmbmHCA3XPG0eR1EAKTrULfDAZwrqiRO+I/xJ1
         ISEWQhIRibpp5HlMeDBYu0wuUV6ihxFTG883bJgbUexDaBY0rUXKz0mJO04Ty5cwUzVR
         NA3krUtJ9U/mc0K6fOgkEQLE1gY6+flTFftaFQ3SM920uMXopx07txrBlP0BL/N752yb
         1RBg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684456152; x=1687048152;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EbAo41j9dwaocJzq5AJ7mE2sUYUnT4TmOl4fPIqDs6s=;
        b=Lz5USSi4xKJKS36UUnmEwSY1pDiazKkwnePWMjGVwV7o26UAgRKYKwEcNf9FyWwEfu
         9FG2n9ZEAM4vz6VazljuXT5Z/uXWnPaajId/s3aiTsReKt9jPQAplRL1awJdrnrE3R7c
         vdUydNteblBEXOqBll5DzdOg9xnfixArU3pjA/8zXMoUHdJkclhPIvkONEJ1kGw/eAEk
         PS8AeyWFFTjCDeSdirxtRqE6DJurRhgUElEK3avmATWKLKPpTN8Jlu2Qwdxxcxah5HNk
         ZuwGBmhRtIMe1FZ9J5unMB0emHj2uDBlhRCzh9oEXdt7LErmhTvNiPsTxXIPLH1UUMg1
         mMpA==
X-Gm-Message-State: AC+VfDyFW+T6NaKk5VksDkzxoWOnvYZHqGpAKp3qg1oJBOYtD7ykFeky
        me7dEUgb36aEdJT8ul5R24s=
X-Google-Smtp-Source: ACHHUZ7R0NSRLuks3+Tvx1V18EGuJSFwkjrX+Vq0Aw9bVeQUXZre/pcYUkY2csM5F5hPc5AXhjt8kQ==
X-Received: by 2002:a05:6871:721:b0:196:331a:b8f5 with SMTP id f33-20020a056871072100b00196331ab8f5mr326266oap.3.1684456152497;
        Thu, 18 May 2023 17:29:12 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id oh16-20020a0568702c9000b0017ae1aede32sm1376614oab.46.2023.05.18.17.29.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 18 May 2023 17:29:12 -0700 (PDT)
Message-ID: <85aca422-6799-a2dd-cff7-99e0ec564ff4@gmail.com>
Date:   Thu, 18 May 2023 21:22:33 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 7/7] rust: workqueue: add `try_spawn` helper method
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
 <20230517203119.3160435-8-aliceryhl@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230517203119.3160435-8-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 17:31, Alice Ryhl wrote:
> This adds a convenience method that lets you spawn a closure for
> execution on a workqueue. This will be the most convenient way to use
> workqueues, but it is fallible because it needs to allocate memory.
> 
> Signed-off-by: Alice Ryhl <aliceryhl@google.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
