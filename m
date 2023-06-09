Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5FE37729C8E
	for <lists+linux-kernel@lfdr.de>; Fri,  9 Jun 2023 16:18:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240665AbjFIOR7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 9 Jun 2023 10:17:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240645AbjFIOR4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 9 Jun 2023 10:17:56 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FF1E30E3;
        Fri,  9 Jun 2023 07:17:54 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 359A3FmR006476;
        Fri, 9 Jun 2023 16:17:32 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=btDJtIh1cw3yXU+IQ7CpStkfIN76KqeRQ3JfVlXbAHw=;
 b=OB5RknaZn43QojrQ0uBNb1Btof6jmsRoKnuUDvpaK8NnAmc0PU5Cqq44GRcjzfKV5DRB
 dMlVrm8iyMkojpd1zYXZPwQB/22Gtw4dNzCT0GBmXs2BqhybcJrl9ufMMfYgJiSwB1iV
 g2PnaGC+1eohFK90Wt1JIQAmj29ipXSxsjrB7DNH1vHbuLIaa39Nvhr+IoKCYJJCOzSl
 766ZsPX5X18oIDSM1LUBcu4xxAOC/1NmYwhRKxcvtrUdoRw3Wuwpe+90mG9NheEobNUN
 AItK8oBagezDCRDNv4jCQNWzJ5VfARNibV2adaA51FJ7uV7sYZ0JXw1xmm797boncUVp rQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r42081h4r-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 09 Jun 2023 16:17:32 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2529510003D;
        Fri,  9 Jun 2023 16:17:32 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1AAEB236937;
        Fri,  9 Jun 2023 16:17:32 +0200 (CEST)
Received: from [10.129.178.187] (10.129.178.187) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Fri, 9 Jun
 2023 16:17:31 +0200
Message-ID: <062c5f47-d973-0fc3-9799-17282586f374@foss.st.com>
Date:   Fri, 9 Jun 2023 16:17:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [Linux-stm32] [PATCH v3 1/4] ARM: dts: stm32: add ltdc support on
 stm32f746 MCU
Content-Language: en-US
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC:     <devicetree@vger.kernel.org>, Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        <michael@amarulasolutions.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230609062050.2107143-1-dario.binacchi@amarulasolutions.com>
 <20230609062050.2107143-2-dario.binacchi@amarulasolutions.com>
From:   Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <20230609062050.2107143-2-dario.binacchi@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.129.178.187]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-09_10,2023-06-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/9/23 08:20, Dario Binacchi wrote:
> Add LTDC (Lcd-tft Display Controller) support.
>
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>

Reviewed-by: Raphaël Gallais-Pou <raphael.gallais-pou@foss.st.com>

> ---
>
> (no changes since v1)
>
>  arch/arm/boot/dts/stm32f746.dtsi | 10 ++++++++++
>  1 file changed, 10 insertions(+)

