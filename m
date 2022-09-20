Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16F9D5BEDA0
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:26:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231415AbiITT0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230233AbiITT0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:26:04 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3A5FC51A11;
        Tue, 20 Sep 2022 12:25:58 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id A14BADB0;
        Tue, 20 Sep 2022 22:30:05 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com A14BADB0
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1663702206;
        bh=WuN6fIRJSgPaBAXvrpUeWDy+6ABC8ILpJugeKFj4CyE=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=Wrp4gkmqBNH9kyFedVhCq9TZlYrN9BTebvh5o45AfRELcS0KbcN3mcFug4s2QhLdD
         //i77czlVKXMwEkHBDXQReg6g88jsZWfYEbS7FteXvNUI0Z3yjV6IdwVcdlIhHeBX4
         WQnSQH3T+0IO4iaPNbBcbMGj4cdM/qc+yc46KwmE=
Received: from mobilestation (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 20 Sep 2022 22:25:55 +0300
Date:   Tue, 20 Sep 2022 22:25:55 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     Damien Le Moal <damien.lemoal@opensource.wdc.com>
CC:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the libata tree
Message-ID: <20220920192555.s3256bkmv3b5sthq@mobilestation>
References: <20220919124034.58670a27@canb.auug.org.au>
 <6f9b5fd7-8a8a-619e-f758-216cadd8ea08@opensource.wdc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6f9b5fd7-8a8a-619e-f758-216cadd8ea08@opensource.wdc.com>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Damien

On Tue, Sep 20, 2022 at 08:56:53AM +0900, Damien Le Moal wrote:
> On 9/19/22 11:40, Stephen Rothwell wrote:
> > Hi all,
> > 
> > After merging the libata tree, today's linux-next build (arm
> > multi_v7_defconfig) produced this warning:
> > 
> > drivers/ata/ahci_st.c: In function 'st_ahci_probe':
> > drivers/ata/ahci_st.c:147:24: warning: unused variable 'dev' [-Wunused-variable]
> >   147 |         struct device *dev = &pdev->dev;
> >       |                        ^~~
> > 
> > Introduced by commit
> > 
> >   3f74cd046fbe ("ata: libahci_platform: Parse ports-implemented property in resources getter")
> > 
> 

> I pushed a fix for this. I also added a dependency on COMPILE_TEST for
> this driver to avoid a repeat in the future.

I'm sorry for not delivering a quick response to the request. Thanks
for sending the fix. Indeed the dev variable should have been dropped.
I should have checked that after removing a part of the code some
variables could be left unused.

-Sergey

> 
> Thanks.
> 
> -- 
> Damien Le Moal
> Western Digital Research
> 
