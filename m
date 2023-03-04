Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 029A06AAC07
	for <lists+linux-kernel@lfdr.de>; Sat,  4 Mar 2023 20:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229604AbjCDTDK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 4 Mar 2023 14:03:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34048 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229471AbjCDTDC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Mar 2023 14:03:02 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30D206EA3;
        Sat,  4 Mar 2023 11:03:00 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BC21B60A48;
        Sat,  4 Mar 2023 19:02:59 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 65FC6C433D2;
        Sat,  4 Mar 2023 19:02:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677956579;
        bh=tqtGgBiDL+JULeCUoXPI91l++hnlRRTkBEcPxi6Ir+0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=UEhWo3Y2RFmMcuRyWt8VqVYdDdvegU8V5JbK+VC4LaWUAw+okmWWOhcSWvDjVtD7d
         tLDBGTJ6UJYnzCD87kzEaFI5+Ofbds01Uei2P9151HTQFqyW4vNc9j7Vtws+6+CWiH
         +5tGXQ5cTxgu0yc9ZdnoAwd4tE8dYdMu27DliTPTOJPgP5alwf4H2Yr9YU7E2BXpbz
         qhufb+KvDGUc2mgwX+GcYpJCzeej4rJHRvA1fvKiTMq7fGmj0/V4xNLN/8VT86tqFJ
         sfgs0eZnXUQcp5L9A8Yu83/eRgYSswlDIaWTW0ZS7cNAhqiUKclQEF/WlsseaRHq1G
         SKTfYhcawrJaw==
Date:   Sat, 4 Mar 2023 19:02:54 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Paul Gazzillo <paul@pgazz.com>,
        Zhigang Shi <Zhigang.Shi@liteon.com>,
        Shreeya Patel <shreeya.patel@collabora.com>,
        Dmitry Osipenko <dmitry.osipenko@collabora.com>,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH v2 5/6] iio: light: ROHM BU27034 Ambient Light Sensor
Message-ID: <20230304190254.2ea052eb@jic23-huawei>
In-Reply-To: <ae769902-4bb5-a970-be1e-05b26f4c770c@gmail.com>
References: <cover.1677750859.git.mazziesaccount@gmail.com>
        <874d59be98703bb58a98fea72138de5b94d71a52.1677750859.git.mazziesaccount@gmail.com>
        <ZADCEPc1ZKczhEpE@smile.fi.intel.com>
        <ae769902-4bb5-a970-be1e-05b26f4c770c@gmail.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.37; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


A few follow up comments.

Jonathan
> >   
> >>   obj-$(CONFIG_OPT3001)		+= opt3001.o
> >>   obj-$(CONFIG_PA12203001)	+= pa12203001.o  
> >   
> >> +obj-$(CONFIG_ROHM_BU27034)	+= rohm-bu27034.o  
> > 
> > If you see, most of the components are without vendor prefix, why rohm is
> > special? Like you are expecting the very same filename for something else?  
> 
> No. I don't.
> 
> Using the vendor prefix in _file name_ was suggested to me by Lee 
> already a few years ago. And I am actually grateful he did. I've found 
> that _very_ useful as it simplifies finding the files I am looking for. 
> What comes to the config option name, being able to easily search for 
> the configs by vendor name has also been helpful.

For filenames I've no strong preference - though perhaps if I'd been
starting out today I might have decided the convention was to always
add a vendor because of the slight risk of a naming clash.


> 
> > ...
> >   
> >> +#include <linux/iio/iio.h>
> >> +#include <linux/iio/buffer.h>
> >> +#include <linux/iio/kfifo_buf.h>  
> > 
> > Sorted?  
> 
> Sure, thanks.
> 
> > 
> > ...
> >   
> >> +#define BU27034_REG_DATA0_LO		0x50
> >> +#define BU27034_REG_DATA1_LO		0x52
> >> +#define BU27034_REG_DATA2_LO		0x54  
> > 
> > I would drop _LO in all these
> >   
> >> +#define BU27034_REG_DATA2_HI		0x55  
> > 
> > and rename somehow this to something like _END / _MAX (similar to the fields.
> > Perhaps you would need _START / _MIN above.  
> 
> I don't think this would improve anything. The _LO / _HI are descriptive 
> as we have only two registers for each channel, _LO and _HI being more 
> or less standard abbreviations for low and high.

Whilst it might be fairly obvious that we are going to do double reg reads
against these, having the register names match the datasheet is useful.

But in this case the datasheet register map does given them a top level
label without the LO, HI so either option would be easy to find.


> 
> > ...
> >   
> >> +/*
> >> + * Available scales with gain 1x - 4096x, timings 55, 100, 200, 400 mS
> >> + * Time impacts to gain: 1x, 2x, 4x, 8x.
> >> + *
> >> + * => Max total gain is HWGAIN * gain by integration time (8 * 4096) = 32768
> >> + *
> >> + * Using NANO precision for scale we must use scale 64x corresponding gain 1x
> >> + * to avoid precision loss. (32x would result scale 976 562.5(nanos).
> >> + */
> >> +#define BU27034_SCALE_1X	64
> >> +
> >> +#define BU27034_GSEL_1X		0x00
> >> +#define BU27034_GSEL_4X		0x08
> >> +#define BU27034_GSEL_16X	0x0a
> >> +#define BU27034_GSEL_32X	0x0b
> >> +#define BU27034_GSEL_64X	0x0c
> >> +#define BU27034_GSEL_256X	0x18
> >> +#define BU27034_GSEL_512X	0x19
> >> +#define BU27034_GSEL_1024X	0x1a
> >> +#define BU27034_GSEL_2048X	0x1b
> >> +#define BU27034_GSEL_4096X	0x1c  
> > 
> > Shouldn't the values be in plain decimal?  
> 
> Why?

Normally go with datasheet on this as it makes reviewer simpler.
But datasheet is in binary so meh.

> 
> > Otherwise I would like to understand bit mapping inside these hex values.  
> 
> I like having register values in hex. It makes it obvious they don't 
> necessarily directly match any 'real world' human-readable values.

Perhaps a cross reference to the table in the spec is appropriate here?

whilst there are some patterns they aren't terribly consistent so probably
best to just point at the table in the spec.


> >> +		if (helper64 < 0xFFFFFFFFFFFFFLLU) {  
> > 
> > Perhaps this needs a definition.  
> 
> I like seeing the value here. It makes this less obfuscating. Comment 
> makes the purpose obvious so adding a define would not really give any 
> extra advantage.

It's not immediately obvious why it is that many f's.  Perhaps change
to refer to number of bits (which is what matters really I think)
and then use GENMASK() to fill this in?  I think it's 52 bits?

> 
> >> +			helper64 *= gain0;
> >> +			do_div(helper64, ch0);
> >> +		} else {
> >> +			do_div(helper64, ch0);
> >> +			helper64 *= gain0;
> >> +		}  

> > 
> > ...> >> +	if (!res[0])  
> > 
> > Positive conditional?  
> 
> No. Again, we check for the very specific case where res has all bits 
> zeroed. Inverse condition is counter intuitive.
> 
> >   
> >> +		ch0 = 1;
> >> +	else
> >> +		ch0 = le16_to_cpu(res[0]);
> >> +
> >> +	if (!res[1])
> >> +		ch1 = 1;  
> > 
> > Ditto.
> >   
> >> +	else
> >> +		ch1 = le16_to_cpu(res[1]);  
> > 
> > But why not to read and convert first and then check.  
> 
> Because conversion is not needed if channel data is zero.

Conversion is trivial. I agree with Andy here that the logic would look
a bit simpler as (taking it a little further)

	ch0 = max(1, le16_to_cpu(res[0]));
> 
> > This at least will
> > correctly compare 0 to the LE16 0 (yes, it's the same for 0, but strictly
> > speaking the bits order of lvalue and rvalue is different).  
> 
> and hence we check for !res[0]
> 
> > 
> > ...
> >   
> >> +	switch (mask) {
> >> +	case IIO_CHAN_INFO_INT_TIME:
> >> +		return iio_gts_avail_times(&data->gts, vals, type, length);
> >> +	case IIO_CHAN_INFO_SCALE:
> >> +		return iio_gts_all_avail_scales(&data->gts, vals, type, length);
> >> +	default:
> >> +		break;
> >> +	}
> >> +
> >> +	return -EINVAL;  
> > 
> > You may do it from default case.
> >   
> 
> I think we have discussed this one in the past too. I like having return 
> at the end of a non void function.

Given all the earlier returns and the fact that the compiler will shout at
you if it you can get here and it is missing, I'd also suggest just putting
it in the switch statement.


