Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 566715BEDC6
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 21:29:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231435AbiITT3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Sep 2022 15:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230220AbiITT3O (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Sep 2022 15:29:14 -0400
Received: from mail.baikalelectronics.com (mail.baikalelectronics.com [87.245.175.230])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1F25175FFA;
        Tue, 20 Sep 2022 12:29:06 -0700 (PDT)
Received: from mail (mail.baikal.int [192.168.51.25])
        by mail.baikalelectronics.com (Postfix) with ESMTP id D663DDB1;
        Tue, 20 Sep 2022 22:33:14 +0300 (MSK)
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.baikalelectronics.com D663DDB1
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baikalelectronics.ru; s=mail; t=1663702395;
        bh=as0KC7NBvrB4OZ1kNVjsd0hqYCjlENHq273u9PL1SvU=;
        h=Date:From:To:CC:Subject:References:In-Reply-To:From;
        b=jFuYssRYoOU+j+p09piC6uAmZXovXl5BNplZfYNKsAKTfxVbu5RtSSzNQziw1CN1/
         8eL6fWSAr8+SNXpohbgTRA/NxLLHjle58fNUtagdP8qgQOb7jY3XzL4MryJtLAqOfJ
         qjBxDbmJY1cxo4eaE0Vfs4/t1T1kHy3Ku+welqAo=
Received: from mobilestation (192.168.168.10) by mail (192.168.51.25) with
 Microsoft SMTP Server (TLS) id 15.0.1395.4; Tue, 20 Sep 2022 22:29:04 +0300
Date:   Tue, 20 Sep 2022 22:29:04 +0300
From:   Serge Semin <Sergey.Semin@baikalelectronics.ru>
To:     "Sudip Mukherjee (Codethink)" <sudipm.mukherjee@gmail.com>
CC:     Damien Le Moal <damien.lemoal@opensource.wdc.com>,
        Patrice Chotard <patrice.chotard@foss.st.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-ide@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-next@vger.kernel.org>
Subject: Re: build failure of next-20220919 due to 3f74cd046fbe ("ata:
 libahci_platform: Parse ports-implemented property in resources getter")
Message-ID: <20220920192904.oxa7y35qwrs3ncbp@mobilestation>
References: <Yyhr1VW3Kn30E/Jv@debian>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yyhr1VW3Kn30E/Jv@debian>
X-ClientProxiedBy: MAIL.baikal.int (192.168.51.25) To mail (192.168.51.25)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sudip

On Mon, Sep 19, 2022 at 02:17:09PM +0100, Sudip Mukherjee (Codethink) wrote:
> Hi All,
> 
> The builds of arm allmodconfig have failed to build next-20220919
> with the error:
> 
> drivers/ata/ahci_st.c: In function 'st_ahci_probe':
> drivers/ata/ahci_st.c:147:24: error: unused variable 'dev' [-Werror=unused-variable]
>   147 |         struct device *dev = &pdev->dev;
>       |                        ^~~
> 
> 
> git bisect pointed to 3f74cd046fbe ("ata: libahci_platform: Parse ports-implemented property in resources getter")
> 
> I will be happy to test any patch or provide any extra log if needed.

Thanks for submitting the report. The fix has been already provided by
Damien:
https://lore.kernel.org/all/6f9b5fd7-8a8a-619e-f758-216cadd8ea08@opensource.wdc.com/

-Sergey

> 
> 
> -- 
> Regards
> Sudip
> 
