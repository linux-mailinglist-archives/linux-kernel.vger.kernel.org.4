Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A1E10661538
	for <lists+linux-kernel@lfdr.de>; Sun,  8 Jan 2023 13:51:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229520AbjAHMvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 8 Jan 2023 07:51:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230363AbjAHMvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 8 Jan 2023 07:51:00 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0A22B21AB;
        Sun,  8 Jan 2023 04:50:59 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id A947BB80976;
        Sun,  8 Jan 2023 12:50:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F41E7C433EF;
        Sun,  8 Jan 2023 12:50:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1673182256;
        bh=rDIT6gOl0JO4Pi6BQxe7HUa29MorRTACERDszgVOHnE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=NvemCsLHeLLV+8PVO2pbhxbb52p3xtb96zE7/xXKTz1izmy3Rw0KxsxjRIFJn/SlS
         oFXd4nidiwMNH23ZaBiUh6nxpg9P1mI2CYC2aQKuaYnCTnJ+BZocXBRtTUum4LhmK2
         lCftg30KLGlQzvHx82O3xsXbGp7KvX4O0CKEXJVvex175baGrwtul/lzWabC67km8f
         JPQU9cheLe38Cen77Wj5tFSIg38d9JIJPNq7Hm8wLfpEdMTgo+y3n2jo6MhuZWXScP
         MasUqRGgcCAx5v9Wofq/ZbAEwj/GxGoTLz5Msdtto1NCPWB4BaRqz3EAv9zXRM+E0H
         80I/jiXRfWrGA==
Date:   Sun, 8 Jan 2023 13:04:22 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Luca Weiss <luca.weiss@fairphone.com>
Cc:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Konrad Dybcio <konrad.dybcio@linaro.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] iio: adc: qcom-spmi-adc5: define
 ADC5_BAT_ID_100K_PU channel
Message-ID: <20230108130422.76493bf8@jic23-huawei>
In-Reply-To: <20230106-pm7250b-bat_id-v1-1-82ca8f2db741@fairphone.com>
References: <20230106-pm7250b-bat_id-v1-0-82ca8f2db741@fairphone.com>
        <20230106-pm7250b-bat_id-v1-1-82ca8f2db741@fairphone.com>
X-Mailer: Claws Mail 4.1.1 (GTK 3.24.36; x86_64-pc-linux-gnu)
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

On Fri, 06 Jan 2023 16:39:41 +0100
Luca Weiss <luca.weiss@fairphone.com> wrote:

> Define the ADC channel used for battery identification purposes so it
> can be used in drivers.
> 
> Signed-off-by: Luca Weiss <luca.weiss@fairphone.com>
Applied to the togreg branch of iio.git and pushed out as testing for
0-day to take a look at it.

If anyone else has comments, then there is still time as I won't push
this out as a non-rebasing branch for a few days at least
(and I'm aware I picked it up very quickly :)


Thanks,

Jonathan

> ---
>  drivers/iio/adc/qcom-spmi-adc5.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/iio/adc/qcom-spmi-adc5.c b/drivers/iio/adc/qcom-spmi-adc5.c
> index 821fee60a765..8c33da9de257 100644
> --- a/drivers/iio/adc/qcom-spmi-adc5.c
> +++ b/drivers/iio/adc/qcom-spmi-adc5.c
> @@ -543,6 +543,8 @@ static const struct adc5_channels adc5_chans_pmic[ADC5_MAX_CHANNEL] = {
>  					SCALE_HW_CALIB_DEFAULT)
>  	[ADC5_XO_THERM_100K_PU]	= ADC5_CHAN_TEMP("xo_therm", 0,
>  					SCALE_HW_CALIB_XOTHERM)
> +	[ADC5_BAT_ID_100K_PU]	= ADC5_CHAN_TEMP("bat_id", 0,
> +					SCALE_HW_CALIB_DEFAULT)
>  	[ADC5_AMUX_THM1_100K_PU] = ADC5_CHAN_TEMP("amux_thm1_100k_pu", 0,
>  					SCALE_HW_CALIB_THERM_100K_PULLUP)
>  	[ADC5_AMUX_THM2_100K_PU] = ADC5_CHAN_TEMP("amux_thm2_100k_pu", 0,
> 

