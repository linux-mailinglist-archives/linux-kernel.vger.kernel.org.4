Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A33D6A2A11
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Feb 2023 14:43:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229614AbjBYNn4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Feb 2023 08:43:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39484 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229529AbjBYNnz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Feb 2023 08:43:55 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B7FA1207A
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 05:43:53 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 05C27B80AB4
        for <linux-kernel@vger.kernel.org>; Sat, 25 Feb 2023 13:43:52 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E795EC433EF;
        Sat, 25 Feb 2023 13:43:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677332630;
        bh=A9z3b64VkaMRkUAV1DYE9aa9lOpeR5FF3NvObDflES0=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=iTVYV7ncYTQRDyLSgSNhGrfTl9ww5MbQlU3XA3IC9rHliGKhfjSY8yoFSdoPCYzYL
         iXVZaNytRiIDyqftw11H/HgVHnCZxnIYfZII3RrWXH/jVpZOgh0/z+k3E9ls2mI3am
         NL/uSwt4KjXokRnEZDBWC0Z5WznQoBWzEnYklMxG0cIrbWnA8K1O41Hcz+xHs2aVZz
         Ez8UUAEi4MYPw5m5EMdFzNoupIxs+a6gd4yTNyrqHSqgUgu0Jw4qJROkFabq878UP4
         MFcnjhbbuZcVeZVtiCeywenPtk9sMcT+ENFq7Oj16vf5kImMUXvj0gTd77tPLZGIur
         rEzwaeyKiYFnQ==
Date:   Sat, 25 Feb 2023 13:43:44 +0000
From:   Conor Dooley <conor@kernel.org>
To:     Randy Dunlap <rdunlap@infradead.org>
CC:     kernel test robot <lkp@intel.com>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Paul Gazzillo <paul@pgazz.com>,
        Necip Fazil Yildiran <fazilyildiran@gmail.com>,
        oe-kbuild-all@lists.linux.dev, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Conor Dooley <conor.dooley@microchip.com>,
        Guo Ren <guoren@kernel.org>
Subject: =?US-ASCII?Q?Re=3A_kismet=3A_WARNING=3A_unmet_direct_dependencies_detecte?= =?US-ASCII?Q?d_for_IOMMU=5FIO=5FPGTABLE=5FLPAE?= =?US-ASCII?Q?_when_selected_by_IPMMU=5FVMSA?=
User-Agent: K-9 Mail for Android
In-Reply-To: <ae2452d4-52cf-4e11-8248-05fb7be77dc8@infradead.org>
References: <202212221206.Lt61kYrt-lkp@intel.com> <e1680223-2819-172e-20ea-daea3282e9eb@infradead.org> <Y6tAgP7UoP3aYBjq@spud> <d5bd9e86-473e-7577-4472-33eb2acbe8fa@infradead.org> <Y/lUvq3TSXL6tJOk@spud> <ae2452d4-52cf-4e11-8248-05fb7be77dc8@infradead.org>
Message-ID: <4F5BE5CB-1AB5-4725-860A-1231A72FCE1D@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 25 February 2023 00:28:36 GMT, Randy Dunlap <rdunlap@infradead=2Eorg> w=
rote:
>
>
>On 2/24/23 16:22, Conor Dooley wrote:
>> On Fri, Feb 24, 2023 at 04:12:49PM -0800, Randy Dunlap wrote:
>>> Hi Conor, Palmer,
>>>
>>> On 12/27/22 10:59, Conor Dooley wrote:
>>>> Hey Randy,
>>>>
>>>> On Thu, Dec 22, 2022 at 05:00:06PM -0800, Randy Dunlap wrote:
>>>>> On 12/21/22 20:49, kernel test robot wrote:
>>>>>> tree:   https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torvald=
s/linux=2Egit master
>>>>>> head:   9d2f6060fe4c3b49d0cdc1dce1c99296f33379c8
>>>>>> commit: 8292493c22c8e28b6e67a01e0f5c6db1cf231eb1 riscv: Kconfig=2Es=
ocs: Add ARCH_RENESAS kconfig option
>>>>>> date:   6 weeks ago
>>>>>> config: riscv-kismet-CONFIG_IOMMU_IO_PGTABLE_LPAE-CONFIG_IPMMU_VMSA=
-0-0
>>>>>> reproduce:
>>>>>>         # https://git=2Ekernel=2Eorg/pub/scm/linux/kernel/git/torva=
lds/linux=2Egit/commit/?id=3D8292493c22c8e28b6e67a01e0f5c6db1cf231eb1
>>>>>>         git remote add linus https://git=2Ekernel=2Eorg/pub/scm/lin=
ux/kernel/git/torvalds/linux=2Egit
>>>>>>         git fetch --no-tags linus master
>>>>>>         git checkout 8292493c22c8e28b6e67a01e0f5c6db1cf231eb1
>>>>>>         # 1=2E reproduce by kismet
>>>>>>            # install kmax per https://github=2Ecom/paulgazz/kmax/bl=
ob/master/README=2Emd
>>>>>>            kismet --linux-ksrc=3Dlinux --selectees CONFIG_IOMMU_IO_=
PGTABLE_LPAE --selectors CONFIG_IPMMU_VMSA -a=3Driscv
>>>>>>         # 2=2E reproduce by make
>>>>>>            # save the config file to linux source tree
>>>>>>            cd linux
>>>>>>            make ARCH=3Driscv olddefconfig
>>>>>>
>>>>>> If you fix the issue, kindly add following tag where applicable
>>>>>> | Reported-by: kernel test robot <lkp@intel=2Ecom>
>>>>>>
>>>>>> kismet warnings: (new ones prefixed by >>)
>>>>>>>> kismet: WARNING: unmet direct dependencies detected for IOMMU_IO_=
PGTABLE_LPAE when selected by IPMMU_VMSA
>>>>>>    =2Econfig:4814:warning: symbol value 'ONFIG_ARCH_MMAP_RND_BITS_M=
I' invalid for ARCH_MMAP_RND_BITS
>>>>>>   =20
>>>>>>    WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE=
_LPAE
>>>>>>      Depends on [n]: IOMMU_SUPPORT [=3Dy] && (ARM || ARM64 || COMPI=
LE_TEST [=3Dy] && !GENERIC_ATOMIC64 [=3Dy])
>>>>>>      Selected by [y]:
>>>>>>      - IPMMU_VMSA [=3Dy] && IOMMU_SUPPORT [=3Dy] && (ARCH_RENESAS [=
=3Dy] || COMPILE_TEST [=3Dy] && !GENERIC_ATOMIC64 [=3Dy])
>>>>>>
>>>>>
>>>>> Maybe this:
>>>>>
>>>>> ---
>>>>>  drivers/iommu/Kconfig |    3 ++-
>>>>>  1 file changed, 2 insertions(+), 1 deletion(-)
>>>>>
>>>>> diff -- a/drivers/iommu/Kconfig b/drivers/iommu/Kconfig
>>>>> --- a/drivers/iommu/Kconfig
>>>>> +++ b/drivers/iommu/Kconfig
>>>>> @@ -32,7 +32,8 @@ config IOMMU_IO_PGTABLE
>>>>>  config IOMMU_IO_PGTABLE_LPAE
>>>>>  	bool "ARMv7/v8 Long Descriptor Format"
>>>>>  	select IOMMU_IO_PGTABLE
>>>>> -	depends on ARM || ARM64 || (COMPILE_TEST && !GENERIC_ATOMIC64)
>>>>> +	depends on ARM || ARM64 || ARCH_RENESAS || \
>>>>> +		(COMPILE_TEST && !GENERIC_ATOMIC64)
>>>>>  	help
>>>>>  	  Enable support for the ARM long descriptor pagetable format=2E
>>>>>  	  This allocator supports 4K/2M/1G, 16K/32M and 64K/512M page
>>>>>
>>>>>
>>>>> or is way off?
>>>>
>>>> Apologies for the radio silence here=2E=2E
>>>>
>>>> Palmer initially sent a workaround and there was some discussion ther=
e:
>>>> https://lore=2Ekernel=2Eorg/all/20221214180409=2E7354-1-palmer@rivosi=
nc=2Ecom/
>>>> Guo sent a patch too:
>>>> https://lore=2Ekernel=2Eorg/linux-riscv/20221215073212=2E1966823-1-gu=
oren@kernel=2Eorg/
>>>>
>>>> I suppose Christmas is doing Christmas things :)
>>>
>>> Has this been solved (merged) yet?
>>> I'm still seeing a warning on linux-next-20230224=2E
>>=20
>> I thought it was fixed in the iommu tree with this series:
>> https://lore=2Ekernel=2Eorg/all/7a53ac6f-640b-436d-9bfa-3e49066b2460@ar=
m=2Ecom/
>>=20
>> If it is not, I'll take a look tomorrow=2E=2E=2E
>
>I see this warning on today's linux-next-20230224:
>
>WARNING: unmet direct dependencies detected for IOMMU_IO_PGTABLE_LPAE
>  Depends on [n]: IOMMU_SUPPORT [=3Dy] && (ARM || ARM64 || COMPILE_TEST [=
=3Dn]) && !GENERIC_ATOMIC64 [=3Dn]
>  Selected by [y]:
>  - IPMMU_VMSA [=3Dy] && IOMMU_SUPPORT [=3Dy] && (ARCH_RENESAS [=3Dy] || =
COMPILE_TEST [=3Dn]) && !GENERIC_ATOMIC64 [=3Dn]
>
>with the attached config file=2E Please have a look=2E

My main hard drive in my dev machine died overnight, so I'll have to renag=
e on my tomorrow promise above=2E

Apologies,
Conor=2E

