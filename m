Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C00777064F8
	for <lists+linux-kernel@lfdr.de>; Wed, 17 May 2023 12:16:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230259AbjEQKQR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 May 2023 06:16:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230086AbjEQKQP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 May 2023 06:16:15 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 403BDE52;
        Wed, 17 May 2023 03:16:14 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34HA9usH020544;
        Wed, 17 May 2023 12:16:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Acu3VRk8URx4zhT9TEYTwcGNoSlssTXFMHvC8yppvWE=;
 b=1Zr2Ztfg4+QPSUcNDm5tMbPTpl0zUBFD7OHRPHin6oj3T7VT8w0nEzqX4M87gb+bBkpw
 vJ8BQRHneVGEHT7iDytVsdwOXrDp9tu4ZR8ffY0l1clk+GqC1/+4l/5Mm/NZaXqdhqUp
 FiQpbbafuW23po6XqZGRC8+tSfyDIDhfN2NxqXK//BbsykwEdE9NBZYWMf0mjpIGxhBU
 J/XCBDLBgmOP0YsbAO5IcLFCi929Vv+MnV3552K7e4CInALMBD0z6KTdPsRLlnBDeZ5G
 RpTCsusA24zmdsDeWaz2D1expySEX16egr+Uczi/4zw5yVf685IGlUUwBfq3VRD+pC2c Xg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qmtefher8-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 17 May 2023 12:16:01 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 3E2D810002A;
        Wed, 17 May 2023 12:16:01 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 31416226FAE;
        Wed, 17 May 2023 12:16:01 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Wed, 17 May
 2023 12:16:00 +0200
Message-ID: <56aafce0-039e-bc5e-37e4-10b7fb4e5fdd@foss.st.com>
Date:   Wed, 17 May 2023 12:15:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 0/2] stm32mp15: update remoteproc to support SCMI
 Device tree
Content-Language: en-US
To:     Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Bjorn Andersson <andersson@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-remoteproc@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20230517074830.569398-1-arnaud.pouliquen@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230517074830.569398-1-arnaud.pouliquen@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-17_02,2023-05-16_01,2023-02-09_01
X-Spam-Status: No, score=-4.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnaud

On 5/17/23 09:48, Arnaud Pouliquen wrote:
> Update vs V3[1]:
> ---------------
> - remove from the V4 the commits already merged by Mathieu Poirier in the
>    remoteproc next branch:
>    - dt-bindings: remoteproc: st,stm32-rproc: Rework reset declarations
>    - remoteproc: stm32: Allow hold boot management by the SCMI reset
>      controller
> - rename patch " ARM: dts: stm32: Update reset declarations" to
>    "ARM: dts: stm32: Update Cortex-M4 reset declarations on stm32mp15"
> - Fix DTS error reported by "make dtbs_check"
> 
> [1]https://lore.kernel.org/lkml/20230512093926.661509-1-arnaud.pouliquen@foss.st.com/
> 
> 
> Description:
> -----------
> This series updates the stm32_rproc driver and associated DT node to
> support device tree configuration with and without SCMI server.
> The impact is mainly on the MCU hold boot management.
> 
> Three configurations have to be supported:
> 
> 1) Configuration without OP-TEE SCMI (legacy): Trusted context not activated
> - The MCU reset is controlled through the Linux RCC reset driver.
> - The MCU HOLD BOOT is controlled through The RCC sysconf.
> 
> 2) Configuration with SCMI server: Trusted context activated
> - The MCU reset is controlled through the SCMI reset service.
> - The MCU HOLD BOOT is no more controlled through a SMC call service but
>    through the SCMI reset service.
> 
> 3) Configuration with OP-TEE SMC call (deprecated): Trusted context activated
> - The MCU reset is controlled through the Linux RCC reset driver.
> - The MCU HOLD BOOT is controlled through The SMC call.
> 
> In consequence this series:
> - adds the use of the SCMI reset service to manage the MCU hold boot,
> - determines the configuration to use depending on the presence of the
>    "reset-names" property
>    if ( "reset-names" property contains "hold_boot")
>    then use reset_control services
>    else use regmap access based on "st,syscfg-holdboot" property.
> - set the DT st,syscfg-tz property as deprecated
> 
> 
> Arnaud Pouliquen (2):
>    ARM: dts: stm32: Update Cortex-M4 reset declarations on stm32mp15
>    ARM: dts: stm32: fix m4_rproc references to use SCMI
> 
>   arch/arm/boot/dts/stm32mp151.dtsi          | 2 +-
>   arch/arm/boot/dts/stm32mp157a-dk1-scmi.dts | 7 +++++--
>   arch/arm/boot/dts/stm32mp157c-dk2-scmi.dts | 7 +++++--
>   arch/arm/boot/dts/stm32mp157c-ed1-scmi.dts | 7 +++++--
>   arch/arm/boot/dts/stm32mp157c-ev1-scmi.dts | 7 +++++--
>   5 files changed, 21 insertions(+), 9 deletions(-)
> 

Series applied on stm32-next.

Regards
Alex
