Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D9AA26113E5
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 16:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231231AbiJ1OEK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 10:04:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiJ1OEI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 10:04:08 -0400
Received: from mail-pj1-x1033.google.com (mail-pj1-x1033.google.com [IPv6:2607:f8b0:4864:20::1033])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0086B1DEC1B;
        Fri, 28 Oct 2022 07:04:07 -0700 (PDT)
Received: by mail-pj1-x1033.google.com with SMTP id b11so4783394pjp.2;
        Fri, 28 Oct 2022 07:04:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=o1QkAhlKr5y3Yemv84a0WENoZI0iQ9cHsX5Tp/FV6B8=;
        b=EXftrL6jQFzF0sxNA70BdMwTF3A8Qh650r36dic5x9N30A+WrSN+lKkncvIzFNnXQ2
         Gt+hdA1/wsTu1tompguNjBSrcYt3Db1INEujJj7MFsZRH+ePkGfdx1mHo1HRnbbQWNBU
         knWUYIEXnwOlOGfFWqyeEdvp8/kd+9OUcFx9hf7rYu7ggIrIj52YPIJM/JYd1rh9dnnn
         vPzTlOJ9bQ3OlBwkKrWr5MZt3xET8wfvGvO0JptJlclvbnH1On/jrAqWyKjN+zMNNuJj
         mVw4STKzDnquKc5Fqta+JE1aEiDbH4NlnUKlae8P2f5d/HTXp7zLyp0fC8UeyCIAaEbS
         o1ZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=o1QkAhlKr5y3Yemv84a0WENoZI0iQ9cHsX5Tp/FV6B8=;
        b=pKJpN9OW4wnRTzuY4svPXuSiAm4sXduQr8BTUiXTzO+N8Gwil5dmqfSNb5ipbKJ47W
         wFhgCQyohrHvywTFRluVmGstnbLI5+eoXvMu0Xh+53tYxublmA9wcdrcBTMZS4AUiD/+
         PfZQ7STNuiOmSAp75noEjbnLcEFCmfDmyJFG1Q1GvCsLxM6hcvKCYKlICf7SlcOfM9OQ
         OGp5XmgtB3PP7HPxenew8iRr8O3zmI2bcNkqaTmgPTzonDWCueisIRt064+XX0Tgwor1
         H8md7gzkk/UAj2aaIMUgahQu2KHqnxDgd3QMcf8slBSOIQa9XnLU54r0rMFg0JoobWiZ
         kXXA==
X-Gm-Message-State: ACrzQf2bUEMmRGxpKn2SAhfUVm+t7xuVoN9h/GzhZXe9ncYm0anrWX+3
        qtNU/WsT/VPHiN5u3+3MlTw=
X-Google-Smtp-Source: AMsMyM5Bdu55a+pqkKJZBBQ1bL85SEwmUnbaJNJya+QsyYzpf2RxaaFGM5Ml577NXVyPVftPP7SA0A==
X-Received: by 2002:a17:903:2442:b0:186:ef89:7b41 with SMTP id l2-20020a170903244200b00186ef897b41mr7574440pls.164.1666965847480;
        Fri, 28 Oct 2022 07:04:07 -0700 (PDT)
Received: from [192.168.43.80] (subs03-180-214-233-72.three.co.id. [180.214.233.72])
        by smtp.gmail.com with ESMTPSA id k12-20020a170902c40c00b001822121c45asm3209062plk.28.2022.10.28.07.04.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Oct 2022 07:04:07 -0700 (PDT)
Message-ID: <3f4ca307-c995-e105-7190-5fff51dfe742@gmail.com>
Date:   Fri, 28 Oct 2022 21:04:01 +0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.0
Subject: Re: [PATCH 15/15] Documentation: bury magic-number, now devoid of
 content
Content-Language: en-US
To:     =?UTF-8?B?0L3QsNCx?= <nabijaczleweli@nabijaczleweli.xyz>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        Alex Shi <alexs@kernel.org>,
        Yanteng Si <siyanteng@loongson.cn>,
        Hu Haowen <src.res@email.cn>,
        Steven Rostedt <rostedt@goodmis.org>,
        Kees Cook <keescook@chromium.org>,
        Stefano Zacchiroli <zack@upsilon.cc>,
        Thorsten Leemhuis <linux@leemhuis.info>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Wu XiangCheng <bobwxc@email.cn>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        linux-doc-tw-discuss@lists.sourceforge.net
References: <9a453437b5c3b4b1887c1bd84455b0cc3d1c40b2.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
 <83bd024a7f81492be259a531c407cb017186d745.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
From:   Bagas Sanjaya <bagasdotme@gmail.com>
In-Reply-To: <83bd024a7f81492be259a531c407cb017186d745.1666822928.git.nabijaczleweli@nabijaczleweli.xyz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-0.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_SORBS_WEB,SPF_HELO_NONE,SPF_PASS
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/27/22 05:43, наб wrote:
> The list is now empty, and we've largely moved away from this approach,
> and we have better debugging instrumentation nowadays
> 

The patch subject should be "Documentation: remove magic number
documentation".

Better say for the description "Now that all magic numbers have
been removed, remove the documentation".

Thanks.

-- 
An old man doll... just what I always wanted! - Clara

