Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48D72641809
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 18:12:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229807AbiLCRM1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 12:12:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229597AbiLCRM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 12:12:26 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E07D11C912;
        Sat,  3 Dec 2022 09:12:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7A961B8074C;
        Sat,  3 Dec 2022 17:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0AB65C433C1;
        Sat,  3 Dec 2022 17:12:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670087540;
        bh=HCj01ypWGHi8MG8ZVE2o2OTaMzH427TOChQYWQAYPjE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YmU3qTT3PU1o1LD/wkyrVxX/Od51+zUOtSZEY/Y/84DLVcVC2wBuiOVmxTC6HPKyY
         vBfWFEEEFr/I0utlf0iMq7yxoiUtoE+DQTXto5Q+J5EuS6qJN8fL2Q5b7VB/gflLev
         dCMwd5AWUWak9i8toT8sMqIkUpAWX+EwU2gfHJ8o3sY/a5AyslJM/rCdVvG1dtrvQk
         9OoGyiQeW0/bu0lEseqrKT3YLrj/hEyJXy1D6ncaLoxPem4mQ2KSZsIMJCxseVlmSb
         TR/Lwkm35S7rj/FQROFHY7xOLWVSbtBE41dCrUUKm3pB+r1fwZBRlCZJGeZNbkEyCO
         EUP1omNTNxFQg==
Date:   Sat, 3 Dec 2022 17:25:04 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Gerald Loacker <gerald.loacker@wolfvision.net>
Cc:     linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Jakob Hauser <jahau@rocketmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Nikita Yushchenko <nikita.yoush@cogentembedded.com>,
        Michael Riesch <michael.riesch@wolfvision.net>
Subject: Re: [PATCH v6 0/3] add ti tmag5273 driver
Message-ID: <20221203172504.4b366d54@jic23-huawei>
In-Reply-To: <20221201072220.402585-1-gerald.loacker@wolfvision.net>
References: <20221201072220.402585-1-gerald.loacker@wolfvision.net>
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

On Thu,  1 Dec 2022 08:22:17 +0100
Gerald Loacker <gerald.loacker@wolfvision.net> wrote:

> Hi all,
> 
> This patch set adds support for the TI TMAG5273 Low-Power Linear 3D Hall-
> Effect Sensor. Additionally to temperature and magnetic X, Y and Z-axes the
> angle and magnitude are reported. The sensor is operating in continuous
> measurement mode and changes to sleep mode if not used for 5 seconds.
> 
> Tests were done on a ROCK3 Model A board using the TMAG5273 evaluation
> module.

Hi Gerald,

Looks good to me (thanks to Andy for his work reviewing!)

Unfortunately timing is such that we are too close to the merge window, so
I'm not planning on doing another pull request for this cycle. As such it's
the first thing I've queued up for 6.3.

Applied to the togreg branch of iio.git and pushed out as testing for
0-day to take a look at it.

Note I'll probably rebase the tree after rc1 and so it won't push out as
togreg (which is meant to be non-rebasing) until after that point.

Thanks,

Jonathan


> 
> Changes in v6:
>  - Defined TMAG5273_MAX_REG
>  - Added comment for wrong device ID
>  
> Changes in v5:
>  - Fixed dev_err_probe
>  - Removed unnecessary '&' for function pointers
>  - Removed warning for device tree reading failure as Linux should not
>    validate device tree.
>  - Added comment for device name
>  - Added tmag5273_wake_up() and improved comments
>  - Reformatted pm_ops
>  
> Changes in v4:
>  - Add only struct for IIO_VAL_INT_PLUS_MICRO iio type to iio.h.
>  - Simplified tmag5273_write_scale()
>  - Removed unnecessary  != 0
>  - Fixed regmap max_register
>  - Simplified tmag5273_read_device_property()
>  - Fixed some line breaks.
> 
> Changes in v3:
>  - Added structs for iio types to iio.h. Using these structs for iio type
>    arrays such as IIO_AVAIL_LIST makes the code more readable than just
>    using (int *). It was suggested by Andy Shevchenko to move these structs
>    to the iio headers to avoid different approaches.
>  - dt-bindings: dropped quotes from strings
>  - Added include <linux/bitfield.h>
>    | Reported-by: kernel test robot <lkp@intel.com> 
>  - Added include <linux/bits.h>
>  - Removed <asm/unaligned.h>
>  - Added missing "static const" for tmag5273_avg_table
>  - Documented Device ID
>  - Fixed index of tmag5273_scale definition
>  - Clarify TMAG5273_MAG_CH_EN_X_Y_Z as an index
>  - Removed unnecessary print
>  - Introduced tmag5273_write_scale() and tmag5273_write_osr() helper
>    functions
>  - Use of match_string()
>  - Format
> 
> Changes in v2:
>  Thanks to Krzysztof, Andy and Jonathan for your detailed review and
>  explanations on the first version. This patch includes all your
>  suggestions and some additional cleanup in the probe function.
> 
> Gerald Loacker (3):
>   iio: add struct declaration for iio types
>   dt-bindings: iio: magnetometer: add ti tmag5273 documentation file
>   iio: magnetometer: add ti tmag5273 driver
> 
>  .../iio/magnetometer/ti,tmag5273.yaml         |  75 ++
>  MAINTAINERS                                   |   7 +
>  drivers/iio/magnetometer/Kconfig              |  12 +
>  drivers/iio/magnetometer/Makefile             |   2 +
>  drivers/iio/magnetometer/tmag5273.c           | 743 ++++++++++++++++++
>  include/linux/iio/iio.h                       |   5 +
>  6 files changed, 844 insertions(+)
>  create mode 100644 .../bindings/iio/magnetometer/ti,tmag5273.yaml
>  create mode 100644 drivers/iio/magnetometer/tmag5273.c
> 

