Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C690469D935
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Feb 2023 04:16:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233427AbjBUDQz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 20 Feb 2023 22:16:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232588AbjBUDQx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 22:16:53 -0500
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9897C23C4D
        for <linux-kernel@vger.kernel.org>; Mon, 20 Feb 2023 19:16:50 -0800 (PST)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 6CF6924DC13;
        Tue, 21 Feb 2023 11:16:49 +0800 (CST)
Received: from EXMBX163.cuchost.com (172.16.7.73) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Feb
 2023 11:16:49 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX163.cuchost.com
 (172.16.7.73) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Tue, 21 Feb
 2023 11:16:49 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Tue, 21 Feb 2023 11:16:49 +0800
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
Thread-Index: AQHZIZTz+V7+Gz83+Eel+CLGjWDN767UeZmAgAMGpQCAAYIHUA==
Date:   Tue, 21 Feb 2023 03:16:48 +0000
Message-ID: <ed6ebf0e6cc146e8b01c543a2fbc6e76@EXMBX066.cuchost.com>
References: <20230106060535.104321-1-jeeheng.sia@starfivetech.com>
 <20230106060535.104321-4-jeeheng.sia@starfivetech.com>
 <Y/DaH0vjMsln4Ghr@duo.ucw.cz>
 <be39247014cd4e12b871ef0e40f09f12@EXMBX066.cuchost.com>
In-Reply-To: <be39247014cd4e12b871ef0e40f09f12@EXMBX066.cuchost.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

In case if you are not aware, the latest series (v4) can be found at: https://patchwork.kernel.org/project/linux-riscv/list/?series=723586

Thanks
Regards
Jee Heng

> -----Original Message-----
> From: JeeHeng Sia
> Sent: Monday, 20 February, 2023 12:22 PM
> To: 'Pavel Machek' <pavel@ucw.cz>
> Cc: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>
> Subject: RE: [PATCH 3/3] RISC-V: Add arch functions to support hibernation/suspend-to-disk
> 
> Hi,
> 
> This is the old series, could you review the latest series at: https://patchwork.kernel.org/project/linux-riscv/list/?series=716143 ?
> 
> > -----Original Message-----
> > From: Pavel Machek <pavel@ucw.cz>
> > Sent: Saturday, 18 February, 2023 10:01 PM
> > To: JeeHeng Sia <jeeheng.sia@starfivetech.com>
> > Cc: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; linux-riscv@lists.infradead.org; linux-
> > kernel@vger.kernel.org; Leyfoon Tan <leyfoon.tan@starfivetech.com>; Mason Huo <mason.huo@starfivetech.com>
> > Subject: Re: [PATCH 3/3] RISC-V: Add arch functions to support hibernation/suspend-to-disk
> >
> > Hi!
> >
> > > @@ -21,6 +21,11 @@ struct suspend_context {
> > >  #endif
> > >  };
> > >
> > > +/* This parameter will be assigned to 0 during resume and will be used by
> > > + * hibernation core for the subsequent resume sequence
> > > + */
> > > +extern int in_suspend;
> >
> > "/*" should be on separate line. (This occurs multiple times.)
> already resolved in v3 series.
> >
> > > +ENTRY(core_restore_code)
> > > +	/* switch to temp page table */
> > > +	csrw satp, s1
> > > +	sfence.vma
> > > +	beqz	s4, done
> > > +loop:
> > > +	/* The below code will restore the hibernated image. */
> > > +	ld	a1, HIBERN_PBE_ADDR(s4)
> > > +	ld	a0, HIBERN_PBE_ORIG(s4)
> > > +
> > > +	lui     a4, 0x1
> > > +	add     a4, a4, a0
> >
> > Do you have enough registers to move a4 = 0x1 assignment before the
> > loop:?
> I am sorry but I don't understand the question. Could you elaborate please?
> >
> > > +static int __init riscv_hibernate__init(void)
> > > +{
> > > +	hibernate_cpu_context = kcalloc(1, sizeof(struct suspend_context), GFP_KERNEL);
> > > +
> >
> > kzalloc?
> sure, will change it.
> >
> > > +	if (WARN_ON(!hibernate_cpu_context))
> > > +		return -ENOMEM;
> > > +
> > > +	return 0;
> > > +}
> > > +
> > > +early_initcall(riscv_hibernate__init);
> >
> > Does this really need to be done early?
> yes. To make sure it is initialized before next resume.
> >
> > Best regards,
> > 								Pavel
> > --
> > People of Russia, stop Putin before his war on Ukraine escalates.
