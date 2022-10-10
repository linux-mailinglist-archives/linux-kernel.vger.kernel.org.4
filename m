Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5EDD35F9E31
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Oct 2022 13:58:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232273AbiJJL6i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Oct 2022 07:58:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232143AbiJJL6N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Oct 2022 07:58:13 -0400
Received: from mga07.intel.com (mga07.intel.com [134.134.136.100])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B89DF5FE3;
        Mon, 10 Oct 2022 04:58:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1665403091; x=1696939091;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:content-transfer-encoding:in-reply-to;
  bh=1t5mrNL2bcib+WNgzQGPTtGf3KVLzMbbyVvf2opVQIg=;
  b=X5daZzQjnTlmcMyIMUWnxIGPQVbdjQWt5aT2RwAun79AINp/Lj0CbfeB
   6DUgSZSub0IlddGYOCk/PVnS/vxiTvPxXZ4yg/iP/xU+D2dhcCNmPN6YY
   aVmEXp+TTcUD6nTUEiUAUtMNYrCVfohmmNTIiHr032Xc+ztOtY6be7z4D
   P98UDRTjfPUmwRERFpMggzDD7zkgJjLZyRDrainpu9DIwoaPuvZYIwEMz
   VCnaagU6Iq0D+aWBrZM30dSiv5WvM0w0uVqd/juP4z7Y9V3sOs5ksFBfC
   eBZ3lsoNw5l7SML4vyV5ZEFutC2EeIvjY0u3hn4orkyqXPNVy5QNSxkd7
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="368344850"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="368344850"
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 10 Oct 2022 04:58:11 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10495"; a="954890365"
X-IronPort-AV: E=Sophos;i="5.95,173,1661842800"; 
   d="scan'208";a="954890365"
Received: from smile.fi.intel.com ([10.237.72.54])
  by fmsmga005.fm.intel.com with ESMTP; 10 Oct 2022 04:58:07 -0700
Received: from andy by smile.fi.intel.com with local (Exim 4.96)
        (envelope-from <andriy.shevchenko@linux.intel.com>)
        id 1ohrQ6-004ruh-04;
        Mon, 10 Oct 2022 14:58:06 +0300
Date:   Mon, 10 Oct 2022 14:58:05 +0300
From:   Andy Shevchenko <andriy.shevchenko@linux.intel.com>
To:     Matti Vaittinen <mazziesaccount@gmail.com>
Cc:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jagath Jog J <jagathjog1996@gmail.com>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Cosmin Tanislav <demonsingur@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH v2 4/5] iio: accel: Support Kionix/ROHM KX022A
 accelerometer
Message-ID: <Y0QIzf2cAH9ehSeO@smile.fi.intel.com>
References: <cover.1665066397.git.mazziesaccount@gmail.com>
 <88e24b01da9f44ebf5fcd8344ded0b75ff742fbf.1665066397.git.mazziesaccount@gmail.com>
 <Yz8fK7j8pxlU76xt@smile.fi.intel.com>
 <98b59ad5-8c29-be41-4da1-a961db67827c@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <98b59ad5-8c29-be41-4da1-a961db67827c@gmail.com>
Organization: Intel Finland Oy - BIC 0357606-4 - Westendinkatu 7, 02160 Espoo
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Oct 10, 2022 at 12:12:34PM +0300, Matti Vaittinen wrote:
> Hello Andy,
> 
> Thanks for taking the time and doing the review. Quite a few comments I do
> agree with. I didn't respond to those unless you asked a question :) Thanks
> for the help! OTOH, as usual, I do not fully agree with everything - and at
> some places I would like to get some further information :)
> 
> On 10/6/22 21:32, Andy Shevchenko wrote:
> > On Thu, Oct 06, 2022 at 05:38:14PM +0300, Matti Vaittinen wrote:

...

> > > +config IIO_KX022A_SPI
> > > +	tristate "Kionix KX022A tri-axis digital accelerometer"
> > > +	depends on I2C
> > > +	select IIO_KX022A
> > > +	select REGMAP_SPI
> > > +	help
> > > +	  Say Y here to enable support for the Kionix KX022A digital tri-axis
> > > +	  accelerometer connected to I2C interface.
> > 
> > Why it tending to get user to choose Y? It might increase the footprint of
> > bootable image and on the embedded platforms it may increase the chances
> > to not fit into (flash) ROM.
> 
> It may be just my English skills but to me this is really telling that "say
> Y to enable support for this IC". For me it does not mean that "Say Y even
> if you don't have this IC". I am really not seeing the problem here, but as
> I said - maybe it's just my lack of English skills.
> 
> Nevertheless, looking at the top of the IIO/accelerometer/KConfg - plenty of
> the accelerometer driver KConfig entries seem to use similar pattern. I am
> nevertheless usually willing to break the pattern if it seems like the right
> thing ;) Can anyone help me to format better description?

Oh, I didn't know that the rest is also using this pattern. My main objection
here is Y vs. M and maybe less insisting tone of the language (it doesn't tell
anything like "if you have the sensor".

I leave this to native speaker(s) to propose something here, because for me
English is not the one.

> > Also what will be the module name (see other Kconfig for the pattern)?
> 
> Here the pattern is IMHO improved by cutting the useless text. Even the
> cross-reference from SPI to I2C and I2C to SPI driver which was in v1 is
> more useful. Module autoloading for SPI should just work. Adding the module
> name here seems just a silly habit - which I see many people are breaking.
> If module name is to be needed, then it should be checked from the Makefile
> and not trusted that Kconfig text stays up-to-date...

I think the module name is a good thing to have for a user who might be
not knowing about Makefile:s and how to derive the module name from that
(sometimes it's not so obvious).

> If the module name in config text is generally seen useful (which I doubt),
> then maybe there should be a script that fetches it from the Makefile?

No idea about this, if it's even possible.

...

> > Can you fix I²C driver to follow this style?
> 
> I need to respin this anyways, so yes.
> 
> > > +	}
> > 
> > Ditto (blank line).
> 
> The blank prior function return? I think I have been told to have blanks
> preceding returns to make returns more obvious - which I kind of understand.

Yes, _adding_ blank line (see what I referred to? To SPI driver as a good
example).

...

> > > +#include <linux/iio/iio.h>
> > > +#include <linux/iio/sysfs.h>
> > > +#include <linux/iio/trigger.h>
> > > +#include <linux/iio/trigger_consumer.h>
> > > +#include <linux/iio/triggered_buffer.h>
> > 
> > Can this group be placed after units.h (with blank line in between)?
> 
> Why? What's wrong with alphabetical order?

Nothing wrong with the order and order is orthogonal to the grouping.
My comment is for the latter. The rationale is to easily see generic header
group and subsystem related group.

...

> > > +#define KXO22A_FIFO_ERR_THRESHOLD 10
> > > +#define KX022A_FIFO_LENGTH 41
> > 
> > Why not to use TAB between definitions and values (also for the rest similar
> > cases)?
> 
> Because I don't personally see the benefit. I can still do that as I've
> heard many people prefer the aligned values.

For me it's hard to read when they are not on the same column, that's the
benefit I see.

...

> > > +#define KX022A_FIFO_MAX_BYTES (KX022A_FIFO_LENGTH *			\
> > > +			       KX022A_FIFO_SAMPLES_SIZE_BYTES)
> > 
> > Slightly better to read:
> > 
> > #define KX022A_FIFO_MAX_BYTES					\
> > 	(KX022A_FIFO_LENGTH * KX022A_FIFO_SAMPLES_SIZE_BYTES)
> > 
> 
> Really?

Really.

> Well, I can change this but don't personally see any improvement.

...

> > > +const struct regmap_config kx022a_regmap = {
> > > +	.reg_bits = 8,
> > > +	.val_bits = 8,
> > > +	.volatile_table = &kx022a_volatile_regs,
> > > +	.rd_table = &kx022a_wo_regs,
> > > +	.wr_table = &kx022a_ro_regs,
> > > +	.rd_noinc_table = &kx022a_nir_regs,
> > > +	.precious_table = &kx022a_precious_regs,
> > > +	.max_register = KX022A_MAX_REGISTER,
> > > +	.cache_type = REGCACHE_RBTREE,
> > 
> > No max register? Have you tried debugfs output?
> 
> Can you please explain what you mean by no max register?

There is a field which name I don't remember by heart limits the register
range. This, in particular is visible when one tries to dump the registers
via debugfs.

But I see that it is there, I simply missed it.

...

> > > +struct kx022a_data {
> > > +	int irq;
> > > +	int inc_reg;
> > > +	int ien_reg;
> > 
> > > +	struct regmap *regmap;
> > 
> > Putting this as a first member might improve code by making pointer arithmetics
> > better. Have you checked possibilities with bloat-o-meter?
> 
> No. Amount of combinations is just too huge for me to try randomly
> reordering structs and running bloat-o-meter. Can you please explain me why
> you think reordering this would have visible impact and if this is something
> that is universally true or if such an optimization is architecture
> dependent?

Usually regmap pointer is used more often than, for instance, the 'irq' member,
and I believe that moving 'irq' member deeper will be harmless, while moving
regmap might be winning.

> > > +	struct iio_trigger *trig;
> > > +	bool trigger_enabled;
> > > +
> > > +	struct device *dev;
> > > +	unsigned int g_range;
> > 
> > > +	struct mutex mutex;
> > 
> > No warning from checkpatch? Every lock should be commented what it is for.
> 
> No. I didn't see a warn from checkpatch with v6.0-rc7. And I am glad I
> didn't. I am not a fan of statements like "always document a lock" or "never
> use a goto" - because blindly following such "rules" tend to lead silly
> corner cases. In lock commenting case it is likely to lead copy-pasting
> comments for locks which are used for trivial protections. And I am
> definitely not a fan of boilerplate.

So, tell then, what is this lock for? How as a code reader I have to know that?

> > > +	unsigned int state;
> > > +
> > > +	int64_t timestamp, old_timestamp;
> > > +	unsigned int odr_ns;
> > > +
> > > +	struct iio_mount_matrix orientation;
> > > +	u8 watermark;
> > > +	/* 3 x 16bit accel data + timestamp */
> > > +	s16 buffer[8] __aligned(IIO_DMA_MINALIGN);
> > > +	struct {
> > > +		__le16 channels[3];
> > > +		s64 ts __aligned(8);
> > > +	} scan;
> > > +};

...

> > > + * The sensor HW can support ODR up to 1600 Hz - which is beyond what most of
> > > + * Linux CPUs can handle w/o dropping samples. Also, the low power mode is not
> > > + * available for higher sample rates. Thus the driver only supports 200 Hz and
> > > + * slower ODRs. Slowest being 0.78 Hz
> > 
> > Please, check the punctuation.
> 
> I admit it. Punctuation rules for English grammar are something I never
> learned. Actually, in the school I was told to just use short sentences
> because correct punctuation in English is not trivial. I understand that
> grammatically correct comments are pleasing to the eye for people who really
> _know_ English. Yet, even the grammatically incorrect comments can provide
> value for someone wondering why some code is as it is. Thus, I write the
> comments the best way I can - even though I am sure there are errors at
> times :)
> 
> I actually just tried running the comment through an online English checker.
> (Just picked first search result, I think it was called "Reverso" or
> something like that) Result the checker gave me was "No mistakes detected!"
> 
> Can you please suggest me a good tool for checking the grammar (or show me
> the errors - but that won't scale).

My eyes caught the missed period at the end of the comment (easy to catch),
other than that I use these rules:
 - Oxford comma;
 - commas for the subsentences that do not affect the meaning of the main
   one if they were dropped.

Rarely I use tools for punctuation as I agree it's not obvious in English.

...

> > > +static const int kx022a_accel_samp_freq_table[][2] = {
> > > +	[0] = { 0, 780000 },
> > > +	[1] = { 1, 563000 },
> > > +	[2] = { 3, 125000 },
> > > +	[3] = { 6, 250000 },
> > > +	[4] = { 12, 500000 },
> > > +	[5] = { 25, 0 },
> > > +	[6] = { 50, 0 },
> > > +	[7] = { 100, 0 },
> > > +	[8] = { 200, 0 }
> > 
> > What do you need the indices for? They are not defines, so are you expecting to
> > shuffle the entries?
> 
> No. Not expecting to suffle. I think I borrowed the construct from another
> driver. I am not sure if it had defines for indices though. Sounds like you
> have a problem with this, right? What would you suggest here?

Drop the indices and add a comma to the last entry (#8 according to your
indices). Similar to the rest of the similar cases.

> > > +};

...

> > > +		int n = ARRAY_SIZE(kx022a_accel_samp_freq_table);
> > 
> > You may drop {} in each case and have n defined once for all cases.
> 
> Could you please explain how? We use different table depending on the case.

	{
		int n;

		switch (x) {
		case Y:
			n = ARRAY_SIZE(foo);
			...
			break
		case Z:
			n = ARRAY_SIZE(bar);
			...
		}
	}

> > > +
> > > +		while (n-- > 0)
> > 
> > while (n--) ? Or why the 0 is ignored?
> 
> What do you mean by 0 being ignored? I am sorry but I do have difficulties
> following some of your comments.

Your while loop stops when n == 0. The 0 is not going inside while-loop body...

> > > +			if (val == kx022a_accel_samp_freq_table[n][0] &&
> > > +			    kx022a_accel_samp_freq_table[n][1] == val2)
> > > +				break;
> > 
> > > +		if (n < 0) {
> > 
> > How is it even possible with your conditional?
> 
> Eh? Why it would not be possible? I don't see any problem with the code.
> Could you explain me what you mean?

...and as a side effect, this condition won't be ever true. Did I miss
something?

> > 
> > > +			ret = -EINVAL;
> > > +			goto unlock_out;
> > > +		}

...

> > > +	ret = regmap_bulk_read(data->regmap, chan->address, &data->buffer,
> > > +			       sizeof(s16));

> > No endianess awareness (sizeof __le16 / __be16)

> > > +	if (ret)
> > > +		return ret;
> > > +
> > > +	*val = data->buffer[0];
> > 
> > Ditto (get_unaligned_be16/le16 / le16/be16_to_cpup()).
> 
> I have probably misunderstood something but I don't see why we should use
> 'endianess awareness' in drivers? I thought the IIO framework code takes
> care of the endianes conversions based on scan_type so each individual
> driver does not need to do that. That however has been just my assumption. I
> will need to check this. Thanks for pointing it out.

The IIO core uses endianness field only once in iio_show_fixed_type() AFAICS.
And it does nothing with it. Maybe Jonathan can shed a light what is it for
(I mean the field)?

...

> > > +	if (val > KX022A_FIFO_LENGTH)
> > > +		val = KX022A_FIFO_LENGTH;
> > 
> > max() from minmax.h?
> 
> Definitely not. We could use min() to squeeze one line but for my personal
> preference the open-coded limit check is clearer. Can switch to min() if
> this is a subsystem standard though.

Not sure how min() here would check for >. Are you sure you haven't forgotten
to tell me something more?

...

> > > +	return regmap_write(data->regmap, KX022A_REG_BUF_CLEAR, 0xff);
> > 
> > GENMASK() ?
> 
> I don't really see a need for GENMASK here. It does not matter what is
> written to this register.

Why not 0? At least it will be aligned to the _CLEAR part without need of
any comment. Otherwise it sounds like 0xff is special here.

...

> > > +	if (en)
> > > +		return regmap_set_bits(data->regmap, KX022A_REG_CNTL,
> > > +				       KX022A_MASK_DRDY);
> > 
> > I would put redundant 'else' here to have them on the same column, but
> > it's pity we don't have regmap_assign_bits() API (or whatever name you
> > can come up with) to hide this kind of code.
> 
> Eh, you mean you would put else here even though we return from the if? And
> then put another return in else, and no return outside the if/else?
> 
> I definitely don't like the idea.
> 
> We could probably use regmap_update_bits and ternary but in my opinion that
> would be just much less obvious. I do like the use of set/clear bits which
> also makes the meaning / "polarity" of bits really clear.

The idea behind is simple (and note that I'm usually on the side of _removing_
redundancy)

	if (en)
		return regmap_set_bits(data->regmap, KX022A_REG_CNTL,
				       KX022A_MASK_DRDY);
	else
		return regmap_clear_bits(data->regmap, KX022A_REG_CNTL,
					 ...

Because the branches are semantically tighten to each other. But it's not
a big deal to me.

> > > +	return regmap_clear_bits(data->regmap, KX022A_REG_CNTL,
> > > +				 KX022A_MASK_DRDY);

...

> > > +	if (WARN_ON(!dev))
> > 
> > Huh?! This can be easily transformed to panic followed by oops. Why is it
> > necessary to do so?
> 
> Because the call to this probe is only issued from I2C / SPI wrappers which
> are part of the same driver. I think missing a dev here means error in this
> driver - and it should be caught immediately. I don't think this should ever
> happen unless one developing this driver makes an error.
> 
> Well, if there are doubts I can remove this though.

I guess simple removal is right thing to do in this case.

> > > +		return -ENODEV;

...

> > > +	irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT1");
> > > +	if (irq > 0) {
> > > +		data->inc_reg = KX022A_REG_INC1;
> > > +		data->ien_reg = KX022A_REG_INC4;
> > > +	} else {
> > > +		irq = fwnode_irq_get_byname(dev_fwnode(dev), "INT2");
> > > +		if (irq < 0)
> > > +			return dev_err_probe(dev, irq, "No suitable IRQ\n");
> > 
> > Missed check for 0.
> 
> Why check for 0? fwnode_irq_get_byname() doc states:
>  * Return:
>  * Linux IRQ number on success, or negative errno otherwise.
> 
> I don't see 0 indicating a failure?

It's a mislead by documentation. You need to read the fwnode_irq_get()
to see what's going on. Feel free to submit a fix for the
fwnode_irq_get_byname() kernel doc.

...

> > To me it feels inconsistency to use dev_err_probe() in the cases when
> > it _might_ be a deferred probe and not use it in the cases we it won't
> > be a deferred probe.
> 
> I think we discussed this already. To me it feels better to have
> inconsistency for hard-coded return values than use dev_err_probe. At times
> using the "consistency" as a rationale for things feels like excusing the
> infamous "when you're used to use a hammer as solution, all problems start
> looking like nails" approach...

Yes, just shading my opinion once again.

...

> > > +module_param(g_kx022a_use_buffer, bool, 0);
> > > +MODULE_PARM_DESC(g_kx022a_use_buffer,
> > > +		 "Buffer samples. Use at own risk. Fifo must not overflow");
> > 
> > Why?! We usually do not allow module parameters in the new code.
> 
> There are still quite a few parameters that have been added during previous
> cycle. And many of those are to allow behaviour which is undesirable in many
> cases for those who can benefit from it.
> 
> 3dbec44d9c94 ("KVM: VMX: Reject kvm_intel if an inconsistent VMCS config is
> detected")
> 
> can serve as a random example.

KVM is quite different by nature to an arbitrary driver of an arbitrary sensor
that might appear in the real hardware at hand on 1:100 ratio basis.

> As explained by the comment:
> /*
>  * Filling up the HW-FIFO can cause nasty problems. Thus we do not
>  * enable the fifo unless it is explicitly requested by a module param.
>  * If you are _sure_ your system can serve the interrupts in time you
>  * can enable the HW fifo. I do not recommend it for sample frequencies
>  * higher than 2 Hz - and even in that case I would set the watermark
>  * somewhere near 20 samples (HI-RES) to have magnitude of 10 sec
>  * safety-margin.
>  */
> 
> this is also the use-case here.
> 
> And yes, using the FIFO regardless of the problems can be beneficial so just
> dropping the support completely would be counter-productive. I agree with
> Jonathan that disabling the FIFO by default does probably help avoiding bug
> reports - but allowing enabling the FIFO with own risk is just giving a hand
> to those who need it. Thus I'd really like to see the support upstream. We
> all know that code which is sitting in some downstream git is not likely to
> help people - and it is the reason why I do upstream code in first place.

I would suggest to split the part that adds parameter (with whatever it does
elsewhere) from the basic configuration. In this case the commit message should
at least clarify the needs of the parameter.

JFYI: It's Greg KH strong opinion about parameters and I agree with him on
that. Note that this subsystem goes via on of the Greg's trees.

-- 
With Best Regards,
Andy Shevchenko


