Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B99F171FF70
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 12:35:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234540AbjFBKfb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 06:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234279AbjFBKem (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 06:34:42 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EE50E51;
        Fri,  2 Jun 2023 03:33:20 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3527NtGN024389;
        Fri, 2 Jun 2023 12:31:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=qVWMZjCW06p4Kysf6wJpT9ettqaWhBD5pA4J9JkgqBs=;
 b=UKdo0LF6m5EZ2N5T5W43t+8yXUGxJNYME3AOAG5DYgtzijNzwMOFAoZBBz1vqs/LJWKe
 VFJ3Mh/Rm8uBeoeyG+NsMDC8x6imZn3055Nz38Lt6VfIhclrUxX3vvfNC5ra4nPMCaZK
 PuoRAGT3QVknJAN7waLBg1cnxLvVDccCMLsi0sxE+7Xnlj8Z8z2xyE4hsMRslOFEI8hG
 GbH+STPvu7aVOFnoZGKJ1XidbVBjtRpEx7zgEKcQR7MlJMttM3ofWa6cddGzOor+OOyQ
 M1ng0qEeYTKUW1y23TuspNiesZzP8oAv0j7IM1eU2AvEYs+FI+OjYda9Yi1Jn8p63xbw AA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qyc08946e-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 02 Jun 2023 12:31:28 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1C601100034;
        Fri,  2 Jun 2023 12:31:26 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 0E5E2229A7B;
        Fri,  2 Jun 2023 12:31:26 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 2 Jun
 2023 12:31:25 +0200
Message-ID: <36c1ab40-6ff7-6f6e-043d-543c75200e94@foss.st.com>
Date:   Fri, 2 Jun 2023 12:31:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2 0/9] ARM: dts: stm32: add adc internal channels on
 stm32mp15
Content-Language: en-US
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Marek Vasut <marex@denx.de>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@dh-electronics.com>
References: <20230530124538.621760-1-olivier.moysan@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230530124538.621760-1-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-02_07,2023-05-31_03,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olivier

On 5/30/23 14:45, Olivier Moysan wrote:
> Add STM32 ADC2 internal channels VREFINT and VDDCORE to STM32MP15x SoCs.
> 
> Add support of vrefint channel by adding access to vrefint calibration
> data in OTP.
> 
> The internal channels are defined in STM32MP15 SoC DT according to
> generic channel bindings. The STM32 driver does not support a mixed use
> of legacy and generic channels. When generic channels are defined,
> legacy channel are ignored. This involves that the board device trees
> using legacy bindings have to be changed to generic bindings.
> 
> Adopt generic iio bindings on STM32 boards implementing the ADC.
> 
> Changes in v2:
> - Add patch from https://lore.kernel.org/linux-arm-kernel/20230518020547.487670-1-marex@denx.de/T/
> - Change node name from vrefin_cal to vrefin-cal
> 
> Marek Vasut (1):
>    ARM: dts: stm32: Update to generic ADC channel binding on DHSOM
>      systems
> 
> Olivier Moysan (8):
>    ARM: dts: stm32: add adc internal channels to stm32mp15
>    ARM: dts: stm32: add vrefint calibration on stm32mp15
>    ARM: dts: stm32: add vrefint support to adc2 on stm32mp15
>    ARM: dts: stm32: enable adc on stm32mp15xx-dkx boards
>    ARM: dts: stm32: adopt generic iio bindings for adc channels on
>      stm32mp157c-ed1
>    ARM: dts: stm32: adopt generic iio bindings for adc channels on
>      emstamp-argon
>    ARM: dts: stm32: adopt generic iio bindings for adc channels on
>      dhcor-drc
>    ARM: dts: stm32: adopt generic iio bindings for adc channels on
>      dhcor-testbench
> 
>   arch/arm/boot/dts/stm32mp151.dtsi             | 17 +++++++++
>   arch/arm/boot/dts/stm32mp157c-ed1.dts         | 16 ++++++--
>   .../boot/dts/stm32mp157c-emstamp-argon.dtsi   |  6 ++-
>   arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi  | 18 +++++----
>   .../boot/dts/stm32mp15xx-dhcor-avenger96.dtsi | 38 +++++++++++++++----
>   .../dts/stm32mp15xx-dhcor-drc-compact.dtsi    | 28 ++++++++++++--
>   .../boot/dts/stm32mp15xx-dhcor-testbench.dtsi | 28 ++++++++++++--
>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi        | 29 +++++++++-----
>   8 files changed, 142 insertions(+), 38 deletions(-)
> 

Series applied on stm32-next.

Regards
Alex
