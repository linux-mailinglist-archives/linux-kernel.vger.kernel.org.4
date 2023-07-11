Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88E5974EB32
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 11:55:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229990AbjGKJzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 05:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjGKJzL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 05:55:11 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AA87A1;
        Tue, 11 Jul 2023 02:55:09 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 36B7mZns018506;
        Tue, 11 Jul 2023 11:54:49 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=DdmwbcwKjdUOujh3dcjygwnoj2wjLr34qkQHdcWvyA8=;
 b=uFTS/by5O6AZ4wmuDrELGNEuEVirQHvqHkLLuMrvZUq/e2+GgD2Ququ4MouK7c20mS3D
 IadAR81PQdYWPswoOCpEzesJfJIW9ua1qJb4rIfCJGv1sm9A9A25qveIAPujxTVwImr8
 5del0PYNYVIF8CadxOBuILKB0JNJxI3+IsVQX8GyUm+65Hex/1drJn8irGrCqYmz7TSv
 YzDmqrSniEeKlj09EJI3Hm58wPkElus7JrFS4iggJg/lMjbzQpvJ0ousq+jxlk3Do9Of
 eL8IOZeSb7xNNVoR32hpT2jjT423enamy0MV3fQxL6v1tEvDcDf4J+PT5F2i1OLYmFGe vw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3rs311s1gf-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 11 Jul 2023 11:54:49 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id B6896100057;
        Tue, 11 Jul 2023 11:54:48 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id AB76E21515D;
        Tue, 11 Jul 2023 11:54:48 +0200 (CEST)
Received: from [10.201.21.122] (10.201.21.122) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 11 Jul
 2023 11:54:48 +0200
Message-ID: <eb735953-bfa3-4dd7-6ab0-184de050c7de@foss.st.com>
Date:   Tue, 11 Jul 2023 11:54:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH] ARM: dts: stm32: re-add CAN support on stm32f746
Content-Language: en-US
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>,
        <linux-kernel@vger.kernel.org>
CC:     Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230704173317.590190-1-dario.binacchi@amarulasolutions.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230704173317.590190-1-dario.binacchi@amarulasolutions.com>
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
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Dario

On 7/4/23 19:33, Dario Binacchi wrote:
> The revert commit 36a6418bb1259 ("Revert "ARM: dts: stm32: add CAN support
> on stm32f746"") prevented parsing errors due to the lack of CAN3 binding.
> 
> Now that the binding definition for CAN3 is available in the mainline
> thanks to commit 8f3ef556f8e1a ("dt-bindings: mfd: stm32f7: Add binding
> definition for CAN3"), we can re-add the CAN support and make the driver
> usable again.
> 
> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
> ---
> 

...

> +		};
> +
> +		can2: can@40006800 {
> +			compatible = "st,stm32f4-bxcan";
> +			reg = <0x40006800 0x200>;
> +			iterrupts = <63>, <64>, <65>, <66>;

I modified this (bad) line and applied the patch on stm32-next.

br
Alex


> +			interrupt-names = "tx", "rx0", "rx1", "sce";
> +			resets = <&rcc STM32F7_APB1_RESET(CAN2)>;
> +			clocks = <&rcc 0 STM32F7_APB1_CLOCK(CAN2)>;
> +			st,can-secondary;
> +			st,gcan = <&gcan1>;
> +			status = "disabled";
> +		};
> +
>   		cec: cec@40006c00 {
>   			compatible = "st,stm32-cec";
>   			reg = <0x40006C00 0x400>;

