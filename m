Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4DAA05FEFAD
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Oct 2022 16:04:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230326AbiJNOEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Oct 2022 10:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230316AbiJNODa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Oct 2022 10:03:30 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11D6667041;
        Fri, 14 Oct 2022 07:02:46 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29EAIp1X021787;
        Fri, 14 Oct 2022 16:01:28 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=hIs62NaFwheRET5awOLLUpS90nMRm/P9eUIk+y/X9QU=;
 b=jO/hdYJgwSs/MqAHxM657DHPMeZXtap/LIsow0SOOKYdnsm8veqVtx4ise5RkT2p3c+O
 KtY3OznKDM2l4n7NKY4RFJ0oTozWd0Bkcv1wpfPHcmABgqSj83dc9qF+jov1AW6lOlwo
 QSNi9OSH7D2ip6AbQ03+bV0gX1fJZyLUwFlO7stEy3+e2fIUJf87IGPg0EX3rqzczhg7
 8E0stjBoCnzcOQidKJIgbLgZOenV5TukpCFxjQILif/752Xct847Ujew7FAXkTq2ayJr
 KHwojEtqMPChApiudbYIPVCj6zz2l+b3zDcmHbKVL5F1tfPTYOPppDqWIYrT1tFCn5Vo zw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3k64m7wwdc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 14 Oct 2022 16:01:28 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id ABFBA100034;
        Fri, 14 Oct 2022 16:01:22 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 7FBE62309C7;
        Fri, 14 Oct 2022 16:01:20 +0200 (CEST)
Received: from [10.252.6.249] (10.75.127.121) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256) id 15.1.2375.31; Fri, 14 Oct
 2022 16:01:16 +0200
Message-ID: <215c11d7-9bee-a97c-674c-06336f5c7dc9@foss.st.com>
Date:   Fri, 14 Oct 2022 16:01:15 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH 00/10] Add support for USB on STM32MP13
Content-Language: en-US
To:     <alexandre.torgue@foss.st.com>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <amelie.delaunay@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20221014092651.25202-1-fabrice.gasnier@foss.st.com>
From:   Fabrice Gasnier <fabrice.gasnier@foss.st.com>
In-Reply-To: <20221014092651.25202-1-fabrice.gasnier@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.75.127.121]
X-ClientProxiedBy: GPXDAG2NODE4.st.com (10.75.127.68) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.895,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2022-10-14_08,2022-10-14_01,2022-06-22_01
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/14/22 11:26, Fabrice Gasnier wrote:
> Add support for USBPHYC, USB Host and USB OTG on STM32MP13.
> Enable all these interfaces on STM32MP135F-DK board.
> Enable the STM32G0 UCSI driver as module.
> Dependency on PWR and PMIC regulator is tempoarily managed by using
> fixed regulators (resp in the SoC dtsi and the board dts files).
> The USB support is functional when these regulators gets enabled at
> boot time before entering the kernel.

Hi,

Please discard this series. Generic node names recommendation has been
missed.
I'll send a V2.

Sorry for the noise.
Best Regards,
Fabrice

> 
> Amelie Delaunay (5):
>   ARM: dts: stm32: add USBPHYC and dual USB HS PHY support on stm32mp131
>   ARM: dts: stm32: add UBSH EHCI and OHCI support on stm32mp131
>   ARM: dts: stm32: add USB OTG HS support on stm32mp131
>   ARM: dts: stm32: enable USB HS phys on stm32mp135f-dk
>   ARM: dts: stm32: enable USB Host EHCI on stm32mp135f-dk
> 
> Fabrice Gasnier (5):
>   ARM: dts: stm32: add PWR fixed regulators on stm32mp131
>   ARM: dts: stm32: add fixed regulators to support usb on stm32mp135f-dk
>   ARM: dts: stm32: add pins for stm32g0 typec controller on stm32mp13
>   ARM: dts: stm32: enable USB OTG in dual role mode on stm32mp135f-dk
>   ARM: multi_v7_defconfig: enable Type-C UCSI and STM32G0 as modules
> 
>  arch/arm/boot/dts/stm32mp13-pinctrl.dtsi |  7 ++
>  arch/arm/boot/dts/stm32mp131.dtsi        | 81 ++++++++++++++++++++
>  arch/arm/boot/dts/stm32mp135f-dk.dts     | 95 ++++++++++++++++++++++++
>  arch/arm/configs/multi_v7_defconfig      |  2 +
>  4 files changed, 185 insertions(+)
> 
