Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 427256CC73E
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 17:58:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232633AbjC1P60 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 11:58:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231432AbjC1P6W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 11:58:22 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB0DCE1;
        Tue, 28 Mar 2023 08:58:21 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 32SE1UCg013735;
        Tue, 28 Mar 2023 17:58:12 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=3cqzRIJdewoK2RAi7Vek0DH6QdLvv7qnifIjCxrVoo4=;
 b=nG4fdk0pfSI8CI103Ymn/Ki01uFeQV3oAVzI7HQX5A65W/AF8jZNMHomUH0v52iLGkdW
 oKqWkUjiTqb3Cvtsjo+gtQ1RRC+KWkIBOB1/pEukeylwuTRO1P/vEP3ExbZCloJhPckD
 M/+jG0dRVwFrx8cWJ9Zvtx/lZYHYQYRd8iGZ3BT0X5glcs6dwQKNOknsURnPl1KNEeD+
 fSN1oSll7ruenM09kMx3ItEnVWEWAo9kcuJ4yYzMRCYdooSxGMFYzRMeQ5cf6f0oW5HF
 an7h0i0ZTgCC0Ugba8kqN9dqUXUmEGkY+dAw3jhOCCOQpSPOnLbj+Olw41QKPIehYFTb Iw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3phsqwkabn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 28 Mar 2023 17:58:12 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 41F0A10002A;
        Tue, 28 Mar 2023 17:58:11 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 3AE9B21A205;
        Tue, 28 Mar 2023 17:58:11 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.17; Tue, 28 Mar
 2023 17:58:10 +0200
Message-ID: <38c0e334-7b88-d139-37f7-ad3e99b0bb16@foss.st.com>
Date:   Tue, 28 Mar 2023 17:58:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 0/6] ARM: dts: stm32: stm32mp15 various fixes and add
 stm32mp13 usart nodes
Content-Language: en-US
To:     Valentin Caron <valentin.caron@foss.st.com>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230328153723.498672-1-valentin.caron@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230328153723.498672-1-valentin.caron@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.254,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-03-24_11,2023-03-28_02,2023-02-09_01
X-Spam-Status: No, score=-0.8 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/28/23 17:37, Valentin Caron wrote:
> On stm32mp15 device trees:
>    - Fix pins of USART2 of stm32mp15 dk* boards
>    - Remove duplicates serial aliases
> 
> On stm32mp13 device trees:
>    - Add USART nodes in stm32mp131.dtsi
>    - Add USART nodes in stm32mp135f-dk.dts
>    
> Changes in v2:
>    - Drop patch about SCMI clock of USART1.
> 
> Valentin Caron (6):
>    ARM: dts: stm32: fix slew-rate of USART2 on stm32mp15xx-dkx
>    ARM: dts: stm32: clean uart aliases on stm32mp15xx-dkx boards
>    ARM: dts: stm32: clean uart aliases on stm32mp15xx-exx boards
>    ARM: dts: stm32: add uart nodes on stm32mp13
>    ARM: dts: stm32: add pins for usart2/1/4/8 in stm32mp13-pinctrl
>    ARM: dts: stm32: add uart nodes and uart aliases on stm32mp135f-dk
> 
>   arch/arm/boot/dts/stm32mp13-pinctrl.dtsi | 129 +++++++++++++++++++++++
>   arch/arm/boot/dts/stm32mp131.dtsi        |  97 ++++++++++++++++-
>   arch/arm/boot/dts/stm32mp135f-dk.dts     |  42 +++++++-
>   arch/arm/boot/dts/stm32mp15-pinctrl.dtsi |   4 +-
>   arch/arm/boot/dts/stm32mp157a-dk1.dts    |   3 -
>   arch/arm/boot/dts/stm32mp157c-dk2.dts    |   3 -
>   arch/arm/boot/dts/stm32mp157c-ed1.dts    |   8 +-
>   arch/arm/boot/dts/stm32mp157c-ev1.dts    |   9 +-
>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi   |   6 ++
>   9 files changed, 282 insertions(+), 19 deletions(-)
> 
Series applied on stm32-next.

Regards
Alex
