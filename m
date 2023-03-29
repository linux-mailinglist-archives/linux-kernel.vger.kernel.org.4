Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FC9E6CD737
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 12:03:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231445AbjC2KDW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 06:03:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbjC2KDQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 06:03:16 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D49C219A;
        Wed, 29 Mar 2023 03:03:11 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 92620B8221B;
        Wed, 29 Mar 2023 10:03:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0B6BEC4339C;
        Wed, 29 Mar 2023 10:03:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1680084189;
        bh=sXjAXS7GKfTMqiOarTnLtqfJGk5+jgMH5pzTa1vvvNE=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=kYf7Zo7Jp9KyMrVD0BPvZN+YAK1AZ77mCvpLJ1djMCOVDezO1xZ90TxnX81w3FtUx
         psTxuZ7pwFdFXd4sgjQY41J0rC9KmB9HecTb2brI8KySB3z/U5Tn81zcBOZZ8vLWGb
         8MAl/7+pdID8GR5g8gZJ4hSb/L0n0Yh/Wl+Ddyzw=
Date:   Wed, 29 Mar 2023 12:03:06 +0200
From:   Greg KH <gregkh@linuxfoundation.org>
To:     "Vaibhaav Ram T.L" <vaibhaavram.tl@microchip.com>
Cc:     arnd@arndb.de, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org, kumaravel.thiagarajan@microchip.com,
        tharunkumar.pasumarthi@microchip.com, UNGLinuxDriver@microchip.com
Subject: Re: [PATCH v8 char-misc-next 5/5] misc: microchip: pci1xxxx: Add
 documentation for sysfs bin attributes
Message-ID: <ZCQM2hymNEneoSTa@kroah.com>
References: <20230328144008.4113-1-vaibhaavram.tl@microchip.com>
 <20230328144008.4113-6-vaibhaavram.tl@microchip.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328144008.4113-6-vaibhaavram.tl@microchip.com>
X-Spam-Status: No, score=-2.5 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 08:10:08PM +0530, Vaibhaav Ram T.L wrote:
> From: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> 
> This patch contains Documentation for Microchip PCI1XXXX OTP/EEPROM sysfs
> bin attributes.
> 
> Co-developed-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Tharun Kumar P <tharunkumar.pasumarthi@microchip.com>
> Signed-off-by: Kumaravel Thiagarajan <kumaravel.thiagarajan@microchip.com>
> Signed-off-by: Vaibhaav Ram T.L <vaibhaavram.tl@microchip.com>
> ---
>  Documentation/ABI/stable/sysfs-devices-mchp-pci1xxxx | 11 +++++++++++
>  1 file changed, 11 insertions(+)
>  create mode 100644 Documentation/ABI/stable/sysfs-devices-mchp-pci1xxxx
> 
> diff --git a/Documentation/ABI/stable/sysfs-devices-mchp-pci1xxxx b/Documentation/ABI/stable/sysfs-devices-mchp-pci1xxxx
> new file mode 100644
> index 000000000000..0913c7b01990
> --- /dev/null
> +++ b/Documentation/ABI/stable/sysfs-devices-mchp-pci1xxxx
> @@ -0,0 +1,11 @@
> +What:		/sys/devices/pciXXXX:XX/XXXX:XX:XX.X/../mchp_pci1xxxx_gp.gp_otp_e2p.n/pci1xxxx_eeprom
> +Date:		March 27, 2023
> +KernelVersion:	6.3
> +Contact:	Vaibhaav Ram T.L <vaibhaavram.tl@microchip.com>
> +Description:	This bin file is used for writing into and reading from Microchip PCI1XXXX EEPROM

"bin"?  Userspace doesn't know what that means.

But again, why can't you use the eeprom api instead?

thanks,

greg k-h
