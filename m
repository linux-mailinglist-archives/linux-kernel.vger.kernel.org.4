Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6100669799A
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 11:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231269AbjBOKPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 05:15:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42536 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229605AbjBOKPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 05:15:31 -0500
Received: from mail.3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 023B7233F9;
        Wed, 15 Feb 2023 02:15:29 -0800 (PST)
Received: from 3ffe.de (0001.3ffe.de [IPv6:2a01:4f8:c0c:9d57::1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.3ffe.de (Postfix) with ESMTPSA id 6FDA5D55;
        Wed, 15 Feb 2023 11:15:28 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2022082101;
        t=1676456128;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=PpXCooOaudyL1G2ba6OqnRgI8sSX5LWMJy3d6h9lOGs=;
        b=YsYEoNG3VU6DEEUj0Djdnsl7qpS7XCC8XjM/K9VzRRejHsmo7x62IZ6vMLzZz0neJ5GR3r
        ZsWjkuiau3tF5RwJzZ2QJRydWZQoG1kzUbZ474BSlZV11hXRtZKkRcj9ABOUwprevu9zeU
        pNW+Vn9nEGkT+tMkvaVnatiimPsq0Nn61h2CTXvO22nVOK4ojfVQ+pptZkrpB3zCzwTE2S
        MIZEOvKJmE2uyLNq1/EePC/jFTyiMP2sr2gcVmmkdc4KpUtnjlFt4imvKcaMa8YC6+/AZQ
        7n2A7Uu/G7+6i1NEEvlDXdVX7D7oG+CE2DSeyh1+O/AXGiEcyPQqnue/AXB+iA==
MIME-Version: 1.0
Date:   Wed, 15 Feb 2023 11:15:28 +0100
From:   Michael Walle <michael@walle.cc>
To:     Kumaravel.Thiagarajan@microchip.com
Cc:     gregkh@linuxfoundation.org, Tharunkumar.Pasumarthi@microchip.com,
        UNGLinuxDriver@microchip.com, arnd@arndb.de,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        srinivas.kandagatla@linaro.org
Subject: Re: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
In-Reply-To: <BN8PR11MB3668A1E8541035E257F2C500E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
References: <20230212035743.231353-1-tharunkumar.pasumarthi@microchip.com>
 <20230214082804.2761756-1-michael@walle.cc>
 <BN8PR11MB36680842890C294566A156C3E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
 <7276bef47792e489abd093e4bd0044de@walle.cc> <Y+yeyNCA48IbKOKC@kroah.com>
 <BN8PR11MB36680D97C97B4894E321CAD9E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
 <BN8PR11MB3668A1E8541035E257F2C500E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
User-Agent: Roundcube Webmail/1.4.13
Message-ID: <4124a575e7c7fe4f7d6393698970183c@walle.cc>
X-Sender: michael@walle.cc
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>> > > > > > Microchip's pci1xxxx is an unmanaged PCIe3.1a switch for
>> > > > > > consumer, industrial, and automotive applications. This
>> > > > > > switch integrates OTP and EEPROM to enable customization of
>> > > > > > the part in the field. This patch provides the OTP/EEPROM
>> > > > > > driver to support the
>> > same.
>> > > > >
>> > > > > Why isn't this driver using the nvmem subsystem which is
>> > > > > usually used for OTP and EEPROM?
>> > > > Michael, these OTP and EEPROM memories do not have any fixed
>> > > > location registers which store values (Eg. mac address, config
>> > > > parameters, etc) at fixed offsets.
>> > > > It stores a bunch of records, each of which has some data to be
>> > > > written into the device's hardware registers at different locations.
>> > > > These records are directly consumed by the hardware and
>> > > > interpreted without the involvement of the software.
>> > > > Therefore, we don't require any OTP / EEPROM register map to be
>> > > > input to the OS / driver through device tree or board files.
>> > > > I only had to enumerate two separate block devices using the
>> > > > driver so that the config binary files can be overlayed using
>> > > > the dd command.
>> > > > Since this is not fitting like a conventional nvme device, I
>> > > > didn't choose the nvme subsystem.
>> > > > Please let me know your thoughts / comments if any.
>> > >
>> > > So this is only for provisioning. i.e. during manufacturing a
>> > > board which uses this PCI bridge? There are no kernel users, nor
>> > > is there a common interface towards user-space. But just some
>> > > block device (why not a char device?) exposed to userspace. I
>> > > presume there is a companion userspace application for it? Why do
>> > > you take the extra step and have a (random) kernel interface, you
>> > > could also just access the PCI device directly from userspace
>> > > within your companion application, e.g. through libpci.
>> >
>> > Yeah, why not just use userspace, I missed that, thanks!
>> Greg & Michael, I do not want to expose the entire or even partial set
>> of device registers to the user space access directly for safety 
>> reasons.

I presume that utility will need root anyway. IOW, it doesn't make
sense to be used as a normal user.

>> I think hardware registers shall be accessible only through safe and
>> robust kernel mode components and that the user space shall only be
>> able to access the device through the kernel mode services.
>> I want the user to use the hardware only in those ways designated by
>> the driver.

I don't get that point. It is not something you are doing regularly
or maybe even in a running system. I guess you'll have to do a reboot
anyway after you modified some registers defaults. Anyway, it's still
only for provisioning.

>> We were using the "busybox devmem" to access the hardware registers
>> directly and to program the EEPROM / OTP.
>> But we understood that it cannot be an end user solution in all cases
>> and based on some of the operating environments, there can be some
>> restrictions in opening the direct hardware access to the user space.

Yes, then just build a tool around libpci as I've mentioned. Who is the
user here? An OEM? An end-user? What would an end-user update within
your PCI bridge?

As a matter of fact, it actually makes it harder for a user because
he will also need this kernel driver (which might be disabled for
whatever reason).

>> Please let me know your thoughts / comments if any.
> 
> I missed one more important point. This driver is targeted not just
> for the manufacturing environment.
> we want to be able to update the OTP / EEPROM when the device is in
> the field also.

What would be an example of that?

-michael
