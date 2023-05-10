Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 605DC6FE4FF
	for <lists+linux-kernel@lfdr.de>; Wed, 10 May 2023 22:24:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236281AbjEJUYV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 10 May 2023 16:24:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52038 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236154AbjEJUYP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 May 2023 16:24:15 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88B2B7296;
        Wed, 10 May 2023 13:24:13 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id d2e1a72fcca58-6434e65d808so8169906b3a.3;
        Wed, 10 May 2023 13:24:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20221208; t=1683750253; x=1686342253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=nOqXUZiOn/jbSQs17L6q02ziolcmWifsT1TYQOY1qSY=;
        b=Hn+UCnzV77OBGkRlHOGSFKAb6OcNQRqJ8IQnldKNfoU/yANURsKO9t2igLjw+mabAq
         /IPmuHzXMwkrdlFKJmmR+Gt9verLisyjAjUSFDVqzolZz4q9Tr7Duuqe0KY5MsaVR4zH
         /DZXk/Zhcdu2nE4xEse9Av5Zsqat1K5i92FoU/aR0lisZyAzzYilhsOO2c3S6lDGuplf
         vwGahTH4WbRXVrdj1r0l/DT1TqaI/QTtm98Jord7lh451z/D8SWX8AzRN76hrr9sp+45
         JbDW++TmQNMuoIdirhmXQ366/1DMbDYDUhTz8RuMRJAlF22L0mroV0coHjJq5joEmfsW
         jWoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1683750253; x=1686342253;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=nOqXUZiOn/jbSQs17L6q02ziolcmWifsT1TYQOY1qSY=;
        b=F86u2nq5yKVurjhwOjHNYuhH5eBx36GalSWC5dUlAnNZOI4St395PWG1FXSTpNEwCZ
         6+yULPwFs38sG7KYEbNlafqO/rcswUWaBMCyM4uh7J72EiRavoFdB0pmApTGuAtj4Qhm
         fQT51/S6OumpHs8ZG3xubA/gJn5dyOUmvY2D2bZiunI2fXkASk8s4FMas4D9ycDHt7k0
         C8mIlWox6ogHINoAtIpIRFx8b02Trz6lDdgrtmpjBOjXUiiLJxT5F45OnKSIiu4REmcJ
         zZuEadBmv/goNxHyAPhbzRtMO3WEXreQFFGLQmzbxBAsGeX0dACDO0PP0ceW/5obQqiU
         gvpg==
X-Gm-Message-State: AC+VfDxWQeD3waOKd5dD9C8vVauSG8TfXLjHrW40v7Uv5CxT7aA4HeKM
        ETjkko1lR5llncAdAXzeN2Y=
X-Google-Smtp-Source: ACHHUZ6f8vyYdfqiJozi9u+SvGpSL8JArXiYGOH//CgnyhUeOA7mEhAnOxgJEEuw40NEiXdB3C+wXQ==
X-Received: by 2002:a05:6a20:1591:b0:103:9d9b:1ead with SMTP id h17-20020a056a20159100b001039d9b1eadmr1621812pzj.50.1683750252642;
        Wed, 10 May 2023 13:24:12 -0700 (PDT)
Received: from google.com ([2620:15c:9d:2:f65a:fd28:e01b:3900])
        by smtp.gmail.com with ESMTPSA id x1-20020a63f701000000b0051b8172fa68sm3636950pgh.38.2023.05.10.13.24.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 May 2023 13:24:11 -0700 (PDT)
Date:   Wed, 10 May 2023 13:24:08 -0700
From:   Dmitry Torokhov <dmitry.torokhov@gmail.com>
To:     Stephen Boyd <swboyd@chromium.org>
Cc:     Jiri Kosina <jikos@kernel.org>,
        Benjamin Tissoires <benjamin.tissoires@redhat.com>,
        linux-kernel@vger.kernel.org, patches@lists.linux.dev,
        linux-input@vger.kernel.org
Subject: Re: [PATCH] HID: google: Don't use devm for hid_hw_stop()
Message-ID: <ZFv9aKZlZbfK1cVr@google.com>
References: <20230505232417.1377393-1-swboyd@chromium.org>
 <ZFWZ785FRHDii/+5@google.com>
 <CAE-0n521MhmdWjEb0-xwnPLQz07bMCGyXokZ3L87azYcw6_C_Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAE-0n521MhmdWjEb0-xwnPLQz07bMCGyXokZ3L87azYcw6_C_Q@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 10, 2023 at 11:51:31AM -0700, Stephen Boyd wrote:
> Quoting Dmitry Torokhov (2023-05-05 17:06:07)
> > On Fri, May 05, 2023 at 04:24:16PM -0700, Stephen Boyd wrote:
> > >
> > ...
> > > Unfortunately, the hid google hammer driver hand rolls a devm function
> > > to call hid_hw_stop() when the driver is unbound and implements an
> > > hid_driver::remove() function. The driver core doesn't call the devm
> > > release functions until _after_ the bus unbinds the driver, so the order
> > > of operations is like this:
> >
> > Excellent analysis, but the problem is not limited to the hammer driver
> > (potentially) and shalt be dealt with appropriately, at the HID bus
> > level.
> 
> Thanks. I thought of the bus level approach as well, but I was trying to
> keep the fix isolated to the driver that had the problem. I'd like to
> get the fix into the stable kernel, as this fixes a regression
> introduced by commit d950db3f80a8 ("HID: google: switch to devm when
> registering keyboard backlight LED") in v5.18.
> 
> Is the bus level approach going to be acceptable as a stable backport?

Sure, why not given the kind of stuff flowing into stable kernels. At
least this would be fixing real issue that can be triggered with a real
device.

> 
> Is it a problem to call hid_hw_stop() directly? I suppose for the
> hid-google-hammer driver we don't want to leave the led sysfs node
> hanging around after the hid_hw_stop() function has been called either,
> so some sort of forced ejection of the devm led device is needed and the
> bus level approach helps there.
> 
> I was curious to see if anything else had this problem so I did this
> poor grep to find code that isn't calling hid_hw_stop() from probe or
> remove:
> 
>   git grep -W hid_hw_stop | grep .c= | grep -v probe | grep -v remove
> 
> and I got this list (minus hid core which doesn't matter):
> 
>  drivers/hid/hid-google-hammer.c=static void hammer_stop(void *hdev)
>  drivers/hid/hid-mcp2221.c=static void mcp2221_hid_unregister(void *ptr)
>  drivers/hid/hid-wiimote-core.c=static void wiimote_destroy(struct
> wiimote_data *wdata)
>  drivers/hid/wacom_sys.c=static int wacom_parse_and_register(struct
> wacom *wacom, bool wireless)
>  drivers/hid/wacom_sys.c=static void wacom_wireless_work(struct
> work_struct *work)
>  drivers/hid/wacom_sys.c=static void wacom_mode_change_work(struct
> work_struct *work)
> 
> The wacom_sys.c ones look OK because they're during workqueues that are
> probably flushed, and wiimote_destroy() is called from an error path or
> driver remove, so it is also OK. But mcp2221_hid_unregister() has the
> same problem.
> 
> If you look at drivers/hid/hid-mcp2221.c you'll see this comment above
> mcp2221_remove() too:
> 
>  /* This is needed to be sure hid_hw_stop() isn't called twice by the
> subsystem */
>  static void mcp2221_remove(struct hid_device *hdev)
> 
> which is kinda weird. Why can't we have a devm_hid_hw_start() API that
> tells the hid bus to not call hid_hw_stop() at all in
> hid_device_remove()? That would allow us to avoid this pitfall where
> everything is moved to devm and the driver has no remove function at all
> and we forget to populate an empty one. Instead, the bus layer can know
> that hardware will be stopped with devm later.

So yes, this is another option: all bus code should exclusively use
devm* API and can not use non-managed resources. This for HID includes
disconnecting hiddev, hidraw and hidinput handlers/drivers.

FTR, I think having devm_hid_hw_start() would be nice.

> 
> >
> > Actually, it is not even limited to HID, but exists in most buses with
> > non-trivial ->remove() implementation. For example I fixed similar issue
> > in I2C in 5b5475826c52 ("i2c: ensure timely release of driver-allocated
> > resources"). I tried fixing it in SPI but Mark has some objections, and
> > wanted to fix it in the driver core, so I was thinking about it and then
> > dropped the ball. At this time I do not think fixing it at driver core
> > makes logic any clearer, so I think we just need to fix a handful of
> > buses.
> 
> Do you have a link to that discussion?

https://lore.kernel.org/lkml/YFf2RD931nq3RudJ@google.com/

> 
> -------
> 
> This got me thinking that maybe both of these approaches are wrong.
> Maybe the call to hid_close_report() should be removed from
> hid_device_remove() instead.
> 
> The device is being removed from the bus when hid_device_remove() is
> called, but it hasn't been released yet. Other devices like the hidinput
> device are referencing the hdev device because they set the hdev as
> their parent. Basically, child devices are still bound to some sort of
> driver or subsystem when the parent hdev is unbound from its driver,
> leading to a state where the child drivers could still access the hdev
> while it is being destroyed. If we remove the hid_close_report() call
> from this function it will eventually be called by hid_device_release()
> when the last reference to the device is dropped, i.e. when the child
> devices all get destroyed. In the case of hid-google-hammer, that would
> be when hid_hw_stop() is called from the devm release function by driver
> core.
> 
> The benefit of this approach is that we don't allocate a devres group
> for all the hid devices when only two drivers need it. The possible
> downside is that we keep the report around while the device exists but
> has no driver bound to it.
> 
> Here's a totally untested patch for that.
> 
> ---8<----
> diff --git a/drivers/hid/hid-core.c b/drivers/hid/hid-core.c
> index 22623eb4f72f..93905e200cae 100644
> --- a/drivers/hid/hid-core.c
> +++ b/drivers/hid/hid-core.c
> @@ -1211,8 +1211,8 @@ int hid_open_report(struct hid_device *device)
>  		hid_parser_reserved
>  	};
> 
> -	if (WARN_ON(device->status & HID_STAT_PARSED))
> -		return -EBUSY;
> +	if (device->status & HID_STAT_PARSED)
> +		hid_close_report(device);
> 
>  	start = device->dev_rdesc;
>  	if (WARN_ON(!start))
> @@ -2662,7 +2662,6 @@ static void hid_device_remove(struct device *dev)
>  			hdrv->remove(hdev);
>  		else /* default remove */
>  			hid_hw_stop(hdev);
> -		hid_close_report(hdev);
>  		hdev->driver = NULL;
>  	}

This will probably work, but it I consider this still being fragile as
at some point we might want to add some more unwinding, and we'll run
into this issue again. I would feel much safer if the order of release
followed (inversely) order of allocations more closely.

Thanks.

-- 
Dmitry
