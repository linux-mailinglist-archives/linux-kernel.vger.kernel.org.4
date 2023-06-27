Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 93D9373FF71
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:15:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232281AbjF0POm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:14:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232067AbjF0POg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:14:36 -0400
Received: from mail-ej1-x62d.google.com (mail-ej1-x62d.google.com [IPv6:2a00:1450:4864:20::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF87B2D59;
        Tue, 27 Jun 2023 08:14:32 -0700 (PDT)
Received: by mail-ej1-x62d.google.com with SMTP id a640c23a62f3a-988a076a7d3so680456266b.3;
        Tue, 27 Jun 2023 08:14:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1687878871; x=1690470871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=oToC9jwkuaZE3Mgp12dfXgGs+LHa6pnKPaY9hlvQGdQ=;
        b=PSagK0wduJse94dOVuw/z0v5acVYUJuPR6bAmC7AteLruWD78teA0hy8F1pVKtZ1/f
         5rcEQ4FAXRues1K1Q/Ujw1Ox6DQe+oFV0bkP866fXjr8iqaHQskYSWCA8s7oY12sNAm2
         DFbx5ZtYKluXq/CU+8f8bWhu++oG69oE3vEAwBJyqICjrPI4zDZ+Vb2zkndEkVETKs54
         JqTnQzm/+v5IevepzSW/k3EkCg7ynw+RAB4VjI024hWaNfokXH1LDh3i3ZacnyV0O102
         n1VfYolJDvW8HGmWzF3nsOz6ar9yhlhzXzmXgxGzY5J64gD/nXZF21QB2ZiV6gLbgz7l
         7uyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687878871; x=1690470871;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=oToC9jwkuaZE3Mgp12dfXgGs+LHa6pnKPaY9hlvQGdQ=;
        b=hXSdnjdWoSIx1otaUn1mSEZUf1hBcwytGZiO5dP1pDNxASV3gY0v5JjIODim3su1kH
         CgTcGP7BW1T6/VWOh9cnAr2mNWHTgVcT7lQDhIwuvCLDmf1RFUS3rb6mUfcXsoZIyz5w
         8ljCMeXhIrDypJTeJ1ZyWvHmQdiAnpBvO4wNMgVLlOUA9uz1M5m6BfwGnkaOqlu+Yphe
         Z+Vx6SiWf/3zM6UBOl2HKGrM8sKrH0VlIOxqlb54EWnzQ84YORFmxc5Qpj/So7ZkraeW
         JHycGe/IsUiZu+T5CTQZNwAbs1DCteB5VzGH5VTa9CZvN7gdH2pFU5YFGc8ESncaWEJz
         uAng==
X-Gm-Message-State: AC+VfDx0rcGyEACMk5Ui1QeV2Eh6slFFVGecwP7frmvCbxd9suLzhf0O
        IAxvvXi3xE/7FJMwouEQBfs=
X-Google-Smtp-Source: ACHHUZ7WfhgwC7HCWL5CUPkJUS3shDwSxfhcYpEM1mWhnqALUI4ud+xgNKjBQcPVCoDzpZ1mKi1HeA==
X-Received: by 2002:a17:907:3e16:b0:978:a186:464f with SMTP id hp22-20020a1709073e1600b00978a186464fmr32048698ejc.39.1687878871105;
        Tue, 27 Jun 2023 08:14:31 -0700 (PDT)
Received: from tom-HP-ZBook-Fury-15-G7-Mobile-Workstation ([193.85.242.128])
        by smtp.gmail.com with ESMTPSA id z18-20020a1709067e5200b0096f7500502csm4630685ejr.199.2023.06.27.08.14.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 27 Jun 2023 08:14:30 -0700 (PDT)
Date:   Tue, 27 Jun 2023 17:14:29 +0200
From:   Tommaso Merciai <tomm.merciai@gmail.com>
To:     "Colin King (gmail)" <colin.i.king@gmail.com>
Cc:     Mauro Carvalho Chehab <mchehab@kernel.org>,
        linux-media@vger.kernel.org, kernel-janitors@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH][next] media: bt8xx: make read-only arrays static
Message-ID: <ZJr81Tg285kr4oEs@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
References: <20230627134851.728487-1-colin.i.king@gmail.com>
 <ZJr0WvhFfCILwbeP@tom-HP-ZBook-Fury-15-G7-Mobile-Workstation>
 <2b17acc9-44c3-acf6-0674-04a43aa742e0@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2b17acc9-44c3-acf6-0674-04a43aa742e0@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Coli,

On Tue, Jun 27, 2023 at 04:04:38PM +0100, Colin King (gmail) wrote:
> On 27/06/2023 15:38, Tommaso Merciai wrote:
> > Hi Colin,
> > 
> > On Tue, Jun 27, 2023 at 02:48:51PM +0100, Colin Ian King wrote:
> > > Don't populate the arrays on the stack, instead make them static const.
> > > Also add spaces between values to clean up checkpatch style warnings.
> > > 
> > > Signed-off-by: Colin Ian King <colin.i.king@gmail.com>
> > > ---
> > >   drivers/media/pci/bt8xx/dvb-bt8xx.c | 12 ++++++++----
> > >   1 file changed, 8 insertions(+), 4 deletions(-)
> > > 
> > > diff --git a/drivers/media/pci/bt8xx/dvb-bt8xx.c b/drivers/media/pci/bt8xx/dvb-bt8xx.c
> > > index 4cb890b949c3..df83b59a618d 100644
> > > --- a/drivers/media/pci/bt8xx/dvb-bt8xx.c
> > > +++ b/drivers/media/pci/bt8xx/dvb-bt8xx.c
> > > @@ -190,11 +190,15 @@ static int cx24108_tuner_set_params(struct dvb_frontend *fe)
> > >   	u32 freq = c->frequency;
> > >   	int i, a, n, pump;
> > >   	u32 band, pll;
> > > -	u32 osci[]={950000,1019000,1075000,1178000,1296000,1432000,
> > > -		1576000,1718000,1856000,2036000,2150000};
> > > -	u32 bandsel[]={0,0x00020000,0x00040000,0x00100800,0x00101000,
> > > +	static const u32 osci[] = {
> > > +		950000, 1019000, 1075000, 1178000, 1296000, 1432000,
> > > +		1576000, 1718000, 1856000, 2036000, 2150000
> > > +	};
> > > +	static const u32 bandsel[] = {
> > > +		0, 0x00020000, 0x00040000, 0x00100800, 0x00101000,
> > >   		0x00102000,0x00104000,0x00108000,0x00110000,
+			0x00102000, 0x00104000, 0x00108000, 0x00110000,

ERROR: space required after that ',' (ctx:VxV)
#199: FILE: drivers/media/pci/bt8xx/dvb-bt8xx.c:199:
+		0x00102000,0x00104000,0x00108000,0x00110000,

I'm wrong?

Regards,
Tommaso

> > 
> > Are you not missing space also here?
> 
> I can't see the space you are referring to.
> 
> > 
> > > -		0x00120000,0x00140000};
> > > +		0x00120000, 0x00140000
> > > +	};
> > >   	#define XTAL 1011100 /* Hz, really 1.0111 MHz and a /10 prescaler */
> > >   	dprintk("cx24108 debug: entering SetTunerFreq, freq=%d\n", freq);
> > > -- 
> > > 2.39.2
> > > 
> > 
> > Regards,
> > Tommaso
> 
