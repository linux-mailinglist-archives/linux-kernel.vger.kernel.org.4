Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2B46F7F79
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:01:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231351AbjEEJBA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:01:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229810AbjEEJA6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:00:58 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D31F13C22
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 02:00:56 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 9B4E66017E;
        Fri,  5 May 2023 11:00:53 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1683277253; bh=nRqDNIOwpLVzu+gY5IMY4uO38J2lvGJyukw3w+el00Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=2bIaxo8x3KHJLLSZRAEoWoHM1g+NOZp3jfA/yx3HY3hUAQgUIsl8K7ovpBrh3ocX+
         U+Y9xGJKXGt1rDC8mkwoXbIeI3G9DAT4Z19N2REqx/dROpsnMDeXG1aL8RAQQTc+cS
         dl5m/Oua3EAg0Erlbg3pP6aee9XC7UBj5Fa84Ey2HIHXCFgjjP3G3yXkb/8IoeteY+
         l6K2pOENdw/QjwKt96GTxmaVJ5IRKtFPxmx72izt5ZecMi7vrcPZ8LkzPf8Jt1c2RN
         xQ4JsVwqK6JhOmuxBad5j82fv6nc5VlNc0m5eZxPUJCBvPWmWYDXdIltWHqMohXxbK
         Hbj9z9SFtUFoQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mrqEIdXXJ5SD; Fri,  5 May 2023 11:00:51 +0200 (CEST)
Received: from [10.0.1.134] (grf-nat.grf.hr [161.53.83.23])
        by domac.alu.hr (Postfix) with ESMTPSA id 3F6C26016E;
        Fri,  5 May 2023 11:00:51 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1683277251; bh=nRqDNIOwpLVzu+gY5IMY4uO38J2lvGJyukw3w+el00Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=d8SV3T63a9pa3YCcnIdHOPAGPnRoWuUum50gHjCnB/DoeiIrgkA6pMqRAxZgYnNDU
         l+HlM7YYRiiaYi09AviSw0/jbf548v2pwzPYzMDB8DO5oH909ZFlWgT+BxIYbQrcoF
         ir/+FKHpVzwAWAYGpnmX4/Fq8LjE9K43iiwmpAv6AUfHh1YwkTACUr9tWZR+ws6PBX
         Z5CdQ3Ac5AfDQFlWFYGaha604n8HwxTj7Cwr0qxDpYpRw8T4wV3tUblIfG8eRFPosP
         in6YRiq3ZWGW7kCU9CfuzTczCQCGaFUEdZY5V2WSQLZIg6OYuVQJS3H/DFv3oCFM/y
         BwL38JpxAAdGA==
Message-ID: <59599649-6481-eb3a-8584-6653f2c511cd@alu.unizg.hr>
Date:   Fri, 5 May 2023 11:00:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.1
Subject: Re: [BUILD] [FOUND WORKAROUND] Unable to sign drivers on Ubuntu 22.04
 LTS desktop
Content-Language: en-US, hr
To:     Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>,
        Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-kernel@vger.kernel.org
References: <bb89a720-b1b2-18fc-7f89-44267885700d@alu.unizg.hr>
From:   Mirsad Goran Todorovac <mirsad.todorovac@alu.unizg.hr>
In-Reply-To: <bb89a720-b1b2-18fc-7f89-44267885700d@alu.unizg.hr>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4.5.2023. 19:02, Mirsad Goran Todorovac wrote:
> Hi Bagas,
> 
> I seem to have run into a dead end with this.
> 
> OpenSSL 3.0.2 refuses to cooperate, despite enabling legacy ciphers:
> 
>    BTF [M] net/nsh/nsh.ko
>    BTF [M] net/hsr/hsr.ko
> make -f ./Makefile ARCH=x86     KERNELRELEASE=6.3.0+ intdeb-pkg
> sh ./scripts/package/builddeb
>    INSTALL debian/linux-image/lib/modules/6.3.0+/kernel/arch/x86/events/intel/intel-cstate.ko
>    SIGN debian/linux-image/lib/modules/6.3.0+/kernel/arch/x86/events/intel/intel-cstate.ko
> At main.c:170:
> - SSL error:1E08010C:DECODER routines::unsupported: ../crypto/encode_decode/decoder_lib.c:101
> sign-file: ./
> make[6]: *** [scripts/Makefile.modinst:87: debian/linux-image/lib/modules/6.3.0+/kernel/arch/x86/events/intel/intel-cstate.ko] Error 1
> make[6]: *** Deleting file 'debian/linux-image/lib/modules/6.3.0+/kernel/arch/x86/events/intel/intel-cstate.ko'
> make[5]: *** [Makefile:1955: modules_install] Error 2
> make[4]: *** [scripts/Makefile.package:150: intdeb-pkg] Error 2
> make[3]: *** [Makefile:1657: intdeb-pkg] Error 2
> make[2]: *** [debian/rules:16: binary-arch] Error 2
> dpkg-buildpackage: error: debian/rules binary subprocess returned exit status 2
> make[1]: *** [scripts/Makefile.package:139: bindeb-pkg] Error 2
> make: *** [Makefile:1657: bindeb-pkg] Error 2
> 
> I have tried to enable NEXT crypto mode:
> 
> % sudo update-crypto-policies --set NEXT
> 
> and rebooted, but no use.
> 
> Google also doesn't give a clue.
> I have been able to compile kernels on Ubuntu 22.04 LTS on my laptop just about a year ago.

Hi all,

There was no success in building 6.3+ with the Ubuntu generic config, but it has succeeded
with the config derived from Debian one.

Still, it would be interesting to find what is preventing the Ubuntu config from signing the
kernel modules. Up to that point the build process is fine.

Best regards,
Mirsad

-- 
Mirsad Todorovac
System engineer
Faculty of Graphic Arts | Academy of Fine Arts
University of Zagreb
Republic of Croatia, the European Union

Sistem inženjer
Grafički fakultet | Akademija likovnih umjetnosti
Sveučilište u Zagrebu

