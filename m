Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF6D6662BDC
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:57:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231830AbjAIQ4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:56:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237372AbjAIQ4I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:56:08 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E13843DBE6;
        Mon,  9 Jan 2023 08:55:39 -0800 (PST)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309CcGuC004595;
        Mon, 9 Jan 2023 17:55:28 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=YjT/bG+TMpRgFpOkWYXPKTVwULXuvHrBXEMuyi5xiqc=;
 b=69WzxP57UXXJoZhip+4l6/j5qNj6dTrnhgHgl+hnCgaA+2AHA52MuDXJsr83tU5eLXtF
 7m8P2rjr6xxRzQmrrJ8bH9TPRDAKjm+HGXacET3auJHEeiiHoFzkhRl0iM7nLIGjZ7Ly
 0GIK3zUCr8yZJSkFWBqjHnxR2b4TbepUeP5a6eJXNgBEcxsZ+HRkL6kwH2kSVkXV2l2H
 QWqocyVy/sKXsRp+qgxkFPfqpVUmzVmadPhMXBSEUqoY/BWPWREZ5EnV/t6gDKNbps2Q
 RI563mCn6M+DZ/VlP6bPtS6edNG1a3fY50JyTYMjB53pS6UszyffIGaOJWAPnfK0gvHC zA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3my0y6uhud-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 17:55:27 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6C70A10002A;
        Mon,  9 Jan 2023 17:55:27 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 64904226FDF;
        Mon,  9 Jan 2023 17:55:27 +0100 (CET)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Mon, 9 Jan
 2023 17:55:26 +0100
Message-ID: <1712d4cf-3315-0d38-04ab-6b55d3f1d4b9@foss.st.com>
Date:   Mon, 9 Jan 2023 17:55:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/4] ARM: dts: add audio support on stm32mp131
Content-Language: en-US
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221118142006.479138-1-olivier.moysan@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20221118142006.479138-1-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_10,2023-01-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olivier

On 11/18/22 15:20, Olivier Moysan wrote:
> Add SAI, I2S, SPDIFRX and DFSDM audio peripherals support for the
> STM32MP13 SoC family.
> 
> Olivier Moysan (4):
>    ARM: dts: stm32: add i2s nodes on stm32mp131
>    ARM: dts: stm32: add sai nodes on stm32mp131
>    ARM: dts: stm32: add spdifrx node on stm32mp131
>    ARM: dts: stm32: add dfsdm node on stm32mp131
> 
>   arch/arm/boot/dts/stm32mp131.dtsi | 149 ++++++++++++++++++++++++++++++
>   1 file changed, 149 insertions(+)
> 

Series applied on stm32-next.

Regards
Alex
