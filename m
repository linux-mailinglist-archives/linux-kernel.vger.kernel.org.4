Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4FE73662ABA
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:02:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235612AbjAIQCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:02:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42254 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234955AbjAIQC3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:02:29 -0500
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 37C8C1C133;
        Mon,  9 Jan 2023 08:02:28 -0800 (PST)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309BUSOH003298;
        Mon, 9 Jan 2023 17:02:16 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Jt+8u7dc7kaoHRVclJ4gTOkOj2blFmusjgWq7LjVRrc=;
 b=6eZORvo4lw///FcMSYj4Ln6zwTf4V0NdkPNkTC2Mxs2sfnMU50VmLapBkp2bv+V8Qjr3
 N3TpQVRCcgx5z0ntc0G4MZcBVqEkOhUkf6W1XUx75gs0y0oFkJOqF1eBXbRA9/Mp6eR1
 d2m7VgFpN5UgLR6XwdfTItj6hvNG7P3UaFfjwcxMSHQlDPseCZILJxFKwfOVA3ei7ThL
 r5R8zn/DTP6uU3XSFcbWRm55RmCvmieUrGls33uC1GL1qL5cElfjsUzOOZ3wdbzbbM/W
 IcKfgG8UUjDOHiC+uhOXz4dL4USqmIxdykSdgzMu5qYrtJge5c1V9+ls512OAiHeniTW zA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3my0gnvbhq-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 17:02:16 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id EE11610002A;
        Mon,  9 Jan 2023 17:02:14 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E7A812243E9;
        Mon,  9 Jan 2023 17:02:14 +0100 (CET)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Mon, 9 Jan
 2023 17:02:14 +0100
Message-ID: <dd823016-f419-f801-6da5-3fdfc9bd758b@foss.st.com>
Date:   Mon, 9 Jan 2023 17:02:13 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/2] ASoC: stm32: update sound card on stm32mp15xx-dkx
Content-Language: en-US
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     Alexandre Torgue <alexandre.torgue@st.com>,
        <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
References: <20221205121602.17187-1-olivier.moysan@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20221205121602.17187-1-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.923,Hydra:6.0.545,FMLib:17.11.122.1
 definitions=2023-01-09_09,2023-01-09_01,2022-06-22_01
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Olivier

On 12/5/22 13:16, Olivier Moysan wrote:
> This patchset introduces the following changes on STMP32MP15 DK boards
> sound card:
> - Rename the sound card to ease SOC diversity management
> - Cleanup of useless clock property in SAI2A node
> 
> Olivier Moysan (2):
>    ARM: dts: stm32: remove sai kernel clock on stm32mp15xx-dkx
>    ARM: dts: rename sound card on stm32mp15xx-dkx
> 
>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi | 4 +---
>   1 file changed, 1 insertion(+), 3 deletions(-)
> 

Applied on stm32-fixes.

Regards
Alex
