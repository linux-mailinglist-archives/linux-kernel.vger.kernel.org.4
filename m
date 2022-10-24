Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A943609C7C
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 10:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230268AbiJXI1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 04:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230342AbiJXI0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 04:26:36 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 014B64DB3F;
        Mon, 24 Oct 2022 01:26:16 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.5/8.17.1.5) with ESMTP id 29O7MCXA030959;
        Mon, 24 Oct 2022 10:26:03 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=dOzDY6/9nKLDPhrGpoUZqyh/A75KkyrWIBiqANqXlLI=;
 b=yDd8MeudAA7/XHYPG/0y8Qnfpv1UsVRDlGctc8tI0mQb3Js/i7xRusjoKOmsr8/VCwaZ
 r6o3BXPp5axTiKuLdM1Dtrf2QVXuG3HpjxM74IXoQWmX3mORPgPPmnoUn7HA1WdlVrjH
 COkQtqWHTFef+kkpIIDs6LFjlCw55o9m7ca8Hw/mliHx8EkbLsgXLkjnWpb4U5qWk9Iz
 mm+kUErhfEaSaOjJcNfYJ/pJsfo6IQJQwhDGGS0DS+q1De1sIFYSlV04qT676H+V/ijy
 dD02/lZx86nv5983WqRAgGYeDwp+0RVoi4xRj929Paq93hP71cKKeCohCEAKEmzYvdIR vQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3kc5xksucj-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 24 Oct 2022 10:26:03 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1FC6510002A;
        Mon, 24 Oct 2022 10:25:55 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1AC22216839;
        Mon, 24 Oct 2022 10:25:55 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.31; Mon, 24 Oct
 2022 10:25:54 +0200
Message-ID: <651d7bae-1674-4040-e3b9-6a93839d7906@foss.st.com>
Date:   Mon, 24 Oct 2022 10:25:53 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.2
Subject: Re: [PATCH] ARM: dts: stm32: update vbus-supply of usbphyc_port0 on
 stm32mp157c-ev1
Content-Language: en-US
To:     Fabrice Gasnier <fabrice.gasnier@foss.st.com>,
        <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>
CC:     <amelie.delaunay@foss.st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20220930150232.249573-1-fabrice.gasnier@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20220930150232.249573-1-fabrice.gasnier@foss.st.com>
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

Hi Fabrice

On 9/30/22 17:02, Fabrice Gasnier wrote:
> From: Amelie Delaunay <amelie.delaunay@foss.st.com>
> 
> phy-stm32-usbphyc bindings uses a connector node with vbus-supply
> property.
> 
> Signed-off-by: Amelie Delaunay <amelie.delaunay@foss.st.com>
> Signed-off-by: Fabrice Gasnier <fabrice.gasnier@foss.st.com>
> ---
>   arch/arm/boot/dts/stm32mp157c-ev1.dts | 5 +++++
>   1 file changed, 5 insertions(+)
> 
> diff --git a/arch/arm/boot/dts/stm32mp157c-ev1.dts b/arch/arm/boot/dts/stm32mp157c-ev1.dts
> index d142dd30e16b..e22e394832a8 100644
> --- a/arch/arm/boot/dts/stm32mp157c-ev1.dts
> +++ b/arch/arm/boot/dts/stm32mp157c-ev1.dts
> @@ -385,6 +385,11 @@ &usbphyc_port0 {
>   	st,tune-squelch-level = <3>;
>   	st,tune-hs-rx-offset = <2>;
>   	st,no-lsfs-sc;
> +
> +	connector {
> +		compatible = "usb-a-connector";
> +		vbus-supply = <&vbus_sw>;
> +	};
>   };
>   
>   &usbphyc_port1 {

Applied on stm32-next.

Thanks
Alex
