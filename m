Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59BDA5F8B52
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Oct 2022 14:46:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiJIMqI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Oct 2022 08:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230037AbiJIMqG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Oct 2022 08:46:06 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1E6E2B61F;
        Sun,  9 Oct 2022 05:46:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 81010B80CB4;
        Sun,  9 Oct 2022 12:46:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84C98C433C1;
        Sun,  9 Oct 2022 12:45:59 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1665319563;
        bh=4Nj1puvm6vqPNPlMuFm1NVtI87aUUZFMFh+0kE9uGy0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Rmok3e/Ig4bRD0InOAXvRsPjsuTDJHzdt/hKDk4DgRNCe2PefW+zuRASQD3yZdiW9
         1dufcr3fL1qkQxlJhjkl1+0Wg5ULDdPLxYSdkzawIqNxSF2pxWNZJVhYSTWHRiDK7o
         uvRst07UF46+7gGpsMJMg5UGqp1+onipWszF61cUjQ2idh069XpphazFPaMvI6Yqk7
         krc1zYr+6MjE6MqW1YRGxLMIZx36QcuTa6kKR1Z9Vqr+TDj0vtJUNG1Nk67VcaX3gD
         w0F1eSTrfeZW+1tw2CsuZSOjuBWTthkfOnMJ2bVoEoqXadznDii2QbDR3k7SomvNVs
         sgzGpIYCjg7Rw==
Date:   Sun, 9 Oct 2022 13:46:23 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Olivier Moysan <olivier.moysan@foss.st.com>
Cc:     Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <nuno.sa@analog.com>, Paul Cercueil <paul@crapouillou.net>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Wan Jiabing <wanjiabing@vivo.com>,
        Yannick Brosseau <yannick.brosseau@gmail.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
Subject: Re: [PATCH v3 2/8] dt-bindings: iio: adc: stm32-adc: add stm32mp13
 compatibles
Message-ID: <20221009134623.1525c67c@jic23-huawei>
In-Reply-To: <20221005161424.4537-3-olivier.moysan@foss.st.com>
References: <20221005161424.4537-1-olivier.moysan@foss.st.com>
        <20221005161424.4537-3-olivier.moysan@foss.st.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Wed, 5 Oct 2022 18:14:18 +0200
Olivier Moysan <olivier.moysan@foss.st.com> wrote:

> Add st,stm32mp13-adc-core and st,stm32mp13-adc compatibles
> to support STM32MPU13 SoC.
> 
> On STM32MP13x, each ADC peripheral has a single ADC block.
> These ADC peripherals, ADC1 and ADC2, are fully independent.
> 
> Main characteristics of STM32MP13x ADC:
> - One interrupt line per ADC
> - 6 to 12 bits resolution
> - 19 channels
> 
> ADC2 instance supports two extra internal channels VDDCPU and VDDQ_DDR.
> Add "vddcpu" and "vddq_ddr" internal channels names to the reserved
> labels list.
> 
> Signed-off-by: Olivier Moysan <olivier.moysan@foss.st.com>
Hi,

All patches touching device tree bindings need to go to the devicetree
list and device tree binding maintainers for review (See MAINTAINERS)
Make sure you cc them on v4 as I won't pick up DT patches without their
review unless they are much more trivial than this one.

I'm not always great at noticing this on early versions as I tend to pick
up on the fact they didn't review as first sign they haven't seen the
series!

Jonathan
