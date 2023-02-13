Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DA6C694ECA
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Feb 2023 19:06:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229907AbjBMSG2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Feb 2023 13:06:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51652 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229721AbjBMSG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Feb 2023 13:06:26 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5E0E72AE
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:05:56 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id be8so14327797plb.7
        for <linux-kernel@vger.kernel.org>; Mon, 13 Feb 2023 10:05:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=gp01G0BnFM3UtiZCCxzyTfWZR8Wx0j9sIGOAAei1oMU=;
        b=mlNWBi4qWOmt9CWXPhLTyfsFtxOYE4aUhkT7NmX8aiwyLhuI/5LKhxAUJ+I+/KaNuP
         nm/EYaqSF3u/oIgBNxcS2Y8oc3b8NS2fanszcj32o2kE1mBcfiYKKqyb0ZmNadik5/50
         JpRAWTdNsaTje/7/HECRCwtzdORJvUq134+BFS42xlwkLL+yDQ1bTqdXgBa80CSOtjEw
         KAlN5Et1DQM6eIygJc08jb8CMILZu+XH6wnPNDuZrHuZPCzrOCi6PkGz6iAq0PMF/Cam
         cPP2Lro0A1zpfoN9WgaUUSvM/5NdZvYArlAGr577kURNoBwrG6UCrRLt5oz3/LdUe2Nt
         aLLw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=gp01G0BnFM3UtiZCCxzyTfWZR8Wx0j9sIGOAAei1oMU=;
        b=14Jhf92M8egTmCBWsxkvCh/ivB63vsP/0GvjW7AOfStA3FqYkJDYRdDtI8ibsgcCan
         JOCzlTzlQI7IavUqyXmDoqWke43PhovznF6pHEcqMcQaRnjQ5lKhqXkcvznq7V2pQZC6
         /g8I19NQhAQNnbno04pqL+5SydNhFFODyT4eKw9s/k2jVjiJrFQSx0EtXTT3KjvCEB73
         tNk/XYmBbsf0kpFvK8vx7WjoQaxUqPD3dYnKQgsyEcG05qbeEdTqlBUhTcjBj4WOldgb
         jM9FP5doZs0izYct+28qUk3Jp1eh0oaTNHPtZxhYq8xNZeiZlxrtQGvsYL2bO7RSgKSA
         EiKA==
X-Gm-Message-State: AO0yUKVL5GuPeLDtquuyGQqX30ljhGNUOu3n/SU/WwDd1fKvaQ1NRoz7
        YnPW8oTLYFiFVU8oLIGB7DQwXA==
X-Google-Smtp-Source: AK7set+Oe+Z/pGux9QGelWq+eQYgY04H3vqJ9vxdOS+0Ac1mT841bzismegHoIlBb0yW8bwOsbUPrw==
X-Received: by 2002:a17:902:e193:b0:19a:9890:eac6 with SMTP id y19-20020a170902e19300b0019a9890eac6mr4169728pla.24.1676311501634;
        Mon, 13 Feb 2023 10:05:01 -0800 (PST)
Received: from p14s ([2604:3d09:148c:c800:8b5:7925:cf2a:8bac])
        by smtp.gmail.com with ESMTPSA id k19-20020a170902761300b0019a87ede846sm4435273pll.285.2023.02.13.10.05.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 13 Feb 2023 10:05:01 -0800 (PST)
Date:   Mon, 13 Feb 2023 11:04:58 -0700
From:   Mathieu Poirier <mathieu.poirier@linaro.org>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "andersson@kernel.org" <andersson@kernel.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "arnaud.pouliquen@foss.st.com" <arnaud.pouliquen@foss.st.com>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-remoteproc@vger.kernel.org" <linux-remoteproc@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH V2 5/6] remoteproc: imx_rproc: set Cortex-M stack/pc to
 TCML
Message-ID: <20230213180458.GB310433@p14s>
References: <20230127092246.1470865-1-peng.fan@oss.nxp.com>
 <20230127092246.1470865-6-peng.fan@oss.nxp.com>
 <20230202215629.GC1147631@p14s>
 <DU0PR04MB9417620B668E43118933821388D79@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417620B668E43118933821388D79@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 03, 2023 at 12:04:27AM +0000, Peng Fan wrote:
> > Subject: Re: [PATCH V2 5/6] remoteproc: imx_rproc: set Cortex-M stack/pc
> > to TCML
> > 
> > On Fri, Jan 27, 2023 at 05:22:45PM +0800, Peng Fan (OSS) wrote:
> > > From: Peng Fan <peng.fan@nxp.com>
> > >
> > > The i.MX8M Cortex-M core not has ROM. It has a requirement is the
> > > stack, pc value should be set in address 0 and 4 from the view of
> > > itself. From Cortex-A core view, the region is at TCML start address.
> > >
> > > The stack and pc value are the first two words stored in section
> > > ".interrupts" of the firmware, and the section is the first section in
> > > the firmware.
> > >
> > > When the firmware is built to run in TCML, there is no issue, because
> > > when copying elf segments, the first two words are copied to TCML also.
> > >
> > > However when the firmware is built ro run in DDR, the first two words
> > > are not copied to TCML start address.
> > >
> > > This patch is to find the ".interrupts" section, read out the first
> > > two words and write to TCML start address at offset 0 and 4.
> > >
> > > Signed-off-by: Peng Fan <peng.fan@nxp.com>
> > > ---
> > >  drivers/remoteproc/imx_rproc.c | 37
> > > +++++++++++++++++++++++++++++++++-
> > >  1 file changed, 36 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/drivers/remoteproc/imx_rproc.c
> > > b/drivers/remoteproc/imx_rproc.c index 295e0e0e869a..f5ee0c9bb09d
> > > 100644
> > > --- a/drivers/remoteproc/imx_rproc.c
> > > +++ b/drivers/remoteproc/imx_rproc.c
> > > @@ -7,6 +7,7 @@
> > >  #include <linux/arm-smccc.h>
> > >  #include <linux/clk.h>
> > >  #include <linux/err.h>
> > > +#include <linux/firmware.h>
> > >  #include <linux/firmware/imx/sci.h>
> > >  #include <linux/interrupt.h>
> > >  #include <linux/kernel.h>
> > > @@ -23,6 +24,7 @@
> > >  #include <linux/workqueue.h>
> > >
> > >  #include "imx_rproc.h"
> > > +#include "remoteproc_elf_helpers.h"
> > >  #include "remoteproc_internal.h"
> > >
> > >  #define IMX7D_SRC_SCR			0x0C
> > > @@ -634,6 +636,39 @@ static struct resource_table
> > *imx_rproc_get_loaded_rsc_table(struct rproc *rproc
> > >  	return (struct resource_table __force *)priv->rsc_table;  }
> > >
> > > +static u64 imx_rproc_get_boot_addr(struct rproc *rproc, const struct
> > > +firmware *fw) {
> > > +	struct imx_rproc *priv = rproc->priv;
> > > +	const u8 *elf_data = (void *)fw->data;
> > > +	u8 class = fw_elf_get_class(fw);
> > > +	u64 bootaddr = rproc_elf_get_boot_addr(rproc, fw);
> > > +	const void *shdr;
> > > +	void __iomem *va;
> > > +	u64 sh_addr, offset;
> > > +
> > > +	if (priv->dcfg->devtype == IMX_RPROC_IMX8M) {
> > > +		/*
> > > +		 * i.MX8M Cortex-M requires [stack, pc] be put in address
> > > +		 * [0, 4], so the da address is 0, size is 8 words.
> > > +		 */
> > > +		va = (__force void __iomem *)rproc_da_to_va(rproc, 0, 8,
> > NULL);
> > > +		shdr = rproc_elf_find_shdr(rproc, fw, ".interrupts");
> > > +		if (!shdr || !va)
> > > +			return bootaddr;
> > > +		sh_addr = elf_shdr_get_sh_addr(class, shdr);
> > 
> > This isn't used - why is it still there?
> 
> will drop it.
> 
> > 
> > > +		offset = elf_shdr_get_sh_offset(class, shdr);
> > > +
> > > +		/*
> > > +		 * Write stack, pc to TCML start address. The TCML region
> > > +		 * is marked with ATT_IOMEM, so use writel.
> > > +		 */
> > > +		writel(*(u32 *)(elf_data + offset), va);
> > > +		writel(*(u32 *)(elf_data + offset + 4), va + 4);
> > 
> > Here you are writing 2 words at address 0x0 and 2 words at address 0x4.
> > Why are you saying the size is 8 words in the comment above?
> 
> Typo. I should mean 8 bytes.
>

How can I trust the code in this patchset when the "typo" is so obvious and
found in the comment above and 4 times in the changelog? 

> Thanks,
> Peng.
> 
> > 
> > > +	}
> > > +
> > > +	return bootaddr;
> > > +}
> > > +
> > >  static const struct rproc_ops imx_rproc_ops = {
> > >  	.prepare	= imx_rproc_prepare,
> > >  	.attach		= imx_rproc_attach,
> > > @@ -647,7 +682,7 @@ static const struct rproc_ops imx_rproc_ops = {
> > >  	.find_loaded_rsc_table = rproc_elf_find_loaded_rsc_table,
> > >  	.get_loaded_rsc_table = imx_rproc_get_loaded_rsc_table,
> > >  	.sanity_check	= rproc_elf_sanity_check,
> > > -	.get_boot_addr	= rproc_elf_get_boot_addr,
> > > +	.get_boot_addr	= imx_rproc_get_boot_addr,
> > >  };
> > >
> > >  static int imx_rproc_addr_init(struct imx_rproc *priv,
> > > --
> > > 2.37.1
> > >
