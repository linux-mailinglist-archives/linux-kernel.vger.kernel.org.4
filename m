Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89C25609DB8
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 11:16:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230150AbiJXJQV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 05:16:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230472AbiJXJQD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 05:16:03 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9F97546238;
        Mon, 24 Oct 2022 02:15:41 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29O6ogAs020583;
        Mon, 24 Oct 2022 11:15:19 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=z+1JCm1pKs2pubgyamSKK+Q6QSmrDxZrpGoChFw5Hls=;
 b=UZATB/6EVJaHP+kheMoZbkdycFbxldtahGwBzhpxjYAcjpuEPD0sA1D9XwalMRuhsC5q
 wOWttOFXaS6PvbJqRk0M41AZInYX2uW0oZVpZE2hMRrgIgCqEX79GUMyrH9B5Yn01bFH
 ao4Jxsc0OZSJcZkEe+hpCMoRhF0nitIDPMaVpGNiSwq9z3oc8F99dqn4JN22Hex0/l1+
 b2iVvuc3y9O+0xNrDaQHV+Er/WNHF4p9FtyoLlGJI1DLAVHI4z6FkhrRWrz7uvSUL5Lm
 O6P9rn6lvscZF6swMPPhDCX9LIxqYMFEzS78uXjKhIjlHzI3tlsDEJKAvxvtlMMARXqq rA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kc7v29rdd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 11:15:19 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id BCF0610002A;
        Mon, 24 Oct 2022 11:15:14 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id B7CC1217B88;
        Mon, 24 Oct 2022 11:15:14 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 11:15:13 +0200
Message-ID: <19d20435-ad5d-dc61-7b54-36b7bac72266@foss.st.com>
Date:   Mon, 24 Oct 2022 11:15:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v4 0/8] iio: stm32-adc: add support of adc for stm32mp13
Content-Language: en-US
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-iio@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>
References: <20221012142205.13041-1-olivier.moysan@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20221012142205.13041-1-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-24_02,2022-10-21_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olivier

On 10/12/22 16:21, Olivier Moysan wrote:
> On STM32MP13 SoCs, each ADC peripheral has a single ADC block.
> These ADC peripherals, ADC1 and ADC2, are fully independent.
> The STM32MP131 SoC provides only ADC2, while other STM32MP13x
> SoCs provide both ADC1 and ADC2.
> 
> The STM32MP13 ADC features and characteristics are slightly
> different from STM32MP15 ADC ones, requiring a specific support
> in the driver.
> 
> This patchset enables the ADC peripheral on STM32MP135F-DK board.
> 
> On STM32MP135F-DK board the ADC is connected to VDDA voltage
> provided by the PMIC LOD1 supply, which has to be enabled through
> SCMI regulator framework.
> This serie introduces a fixed regulator to allow ADC probing,
> while SCMI regulators support is not available. This does
> not ensure ADC regulator enabling however.
> 
> Changes in v4:
> - reformat patch 1 commit message
> - reorder adc1 node
> 
> v3:
> - Remove blank line in tag block
> - Use HZ_PER_MHZ unit for max frequency definition
> - Coding style updates
> 
> v2:
> - Rework commit message length
> - Add missing spaces
> - Remove useless defines
> 
> Olivier Moysan (8):
>    iio: adc: stm32-adc: fix channel sampling time init
>    dt-bindings: iio: adc: stm32-adc: add stm32mp13 compatibles
>    iio: adc: stm32-adc: add stm32mp13 support
>    iio: adc: stm32: manage min sampling time on all internal channels
>    ARM: dts: stm32: add adc support to stm32mp13
>    ARM: dts: stm32: add adc pins muxing on stm32mp135f-dk
>    ARM: dts: stm32: add dummy vdd_adc regulator on stm32mp135f-dk
>    ARM: dts: stm32: add adc support on stm32mp135f-dk
> 

DT patches [5 to 8] applied on stm32-next.

Thanks
Alex


