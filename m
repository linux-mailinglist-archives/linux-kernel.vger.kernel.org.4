Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B728D6DFD0C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 19:53:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230083AbjDLRxA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 13:53:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229839AbjDLRw6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 13:52:58 -0400
Received: from mail-qt1-x82a.google.com (mail-qt1-x82a.google.com [IPv6:2607:f8b0:4864:20::82a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97F976584
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:52:54 -0700 (PDT)
Received: by mail-qt1-x82a.google.com with SMTP id l16so645923qtv.1
        for <linux-kernel@vger.kernel.org>; Wed, 12 Apr 2023 10:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1681321973; x=1683913973;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=MGNHme4ev+oSAU07TVEQ5TqCiejkM5QtRdbf69iz9UY=;
        b=EVRLmJLP5hAOlm2KflV2OB71ZjUSrXaxHbFQJWGwlMQvMCJe1BGoI4Dbqcoj03rFwy
         cgvfIHfz+VIE4H0fFy9aolgLlRNOELhzB4fyMo3ssLXuYCm7QdosJVwqIHvNcUcvCiOe
         LpVNtE2ZOS3vB6xzUi+OSQhpmUPLdR+Im/vZBYxsXS0+ziea0mFYLqWSz/aKN0qyi6T8
         5i56tO6nbofeXlu8uGJ4s8kRvRXKTSL2KSEUD+WXiVTWNxza2v433HEMr0YhPKiU3l3q
         92EtzJ5KGVxpwCRrmbzNrZkjrKIT6GV0HYydYzeQtjijivY+DpJoUtGZj7iEDj2Wcxj2
         CFYw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1681321973; x=1683913973;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=MGNHme4ev+oSAU07TVEQ5TqCiejkM5QtRdbf69iz9UY=;
        b=c/4rJ9rI5bfFovHX1sElIvUbLBGyb8DVKTymabojYDPJn+ADE3PkXKwmrco5w4ehhR
         I6MMDV9Ks9ankhPjY+tKbBpdivfWWiwkwIW0nqL8KfvWqEXWp2raxirxEEiY4KjwgCDz
         sdXonmvGBCdl99rQgNrNMPdOTY+13y4xV+Yv9AtjouBSx8lRKnzuGCp4sR2cosAvV8V6
         0SRlnvKPH6bX0wsVFzI4byKTSWjyO1DMTGMySRBjxtzHTswW4WH/h13LDDzdy1rgNJ4u
         lLIVgbbVMyyvIjB+OBusLSV47nusljwuzSqmK1KAIF+YViE54KA5J67n7TzBPivoWk4J
         gLrw==
X-Gm-Message-State: AAQBX9dlW+qNbhnlyLKoSOu267gJL8T5jOel4eTQiS/W2Aejvbb4HMcG
        cuoN/8WbzFWOKHVwHaUAI8k=
X-Google-Smtp-Source: AKy350ZdKWs5qUa0FFC5cFUzm4WnwkOzv5Nf7PzGnN3q90ImT4QsBXXOyfjsyBq2CqbMTTx1Jik5uQ==
X-Received: by 2002:a05:622a:164d:b0:3c0:3b08:2d80 with SMTP id y13-20020a05622a164d00b003c03b082d80mr29626040qtj.63.1681321973362;
        Wed, 12 Apr 2023 10:52:53 -0700 (PDT)
Received: from [10.67.48.245] ([192.19.223.252])
        by smtp.googlemail.com with ESMTPSA id 206-20020a370ad7000000b0074589d41342sm4854403qkk.17.2023.04.12.10.52.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 12 Apr 2023 10:52:52 -0700 (PDT)
Message-ID: <9954a532-871a-e747-908f-bc5a3e32a55f@gmail.com>
Date:   Wed, 12 Apr 2023 10:52:50 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH] scripts/gdb: use mem instead of core_layout to get the
 module address
Content-Language: en-US
To:     Pankaj Raghav <p.raghav@samsung.com>, jan.kiszka@siemens.com,
        kbingham@kernel.org
Cc:     gost.dev@samsung.com, linux-kernel@vger.kernel.org,
        song@kernel.org, mcgrof@kernel.org
References: <20230412111508.892296-1-p.raghav@samsung.com>
 <CGME20230412112608eucas1p2e8aa819cf92ccc2bacfe0ff9bfcd7a6f@eucas1p2.samsung.com>
 <ffc82a81-c212-7990-53fb-2f95eb7af2ad@samsung.com>
From:   Florian Fainelli <f.fainelli@gmail.com>
In-Reply-To: <ffc82a81-c212-7990-53fb-2f95eb7af2ad@samsung.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/12/23 04:26, Pankaj Raghav wrote:
> On 2023-04-12 13:15, Pankaj Raghav wrote:
>> commit ac3b43283923 ("module: replace module_layout with module_memory")
>> changed the struct module data structure from module_layout to
>> module_memory. The core_layout member which is used while loading
>> modules are not available anymore leading to the following error while
>> running gdb:
>>
>> (gdb) lx-symbols
>> loading vmlinux
>> Python Exception <class 'gdb.error'>: There is no member named core_layout.
>> Error occurred in Python: There is no member named core_layout.
>>
>> Replace core_layout with its new counterpart mem[MOD_TEXT].
>>
>> Fixes: ac3b43283923 ("module: replace module_layout with module_memory")
>> Signed-off-by: Pankaj Raghav <p.raghav@samsung.com>
>> ---
> 
> I had one question:
> - Is there a way to import enum? I currently hard code 0 but it will better if we can
> use the MOD_TEXT enum instead.

You should be able to with updating constants.py.in and using LX_GDBPARSED()
-- 
Florian

