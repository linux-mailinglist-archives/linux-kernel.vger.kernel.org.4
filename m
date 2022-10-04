Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CACDE5F47FB
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Oct 2022 18:57:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229781AbiJDQ5H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Oct 2022 12:57:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229846AbiJDQ5E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Oct 2022 12:57:04 -0400
Received: from mail-il1-x12f.google.com (mail-il1-x12f.google.com [IPv6:2607:f8b0:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77E1E5D13D
        for <linux-kernel@vger.kernel.org>; Tue,  4 Oct 2022 09:57:01 -0700 (PDT)
Received: by mail-il1-x12f.google.com with SMTP id a2so7100179iln.13
        for <linux-kernel@vger.kernel.org>; Tue, 04 Oct 2022 09:57:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc:subject:date:message-id:reply-to;
        bh=c+lxrtVmYP2d38P1SdALs4rrUTawssSz9RKxR6kOlUc=;
        b=jyR4LtfRzvLZui//vYHZIKALA4cMdIiGdfojpITegWWlvFIQSaSap+N3mbcIUyRA81
         tN0HPWH+rl422NBxc4ODVxhh0FufxIXTKjwHLe0N73Hzm6sYkUoa9vDwhyo3HC3s/La9
         l7xKhyZHzcKl3pKrcVkIEv+/QWhV9CZ7pdkeQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc:subject:date
         :message-id:reply-to;
        bh=c+lxrtVmYP2d38P1SdALs4rrUTawssSz9RKxR6kOlUc=;
        b=c2Vxzn1tZRCdGMcZ3g2CKBhEfJe6yxQq1/e5lP0ZncO/x9qL3p1gZXWWaKrYkLQ5mF
         TjnLUBaHJ4zPtI6xcOtJ4SaIRFDI7v2fihPoR3EwOnylW/OgST8F0dlI0E10wVN9x2rb
         pBNC/5HUUWgfSnK8O3eYuFRPIpb+rbwIy9uPqjLgz4bifHA5ZFxAHJJ4xn7tORrvp9Ko
         gDHWlzB8xNkr+mPNJhvwOKs52befNUt9ABmabueLiO/GkkfV4WxL/xHVtbQXhkpDeTaG
         cXOW/alIVkGOYDp6rD/KmQaJuvEN4vIV8IXhcf2bSy/WXuk9BG9BTDfsP2aya44RqRHy
         H/gQ==
X-Gm-Message-State: ACrzQf10OMoOSttmqOdd6nNUDyaJMQK3dpsBApEFYhyK7IlLeqGckUaV
        M85iYNFM8e9ICLb016ydkYbJ7A==
X-Google-Smtp-Source: AMsMyM48IFcKHxg+s1j2qhJ7PaQkBuYus2BtblotwI9gOl/qgWtJETmMU6HgxwoYP6O0hfgPX9KacQ==
X-Received: by 2002:a05:6e02:1aaa:b0:2f8:1908:7099 with SMTP id l10-20020a056e021aaa00b002f819087099mr12178915ilv.166.1664902620369;
        Tue, 04 Oct 2022 09:57:00 -0700 (PDT)
Received: from chromium.org (c-73-217-34-248.hsd1.co.comcast.net. [73.217.34.248])
        by smtp.gmail.com with ESMTPSA id w1-20020a056638030100b0036338050cb7sm2166108jap.108.2022.10.04.09.56.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Oct 2022 09:57:00 -0700 (PDT)
Date:   Tue, 4 Oct 2022 10:56:58 -0600
From:   Jack Rosenthal <jrosenth@chromium.org>
To:     Greg KH <gregkh@linuxfoundation.org>
Cc:     linux-kernel@vger.kernel.org, chrome-platform@lists.linux.dev,
        Stephen Boyd <swboyd@chromium.org>,
        Tzung-Bi Shih <tzungbi@kernel.org>,
        Guenter Roeck <groeck@chromium.org>,
        Julius Werner <jwerner@chromium.org>
Subject: Re: [PATCH v12] firmware: google: Implement cbmem in sysfs driver
Message-ID: <Yzxl2oczTtwEvIqt@chromium.org>
References: <20221004003811.4075765-1-jrosenth@chromium.org>
 <Yzvz9hn1G8rU4VaO@kroah.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yzvz9hn1G8rU4VaO@kroah.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-10-04 at 10:51 +0200, Greg KH wrote:
> > +		A list of ids known to Coreboot can be found in the coreboot
> > +		source tree at
> > +		``src/commonlib/bsd/include/commonlib/bsd/cbmem_id.h``.
> 
> That will not age well, why not point to the reference in the kernel
> tree instead?

There is no copy in the kernel tree.

> > +What:		/sys/bus/coreboot/devices/cbmem-<id>/address
> > +Date:		August 2022
> > +Contact:	Jack Rosenthal <jrosenth@chromium.org>
> > +Description:
> > +		This is the pyhsical memory address that the CBMEM entry's data
> > +		begins at.
> 
> In hex?  Decimal?
> 
> > +
> > +What:		/sys/bus/coreboot/devices/cbmem-<id>/size
> > +Date:		August 2022
> > +Contact:	Jack Rosenthal <jrosenth@chromium.org>
> > +Description:
> > +		This is the size of the CBMEM entry's data.
> 
> In hex?  Decimal?  Octal?  Binary?  Be specific please :)

Added "hexadecimal" and an example for both in v13.

> > +What:		/sys/bus/coreboot/devices/cbmem-<id>/id
> > +Date:		August 2022
> > +Contact:	Jack Rosenthal <jrosenth@chromium.org>
> > +Description:
> > +		This is the CBMEM id corresponding to the entry.
> 
> so "id" is the same as "<id>" here?  Why is that needed?

Removed in v13, agreee it's reduntant with the device name now.

> > +	  Say Y here to enable the kernel to search for Coreboot CBMEM
> > +	  entries, and expose the memory for each entry in sysfs under
> > +	  /sys/bus/coreboot/devices/cbmem-<id>.
> 
> Module name?

Added in v13.

> 
> > +
> >  config GOOGLE_COREBOOT_TABLE
> >  	tristate "Coreboot Table Access"
> >  	depends on HAS_IOMEM && (ACPI || OF)
> > diff --git a/drivers/firmware/google/Makefile b/drivers/firmware/google/Makefile
> > index d17caded5d88..8151e323cc43 100644
> > --- a/drivers/firmware/google/Makefile
> > +++ b/drivers/firmware/google/Makefile
> > @@ -7,5 +7,8 @@ obj-$(CONFIG_GOOGLE_MEMCONSOLE)            += memconsole.o
> >  obj-$(CONFIG_GOOGLE_MEMCONSOLE_COREBOOT)   += memconsole-coreboot.o
> >  obj-$(CONFIG_GOOGLE_MEMCONSOLE_X86_LEGACY) += memconsole-x86-legacy.o
> >  
> > +# Must come after coreboot_table.o, as this driver depends on that bus type.
> 
> Doesn't the linker handle this for us?

Not in the case of compiling as a built-in module: I observed in this
scenario the order in the Makefile deterimined the module initialization
order, and, if this were to be listed alphabetically, the coreboot_table
module would not have been loaded before the cbmem module.

> > +	entry->size = dev->cbmem_entry.entry_size;
> 
> Ah nevermind you set the size here.

The size that stat reports is still 0, as when creating this as a device
attribute, the size is not known until the driver is probed.  I observed
this in some other sysfs attributes, so I imagine it's a common pattern.

> > +/* Corresponds to LB_TAG_CBMEM_ENTRY */
> > +struct lb_cbmem_entry {
> > +	u32 tag;
> > +	u32 size;
> 
> little or big endian?

It's the native host endianness, as coreboot wrote these tables from the
same CPU that Linux is running on.
