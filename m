Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3A36B6FD8B1
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 09:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236461AbjEJHz0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 03:55:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236431AbjEJHzX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 03:55:23 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D2ACDE
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:55:22 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id a640c23a62f3a-94f9cd65b1aso174972166b.0
        for <linux-kernel@vger.kernel.org>; Wed, 10 May 2023 00:55:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683705321; x=1686297321;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=GIJKyRBEjdyUl/MVV9x2JqKCqHZQzxhquAJ+JI/f5XA=;
        b=a3T9bDodW1/k5HN5DT6PH4X9lv2Dbf5kR59lnt3ABrgC+Kle9jBuRgvo8pYQuSXECQ
         npw2L4nGfhgTq/XJKcDxDMFFwxE6PmiTf4k34cjdmZgiYC8ola/kc4pTRb8NuxGYht58
         qSclKzvYvMKJ8da54yy5Jhn3LL0ITzet4+nykowvYW6vW0OtqD/KbezsfgO/zlonoIGn
         HjQpf3m2oHdydnewz5Ofg3xmhwForC/o69EppfOEMvMRoZqaa91REZHoBVV6eNiZEXA9
         DX1OWn9Lpc7fKvsMPh7dG4M8CTWtv16zMcTBYN3ssm2XxJQAxD3qHwmiO4zvLB/iK01X
         KMIA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683705321; x=1686297321;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=GIJKyRBEjdyUl/MVV9x2JqKCqHZQzxhquAJ+JI/f5XA=;
        b=kRFGETQOJ1PP1k1Rdj6X/eO4lPesHsmD+9d1x1ppVPaqPu6eTzt8imeEnStBtCoHdg
         FaZyOj8t5dSR+A2m2oJ0eJeatG6mGkWQP3T7H19yBegRjY7PItnfhKqnNmVVm4crYN1H
         N21gl6bSK3uZE5T9ZbRne2RX53hwHJw6F9Atki7LBh4ytobaZI9DBhWoGD2N+NCBeZr4
         X0LZixB2nPkAvYC0HPfsOvSobKdLo6NYJCnIM5oYy0gRnHUezLF1BWLXMUk8/8lzd0N2
         Z0dfq1Z6azCAsEX1Y6qvhXJtHL1rudOeeNZs9WcZLZHfVVxOm2s69rzjnPaApBpX6kTy
         70qw==
X-Gm-Message-State: AC+VfDz/KF3jNvmURnMAOKwisRM8aEvFglZT87u0ky5mWxJtLIYtT4RL
        LHOCXAqjqhFUnNTSOo7PbYg=
X-Google-Smtp-Source: ACHHUZ4Etamrv/XEITbdotEx2ui0eic7/8Gzjz6mioeFp38Zuvsrbto00bt1j4JEIfAzxCT4KgGXCQ==
X-Received: by 2002:a17:906:7794:b0:965:9db5:3823 with SMTP id s20-20020a170906779400b009659db53823mr13650720ejm.3.1683705320717;
        Wed, 10 May 2023 00:55:20 -0700 (PDT)
Received: from [192.168.10.10] ([37.252.94.55])
        by smtp.gmail.com with ESMTPSA id tk13-20020a170907c28d00b0094f185d82dcsm2313239ejc.21.2023.05.10.00.55.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 10 May 2023 00:55:20 -0700 (PDT)
Message-ID: <f1a912ea-884b-fdcd-1c05-87089f1e97b7@gmail.com>
Date:   Wed, 10 May 2023 11:55:18 +0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH] ALSA: PCM: Fix codestyle issues in pcm_native.c
Content-Language: en-US
To:     ivan.orlov0322@gmail.com
Cc:     perex@perex.cz, tiwai@suse.com, oswald.buddenhagen@gmx.de,
        axboe@kernel.dk, 42.hyeyoo@gmail.com, surenb@google.com,
        alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-kernel-mentees@lists.linuxfoundation.org
References: <20230510072726.435247-1-ivan.orlov0322@gmail.com>
 <2023051052-recoil-headache-1594@gregkh>
From:   Ivan Orlov <ivan.orlov0322@gmail.com>
In-Reply-To: <2023051052-recoil-headache-1594@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/10/23 11:48, Greg KH wrote:
> - Your patch did many different things all at once, making it difficult
>    to review.  All Linux kernel patches need to only do one thing at a
>    time.  If you need to do multiple things (such as clean up all coding
>    style issues in a file/driver), do it in a sequence of patches, each
>    one doing only one thing.  This will make it easier to review the
>    patches to ensure that they are correct, and to help alleviate any
>    merge issues that larger patches can cause.
> 
> If you wish to discuss this problem further, or you have questions about
> how to resolve this issue, please feel free to respond to this email and
> Greg will reply once he has dug out from the pending patches received
> from other developers.
> 
> thanks,
> 
> greg k-h's patch email bot

Greg's Bot is right, it will be better as a sequence of patches. Sorry 
for bothering!

Kind regards,
Ivan Orlov.
