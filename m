Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADE946A2560
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 01:13:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229593AbjBYANJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Feb 2023 19:13:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229482AbjBYANH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Feb 2023 19:13:07 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C513B76F
        for <linux-kernel@vger.kernel.org>; Fri, 24 Feb 2023 16:13:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=cIp1vPf5C0pIRZ3gwOB719tgW+A4U3+VOJjnqQvFh+k=; b=NJzOFULQNRvh/Mj/AJDtenyeRh
        rAQ6jLokeZ3m4QXGcP4vDiOfbRu9RtlqD/AtxtiXKlRC9G1vyTd71c9JYmDKv1rrekNVpLfo9ylEz
        /nFYyJOEn/fBDinX1fsY6I5I4GfqMYcDd82vzfp029AzPw/jYXRqlrkD+MupXYW2P5Ftn6OoiecIr
        vCLZkDpY7vEuSnmBzNliCM49M15Fv10hIbtTYcCmgZc2tAuPc/L8GVeqCqs6jv5fceRcQWJ1Vt0k+
        B0bU1bPQB62oQr2z2+6dcFXpwWTZEDOvIolIIwdhWURXe8zyYCB+GecHmuPwEjAYg5dzz17Bw7wQ+
        n6vPkVoQ==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pViBG-004OFL-7r; Sat, 25 Feb 2023 00:12:50 +0000
Message-ID: <d5bd9e86-473e-7577-4472-33eb2acbe8fa@infradead.org>
Date:   Fri, 24 Feb 2023 16:12:49 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: kismet: WARNING: unmet direct dependencies detected for
 IOMMU_IO_PGTABLE_LPAE when selected by IPMMU_VMSA
Content-Language: en-US
To:     Conor Dooley <conor@kernel.org>
Cc:     kernel test robot <lkp@intel.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>
References: <202212221206.Lt61kYrt-lkp@intel.com>
 <e1680223-2819-172e-20ea-daea3282e9eb@infradead.org> <Y6tAgP7UoP3aYBjq@spud>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <Y6tAgP7UoP3aYBjq@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor, Palmer,

On 12/27/22 10:59, Conor Dooley wrote:
> Hey Randy,
> 
> On Thu, Dec 22, 2022 at 05:00:06PM -0800, Randy Dunlap wrote:
>> On 12/21/22 20:49, kernel test robot wrote:
>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>> head:   9d2f6060fe4c3b49d0cdc1dce1c99296f33379c8
>>> commit: 8292493c22c8e28b6e67a01e0f5c6db1cf231eb1 riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option
>>> date:   6 weeks ago
>>> config: riscv-kismet-CONFIG_IOMMU_IO_PGTABLE_LPAE-CONFIG_IPMMU_VMSA-0-0
>>> reproduce:
>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8292493c22c8e28b6e67a01e0f5c6db1cf231eb1
>>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>         git fetch --no-tags linus master
>>>         git checkout 8292493c22c8e28b6e67a01e0f5c6db1cf231eb1
>>>         # 1. reproduce by kismet
>>>            # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
>>>            kismet --linux-ksrc=linux --selectees CONFIG_IOMMU_IO_PGTABLE_LPAE --selectors CONFIG_IPMMU_VMSA -a=riscv
>>>         # 2. reproduce by make
>>>            # save the config file to linux source tree
>>>            cd linux
>>>            make ARCH=riscv olddefconfig
>>>
>>> If you fix the issue, kindly add following tag where applicable
>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>
>>> kismet warnings: (new ones prefixed by >>)
>>>>> kismet: WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE when selected by IPMMU_VMSA
>>>    .config:4814:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' invalid for ARCH_MMAP_RND_BITS
>>>    
>>>    WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
>>>      Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=y] && !GENERIC_ATOMIC64 [=y])
>>>      Selected by [y]:
>>>      - IPMMU_VMSA [=y] && IOMMU_SUPPORT [=y] && (ARCH_RENESAS [=y] || COMPILE_TEST [=y] && !GENERIC_ATOMIC64 [=y])
>>>
>>
>> Maybe this:
>>
>> ---
>>  drivers/iommu/Kconfig |    3 ++-
>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>
>> diff -- a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>> --- a/drivers/iommu/Kconfig
>> +++ b/drivers/iommu/Kconfig
>> @@ -32,7 +32,8 @@ config IOMMU_IO_PGTABLE
>>  config IOMMU_IO_PGTABLE_LPAE
>>  	bool "ARMv7/v8 Long Descriptor Format"
>>  	select IOMMU_IO_PGTABLE
>> -	depends on ARM || ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
>> +	depends on ARM || ARM64 || ARCH_RENESAS || \
>> +		(COMPILE_TEST && !GENERIC_ATOMIC64)
>>  	help
>>  	  Enable support for the ARM long descriptor pagetable format.
>>  	  This allocator supports 4K/2M/1G, 16K/32M and 64K/512M page
>>
>>
>> or is way off?
> 
> Apologies for the radio silence here..
> 
> Palmer initially sent a workaround and there was some discussion there:
> https://lore.kernel.org/all/20221214180409.7354-1-palmer@rivosinc.com/
> Guo sent a patch too:
> https://lore.kernel.org/linux-riscv/20221215073212.1966823-1-guoren@kernel.org/
> 
> I suppose Christmas is doing Christmas things :)

Has this been solved (merged) yet?
I'm still seeing a warning on linux-next-20230224.

thanks.
-- 
~Randy
