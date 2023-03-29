Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C1546CEC3C
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:55:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbjC2OzJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:55:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41468 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbjC2OzI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:55:08 -0400
Received: from mail-oa1-x2d.google.com (mail-oa1-x2d.google.com [IPv6:2001:4860:4864:20::2d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4536712E;
        Wed, 29 Mar 2023 07:55:07 -0700 (PDT)
Received: by mail-oa1-x2d.google.com with SMTP id 586e51a60fabf-177b78067ffso16476841fac.7;
        Wed, 29 Mar 2023 07:55:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680101705;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=00J2tFQAR6OeqFvOfd4m1mRnl/Lfkd+F4P/jvBTwR64=;
        b=mBw3isB0a1lWAdTqHxdwioIarsu2c33Jbf2ro3MVQKkVS7vwS0GCcz1C/XS+tDklxV
         3cETivgOWeXaiLXxq9FahWs4ZREjvb5G3ReGLP7K3bQF7g+nCaZGOKIBD00qaseVd5xm
         aaoWgCtl/WeE1xtJQ7itFaB76z+IDoxIoCz6UI1Yg6LrQICF9n95579fcHod19gOB3nh
         PxYZ6ruPeIw0MN/HYlnrq/2uuDxOuOJQ+nq9ySzbyEMa7A9n3gIzbgAsAL1VJtKMPxUX
         GnNSCnUc638Czhs2GXAuzrHT8AIpwUxCNnK3DcB3AtQlwiVX4tfxDc73MxNQoLXKKwmw
         PqjQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680101705;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=00J2tFQAR6OeqFvOfd4m1mRnl/Lfkd+F4P/jvBTwR64=;
        b=Em7dPiRWr07H0DBLtjHvu6Bf1RqDFbzWvRD7T1JmH1HwGB5pIZ9iHUEb9NFaQ3ObRs
         k2LHK+Z/9y2uMlIDU8fBx+6o+cyLSatvcMFikUJr0LcTg0N6SO2jSY3CnRD8kY+04nLv
         546/Vf9dsntqTwybRGT7xm4DHRdX60QuUGoOXHT+ypiMDcJGr9T3iuWK+F/udfBUHJYa
         d2mklE88BMCW56DKFhfFL1eOnzam2DAHgLMKl4N7E3vLaioBm0/hRDNuhE3Sf1Tt5NLQ
         72v+m0Qs7bs6Yb7DIs/AzW0a4O4DTCP6UHgdit73RD64kzoz8kzJbxJkSjvHNpBs8SwY
         75CA==
X-Gm-Message-State: AO0yUKU4fQfAe+2VSyHdd758UuShKw6EFcgq4UrIaO6rgZHjQRIhEbnL
        OK9RFWJiMoph0aadBKY7Dn+qtDoWRRo=
X-Google-Smtp-Source: AKy350beORPmwZIBbiLlLRNWPpKJeHvKoLbHpBB2RSMF0sQJeYJuwtLaAUnyFC7BzWXnQCJgL+L8/A==
X-Received: by 2002:a05:6870:9129:b0:177:b438:b0a with SMTP id o41-20020a056870912900b00177b4380b0amr11242837oae.53.1680101705512;
        Wed, 29 Mar 2023 07:55:05 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id wi22-20020a056871a71600b00176d49bb898sm11800496oab.44.2023.03.29.07.55.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 07:55:05 -0700 (PDT)
Message-ID: <bc99d578-0905-5cf6-db0d-1ebad2b3d9b2@gmail.com>
Date:   Wed, 29 Mar 2023 11:55:01 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 6/6] rust: error: Add from_result() helper
Content-Language: en-US
To:     Asahi Lina <lina@asahilina.net>, Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Sven Van Asbroeck <thesven73@gmail.com>
Cc:     Fox Chen <foxhlchen@gmail.com>,
        Andreas Hindborg <a.hindborg@samsung.com>,
        rust-for-linux@vger.kernel.org, linux-kernel@vger.kernel.org,
        asahi@lists.linux.dev
References: <20230224-rust-error-v2-0-3900319812da@asahilina.net>
 <20230224-rust-error-v2-6-3900319812da@asahilina.net>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230224-rust-error-v2-6-3900319812da@asahilina.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/29/23 09:04, Asahi Lina wrote:
> [...]
> 
> +
> +/// Calls a closure returning a [`crate::error::Result<T>`] and converts the result to
> +/// a C integer result.
> +///
> +/// This is useful when calling Rust functions that return [`crate::error::Result<T>`]
> +/// from inside `extern "C"` functions that need to return an integer error result.
> +///
> +/// `T` should be convertible from an `i16` via `From<i16>`.
> +///
> +/// # Examples
> +///
> +/// ```ignore
> +/// # use kernel::from_result;
> +/// # use kernel::bindings;
> +/// unsafe extern "C" fn probe_callback(
> +///     pdev: *mut bindings::platform_device,
> +/// ) -> core::ffi::c_int {
> +///     from_result(|| {
> +///         let ptr = devm_alloc(pdev)?;
> +///         bindings::platform_set_drvdata(pdev, ptr);
> +///         Ok(0)
> +///     })
> +/// }
> +/// ```
> +// TODO: Remove `dead_code` marker once an in-kernel client is available.
> +#[allow(dead_code)]
> +pub(crate) fn from_result<T, F>(f: F) -> T
> +where
> +    T: From<i16>,
> +    F: FnOnce() -> Result<T>,
> +{
> +    match f() {
> +        Ok(v) => v,
> +        // NO-OVERFLOW: negative `errno`s are no smaller than `-bindings::MAX_ERRNO`,
> +        // `-bindings::MAX_ERRNO` fits in an `i16` as per invariant above,
> +        // therefore a negative `errno` always fits in an `i16` and will not overflow.
> +        Err(e) => T::from(e.to_errno() as i16),
> +    }
> +}
> 

Reviewed-by: Martin Rodriguez Reboredo
