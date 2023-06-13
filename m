Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 507F472E896
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Jun 2023 18:36:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbjFMQfp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Jun 2023 12:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229445AbjFMQfm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Jun 2023 12:35:42 -0400
Received: from mail-il1-x129.google.com (mail-il1-x129.google.com [IPv6:2607:f8b0:4864:20::129])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C775B10F3;
        Tue, 13 Jun 2023 09:35:40 -0700 (PDT)
Received: by mail-il1-x129.google.com with SMTP id e9e14a558f8ab-33b3f2f7989so23910895ab.0;
        Tue, 13 Jun 2023 09:35:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1686674140; x=1689266140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=2aVGCAfttGaEP+T5hFXH09b2R9I6QV7AaZOFPngkhMY=;
        b=AjVIGkaWmO1nZ9NVHq/qqhSokL2RvmRg57FyyLj+r55Q4PaXJW4Ht+C4nQFIBOdIV7
         xFlyK2GhB7vo1oGBUC8GAzzuLpB+xLvekmCpT3IDwqbsXPtGEDVDhtlJ9YGmWJ1BUEhG
         /0jj54hy+GvfPsW/WFs6LhLThXfK8e0fdGJlZDn6I0TK1mrW8N57uhHgY+9nZRGGa1J8
         dsN5/tL+L28kGWyXicBB4cxqsefgwI8pBtxwaddCZCw0PtzAs/BCgPnP9TzH0EjHsY0/
         GnfIfY3Bf0HaKAtd63OD5mQVgnxbNDApDWqcI6f7MfXhnpL6/dT0+Kwejiht8PmfqeK+
         Vrcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686674140; x=1689266140;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=2aVGCAfttGaEP+T5hFXH09b2R9I6QV7AaZOFPngkhMY=;
        b=Wsv4cs/3qJvcFu6uctx3rViSw0gR90+zHLtSsgetfyDaYQ0lix+ZGpRecmemR+02zh
         e/IR2jCApwcFslRgFbIsXUBF9+MLk4mPbA6TpgZrMUHREgcfYAXWOf6NLHzs+vl72rh7
         4FNoHaLL9NxUM/3s0TvRP6OAt+j2gGqEjYonbx7WBS6yBD03uaArTmB/wpXek37ckpw3
         nIC4NeNtd7tYn3n6ey+ocwNMGj80uvPTEW+C2hi+PiwKMejhCQ+xcQYMhd2nXI+nfZps
         HeWJ0KxvZR3UvtWxX/JxHRJGambzdOdpn+uWeiyN/8/mBOAVwFs8BpghzJ4EtMNJcAcY
         mHZQ==
X-Gm-Message-State: AC+VfDz2oXLiPNzNCHSFXws4rE8wjo79dg9Y5KIf2CsKEzGaaFNKqUDR
        AYMNcDfvktnbtw4wfroyl94=
X-Google-Smtp-Source: ACHHUZ5ou41eckvYfJzBCPzcD/8kdC9EnK2SJ34PiiUY7kYzebcHK8C89YC/Y2wQQMhFyOY/F5gpgA==
X-Received: by 2002:a92:2908:0:b0:338:20f2:1fba with SMTP id l8-20020a922908000000b0033820f21fbamr10733181ilg.10.1686674140058;
        Tue, 13 Jun 2023 09:35:40 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id g25-20020a633759000000b0051afa49e07asm9675143pgn.50.2023.06.13.09.35.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 13 Jun 2023 09:35:39 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <ab4e5232-ccc4-144a-cb72-2a0cce825f31@roeck-us.net>
Date:   Tue, 13 Jun 2023 09:35:37 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 5.10 00/68] 5.10.184-rc1 review
Content-Language: en-US
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org
Cc:     patches@lists.linux.dev, linux-kernel@vger.kernel.org,
        torvalds@linux-foundation.org, akpm@linux-foundation.org,
        shuah@kernel.org, patches@kernelci.org,
        lkft-triage@lists.linaro.org, pavel@denx.de, jonathanh@nvidia.com,
        f.fainelli@gmail.com, sudipm.mukherjee@gmail.com,
        srw@sladewatkins.net, rwarsow@gmx.de
References: <20230612101658.437327280@linuxfoundation.org>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20230612101658.437327280@linuxfoundation.org>
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

On 6/12/23 03:25, Greg Kroah-Hartman wrote:
> This is the start of the stable review cycle for the 5.10.184 release.
> There are 68 patches in this series, all will be posted as a response
> to this one.  If anyone has any issues with these being applied, please
> let me know.
> 
> Responses should be made by Wed, 14 Jun 2023 10:16:41 +0000.
> Anything received after that time might be too late.
> 

Am I the only one seeing this problem ?

Build reference: v5.10.183-69-g32cae866b182
Compiler version: x86_64-linux-gcc (GCC) 11.3.0
Assembler version: GNU assembler (GNU Binutils) 2.39

Building x86_64:allyesconfig ... failed
--------------
Error log:
x86_64-linux-objcopy: vmlinux: unsupported relocation type 0x44
x86_64-linux-objcopy: vmlinux[.text]: relocation count is negative: bad value
make[3]: *** [arch/x86/boot/compressed/Makefile:114: arch/x86/boot/compressed/vmlinux.bin] Error 1
make[3]: *** Waiting for unfinished jobs....
Unsupported relocation type: unknown type rel type name (-1939958716)
make[3]: *** [arch/x86/boot/compressed/Makefile:122: arch/x86/boot/compressed/vmlinux.relocs] Error 1
make[3]: *** Deleting file 'arch/x86/boot/compressed/vmlinux.relocs'
make[2]: *** [arch/x86/boot/Makefile:115: arch/x86/boot/compressed/vmlinux] Error 2
make[1]: *** [arch/x86/Makefile:274: bzImage] Error 2
make: *** [Makefile:192: __sub-make] Error 2

It affects 5.4.y and 5.10.y for me.

Guenter

