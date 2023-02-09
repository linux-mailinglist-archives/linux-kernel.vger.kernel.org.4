Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8EB1F68FFEE
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Feb 2023 06:39:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229793AbjBIFjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Feb 2023 00:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBIFjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Feb 2023 00:39:08 -0500
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DF1331E34;
        Wed,  8 Feb 2023 21:39:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1675921147; x=1707457147;
  h=date:from:to:cc:subject:message-id:references:
   mime-version:in-reply-to;
  bh=XNzVc05Fuzc2StlWmbJqDQ2OQF9U1yLDx5zjdvbyMOw=;
  b=TfDlAsmFyS4mvJZyKdU/pydy+7KN982rFWmoTWWmXXg03Xg/e6P5iAWb
   Id18xZVLXt/akxPvaXMluhjKLZmDBE2SsnLJenve5imncCgXQu7yCkjEI
   15n1ze4t6FdF4ESKof1lG5t8LSi8mSTkWARmH7fgodkkPbdsEMZYV6n13
   yTtjt201r9QV2j5kwQAFLaryYVz8V0jO5hrQ1LG0N2UD9f2sXC/LXiJqO
   JqoavyXrIwojWk4HTYEGppR/YhfopdFd3AI5Q9by5nLjlz1NTIK27p5bc
   NJNs4yIUG1cGUBBRa5gvqfHOv8MKpxpWnitcF7XJbo2kumxHTzlbnJsEN
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="392407198"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="392407198"
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Feb 2023 21:39:06 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=McAfee;i="6500,9779,10615"; a="736187333"
X-IronPort-AV: E=Sophos;i="5.97,281,1669104000"; 
   d="scan'208";a="736187333"
Received: from black.fi.intel.com ([10.237.72.28])
  by fmsmga004.fm.intel.com with ESMTP; 08 Feb 2023 21:39:05 -0800
Received: by black.fi.intel.com (Postfix, from userid 1001)
        id EE28A1A6; Thu,  9 Feb 2023 07:39:43 +0200 (EET)
Date:   Thu, 9 Feb 2023 07:39:43 +0200
From:   Mika Westerberg <mika.westerberg@linux.intel.com>
To:     Mauro Lima <mauro.lima@eclypsium.com>
Cc:     broonie@kernel.org, michael@walle.cc, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] spi: intel: Update help text of PCI driver
Message-ID: <Y+SHH2+VqLoQ+6Ss@black.fi.intel.com>
References: <20230208175253.117714-1-mauro.lima@eclypsium.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20230208175253.117714-1-mauro.lima@eclypsium.com>
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Feb 08, 2023 at 02:52:53PM -0300, Mauro Lima wrote:
> Modern intel hardware uses controllers that work in hardware
> sequencing mode. In this mode, the controller exposes a subset
> of operations, like read, write and erase, making it easier
> and less error-prone for use.
> On the other hand, most of the controllers handled by the
> platform driver use software sequencing that exposes the
> entire set of opcodes i.e. include the low-level operations
> available from the controller.
> 
> Since the PCI driver works with modern controllers, remove the
> DANGEROUS tag from it.
> Update the driver's help text and leave the DANGEROUS tag of
> the platform driver.

This is not done in this commit. You just update the help texts, right?

> Signed-off-by: Mauro Lima <mauro.lima@eclypsium.com>
> ---
>  For the record of the base commit:
> 
>  Given that the PCI driver handles controllers that only work with
>  hardware sequencing, we can remove the dangerous tag.
>  This patch is the second part of Mika's suggestion [1].
>  The first part was accepted in [2].
> 
>  [1] https://lore.kernel.org/r/Y1d9glOgHsQlZe2L@black.fi.intel.com/
>  [2] https://lore.kernel.org/linux-spi/20230201205455.550308-1-mauro.lima@eclypsium.com/
> 
>  This patch continues the work addressing the comments in the previous
>  patch adding information about hardware and software sequencing.
>  Discussion: https://lore.kernel.org/r/20230206183143.75274-1-mauro.lima@eclypsium.com/
> 
>  drivers/spi/Kconfig | 21 +++++++++++++--------
>  1 file changed, 13 insertions(+), 8 deletions(-)
> 
> diff --git a/drivers/spi/Kconfig b/drivers/spi/Kconfig
> index 3a362c450cb6..9eb3c72d7cd8 100644
> --- a/drivers/spi/Kconfig
> +++ b/drivers/spi/Kconfig
> @@ -454,13 +454,16 @@ config SPI_INTEL_PCI
>  	select SPI_INTEL
>  	help
>  	  This enables PCI support for the Intel PCH/PCU SPI controller in
> -	  master mode. This controller is present in modern Intel hardware
> -	  and is used to hold BIOS and other persistent settings. This
> -	  driver only supports hardware sequencing mode. Using this
> -	  driver it is possible to upgrade BIOS directly from Linux.
> +	  master mode. This controller is used to hold BIOS and other
> +	  persistent settings. Controllers present in modern Intel hardware
> +	  only work in hardware sequencing mode, this means that the
> +	  controller exposes a subset of operations that makes it easier
> +	  and safer to use. Using this driver it is possible to upgrade BIOS

I would remove the "easier" part because from user perspective there is
really no difference.

> +	  directly from Linux.
>  
> -	  Say N here unless you know what you are doing. Overwriting the
> -	  SPI flash may render the system unbootable.
> +	  Say N here unless you want to overwrite the flash memory and

Putting it like this surely scares all distro folks from ever enabling
this ;-)

  "Say N here unless you want to overwrite the flash memory.."

At least to me this means that if you enable this option your flash
memory will be overwritten.

> +	  know what you are doing or you want to read the memory's content.
> +	  Overwriting the SPI flash may render the system unbootable.
>  
>  	  To compile this driver as a module, choose M here: the module
>  	  will be called spi-intel-pci.
> @@ -473,8 +476,10 @@ config SPI_INTEL_PLATFORM
>  	help
>  	  This enables platform support for the Intel PCH/PCU SPI
>  	  controller in master mode that is used to hold BIOS and other
> -	  persistent settings. Most of these controllers are using
> -	  software sequencing mode. Using this driver it is possible to
> +	  persistent settings. Most of these controllers work in
> +	  software sequencing mode, which means that the controller
> +	  exposes the full set of operations that supports, making it
> +	  more complex for use. Using this driver it is possible to

Here,

exposes the low level SPI-NOR opcodes to the software

I think is better. Also here too drop the "complex" as it looks similar
from user perspective.

>  	  upgrade BIOS directly from Linux.
>  
>  	  Say N here unless you know what you are doing. Overwriting the
> 
> base-commit: 7db738b5fea4533fa217dfb05c506c15bd0964d9
> -- 
> 2.39.1
