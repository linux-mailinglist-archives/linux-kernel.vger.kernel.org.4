Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B02D6FEE9D
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 11:22:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237458AbjEKJWk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 05:22:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237455AbjEKJWd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 05:22:33 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 135C22126;
        Thu, 11 May 2023 02:22:30 -0700 (PDT)
Received: from pps.filterd (m0046661.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34B78eoF003364;
        Thu, 11 May 2023 11:21:59 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=SeWGtG+XiqIvze4ZZLjFVr2B3K2HgCHgt+uSIHu1cd0=;
 b=xfoz1DcUtxYMHhLfxpMljJurG3O+QF3UahoG5vMp05o1N4XXk8UJ8Zw/7HgzqIAx8n7W
 ZJF8ieQpHapWlHPB7cYOrchfzUfaVDruvGHUTBrtacC/kH3TSv55ZqCvy/DbY3Q5TZZU
 WwQrXTqe+bpZ4aRrKA+CFcu4NZDR7XGGs7lXAVI2Ade4iZvcIeZ9wagT2FnwAHEG/Itj
 1YmHB4woAUqLRA+LuNyc9XTzfIC3ryeuuLtg/egvx5GbQKbj0yTO4Gbv8ziuzZofp5Wy
 3J6FV7hsR5D5qn/f2FjYnLCDwVNJu9SIhPNbMZ1Tb/rgl8SISw930978hjZvseurYj2U 2g== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3qg9hfevru-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Thu, 11 May 2023 11:21:59 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 6FD13100038;
        Thu, 11 May 2023 11:21:45 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 663D5216ECC;
        Thu, 11 May 2023 11:21:45 +0200 (CEST)
Received: from [10.48.0.11] (10.48.0.11) by SHFDAG1NODE1.st.com (10.75.129.69)
 with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Thu, 11 May
 2023 11:21:44 +0200
Message-ID: <067b2abb-9a84-db6c-725b-87307839b81a@foss.st.com>
Date:   Thu, 11 May 2023 11:21:31 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v2] dt-bindings: rcc: stm32: Sync with u-boot copy for
 STM32MP13 SoC
To:     Conor Dooley <conor@kernel.org>,
        Patrick Delaunay <patrick.delaunay@foss.st.com>
CC:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        <gabriel.fernandez@st.com>, <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>
References: <20230510184305.v2.1.I417093ddcea282be479f10a37147d1935a9050b7@changeid>
 <20230510-cornball-compacter-39e57a5c1906@spud>
Content-Language: en-US
From:   Gabriel FERNANDEZ <gabriel.fernandez@foss.st.com>
In-Reply-To: <20230510-cornball-compacter-39e57a5c1906@spud>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.48.0.11]
X-ClientProxiedBy: EQNCAS1NODE4.st.com (10.75.129.82) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.942,Hydra:6.0.573,FMLib:17.11.170.22
 definitions=2023-05-11_06,2023-05-05_01,2023-02-09_01
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/10/23 19:02, Conor Dooley wrote:
> On Wed, May 10, 2023 at 06:51:40PM +0200, Patrick Delaunay wrote:
>> Minor cosmetic change, aligned with files in U-Boot:
>> - change obsolete SPDX id : GPL-2.0+ and use the same license
>>    GPL-2.0-only for the 2 files
>> - use correct mail address gabriel.fernandez@foss.st.com
>> - remove extra space
> Rob's comments on v1 were about $subject, which you've fixed, although
> the second prefix is a bit odd (I assume since you're changing clock and
> reset headers) and about the change in license to "or-later" for the
> resets header, which you've changed too, so...
>> Signed-off-by: Patrick Delaunay <patrick.delaunay@foss.st.com>
>> ---
>>
>> Changes in v2:
>> - Change title "Fix STM32MP13 include file"
>> - Use the same license for the 2 files GPL-2.0-only as recommended
>>    to avoid check-patch issue on next
>>
>>   include/dt-bindings/clock/stm32mp13-clks.h   | 6 +++---
>>   include/dt-bindings/reset/stm32mp13-resets.h | 4 ++--
>>   2 files changed, 5 insertions(+), 5 deletions(-)
>>
>> diff --git a/include/dt-bindings/clock/stm32mp13-clks.h b/include/dt-bindings/clock/stm32mp13-clks.h
>> index 02befd25edce..0bd7b54c65ff 100644
>> --- a/include/dt-bindings/clock/stm32mp13-clks.h
>> +++ b/include/dt-bindings/clock/stm32mp13-clks.h
>> @@ -1,7 +1,7 @@
>> -/* SPDX-License-Identifier: GPL-2.0+ or BSD-3-Clause */
>> +/* SPDX-License-Identifier: GPL-2.0-only OR BSD-3-Clause */
> ...since Gabriel does appear to be the only author of this file:
>
> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>
> Thanks,
> Conor.

Hi

Acked-by: Gabriel Fernandez <gabriel.fernandez@foss.st.com>

Thanks
Gabriel

