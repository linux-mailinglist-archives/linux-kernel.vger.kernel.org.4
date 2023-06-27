Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9877773F3D8
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 07:08:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230075AbjF0FIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 01:08:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229584AbjF0FIf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 01:08:35 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C2F494
        for <linux-kernel@vger.kernel.org>; Mon, 26 Jun 2023 22:08:34 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0EEBF60FF5
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 05:08:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 494D9C433C0;
        Tue, 27 Jun 2023 05:08:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687842513;
        bh=XI/I8CJuUMJoeYo9ZCJ+THr+Vj3BF/x2yfq8wLJ0gWM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=f6ORfyJfBvvfb2pO+nnY8o0t6lTsbWAFImQy73aSEydg7kHt1qTUJ6OeojjHNegUN
         espCzIOefg98A/K7OCpJGH6G2oLFDTwdW5V/isPD0INd/27h3A9j5avj7cj6cmVZL0
         NZeVX1qHyV0cEIr21+Iv+nl/JYtUaMVBWDTBC2m023JNPvVSmnnBJDUYqzi1qJeWkY
         Nr5WRGwbE5uauoAHLn0yZ+iisgkIbCFb/BWEWWI4bi+MPTdYnEPBS9BSr6M38fG5ST
         ti2+N6cnyK4/SW3cYsEP6ekhVBR+yivBnCIqDepsu42n95QwY45U7mq/5WL5+e8cDE
         +xT+UrJPMlOjQ==
Message-ID: <5b6953ac-6bf6-6663-a566-40f0ae9f9572@kernel.org>
Date:   Tue, 27 Jun 2023 00:08:30 -0500
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/2] arch: arm64: configs: Enable UBI and UBIFS
Content-Language: en-US
To:     "Lee, Kah Jing" <kah.jing.lee@intel.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <0d1b3c55-4b11-9e63-e388-191d39d88df1@linaro.org>
 <20230622122114.592791-1-kah.jing.lee@intel.com>
 <25439c1e-c9ef-0dc6-8d91-883d7734d0fd@linaro.org>
 <PH0PR11MB5673A862187810E9986E3C8BCB23A@PH0PR11MB5673.namprd11.prod.outlook.com>
 <125c849f-3746-864f-8b8f-6e0a33aca439@linaro.org>
 <PH0PR11MB567334A09B2D4A1D3DDC09F2CB20A@PH0PR11MB5673.namprd11.prod.outlook.com>
 <0599fc9c-0057-7aa5-3332-40922753ad97@linaro.org>
 <PH0PR11MB56734DB18155588535DC0384CB26A@PH0PR11MB5673.namprd11.prod.outlook.com>
 <12c68124-9687-d68c-294a-2bfd13338edd@linaro.org>
 <PH0PR11MB5673A2BA9D39B9CD4C775DA5CB27A@PH0PR11MB5673.namprd11.prod.outlook.com>
From:   Dinh Nguyen <dinguyen@kernel.org>
In-Reply-To: <PH0PR11MB5673A2BA9D39B9CD4C775DA5CB27A@PH0PR11MB5673.namprd11.prod.outlook.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/26/23 22:40, Lee, Kah Jing wrote:
>> -----Original Message-----
>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Sent: Monday, 26 June, 2023 4:39 PM
>> To: Lee, Kah Jing <kah.jing.lee@intel.com>; Dinh Nguyen
>> <dinguyen@kernel.org>; Rob Herring <robh+dt@kernel.org>; Krzysztof
>> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
>> <conor+dt@kernel.org>; Catalin Marinas <catalin.marinas@arm.com>; Will
>> Deacon <will@kernel.org>
>> Cc: linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH 2/2] arch: arm64: configs: Enable UBI and UBIFS
>>
>> On 26/06/2023 06:16, Lee, Kah Jing wrote:
>>>> -----Original Message-----
>>>> From: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>>>> Sent: Saturday, 24 June, 2023 3:30 PM
>>>> To: Lee, Kah Jing <kah.jing.lee@intel.com>; Dinh Nguyen
>>>> <dinguyen@kernel.org>; Rob Herring <robh+dt@kernel.org>; Krzysztof
>>>> Kozlowski <krzysztof.kozlowski+dt@linaro.org>; Conor Dooley
>>>> <conor+dt@kernel.org>; Catalin Marinas <catalin.marinas@arm.com>;
>>>> Will Deacon <will@kernel.org>
>>>> Cc: linux-kernel@vger.kernel.org
>>>> Subject: Re: [PATCH 2/2] arch: arm64: configs: Enable UBI and UBIFS
>>>>
>>>> On 24/06/2023 05:42, Lee, Kah Jing wrote:
>>>>>>>> So you miss init ramdisk.
>>>>>>> Currently we are using the bootargs to mount the rootfs from QSPI
>>>>>>> NOR
>>>>>> flash:
>>>>>>> [    0.000000] Kernel command line: earlycon panic=-1 ubi.mtd=1
>>>>>> root=ubi0:rootfs rootfstype=ubifs rw rootwait
>>>>>>> Is it possible to mount the ubifs rootfs with the ubifs=m config
>>>>>>> during
>>>> boot?
>>>>>>
>>>>>> I think yes. rootfs devices are for example modules, so filesystem
>>>>>> can be as well.
>>>>> Was going through mtd ubifs page -
>>>>> http://www.linux-mtd.infradead.org/faq/ubifs.html
>>>>> Quoted: 'In order to mount UBIFS as the root file system, you have
>>>>> to compile UBIFS into the kernel (instead of compiling it as a
>>>>> kernel
>>>>> module) and specify proper kernel boot arguments and make the kernel
>>>> mount UBIFS on boot.'
>>>>
>>>> Why? Module loaded by initramfs would also understand cmdline
>>>> arguments, right?
>>> The suggestion is to use initramfs for rootfs -> remount UBIFS as chroot?
>>> The concern is additional initrd image and steps to store in the
>>> limited NOR flash (256MB, Boot data + Uboot - ~66MB, UBIFS image -
>>> ~88MB, kernel.itb - ~10MB = 164MB).
>>> With the mounting Rootfs from UBIFS volume, we can skip the initrd
>>> step, and save some space for the user operations.
>>> Let me know if I understands that correctly.
>>
>> arm64 defconfig creates huge development config for all platforms, so why
>> would you ever use it in resource-constrained system? It would barely fit.
>> defconfig modules take 50 MB alone and you don't need most of them.
>>
>> I think you misunderstood the purpose of this defconfig and now try to apply
>> some arguments for different use cases.
> Understood the point. In this case, I would drop this defconfig patch, and
> document it for customers to enable through menuconfig.
> 
> Will proceed to send the v3 for only dts changes.
> Thanks for the time.
>>

You can still have the defconfig build them as modules. Then you can 
include them in your initramfs.

Dinh
