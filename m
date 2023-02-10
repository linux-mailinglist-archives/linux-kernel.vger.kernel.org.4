Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1F0B692B2A
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 00:30:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229754AbjBJXan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Feb 2023 18:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbjBJXal (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Feb 2023 18:30:41 -0500
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA7291B564;
        Fri, 10 Feb 2023 15:30:39 -0800 (PST)
Received: by mail-pl1-x62e.google.com with SMTP id m2so8270622plg.4;
        Fri, 10 Feb 2023 15:30:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:from:to:cc:subject:date
         :message-id:reply-to;
        bh=tEj/ZRqPDHV3euzaw9BypxOqQolHXZURobYLo7ytqXI=;
        b=k6bTErh6BD3tS2w9e8Y+lmT5iUB/rtXLoMAdR6LQzp/Hj0e8QI0Doow4kLuhK/WVgD
         EEhawPGKaxLdC1cWeVTpWQ366TQHM9kxQdfoBTFb8tKkvKgat540Zwf86/3PxIQnLaKc
         ZxnB5LgADmHaXuFnIC8qZk9RdoX+8AaOxk33PGVjllCKwNssPXtXUtDsPDha4+gHOKOB
         HU/vHVagW/39wK2GwRnko1YXPQzur36hnYF2VqKM9BN9JtJYyzjzRUy8yVoq8tWe0C6A
         pRjr5rFimvBwWTcr7VUz1wiUYak6x+b3yr1l0EVG7v9wJc0EFvnlbIL5+7jgznUeZOz/
         RFVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:subject:cc:to:from:date:x-gm-message-state:from:to:cc
         :subject:date:message-id:reply-to;
        bh=tEj/ZRqPDHV3euzaw9BypxOqQolHXZURobYLo7ytqXI=;
        b=wFm/ji7V3TvdVFeyVEKeS4MzCUawgXd/qCQjl2tGK1EgO8dO+ii7J0NCnhzhpAWlJZ
         nGfNRTlfE977Zm7xYTOZnMvEREMBTyLeaDEYNs+72Y63xcfXSLBjGXpxoBHRAFiEGm6T
         nwt1mAGXwe8Yo2r6lcOaiL+oT66dt4lZ44B3kBA6DiPz+x7L9dUyhrr8Rw9VQm8xch/F
         /9aUCTZ2dT2FLVKpsYMJv9VdWy5F1EKA3mjWD4xHCCM3qU/29yQPpgHqhncPO8+9knHv
         +qhQHyjlekjcCbWKL2UeWUJ24j79Ydpl+hfpC0ikCW2U5PK42VhnQn1GUgv8myy5GTgy
         oaNg==
X-Gm-Message-State: AO0yUKUh4wAMJLKlnOUljEC2WlRedl07TxURGeBHqWET8QdQ4WD15ti1
        y3LpYcvLanqVVo5D5MbMBZc=
X-Google-Smtp-Source: AK7set/cBhHgTRDkorSIdrM2NOdlYlVW66+6n2lvyjBtTHp7SCfKc/citVEd3wdFWlNuqWSayBvocg==
X-Received: by 2002:a05:6a21:2c8b:b0:bf:1b09:5cda with SMTP id ua11-20020a056a212c8b00b000bf1b095cdamr13393488pzb.12.1676071839038;
        Fri, 10 Feb 2023 15:30:39 -0800 (PST)
Received: from redecorated-mbp ([202.53.32.211])
        by smtp.gmail.com with ESMTPSA id h6-20020a63b006000000b0049f5da82b12sm3456028pgf.93.2023.02.10.15.30.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Feb 2023 15:30:38 -0800 (PST)
Date:   Sat, 11 Feb 2023 10:30:24 +1100
From:   Orlando Chamberlain <orlandoch.dev@gmail.com>
To:     Hans de Goede <hdegoede@redhat.com>
Cc:     platform-driver-x86@vger.kernel.org, amd-gfx@lists.freedesktop.org,
        linux-kernel@vger.kernel.org, alsa-devel@alsa-project.org,
        Alex Deucher <alexander.deucher@amd.com>,
        Christian =?UTF-8?B?S8O2bmln?= <christian.koenig@amd.com>,
        "Pan, Xinhui" <Xinhui.Pan@amd.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Mark Gross <markgross@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Hawking Zhang <Hawking.Zhang@amd.com>,
        Andrey Grodzovsky <andrey.grodzovsky@amd.com>,
        Lijo Lazar <lijo.lazar@amd.com>,
        YiPeng Chai <YiPeng.Chai@amd.com>,
        Somalapuram Amaranath <Amaranath.Somalapuram@amd.com>,
        Mario Limonciello <mario.limonciello@amd.com>,
        Bokun Zhang <Bokun.Zhang@amd.com>,
        Jack Xiao <Jack.Xiao@amd.com>,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Amadeusz =?UTF-8?B?U8WCYXdpxYRza2k=?= 
        <amadeuszx.slawinski@linux.intel.com>,
        Yong Zhi <yong.zhi@intel.com>, Evan Quan <evan.quan@amd.com>,
        Kerem Karabay <kekrby@gmail.com>,
        Aditya Garg <gargaditya08@live.com>,
        Aun-Ali Zaidi <admin@kodeit.net>
Subject: Re: [RFC PATCH 1/9] apple-gmux: use cpu_to_be32 instead of manual
 reorder
Message-ID: <20230211103024.2a204487@redecorated-mbp>
In-Reply-To: <74e3c9ae-b1f1-1e7b-4af1-56f918471b36@redhat.com>
References: <20230210044826.9834-1-orlandoch.dev@gmail.com>
        <20230210044826.9834-2-orlandoch.dev@gmail.com>
        <3af65b5e-1f52-79f6-4130-03901ce76d2f@redhat.com>
        <74e3c9ae-b1f1-1e7b-4af1-56f918471b36@redhat.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.35; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 10 Feb 2023 20:19:27 +0100
Hans de Goede <hdegoede@redhat.com> wrote:

> Hi,
> 
> On 2/10/23 20:09, Hans de Goede wrote:
> > Hi,
> > 
> > On 2/10/23 05:48, Orlando Chamberlain wrote:  
> >> Currently it manually flips the byte order, but we can instead use
> >> cpu_to_be32(val) for this.
> >>
> >> Signed-off-by: Orlando Chamberlain <orlandoch.dev@gmail.com>
> >> ---
> >>  drivers/platform/x86/apple-gmux.c | 18 ++----------------
> >>  1 file changed, 2 insertions(+), 16 deletions(-)
> >>
> >> diff --git a/drivers/platform/x86/apple-gmux.c
> >> b/drivers/platform/x86/apple-gmux.c index
> >> 9333f82cfa8a..e8cb084cb81f 100644 ---
> >> a/drivers/platform/x86/apple-gmux.c +++
> >> b/drivers/platform/x86/apple-gmux.c @@ -94,13 +94,7 @@ static u32
> >> gmux_pio_read32(struct apple_gmux_data *gmux_data, int port)
> >> static void gmux_pio_write32(struct apple_gmux_data *gmux_data,
> >> int port, u32 val) {
> >> -	int i;
> >> -	u8 tmpval;
> >> -
> >> -	for (i = 0; i < 4; i++) {
> >> -		tmpval = (val >> (i * 8)) & 0xff;
> >> -		outb(tmpval, gmux_data->iostart + port + i);
> >> -	}
> >> +	outl(cpu_to_be32(val), gmux_data->iostart + port);
> >>  }
> >>  
> >>  static int gmux_index_wait_ready(struct apple_gmux_data
> >> *gmux_data)  
> > 
> > The ioport / indexed-ioport accessed apple_gmux-es likely are (part
> > of?) LPC bus devices . Looking at the bus level you are now
> > changing 4 io accesses with a size of 1 byte, to 1 32 bit io-access.
> > 
> > Depending on the decoding hw in the chip this may work fine,
> > or this may work not at all.
> > 
> > I realized that you have asked for more testing, but most surviving
> > macbooks from the older apple-gmux era appear to be models without
> > a discrete GPU (which are often the first thing to break) and thus
> > without a gmux.
> > 
> > Unless we get a bunch of testers to show up, which I doubt. I would
> > prefer slightly bigger / less pretty code and not change the
> > functional behavior of the driver on these older models.  
> 
> A quick follow up on this, I just noticed that only the pio_write32
> is doing the one byte at a time thing:
> 
> static u32 gmux_pio_read32(struct apple_gmux_data *gmux_data, int
> port) {
>         return inl(gmux_data->iostart + port);
> }
> 
> static void gmux_pio_write32(struct apple_gmux_data *gmux_data, int
> port, u32 val)
> {
>         int i;
>         u8 tmpval;
> 
>         for (i = 0; i < 4; i++) {
>                 tmpval = (val >> (i * 8)) & 0xff;
>                 outb(tmpval, gmux_data->iostart + port + i);
>         }
> }
> 
> And if you look closely gmux_pio_write32() is not swapping
> the order to be32 at all, it is just taking the bytes
> in little-endian memory order, starting with the first
> (index 0) byte which is the least significant byte of
> the value.
> 
> On x86 the original code is no different then doing:
> 
> static void gmux_pio_write32(struct apple_gmux_data *gmux_data, int
> port, u32 val)
> {
>         u8 *data = (u8 *)&val;
>         int i;
> 
>         for (i = 0; i < 4; i++)
>                 outb(data[i], gmux_data->iostart + port + i);
> }
> 
> So yeah this patch is definitely wrong, it actually swaps
> the byte order compared to the original code. Which becomes
> clear when you look the weird difference between the read32 and
> write32 functions after this patch.
> 
> Presumably there is a specific reason why gmux_pio_write32()
> is not already doing a single outl(..., val) and byte-ordering
> is not the reason.
> 
> Regards,
> 
> Hans

Sounds like it may be better to just drop this patch as there's very
little benefit for the risk of causing a regression.

> 
> 
> 
> >> @@ -177,16 +171,8 @@ static u32 gmux_index_read32(struct
> >> apple_gmux_data *gmux_data, int port) static void
> >> gmux_index_write32(struct apple_gmux_data *gmux_data, int port,
> >> u32 val) {
> >> -	int i;
> >> -	u8 tmpval;
> >> -
> >>  	mutex_lock(&gmux_data->index_lock);
> >> -
> >> -	for (i = 0; i < 4; i++) {
> >> -		tmpval = (val >> (i * 8)) & 0xff;
> >> -		outb(tmpval, gmux_data->iostart + GMUX_PORT_VALUE
> >> + i);
> >> -	}
> >> -
> >> +	outl(cpu_to_be32(val), gmux_data->iostart +
> >> GMUX_PORT_VALUE); gmux_index_wait_ready(gmux_data);
> >>  	outb(port & 0xff, gmux_data->iostart + GMUX_PORT_WRITE);
> >>  	gmux_index_wait_complete(gmux_data);  
> >   
> 

