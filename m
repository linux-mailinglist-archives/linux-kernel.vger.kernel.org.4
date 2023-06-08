Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B0CB727F83
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 13:57:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235660AbjFHL5k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 07:57:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234001AbjFHL5i (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 07:57:38 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E57C1210C;
        Thu,  8 Jun 2023 04:57:36 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 3589OCnw007652;
        Thu, 8 Jun 2023 13:57:09 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=73Ubk5oRaELFQy9MiHEBTyfooWnX9EJZnQ7YDu0s2/M=;
 b=S73rOSWmTnk9u+GB1rogOjulSFtgS1Yc0hW/82plEdlDrmEh7NEIIKQn34WDhlm4m6hk
 aHL8TgxLwEnbSErpCCnYdsCvvUYntykGWAwjvdgi2ULqeqCRvxzEGyd2cP5AY6gPL3+O
 8VrV1n/27oCSe+A//hKYww5a2XPPDdS6qz8Dbwoy3+bLTQ7VFtlbqQoPN/4GjZj6DSZs
 xSCl2hPEHuEN2QDDR7VNO+sg2ILkS6B/pAgnn0jvqn2Cd9lfAFV5z9AMrrxpzIoWbNGo
 y/BuqtSQ1boqyKlU9A8eQuOvAnLwTLN8gRrqtfKobGAtcP/ZRFoo39sNXtREsDaGwy2g 2A== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r3cax10j8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 08 Jun 2023 13:57:09 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 20F8E10002A;
        Thu,  8 Jun 2023 13:57:06 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id A15922291CB;
        Thu,  8 Jun 2023 13:57:06 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 8 Jun
 2023 13:57:05 +0200
Message-ID: <a02ae654-b0bb-5d57-64b9-94cc3182b463@foss.st.com>
Date:   Thu, 8 Jun 2023 13:57:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/3] ASoC: stm32: fix dtbs_check warnings
Content-Language: en-US
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        "Lucas Tanure" <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     Alexandre Torgue <alexandre.torgue@st.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230606115605.1633595-1-olivier.moysan@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230606115605.1633595-1-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-08_08,2023-06-08_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi

On 6/6/23 13:56, Olivier Moysan wrote:
> Fix dtbs_check warnings in STM32MP15 DK boards Devices Trees for
> STM32 I2S and Cirrus CS42L51 codec.
> 
> - Add OF graph port property in I2S and CS42L51 DT bindings.
>    Fixes warnings:
>    audio-controller@4000b000: Unevaluated properties are not allowed
>    ('port' was unexpected)
>    cs42l51@4a: Unevaluated properties are not allowed
>    ('port' was unexpected)
> - Correct OF graph DAI audio format property for STM32MP15x Dkx I2S node
> 
> Changes in v2:
> - Add port example in i2s and cs42l51 binding
> 
> Olivier Moysan (3):
>    ASoC: dt-bindings: stm32: document audio of graph port for i2s
>    ASoC: dt-bindings: document audio of graph port for cs42l51
>    ARM: dts: stm32: fix i2s endpoint format property for stm32mp15xx-dkx
> 
>   .../devicetree/bindings/sound/cirrus,cs42l51.yaml     | 11 +++++++++++
>   .../devicetree/bindings/sound/st,stm32-i2s.yaml       | 11 +++++++++++
>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi                |  2 +-
>   3 files changed, 23 insertions(+), 1 deletion(-)
> 

Patch[3] applied on stm32-next.

Thanks
Alex
