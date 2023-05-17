Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25468707340
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 22:42:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229739AbjEQUmc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 16:42:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjEQUmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 16:42:31 -0400
Received: from mail-oo1-xc2c.google.com (mail-oo1-xc2c.google.com [IPv6:2607:f8b0:4864:20::c2c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7320A30DE;
        Wed, 17 May 2023 13:42:30 -0700 (PDT)
Received: by mail-oo1-xc2c.google.com with SMTP id 006d021491bc7-54fd9c0e435so555396eaf.2;
        Wed, 17 May 2023 13:42:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1684356150; x=1686948150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=IKmc4/mY2T8M2vtBoa3KRIY5AIQ1sNsQWDEPH950Scs=;
        b=eUGiJbnfLgkPtl6HyfdqGOEGxQmhF6+mgHDX4SBK74DqCsMAtewI0AtjeOiTs3oNqq
         4DB7ue0e5qRJccB4bfIXxaZyaPoxol+uXIQfhHJf2LkbDwxCV9fMguKjOXpb4uQL3pPM
         dIZKc1l6DfNpP4fum/8/L07J1kyQSb7rR03oaAfGT/fy2PpYT+WRXnIW8ODOgBYgOLhQ
         MOpXPBwJ3D7sdNEXc0wsZlJ7/3dNQLaKOf68ifgkOjxwE0c1c8KECZ00ltgkejzykvx0
         M0UXVwBqnwENbA8nfmusa/2ON7UtyaA6xxzfg87HGQX9qnEfLh9zntDfeFNqnAdiRyuO
         ZNPQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1684356150; x=1686948150;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=IKmc4/mY2T8M2vtBoa3KRIY5AIQ1sNsQWDEPH950Scs=;
        b=GgjIbS09KIBwqH8m0HTB1l/UEirfdmpscNCTHpm5rLqKNh2k5kMh38exAopZG3xx9x
         KM3GDjFtBqhgbfG+xEZ0q9Z3U9GwHJjjrtLJiY3XMe+PY+9khTujD90AbuG71vJpuiHN
         XFPMfhQ8uCoS9Ga1lkzGeVniu7vsOEd4/vZkC1GPv26vBP8NXK9uj8fV2EsX08m5e1i7
         RfIH2FbsDz49codA5gUm31/IpgFe+5aVRgWa+ehkvRCPOYdo7IkfIUh12SHToJxN6L6z
         1OEerayqx+vqPeD5K3JvEffRN4y1Kqusd2zwcSYx9eKhE0YZ/sR9g2dtOptuDtCZbZ/C
         69Hw==
X-Gm-Message-State: AC+VfDwFUnu71BSl97ib/AyzX0BUUM2U2kn2e+luBtJoEoDsRY1KMQiw
        /6KdK3fgtKBfLrXp3W/hLKk=
X-Google-Smtp-Source: ACHHUZ41+outjsfJKy4Z+3zXxQQv9yrO3qwXSk9TUPgATnMrC9PcekqE5qHFLmEcRTICyBwlKGf1sA==
X-Received: by 2002:a05:6808:99c:b0:395:7577:1533 with SMTP id a28-20020a056808099c00b0039575771533mr39910oic.37.1684356149776;
        Wed, 17 May 2023 13:42:29 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id q66-20020acac045000000b0038c0cf168afsm10424955oif.7.2023.05.17.13.42.24
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 17 May 2023 13:42:29 -0700 (PDT)
Message-ID: <6a8183b8-0e81-9f2f-f79f-74ca5beb3ef4@gmail.com>
Date:   Wed, 17 May 2023 17:42:22 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v1 2/2] rust: sync: implement `AsRef<T>` for `Arc<T>`
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
 <20230517200814.3157916-2-aliceryhl@google.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230517200814.3157916-2-aliceryhl@google.com>
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
>   
> +impl<T: ?Sized> AsRef<T> for Arc<T> {
> +    fn as_ref(&self) -> &T {
> +        self.deref()
> +    }
> +}
> +
>   impl<T: ?Sized> Clone for Arc<T> {
>       fn clone(&self) -> Self {
>           // INVARIANT: C `refcount_inc` saturates the refcount, so it cannot overflow to zero.

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
