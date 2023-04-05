Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637A56D7115
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 02:02:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236671AbjDEAB6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 20:01:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34214 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235153AbjDEAB4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 20:01:56 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E8E6421E;
        Tue,  4 Apr 2023 17:01:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:References:Cc:To:From:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=zu+LT4m9bTpmlAefKcX0chH2sTk6W58anNMQINmqoSA=; b=O6X2nPC/09ge4dU0qrHi54P7kK
        ALdC6IqUbYbQ4dEJKDME61w6TmgJt7hjEOpRr7RMvou/X5vuN6uYCwlEMvhTuZHliJnbt2lxso2Or
        iFtjuFb6e4rE3/nNStwfjXY2LWgdcMCONciGfZENQnVM+hL3hyS4lKj6JngfC4PQc5WlpGQdrdh03
        hHjd3XVXFwwXSbcRbaKcQDdGCA+PoZWKM5AfbQoa9dcRWSqTWTiRTcTIKdEXpx+cJAQ+ZmTCvFeMS
        ZgOFkWPa0GCEf6IUorLSZuvF0lS6w6U+Hc9CYdvMcuGs3sXCsvQLuU2GkAA0E2a75kTQ9S+xliV6v
        +hwZLP4w==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1pjqay-0032Jj-0q;
        Wed, 05 Apr 2023 00:01:48 +0000
Message-ID: <d7c250e0-a3a8-51d0-a761-7a81305b39b2@infradead.org>
Date:   Tue, 4 Apr 2023 17:01:46 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: Build regressions/improvements in v6.3-rc4 (parport_pc)
Content-Language: en-US
From:   Randy Dunlap <rdunlap@infradead.org>
To:     Sudip Mukherjee <sudipm.mukherjee@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     linux-kernel@vger.kernel.org, linux-wireless@vger.kernel.org,
        sparclinux@vger.kernel.org, "Maciej W. Rozycki" <macro@orcam.me.uk>
References: <CAHk-=whcaHLNpb7Mu_QX7ABwPgyRyfW-V8=v4Mv0S22fpjY4JQ@mail.gmail.com>
 <20230327072641.3591802-1-geert@linux-m68k.org>
 <eb55ca34-ca71-ed19-dae2-6e5e87c170@linux-m68k.org>
 <CADVatmNHYar6tR3r9q42vZR5fsqZeeDb8LEmmBcrrOwhA7HpmQ@mail.gmail.com>
 <c3718ac3-3dd1-2273-68ef-3d2923778ab7@infradead.org>
In-Reply-To: <c3718ac3-3dd1-2273-68ef-3d2923778ab7@infradead.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/4/23 15:40, Randy Dunlap wrote:
> 
> 
> On 4/4/23 14:16, Sudip Mukherjee wrote:
>> On Mon, 27 Mar 2023 at 08:29, Geert Uytterhoeven <geert@linux-m68k.org> wrote:
>>>
>>> On Mon, 27 Mar 2023, Geert Uytterhoeven wrote:
>>>> JFYI, when comparing v6.3-rc4[1] to v6.3-rc3[3], the summaries are:
>>>>  - build errors: +9/-1
>>>
>>>    + /kisskb/src/drivers/net/wireless/cisco/airo.c: error: 'status_rid.currentXmitRate' is used uninitialized [-Werror=uninitialized]:  => 6163:45
>>>
>>> sh4-gcc11/sh-allmodconfig
>>> seen before
>>>
>>>    + error: modpost: "ebus_dma_enable" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>>>    + error: modpost: "ebus_dma_irq_enable" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>>>    + error: modpost: "ebus_dma_prepare" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>>>    + error: modpost: "ebus_dma_register" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>>>    + error: modpost: "ebus_dma_request" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>>>    + error: modpost: "ebus_dma_residue" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>>>    + error: modpost: "ebus_dma_unregister" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>>>    + error: modpost: "ns87303_lock" [drivers/parport/parport_pc.ko] undefined!:  => N/A
>>>
>>> sparc64-gcc11/sparc-allmodconfig
>>> seen before
>>
>> Tried sparc64 allmodconfig with gcc-11 and did not see the parport
>> errors with 6ab608fe852b ("Merge tag 'for-6.3-rc4-tag' of
>> git://git.kernel.org/pub/scm/linux/kernel/git/kdave/linux").
>> Is it still being seen?
>>
> 
> This is reported at  http://kisskb.ellerman.id.au/kisskb/buildresult/14905002/
> 
> I still see it on sparc32 using gcc-12.2.0.
> 
> The compiler info vs. the sparc-allmodconfig is confusing IMO.
> I am compiling with sparc-linux, not sparc64-linux.
> 
> The .config file says:
> # CONFIG_64BIT is not set
> CONFIG_SPARC=y
> CONFIG_SPARC32=y

It looks to me like we have 2 choices (though there may be others
that are more complicated):

(1) restrict PARPORT_PC to !SPARC32
This fixes the build errors.

(2) We could build ebus.o and some (new) binary that includes
ns87303_lock for SPARC32. They are currently only built for SPARC64.

I prefer option (1) unless we need to support PARPORT_PC on
Sparc32 (which I have no idea about).  Patch for it is below for inspection.

---
From: Randy Dunlap <rdunlap@infradead.org>
Subject: [PATCH] parport_pc: don't allow driver for SPARC32

arch/sparc/kernel/ebus.o is only built for SPARC64.
ns87303_lock is only built for SPARC64.
Also, arch/sparc/include/asm/parport.h says that it is for sparc64.

Therefore don't allow PARPORT_PC to be built for SPARC32.

Fixes these build errors on SPARC32:

ERROR: modpost: "ebus_dma_irq_enable" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_unregister" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_register" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ns87303_lock" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_enable" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_prepare" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_request" [drivers/parport/parport_pc.ko] undefined!
ERROR: modpost: "ebus_dma_residue" [drivers/parport/parport_pc.ko] undefined!

Fixes: 66bcd06099bb ("parport_pc: Also enable driver for PCI systems")
Signed-off-by: Randy Dunlap <rdunlap@infradead.org>
Cc: Sudip Mukherjee <sudipm.mukherjee@gmail.com>
Cc: Maciej W. Rozycki <macro@orcam.me.uk>
Cc: "David S. Miller" <davem@davemloft.net>
Cc: sparclinux@vger.kernel.org
Cc: Sam Ravnborg <sam@ravnborg.org>
Cc: linux-parport@lists.infradead.org
---
 drivers/parport/Kconfig |    2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff -- a/drivers/parport/Kconfig b/drivers/parport/Kconfig
--- a/drivers/parport/Kconfig
+++ b/drivers/parport/Kconfig
@@ -42,7 +42,7 @@ if PARPORT
 
 config PARPORT_PC
 	tristate "PC-style hardware"
-	depends on ARCH_MIGHT_HAVE_PC_PARPORT || (PCI && !S390)
+	depends on ARCH_MIGHT_HAVE_PC_PARPORT || (PCI && !S390 && !SPARC32)
 	help
 	  You should say Y here if you have a PC-style parallel port. All
 	  IBM PC compatible computers and some Alphas have PC-style
