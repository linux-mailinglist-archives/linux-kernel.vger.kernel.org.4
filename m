Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3CA3C69C4B6
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 05:21:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229637AbjBTEVo convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 19 Feb 2023 23:21:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229451AbjBTEVl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Feb 2023 23:21:41 -0500
Received: from ex01.ufhost.com (ex01.ufhost.com [61.152.239.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4B3CAE399
        for <linux-kernel@vger.kernel.org>; Sun, 19 Feb 2023 20:21:39 -0800 (PST)
Received: from EXMBX166.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX166", Issuer "EXMBX166" (not verified))
        by ex01.ufhost.com (Postfix) with ESMTP id E17AC24DBCE;
        Mon, 20 Feb 2023 12:21:35 +0800 (CST)
Received: from EXMBX063.cuchost.com (172.16.7.63) by EXMBX166.cuchost.com
 (172.16.6.76) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 20 Feb
 2023 12:21:35 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX063.cuchost.com
 (172.16.7.63) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 20 Feb
 2023 12:21:35 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Mon, 20 Feb 2023 12:21:35 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Pavel Machek <pavel@ucw.cz>
CC:     "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Leyfoon Tan <leyfoon.tan@starfivetech.com>,
        Mason Huo <mason.huo@starfivetech.com>
Subject: RE: [PATCH 3/3] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Thread-Topic: [PATCH 3/3] RISC-V: Add arch functions to support
 hibernation/suspend-to-disk
Thread-Index: AQHZIZTz+V7+Gz83+Eel+CLGjWDN767UeZmAgAMGpQA=
Date:   Mon, 20 Feb 2023 04:21:35 +0000
Message-ID: <be39247014cd4e12b871ef0e40f09f12@EXMBX066.cuchost.com>
References: <20230106060535.104321-1-jeeheng.sia@starfivetech.com>
 <20230106060535.104321-4-jeeheng.sia@starfivetech.com>
 <Y/DaH0vjMsln4Ghr@duo.ucw.cz>
In-Reply-To: <Y/DaH0vjMsln4Ghr@duo.ucw.cz>
Accept-Language: en-US, zh-CN
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [202.188.176.82]
x-yovoleruleagent: yovoleflag
Content-Type: text/plain; charset="us-ascii"
Content-Transfer-Encoding: 8BIT
MIME-Version: 1.0
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

This is the old series, could you review the latest series at: https://patchwork.kernel.org/project/linux-riscv/list/?series=716143 ?

> -----Original Message-----
> From: Pavel Machek <pavel@ucw.cz>
> Sent: Saturday, 18 February, 2023 10:01 PM
> To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> Cc: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>
> Subject: Re: [PATCH 3/3] RISC-V: Add arch functions to support hibernation/suspend-to-disk
> 
> Hi!
> 
> > @@ -21,6 +21,11 @@ struct suspend_context {
> >  #endif
> >  };
> >
> > +/* This parameter will be assigned to 0 during resume and will be used by
> > + * hibernation core for the subsequent resume sequence
> > + */
> > +extern int in_suspend;
> 
> "/*" should be on separate line. (This occurs multiple times.)
already resolved in v3 series.
> 
> > +ENTRY(core_restore_code)
> > +	/* switch to temp page table */
> > +	csrw satp, s1
> > +	sfence.vma
> > +	beqz	s4, done
> > +loop:
> > +	/* The below code will restore the hibernated image. */
> > +	ld	a1, HIBERN_PBE_ADDR(s4)
> > +	ld	a0, HIBERN_PBE_ORIG(s4)
> > +
> > +	lui     a4, 0x1
> > +	add     a4, a4, a0
> 
> Do you have enough registers to move a4 = 0x1 assignment before the
> loop:?
I am sorry but I don't understand the question. Could you elaborate please?
> 
> > +static int __init riscv_hibernate__init(void)
> > +{
> > +	hibernate_cpu_context = kcalloc(1, sizeof(struct suspend_context), GFP_KERNEL);
> > +
> 
> kzalloc?
sure, will change it.
> 
> > +	if (WARN_ON(!hibernate_cpu_context))
> > +		return -ENOMEM;
> > +
> > +	return 0;
> > +}
> > +
> > +early_initcall(riscv_hibernate__init);
> 
> Does this really need to be done early?
yes. To make sure it is initialized before next resume.
> 
> Best regards,
> 								Pavel
> --
> People of Russia, stop Putin before his war on Ukraine escalates.
