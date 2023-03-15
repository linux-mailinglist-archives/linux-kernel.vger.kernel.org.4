Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D73296BB605
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 15:30:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232113AbjCOOaJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 10:30:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232603AbjCOO3w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 10:29:52 -0400
Received: from mail-oi1-x235.google.com (mail-oi1-x235.google.com [IPv6:2607:f8b0:4864:20::235])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1321F5E4
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:29:49 -0700 (PDT)
Received: by mail-oi1-x235.google.com with SMTP id bj30so14287634oib.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 07:29:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678890589;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=lK5mtG7Se6CMuyUrk+xwL+zgzNMZyywMH6J7BDcKtmA=;
        b=p/6fSV8ZzPjrD4Nn8WbCJzEPjlN+4/OIp1RU0Mk6jU7Q7AkO7pHIgJFli9hQ771DCk
         SwfEVrh/4LDm+TZITMn+j3UgeNUOGqp4eoctIpdw3yyiDPE6cOqmukqwkRjHMnUYGJTr
         5a+fqIdhZZW7mNxwhmnX87ZHUxBelown1gYWUPzERA+62m41O6a50frpW0Ip7QBlnDjY
         ZLplLh52I1rLt3hKUCBXtu2iaJMVshi3D4UYm2W8poByxwl8QPoo9DSioK5fibPwfk95
         tZGjbK3ahxeWthwTERMQODjrgTdQJhgN1vtc1FzBuSXN95h8QxEYsQ0ewQBI5gUVDlcw
         piIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678890589;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=lK5mtG7Se6CMuyUrk+xwL+zgzNMZyywMH6J7BDcKtmA=;
        b=KcHDx2YCkFA7Htgxls54T0kDxWDesO331Q1C4EnQ1fDwyfwXiP/4nmbklxak9kqhds
         iXJqtJ2VbVn8Q/MAcLXwlxUilVDzyqYntAOMIurOPoe2XxtRuCmsATCXG25G1WhOnUWS
         Rtto7RYNsi9PF4J0efAV9Vvv3aMuhQv0ALaKl0avv9ThpX8TFvKhwRzF1ioOavd/wzSF
         gGZtGMMPwERgr5GYyX74QVEIbCHkJ0wTlEomd1F6FN0xjWOz8tLIO5SUbse9//tjQSda
         rRQRO6U/cIph0sV4pwGdR0kPWgrdaExeWmDT/BXR19wRDJEijW79rlPmSlzzdh3zJeD7
         fzZA==
X-Gm-Message-State: AO0yUKXTrlGLdKNy/iTlhBIIm8+gaZXpkentxqRHKvg2S8t4sqVpvFWt
        0nUnSmwmmiDsceBRUX0ZuSdhPQ==
X-Google-Smtp-Source: AK7set9Z6n7umTMtgZTwEADrUblIxjILzR4/JHuKsmnd14r9u3gMezSrHtKhb+kocVEo4zFOKVBqqw==
X-Received: by 2002:a05:6808:6083:b0:378:7905:62 with SMTP id de3-20020a056808608300b0037879050062mr1308384oib.8.1678890587319;
        Wed, 15 Mar 2023 07:29:47 -0700 (PDT)
Received: from [192.168.17.16] ([189.219.75.19])
        by smtp.gmail.com with ESMTPSA id s78-20020acaa951000000b00386929bbe6asm1963875oie.45.2023.03.15.07.29.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 07:29:46 -0700 (PDT)
Message-ID: <6ed70071-96a3-4f79-17e4-c94f3ef868e2@linaro.org>
Date:   Wed, 15 Mar 2023 08:29:45 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5.15 000/145] 5.15.103-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
References: <20230315115738.951067403@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20230315115738.951067403@linuxfoundation.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 15/03/23 06:11, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.15.103 release.
> There are 145 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Mar 2023 11:57:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.15.103-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.15.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

We're seeing PowerPC build failures like the following (GCC-8, GCC-12, Clang-16):

-----8<-----
In file included from /builds/linux/drivers/usb/host/ehci-hcd.c:1298:
/builds/linux/drivers/usb/host/ehci-ppc-of.c:122:13: error: use of undeclared identifier 'NO_IRQ'
         if (irq == NO_IRQ) {
                    ^
1 error generated.
----->8-----

Then, Perf fails on Arm and i386 with GCC-12:

-----8<-----
In function 'parse_events_term__num',
     inlined from 'parse_events_multi_pmu_add' at util/parse-events.c:1687:9:
util/parse-events.c:3100:64: error: array subscript 'YYLTYPE[0]' is partly outside array bounds of 'char[4]' [-Werror=array-bounds]
  3100 |                 .err_term  = loc_term ? loc_term->first_column : 0,
       |                              ~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~^~~
util/parse-events.c: In function 'parse_events_multi_pmu_add':
util/parse-events.c:1678:39: note: object 'config' of size 4
  1678 |                                 char *config;
       |                                       ^~~~~~
cc1: all warnings being treated as errors
----->8-----

Greetings!

Daniel Díaz
daniel.diaz@linaro.org

