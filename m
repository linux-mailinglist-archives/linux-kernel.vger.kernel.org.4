Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 01ADB72148B
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Jun 2023 06:05:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229760AbjFDEFQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Jun 2023 00:05:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229715AbjFDEFN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Jun 2023 00:05:13 -0400
X-Greylist: delayed 457 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Sat, 03 Jun 2023 21:05:12 PDT
Received: from raptorengineering.com (mail.raptorengineering.com [23.155.224.40])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C39DD2;
        Sat,  3 Jun 2023 21:05:11 -0700 (PDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 32E518284E45;
        Sat,  3 Jun 2023 22:57:33 -0500 (CDT)
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id 16z4nBhDYE8N; Sat,  3 Jun 2023 22:57:31 -0500 (CDT)
Received: from localhost (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id 21E1C8284F94;
        Sat,  3 Jun 2023 22:57:31 -0500 (CDT)
DKIM-Filter: OpenDKIM Filter v2.10.3 mail.rptsys.com 21E1C8284F94
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=raptorengineering.com; s=B8E824E6-0BE2-11E6-931D-288C65937AAD;
        t=1685851051; bh=pp9YQ8oFCEzUqouZstn/GGVcB6betN1RFKBrWGUP9Fs=;
        h=Date:From:To:Message-ID:MIME-Version;
        b=mvhxQwPrWgfdt3u2ilB9ZnV4r7xUJBgie8mHoIpjdvKaaDwFXjCPHqor+GTRcRMIS
         EIcAvtbutXewQm0EAaoVySG89ZaSutTUKean2lOoUB8+9Ywt94CjBc0h6YhH1b7ToN
         14mcLB8iw/PNs6Etd0hWWGjROJAxcpMg9F/vQbww=
X-Virus-Scanned: amavisd-new at rptsys.com
Received: from mail.rptsys.com ([127.0.0.1])
        by localhost (vali.starlink.edu [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id SGdpJceVXicU; Sat,  3 Jun 2023 22:57:30 -0500 (CDT)
Received: from vali.starlink.edu (localhost [127.0.0.1])
        by mail.rptsys.com (Postfix) with ESMTP id CD7728284E45;
        Sat,  3 Jun 2023 22:57:30 -0500 (CDT)
Date:   Sat, 3 Jun 2023 22:57:28 -0500 (CDT)
From:   Timothy Pearson <tpearson@raptorengineering.com>
To:     Michael Ellerman <mpe@ellerman.id.au>
Cc:     Randy Dunlap <rdunlap@infradead.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Alexey Kardashevskiy <aik@ozlabs.ru>
Message-ID: <586983120.3136676.1685851048873.JavaMail.zimbra@raptorengineeringinc.com>
In-Reply-To: <87h6rogjok.fsf@mail.lhotse>
References: <20230602140143.0af52cee@canb.auug.org.au> <2d188c87-ef34-3812-7330-a985f756d959@infradead.org> <87h6rogjok.fsf@mail.lhotse>
Subject: Re: linux-next: Tree for Jun 2 (arch/powerpc/kernel/iommu.c)
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Mailer: Zimbra 8.5.0_GA_3042 (ZimbraWebClient - GC114 (Linux)/8.5.0_GA_3042)
Thread-Topic: linux-next: Tree for Jun 2 (arch/powerpc/kernel/iommu.c)
Thread-Index: RTvjy9BIecQ79Qf7Chi/J96e/nXceg==
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



----- Original Message -----
> From: "Michael Ellerman" <mpe@ellerman.id.au>
> To: "Randy Dunlap" <rdunlap@infradead.org>, "Stephen Rothwell" <sfr@canb.auug.org.au>, "Linux Next Mailing List"
> <linux-next@vger.kernel.org>
> Cc: "linux-kernel" <linux-kernel@vger.kernel.org>, "linuxppc-dev" <linuxppc-dev@lists.ozlabs.org>, "Alexey
> Kardashevskiy" <aik@ozlabs.ru>, "Timothy Pearson" <tpearson@raptorengineering.com>
> Sent: Saturday, June 3, 2023 7:22:51 PM
> Subject: Re: linux-next: Tree for Jun 2 (arch/powerpc/kernel/iommu.c)

> Randy Dunlap <rdunlap@infradead.org> writes:
>> On 6/1/23 21:01, Stephen Rothwell wrote:
>>> Hi all,
>>> 
>>> Changes since 20230601:
>>> 
>>
>> On powerpc64, a randconfig failed with:
>>
>> In file included from ../include/linux/list.h:5,
>>                  from ../include/linux/preempt.h:11,
>>                  from ../include/linux/spinlock.h:56,
>>                  from ../include/linux/mmzone.h:8,
>>                  from ../include/linux/gfp.h:7,
>>                  from ../include/linux/slab.h:15,
>>                  from ../arch/powerpc/kernel/iommu.c:15:
>> ../arch/powerpc/kernel/iommu.c: In function
>> 'spapr_tce_setup_phb_iommus_initcall':
>> ../arch/powerpc/kernel/iommu.c:1391:36: error: 'hose_list' undeclared (first use
>> in this function); did you mean 'zonelist'?
>>  1391 |         list_for_each_entry(hose, &hose_list, list_node) {
>>       |                                    ^~~~~~~~~
> ...
> 
> hose_list is in pci-common.c which is built when PCI=y.
> 
> PSERIES and POWERNV force PCI=y.
> 
> But this config has neither:
> 
> # CONFIG_PPC_POWERNV is not set
> # CONFIG_PPC_PSERIES is not set
> CONFIG_HAVE_PCI=y
> # CONFIG_PCI is not set
> # CONFIG_COMMON_CLK_RS9_PCIE is not set
> 
> 
> Probably the spapr_tce code should be wrapped in an #ifdef that is only
> enabled when POWERNV || PSERIES is enabled.
> 
> cheers

Sounds reasonable, I was going to look into this further over the weekend.  I can put together a patch for Monday if that works?
