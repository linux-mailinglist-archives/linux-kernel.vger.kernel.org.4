Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0790F609C7B
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:27:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230387AbiJXI1L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:27:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230341AbiJXI0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:26:36 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1D0B84D4D7;
        Mon, 24 Oct 2022 01:26:09 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29O7nHTW020020;
        Mon, 24 Oct 2022 10:25:42 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=y1rr3SuzTx4+VSNLhUbJG8kHUD97eG7n0PTphv4eVAg=;
 b=tP96pfR7y0WNwl5Oahwq626J46hrmj+Uco9tUYaSC2Mlfr1q5BFTCkj8bCSogw81G5ou
 8N7U2a+TTaoySn8KvuXHIZEHCFlVB9alEniWHRuPafegtNoo+8D6m71INR0h2atkiLD5
 iz7J1T80xQQtAs6axzTcRKZe3GtZAKZJloM/Gj4FDkqkH1JA/Onb2Fgs+YLr+RF7xB4+
 8ZVAKgSo7USM3szfz3vFWC5/Z46XAVmlN8Ef+OpmYWQhLRi//qdeJmN6IqEQox7VQqSA
 O/QbWMFzQhl411UylzZ9tibtHg/kb3fSF4FjK80Mst1+wmAsu5cZpAnMfztpd/CSI1m3 Sw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kc7v29djc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 10:25:42 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 57F0610002A;
        Mon, 24 Oct 2022 10:25:36 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id EC7A621683A;
        Mon, 24 Oct 2022 10:25:36 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 10:25:36 +0200
Message-ID: <3392048d-e7a9-efb2-b795-30ee0c6ad6d1@foss.st.com>
Date:   Mon, 24 Oct 2022 10:25:35 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] ARM: dts: stm32: add support for USB2514B onboard hub on
 stm32mp157c-ev1
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <amelie.delaunay@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20220930145643.249099-1-fabrice.gasnier@foss.st.com>
Content-Language: en-US
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20220930145643.249099-1-fabrice.gasnier@foss.st.com>
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

Hi Fabrice,

On 9/30/22 16:56, Fabrice Gasnier wrote:
> Add support for USB2514B onboard hub on stm32mp157c EV1 board. The HUB
> is supplied by a 3v3 PMIC regulator.
> 
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c-ev1.dts | 8 ++++++++
>   1 file changed, 8 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
> index e22e394832a8..a0ff92662e02 100644
> --- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
> @@ -362,6 +362,14 @@ &usart3 {
>   &usbh_ehci {
>   	phys = <&usbphyc_port0>;
>   	status = "okay";
> +	#address-cells = <1>;
> +	#size-cells = <0>;
> +	/* onboard HUB */
> +	hub@1 {
> +		compatible = "usb424,2514";
> +		reg = <1>;
> +		vdd-supply = <&v3v3>;
> +	};
>   };
>   
>   &usbotg_hs {

Applied on stm32-next.

Thanks
Alex
