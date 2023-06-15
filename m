Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 099D07311B7
	for <lists+linux-kernel@lfdr.de>; Thu, 15 Jun 2023 10:05:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239138AbjFOIFy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 15 Jun 2023 04:05:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43486 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233955AbjFOIFu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 15 Jun 2023 04:05:50 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 039541AA;
        Thu, 15 Jun 2023 01:05:48 -0700 (PDT)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35F6XFam007602;
        Thu, 15 Jun 2023 10:05:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=rWAsqAnk1NOFfSrch2LiFEFQGq9N0Hnm6C4sCs+M3D4=;
 b=31hrIaUG+w5OmHV87NzjL1XMuVANMHUndDS+geuV4yaGOSRyXOQRfrlPlvbdn+erMk7E
 seB4ccjWnvillD/+0LWQqybK3wYbzQ0F/izSPJp+NRdgSK5DI4Mr6gWxIxcgZOdLuUzr
 2z9XHUE5ln/oMt3V24fhGcdbX0kC8U7nfGLX0K+IVs6YJZ39NXk2UAkJOWVsNjk5I516
 GYI+lm/SOr36nXOntV77sX9+UlnVpI66N0ucc9sf7C+sNe/62ElSfEJZfQT+6cUrnIeH
 1FHYqTd3vTsl4+AfGLyhqFH6jw9P74Qbr16A05ZXcAY0wxa/4m5aDyF744wdhOqMPmSA KA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r7s1maacb-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 15 Jun 2023 10:05:39 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 343B010002A;
        Thu, 15 Jun 2023 10:05:39 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 27FA2216EC2;
        Thu, 15 Jun 2023 10:05:39 +0200 (CEST)
Received: from [10.252.8.64] (10.252.8.64) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 15 Jun
 2023 10:05:38 +0200
Message-ID: <2785de74-69b2-8ebc-09c9-f834adb870c0@foss.st.com>
Date:   Thu, 15 Jun 2023 10:05:33 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 0/4] spi: stm32: add spi slave mode
To:     Mark Brown <broonie@kernel.org>
CC:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Alain Volmat <alain.volmat@foss.st.com>,
        <linux-spi@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20230614102628.202936-1-valentin.caron@foss.st.com>
 <d0b62ef2-5355-4c00-9ff6-4ea9995ec0e1@sirena.org.uk>
Content-Language: en-US
From:   Valentin CARON <valentin.caron@foss.st.com>
In-Reply-To: <d0b62ef2-5355-4c00-9ff6-4ea9995ec0e1@sirena.org.uk>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.252.8.64]
X-ClientProxiedBy: SHFCAS1NODE2.st.com (10.75.129.73) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-15_04,2023-06-14_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 6/14/23 14:16, Mark Brown wrote:
> On Wed, Jun 14, 2023 at 12:26:23PM +0200, Valentin Caron wrote:
>> STM32 SPI can operate in slave mode.
>> This series add this functionnality in spi-stm32 driver.
> The more modern terminology here is device mode.

Hi Mark,

Thanks for your review. I have resent a "v3" with this improvement.

Regards,
Valentin

