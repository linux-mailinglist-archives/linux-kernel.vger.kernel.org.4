Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 08BF35EF2D3
	for <lists+linux-kernel@lfdr.de>; Thu, 29 Sep 2022 11:56:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235118AbiI2J43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 29 Sep 2022 05:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234836AbiI2J4Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 29 Sep 2022 05:56:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A86CDF07A;
        Thu, 29 Sep 2022 02:56:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3F878B82366;
        Thu, 29 Sep 2022 09:56:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7FADDC433D6;
        Thu, 29 Sep 2022 09:56:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=linuxfoundation.org;
        s=korg; t=1664445381;
        bh=upFGcV6kX6erz0a207wkFQ+MRfQh+tRT2Z6zBaX++jM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=ctxRBx4CIAlYjZ/7EpGnprUk8+hC0LFQs+0bYqIR10bip14uZssMKut5T3gFZMbiq
         4mRzx7E1HKCXg/Yfh8Gkf5KDjI+FaLDBL8a/EZfYZ98zD0iDa5/mpJcQ/quiVe6Qvi
         qIATTTZmtJ3dLDh2su6w4PgLhyH1zpIisF70KVWc=
Date:   Thu, 29 Sep 2022 11:56:18 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Quan Nguyen <quan@os.amperecomputing.com>
Cc:     macro@orcam.me.uk, Lee Jones <lee@kernel.org>,
        Bagas Sanjaya <bagasdotme@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Jonathan Corbet <corbet@lwn.net>,
        Derek Kiernan <derek.kiernan@xilinx.com>,
        Dragan Cvetic <dragan.cvetic@xilinx.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Thu Nguyen <thu@os.amperecomputing.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-hwmon@vger.kernel.org, linux-doc@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Open Source Submission <patches@amperecomputing.com>,
        Phong Vo <phong@os.amperecomputing.com>,
        thang@os.amperecomputing.com
Subject: Re: [PATCH v9 6/9] docs: misc-devices: (smpro-misc) Add documentation
Message-ID: <YzVrwo5oUTx/0cxl@kroah.com>
References: <20220929094321.770125-1-quan@os.amperecomputing.com>
 <20220929094321.770125-7-quan@os.amperecomputing.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220929094321.770125-7-quan@os.amperecomputing.com>
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 29, 2022 at 04:43:18PM +0700, Quan Nguyen wrote:
> Adds documentation for the Ampere(R)'s Altra(R) SMpro misc driver.
> 
> Signed-off-by: Thu Nguyen <thu@os.amperecomputing.com>
> Signed-off-by: Quan Nguyen <quan@os.amperecomputing.com>
> ---
> Changes in v9:
>   + Update SPDX licence                          [Greg]
> 
> Changes in v8:
>   + Update to reflect single value per sysfs     [Quan]
> 
> Changes in v7:
>   + None
> 
> Changes in v6:
>   + First introduced in v6 [Quan]
> 
>  Documentation/misc-devices/index.rst      |  1 +
>  Documentation/misc-devices/smpro-misc.rst | 82 +++++++++++++++++++++++
>  2 files changed, 83 insertions(+)
>  create mode 100644 Documentation/misc-devices/smpro-misc.rst
> 
> diff --git a/Documentation/misc-devices/index.rst b/Documentation/misc-devices/index.rst
> index b74b3b34a235..b40cd1b402f7 100644
> --- a/Documentation/misc-devices/index.rst
> +++ b/Documentation/misc-devices/index.rst
> @@ -28,6 +28,7 @@ fit into other categories.
>     oxsemi-tornado
>     pci-endpoint-test
>     smpro-errmon
> +   smpro-misc
>     spear-pcie-gadget
>     uacce
>     xilinx_sdfec
> diff --git a/Documentation/misc-devices/smpro-misc.rst b/Documentation/misc-devices/smpro-misc.rst
> new file mode 100644
> index 000000000000..d21be4a09e69
> --- /dev/null
> +++ b/Documentation/misc-devices/smpro-misc.rst
> @@ -0,0 +1,82 @@
> +.. SPDX-License-Identifier: GPL-2.0-only
> +
> +Kernel driver Ampere(R) Altra(R) SMpro miscellaneous
> +====================================================
> +
> +Supported chips:
> +
> +  * Ampere(R) Altra(R)
> +
> +    Prefix: 'smpro'
> +
> +    Reference: Altra SoC BMC Interface Specification
> +
> +Author: Thu Nguyen <thu@os.amperecomputing.com>
> +
> +Description
> +-----------
> +
> +This driver support the monitoring and configuration of various miscellaneous
> +data provided by Ampere(R) Altra(R) SMpro processor.
> +At this time, these include:
> +
> +  * Reading Boot Progress information
> +  * Configuring SoC Power Limit
> +
> +Sysfs entries
> +-------------
> +
> +1) Boot progress
> +
> +SMpro misc driver creates the sysfs files ``boot_progress``.
> +The format of ``boot_progress`` file is as below::
> +
> +<boot stage><boot status><boot progress>
> +
> +Where:
> +
> +* Boot stage::
> +
> +    0: SMpro firmware booting.
> +    1: PMpro firmware booting.
> +    2: ATF BL1 firmware booting.
> +    3: DDR initialization.
> +    4: DDR training report status.
> +    5: ATF BL2 firmware booting.
> +    6: ATF BL31 firmware booting.
> +    7: ATF BL32 firmware booting.
> +    8: UEFI firmware booting.
> +    9: OS booting.
> +
> +* Boot status::
> +
> +    0: Not started.
> +    1: Started.
> +    2: Complete without error.
> +    3: Failure.
> +
> +* boot progress: 32 bits boot progress code
> +
> +The sysfs ``boot_progress`` only reports the boot state when the host is booting.
> +If the host is already booted, it returns latest state.
> +
> +Example::
> +
> +    #cat boot_progress
> +    0102808454A8
> +
> +2) SoC Power Limit
> +
> +SMpro misc driver creates the sysfs file ``soc_power_limit`` to get/set the SoC Power Limit.
> +
> +Reading this sysfs return the current setting of SoC Power Limit (W) in decimal string.
> +Writing the desired value in decimal string to set the SoC Power Limit in Watt (W).
> +The range of SoC Power Limit is 90-500(W) and will be ignored if out of range.
> +
> +Example::
> +
> +    #cat soc_power_limit
> +    90
> +    #echo 95 > soc_power_limit
> +    #cat soc_power_limit
> +    95
> -- 
> 2.35.1
> 

Why is this file needed at all if you have the correct
Documentation/ABI/ entries instead?

thanks,

greg k-h
