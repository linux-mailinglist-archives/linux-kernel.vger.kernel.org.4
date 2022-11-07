Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C63DA61F897
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Nov 2022 17:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232434AbiKGQMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Nov 2022 11:12:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232273AbiKGQMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Nov 2022 11:12:42 -0500
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 647DC201A3;
        Mon,  7 Nov 2022 08:12:37 -0800 (PST)
Received: by mail-pl1-x635.google.com with SMTP id b21so11486577plc.9;
        Mon, 07 Nov 2022 08:12:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=OxtV4eNytGZqtTr58EFGp2fbSAZOZDoFPK3f2kbkRSc=;
        b=Un0/gzqqJqp56xovtIlDx/l/4Wf3KozrwJ+Kvde3KzTeLg+iaDo42Wl6PMNlX/JaWd
         PmB6+afpyMrrvup7NxbXAiWaqkCzP4waeRlZbICEmJc+ctRV/zlLSgYq+ymI7epfPsNZ
         qW1WxTcaHcgqZbl8Nv6tRJ+hJoxyT+Veeplr34dhyYrUc+3z8L2oBQcSeYpFgFRN9GfD
         HvlNiiQknOQXTQsQDBYbdQwJsFi4ZlGzZhAJzSj4IIul+sH1sW6D0U6+SYPtuQCuj4+r
         +RlXc9obyw1H3h4v+L9s1Xln23utuF1D4SjyB5DrRG3fYMTrVEB2jPaP1wbtU6GXKoBd
         ktkw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=OxtV4eNytGZqtTr58EFGp2fbSAZOZDoFPK3f2kbkRSc=;
        b=IWZOujmH3iGrewKqTzN+9CHRqZVFsfZr11M+FZ6Jhs1iLr62tLZprtAeBI4IXhFmN7
         hIYoRJHpHIVTr3EFj1ga37stM+SxJsyYqJjJO4PFZKERZIr1mM5hIXnIul8ZRZ2/vPVn
         jMctM9sl4fhra7X0W7QQFqRPc8k0IABYRG4drUZMS6bIwQTcGjEd9V9yPLZowGZjvtwT
         LCXCgZ58jndIKc7Zfc3fl3yAXJbrgRntPtRnI4AZLhKYrM8/NnFsyFuycz3i5edD84X7
         6+e5AwIDNA+XyO8HcITuMJrJnrS1mJ0023rDxhgdrYKWR2qfu4GXkneFZoMPFCwZzYE5
         /hBg==
X-Gm-Message-State: ACrzQf1Mt3D/BcxdaokFmXz12lPMbnlyLH0fOPr4drdrAJ+UtRSViOE7
        Ue+Eg6r1yQ4vMkxUBd/78D4=
X-Google-Smtp-Source: AMsMyM66nke43Q8t/SVF5Qdo371dgX5xx0mM6O93qO0RYuPpneFRsifcjcbSFrIfa4oWl4Yes7cs+A==
X-Received: by 2002:a17:903:25c3:b0:188:602c:5c25 with SMTP id jc3-20020a17090325c300b00188602c5c25mr20543498plb.133.1667837556560;
        Mon, 07 Nov 2022 08:12:36 -0800 (PST)
Received: from google.com ([2620:15c:9d:2:626:eb80:9eb9:1fd7])
        by smtp.gmail.com with ESMTPSA id w69-20020a627b48000000b00545f5046372sm4628226pfc.208.2022.11.07.08.12.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 07 Nov 2022 08:12:35 -0800 (PST)
Date:   Mon, 7 Nov 2022 08:12:32 -0800
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        linux-acpi@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 6/6] gpiolib: add support for software nodes
Message-ID: <Y2kucGtw/t9v0245@google.com>
References: <20221031-gpiolib-swnode-v1-0-a0ab48d229c7@gmail.com>
 <20221031-gpiolib-swnode-v1-6-a0ab48d229c7@gmail.com>
 <Y2VVA2Wp1IWoJf3m@smile.fi.intel.com>
 <Y2Vo8g5HfvSi7Bck@google.com>
 <Y2V8uwTHYw2McL5S@smile.fi.intel.com>
 <Y2XrL0noH4HqsAU7@google.com>
 <Y2jnGVKDmGvK94AV@smile.fi.intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Y2jnGVKDmGvK94AV@smile.fi.intel.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 07, 2022 at 01:08:09PM +0200, Andy Shevchenko wrote:
> On Fri, Nov 04, 2022 at 09:48:47PM -0700, Dmitry Torokhov wrote:
> > On Fri, Nov 04, 2022 at 10:57:31PM +0200, Andy Shevchenko wrote:
> > > On Fri, Nov 04, 2022 at 12:33:06PM -0700, Dmitry Torokhov wrote:
> > > > On Fri, Nov 04, 2022 at 08:08:03PM +0200, Andy Shevchenko wrote:
> > > > > On Thu, Nov 03, 2022 at 11:10:16PM -0700, Dmitry Torokhov wrote:
> 
> ...
> 
> > > > > > const struct property_entry simone_key_enter_props[] __initconst = {
> > > > > > 	PROPERTY_ENTRY_U32("linux,code", KEY_ENTER),
> > > > > 
> > > > > > 	PROPERTY_ENTRY_STRING("label", "enter"),
> > > > > > 	PROPERTY_ENTRY_REF("gpios", &gpio_bank_b_node, 123, GPIO_ACTIVE_LOW),
> > > > > 
> > > > > Okay, can we have an example for something like reset-gpios? Because from
> > > > > the above I can't easily get what label is and how in the `gpioinfo` tool
> > > > > the requested line will look like.
> > > > 
> > > > The label is something unrelated to gpio. The example was supposed to
> > > > match gpio-keys binding found in
> > > > Documentation/devicetree/bindings/input/gpio-keys.yaml
> > > 
> > > Yes, but what would be output of `gpioinfo` for the above  example and
> > > if GPIO is named properly (with con_id)?
> > 
> > Same as if I am using device tree, or ACPI, etc. I am not changing how
> > labeling is done, so whatever rules were before adding swnode support
> > they will be used with swnodes.
> > 
> > With the hack patch to gpio-keys.c below and device using the following
> > DT fragment I see the following from gpioinfo:
> > 
> >         gpio_keys: gpio-keys {
> >                 status = "okay";
> > 
> >                 compatible = "gpio-keys";
> >                 pinctrl-names = "default";
> >                 pinctrl-0 = <&pen_eject>;
> > 
> >                 pen_insert: pen-insert {
> >                         label = "Pen Insert";
> >                         /* Insert = low, eject = high */
> >                         /* gpios = <&pio 18 GPIO_ACTIVE_LOW>; */
> >                         linux,code = <SW_PEN_INSERTED>;
> >                         linux,input-type = <EV_SW>;
> >                         wakeup-event-action = <EV_ACT_DEASSERTED>;
> >                         wakeup-source;
> >                 };
> >         };
> > 
> > Just "gpios" (con_id == NULL):
> > 
> >         line  18: "PEN_EJECT_OD" "Pen Insert" input active-low [used]
> > 
> > With "key-gpios" (con_id == "key") it is exactly the same:
> > 
> >         line  18: "PEN_EJECT_OD" "Pen Insert" input active-low [used]
> > 
> > Ah, I guess you wonder how it will look like if we do not pass this
> > "label" into devm_fwnode_gpiod_get() and instead use NULL?
> > 
> > 	line  18: "PEN_EJECT_OD" "?" input active-low [used]
> > 
> > If the driver used gpiod_get() or similar it would either have the
> > "con_id" label or device name (produced with dev_name(dev) if con_id is
> > NULL. Still, not changes from using swnodes compared to ACPI or DT.
> 
> Yes, can you add a summary of above to the commit message?
> 
> > > > > > 	{ }
> > > > > > };
> 
> ...
> 
> > > > > > +	/*
> > > > > > +	 * We expect all swnode-described GPIOs have GPIO number and
> > > > > > +	 * polarity arguments, hence nargs is set to 2.
> > > > > > +	 */
> > > > > 
> > > > > Maybe instead you can provide a custom macro wrapper that will check the number
> > > > > of arguments at compile time?
> > > > 
> > > > We could have PROPERTY_ENTRY_GPIO() built on top of PROPERTY_ENTRY_REF()
> > > > that enforces needed arguments.
> > > 
> > > Yes, that's what I meant.
> > 
> > Where do you think it should go? Not sure if I want to pollute
> > property.h, I guess linux/gpio/matchine.h will need to include
> > property.h?
> 
> Good question. I was thinking more of a separate header for that,
> because adding property.h adds tons of stuff which might be not
> needed otherwise.

OK, I guess include/linux/gpio/property.h ?

> 
> ...
> 
> > > > > > +	/*
> > > > > > +	 * First look up GPIO in the secondary software node in case
> > > > > > +	 * it was used to store updated properties.
> > > > > 
> > > > > Why this is done first? We don't try secondary before we have checked primary.
> > > > 
> > > > I believe we should check secondary first, so that secondaries can be
> > > > used not only to add missing properties, but also to override existing
> > > > ones in case they are incorrect.
> > > 
> > > It contradicts all code we have in the kernel regarding the use of software
> > > nodes, you need very strong argument to justify that.
> > > 
> > > Personally I think this must be fixed.
> > 
> > I agree, the rest of the code should be fixed ;) I'll put it on my TODO
> > list.
> 
> I'm not sure what "rest of the code" you are referring to. The core part of
> device property APIs?

Yes.

> 
> > I gave my argument above already: swnodes should not only be useful to
> > add missing properties, but also allow fixing up existing ones. If I
> > implemented what you are suggesting then I would not be able to create
> > this concise example and would need to model entire DT node for GPIO
> > keys.
> 
> Why do you need that in the first place? We should not use swnodes as primary
> source of the information. The auxiliary one is fine. "Fixing" via priority
> inversion in current model is not good thing to have.
> 
> If you really need that you have to first do the following:
> - convert fwnode to be a list node
> - unembed it from struct device (leaving only head of list there
> - update all necessary APIs respectively
> 
> In such implementation list_add() / list_add_tail() will define a priority
> and you may have stack of properties.

Hmm, that will complicate things quite a bit. I wonder why you think
that using swnodes to fix up the "bad" firmware data is not desirable.
Swnodes are controlled by the kernel and thus we can potentially allow
users tweak them from usersoace. There is a desire to allow easier
access to various driver's parameters - see for example Hans patches to
Goodix and Silead where he adds code that intercepts reading of device
properties and instead gets data form module parameter - I would like to
have such facility in more general way.

https://lore.kernel.org/all/20221025122930.421377-3-hdegoede@redhat.com/

> 
> Doing it in a hackish way by allowing priority inversion in _some_ APIs
> is no go in my opinion.

Yes, I agree that we want to have all APIs behave in the similar way. It
occurred to me that the topic of handling secondary node is actually
separate from swnode hanlding, so I will remove it from this patch and I
can start a separate thread/patches for it after we land this series.

Thanks.

-- 
Dmitry
