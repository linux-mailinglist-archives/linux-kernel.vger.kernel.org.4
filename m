Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AE37F731D40
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 18:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244403AbjFOQAY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 12:00:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241316AbjFOQAV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 12:00:21 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:3::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47A1F295B;
        Thu, 15 Jun 2023 09:00:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20210309; h=Content-Transfer-Encoding:
        Content-Type:In-Reply-To:From:References:Cc:To:Subject:MIME-Version:Date:
        Message-ID:Sender:Reply-To:Content-ID:Content-Description;
        bh=UrGANt7scBrisMpPSlfWbqcoa3cbh52COIYVdt4D2VY=; b=0QxAoBynm1SLoxxSI3Gclka5Vu
        xUULIUSel2hEg2rLJ8O9BZaZHyrMxKQ4yYY3EdEF0sTzbZX4au+/KlFVLNOHc4Kwt+VY+yBCsexlJ
        Es2+5cYctqb0heDwLAQOeW7ojHu52MJPhPFIH/XyxuIR/11WfXaeusqkohM1i9yBydIyIKjsC14tl
        oRChPCxLXAAcvbchHQEuz9TI6BHX0crznjLQKOPyMHsfq247yt2Po1gdxDJXp2J5y7Er6f1yJ3WpJ
        VEx43/do3B9eGlelwjIqPk1bDMRE8jIKvSSIJ748RNKabhQhDUsKMKMhJngRq17yPgthx/ySdfX0B
        o5dl9luQ==;
Received: from [2601:1c2:980:9ec0::2764]
        by bombadil.infradead.org with esmtpsa (Exim 4.96 #2 (Red Hat Linux))
        id 1q9pOL-00FMVx-3A;
        Thu, 15 Jun 2023 16:00:10 +0000
Message-ID: <e2b46606-7ebc-c9a4-4f9a-873c0e71da5e@infradead.org>
Date:   Thu, 15 Jun 2023 09:00:08 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: linux-next: Tree for Jun 2 (arch/powerpc/kernel/iommu.c)
Content-Language: en-US
To:     Timothy Pearson <tpearson@raptorengineering.com>,
        Michael Ellerman <mpe@ellerman.id.au>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
References: <20230602140143.0af52cee@canb.auug.org.au>
 <2d188c87-ef34-3812-7330-a985f756d959@infradead.org>
 <87h6rogjok.fsf@mail.lhotse>
 <586983120.3136676.1685851048873.JavaMail.zimbra@raptorengineeringinc.com>
From:   Randy Dunlap <rdunlap@infradead.org>
In-Reply-To: <586983120.3136676.1685851048873.JavaMail.zimbra@raptorengineeringinc.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Timothy,

On 6/3/23 20:57, Timothy Pearson wrote:
> 
> 
> ----- Original Message -----
>> From: "Michael Ellerman" <mpe@ellerman.id.au>
>> To: "Randy Dunlap" <rdunlap@infradead.org>, "Stephen Rothwell" <sfr@canb.auug.org.au>, "Linux Next Mailing List"
>> <linux-next@vger.kernel.org>
>> Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "Alexey
>> Kardashevskiy" <aik@ozlabs.ru>, "Timothy Pearson" <tpearson@raptorengineering.com>
>> Sent: Saturday, June 3, 2023 7:22:51 PM
>> Subject: Re: linux-next: Tree for Jun 2 (arch/powerpc/kernel/iommu.c)
> 
>> Randy Dunlap <rdunlap@infradead.org> writes:
>>> On 6/1/23 21:01, Stephen Rothwell wrote:
>>>> Hi all,
>>>>
>>>> Changes since 20230601:
>>>>
>>>
>>> On powerpc64, a randconfig failed with:
>>>
>>> In file included from ../include/linux/list.h:5,
>>>                  from ../include/linux/preempt.h:11,
>>>                  from ../include/linux/spinlock.h:56,
>>>                  from ../include/linux/mmzone.h:8,
>>>                  from ../include/linux/gfp.h:7,
>>>                  from ../include/linux/slab.h:15,
>>>                  from ../arch/powerpc/kernel/iommu.c:15:
>>> ../arch/powerpc/kernel/iommu.c: In function
>>> 'spapr_tce_setup_phb_iommus_initcall':
>>> ../arch/powerpc/kernel/iommu.c:1391:36: error: 'hose_list' undeclared (first use
>>> in this function); did you mean 'zonelist'?
>>>  1391 |         list_for_each_entry(hose, &hose_list, list_node) {
>>>       |                                    ^~~~~~~~~
>> ...
>>
>> hose_list is in pci-common.c which is built when PCI=y.
>>
>> PSERIES and POWERNV force PCI=y.
>>
>> But this config has neither:
>>
>> # CONFIG_PPC_POWERNV is not set
>> # CONFIG_PPC_PSERIES is not set
>> CONFIG_HAVE_PCI=y
>> # CONFIG_PCI is not set
>> # CONFIG_COMMON_CLK_RS9_PCIE is not set
>>
>>
>> Probably the spapr_tce code should be wrapped in an #ifdef that is only
>> enabled when POWERNV || PSERIES is enabled.
>>
>> cheers
> 
> Sounds reasonable, I was going to look into this further over the weekend.  I can put together a patch for Monday if that works?

Did you prepare a patch for this? I am still seeing this build error.

thanks.
-- 
~Randy
