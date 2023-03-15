Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D1E76BC0BA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Mar 2023 00:17:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232464AbjCOXRa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 19:17:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53446 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231802AbjCOXR3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 19:17:29 -0400
Received: from mail-oo1-xc2f.google.com (mail-oo1-xc2f.google.com [IPv6:2607:f8b0:4864:20::c2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B7A0F95BEC
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 16:17:27 -0700 (PDT)
Received: by mail-oo1-xc2f.google.com with SMTP id p6-20020a4ab386000000b005252182b0e0so3052927ooo.6
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 16:17:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678922247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=gwSCDeK79SYEEdlhQIkBg13sIJL26ZxbOAa1pqepk2Y=;
        b=DGckXOVNcWZ+6DQxaleHX9UIT1Fpp5qA8pRDBrLtyRDjN9NSMXRBEU6x+tw99slyds
         iplncvsXkxl+Z3OE8yq1hzanM0H/pcY9YaVjgvzA+/MyP7WWXU2t16IH3PGIjB/8JUlX
         hRwztGbswJw5PuL9EnQQ/+zzRNvg/CRxToNzkJYPYgz+6rkq2iLYsDR1VQuTupBth/IU
         YICliYUwjNXoAa+Lcbvpl9ueO9WO59hzEjh5vKqf2++Z7CMDYwCfXAt0ybo2rXFNEXsS
         Db6s4X7DQaCqwdyDQU1u4Nr9b17AQ0PFCeEY56nN+jc6q3oVnh9s82+Ocn4BUgHve0DL
         CQWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678922247;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=gwSCDeK79SYEEdlhQIkBg13sIJL26ZxbOAa1pqepk2Y=;
        b=QSvF08IX938UJ0UGj27Cgkxx9g4kJR5+lz3vMYPD5gXmnhMiENgxelBKtG/+Rq2UWj
         mfLm6S/RxwBn7kh2pG97KLTpF+uRya0au2VXg6ud7UufJHFtoK0RmchTGqvP4JMHLTAT
         G5kp2JzMTvCkftON0DDBeaz7FSConew8xT86JKZbvCD7qQRU5qWvypxIXKScVQ9KvttM
         h0+2lVwh2bkqsBZKJYUHm5yszMl8ddqeFqYxZsaMcBNba9GvgRcWZeZEa13WA+bEbX1e
         McA6mmbkUUIvmm8hJ+ptYkofH2kfXzPxUf5E/cGTzn8OK5fyZ6MXlSSi5cAH2zZrBZZv
         Milw==
X-Gm-Message-State: AO0yUKVQ5hZS7N+pzx7GlJB+gHVytvlrBtZdEdFS0GkWmP+f8RDk+UOa
        sWyJOADIJ1PHtIK7LBQ254cGdQ==
X-Google-Smtp-Source: AK7set8qpD+/GUvRXDQbwTfZtgdsA7+ODOopgvgWwSVBKPv0PeeUa/K95ezyKAgTIqrJ0J9f8v0OTw==
X-Received: by 2002:a4a:4846:0:b0:525:4316:7dac with SMTP id p67-20020a4a4846000000b0052543167dacmr21573068ooa.5.1678922246932;
        Wed, 15 Mar 2023 16:17:26 -0700 (PDT)
Received: from [192.168.17.16] ([189.219.75.19])
        by smtp.gmail.com with ESMTPSA id f25-20020a4a8319000000b00517a7ac36c8sm2779571oog.24.2023.03.15.16.17.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 16:17:26 -0700 (PDT)
Message-ID: <c30fa569-91bf-619c-612f-1c796a61d1a4@linaro.org>
Date:   Wed, 15 Mar 2023 17:17:25 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 5.10 000/104] 5.10.175-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
References: <20230315115731.942692602@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20230315115731.942692602@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 5.10.175 release.
> There are 104 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Mar 2023 11:57:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v5.x/stable-review/patch-5.10.175-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-5.10.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

Lots of failures here too.

For:
* ARC (allnoconfig)
* Arm (tinyconfig, footbridge_defconfig, multi_v5_defconfig-aa80e505, omap1_defconfig, sama5_defconfig)
* MIPS (tinyconfig, bcm63xx_defconfig, ath79_defconfig)
* PA-RISC (tinyconfig)
* PowerPC (allnoconfig, tinyconfig, tqm8xx_defconfig, mpc83xx_defconfig, ppc6xx_defconfig)
* RISC-V (allnoconfig, tinyconfig)
* SPARC (allnoconfig, tinyconfig)
* SuperH (allnoconfig, tinyconfig, dreamcast_defconfig, microdev_defconfig)
* x86 (allnoconfig, tinyconfig)

in combinations of GCC-8, GCC-9, GCC-11, GCC-12, Clang-16:

-----8<-----
In file included from /builds/linux/kernel/sched/core.c:13:
/builds/linux/kernel/sched/sched.h:2560:22: error: no member named 'cpu_capacity_inverted' in 'struct rq'
         return cpu_rq(cpu)->cpu_capacity_inverted;
                ~~~~~~~~~~~  ^
----->8-----


For PowerPC (cell_defconfig, mpc83xx_defconfig, ppc6xx_defconfig, tqm8xx_defconfig) with GCC-8, GCC-12, Clang-16:

-----8<-----
/builds/linux/drivers/tty/serial/cpm_uart/cpm_uart_core.c:1208:25: error: use of undeclared identifier 'NO_IRQ'; did you mean 'do_IRQ'?
         if (pinfo->port.irq == NO_IRQ) {
                                ^~~~~~
                                do_IRQ
----->8-----


Greetings!

Daniel Díaz
daniel.diaz@linaro.org

