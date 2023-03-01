Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83A426A6972
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Mar 2023 10:05:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229700AbjCAJFB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Mar 2023 04:05:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229632AbjCAJEy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Mar 2023 04:04:54 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8FBF15566;
        Wed,  1 Mar 2023 01:04:52 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 6E5FDB80EFA;
        Wed,  1 Mar 2023 09:04:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AA3E8C433EF;
        Wed,  1 Mar 2023 09:04:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1677661490;
        bh=nnWBYCpOWlTZ5z+s2bo2GClbIpIKpWepFx5Lp7X+MMk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Xy575dxmp7KOEPQ3dRySjV+t9rt0HRXVkPTFFpVCD9CgtqTHolOJL2p3Yg1u1pA83
         OBwCGNc6C8k3ZL3bdW1Uhqv2v3ifGqzl6HklCpkt16Hks0getdsvDYN42FK5Qa18bU
         9SVa1TpG/t0MwmsBGcVToLrVf/pIMRkMRVPnCrbXcUlKXj11bBbCNOqRknSb0A+s1O
         604+VCCzga2yw/BJ2+Dpvxupxvh4HFViJdbGk6xVceprBanHBTbyZNmCcaJNjoi8aW
         rbRg0e1eOOIG6mcXcpu3hK9ZsS+IbtOq5GRbwQcdYQtMxbbS3FITc//PHL63fuXIe+
         l3VosKQKL7GgQ==
Date:   Wed, 1 Mar 2023 09:04:45 +0000
From:   Lee Jones <lee@kernel.org>
To:     Nick Alcock <nick.alcock@oracle.com>
Cc:     DLG Adam Ward <DLG-Adam.Ward.opensource@dm.renesas.com>,
        "mcgrof@kernel.org" <mcgrof@kernel.org>,
        "linux-modules@vger.kernel.org" <linux-modules@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>,
        Support Opensource <support.opensource@diasemi.com>
Subject: Re: [PATCH 18/27] kbuild, mfd: remove MODULE_LICENSE in non-modules
Message-ID: <Y/8VLcMlojbFmhZy@google.com>
References: <20230222121453.91915-1-nick.alcock@oracle.com>
 <20230222121453.91915-19-nick.alcock@oracle.com>
 <OS3PR01MB8460D00B7C988DCC13173CAAC2AA9@OS3PR01MB8460.jpnprd01.prod.outlook.com>
 <Y/duxo1aKFibuZtF@google.com>
 <87ttzcmbgu.fsf@esperi.org.uk>
 <OS3PR01MB8460AA34CBDD0C2BBE6F2399C2A89@OS3PR01MB8460.jpnprd01.prod.outlook.com>
 <87zg8zi71g.fsf@esperi.org.uk>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <87zg8zi71g.fsf@esperi.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 27 Feb 2023, Nick Alcock wrote:

> On 24 Feb 2023, DLG Adam Ward told this:
> 
> > On 23/02/2023 19:25, Nick Alcock wrote:
> >
> >>> Makes sense - but if you need to do a V2, would you mind removing the erroneous claim on DA9055 at the same time?
> >
> >>I don't know what this means. There are two references to DA9055 in this patch, both in context (not in modified lines), one in drivers/mfd/da9055-core.c, the other in rivers/mfd/da9055-i2c.c. To me these both seem likely to be DA9055-related. Are you saying that one of them isn't?
> >
> > The comment was followed by this link - https://elixir.bootlin.com/linux/latest/source/drivers/mfd/Kconfig#L36
> > This files talks about the driver being a module, but, as you correctly point out, it is not.
> > And never has been.
> > So it is worth removing.
> 
> Ah! I never even thought of auditing the Kconfigs for erroneous
> statements of modularity: that's a much harder-to-automate job.
> 
> I'm not planning to do this in general any time soon (because I'd have
> to soup up Kconfig parsers and maybe write my own just for this), but
> here's a reroll of this one patch that drops the erroneous Kconfig help
> text:
> 
> -- >8 --

Can you submit this as an orthogonal v2 please?
 
> From 06d491176513f9fcd699871cb6815534068b664a Mon Sep 17 00:00:00 2001
> From: Nick Alcock <nick.alcock@oracle.com>
> Date: Thu, 23 Feb 2023 19:10:03 +0000
> Subject: [PATCH v2 18/27] mfd: remove MODULE_LICENSE in non-modules
> 
> Since commit 8b41fc4454e ("kbuild: create modules.builtin without
> Makefile.modbuiltin or tristate.conf"), MODULE_LICENSE declarations
> are used to identify modules. As a consequence, uses of the macro
> in non-modules will cause modprobe to misidentify their containing
> object file as a module when it is not (false positives), and modprobe
> might succeed rather than failing with a suitable error message.
> 
> So remove it in the files in this commit, none of which can be built as
> modules.
> 
> Signed-off-by: Nick Alcock <nick.alcock@oracle.com>
> Suggested-by: Luis Chamberlain <mcgrof@kernel.org>
> Cc: Luis Chamberlain <mcgrof@kernel.org>
> Cc: linux-modules@vger.kernel.org
> Cc: linux-kernel@vger.kernel.org
> Cc: Hitomi Hasegawa <hasegawa-hitomi@fujitsu.com>
> Cc: Support Opensource <support.opensource@diasemi.com>
> Cc: Lee Jones <lee@kernel.org>
> ---
>  drivers/mfd/Kconfig       | 3 ---
>  drivers/mfd/da903x.c      | 1 -
>  drivers/mfd/da9052-core.c | 1 -
>  drivers/mfd/da9052-i2c.c  | 1 -
>  drivers/mfd/da9052-spi.c  | 1 -
>  drivers/mfd/da9055-core.c | 1 -
>  drivers/mfd/da9055-i2c.c  | 1 -
>  7 files changed, 9 deletions(-)
> 
> diff --git a/drivers/mfd/Kconfig b/drivers/mfd/Kconfig
> index 30db49f318668..751d38b30bb1f 100644
> --- a/drivers/mfd/Kconfig
> +++ b/drivers/mfd/Kconfig
> @@ -361,9 +361,6 @@ config MFD_DA9055
>  	  Additional drivers must be enabled in order to use the functionality
>  	  of the device.
>  
> -	  This driver can be built as a module. If built as a module it will be
> -	  called "da9055"
> -
>  config MFD_DA9062
>  	tristate "Dialog Semiconductor DA9062/61 PMIC Support"
>  	select MFD_CORE
> diff --git a/drivers/mfd/da903x.c b/drivers/mfd/da903x.c
> index 44a25d642ce94..6570b33a5a77b 100644
> --- a/drivers/mfd/da903x.c
> +++ b/drivers/mfd/da903x.c
> @@ -563,4 +563,3 @@ module_exit(da903x_exit);
>  MODULE_DESCRIPTION("PMIC Driver for Dialog Semiconductor DA9034");
>  MODULE_AUTHOR("Eric Miao <eric.miao@marvell.com>");
>  MODULE_AUTHOR("Mike Rapoport <mike@compulab.co.il>");
> -MODULE_LICENSE("GPL v2");
> diff --git a/drivers/mfd/da9052-core.c b/drivers/mfd/da9052-core.c
> index 8b42d2f7024f5..150448cd2eb08 100644
> --- a/drivers/mfd/da9052-core.c
> +++ b/drivers/mfd/da9052-core.c
> @@ -653,4 +653,3 @@ void da9052_device_exit(struct da9052 *da9052)
>  
>  MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
>  MODULE_DESCRIPTION("DA9052 MFD Core");
> -MODULE_LICENSE("GPL");
> diff --git a/drivers/mfd/da9052-i2c.c b/drivers/mfd/da9052-i2c.c
> index ecb8077cdaaf9..03db7a2ccf7a0 100644
> --- a/drivers/mfd/da9052-i2c.c
> +++ b/drivers/mfd/da9052-i2c.c
> @@ -209,4 +209,3 @@ module_exit(da9052_i2c_exit);
>  
>  MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
>  MODULE_DESCRIPTION("I2C driver for Dialog DA9052 PMIC");
> -MODULE_LICENSE("GPL");
> diff --git a/drivers/mfd/da9052-spi.c b/drivers/mfd/da9052-spi.c
> index b79a57b45c1e8..be5f2b34e18ae 100644
> --- a/drivers/mfd/da9052-spi.c
> +++ b/drivers/mfd/da9052-spi.c
> @@ -102,4 +102,3 @@ module_exit(da9052_spi_exit);
>  
>  MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
>  MODULE_DESCRIPTION("SPI driver for Dialog DA9052 PMIC");
> -MODULE_LICENSE("GPL");
> diff --git a/drivers/mfd/da9055-core.c b/drivers/mfd/da9055-core.c
> index c3bcbd8905c6c..768302e05baa1 100644
> --- a/drivers/mfd/da9055-core.c
> +++ b/drivers/mfd/da9055-core.c
> @@ -398,5 +398,4 @@ void da9055_device_exit(struct da9055 *da9055)
>  }
>  
>  MODULE_DESCRIPTION("Core support for the DA9055 PMIC");
> -MODULE_LICENSE("GPL");
>  MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
> diff --git a/drivers/mfd/da9055-i2c.c b/drivers/mfd/da9055-i2c.c
> index 702abff506a1a..537fd5de3e6d4 100644
> --- a/drivers/mfd/da9055-i2c.c
> +++ b/drivers/mfd/da9055-i2c.c
> @@ -97,4 +97,3 @@ module_exit(da9055_i2c_exit);
>  
>  MODULE_AUTHOR("David Dajun Chen <dchen@diasemi.com>");
>  MODULE_DESCRIPTION("I2C driver for Dialog DA9055 PMIC");
> -MODULE_LICENSE("GPL");
> -- 
> 2.39.1.268.g9de2f9a303

-- 
Lee Jones [李琼斯]
