Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 91AA172483E
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Jun 2023 17:53:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238055AbjFFPxK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Jun 2023 11:53:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37464 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231963AbjFFPxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Jun 2023 11:53:08 -0400
Received: from mx07-00178001.pphosted.com (mx08-00178001.pphosted.com [91.207.212.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFE310D4;
        Tue,  6 Jun 2023 08:53:06 -0700 (PDT)
Received: from pps.filterd (m0046660.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 356DEQeu008547;
        Tue, 6 Jun 2023 17:52:36 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=5IUJcU++ZB9s6cZHOpqcQtT4Gl5x6kOb3LYpwx9uNqM=;
 b=5phnNVXAg0S1bGNk39K8BxToytCsg8Awgy5cWSNaAaDB1msYRI+sCqDzr4omyICCRDOV
 0Vs+hX1js3kygaZM5B0OMx2w53sxupvpjQx8JwPuOb/ZPTSBhK99R93Ft0SV9c7uEmIU
 DHxbc+n8O2P5FlDyMAlpZKFW2N9mr61riQ811ikQxF/SzCy3pPhQrBEDQ1yKxwIl2dmJ
 U11hPHhxZTrl75WdHP/GaOhFk11o6rcpQIl8koQVdBqxxKikw5gz13gi+RfT3RrhmI6W
 905hfF6h3a/1FuElAEmWHuRIoRJCkm8PliGu1SGljYt3tpRu97Me8vlpyX+Tj4gTwv0O WA== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r25gp0whn-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 06 Jun 2023 17:52:36 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 42E9110002A;
        Tue,  6 Jun 2023 17:52:16 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1868422D195;
        Tue,  6 Jun 2023 17:52:16 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 6 Jun
 2023 17:52:14 +0200
Message-ID: <fd5b0cb6-a6ae-0ff5-d657-ddde6651ac9f@foss.st.com>
Date:   Tue, 6 Jun 2023 17:52:13 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 0/3] ASoC: stm32: fix dtbs_check warnings
Content-Language: en-US
To:     Olivier Moysan <olivier.moysan@foss.st.com>,
        James Schulman <james.schulman@cirrus.com>,
        David Rhodes <david.rhodes@cirrus.com>,
        "Lucas Tanure" <tanureal@opensource.cirrus.com>,
        Richard Fitzgerald <rf@opensource.cirrus.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Arnaud Pouliquen <arnaud.pouliquen@foss.st.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>
CC:     Alexandre Torgue <alexandre.torgue@st.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <20230531140912.819373-1-olivier.moysan@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230531140912.819373-1-olivier.moysan@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-06_11,2023-06-06_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark

On 5/31/23 16:09, Olivier Moysan wrote:
> Fix dtbs_check warnings in STM32MP15 DK boards Devices Trees for
> STM32 I2S and Cirrus CS42L51 codec.
> 
> - Add OF graph port property in I2S and CS42L51 DT bindings.
>    Fixes warnings:
>    audio-controller@4000b000: Unevaluated properties are not allowed
>    ('port' was unexpected)
>    cs42l51@4a: Unevaluated properties are not allowed
>    ('port' was unexpected)
> - Correct OF graph DAI audio format property for STM32MP15x Dkx I2S node
> 
> Olivier Moysan (3):
>    ASoC: dt-bindings: stm32: document audio of graph port for i2s
>    ASoC: dt-bindings: document audio of graph port for cs42l51
>    ARM: dts: stm32: fix i2s endpoint format property for stm32mp15xx-dkx
> 
>   Documentation/devicetree/bindings/sound/cirrus,cs42l51.yaml | 4 ++++
>   Documentation/devicetree/bindings/sound/st,stm32-i2s.yaml   | 4 ++++
>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi                      | 2 +-
>   3 files changed, 9 insertions(+), 1 deletion(-)
> 

Bindings patches have been acked, do you plan to take patches [1][2] in 
your ASOC tree ? I'll take patch[3].

cheers
Alex
