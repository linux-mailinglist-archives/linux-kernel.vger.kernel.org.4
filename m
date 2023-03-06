Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D75CD6ACF80
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Mar 2023 21:49:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229707AbjCFUtr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Mar 2023 15:49:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229493AbjCFUto (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Mar 2023 15:49:44 -0500
Received: from mail-ed1-x529.google.com (mail-ed1-x529.google.com [IPv6:2a00:1450:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7518D5580
        for <linux-kernel@vger.kernel.org>; Mon,  6 Mar 2023 12:49:43 -0800 (PST)
Received: by mail-ed1-x529.google.com with SMTP id k10so20201139edk.13
        for <linux-kernel@vger.kernel.org>; Mon, 06 Mar 2023 12:49:43 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1678135782;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=AR0RTzTpEWtFuffV0SrWkUkG0y4zet3XlibWdln0yDA=;
        b=HyfuVj6L8naGrI6ho4c5ZRMQCed3OnQv5JMirJm4TP6adfvJ5CacJ8uP3i065Sg9qY
         PFKBC008+ibnRGLq+jubs++BW7k08UBU56JgFvBo5bQwZ0vamL4gIAUnLo0HinHB8n/Z
         3bAyLQX7FdVoTqaQ1Js7hRknztAQz7m1ggzPfVmm7/3CaRE0y6XDPgf1qNSIM0UOz+lC
         nnjPYaatPkP5aPpz0c/lc6c2BAfolN6kyYityKiy+1/3wEiVVl1l86bQf7F2eZO/jhRI
         jYEQlwBS4BO+CZ9d358L/uti7qjP/yXIntySLtC4LF+n8ZqJxWfouNYqGd/gWvv0BKpu
         Q8zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678135782;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=AR0RTzTpEWtFuffV0SrWkUkG0y4zet3XlibWdln0yDA=;
        b=efUxlhbTrXyg2RkmZeim/vsoepD6/s9yretd1A1GEmPhocAHt1X0QxEj2zxAXTNyrS
         F5dKGt7KLL3wFBAnVSlbxZ9cjkdN/Eecq+4Eu90lyAaXfTPzn+6Az/EiSjRkwjfewX6A
         isilai8oegQEcih7TZ4rbX+ux4mXOhfTIlLj8UE4y6nJAXvpITSB9FGA0a+bSzwJmKu9
         nrbGr2J/9UoCttMu+2IRRSGVSqPVL5HKZhbuZZ/53miCJcuvyjXE+MkqJSpb7OwENvR8
         RhEUXnK8YcrT4KC2p/vxN6m+TQfbdibaO1fvZblm4LFJoqz+wGINBKNW8fquAZR5z3n2
         xYfg==
X-Gm-Message-State: AO0yUKWlrq5AXmOr9GRS/Y32RxPNLJXFqXKHGwIYgo5ZB+BT+LoioEVl
        4+HzM/+xjzi5fvSfaC21HiI=
X-Google-Smtp-Source: AK7set8snMKr45wof1XT1a17My+cz3Dv9cvJjNSYPmq/VL6nrLC/pOMGA7RVeMoqjp+lCogVoglEnw==
X-Received: by 2002:a05:6402:274d:b0:4af:7bdc:18a5 with SMTP id z13-20020a056402274d00b004af7bdc18a5mr15401464edd.0.1678135781702;
        Mon, 06 Mar 2023 12:49:41 -0800 (PST)
Received: from [192.168.0.102] (p57935146.dip0.t-ipconnect.de. [87.147.81.70])
        by smtp.gmail.com with ESMTPSA id f14-20020a1709067f8e00b008c16025b318sm4992566ejr.155.2023.03.06.12.49.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Mar 2023 12:49:41 -0800 (PST)
Message-ID: <a8416a2b-fa76-ed07-1364-9cea32bf14f3@gmail.com>
Date:   Mon, 6 Mar 2023 21:49:40 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 1/2] staging: rtl8192e: Remove empty Array
 Rtl8192PciEPHY_REGArray
Content-Language: en-US
To:     Dan Carpenter <error27@gmail.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-staging@lists.linux.dev, linux-kernel@vger.kernel.org
References: <cover.1677955334.git.philipp.g.hortmann@gmail.com>
 <511bd239bf033dca3efcc64a640d5343c98fa897.1677955334.git.philipp.g.hortmann@gmail.com>
 <7d3eaf69-8ddb-4b63-ae8c-89b6a34e9493@kili.mountain>
From:   Philipp Hortmann <philipp.g.hortmann@gmail.com>
In-Reply-To: <7d3eaf69-8ddb-4b63-ae8c-89b6a34e9493@kili.mountain>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/6/23 10:25, Dan Carpenter wrote:
> On Sat, Mar 04, 2023 at 08:13:22PM +0100, Philipp Hortmann wrote:
>> Remove empty array Rtl8192PciEPHY_REGArray and the code where it is used
>> because it is dead code.
>>
>> Signed-off-by: Philipp Hortmann <philipp.g.hortmann@gmail.com>
>> ---
>>   drivers/staging/rtl8192e/rtl8192e/r8192E_phy.c | 5 +----
>>   drivers/staging/rtl8192e/rtl8192e/r8192E_phy.h | 2 --
>>   drivers/staging/rtl8192e/rtl8192e/table.c      | 2 --
>>   drivers/staging/rtl8192e/rtl8192e/table.h      | 2 --
> 
> What are these table.[ch] files?  I don't seem to have them.
> 
> regards,
> dan carpenter
> 


Hi Dan,

thanks for the review. Here some answers to your questions:

With patch: "[PATCH] staging: rtl8192e: Change filename r8192E_hwimg.x 
to table.x" I changed the filename of r8192E_hwimg.c to table.c and 
r8192E_hwimg.h to table.h to adapt filenames from 
drivers/net/wireless/realtek/rtlwifi rtl8192ee and rtl8192se. Task is 
from TODO file.

Thanks for your support.

Bye Philipp
