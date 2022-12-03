Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FD32641812
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 18:23:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229784AbiLCRXx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 12:23:53 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229481AbiLCRXv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 12:23:51 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 246FE1E700;
        Sat,  3 Dec 2022 09:23:49 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id B9812B80689;
        Sat,  3 Dec 2022 17:23:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 218F0C433C1;
        Sat,  3 Dec 2022 17:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1670088226;
        bh=iTtdW6gDpKHLLzKCX31xhKgEEH+3KoFhhXGmXIO5ZP8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=u+BEgHWXH5ITAwz3jXgk74FH9/Gb25v/9qpiVZjuhkSjkKCCxC0WqKDHhfSoEehp0
         OZR+rOagvJcew3j4vmZSM4+bXjb44hWLLYp5W9SgnLMUea/u2PVqKFbuJ1WbqjyD9v
         8YHVekiyvg5oxz6p5rgsajsL1shvgSj9ilzlnJFuQIRbY0bIRbnN8JjkknRMP7NaoI
         fhYr3xyvOh55rHcRYWzoDVHeRmKhy6s2bRAK+Z2Uju2lXLMYZAB63RdZ9isq36WIge
         IVwx0U+Uwaz/b7vRn57R4wyFtsKEa42bvqhHfIPNKklNf1Hvrzyza9XEAW23Fv8JYE
         RjDy6sNGMXfgg==
Date:   Sat, 3 Dec 2022 17:36:30 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Mark Brown <broonie@kernel.org>,
        "Arnaud Pouliquen" <arnaud.pouliquen@st.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        <linux-iio@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2] iio: adc: stm32-dfsdm: fill module aliases
Message-ID: <20221203173630.4b4de6c7@jic23-huawei>
In-Reply-To: <20221202152848.45585-1-olivier.moysan@foss.st.com>
References: <20221202152848.45585-1-olivier.moysan@foss.st.com>
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

On Fri, 2 Dec 2022 16:28:48 +0100
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> When STM32 DFSDM driver is built as module, no modalias information
> is available. This prevents module to be loaded by udev.
> Add MODULE_DEVICE_TABLE() to fill module aliases.
> 
> Fixes: e2e6771c6462 ("IIO: ADC: add STM32 DFSDM sigma delta ADC support")
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Applied to the fixes-togreg branch of iio.git.

Note this will probably go upstream just after the merge window closes
now.

Thanks,

Jonathan

> ---
> Changes in v2: Add Fixes tag
> ---
>  drivers/iio/adc/stm32-dfsdm-adc.c | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/drivers/iio/adc/stm32-dfsdm-adc.c b/drivers/iio/adc/stm32-dfsdm-adc.c
> index 6d21ea84fa82..a428bdb567d5 100644
> --- a/drivers/iio/adc/stm32-dfsdm-adc.c
> +++ b/drivers/iio/adc/stm32-dfsdm-adc.c
> @@ -1520,6 +1520,7 @@ static const struct of_device_id stm32_dfsdm_adc_match[] = {
>  	},
>  	{}
>  };
> +MODULE_DEVICE_TABLE(of, stm32_dfsdm_adc_match);
>  
>  static int stm32_dfsdm_adc_probe(struct platform_device *pdev)
>  {

