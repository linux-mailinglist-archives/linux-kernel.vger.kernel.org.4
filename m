Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B49DC74E916
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 10:28:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231751AbjGKI2Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 04:28:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47322 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231148AbjGKI2U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 04:28:20 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B76EE69;
        Tue, 11 Jul 2023 01:27:59 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B7BULs017783;
        Tue, 11 Jul 2023 10:27:01 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=5BykRxZq5pCQOrfLUK1o5UBK9a6Q0LVx7aCtpEXNmhI=;
 b=hYY5/FGGoPmLSwlUvblXYuAx4RCnoZF/DZP9ExC4PdFqcbiGRCUCsuVavP8edbDSYkID
 FE8szszuXpmepo701cLa3FQG/MlrN927AAgZaSBGPAI/zqz2EL9iH9rG/HaEPtdKzkJQ
 clnk4+MIsMmf/cUfwQQWqBgwfXhuNB4NZfE3wfwm3OCc5nBNiwQHgANO9wKj8rjoj2qZ
 n9nGFjmzYYxHTiqxmpdeencgZzAak4RntcAutHMV5pfd+8OLzQSBe20vxrFtGkciDt8l
 EfwBD919H1k19nRxJ6QuPtKKCLIRos/jltlvK4/LMSx/p0hOpqzQhVH0XwA4orECcasP 3w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rs2fr8kwq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 10:27:01 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2FFA410005D;
        Tue, 11 Jul 2023 10:27:00 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 20ED521513C;
        Tue, 11 Jul 2023 10:27:00 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 11 Jul
 2023 10:26:59 +0200
Message-ID: <fae63cee-042a-ee9b-2f8a-ff7895543df4@foss.st.com>
Date:   Tue, 11 Jul 2023 10:26:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] ARM: dts: stm32: leverage OP-TEE ASync notif on
 STM32MP13x Soc family
Content-Language: en-US
To:     Etienne Carriere <etienne.carriere@foss.st.com>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>
References: <20230710150515.2127124-1-etienne.carriere@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230710150515.2127124-1-etienne.carriere@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.122]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.591,FMLib:17.11.176.26
 definitions=2023-07-11_04,2023-07-06_02,2023-05-22_02
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_BLOCKED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Etienne

On 7/10/23 17:05, Etienne Carriere wrote:
> Enables use of GIC PPI#15 for OP-TEE asynchronous notifications
> on stm32mp13 platforms.
> 
> Signed-off-by: Etienne Carriere <etienne.carriere@foss.st.com>
> ---
>   arch/arm/boot/dts/st/stm32mp131.dtsi | 2 ++
>   1 file changed, 2 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/st/stm32mp131.dtsi b/arch/arm/boot/dts/st/stm32mp131.dtsi
> index d163c267e34c..02f872b99f1d 100644
> --- a/arch/arm/boot/dts/st/stm32mp131.dtsi
> +++ b/arch/arm/boot/dts/st/stm32mp131.dtsi
> @@ -33,6 +33,8 @@ firmware {
>   		optee {
>   			method = "smc";
>   			compatible = "linaro,optee-tz";
> +			interrupt-parent = <&intc>;
> +			interrupts = <GIC_PPI 15 (GIC_CPU_MASK_SIMPLE(1) | IRQ_TYPE_LEVEL_LOW)>;
>   		};
>   
>   		scmi: scmi {

Applied on stm32-next.

Thanks.
Alex
