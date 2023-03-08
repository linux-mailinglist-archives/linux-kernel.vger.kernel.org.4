Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 845186B0F91
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 18:01:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229913AbjCHRBV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 12:01:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230355AbjCHRAT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 12:00:19 -0500
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9DDB38B46
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 08:58:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=+l6pvPFSZzemwr93IjuxChf8Z8w25V8S4wILXsPthcg=; b=EfkP0FEVzkM+EhrE5eUOXwf/z/
        BwhqVtvzR2VDJzg0nGR2I5ld03VrAl+FUNiUDjBiM1Zq0Uo7JUD3vgT9P/tk0lDlmaw/BC859tJ8Y
        80+30jzQSldVlKEfoqwUhuNM+hDiA7JxZLzf4el9o88Tas7N5Nphf7UF9Tiw7/C/puIcC7r3sIIsq
        wCfYdqQIxUyPw8dbvHlvWJKoRzKg8v8/O1IourmNZWL6QLNfk3fDSb6/Vsb1ABLg1NifjDx99jx/B
        GtX3pp1oDPtu2N4GjdUTqelaQxqEjEcGzU5Maryt4Ybh8rRVlUjKfQs4LS1tElKzlE8YGLtm+d21t
        ShHhg2GA==;
Received: from [2601:1c2:980:9ec0::df2f]
        by bombadil.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1pZx7h-006239-Ul; Wed, 08 Mar 2023 16:58:42 +0000
Message-ID: <0b57bfa2-4d84-1661-f2cb-3e39cce56a42@infradead.org>
Date:   Wed, 8 Mar 2023 08:58:39 -0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
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
 <d5bd9e86-473e-7577-4472-33eb2acbe8fa@infradead.org> <Y/lUvq3TSXL6tJOk@spud>
 <ae2452d4-52cf-4e11-8248-05fb7be77dc8@infradead.org>
 <4F5BE5CB-1AB5-4725-860A-1231A72FCE1D@kernel.org>
 <9d44f863-8644-459a-9fd7-918f742d437e@spud>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <9d44f863-8644-459a-9fd7-918f742d437e@spud>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Conor,

On 3/8/23 08:08, Conor Dooley wrote:
> On Sat, Feb 25, 2023 at 01:43:44PM +0000, Conor Dooley wrote:
>>
>>
>> On 25 February 2023 00:28:36 GMT, Randy Dunlap <rdunlap@infradead.org> wrote:
>>>
>>>
>>> On 2/24/23 16:22, Conor Dooley wrote:
>>>> On Fri, Feb 24, 2023 at 04:12:49PM -0800, Randy Dunlap wrote:
>>>>> Hi Conor, Palmer,
>>>>>
>>>>> On 12/27/22 10:59, Conor Dooley wrote:
>>>>>> Hey Randy,
>>>>>>
>>>>>> On Thu, Dec 22, 2022 at 05:00:06PM -0800, Randy Dunlap wrote:
>>>>>>> On 12/21/22 20:49, kernel test robot wrote:
>>>>>>>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>>>>>>>> head:   9d2f6060fe4c3b49d0cdc1dce1c99296f33379c8
>>>>>>>> commit: 8292493c22c8e28b6e67a01e0f5c6db1cf231eb1 riscv: Kconfig.socs: Add ARCH_RENESAS kconfig option
>>>>>>>> date:   6 weeks ago
>>>>>>>> config: riscv-kismet-CONFIG_IOMMU_IO_PGTABLE_LPAE-CONFIG_IPMMU_VMSA-0-0
>>>>>>>> reproduce:
>>>>>>>>         # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=8292493c22c8e28b6e67a01e0f5c6db1cf231eb1
>>>>>>>>         git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
>>>>>>>>         git fetch --no-tags linus master
>>>>>>>>         git checkout 8292493c22c8e28b6e67a01e0f5c6db1cf231eb1
>>>>>>>>         # 1. reproduce by kismet
>>>>>>>>            # install kmax per https://github.com/paulgazz/kmax/blob/master/README.md
>>>>>>>>            kismet --linux-ksrc=linux --selectees CONFIG_IOMMU_IO_PGTABLE_LPAE --selectors CONFIG_IPMMU_VMSA -a=riscv
>>>>>>>>         # 2. reproduce by make
>>>>>>>>            # save the config file to linux source tree
>>>>>>>>            cd linux
>>>>>>>>            make ARCH=riscv olddefconfig
>>>>>>>>
>>>>>>>> If you fix the issue, kindly add following tag where applicable
>>>>>>>> | Reported-by: kernel test robot <lkp@intel.com>
>>>>>>>>
>>>>>>>> kismet warnings: (new ones prefixed by >>)
>>>>>>>>>> kismet: WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE when selected by IPMMU_VMSA
>>>>>>>>    .config:4814:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_MI' invalid for ARCH_MMAP_RND_BITS
>>>>>>>>    
>>>>>>>>    WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
>>>>>>>>      Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=y] && !GENERIC_ATOMIC64 [=y])
>>>>>>>>      Selected by [y]:
>>>>>>>>      - IPMMU_VMSA [=y] && IOMMU_SUPPORT [=y] && (ARCH_RENESAS [=y] || COMPILE_TEST [=y] && !GENERIC_ATOMIC64 [=y])
>>>>>>>>
>>>>>>>
>>>>>>> Maybe this:
>>>>>>>
>>>>>>> ---
>>>>>>>  drivers/iommu/Kconfig |    3 ++-
>>>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>>>
>>>>>>> diff -- a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>>>>>> --- a/drivers/iommu/Kconfig
>>>>>>> +++ b/drivers/iommu/Kconfig
>>>>>>> @@ -32,7 +32,8 @@ config IOMMU_IO_PGTABLE
>>>>>>>  config IOMMU_IO_PGTABLE_LPAE
>>>>>>>  	bool "ARMv7/v8 Long Descriptor Format"
>>>>>>>  	select IOMMU_IO_PGTABLE
>>>>>>> -	depends on ARM || ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
>>>>>>> +	depends on ARM || ARM64 || ARCH_RENESAS || \
>>>>>>> +		(COMPILE_TEST && !GENERIC_ATOMIC64)
>>>>>>>  	help
>>>>>>>  	  Enable support for the ARM long descriptor pagetable format.
>>>>>>>  	  This allocator supports 4K/2M/1G, 16K/32M and 64K/512M page
>>>>>>>
>>>>>>>
>>>>>>> or is way off?
>>>>>>
>>>>>> Apologies for the radio silence here..
>>>>>>
>>>>>> Palmer initially sent a workaround and there was some discussion there:
>>>>>> https://lore.kernel.org/all/20221214180409.7354-1-palmer@rivosinc.com/
>>>>>> Guo sent a patch too:
>>>>>> https://lore.kernel.org/linux-riscv/20221215073212.1966823-1-guoren@kernel.org/
>>>>>>
>>>>>> I suppose Christmas is doing Christmas things :)
>>>>>
>>>>> Has this been solved (merged) yet?
>>>>> I'm still seeing a warning on linux-next-20230224.
>>>>
>>>> I thought it was fixed in the iommu tree with this series:
>>>> https://lore.kernel.org/all/7a53ac6f-640b-436d-9bfa-3e49066b2460@arm.com/
>>>>
>>>> If it is not, I'll take a look tomorrow...
>>>
>>> I see this warning on today's linux-next-20230224:
>>>
>>> WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
>>>  Depends on [n]: IOMMU_SUPPORT [=y] && (ARM || ARM64 || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]
>>>  Selected by [y]:
>>>  - IPMMU_VMSA [=y] && IOMMU_SUPPORT [=y] && (ARCH_RENESAS [=y] || COMPILE_TEST [=n]) && !GENERIC_ATOMIC64 [=n]
>>>
>>> with the attached config file. Please have a look.
>>
>> My main hard drive in my dev machine died overnight, so I'll have to renage on my tomorrow promise above.
> 
> I finally got around to looking at this today. I tried Palmer's original
> reproducer (riscv32 allmodconfig) on top of v6.3-rc1 & this randconfig +
> olddefconfig on it, and couldn't get the selection to trigger.
> Maybe I misunderstand the randconfig process, but I had thought that
> olddefconfig was supposed to be (the equivalent of) idempotent for
> randconfigs.

That's what I usually do also:
cp some_old_randconfig_file .config
make olddefconfig

> Robin did make some changes to the IOMMU Kconfig stuff that landed in
> v6.3, so perhaps that's what has eventually sorted this out.

Yes, it looks like Robin's commit d286a58bc8f4 fixed this problem.

> Please LMK if I've misunderstood & ruined the randconfig w/
> olddefconfig!

Looks good now. Thanks.

-- 
~Randy
