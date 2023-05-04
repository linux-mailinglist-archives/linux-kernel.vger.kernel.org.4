Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5ED846F705F
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 19:03:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229825AbjEDRDG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 13:03:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229622AbjEDRDF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 13:03:05 -0400
Received: from domac.alu.hr (domac.alu.unizg.hr [IPv6:2001:b68:2:2800::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 44B8C359F
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 10:03:03 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by domac.alu.hr (Postfix) with ESMTP id 12A196017E;
        Thu,  4 May 2023 19:03:00 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.hr; s=mail;
        t=1683219780; bh=fMQDEi8jqrkIa+i3glZ9O5VMJQuWlqTxJKAKZVf70R8=;
        h=Date:To:Cc:From:Subject:From;
        b=fPfcAvXxKDsFzLK0+6nPx6SUH18s65xIuq/IIcwHi/iWX3WAJC9q/y8kgrIui7SOM
         CL9oe3cMZxeT6m0Nln/b3u1H+uhWXUXjoXjS92NkR/iMgZ67qCCjQu5yQcNf1jvllo
         M16AnCvmEKCgz4DtFR5vlIc+8YX7BiUNnD7r/c0P+b9eBAUuVBhB3OLflqdPyQlbXL
         cp0aHxCWbAPs2qrnuyTrvt3u7RXNCyQ/O2nYNWiIpGM8o/RcppszhT0VXkywJndxYF
         bdjpockF4SVhGQj/Qiq0y0d0mgdd4aABqP9CsDb2dtXbxTWS4ZsxONwdr1BZGtVp7q
         jjZrigFBsIlvQ==
X-Virus-Scanned: Debian amavisd-new at domac.alu.hr
Received: from domac.alu.hr ([127.0.0.1])
        by localhost (domac.alu.hr [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id MreHz3IKBUXK; Thu,  4 May 2023 19:02:57 +0200 (CEST)
Received: from [192.168.1.6] (unknown [77.237.113.62])
        by domac.alu.hr (Postfix) with ESMTPSA id ECBC560173;
        Thu,  4 May 2023 19:02:57 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple; d=alu.unizg.hr; s=mail;
        t=1683219777; bh=fMQDEi8jqrkIa+i3glZ9O5VMJQuWlqTxJKAKZVf70R8=;
        h=Date:To:Cc:From:Subject:From;
        b=kbDpEPGYklijrpzNWkEZ4zOtCeGU7Vy/HNsgvuiqmLSgnoExzFdAbc/vkG7en31EJ
         9WVyj5Vt++KAVXS/5eypaVWVbqGr76KeFdcq+zppEvN9gA6WGV+Wr0x4t45H8GxWjI
         WIq5lI9QtHFh6mh7Pe9FtUy4j3LPLfVZ8bAbG6OJoE9NfcfEMqCs3vdRl1f2o6qr50
         Q+BJiSK0mRedCB7WpQO9ayxreUDg5Elfoov05S/dC1yBgG5kRNNROThBDWH+S/ruoQ
         zwl0ZwHUkIWajOcsujcQQlG0w9iFIDizMkS4yCUsDjhKLVBpFqpKLSaWShroKWBQVY
         lq+LEv5oAgf1w==
Message-ID: <bb89a720-b1b2-18fc-7f89-44267885700d@alu.unizg.hr>
Date:   Thu, 4 May 2023 19:02:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Content-Language: en-US
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-kernel@vger.kernel.org
From:   Mirsad Goran Todorovac <mirsad.goran.todorovac@alu.hr>
Subject: [BUILD] Unable to sign drivers on Ubuntu 22.04 LTS desktop
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=0.9 required=5.0 tests=AC_FROM_MANY_DOTS,BAYES_00,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Bagas,

I seem to have run into a dead end with this.

OpenSSL 3.0.2 refuses to cooperate, despite enabling legacy ciphers:

   BTF [M] net/nsh/nsh.ko
   BTF [M] net/hsr/hsr.ko
make -f ./Makefile ARCH=x86     KERNELRELEASE=6.3.0+ intdeb-pkg
sh ./scripts/package/builddeb
   INSTALL 
debian/linux-image/lib/modules/6.3.0+/kernel/arch/x86/events/intel/intel-cstate.ko
   SIGN 
debian/linux-image/lib/modules/6.3.0+/kernel/arch/x86/events/intel/intel-cstate.ko
At main.c:170:
- SSL error:1E08010C:DECODER routines::unsupported: 
../crypto/encode_decode/decoder_lib.c:101
sign-file: ./
make[6]: *** [scripts/Makefile.modinst:87: 
debian/linux-image/lib/modules/6.3.0+/kernel/arch/x86/events/intel/intel-cstate.ko] 
Error 1
make[6]: *** Deleting file 
'debian/linux-image/lib/modules/6.3.0+/kernel/arch/x86/events/intel/intel-cstate.ko'
make[5]: *** [Makefile:1955: modules_install] Error 2
make[4]: *** [scripts/Makefile.package:150: intdeb-pkg] Error 2
make[3]: *** [Makefile:1657: intdeb-pkg] Error 2
make[2]: *** [debian/rules:16: binary-arch] Error 2
dpkg-buildpackage: error: debian/rules binary subprocess returned exit 
status 2
make[1]: *** [scripts/Makefile.package:139: bindeb-pkg] Error 2
make: *** [Makefile:1657: bindeb-pkg] Error 2

I have tried to enable NEXT crypto mode:

% sudo update-crypto-policies --set NEXT

and rebooted, but no use.

Google also doesn't give a clue.
I have been able to compile kernels on Ubuntu 22.04 LTS on my laptop 
just about a year ago.

Thank you.

Mirsad


