Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8E540699397
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 12:49:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229678AbjBPLtX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Feb 2023 06:49:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229575AbjBPLtV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Feb 2023 06:49:21 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35C9E4DBE0;
        Thu, 16 Feb 2023 03:49:20 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E482BB824B3;
        Thu, 16 Feb 2023 11:49:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 45F0CC433EF;
        Thu, 16 Feb 2023 11:49:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676548157;
        bh=9vmuzx3tH6MHeToyGwqVw/F+KPzFPeoWov9zhDgvWbA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=W7v0sWiqfGK/oPS+QDKM604v5mm/OXkQ52M7ak0hvSnFlSg7Lvae5AwUXMS+GoBzF
         xkxSMfDiymFEDNKth8SD+T9R7IgRWJSZCmp+uPnr1MDdXeQ6+9MSqG5LpQJ3QdFEjC
         zThsiToJSD1VuE1k62ADoCleoR0teQ0HRMkQrc3s=
Date:   Thu, 16 Feb 2023 12:49:15 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumaravel.Thiagarajan@microchip.com
Cc:     michael@walle.cc, Tharunkumar.Pasumarthi@microchip.com,
        UNGLinuxDriver@microchip.com, arnd@arndb.de,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Subject: Re: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Message-ID: <Y+4YO7HSmETanIU2@kroah.com>
References: <20230212035743.231353-1-tharunkumar.pasumarthi@microchip.com>
 <20230214082804.2761756-1-michael@walle.cc>
 <BN8PR11MB36680842890C294566A156C3E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
 <7276bef47792e489abd093e4bd0044de@walle.cc>
 <Y+yeyNCA48IbKOKC@kroah.com>
 <BN8PR11MB36680D97C97B4894E321CAD9E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
 <BN8PR11MB3668A1E8541035E257F2C500E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
 <Y+zFo4SP5L/KkT/v@kroah.com>
 <BN8PR11MB3668C37EFBB42FB3FFC7618FE9A09@BN8PR11MB3668.namprd11.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <BN8PR11MB3668C37EFBB42FB3FFC7618FE9A09@BN8PR11MB3668.namprd11.prod.outlook.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 16, 2023 at 11:39:12AM +0000, Kumaravel.Thiagarajan@microchip.com wrote:
> > -----Original Message-----
> > From: Greg KH <gregkh@linuxfoundation.org>
> > Sent: Wednesday, February 15, 2023 5:15 PM
> > To: Kumaravel Thiagarajan - I21417 <Kumaravel.Thiagarajan@microchip.com>
> > Subject: Re: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
> > OTP/EEPROM driver for the pci1xxxx switch

What is this header for?

Please fix your email client to not add this to the body of the text...

> > > > Greg & Michael, I do not want to expose the entire or even partial
> > > > set of device registers to the user space access directly for safety
> > reasons.
> > 
> > But that's all exposed here through this block device, right?
> The block device created by this driver does not expose the device registers to the user space applications.

What is it exposing?

And please use line-wrapping :)

> The device hardware provides separate set of registers to read and write into the OTP memory and EEPROM.
> The driver uses these hardware registers and abstracts the programming logic inside and exposes the only the memory as devices to the user space.

What memory is being exposed?  And how?

> I don't have any user program to program the device. I use the Linux dd command only.
> If I want to view the contents of the memory, I can use any hex editor tool in Linux this way.

Exposing the memory of a device as a block device is not normal, it
should just be mmapped, right?

> > And this is already exposed to userspace today, no need to add anything the
> > kernel already provides this.
> Can you explain this? Are you referring to any sysfs directories / files? What is the necessity to do this? I am trying to understand this.

PCI device accesses can go through userspace directly.  Is this just
memory mapped in your PCI device?

> If this is for any debug purpose and whether kernel does this under some conditional compilation or is that the default behavior?

Is this only for debugging?  If so, please document it as such so that
no one accidentally enables it as a valid build option.

> Even if the user is a super user, should he be allowed to access the device hardware registers mandatorily. It should depend on the policy the system owner want to adopt. Right?

Again, is this PCI memory that can be accessed directly?

And again, a block device is very odd, that is not the normal way to
access a device's memory.

thanks,

greg k-h
