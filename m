Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 40D5670B2AF
	for <lists+linux-kernel@lfdr.de>; Mon, 22 May 2023 03:12:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230489AbjEVBMg convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Sun, 21 May 2023 21:12:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229801AbjEVBMd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 May 2023 21:12:33 -0400
Received: from fd01.gateway.ufhost.com (fd01.gateway.ufhost.com [61.152.239.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0783C4
        for <linux-kernel@vger.kernel.org>; Sun, 21 May 2023 18:12:31 -0700 (PDT)
Received: from EXMBX165.cuchost.com (unknown [175.102.18.54])
        (using TLSv1 with cipher DHE-RSA-AES256-SHA (256/256 bits))
        (Client CN "EXMBX165", Issuer "EXMBX165" (not verified))
        by fd01.gateway.ufhost.com (Postfix) with ESMTP id 1D4687F8E;
        Mon, 22 May 2023 09:12:30 +0800 (CST)
Received: from EXMBX068.cuchost.com (172.16.6.68) by EXMBX165.cuchost.com
 (172.16.6.75) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 22 May
 2023 09:12:30 +0800
Received: from EXMBX066.cuchost.com (172.16.7.66) by EXMBX068.cuchost.com
 (172.16.6.68) with Microsoft SMTP Server (TLS) id 15.0.1497.42; Mon, 22 May
 2023 09:12:29 +0800
Received: from EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f]) by
 EXMBX066.cuchost.com ([fe80::5947:9245:907e:339f%17]) with mapi id
 15.00.1497.044; Mon, 22 May 2023 09:12:29 +0800
From:   JeeHeng Sia <jeeheng.sia@starfivetech.com>
To:     Song Shuai <suagrfillet@gmail.com>,
        "paul.walmsley@sifive.com" <paul.walmsley@sifive.com>,
        "palmer@dabbelt.com" <palmer@dabbelt.com>,
        "aou@eecs.berkeley.edu" <aou@eecs.berkeley.edu>,
        Mason Huo <mason.huo@starfivetech.com>,
        "conor.dooley@microchip.com" <conor.dooley@microchip.com>
CC:     "linux-riscv@lists.infradead.org" <linux-riscv@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] riscv: hibernation: Replace jalr with jr before
 suspend_restore_regs
Thread-Topic: [PATCH] riscv: hibernation: Replace jalr with jr before
 suspend_restore_regs
Thread-Index: AQHZihi0VP3rwfUufEaZ9/XX0w5YHK9hZs+ggAQZvJA=
Date:   Mon, 22 May 2023 01:12:29 +0000
Message-ID: <17c5a8fe2d8c4d53b7293db01e7f0955@EXMBX066.cuchost.com>
References: <20230519060854.214138-1-suagrfillet@gmail.com>
 <99eac7b418bd4b518e2edb7379e1158f@EXMBX066.cuchost.com>
In-Reply-To: <99eac7b418bd4b518e2edb7379e1158f@EXMBX066.cuchost.com>
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
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> -----Original Message-----
> From: JeeHeng Sia
> Sent: Friday, May 19, 2023 6:45 PM
> To: 'Song Shuai' <suagrfillet@gmail.com>; paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; Mason Huo
> <mason.huo@starfivetech.com>; conor.dooley@microchip.com
> Cc: linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org
> Subject: RE: [PATCH] riscv: hibernation: Replace jalr with jr before suspend_restore_regs
> 
> looks good to me.
> 
> Thanks
> Regards
> Jee Heng
> > -----Original Message-----
> > From: Song Shuai <suagrfillet@gmail.com>
> > Sent: Friday, May 19, 2023 2:09 PM
> > To: paul.walmsley@sifive.com; palmer@dabbelt.com; aou@eecs.berkeley.edu; JeeHeng Sia <jeeheng.sia@starfivetech.com>;
> Mason
> > Huo <mason.huo@starfivetech.com>; conor.dooley@microchip.com
> > Cc: linux-riscv@lists.infradead.org; linux-kernel@vger.kernel.org; Song Shuai <suagrfillet@gmail.com>
> > Subject: [PATCH] riscv: hibernation: Replace jalr with jr before suspend_restore_regs
> >
> > No need to link the x1/ra reg via jalr before suspend_restore_regs
> > So it's better to replace jalr with jr.
> >
> > Signed-off-by: Song Shuai <suagrfillet@gmail.com>
> > ---
> >  arch/riscv/kernel/hibernate-asm.S | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/hibernate-asm.S b/arch/riscv/kernel/hibernate-asm.S
> > index effaf5ca5da0..5c76671c7e15 100644
> > --- a/arch/riscv/kernel/hibernate-asm.S
> > +++ b/arch/riscv/kernel/hibernate-asm.S
> > @@ -50,7 +50,7 @@ ENTRY(hibernate_restore_image)
> >  	REG_L	s4, restore_pblist
> >  	REG_L	a1, relocated_restore_code
> >
> > -	jalr	a1
> > +	jr	a1
> >  END(hibernate_restore_image)
> >
> >  /*
> > @@ -73,5 +73,5 @@ ENTRY(hibernate_core_restore_code)
> >  	REG_L	s4, HIBERN_PBE_NEXT(s4)
> >  	bnez	s4, .Lcopy
> >
> > -	jalr	s2
> > +	jr	s2
> I am content with these changes, as they do not involve a return after the jump
Reviewed-by: JeeHeng Sia <jeeheng.sia@starfivetech.com >

Thanks
Regards
Jee Heng
> >  END(hibernate_core_restore_code)
> > --
> > 2.20.1

