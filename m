Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F202F655343
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Dec 2022 18:31:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232778AbiLWRbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Dec 2022 12:31:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232838AbiLWRbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Dec 2022 12:31:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89AF62199;
        Fri, 23 Dec 2022 09:31:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 1974861B0A;
        Fri, 23 Dec 2022 17:31:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B9EE0C433D2;
        Fri, 23 Dec 2022 17:31:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1671816697;
        bh=Kyf6wmV7Q1Fz5Umr6Hn32k9g/9IdeAhz9EIzUF51TFM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=mJJU14Ylq5lL4eg98J1DOHdyotXdGcfOUGoVDzkYSjjYqbHGkug37C5yVDPI+J96S
         Zy8Iatu190lglyxLPf30QKDpgke+henUX1mIbBd8R7YCDvXdGaKXmfucWoUTJ6pSjO
         ObjOlPVwdX4RMRDf0F7+hyTgT9SjPn64kIPNGLgwx+ytUChQtpBJF1cfdXFfGOxNjb
         WJHdKqAnIHlx/p5eO8Xjfpssih+YZ9B2I/q2AcZW1VpVpET6LIn4a0BcklLDEhM/Qt
         1T7X3YzcUqMoe/vdMohAX51gcfFtxmldEAfj2MMEU3LpiX4HraYX2lPi6H7YNMUjTO
         aN8RgS3Ek941g==
Date:   Fri, 23 Dec 2022 17:44:45 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marijn Suijten <marijn.suijten@somainline.org>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>,
        Luca Weiss <luca@z3ntu.xyz>, linux-arm-msm@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Subject: Re: [RFC PATCH] iio: adc: qcom-spmi-vadc: Propagate fw node
 name/label to extend_name
Message-ID: <20221223174445.7c607ebc@jic23-huawei>
In-Reply-To: <20221221223432.si2aasbleiicayfl@SoMainline.org>
References: <20221106193018.270106-1-marijn.suijten@somainline.org>
        <20221106202445.fkobsyc3mohmzqod@SoMainline.org>
        <20221112162719.0ac87998@jic23-huawei>
        <20221130205414.6m4rfufc25hfzxmf@SoMainline.org>
        <20221203170656.7b65142b@jic23-huawei>
        <20221221223432.si2aasbleiicayfl@SoMainline.org>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.35; x86_64-pc-linux-gnu)
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

On Wed, 21 Dec 2022 23:34:32 +0100
Marijn Suijten <marijn.suijten@somainline.org> wrote:

> Hi Jonathan,
> 
> Apologies for another late reply; we really shouldn't make these
> messages this long and I'll try to only reply to the most relevant
> points and cull out the rest.
> 
> On 2022-12-03 17:06:56, Jonathan Cameron wrote:
> > On Wed, 30 Nov 2022 21:54:14 +0100
> > Marijn Suijten <marijn.suijten@somainline.org> wrote:
> >   
> > > On 2022-11-12 16:27:19, Jonathan Cameron wrote:  
> > > > On Sun, 6 Nov 2022 21:24:45 +0100
> > > > Marijn Suijten <marijn.suijten@somainline.org> wrote:
> > > >     
> > > > > Adding Krzysztof to CC for the DT bindings discussion.
> > > > > 
> > > > > On 2022-11-06 20:30:18, Marijn Suijten wrote:    
> > > > > > Much like the ADC5 driver iio_chan_spec::extend_name has to be set for
> > > > > > friendly/useful names to show up in sysfs, allowing users to correlate
> > > > > > readout values with the corresponding probe. This name is read from
> > > > > > firmware, taking both the node name and - if set - node label into
> > > > > > account.  This is particularly useful for custom thermistors being
> > > > > > attached to otherwise-generically-named GPIOs.
> > > > > >     
> > > > 
> > > > If you are attaching thermistors to an ADC channel, then you should have
> > > > a driver for that thermistor.  It will be a consumer of the ADC channel
> > > > in question and any labels etc should apply there (along with scaling
> > > > / non linear transforms to get to a temperature), not at the ADC
> > > > level.    
> > > 
> > > This is what happens in the ADC5 driver, though.  In /sys/bus/iio names
> > > show up for ADC channels that aren't otherwise consumed by (thermistor)
> > > drivers.  There are also voltage readings.  The IIO driver seems to be
> > > aware of both the unit and (linear iirc) scaling.  
> > 
> > There were cases where we did that but my understanding of what was going
> > on at the time may have been wrong. I was assuming there was specific
> > hardware on the SOC side of things that did 'special' stuff for the
> > thermistor rather than just being an ADC channel.  
> 
> There is, it's the thermal monitor driver but I don't think it binds to
> every ADC channel, and the ADC channels provided by VADC/ADC5 provide
> useful information on their own in sysfs.
> 

Ah. That make sense - the specific logic is hidden in the other driver.

> > > Ack, the node name is a mess nowadays.  That means ADC5 shouldn't use it
> > > as fallback either when a DT label is not set (and instead use the
> > > currently-unused adc5_channels::datasheet_name field).
> > > 
> > > Can I remove it (use of fwnode_get_name() as datasheet_name)?  
> > 
> > Ah. That's indeed a mess. From an ABI point of view you can indeed break the
> > connection between datasheet_name and the "label", but you can't
> > change the use for extend_name (ABI breakage) unless you are very very sure
> > it won't break existing userspace code.  
> 
> As in, as long as we don't touch extend_name which would affect sysfs
> names, changing the label returned by read_label is fine? 

Sticky corner, but I think we should be fine doing so on basis of changing
ABI we don't think anyone will notice. In lots of cases the label is effected
by DTS files that may change under the kernel anyway so hopefully no one is
relying on the value too much *crossed fingers*

> And changing
> datasheet_name to only ever use the datasheet_name provided by the
> driver and never the name provided in DTS is also okay?

datasheet_name is internal to kernel only so can definitely change that
as long as we don't have any upstream users (I'm fairly sure there aren't any)

> 
> > Now from a potential consumers point of view, it's possible someone is relying
> > on the datasheet name to get the right channel. Given those are only
> > used if a driver is directly registering an iio_map, should be easy enough
> > to fix..  
> 
> I am unfortunately completely unfamiliar with iio_map, and hope it
> doesn't distract too much from trying to add label files to QCom's SPMI
> VADC driver :)

Just think of it as the board file way of doing equivalent of what we have
to set up IIO consumers in DT. It's also used in driver that hard code
relationships with their consumers - not including this one so we should
be fine.

> 

> 
> > > > > > 3. If only labels are going to be used in conjunction with generic node
> > > > > >    names, should ADC5 be changed to ignore the node name?    
> > > >
> > > > From a quick search, I'm only seeing the node name used in debug prints currently.
> > > > That feels fine to me as it's telling us where the binding parsing went wrong...
> > > > Am I missing some use outside of vadc_get_fw_channel_data()?    
> > > 
> > > That's the VADC driver.  Look at adc5_get_fw_channel_data, specifically
> > > where it calls fwnode_property_read_string() to overwrite
> > > prop->datasheet_name.  
> > 
> > Ah. Thanks for the pointer, though I'm still confused.
> > 
> > 	ret = fwnode_property_read_string(fwnode, "label", &channel_name);
> > 	if (ret)
> > 		channel_name = name;  
>   		             ^ here ^
> 
> > 	prop->datasheet_name = channel_name;
> > 
> > That's reading the label property, not the node name.  
> 
> The node name sits in `name`, and that's used if there's no "label"
> property in wich case ret is non-zero and we end up in `if (ret)
> channel_name = name;`.
Ah. Missed that.  thanks!
> 
> > > > > > 4. If a label (or node name) is not set, do we fall back to
> > > > > >    datasheet_name hardcoded in the driver?    
> > > > 
> > > > Hmm. Probably not.    
> > > 
> > > Then we might as well remove this useless data from the kernel driver
> > > altogether...  
> > 
> > Ok. May make sense to use the datasheet name if noting better provided
> > for the label.  Assuming the datasheet names are them selves somewhat
> > useful information for a user.  
> 
> They're generated from the macro (hence capitalized) in VADC, manually
> written in ADC5.  Would it make sense to add handwritten string
> literals for this?

Not sure. I've rather lost track of where we are on this.
> 
> > > > > > 5. What do we use for datasheet_name vs extend_name?    
> > > > Expand that to include label.
> > > > datasheet_name : When you want to have human readable pin names from the ADC
> > > >   datasheet, used as part of provide services to consumer drivers. Doesn't
> > > >   work with DT though as it wasn't part of the binding for consumers.
> > > >   So largely irrelevant unless you have an MFD where the ADC consumers are
> > > >   also part of the MFD children and so the map is set up in the way we used
> > > >   to do it for board files.    
> > > 
> > > ... or this could remain to feed into datasheet_name?  
> > Now I'm confused.  Feed into label perhaps?  
> 
> Feed into read_label when no label was otherwise provided in DTS, but
> always feed into iio_chan_spec::datasheet_name since we discussed that
> this should represent the name of the part (e.g. PMIC), not the board
> and way in which it consumes the channel.

Should be the name of the pin on the part, but otherwise agreed.

> 
> <snip>
> 
> > > Do we then remove extend_name from qcom-spmi-adc5 and give it the same
> > > treatment, since it would now use DT node names as filenames unless a
> > > label is set?  I can only imagine it having been set because the ADC5
> > > author(s) didn't see a name nor label in sysfs either, without knowing
> > > about the existence of read_label.  
> > 
> > Sadly we can't remove it because of the ABI change that would result and
> > potential userspace breakage.  
> 
> The change to fwnode_get_name is already breaking this sysfs ABI though,
> as discussed in a DTS series where I replaced all node names with labels
> to support (the followup of) this iio series.
> 
> We could unbreak it by either stripping @xx off of it, or setting
> extend_name to a label (if it exists) instead, but the latter is
> breaking :(
> 
> <snip>

I hate it when we break ABI and don't notice, precisely because it then
becomes guessing game on which one people might be relying on.

Let's take the view it is the older one without the @xx? 
So strip that off as a fix that we backport.

> 
> > > > Hope that helps.    
> > > 
> > > A lot, now knowing that read_label is the part of the puzzle I
> > > previously missed.  Thanks!  
> > 
> > When I let the extend_name fallback in for the labels
> > it didn't occur to me that it would make it more confusing for
> > people looking at older code.  Long shot, but would a comment
> > in iio.h for extend_name to say something to this effect be likely
> > to have been something you'd have seen?  If it would, let's add
> > one to potentially make this less confusing for the next person!  
> 
> Yes, I think I visited the documentation/definition of extend_name at
> some point and would have been been helped if that pointed me right over
> to read_label.  Right in ADC5 (and other drivers) would be even better
> but may be overly verbose.
I agree that a cross reference for that 'other' use of extend_name
would make sense and that it can be overridden.  Though the override is
kind of the common case, if you are looking at extend_name docs you
are presumably in the case where such docs would help.
Patches for docs welcome :) 
> 
> Regardless of that VADC/ADC5 do some _really confusing_ things, passing
> strings around in various weird ways (or not), and it took some time to
> keep the various similar structs apart :)

I'm feeling a bit guilty I never noticed this insanity at the time.
I blame my younger self.

Have a good break if you are having one.

Jonathan
> 
> - Marijn

