Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C858367D4C3
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 19:56:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232270AbjAZS4C (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 13:56:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbjAZS4A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 13:56:00 -0500
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 869CD17171
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:55:58 -0800 (PST)
Received: by mail-wm1-x336.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so1788565wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 10:55:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=D+w4fUPxxTWG9QVf0Szc5onsRht7eW5JaAqsaiPyRug=;
        b=L/uivq+tdPFFW1hoGKz5ZioC+sc5BHZeNJQyWmXz2DBqTyKD2Q1AcQoR76HoHUVi+v
         xtdLjgv1DHha1es2x1WpctTUGh3TTTMzsz1QkLuIFNbjg9d1DEHo48YjcG93hHjJgW4f
         kAfURwYkcAMV5dg4nV8GsPSyhbNAgGJc8fln/Ev6B1hqoKqQ/gyvR6U3Spj20luSgqnP
         rLuqKCnADyWqYshGLbZTCSsjkRmreuY+Py8yI81Fjute4L3mkd7DM/a4j56ge9jvcF7R
         FkOA4UozdQDv09h7vTYwH2A6PEAqSzTjrBg2kZJv6TQ9yUiB8IsjFqhPXM4TyH+lK7ma
         yLUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=D+w4fUPxxTWG9QVf0Szc5onsRht7eW5JaAqsaiPyRug=;
        b=G1iWwW2IQgLjayRF047NnepIzYHRaJxEauF3t6mfbHCsMqKhFJsKrrjPdoR/EIakDl
         BubaM5NezyHQabYEmLWrcuEVdzHekJhkGhKsAdKYrSwxjs8vHPoR5dl4ahoUlI4h+LZI
         C65IrZtyuQ1+WIm2np3IepdItwFG4UR07kkBHhgHDY8gfdK5LCFuvPHJFn3SEqb8FSqD
         v04HJ8EDPBRCa2PH8xC8eRwZz2borbh6KMLUny8nZLWYpKIi7xjEUu6zsVvHqiR0F2iN
         5vkD9vbXmyJfXjfps/f8kEF7vHxdaowm3XZyLCexhUbEtlbqKOf46kb6UdRYw6qf8WXn
         1VqQ==
X-Gm-Message-State: AFqh2kqBZkpjoKs7np2XYdSyqYNifq8iuM/bocYln2aq4mwiyjUbZvDz
        Xpvoe6z6Psnk6VAtPRGrvHKNxw==
X-Google-Smtp-Source: AMrXdXtbnsIhuR8Zrr1d52g1fP2d5fESGfLVq9iPJpgV09BxMz+l3t8u/dR770it//1aXz9wlQTMrw==
X-Received: by 2002:a05:600c:1e23:b0:3d9:103d:9081 with SMTP id ay35-20020a05600c1e2300b003d9103d9081mr34028920wmb.28.1674759357150;
        Thu, 26 Jan 2023 10:55:57 -0800 (PST)
Received: from [192.168.0.114] ([196.77.8.13])
        by smtp.gmail.com with ESMTPSA id ip15-20020a05600ca68f00b003dc0d5b4f75sm2106584wmb.43.2023.01.26.10.55.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 10:55:56 -0800 (PST)
Message-ID: <5338465a-430a-bcc3-016c-7528499d96ab@linaro.org>
Date:   Thu, 26 Jan 2023 19:55:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:102.0)
 Gecko/20100101 Thunderbird/102.6.1
Subject: Re: [PATCH] MIPS: remove CONFIG_MIPS_LD_CAN_LINK_VDSO
Content-Language: en-US
To:     Masahiro Yamada <masahiroy@kernel.org>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Nathan Chancellor <nathan@kernel.org>
References: <20230120063351.433502-1-masahiroy@kernel.org>
From:   =?UTF-8?Q?Philippe_Mathieu-Daud=c3=a9?= <philmd@linaro.org>
In-Reply-To: <20230120063351.433502-1-masahiroy@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/1/23 07:33, Masahiro Yamada wrote:
> Given commit e4412739472b ("Documentation: raise minimum supported
> version of binutils to 2.25"), CONFIG_MIPS_LD_CAN_LINK_VDSO is always
> 'y'.
> 
> Signed-off-by: Masahiro Yamada <masahiroy@kernel.org>
> ---
> 
>   arch/mips/vdso/Kconfig  | 14 +-------------
>   arch/mips/vdso/Makefile |  3 ---
>   2 files changed, 1 insertion(+), 16 deletions(-)

Reviewed-by: Philippe Mathieu-Daudé <philmd@linaro.org>

