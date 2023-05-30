Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7588971623E
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 15:39:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232742AbjE3NjK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 09:39:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231665AbjE3NjI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 09:39:08 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4861EA1;
        Tue, 30 May 2023 06:39:07 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34UC3ghA017399;
        Tue, 30 May 2023 15:38:39 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=h3UJJ7gv6LbZY+kgVidEBO7tNCMRdOY5R4jWJYzfASU=;
 b=E/qCAVSEb2LZOD/LX+28gscOj8xRXRisI6JDDFiZPNH6eX0D/+LpjJ/WP4Mswln/FreS
 od+vhg9iV6OFDPjq7DhMg+t5Ze/UkWiLkmhpi0pwdmkpVR1cKKRUuDJF/RXlynaxcxEM
 94m4aZn61Z+mvlY88Yq1jfdnpNsxHoklL96St0WZrsXV8u4XfGim5YS8Fc3BVzdWnQ8I
 CmINMCJf5YXkRf9kn64CnmqhrcQ6OFfhCo9e73NX+f583dwbKL9fWCb++ib1Kav6+TVZ
 989jjzhE4rG2+fTH5mHqO+u854vXF8lfQdF4cQ4pMo46jIdsSLWWphltmuPPNXlUn81f cA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3quahy8aue-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 15:38:38 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 1AF5910002A;
        Tue, 30 May 2023 15:38:38 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node2.st.com [10.75.129.70])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 11B16228A35;
        Tue, 30 May 2023 15:38:38 +0200 (CEST)
Received: from [10.129.178.187] (10.129.178.187) by SHFDAG1NODE2.st.com
 (10.75.129.70) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 30 May
 2023 15:38:37 +0200
Message-ID: <af31ae21-2711-2fac-e885-b3bbbcb12be8@foss.st.com>
Date:   Tue, 30 May 2023 15:38:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v4 2/4] dt-bindings: display: st,stm32-dsi: Remove
 unnecessary fields
Content-Language: en-US
To:     Alexandre TORGUE <alexandre.torgue@foss.st.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <linux-stm32@st-md-mailman.stormreply.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        David Airlie <airlied@gmail.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Conor Dooley <conor.dooley@microchip.com>,
        <kernel@dh-electronics.com>, Marek Vasut <marex@denx.de>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <dri-devel@lists.freedesktop.org>,
        Rob Herring <robh+dt@kernel.org>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        Conor Dooley <conor+dt@kernel.org>
References: <20230529091359.71987-1-raphael.gallais-pou@foss.st.com>
 <20230529091359.71987-3-raphael.gallais-pou@foss.st.com>
 <20230530122736.tflfu5cugbd7ooup@krzk-bin>
 <92d5a699-9f5d-2e40-ca73-4604f3e5a657@foss.st.com>
From:   Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
In-Reply-To: <92d5a699-9f5d-2e40-ca73-4604f3e5a657@foss.st.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.129.178.187]
X-ClientProxiedBy: SHFCAS1NODE1.st.com (10.75.129.72) To SHFDAG1NODE2.st.com
 (10.75.129.70)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_10,2023-05-30_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 5/30/23 15:30, Alexandre TORGUE wrote:
> On 5/30/23 14:27, Krzysztof Kozlowski wrote:
>> On Mon, 29 May 2023 11:13:57 +0200, Raphael Gallais-Pou wrote:
>>> "#address-cells" and "#size-cells" are two properties that are not
>>> mandatory. For instance, the DSI could refer to a bridge outside the scope
>>> of the node rather than include a 'panel@0' subnode. By doing so, address
>>> and size fields become then unnecessary, creating a warning at build time.
>>>
>>> Signed-off-by: Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>
>>> Acked-by: Conor Dooley <conor.dooley@microchip.com>
>>> Reviewed-by: Marek Vasut <marex@denx.de>
>>> ---
>>>   Documentation/devicetree/bindings/display/st,stm32-dsi.yaml | 2 --
>>>   1 file changed, 2 deletions(-)
>>>
>>
>> Running 'make dtbs_check' with the schema in this patch gives the
>> following warnings. Consider if they are expected or the schema is
>> incorrect. These may not be new warnings
> I checked it before merging the series on stm32-next tree. I didn't get this
> error. I didn't check commit per commit.
>
> Do you get this error after merging the whole series ?


I think this is because of the order of the patches within the serie. The patch
correcting the yaml is before those modifying the device-trees. This could
explain warnings rise up when checking patch per patch. However I did not get
any errors on top of  the whole serie.

>
>
>>
>> Note that it is not yet a requirement to have 0 warnings for dtbs_check.
>> This will change in the future.
>>
>> Full log is available here: https://patchwork.ozlabs.org/patch/1787034
>>
>>
>> dsi@40016c00: Unevaluated properties are not allowed ('panel-dsi@0' was
>> unexpected)
>>     arch/arm/boot/dts/stm32f469-disco.dtb
>>
>> dsi@5a000000: Unevaluated properties are not allowed ('panel-dsi@0' was
>> unexpected)
>>     arch/arm/boot/dts/stm32mp157c-ev1.dtb
>>     arch/arm/boot/dts/stm32mp157c-ev1-scmi.dtb
>
