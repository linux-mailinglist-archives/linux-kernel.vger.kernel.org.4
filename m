Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C0AAA6C35E9
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Mar 2023 16:40:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229510AbjCUPkO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Mar 2023 11:40:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231745AbjCUPkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Mar 2023 11:40:08 -0400
Received: from mail-ed1-x534.google.com (mail-ed1-x534.google.com [IPv6:2a00:1450:4864:20::534])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5E0ECDC5;
        Tue, 21 Mar 2023 08:39:52 -0700 (PDT)
Received: by mail-ed1-x534.google.com with SMTP id r11so61380769edd.5;
        Tue, 21 Mar 2023 08:39:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679413191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=BhRZzo5W5WK8rOEY4/wWhz0Z25jZKpybh9lftHazrOY=;
        b=dz4AaUSlrc9QHJVsxQwyOK89Wg/88c/tWfVcBQ1FBqTNRP3iaDFV/AnUmnK+fOlZk0
         EuMdbwd4TfKHefG9RNySVHg3KlLmt2kco77Rsb43jZDZidBXmGlFY5eZQTl+0c98qiIK
         jXon0sRa1QmMO88Ng8wQ3WPDd7SCWGw2QEdqWLZnakJFaPFNhyCwddsOmtHe0+OWjsX6
         cmHo1dh4aXAV6ENdTweYf++5hO99drrJUsY9Nk+PLb6eYZh0UnaFSrBDz8I7Z8udJVX+
         d5BlKmUGQPh6OTJ6CpQ1FdpF/IWii7bueoQWXrepepqZ9XhQrViW6jOn+JZU6lPA4dtW
         V3QQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679413191;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=BhRZzo5W5WK8rOEY4/wWhz0Z25jZKpybh9lftHazrOY=;
        b=eY/rpkpfkEwk+yZ3594CJyAIx7uR6GvkfYDlv13ZzIUI2+V6IBDdLIq/0CHMgYCe7N
         rL0v4R6Y16lETOnqMS7r6Vk+NQV2ajQxkUedh4nyQXcI9Bt3TSp11mg7vz2TbUqHCb4i
         jHmDC1UiOSB+SdLo8Ak+K/IOqc7xkMNnymYCOA63jqD0Z7ruqZ6cReOozyqU6cL9vzdM
         rB+6bwJLCxjplc87h4OsmTD4Gdu8mYElv6ig9ydYvCI2nAb3BaS+/YbryLbk0gkB+0Ag
         MFkTru+3IeixhXxNcec9nsIPC5eBLVxl1TR/QEJR9o3mwgThy/PY2bKVUkF/PZ7hSWgZ
         SjCQ==
X-Gm-Message-State: AO0yUKXTV4utQ6JG33o6a/Nb4zbkBAF4zLAhaSp5MqDrVeOtA/9d6G68
        ySQJiSHxEQksId28OOjcMXo=
X-Google-Smtp-Source: AK7set8HLx0/mEzJWBsqBV5pb0VvpamUPod+26AlLqMhFMCfCBFkCekgexGZENXwkv7igsMt49RJFA==
X-Received: by 2002:a17:906:2449:b0:91f:b13f:a028 with SMTP id a9-20020a170906244900b0091fb13fa028mr3356477ejb.34.1679413191230;
        Tue, 21 Mar 2023 08:39:51 -0700 (PDT)
Received: from carbian ([2a02:8109:aa3f:ead8::a9c0])
        by smtp.gmail.com with ESMTPSA id m17-20020a17090607d100b0093a768b3dddsm515516ejc.216.2023.03.21.08.39.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 21 Mar 2023 08:39:50 -0700 (PDT)
Date:   Tue, 21 Mar 2023 16:39:48 +0100
From:   Mehdi Djait <mehdi.djait.k@gmail.com>
To:     Jonathan Cameron <Jonathan.Cameron@huawei.com>
Cc:     Matti Vaittinen <mazziesaccount@gmail.com>,
        Jonathan Cameron <jic23@kernel.org>,
        krzysztof.kozlowski+dt@linaro.org,
        andriy.shevchenko@linux.intel.com, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 2/3] iio: accel: kionix-kx022a: Add chip_info structure
Message-ID: <ZBnPxCNjZ1PKTdbr@carbian>
References: <cover.1679009443.git.mehdi.djait.k@gmail.com>
 <3ddca10a4c03c3a64afb831cc9dd1e01fe89d305.1679009443.git.mehdi.djait.k@gmail.com>
 <20230319162030.318918b8@jic23-huawei>
 <3d4da08a-d3aa-91d7-0a9d-a6bc2ee87927@gmail.com>
 <20230320122447.000025da@Huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230320122447.000025da@Huawei.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello everyone,

On Mon, Mar 20, 2023 at 12:24:47PM +0000, Jonathan Cameron wrote:
> On Mon, 20 Mar 2023 09:17:54 +0200
> Matti Vaittinen <mazziesaccount@gmail.com> wrote:
> 
> > Hi Mehdi and Jonathan,
> > 
> > Just my take on couple of comments from Jonathan :) I still have my own 
> > review to do though...
> > 
> > On 3/19/23 18:20, Jonathan Cameron wrote:
> > > On Fri, 17 Mar 2023 00:48:36 +0100
> > > Mehdi Djait <mehdi.djait.k@gmail.com> wrote:
> > >   
> > >> Refactor the kx022a driver implementation to make it more
> > >> generic and extensible.
> > >> Add the chip_info structure will to the driver's private
> > >> data to hold all the device specific infos.
> > >> Move the enum, struct and constants definitions to the header
> > >> file.  
> > > 
> > > You also introduce an i2c_device_id table
> > > 
> > > Without that I think module autoloading will be broken anyway so that's
> > > definitely a good thing to add.  
> > 
> > I am pretty sure the autoloading worked for OF-systems. But yes, adding 
> > the i2c_device_id is probably a good idea. Thanks.
> 
> Ah. Maybe that issue only occurred for SPI - I'd assumed it was more general.
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/drivers/?id=5fa6863ba692
> 
> > 
> > > A few comments inline.  Mostly around reducing the name changes.
> > > Wild cards (or simply shorted 'generic' prefixes like KX_)
> > > almost always bite back in the long run.  Hence we generally just try
> > > to name things after the first device that they were relevant to.  
> > 
> > I must say I disagree on this with you Jonathan. I know wildcards tend 
> > to get confusing - but I still like the idea of showing which of the 
> > definitions are IC specific and which ones are generic or at least used 
> > by more than one variant - especially as long as we only have two 
> > supported ICs. I definitely like the macro naming added by Mehdi. This 
> > approach has been very helpful for me for example in the BD718x7 
> > (BD71837/BD71847/BD71850) PMIC driver. My take on this is:
> > 
> > 1) I like the generic KX_define.
> 
> We already have other kionix drivers that don't use these defines.
> This is less of an issue if they are very local - so pushed down to the C file,
> but I still don't like the implication that they extend to a broad range of
> devices.
> 
> > 2) I would not try adding wildcards like KX_X22 - to denote support for 
> > 122 and 022 - while not supporting 132 - in my experience - that won't 
> > scale.
> 
> I think this already runs into this problem or at least sets the driver
> up to hit it very soon. The reality is that these definitions are shared
> by the 2 parts supported so far.  3rd part comes along and I'd be willing
> to place a bet that at least one of these definitions doesn't apply.
> So we end up with a mess converting it back to a specific name.
> 
> I've gone down this path many times before and it very rarely works out.
> 
> > 3) I definitely like the idea of using exact model number prefix for 
> > 'stuff' which is intended to work only on one exact .
> 
> When you have 2 devices it is easy to separate the 'generic' from the
> 'specific'.  That breaks when you have 3. If we are sure there won't be
> a 3rd device supported by this driver then fair enough...
> 
> > 
> > Regarding the 3) - I am not so strict on how the register/mask defines 
> > are handled - I _like_ the 1) 2) 3) approach above - but mask/register 
> > defines tend to get set (correctly) once and not required to be looked 
> > up after this. But. When the 'stuff' is functions - this gets very 
> > useful as one is very often required to see which functions are executed 
> > on which IC variant. Same goes to structs.
> 
> Given they tend to be accessed via a function pointer, even functions
> are only set up the once.  For these I'm fine with a nasty listing
> type approach with multiple part names in the function defintion.
> That doesn't scale great either as lots of parts get added but it at least
> calls out which function covers which parts.
> 
> > 
> > So, if we manage to convince Jonathan about the naming, then I like what 
> > yoo had here! I would hovever do it in two steps. I would at first do 
> > renaming patch where the generic defines were renamed - without any 
> > functional changes - and only then add the kx132 stuff in a subsequent 
> > patch. That would simplify seeing which changes are just renaming and 
> > which are functional ones.
> > 
> > But here, I must go with the wind - if subsystem maintainer says the 
> > code should not have naming like this - then I have no say over it... :/
> 
> If we have truely universal defines - sometimes this happens for WHO AM I 
> registers for example as they are the same over all devices from a manufacturer
> (more or less anyway) then the broad forms are fine.  Otherwise it just tends
> to end up as a mess if lots of parts added.

I will remove the generic defines. 

I also really liked the idea of seperating the IC specific stuff from the 
generic ones. Better play it safe here, I can also see it becoming a mess in
the long run. 

> > 
> > >>   
> > >> +static const struct i2c_device_id kx022a_i2c_id[] = {
> > >> +	{ .name = "kx022a", .driver_data = (kernel_ulong_t)&kx_chip_info[KX022A] },  
> > > If there are a small set and we aren't ever going to index the chip_info structure
> > > we might be better off not bothering with the enum and instead using a separate
> > > instance of the structure for each chip.
> > >   
> > 
> > I kind of like also the table added by Mehdi. I admit I was at first 
> > just thinking that we should have a pointer to the struct here without 
> > any tables - but... After I took a peek in the kionix-kx022a.c - I kind 
> > of liked the table and not exporting the struct names. So, I don't have 
> > a strong opinion on this.
> > 
> > I think it's worth noting that this driver could (maybe easily enough) 
> > be extended to support also a few other kionix accelerometers. Maybe, if 
> > we don't scare Mehdi away, we will see a few other variants supported as 
> > well ;)
> 
> This one wasn't a particularly important bit of feedback. I'm fine with the
> table, though seems slightly less readable to my eyes.

My reasoning behind it: when supporting multiple devices, having a single
array of chip_info and one single EXPORT_SYMBOL is more concise and
readable. 

> 
> > 
> > >>   	data->regmap = regmap;
> > >>   	data->dev = dev;
> > >>   	data->irq = irq;
> > >> -	data->odr_ns = KX022A_DEFAULT_PERIOD_NS;
> > >> +	data->odr_ns = KX_DEFAULT_PERIOD_NS;
> > >>   	mutex_init(&data->mutex);
> > >>   
> > >> -	idev->channels = kx022a_channels;
> > >> -	idev->num_channels = ARRAY_SIZE(kx022a_channels);
> > >> -	idev->name = "kx022-accel";  
> > > 
> > > Ah. Missed this naming in original driver review.  We only normally
> > > postfix with accel in devices that have multiple sensors with separate
> > > drivers. Don't think that is true of the kx022a.  
> > 
> > Ouch. I am not 100% sure but may be you didn't miss it. It may be I just 
> > missed fixing this because your comment here sounds somewhat familiar to 
> > me! (Or then you commented on suffix in driver-name).
> 
> Meh. This stuff happens and at the end of the day it's a magic string
> that userspace can match against.  No userspace knows all of them anyway
> so most likely it's just provided in a 'selection' box for a user or encoded
> in a custom script / config file.  So not hugely important for it to have
> the simplest possible form.
> 
> > 
> > > It's ABI so we are stuck with it, but avoid repeating that issue
> > > for new devices. >  

I will change the name in the chip_info of kx022a back to "kx022-accel"

I am already using "kx132" as name for the newly supported device

> > 
> > >>   
> > >> +enum kx022a_device_type {
> > >> +	KX022A,
> > >> +};  
> > > 
> > > As below. I'd avoid using the enum unless needed.
> > > That can make sense where a driver supports lots of devices but I don't think
> > > it does here.  
> > 
> > Well, I know it is usually not too clever to be prepared for the future 
> > stuff too well. But - I don't think the enum and table are adding much 
> > of complexity? I am saying this as I think this driver could be extended 
> > to support also kx022 (without the A), kx023, kx122. I've also seen some 
> > references to model kx022A-120B (but I have no idea what's the story 
> > there or if that IC is publicly available). Maybe Mehdi would like to 
> > extend this driver further after the KX132 is done ;)

Yes, my goal is to support more devices and I want to make as easy as 
possible to extend this driver :)

> 
> Not adding a lot, but you are going to end up with adding one line
> to an enum in the header for each new device, vs one
> extern line.  So I'm not sure it saves anything either.
> 

Using a separate instance of the chip_info structure for each chip means
also an extra symbol export

> > 
> > >> -int kx022a_probe_internal(struct device *dev);
> > >> -extern const struct regmap_config kx022a_regmap;
> > >> +struct kx022a_chip_info {
> > >> +	const char *name;
> > >> +	enum kx022a_device_type type;
> > >> +	const struct regmap_config *regmap_config;
> > >> +	const struct iio_chan_spec *channels;
> > >> +	unsigned int num_channels;
> > >> +	unsigned int fifo_length;
> > >> +	u8 who;  
> > > Some of these are no immediately obvious so either rename the
> > > field so it is more obvious what it is, or add comments.  
> > 
> > I would vote for adding a comment :) I like the who. Both the band and 
> > this member here :) Data-sheet has register named as "who_am_i" - so I 
> > don't think this name is too obfuscating - and what matters to me - it 
> > is short yet meaningful.
> > 
> > >> +	u8 id;
> > >> +	u8 cntl;
> > >> +	u8 cntl2;
> > >> +	u8 odcntl;
> > >> +	u8 buf_cntl1;
> > >> +	u8 buf_cntl2;
> > >> +	u8 buf_clear;
> > >> +	u8 buf_status1;
> > >> +	u16 buf_smp_lvl_mask;
> > >> +	u8 buf_read;
> > >> +	u8 inc1;
> > >> +	u8 inc4;
> > >> +	u8 inc5;
> > >> +	u8 inc6;
> > >> +	u8 xout_l;
> > >> +};
> > >> +
> > >> +struct kx022a_data {  
> > > 
> > > Why move this to the header?  Unless there is a strong reason
> > > I'd prefer this to stay down in the .c file.  
> > 
> > So would I. It's definitely nice to be able to see the struct in the 
> > same file where the code referencing it is.

no strong reason, I will move it back to the .c file

--
Kind Regards
Mehdi Djait
