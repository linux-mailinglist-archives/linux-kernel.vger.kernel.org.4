Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B73366DC1C
	for <lists+linux-kernel@lfdr.de>; Tue, 17 Jan 2023 12:18:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236097AbjAQLSU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 Jan 2023 06:18:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236100AbjAQLRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Jan 2023 06:17:41 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B76A62BEE8;
        Tue, 17 Jan 2023 03:17:39 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 30HAFL7k020822;
        Tue, 17 Jan 2023 12:17:21 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=u0kaHI8tNOfKQRFpseaOw/BSe5Zyv8eEs8CWYtEpTic=;
 b=oP5YhL2+bok9XIMnUzy7YEFlwtztXCoS/ViqC333m8urOpeUaxWemfaS99SaRU5cB1aM
 qE4Xi3db6rQT9Y+fhLQYQNUKwxhx34JP+cmvBgvE5Dl7XPjrxEi95N4UATAeAp6tVrly
 HxTZMwNnrYhh7iG90ecEtFGamEAJQ3+fcf0armNMl6yxs5BZRW9VAk0ICpd8/IX3LKLB
 4IEFClBDiiwL5Wnc7xsJDzxanKzplRD5VNdR/RJ6VSefbM4yB4X87S+k1/lF4PgOQ2MY
 UX4u1/3hASBtHs8xQNDXl5gOltgGNukYpmfUiWfWvHQk1spAlt7SVfCry2ZWVxG5/dOt QA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3n3jpr0b5x-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 17 Jan 2023 12:17:21 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 18F2210002A;
        Tue, 17 Jan 2023 12:17:20 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 15F39215BDC;
        Tue, 17 Jan 2023 12:17:20 +0100 (CET)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Tue, 17 Jan
 2023 12:17:19 +0100
Message-ID: <5c742bec-723d-b6dd-2571-a574ebbf3ad5@foss.st.com>
Date:   Tue, 17 Jan 2023 12:17:19 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/3] ARM: dts: stm32: add timers support on stm32mp13
Content-Language: en-US
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230110091713.444395-1-olivier.moysan@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230110091713.444395-1-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.219,Aquarius:18.0.923,Hydra:6.0.562,FMLib:17.11.122.1
 definitions=2023-01-17_05,2023-01-17_01,2022-06-22_01
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/10/23 10:17, Olivier Moysan wrote:
> Add STM32 TIM and LPTIM support to STM32MP13 SoCs family.
> Add also support of timers available on DK board RPI expansion connector.
> These timers are configured in the DK board device tree, but let in
> disabled state by default.
> 
> Changes in v2:
> - rebase serie
> 
> Olivier Moysan (3):
>    ARM: dts: stm32: add timers support on stm32mp131
>    ARM: dts: stm32: add timer pins muxing for stm32mp135f-dk
>    ARM: dts: stm32: add timers support on stm32mp135f-dk
> 
>   arch/arm/boot/dts/stm32mp13-pinctrl.dtsi |  60 +++
>   arch/arm/boot/dts/stm32mp131.dtsi        | 557 +++++++++++++++++++++++
>   arch/arm/boot/dts/stm32mp135f-dk.dts     |  58 +++
>   3 files changed, 675 insertions(+)
> 
Series applied on stm32-next.

Regards
Alex
