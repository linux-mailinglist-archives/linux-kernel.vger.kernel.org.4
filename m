Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7150F72CB32
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 18:14:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234772AbjFLQOA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 12:14:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234585AbjFLQNm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 12:13:42 -0400
Received: from mail-ot1-x333.google.com (mail-ot1-x333.google.com [IPv6:2607:f8b0:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB8732108;
        Mon, 12 Jun 2023 09:13:26 -0700 (PDT)
Received: by mail-ot1-x333.google.com with SMTP id 46e09a7af769-6b2b7ca1c5eso2912714a34.0;
        Mon, 12 Jun 2023 09:13:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686586406; x=1689178406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=xT+8NLEGzyzl+xXCJr5EVpOiH3QRwvba1OJtzK594kI=;
        b=iVikyQ4ZrnCh5+QLc3Sfp/D/sf7kLl/NG0CPEYh4Nm6pipiQBAQfQgqwNO3tVq6rVM
         zUV5BJMFkbOHyW3CfJJ0DFWDT/6di3Leha+nvhJGBVrrZHKOz/lLjhgJEeJ7Ajg0z/Hq
         lFXF7S1KW3t4KomGDDSdPplQHzwApe2Ng8kdw1Wn/bLTz1ysdTN0T5+Wdm7m1Bo9DN0O
         4ssu48lxeqUyUqNDX7385KJq+GpMaXGpBYE+Wv8yNq8LDCrSnWXnq8b9x4ORAssLuE4V
         3I8ssuHbkUnRq05Uwtli1nO+KdclcilVuoa8i1Fdejq74tQW+/Wpl1bB5pu3wNBtWTCw
         iJ+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686586406; x=1689178406;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=xT+8NLEGzyzl+xXCJr5EVpOiH3QRwvba1OJtzK594kI=;
        b=SEDNGpSFV+3TpxafOOIYx3ue/xIpPtejiTorSq6aWcUF1wv3uYmXp6R6hifLUm+oiA
         4EwwBx3AyNPoB4JumaDpRsbm5f6BZngqxh7DB2pNVfRjNFUbdeI5lAp0H3CdcqLK4fMb
         YncemdivZL5LoYIkl2uXaVmp3SEC3ugqsgjsZ/HWzzqmXmgTwK91viTUweD76m/Ia1WJ
         zBHBzCxal1xL691nW2iYlO6/rJQw/Ri2yO+Vzv1jnQbou7ALH+DTSGILRpOTw4nm2ZvV
         Szz+hWWVXk1/S1PCR9o7AgNgwgcY7MsRuVt43ZrThzG9PDLeS1rqekIGfiIfH4RQcWp8
         gyjg==
X-Gm-Message-State: AC+VfDwlLIlrOh28MF3n8OXHdhOhwJnyhqun6f7X8DEgs9G9LynDY6Cw
        8GNgleLi0CKNLKkNWUZbuqo=
X-Google-Smtp-Source: ACHHUZ4626NO/0JccShDWWMTVyJaq7sZ+f8plBCXtfLF3nzGesdT386Jnj2NbwYBM36f/QtVgLMbhQ==
X-Received: by 2002:a05:6870:4c3:b0:177:dfdb:63 with SMTP id u3-20020a05687004c300b00177dfdb0063mr6390948oam.44.1686586406210;
        Mon, 12 Jun 2023 09:13:26 -0700 (PDT)
Received: from [192.168.54.90] (static.220.238.itcsa.net. [190.15.220.238])
        by smtp.gmail.com with ESMTPSA id l2-20020a056870f14200b0019e8deb387bsm6041572oac.53.2023.06.12.09.13.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 12 Jun 2023 09:13:25 -0700 (PDT)
Message-ID: <3fff0908-5e77-812f-2037-1a65f6f8cc26@gmail.com>
Date:   Mon, 12 Jun 2023 12:08:21 -0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/3] rust: kernel: add ScatterList abstraction
Content-Language: en-US
To:     Qingsong Chen <changxian.cqs@antgroup.com>,
        linux-kernel@vger.kernel.org
Cc:     =?UTF-8?B?55Sw5rSq5Lqu?= <tate.thl@antgroup.com>,
        Miguel Ojeda <ojeda@kernel.org>,
        Alex Gaynor <alex.gaynor@gmail.com>,
        Wedson Almeida Filho <wedsonaf@gmail.com>,
        Boqun Feng <boqun.feng@gmail.com>, Gary Guo <gary@garyguo.net>,
        =?UTF-8?Q?Bj=c3=b6rn_Roy_Baron?= <bjorn3_gh@protonmail.com>,
        Benno Lossin <benno.lossin@proton.me>,
        Alice Ryhl <aliceryhl@google.com>,
        Asahi Lina <lina@asahilina.net>,
        Niklas Mohrin <dev@niklasmohrin.de>,
        rust-for-linux@vger.kernel.org
References: <20230610104909.3202958-1-changxian.cqs@antgroup.com>
 <20230610104909.3202958-2-changxian.cqs@antgroup.com>
From:   Martin Rodriguez Reboredo <yakoyoku@gmail.com>
In-Reply-To: <20230610104909.3202958-2-changxian.cqs@antgroup.com>
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

On 6/10/23 07:49, Qingsong Chen wrote:
> Add a wrapper for `struct scatterlist`.
> 
> Signed-off-by: Qingsong Chen <changxian.cqs@antgroup.com>
> ---
> [...]

Reviewed-by: Martin Rodriguez Reboredo <yakoyoku@gmail.com>
