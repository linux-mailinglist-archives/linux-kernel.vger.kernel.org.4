Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1805D6CEC28
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 16:52:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230160AbjC2OwM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 10:52:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230243AbjC2OwK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 10:52:10 -0400
Received: from mail-oa1-x35.google.com (mail-oa1-x35.google.com [IPv6:2001:4860:4864:20::35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BDF001BE1;
        Wed, 29 Mar 2023 07:52:07 -0700 (PDT)
Received: by mail-oa1-x35.google.com with SMTP id 586e51a60fabf-17ac5ee3f9cso16447354fac.12;
        Wed, 29 Mar 2023 07:52:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1680101527;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=3nZRYMXkXMuH4jLnE9DwtMk8EvGIG54ns0arYzcO6DM=;
        b=WQGD7VE2RLizutWV8oj2BEh7aeup2PtzJ9z7+As2c3K22fLI66OxNEWdHt4wyIFRYV
         7Pm6QEAEH21ObvA019rq5fgYLr+ZpTX/dbTwkWZe1Br7ot64819ByuGPFgxgwdM/QZd1
         D2VJcD07q41GZl62Cj1gU64P5IW2DZX13gm4++8y/dRzGPwhcRV8/AFIxXcZ7XK4Q5KR
         1sOEpnoi9SG98Ja6ydM1IP9kUUZven2rBTehUwrqjvTnE9+m+UbO9jg/V6/V5hFF49Uw
         +T8Q07oKBIF/tV0flCSxaMIbJWXv+nxZGXWxEkPa1vUOReDhPj6oaQll7cQH3/7OfJ/z
         Eh3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1680101527;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=3nZRYMXkXMuH4jLnE9DwtMk8EvGIG54ns0arYzcO6DM=;
        b=12RxlOuIeEz5HENg4JdhjbcgW+mrp8UhSFzsJJwryVm5js8ihwNFhL2r56/p+Nav/5
         INV2fcB0Z48xMr326CVjNnkd0UykTBjxMGGjj7cUrsQAtr2jHz92SjY7bE7RF2VoqESd
         Gt8KtSObO52+4bVLfrpVGllztemSd6ytrMniaIPFaPMMhry8Z1gNVbtMG8Nwe7YhMgCc
         q2NhYXQI0oxdtTSztQwScJOdex3DfWhCdck76K4Y0UGij97w6DHV7yJoN0lSTbb3dJBG
         RsYRN4PjYD4hfPiyCtVYJUQSQ5n+J+QHrFsg+6AAOZfNRxvQETvDxc+mgbH9FWrGRw35
         O/mQ==
X-Gm-Message-State: AAQBX9f8xgbwrNCO8y+kfS+6RH5qgvCRA27Zj81hPHLuOIIwOdSf2ne9
        jlbYCcU5Rtrs8MBCMxJ/DhE=
X-Google-Smtp-Source: AKy350az8V8n53MAaV6Ss+bLCfROdWnTd1OvypXw9n+hjQh6aj7aqpHlTBRfEaBBeVbyyKqk8QEPeQ==
X-Received: by 2002:a05:6870:9591:b0:177:b0ee:b034 with SMTP id k17-20020a056870959100b00177b0eeb034mr11073610oao.43.1680101527152;
        Wed, 29 Mar 2023 07:52:07 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id a20-20020a9d74d4000000b006a11998d20esm5940720otl.45.2023.03.29.07.52.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Mar 2023 07:52:06 -0700 (PDT)
Message-ID: <5c8c004e-f04f-febc-783e-13cbb8129688@gmail.com>
Date:   Wed, 29 Mar 2023 11:52:03 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH v2 4/6] rust: error: Add to_result() helper
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
 <20230224-rust-error-v2-4-3900319812da@asahilina.net>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230224-rust-error-v2-4-3900319812da@asahilina.net>
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
> +/// Converts an integer as returned by a C kernel function to an error if it's negative, and
> +/// `Ok(())` otherwise.
> +pub fn to_result(err: core::ffi::c_int) -> Result {
> +    if err < 0 {
> +        Err(Error::from_errno(err))
> +    } else {
> +        Ok(())
> +    }
> +}
> 

Reviewed-by: Martin Rodriguez Reboredo
