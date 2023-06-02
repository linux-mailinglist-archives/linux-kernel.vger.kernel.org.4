Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464BC720217
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 14:33:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234367AbjFBMdS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 08:33:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233609AbjFBMdQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 08:33:16 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0DA6F13D;
        Fri,  2 Jun 2023 05:33:16 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id d9443c01a7336-1b010338d82so10556245ad.0;
        Fri, 02 Jun 2023 05:33:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685709195; x=1688301195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=SbMziD+yODVijD+pmZlHL1+LyDW7UnKosThfDRRDpqI=;
        b=lnI9Myn4s53cPHi64DPoUhQQvE9BPIhpUG8CJDK5Qnj582pRJz78Nig/yIm9dG6hsK
         Z3Dl2fqm/oiLW3GwP9yClT71vM0lvQBbdFD/OwRd01xDjJLVD+g3wTB6W/67IOftFxOt
         A/qDlC9i9wzL/RG+ctBg5TVypbqzY+S7IM4cw8VGg/H+qaOjjCKIB3pTlRnIixoyQTYh
         zlS2caD6emOM14ERRaWbZSkp7V6KJfEwd1rxjYgbcU8duRlhbxCUm8M0ebX53WAW2QBv
         3t/FrwkcnQ90Hq2dzAg5IWQXioFX/mGq3yyg+6DLZEM88AEVGR2LTyd8sfOeyE7zz2hK
         ss3Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685709195; x=1688301195;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=SbMziD+yODVijD+pmZlHL1+LyDW7UnKosThfDRRDpqI=;
        b=PBUz/g/JognWFAc62nsdYY3tzX3HHw54X2eTwpg5vIoIupgMKOdMEi5qowxM23Lwi+
         mjdh6SGcpLqcCzqq/zo+aOLAhPj1ql70KBmSUeUKOOptG4ggekehrEgEV0OgjK4agBpq
         DhchP6Ebj53im5ix7z2OsMkwXckqZbaTSSFvpUO/PqBovjZIEFA+bXi+LXTllOsp/Iko
         ubAcRiegHoiY1DhypxZ3Hw8tgxg45A9C/UozFkGRkN5AVuQ9MnQmUyDf5dhV1lDcRQ9R
         NUIiq5up8fpqxGHMcNER1Mq3/H+BznIl075BTJWJuS9R8Yuela35p7PbZqpaVls7jaxz
         2elw==
X-Gm-Message-State: AC+VfDyrkx8RgSGH4UAwqOUU0SaK5UUk7fUyUnUMjeudjuQgOiIZ9O6+
        iau7EKfG5jNMCLEsE1Jmo5g=
X-Google-Smtp-Source: ACHHUZ6FfTlTWl7qTtPtQUKLnxk2CSa7+vYgTId2M3DW/LYkx6g5ZV/0CkRVeRWnpc9d5T3LmwCtvA==
X-Received: by 2002:a17:903:2291:b0:1b0:6541:91c2 with SMTP id b17-20020a170903229100b001b0654191c2mr1329274plh.63.1685709195419;
        Fri, 02 Jun 2023 05:33:15 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id l17-20020a170902f69100b001a96d295f15sm1228685plg.284.2023.06.02.05.33.13
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 02 Jun 2023 05:33:14 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <779687e0-7e21-77fb-8559-49e2100853ed@roeck-us.net>
Date:   Fri, 2 Jun 2023 05:33:12 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 5.15 00/37] 5.15.115-rc2 review
Content-Language: en-US
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     stable@vger.kernel.org, patches@lists.linux.dev,
        linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        akpm@linux-foundation.org, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, srw@sladewatkins.net, rwarsow@gmx.de
References: <20230601143331.405588582@linuxfoundation.org>
 <CADVatmPDwobeqntQ5+LQibMSHK86FmwUpN+E3JUd+GMs3bWpDQ@mail.gmail.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <CADVatmPDwobeqntQ5+LQibMSHK86FmwUpN+E3JUd+GMs3bWpDQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 6/2/23 05:07, Sudip Mukherjee wrote:
> Hi Greg,
> 
> On Thu, 1 Jun 2023 at 15:36, Greg Kroah-Hartman
> <gregkh@linuxfoundation.org> wrote:
>>
>> This is the start of the stable review cycle for the 5.15.115 release.
>> There are 37 patches in this series, all will be posted as a response
>> to this one.  If anyone has any issues with these being applied, please
>> let me know.
> 
> s390 allmodconfig build fails with the error:
> 
> arch/s390/kernel/uv.c: In function 'should_export_before_import':
> arch/s390/kernel/uv.c:204:40: error: 'mm_context_t' has no member
> named 'protected_count'
>    204 |         return atomic_read(&mm->context.protected_count) > 1;
>        |                                        ^
> arch/s390/kernel/uv.c:205:1: error: control reaches end of non-void
> function [-Werror=return-type]
>    205 | }
>        | ^
> 

Missing commit 07fbdf7f93479 ("KVM: s390: pv: usage counter
instead of flag"), but I don't know if that alone is sufficient
(there have been other commits adding to its use).

Guenter


