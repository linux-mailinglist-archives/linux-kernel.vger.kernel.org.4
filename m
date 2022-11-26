Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3AD2E639734
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Nov 2022 17:26:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229563AbiKZQ0G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Nov 2022 11:26:06 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38940 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiKZQZ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Nov 2022 11:25:57 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBC791740E
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 08:25:55 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D440EB818DF
        for <linux-kernel@vger.kernel.org>; Sat, 26 Nov 2022 16:25:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 75D6DC433D6;
        Sat, 26 Nov 2022 16:25:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1669479952;
        bh=mE9FFLOOig/5PFiEBuQVk0ubKR5cL+zh40Pb80IT9JQ=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=OvRffICAcwcyAjRtwbO/v4dHjbFTfGUxJNG5TUu4ZxkgZ3aQtSLzkNaDAeRcwNUD9
         zDp9+L85ut+iaUEIb08kYdRVYefZm6T8yo6Djzbuxzaux3fDhjXvmHCstHzHQIW5qv
         m3D//k3nmUh2bqYc7XVv8/wLO1hcwySZCllorD3pgVtD39GQ9p/340Arq2OR8Ric5P
         zl2fhpKRVbkaq0fIW/be67iS+tN2yqaqU9msDFVPYlLh2z9W8Iv8eeCCDcl+yQQIoX
         pMfRloVCkrZaVT5v3IXs8+4Uhh5o3si90Uw8TxeqeCV+gssU60paDQlH7UOroeN4FX
         kkA8lxvmtxd5w==
Received: by pali.im (Postfix)
        id 1D0FF7B2; Sat, 26 Nov 2022 17:25:50 +0100 (CET)
Date:   Sat, 26 Nov 2022 17:25:50 +0100
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Christophe Leroy <christophe.leroy@csgroup.eu>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Scott Wood <oss@buserror.net>, Sinan Akman <sinan@writeme.com>,
        "linuxppc-dev@lists.ozlabs.org" <linuxppc-dev@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/7] powerpc/85xx: Mark mpc85xx_ds_pic_init() as static
Message-ID: <20221126162550.r4rhg5ud2e5vxzot@pali>
References: <20220819191557.28116-1-pali@kernel.org>
 <20220819191557.28116-3-pali@kernel.org>
 <fd9c174e-2c89-7e11-9e68-d6044b7eab21@csgroup.eu>
 <20220926094706.km22rqzuuulvfssq@pali>
 <20221016110529.76bcgq2v2h4pg2of@pali>
 <3111f16b-2e6d-c46f-67e9-6cb5fada4cc7@csgroup.eu>
 <20221101232503.qymzj7dypsehafvj@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221101232503.qymzj7dypsehafvj@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wednesday 02 November 2022 00:25:03 Pali Rohár wrote:
> On Sunday 16 October 2022 16:59:53 Christophe Leroy wrote:
> > Hello,
> > 
> > Le 16/10/2022 à 13:05, Pali Rohár a écrit :
> > > Hello Christophe! Do you have any other comments for this patch series?
> > 
> > I'm AFK for two weeks, but as far as I remember I don't have any more 
> > comments.
> 
> Hello! When you are back, could you look at my feedback to your comments?

PING?

> > > 
> > > On Monday 26 September 2022 11:47:06 Pali Rohár wrote:
> > >> On Monday 26 September 2022 09:43:55 Christophe Leroy wrote:
> > >>> Le 19/08/2022 à 21:15, Pali Rohár a écrit :
> > >>>> Function mpc85xx_ds_pic_init() is not used out of the mpc85xx_ds.c file.
> > >>>>
> > >>>> Signed-off-by: Pali Rohár <pali@kernel.org>
> > >>>
> > >>> This patch should be squashed into patch 1.
> > >>
> > >> No problem. Just to explain that I split those changes into different
> > >> patches because they touch different files and different board code.
> > >> And I thought that different things should be in different patches.
> > >>
> > >>>> ---
> > >>>>    arch/powerpc/platforms/85xx/mpc85xx_ds.c | 2 +-
> > >>>>    1 file changed, 1 insertion(+), 1 deletion(-)
> > >>>>
> > >>>> diff --git a/arch/powerpc/platforms/85xx/mpc85xx_ds.c b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> > >>>> index f8d2c97f39bd..9a6d637ef54a 100644
> > >>>> --- a/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> > >>>> +++ b/arch/powerpc/platforms/85xx/mpc85xx_ds.c
> > >>>> @@ -54,7 +54,7 @@ static void mpc85xx_8259_cascade(struct irq_desc *desc)
> > >>>>    }
> > >>>>    #endif	/* CONFIG_PPC_I8259 */
> > >>>>    
> > >>>> -void __init mpc85xx_ds_pic_init(void)
> > >>>> +static void __init mpc85xx_ds_pic_init(void)
> > >>>>    {
> > >>>>    	struct mpic *mpic;
> > >>>>    #ifdef CONFIG_PPC_I8259
