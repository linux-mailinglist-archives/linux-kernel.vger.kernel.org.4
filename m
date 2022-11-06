Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 019A161E4E3
	for <lists+linux-kernel@lfdr.de>; Sun,  6 Nov 2022 18:29:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230134AbiKFR3B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 6 Nov 2022 12:29:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229928AbiKFR27 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Nov 2022 12:28:59 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64CFFF4D;
        Sun,  6 Nov 2022 09:28:58 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 15EDDB80B2F;
        Sun,  6 Nov 2022 17:28:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 279DCC433C1;
        Sun,  6 Nov 2022 17:28:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667755735;
        bh=7B9jEp22p3NOh27JTyp2fkl9cSDOyI+0LvYui7iIjns=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=JBmVV0SjUoOWLapbR5esGY/TH4I6gTJwadXsKy6vfhmxz5Iy/21zF3S1qW5mG6Cbp
         lAdzOaMAukkEoGkgp19dCwatfoWivWetpmJziHS3LRGZvtDwgquA/n8JR+2xUXwlIH
         LeORZ89TrVnmsp1XgjLSR9gG4LcW7aAOu4Tb4lGDX/aMmufffYveLRP+9Jnzn0r87x
         MFgVQa+HkjotEMgMb09l4VoR8FXN0rvMkvK0CxfwCl0Sh9YZRTu8Y5bXtTveYMctjd
         cH3I1kDVMxHkIb+JmgPHrQ8ugXvzNW9wdyGWjpo+xnJHmk/oU8qq4Yyv/y5s1isgxm
         9FvooiYfnqKvg==
Date:   Sun, 6 Nov 2022 17:28:48 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Bagas Sanjaya <bagasdotme@gmail.com>
Cc:     linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Cosmin Tanislav <cosmin.tanislav@analog.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>
Subject: Re: [PATCH] Documentation: ad4130: format list of
 in_voltage-voltage_filter_mode_available modes
Message-ID: <20221106172848.374831a5@jic23-huawei>
In-Reply-To: <20221106140233.74112-1-bagasdotme@gmail.com>
References: <20221106140233.74112-1-bagasdotme@gmail.com>
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

On Sun,  6 Nov 2022 21:02:33 +0700
Bagas Sanjaya <bagasdotme@gmail.com> wrote:

> Sphinx reports two warnings on sysfs documentation for AD4130 driver:
> 
> Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130:2: WARNING: Unexpected indentation.
> Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130:2: WARNING: Block quote ends without a blank line; unexpected unindent.
> 
> These are due to misformatting of sinc* modes list. Format it with bullet
> list. Since each entry spans multiple lines, separate each with a blank
> line.
> 
> Fixes: 5bdef39c5c6e1a ("iio: adc: ad4130: add AD4130 driver")
> Signed-off-by: Bagas Sanjaya <bagasdotme@gmail.com>

Applied to the togreg branch of iio.git and pushed out initially as testing for
the autobuilders to look at it (or at least look at the other stuff that I've
applied on that branch today).

Thanks!

Jonathan

> ---
>  .../ABI/testing/sysfs-bus-iio-adc-ad4130      | 48 +++++++++++--------
>  1 file changed, 29 insertions(+), 19 deletions(-)
> 
> diff --git a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130 b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
> index d9555751d21ce2..f24ed6687e900e 100644
> --- a/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
> +++ b/Documentation/ABI/testing/sysfs-bus-iio-adc-ad4130
> @@ -3,25 +3,35 @@ KernelVersion:  6.2
>  Contact:	linux-iio@vger.kernel.org
>  Description:
>  		Reading returns a list with the possible filter modes.
> -		"sinc4"       - Sinc 4. Excellent noise performance. Long 1st
> -				conversion time. No natural 50/60Hz rejection.
> -		"sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion time.
> -		"sinc3"	      - Sinc3. Moderate 1st conversion time. Good noise
> -				performance.
> -		"sinc3+rej60" - Sinc3 + 60Hz rejection. At a sampling frequency
> -				of 50Hz, achieves simultaneous 50Hz and 60Hz
> -				rejection.
> -		"sinc3+sinc1" - Sinc3 + averaging by 8. Low 1st conversion time.
> -				Best used with a sampling frequency of at least
> -				216.19Hz.
> -		"sinc3+pf1"   - Sinc3 + Post Filter 1.
> -				53dB rejection @ 50Hz, 58dB rejection @ 60Hz.
> -		"sinc3+pf2"   - Sinc3 + Post Filter 2.
> -				70dB rejection @ 50Hz, 70dB rejection @ 60Hz.
> -		"sinc3+pf3"   - Sinc3 + Post Filter 3.
> -				99dB rejection @ 50Hz, 103dB rejection @ 60Hz.
> -		"sinc3+pf4"   - Sinc3 + Post Filter 4.
> -				103dB rejection @ 50Hz, 109dB rejection @ 60Hz.
> +
> +		  * "sinc4"       - Sinc 4. Excellent noise performance. Long
> +                    1st conversion time. No natural 50/60Hz rejection.
> +
> +		  * "sinc4+sinc1" - Sinc4 + averaging by 8. Low 1st conversion
> +		    time.
> +
> +		  * "sinc3"	      - Sinc3. Moderate 1st conversion time.
> +		    Good noise performance.
> +
> +		  * "sinc3+rej60" - Sinc3 + 60Hz rejection. At a sampling
> +		    frequency of 50Hz, achieves simultaneous 50Hz and 60Hz
> +		    rejection.
> +
> +		  * "sinc3+sinc1" - Sinc3 + averaging by 8. Low 1st conversion
> +		    time. Best used with a sampling frequency of at least
> +		    216.19Hz.
> +
> +		  * "sinc3+pf1"   - Sinc3 + Post Filter 1. 53dB rejection @
> +		    50Hz, 58dB rejection @ 60Hz.
> +
> +		  * "sinc3+pf2"   - Sinc3 + Post Filter 2. 70dB rejection @
> +		    50Hz, 70dB rejection @ 60Hz.
> +
> +		  * "sinc3+pf3"   - Sinc3 + Post Filter 3. 99dB rejection @
> +		    50Hz, 103dB rejection @ 60Hz.
> +
> +		  * "sinc3+pf4"   - Sinc3 + Post Filter 4. 103dB rejection @
> +		    50Hz, 109dB rejection @ 60Hz.
>  
>  What:		/sys/bus/iio/devices/iio:deviceX/in_voltageY-voltageZ_filter_mode
>  KernelVersion:  6.2
> 
> base-commit: b8bee0f98634cc1ce8cc8bf0e1db025734ee0c2b

