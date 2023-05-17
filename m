Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A75CF706B5C
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 16:39:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231235AbjEQOjV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 10:39:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33622 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbjEQOjR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 10:39:17 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D0E8F;
        Wed, 17 May 2023 07:39:16 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HEZPrH020544;
        Wed, 17 May 2023 16:38:56 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=GThgjJ8WeVYu7amHQKF0EfhYQvmzeVDT7JNsz08BwJA=;
 b=WSk/ncL9iKDHCBnAkNIy9JluwTU+rEYbjwuCSvNXXM1Gf1TxwV1thX5/wNYYyjcm4Q0G
 T96uLtAeK32uGyR2mOfLsHa/ANTCSUpKGlnnIU2kWTwSsS8BMDC7OEUwPLLUhlvUKxJ2
 kuf7pXd2KCA85QdPR0IkvKSrfVXU01OpRV90pOWyHo0BeFyX1+xB4m08w/T9sTvjL0cg
 WZWjGNoT55c6PiOtD4rknnnSPUFrPGBh2HJUd1w21xJPFWNVVBIpvnRM3s63lfYhNrcs
 n7PbaWSHQnS6hArRmefyZfGkt4xO+ewg0DgA8OZZ6cxlXp/+AoEWAsY2U0h/8ppxHPPd 1g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qmtefk6u9-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 16:38:56 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id E96A9100034;
        Wed, 17 May 2023 16:38:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E0FA723357D;
        Wed, 17 May 2023 16:38:55 +0200 (CEST)
Received: from [10.129.178.187] (10.129.178.187) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 17 May
 2023 16:38:55 +0200
Message-ID: <c617bb64-e7fd-c3de-6e29-6dd7c5896d16@foss.st.com>
Date:   Wed, 17 May 2023 16:38:55 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/3] STM32 warning cleanup
Content-Language: en-US
To:     Marek Vasut <marex@denx.de>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>
CC:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@dh-electronics.com>
References: <20230517132214.254757-1-raphael.gallais-pou@foss.st.com>
 <56bcad63-a32e-63fc-1c20-15909f2788b5@denx.de>
From:   Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <56bcad63-a32e-63fc-1c20-15909f2788b5@denx.de>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.129.178.187]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-17_02,2023-02-09_01
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/17/23 16:06, Marek Vasut wrote:
> On 5/17/23 15:22, Raphael Gallais-Pou wrote:
>> This serie aims to reduce the number of device-tree warnings of
>> following boards :
>>
>>    - STM32F429-DISCO
>>    - STM32MP15*
>>
>> Those warnings were appearing either during build or when checking
>> dt-bindings and concern mostly LTDC and DSI IPs and were due to the
>> following cases:
>>
>>    - panel-dsi@0 nodes that needed
>>    - unnecessary #address-cells and #size-cells properties
>>    - residual 'reg' field on single endpoints
>>
>> Raphael Gallais-Pou (3):
>>    ARM: dts: stm32: fix warnings on stm32f469-disco board
>>    dt-bindings: display: st,stm32-dsi: Remove unnecessary fields
>>    ARM: dts: stm32: fix several DT warnings on stm32mp15
>>
>>   .../devicetree/bindings/display/st,stm32-dsi.yaml      |  2 --
>>   arch/arm/boot/dts/stm32f469-disco.dts                  |  4 ++--
>>   arch/arm/boot/dts/stm32mp151.dtsi                      |  5 -----
>>   arch/arm/boot/dts/stm32mp157.dtsi                      |  7 -------
>>   .../dts/stm32mp157a-icore-stm32mp1-ctouch2-of10.dts    |  6 ++++--
>>   .../boot/dts/stm32mp157a-icore-stm32mp1-edimm2.2.dts   |  6 ++++--
>>   .../stm32mp157a-microgea-stm32mp1-microdev2.0-of7.dts  |  3 +--
>>   arch/arm/boot/dts/stm32mp157c-dk2.dts                  |  8 ++++++++
>>   arch/arm/boot/dts/stm32mp157c-ev1.dts                  | 10 +++++++---
>>   arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts              |  3 +--
>>   arch/arm/boot/dts/stm32mp15xx-dhcor-avenger96.dtsi     |  6 +-----
>>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi                 |  3 +--
>>   12 files changed, 29 insertions(+), 34 deletions(-)
>>
>
> Is this a V2 series ?

Hi Marek


yes it was,

Thanks for highlighting it to me.

Raphaël

>
> If so, please do include changelog .
>
> Also, use "git send-email -v2" to mark those patches as v2 automatically when
> sending .
