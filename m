Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D24570734F
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:47:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229794AbjEQUq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229532AbjEQUq6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:46:58 -0400
Received: from mail-oa1-x30.google.com (mail-oa1-x30.google.com [IPv6:2001:4860:4864:20::30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3655255B3;
        Wed, 17 May 2023 13:46:57 -0700 (PDT)
Received: by mail-oa1-x30.google.com with SMTP id 586e51a60fabf-19674cab442so915542fac.3;
        Wed, 17 May 2023 13:46:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684356416; x=1686948416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=tOWjDaNo3/cJ5irwgAWSl2hXx4QRdUNNrZTKP14O2Xo=;
        b=DKhNLAOxM7f1QqxL7ESIoOIpDxHgo31eq97FmRl6lrjFs42gZeymo5Y0DuuXWMPsVt
         qFW7Gm3we0p+BJ/HK2pzFKC8LM34kFMYICsOSq6KWoDmS1tvNric1jAPpMdNZS9OtWCt
         iDg9+/XmCTklCtzCDH9T3BGqgJ3lmtFKIqxmhVuNSdzpBN6hrpXR3CKylIw2efJPBVKB
         Imj1pATGnSmMHr83gCVz0TR4Uz3/e9hjym2wy/LIVbPnKc4IYLknJ0vrzo7NKDZoeGl4
         XnqphKA/6CJtr5/o2GZ0yn8YXwgmYnnD8vTmCfMBotd6RCNZ3eSzXmzRLUq9mQ+2eFOK
         i0bg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684356416; x=1686948416;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=tOWjDaNo3/cJ5irwgAWSl2hXx4QRdUNNrZTKP14O2Xo=;
        b=cbjAX/oWSczdx2ysPseTXl6Et5vo7D8Fbl4fjERDmqafgaAuGbDFrNrWtOarlxnWq1
         9w3RVpKqH7tsQLMsaaYqK42/0Ye+FIIDx7+9NwrgsEPT8SNstINcQ4PbeYUzImw6TFK/
         n3F0cVY6ydwHu6legrfCZWrkSRgtL1Zw7zau5u9Oux+pUl7gXK8+aPXLzQLd9k7JI4m1
         j2FotPiFskZZeJqwImmfPlW6VWYDMQUkP4wCurOs72yYvbsWHat3h96Ess7ufA4dZoRj
         o/7wuHAtHtS7N0KobJs/K/95il7aViGcuQqe2czYv0hs318rBBYkB7V9srZ1sLTwGUSO
         pI4g==
X-Gm-Message-State: AC+VfDwZJTE17STQQTog4SFG/SQfO499FgZ9XoDVTFcexoiQOCSCEMdJ
        Pu86W4KbDtsPer2PKbnHFzM=
X-Google-Smtp-Source: ACHHUZ4Fy1lnnqBoT3R7pNo7eHnEXuk2Q1IeKoNRk5GFRNws5g5Z4uFR+rwa2Fery3DNzuDAMENGuw==
X-Received: by 2002:a05:6871:8504:b0:192:b536:259 with SMTP id sx4-20020a056871850400b00192b5360259mr96231oab.19.1684356416433;
        Wed, 17 May 2023 13:46:56 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id g15-20020a9d6a0f000000b006ab1dd9eedesm9048otn.49.2023.05.17.13.46.52
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 13:46:56 -0700 (PDT)
Message-ID: <ed7b485c-a700-ed59-5480-01417977fa41@gmail.com>
Date:   Wed, 17 May 2023 17:41:11 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 1/2] rust: sync: add `Arc::ptr_eq`
Content-Language: en-US
To:     Alice Ryhl <aliceryhl@google.com>, Miguel Ojeda <ojeda@kernel.org>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Alex Gaynor <alex.gaynor@gmail.com>
Cc:     Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Will Deacon <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Mark Rutland <mark.rutland@arm.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        patches@lists.linux.dev,
        Wedson Almeida Filho <walmeida@microsoft.com>
References: <20230517200814.3157916-1-aliceryhl@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230517200814.3157916-1-aliceryhl@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/17/23 17:08, Alice Ryhl wrote:
> [...]
> +
> +    /// Compare whether two [`Arc`] pointers reference the same underlying object.
> +    pub fn ptr_eq(this: &Self, other: &Self) -> bool {
> +        core::ptr::eq(this.ptr.as_ptr(), other.ptr.as_ptr())
> +    }
>   }
>   
>   impl<T: 'static> ForeignOwnable for Arc<T> {
> 
> base-commit: ac9a78681b921877518763ba0e89202254349d1b

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
