Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D0B76DCC89
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Apr 2023 23:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjDJVEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Apr 2023 17:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbjDJVEf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Apr 2023 17:04:35 -0400
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B34DD10F6;
        Mon, 10 Apr 2023 14:04:34 -0700 (PDT)
Received: by mail-lf1-x12c.google.com with SMTP id a23so8424236lfk.4;
        Mon, 10 Apr 2023 14:04:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1681160673;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ko7QXPbIjeGGHDhMu4npXiL/4qFqfqYW7bib84R6aNU=;
        b=lpvPFtUOP3XhFCJ7Xk611x6D8hZ+kTQRj1OcX61VyNYNxN/okXXr2n0MjOXIdaRTEX
         82X3Em+8AMDFbbbRUwRG8a7Xc8Lx6ZScGdRX6NOVgo6/cH1f86RKS1JERLXxS1ee5XPA
         l0dbCOfG1OLPRgdNiWF/yFY+6oreawyFJAJXcKKVAVFo7+RtnECs3NkVfComi6WdiG/E
         PHbInMiKfIX1fVzaco+up5yfev/cckrlYksisO9zJeMW2s46ujRMdGzrULItwIOWAlGv
         FFwrQLY6qXbV7HTnuOXTLPO5fGmROzrgTQDGxMwKcvu4vXJRa3VB2WCbx8Y2YF4vFlGP
         OE+g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1681160673;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ko7QXPbIjeGGHDhMu4npXiL/4qFqfqYW7bib84R6aNU=;
        b=d0EHNhGhcbZCeo/EGesQwlkvp+Cm6tZxh6KxiW6axfmBPwxjutSNSAFxmq4aHj/YH7
         AaIRHascIY5EAXpW6f4K2gaGckw9qiC9pXs6b8X4xRHU1o4ZA9G01eVENL5zMxARXEBi
         t0gMX0lCtw87jlUdgOn0ADz4Z+ZstAb9DjaS3NAktVw//pS/9IKJRHsDvPeOD34O+tNM
         J1spThnY5lqrkSuqe4sE5KYCztK9f1gJjh3Zx1UqYCoYvfPbUFCazInC4wm9r7S5EyUi
         WvRn54ko7V4xkrVfUu763Y5CY4oVll6ZI1Rs90PICfhf8Kbv1lDykZfHhlmFF669CSb2
         eKXQ==
X-Gm-Message-State: AAQBX9dAAufEjkgMGKD0aOil/2xx6VT/WvI8V1N7+yLOXLJtA0lp14UK
        dE7fTUwNfP+3E1zo88AvckqkT9WqHTY=
X-Google-Smtp-Source: AKy350aaXf7tXMoq/bDIX5RcTUjwlvNj4/ZV58esCJnG/KA/wgu03yQ50TGQoFVlOrSEBxSV3L5hJg==
X-Received: by 2002:ac2:5929:0:b0:4dc:828f:ef97 with SMTP id v9-20020ac25929000000b004dc828fef97mr3028369lfi.60.1681160672813;
        Mon, 10 Apr 2023 14:04:32 -0700 (PDT)
Received: from [192.168.1.13] (81-197-197-13.elisa-laajakaista.fi. [81.197.197.13])
        by smtp.gmail.com with ESMTPSA id j25-20020a19f519000000b004d093d60f50sm2233167lfb.215.2023.04.10.14.04.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Apr 2023 14:04:32 -0700 (PDT)
Message-ID: <52301293-0e21-2885-904b-776b82d5a18d@gmail.com>
Date:   Tue, 11 Apr 2023 00:04:31 +0300
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Per-process flag set via prctl() to deny module loading?
Content-Language: en-US
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-modules <linux-modules@vger.kernel.org>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        "linux-hardening@vger.kernel.org" <linux-hardening@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <640c4327-0b40-f964-0b5b-c978683ac9ba@gmail.com>
 <2023041010-vacation-scribble-ba46@gregkh>
From:   Topi Miettinen <toiwoton@gmail.com>
In-Reply-To: <2023041010-vacation-scribble-ba46@gregkh>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10.4.2023 21.37, Greg KH wrote:
> On Mon, Apr 10, 2023 at 01:06:00PM +0300, Topi Miettinen wrote:
>> I'd propose to add a per-process flag to irrevocably deny any loading of
>> kernel modules for the process and its children. The flag could be set (but
>> not unset) via prctl() and for unprivileged processes, only when
>> NoNewPrivileges is also set. This would be similar to CAP_SYS_MODULE, but
>> unlike capabilities, there would be no issues with namespaces since the flag
>> isn't namespaced.
>>
>> The implementation should be very simple.
> 
> Patches are always welcome to be reviewed.
> 
> But note, please watch out for processes that cause devices to be found,
> and then modules to be loaded that way, it's not going to be as simple
> as you might have imagined...

A very simple version would only add a simple check like 
!current->allow_module_load after every !capable(CAP_SYS_MODULE). It 
wouldn't block all the ways how modules could be caused to be loaded 
indirectly.

I think a less simple version could also do the check at __request_module().

-Topi

