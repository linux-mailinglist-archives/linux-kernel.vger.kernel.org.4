Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 646D15E9E3A
	for <lists+linux-kernel@lfdr.de>; Mon, 26 Sep 2022 11:48:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234169AbiIZJsQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 26 Sep 2022 05:48:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234058AbiIZJrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 26 Sep 2022 05:47:35 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 27A8210F6
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 02:47:12 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C5980B80835
        for <linux-kernel@vger.kernel.org>; Mon, 26 Sep 2022 09:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57A24C433C1;
        Mon, 26 Sep 2022 09:47:09 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1664185629;
        bh=8xLc9Jif8RGEMCtgB+VC2cSdX4vlVBUss1vrHW2eBb0=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=cfJxzqZf84aR/mjLTUgTIxo2o/wXWjOirG23mUZ8lG/Q3Ha4dFytBF1sdY9TD1FeI
         vWgD6oBxMLPZPs3rpf9HOKbDoEtUIRqgJIro82eti7gu+ssVeCspGRSHf3EI4gV/vn
         GGHQTajn3dx9VvGzizl4CPvTKF3Z66FfxyNW1Orq/0TuHbHH9OKQHrQkF58CrN+01H
         oN0jmMflfAh9wbYGMSXCfwKybtEYPTZDG5tYN1xUz4dZzYbH7vHPmXDiuVxgdBhnzr
         1E8Thj/3COxaj7ECKE+06Srm4iphrY/dLtjtXfFRM5fOJU+8vMOZi+CQw/DQQprQlX
         Eh/apLml3VWOg==
Received: by pali.im (Postfix)
        id 585CD8A3; Mon, 26 Sep 2022 11:47:06 +0200 (CEST)
Date:   Mon, 26 Sep 2022 11:47:06 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>, Sinan Akman <sinan@writeme.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] powerpc/85xx: Mark mpc85xx_ds_pic_init() as static
Message-ID: <20220926094706.km22rqzuuulvfssq@pali>
References: <20220819191557.28116-1-pali@kernel.org>
 <20220819191557.28116-3-pali@kernel.org>
 <fd9c174e-2c89-7e11-9e68-d6044b7eab21@csgroup.eu>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <fd9c174e-2c89-7e11-9e68-d6044b7eab21@csgroup.eu>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 26 September 2022 09:43:55 Christophe Leroy wrote:
> Le 19/08/2022 à 21:15, Pali Rohár a écrit :
> > Function mpc85xx_ds_pic_init() is not used out of the mpc85xx_ds.c file.
> > 
> > Signed-off-by: Pali Rohár <pali@kernel.org>
> 
> This patch should be squashed into patch 1.

No problem. Just to explain that I split those changes into different
patches because they touch different files and different board code.
And I thought that different things should be in different patches.

> > ---
> >   arch/powerpc/platforms/85xx/mpc85xx_ds.c | 2 +-
> >   1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> > index f8d2c97f39bd..9a6d637ef54a 100644
> > --- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> > +++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> > @@ -54,7 +54,7 @@ static void mpc85xx_8259_cascade(struct irq_desc *desc)
> >   }
> >   #endif	/* CONFIG_PPC_I8259 */
> >   
> > -void __init mpc85xx_ds_pic_init(void)
> > +static void __init mpc85xx_ds_pic_init(void)
> >   {
> >   	struct mpic *mpic;
> >   #ifdef CONFIG_PPC_I8259
