Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 94A0E61E52E
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 18:58:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbiKFR6y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 12:58:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229947AbiKFR6w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 12:58:52 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F2FEB4A5;
        Sun,  6 Nov 2022 09:58:51 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D31D8B80C7E;
        Sun,  6 Nov 2022 17:58:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DBBABC433D6;
        Sun,  6 Nov 2022 17:58:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667757528;
        bh=S+WnY294EWtEjtcOaVsw5jz5omtvfUMG8HmmViscgG4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=cfuZ09AJPHdBGS649GWBT1+xGTU5gCl0SNqoUUQVUA1mrvR6b9coQ16y+61f+p0M1
         x9/ag8wjbaB6h8bv1BFmm7mLHznBJUcpobitP3kocXHuxqldLosxOFiod/j3P8dfcC
         68x3s2uvfsnRoM5unXgLh/LBXokRr7Srw4kxcyzFrHd0l99oUKF5Z4dKSVSax6iBhW
         mqKzam0bwtYx8tY78Fu6+DGNebo9AvyWbe124gvPsLxW2UisXY0sfShaqXDKHBCzkZ
         AgHEBZQSKTAmoD6HgHyCqbJJrv9fYhytbCmT5ftWrtEq04R7fHP80HyKa6ziqzZoPY
         GdOkZ5MyFhzig==
Date:   Sun, 6 Nov 2022 17:58:39 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 3/4] Documentation: ABI: testing: adf4377: add ABI docs
Message-ID: <20221106175604.061b8662@jic23-huawei>
In-Reply-To: <20221104092802.90725-4-antoniu.miclaus@analog.com>
References: <20221104092802.90725-1-antoniu.miclaus@analog.com>
        <20221104092802.90725-4-antoniu.miclaus@analog.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 4 Nov 2022 11:28:01 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add documentation for the use of the output frequency and muxout select.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>
Hi Antoniu,

A few questions inline.
> ---
>  .../testing/sysfs-bus-iio-frequency-adf4377   | 32 +++++++++++++++++++
>  1 file changed, 32 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4377
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4377 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4377
> new file mode 100644
> index 000000000000..0324de5c9328
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4377
> @@ -0,0 +1,32 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/frequency
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Stores the PLL frequency in Hz for output channels.
> +		Reading returns the frequency in Hz.

I'm a little confused. Should we not tie this to the output channels?
out_altvoltageX_frequency

> +
> +What:		/sys/bus/iio/devices/iio:deviceX/muxout_select

Why would userspace change this? 
I'd sort of expect this to typically be chosen by what it is physically wired
up to.

You could treat muxout_low and muxout_high as a gpio (possibly high_z as well).
If that were the case, then device tree binding should allow you detect that usecase.

Lock detector is normally wired to a GPI so that software can check if the lock is
successful (or it's wired to some other circuits we can't see).  The two
clock dividers should be represented as a clock provider.

Note this is partly driven by my desire to keep custom ABI to the minimum because
it is rare that userspace has a clue what to do with it.  That is probably less
of a consideration here though as I doubt this device is going to be much used
with software stacks that don't know exactly what it is.

Jonathan

> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		The mux output allows the user to access various internal points on
> +		the chip. Valid values that can be written are:
> +		* high_z -> high impedance output
> +		* lock_detect -> digital lock detector output
> +		* muxout_low -> low output
> +		* f_div_rclk_2 -> fdiv_rclk/2
> +		* f_div_nclk_2 -> fdiv_nclk/2
> +		* muxout_high -> high output
> +
> +What:		/sys/bus/iio/devices/iio:deviceX/muxout_select_available
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Reading this returns the valid values that can be written to the
> +		muxout_mode attribute:
> +		* high_z
> +		* lock_detect
> +		* muxout_low
> +		* f_div_rclk_2
> +		* f_div_nclk_2
> +		* muxout_high

