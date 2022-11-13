Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 74F11626F8F
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Nov 2022 13:48:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235177AbiKMMsr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Nov 2022 07:48:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38872 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbiKMMso (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Nov 2022 07:48:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97A3312AB1;
        Sun, 13 Nov 2022 04:48:43 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 396CC60B81;
        Sun, 13 Nov 2022 12:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4826CC433D6;
        Sun, 13 Nov 2022 12:48:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1668343722;
        bh=7i4I5LouaUPrD6INxO4gASs9HbJWfOfLOUNuyxhm3MY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Gma3NW1JB3SMTbEhTaaEYo2Crc9R+TXX13mH37vgWQ3ofdCTi8mOJ8s6UoXhw1SAz
         6nO25aQV/lOja1I+wfxucXmOJ0JG2yo+rNb4lA5cWLyh6jTIpkxir3QZXUkvwhjNbz
         nhJUzX10RKi+UJZK6fO2VjmHiQ44apNUfWsNUIct9K45mvec0zOYrskk7LvZdXL0nG
         dvMkJiznXaRZ1tnQM26E3j3rIjORKmy8LsE4K2msrsVh3QR6gEFYT5ATthDppbm5+y
         bRtVPMXbeB+0T6FVNPWMjse/ctCJ0IajOXrI7edydtMdAvM6ieNE81zDW5hWnWwis5
         N5yQRVPNSR7kQ==
Date:   Sun, 13 Nov 2022 13:00:56 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Antoniu Miclaus <antoniu.miclaus@analog.com>
Cc:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 3/3] Documentation: ABI: testing: adf4377: add ABI
 docs
Message-ID: <20221113130056.571e107f@jic23-huawei>
In-Reply-To: <20221107120243.57344-3-antoniu.miclaus@analog.com>
References: <20221107120243.57344-1-antoniu.miclaus@analog.com>
        <20221107120243.57344-3-antoniu.miclaus@analog.com>
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

On Mon, 7 Nov 2022 14:02:43 +0200
Antoniu Miclaus <antoniu.miclaus@analog.com> wrote:

> Add documentation for the use of the output frequency and muxout select.
> 
> Signed-off-by: Antoniu Miclaus <antoniu.miclaus@analog.com>

The docs system doesn't support more specific definitions of ABI for individual drivers
if there is already an entry in another doc.

Here we have the same entry in sysfs-bus-iio

We can add extra info to that top level description related to an individual part, but
I don't think that's necessary here.

So I suggest dropping this patch.

Thanks,

Jonathan

> ---
> changes in v2:
>  - remove muxout selectdocumentation, since it is done in the devicetree now
>  Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4377 | 6 ++++++
>  1 file changed, 6 insertions(+)
>  create mode 100644 Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4377
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4377 b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4377
> new file mode 100644
> index 000000000000..8888be49754c
> --- /dev/null
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-frequency-adf4377
> @@ -0,0 +1,6 @@
> +What:		/sys/bus/iio/devices/iio:deviceX/out_altvoltageY_frequency
> +KernelVersion:
> +Contact:	linux-iio@vger.kernel.org
> +Description:
> +		Stores the PLL frequency in Hz for output channels.
> +		Reading returns the frequency in Hz.

