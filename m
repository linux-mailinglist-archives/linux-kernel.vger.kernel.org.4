Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1BCFE69C7DE
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 10:45:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231370AbjBTJpR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 04:45:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231126AbjBTJpQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 04:45:16 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0FDD26AF;
        Mon, 20 Feb 2023 01:45:14 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 784B660CD4;
        Mon, 20 Feb 2023 09:45:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84992C433D2;
        Mon, 20 Feb 2023 09:45:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1676886313;
        bh=4wWJoSi2kzlrvECDpu4ylkarcYS/J8ZQa3dO7cbClIA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=t4vR6/QpJIYq4Iansg/lQ5ogbUJ0prpXHUY+Vqj7QhUt6UCHWJkIaIuqiUOCf2F83
         gk77TBJuld9vtTflU38d5U8MxcaGGwXr7L4Ao5ZPx4juOvzy+JDGbGkMal2FnxqBEG
         Z6DUJP3iunfdnk349bpzyzbxIrozUObHBEm3Iq1s=
Date:   Mon, 20 Feb 2023 10:45:11 +0100
From:   Greg KH <gregkh@linuxfoundation.org>
To:     Kumaravel.Thiagarajan@microchip.com
Cc:     arnd@arndb.de, linux-gpio@vger.kernel.org, michael@walle.cc,
        srinivas.kandagatla@linaro.org, linux-kernel@vger.kernel.org,
        UNGLinuxDriver@microchip.com, Tharunkumar.Pasumarthi@microchip.com
Subject: Re: [PATCH v5 char-misc-next] misc: microchip: pci1xxxx: Add
 OTP/EEPROM driver for the pci1xxxx switch
Message-ID: <Y/NBJ5xzUoNHEOm2@kroah.com>
References: <7276bef47792e489abd093e4bd0044de@walle.cc>
 <Y+yeyNCA48IbKOKC@kroah.com>
 <BN8PR11MB36680D97C97B4894E321CAD9E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
 <BN8PR11MB3668A1E8541035E257F2C500E9A39@BN8PR11MB3668.namprd11.prod.outlook.com>
 <Y+zFo4SP5L/KkT/v@kroah.com>
 <BN8PR11MB3668C37EFBB42FB3FFC7618FE9A09@BN8PR11MB3668.namprd11.prod.outlook.com>
 <Y+4YO7HSmETanIU2@kroah.com>
 <b8663c30e7b46955c5da4794919acf5f518aae52.camel@microchip.com>
 <Y+9HOdHGqmPP/Ude@kroah.com>
 <e1375c213b496b86df3f61d04003d94390c80240.camel@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e1375c213b496b86df3f61d04003d94390c80240.camel@microchip.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 20, 2023 at 09:31:45AM +0000, Kumaravel.Thiagarajan@microchip.com wrote:
> > I do not recommend using a block interface for this at all.  Why not
> > the
> > "normal" EEPROM interface that the kernel has today (i.e. a binary
> > sysfs
> > file)?  That way you can mmap it and edit locations how ever you
> > want.
> Greg, I have one question about the sysfs interface. If OTP and EEPROM
> are enumerated as two sysfs files of 8KB each, will that start
> occupying the RAM permamently or is the swapping in and out of the RAM
> handled automatically by the kernel based on the user trying to access
> it.

It depends on exactly what you are doing here with the binary sysfs
file.  Try it yourself and see how it works.

thanks,

greg k-h
