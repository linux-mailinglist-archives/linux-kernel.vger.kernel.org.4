Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A360C714A4B
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 15:26:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjE2N0a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 09:26:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbjE2N0X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 09:26:23 -0400
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0BB490;
        Mon, 29 May 2023 06:26:21 -0700 (PDT)
Received: by mail-ed1-x535.google.com with SMTP id 4fb4d7f45d1cf-5149390b20aso3320667a12.3;
        Mon, 29 May 2023 06:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1685366780; x=1687958780;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date:from:to
         :cc:subject:date:message-id:reply-to;
        bh=EX1ilL83JpLshMr1K5JB/BahD2eO1CjMyvCad0QLW6o=;
        b=kyHpuNqGP96tFxdR4vrmOnmeIVHVyFkvbBm2q0euy8neUfLNdNc/yC1VygKs1YODoN
         nkAE993WC/0ZpHrAUJQildOPzawlDIZzfv7LA0MK6MNUT9a16OmERLfV5khcEl9dydGF
         Lu/WUEKvM38PvK5QmbLDZ63mZ5Nk5B99SqOKye8W5ZuT7K235TDDS0qhCwUHngjfbewN
         s2EjO5ZrX+WxAeCKVZMdHjRNyzL8UUve1Al5BK4cpx6lZ23NNijEVOuu6r4njffsmUWi
         MdonxPvCsOReH4bfQYKG1X86kDYA4Q9kULbZn2uzDSeMFS9vyUjnFFUNCPCjLTlpV8SE
         1KZA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685366780; x=1687958780;
        h=in-reply-to:content-transfer-encoding:content-disposition
         :mime-version:references:message-id:subject:cc:to:from:date
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=EX1ilL83JpLshMr1K5JB/BahD2eO1CjMyvCad0QLW6o=;
        b=BzDO5PTKNLRUTYO4dXzBEXs6jxb/xQ6m1OPV6yt+3JUw5EQVV/YTpmy4bey+4CLNGt
         QWIgu2P2K/ntn8xtAeqwR4oi1aGS9xQYbb7M3NmvR9WXoBw/QmN5YIPA2foK3HdXTrX9
         C8C3dpOQIqxt/gAQOMqrEBSf9RxDri67Q+fDWuW6IPNF0eD+iGRo7vMLQ0QvNpbmWCjk
         zRJMmVrkOojn1XX+LCa07aKCzvm/IOqZ8pP9ysVD7u3LUpdfGrV9fO7o7/HBAEHiV2fk
         n8uCi2SsWgDzpLfL3xsRKWhC/chAOkPKMkTIn21lZQ6xnwGX7LeKa4NdJCb+oKDxQzwl
         ULLQ==
X-Gm-Message-State: AC+VfDz/Sbje7gAbiGaSQZCt45zMFGv+XmTxL7WZMy1944wQryJtyMGI
        pxxnRnX/KhItbhAFSce8XqA=
X-Google-Smtp-Source: ACHHUZ5QWhLEZ8fszHHUBzA+HPiovj79n4c3hZoTN9OZK0JE2KK9DiirMjtPqSH44Cx8GunaqtlMYg==
X-Received: by 2002:a50:fa81:0:b0:514:a655:d240 with SMTP id w1-20020a50fa81000000b00514a655d240mr729060edr.21.1685366779878;
        Mon, 29 May 2023 06:26:19 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation (net-188-217-50-121.cust.vodafonedsl.it. [188.217.50.121])
        by smtp.gmail.com with ESMTPSA id c17-20020aa7c751000000b0050bc4eb9846sm3098756eds.1.2023.05.29.06.26.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 May 2023 06:26:19 -0700 (PDT)
Date:   Mon, 29 May 2023 15:26:17 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     Christophe JAILLET <christophe.jaillet@wanadoo.fr>
Cc:     jacopo.mondi@ideasonboard.com, laurent.pinchart@ideasonboard.com,
        martin.hecht@avnet.eu, linuxfancy@googlegroups.com,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Hans Verkuil <hverkuil@xs4all.nl>,
        Marco Felsch <m.felsch@pengutronix.de>,
        Gerald Loacker <gerald.loacker@wolfvision.net>,
        Nicholas Roth <nicholas@rothemail.net>,
        Shawn Tu <shawnx.tu@intel.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Benjamin Mugnier <benjamin.mugnier@foss.st.com>,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org
Subject: Re: [PATCH v2 2/2] media: i2c: Add support for alvium camera
Message-ID: <ZHSn+UJt+3DQ6KNc@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230526173955.797226-1-tomm.merciai@gmail.com>
 <20230526173955.797226-3-tomm.merciai@gmail.com>
 <8563d09d-fa63-43e3-98a9-8008d53034aa@wanadoo.fr>
 <ZHR5qup6412nLgzz@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <7aaa6abc-09a7-7be5-9184-6cd7d702baf2@wanadoo.fr>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <7aaa6abc-09a7-7be5-9184-6cd7d702baf2@wanadoo.fr>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Cristophe,

On Mon, May 29, 2023 at 02:34:09PM +0200, Christophe JAILLET wrote:
> Le 29/05/2023 à 12:08, Tommaso Merciai a écrit :
> 
> > > > +	int avail_fmt_cnt = 0;
> > > > +
> > > > +	alvium->alvium_csi2_fmt = NULL;
> > > > +
> > > > +	/* calculate fmt array size */
> > > > +	for (fmt = 0; fmt < ALVIUM_NUM_SUPP_MIPI_DATA_FMT; fmt++) {
> > > > +		if (alvium->is_mipi_fmt_avail[alvium_csi2_fmts[fmt].fmt_av_bit]) {
> > > > +			if (!alvium_csi2_fmts[fmt].is_raw) {
> > > > +				sz++;
> > > > +			} else if (alvium_csi2_fmts[fmt].is_raw &&
> > > > +			      alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit]) {
> > > 
> > > It is makes sense, this if/else looks equivalent to:
> > > 
> > > 			if (!alvium_csi2_fmts[fmt].is_raw ||
> > > 			    alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit]) {
> > > 				sz++;
> > > 
> > > The same simplification could also be applied in the for loop below.
> > 
> > I Don't agree on this.
> > This is not a semplification.
> > This change the logic of the statement.
> > 
> 
> Hmmm, unless I missed something obvious, I don't think it changes the logic.
> 
> Let me detail my PoV.
> 
> The original code is, for the inner if:
> 
> +	if (!alvium_csi2_fmts[fmt].is_raw) {
> +		sz++;
> +	} else if (alvium_csi2_fmts[fmt].is_raw &&
> +	      alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit]) {
> +		sz++;
> +	}
> 
> So both branchs end to sz++, so it can be written:
> 
> +	if ((!alvium_csi2_fmts[fmt].is_raw) ||
> +	    (alvium_csi2_fmts[fmt].is_raw &&
> +	      alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit])) {
> +		sz++;
> +	}
> 
> A || (!A && B) is equivalent to A || B, so it can be rewritten as:
> 
> +	if ((!alvium_csi2_fmts[fmt].is_raw) ||
> +	    (alvium->is_bay_avail[alvium_csi2_fmts[fmt].bay_av_bit])) {
> +		sz++;
> +	}
> 
> > Also initialization of sz and avail_fmt_cnt is needed.
> > Maybe I can include fmt variable initialization into the for loop:
> 
> Agreed. I must have been unclear.
> I was only speaking about the *inner* 'if', not the whole block of code.

Mb, got it now.
Thanks for the explanation! :)

> 
> > 
> > for (int fmt = 0; fmt < ALVIUM_NUM_SUPP_MIPI_DATA_FMT; fmt++) {
> > 
> > But from my perspective this seems clear.
> 
> I fully agree with you, but that was not my point.
> 
> 
> > > > +struct alvium_pixfmt {
> > > > +	u8 id;
> > > > +	u32 code;
> > > > +	u32 colorspace;
> > > > +	u8 fmt_av_bit;
> > > > +	u8 bay_av_bit;
> > > > +	u64 mipi_fmt_regval;
> > > > +	u64 bay_fmt_regval;
> > > > +	u8 is_raw;
> > > 
> > > If moved a few lines above, there would be less holes in the struct.
> > 
> > ?
> 
> This is more or less the same comment that you got from Laurent Pinchart.
> 
> Using pahole on your struct, as-is, gives:
> 
> struct alvium_pixfmt {
> 	u8                         id;                   /*     0     1 */
> 
> 	/* XXX 3 bytes hole, try to pack */
> 
> 	u32                        code;                 /*     4     4 */
> 	u32                        colorspace;           /*     8     4 */
> 	u8                         fmt_av_bit;           /*    12     1 */
> 	u8                         bay_av_bit;           /*    13     1 */
> 
> 	/* XXX 2 bytes hole, try to pack */
> 
> 	u64                        mipi_fmt_regval;      /*    16     8 */
> 	u64                        bay_fmt_regval;       /*    24     8 */
> 	u8                         is_raw;               /*    32     1 */
> 
> 	/* size: 40, cachelines: 1, members: 8 */
> 	/* sum members: 28, holes: 2, sum holes: 5 */
> 	/* padding: 7 */
> 	/* last cacheline: 40 bytes */
> };
> 
> If you change the order of some fields, you can get, *for example*:
> 
> struct alvium_pixfmt {
> 	u8                         id;                   /*     0     1 */
> 	u8                         is_raw;               /*     1     1 */
> 	u8                         fmt_av_bit;           /*     2     1 */
> 	u8                         bay_av_bit;           /*     3     1 */
> 	u32                        code;                 /*     4     4 */
> 	u32                        colorspace;           /*     8     4 */
> 
> 	/* XXX 4 bytes hole, try to pack */
> 
> 	u64                        mipi_fmt_regval;      /*    16     8 */
> 	u64                        bay_fmt_regval;       /*    24     8 */
> 
> 	/* size: 32, cachelines: 1, members: 8 */
> 	/* sum members: 28, holes: 1, sum holes: 4 */
> 	/* last cacheline: 32 bytes */
> };
> 
> Now the whole structure require 32 bytes instead of 40, because their are
> less holes in it.
> And "rounding" in the memory allocation layer would finally allocate 64
> bytes. So moving some fields would half (32 vs 64) the memory used!
> 
> But, the main point is to keep a layout that is logical to you. So up to you
> to re-arrange the struct or not.
> 
> (the same applies to some other struct in your patch)

Thanks for the explanation.
I will keep in mind this! :)

Regards,
Tommaso

> 
> CJ
