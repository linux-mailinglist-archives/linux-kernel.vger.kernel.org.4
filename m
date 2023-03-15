Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED1456BB73B
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 16:13:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232852AbjCOPN1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 11:13:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232329AbjCOPNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 11:13:23 -0400
Received: from mail-oi1-x22c.google.com (mail-oi1-x22c.google.com [IPv6:2607:f8b0:4864:20::22c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 801C6EC44
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:13:21 -0700 (PDT)
Received: by mail-oi1-x22c.google.com with SMTP id bi17so14398422oib.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Mar 2023 08:13:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1678893200;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ABKJ4UpnAeH7T4r4sftboUQBoKAUoAxVtGmOsWBgxwY=;
        b=Al7Bv1QZfgGayUYdeFf7q5WdK6oCqS6JbYDyrYWlwlB/e3j39H8+aaaUJaZFARMVxZ
         QQYOBt2dHIaF5ey9NpgZUYUl0zODidfBese7n0A8hZ7doqirYMT3db9tQyUvgx/CNfMJ
         4EP/Gt1i6mMLnpoSEXReyJxIUSSFg5F9+g83ZAXNhl88nj6o55uZ8En/XmdW1ZLrwrlG
         yNiEQl188IqYFVC5y42wyOoppTO6s3xkaW8/qeQUWL3HgO29JysuocdNjYGGpX6ZHcQF
         hNRqKcJb7zcZ5Fg091fucGq+/9XZii1j33CkcByH+uZYOvKwPi126ZRDAs0whYUDNKJ2
         0KWA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1678893200;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ABKJ4UpnAeH7T4r4sftboUQBoKAUoAxVtGmOsWBgxwY=;
        b=lLAV0cB5bJ9uULttqOsYCr47c3rX+be42AEwcSxuJZz9aY7HtO8fKEjtfujGsp7gMb
         ysa2LSreRATvTFjZG9AIEDcrIpmZAFbq1Qw257jj0s8EPI3G80K16+J4QR+eEjNXDoKF
         hRujWXbasHbNXw+j8irzMKyc1ryXRo9+Sm836brBc8EJvDT9DvunbH3CNGaru3qb7ycd
         iiqlmcmdQ6shIm04/TqL7v/y9NSMlp1vRNaCt+dN4mH4QFI1VUobLMMkB3+//Dt5ev5p
         htPLhTcGdTJsG2tqIpEaGzLuy3+YaUPwfGRvdJl/xTJ3mvgTG2roMfC+UfWgVP8sx159
         jkGQ==
X-Gm-Message-State: AO0yUKUTo/gyxwrVzcwtUkR/as4zMqDKvELdtq7ucxfa31lG74o4JZOz
        MKLpUINqaNR7XebaPn38ipVFiA==
X-Google-Smtp-Source: AK7set8ga8fscp43IZc6FMTyWMd8nKLl6VymoeSwhgRBZ6sxtl/5Q59jjV1JhVEl+xRiZamBtHipxw==
X-Received: by 2002:a05:6808:1b13:b0:386:9b71:4d8f with SMTP id bx19-20020a0568081b1300b003869b714d8fmr1349147oib.29.1678893198808;
        Wed, 15 Mar 2023 08:13:18 -0700 (PDT)
Received: from [192.168.17.16] ([189.219.75.19])
        by smtp.gmail.com with ESMTPSA id eb9-20020a056870a88900b001777dc4dac1sm2321566oab.39.2023.03.15.08.13.17
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 15 Mar 2023 08:13:18 -0700 (PDT)
Message-ID: <20ff835c-99e1-4611-95d6-3050604c1b32@linaro.org>
Date:   Wed, 15 Mar 2023 09:13:17 -0600
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 6.2 000/141] 6.2.7-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        linux@roeck-us.net, shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
References: <20230315115739.932786806@linuxfoundation.org>
From:   =?UTF-8?Q?Daniel_D=c3=adaz?= <daniel.diaz@linaro.org>
In-Reply-To: <20230315115739.932786806@linuxfoundation.org>
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
> This is the start of the stable review cycle for the 6.2.7 release.
> There are 141 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Fri, 17 Mar 2023 11:57:10 +0000.
> Anything received after that time might be too late.
> 
> The whole patch series can be found in one patch at:
> 	https://www.kernel.org/pub/linux/kernel/v6.x/stable-review/patch-6.2.7-rc1.gz
> or in the git tree and branch at:
> 	git://git.kernel.org/pub/scm/linux/kernel/git/stable/linux-stable-rc.git linux-6.2.y
> and the diffstat can be found below.
> 
> thanks,
> 
> greg k-h

We can see this build failure on PowerPC with Clang-16 and Clang-nightly, for cell_defconfig:

-----8<-----
error: unknown target CPU 'cell'
note: valid target CPU values are: generic, 440, 450, 601, 602, 603, 603e, 603ev, 604, 604e, 620, 630, g3, 7400, g4, 7450, g4+, 750, 8548, 970, g5, a2, e500, e500mc, e5500, power3, pwr3, power4, pwr4, power5, pwr5, power5x, pwr5x, power6, pwr6, power6x, pwr6x, power7, pwr7, power8, pwr8, power9, pwr9, power10, pwr10, powerpc, ppc, ppc32, powerpc64, ppc64, powerpc64le, ppc64le, future
make[2]: *** [/builds/linux/arch/powerpc/boot/Makefile:235: arch/powerpc/boot/cuboot.o] Error 1
----->8-----


Then on GCC-8 and GCC-12, for ppc64e_defconfig, there's this:

-----8<-----
powerpc64le-linux-gnu-gcc: error: missing argument to '-mcpu='
make[2]: *** [/builds/linux/arch/powerpc/boot/Makefile:238: arch/powerpc/boot/crt0.o] Error 1
powerpc64le-linux-gnu-gcc: error: missing argument to '-mcpu='
make[2]: *** [/builds/linux/arch/powerpc/boot/Makefile:238: arch/powerpc/boot/crtsavres.o] Error 1
powerpc64le-linux-gnu-gcc: error: missing argument to '-mcpu='
make[2]: *** [/builds/linux/arch/powerpc/boot/Makefile:235: arch/powerpc/boot/cuboot.o] Error 1
powerpc64le-linux-gnu-gcc: error: missing argument to '-mcpu='
make[2]: *** [/builds/linux/arch/powerpc/boot/Makefile:235: arch/powerpc/boot/devtree.o] Error 1
[...]
powerpc64le-linux-gnu-gcc: error: missing argument to '-mcpu='
make[2]: *** [/builds/linux/arch/powerpc/boot/Makefile:235: arch/powerpc/boot/fdt_wip.o] Error 1
make[2]: Target 'arch/powerpc/boot/zImage' not remade because of errors.
make[1]: *** [/builds/linux/arch/powerpc/Makefile:247: zImage] Error 2
make[1]: Target '__all' not remade because of errors.
make: *** [Makefile:242: __sub-make] Error 2
make: Target '__all' not remade because of errors.
----->8-----


Greetings!

Daniel Díaz
daniel.diaz@linaro.org

