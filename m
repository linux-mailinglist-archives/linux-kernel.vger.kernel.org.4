Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7BA5609E6F
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 12:01:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230107AbiJXKBp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 06:01:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229792AbiJXKBm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 06:01:42 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5946140B3;
        Mon, 24 Oct 2022 03:01:40 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29O7YUSg032118;
        Mon, 24 Oct 2022 12:01:29 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=/1ISvok2MlOVWxjeDXBIB0FBrreJWa64+ZVjHl7H/0E=;
 b=ljRaRjj4fCSSmCbA1JOGd19ApHhO1Ydkdv6uAasZqkwQ7Wpf5aVeYKyQ/suf441kJdDp
 FHD/YOmgMC4JY60lHQ0MhzRk0F7NTEvoyB5Y9557PmzFo7usgJ2FWtL2jdcKgZDagZXM
 pv5WVmdGc/pvLhAeu8/NgD/7HwBr6yBhF+XVXTdUbLpTT0oweZ//R4sUXZYdhqbqxHJw
 j/7SCmJwAvVkfnJYPPrkQvJD2FfwisNPWQivz2azLxV3dxJgpYDet9isvEdfEc0N9aft
 kirP2IB1oa28yn/AULAiDWk+bHrhtLVt2/SK2L/YRcTQ7dRSojMhFuwvmRLdIjeRgKHR 5g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kc5xktfqw-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 12:01:29 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2FF24100039;
        Mon, 24 Oct 2022 12:01:25 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 2863C21A20D;
        Mon, 24 Oct 2022 12:01:25 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 12:01:24 +0200
Message-ID: <608d4642-34f8-a00a-ffe9-e34bb40f0342@foss.st.com>
Date:   Mon, 24 Oct 2022 12:01:23 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH v2 00/10] Add support for USB on STM32MP13
Content-Language: en-US
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <amelie.delaunay@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20221014141509.211149-1-fabrice.gasnier@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20221014141509.211149-1-fabrice.gasnier@foss.st.com>
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

Hi Fabrice

On 10/14/22 16:14, Fabrice Gasnier wrote:
> Add support for USBPHYC, USB Host and USB OTG on STM32MP13.
> Enable all these interfaces on STM32MP135F-DK board.
> Enable the STM32G0 UCSI driver as module.
> Dependency on PWR and PMIC regulator is tempoarily managed by using
> fixed regulators (resp in the SoC dtsi and the board dts files).
> The USB support is functional when these regulators gets enabled at
> boot time before entering the kernel.
> 
> Changes in v2:
> Adopt "usb" and "typec" generic node names
> 
> Amelie Delaunay (5):
>    ARM: dts: stm32: add USBPHYC and dual USB HS PHY support on stm32mp131
>    ARM: dts: stm32: add UBSH EHCI and OHCI support on stm32mp131
>    ARM: dts: stm32: add USB OTG HS support on stm32mp131
>    ARM: dts: stm32: enable USB HS phys on stm32mp135f-dk
>    ARM: dts: stm32: enable USB Host EHCI on stm32mp135f-dk
> 
> Fabrice Gasnier (5):
>    ARM: dts: stm32: add PWR fixed regulators on stm32mp131
>    ARM: dts: stm32: add fixed regulators to support usb on stm32mp135f-dk
>    ARM: dts: stm32: add pins for stm32g0 typec controller on stm32mp13
>    ARM: dts: stm32: enable USB OTG in dual role mode on stm32mp135f-dk
>    ARM: multi_v7_defconfig: enable Type-C UCSI and STM32G0 as modules
> 
>   arch/arm/boot/dts/stm32mp13-pinctrl.dtsi |  7 ++
>   arch/arm/boot/dts/stm32mp131.dtsi        | 81 ++++++++++++++++++++
>   arch/arm/boot/dts/stm32mp135f-dk.dts     | 95 ++++++++++++++++++++++++
>   arch/arm/configs/multi_v7_defconfig      |  2 +
>   4 files changed, 185 insertions(+)
> 

Series applied on stm32-next.

Cheers
Alex
