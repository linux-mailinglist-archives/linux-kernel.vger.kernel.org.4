Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF76271583F
	for <lists+linux-kernel@lfdr.de>; Tue, 30 May 2023 10:20:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230228AbjE3IUB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 May 2023 04:20:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36454 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230365AbjE3ITw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 May 2023 04:19:52 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4912CDB;
        Tue, 30 May 2023 01:19:51 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34U3tvJT017961;
        Tue, 30 May 2023 10:19:22 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=Dt2qDgO0BJH5VS1WqR/hx20Xk2xMe+9JCiqnd8yB2c4=;
 b=kxmmwhPEmr1VkU9dGGWbG9iC3d1CcqZQsU9WeVrR0KwyhiMR+VXiXs7JlA7XZpxpZVDL
 xT3fgf7uQZD9lN6QL52rK9uFm1r59B1WMzeKlt6n3ZAbNsIHJmc2uIF5Ni63Php42Wgn
 NddmHnMuIRvDOhxQ6ZS9EvUWMFozEjp3K9qQyC7pe8wH5LkQlwdxHdtUPMHsYK9hGtBv
 sakopbXPpvOHaZ+Zj4M1zoIYWRClEPCLzLLbUxk/9Wn4D6QZ7r56TUWSGVVZkrL9Xfdz
 Tjq0j3rLyk/uT67ENQ4ov1ANcUcgKl49a3xYi5tzaDoZ/sL1doPDxxWxG7RCiIXshQ03 EQ== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3quahy689t-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 30 May 2023 10:19:22 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id F2C8610002A;
        Tue, 30 May 2023 10:19:20 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id C683B21513C;
        Tue, 30 May 2023 10:19:20 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Tue, 30 May
 2023 10:19:20 +0200
Message-ID: <df9061ee-dda1-5c46-13b9-0043c3173113@foss.st.com>
Date:   Tue, 30 May 2023 10:19:19 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v4 0/4] STM32 warning cleanup
Content-Language: en-US
To:     Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Marek Vasut <marex@denx.de>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Yannick Fertre <yannick.fertre@foss.st.com>
CC:     <dri-devel@lists.freedesktop.org>, <devicetree@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <kernel@dh-electronics.com>
References: <20230529091359.71987-1-raphael.gallais-pou@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20230529091359.71987-1-raphael.gallais-pou@foss.st.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-05-30_05,2023-05-29_02,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Raphael

On 5/29/23 11:13, Raphael Gallais-Pou wrote:
> This serie aims to reduce the number of device-tree warnings of
> following boards :
> 
>    - STM32F469-DISCO
>    - STM32MP15*
> 
> Those warnings were appearing either during build or when checking
> dt-bindings and concern mostly LTDC and DSI IPs. They were due to the
> following cases:
> 
>    - 'panel-dsi@0' instead of 'panel@0' according to the YAML
>    - unnecessary #address-cells and #size-cells properties
>    - residual 'reg' field on single endpoints
> 
> First patch fixes stm32f469-disco device-tree.
> Second patch fixes st,stm32-dsi.yaml dt-bindings.
> Third patch fixes DSI warnings on stm32mp15* device-trees.
> Last patch fixes LTDC warnings on stm32mp15* device-trees.
> 
> Changes since v3:
> 	* Added Conor's acked-by
> 	* Added Marek's reviewed-by
> 	* Split last patch into two separate for clearer review
> 
> Changes since v2:
> 	* Added changelog
> 	* Enhanced commit descriptions
> 
> Changes since v1:
> 	* Added DSI subnode name change
> 	* Included stm32f469-disco DT in the cleanup
> 	* Included YAML fix to prevent regression
> 
> Raphael Gallais-Pou (4):
>    ARM: dts: stm32: fix warnings on stm32f469-disco board
>    dt-bindings: display: st,stm32-dsi: Remove unnecessary fields
>    ARM: dts: stm32: fix dsi warnings on stm32mp15 boards
>    ARM: dts: stm32: fix ltdc warnings in stm32mp15 boards
> 
>   .../bindings/display/st,stm32-dsi.yaml        |  2 --
>   arch/arm/boot/dts/stm32f469-disco.dts         |  4 ++--
>   arch/arm/boot/dts/stm32mp151.dtsi             |  5 -----
>   arch/arm/boot/dts/stm32mp157.dtsi             |  7 -------
>   arch/arm/boot/dts/stm32mp157a-dk1.dts         | 20 +++++++++++++++++++
>   ...tm32mp157a-icore-stm32mp1-ctouch2-of10.dts |  6 ++++--
>   .../stm32mp157a-icore-stm32mp1-edimm2.2.dts   |  6 ++++--
>   ...157a-microgea-stm32mp1-microdev2.0-of7.dts |  3 +--
>   arch/arm/boot/dts/stm32mp157c-dk2.dts         |  8 ++++++++
>   arch/arm/boot/dts/stm32mp157c-ev1.dts         | 10 +++++++---
>   arch/arm/boot/dts/stm32mp157c-lxa-mc1.dts     |  3 +--
>   .../boot/dts/stm32mp15xx-dhcor-avenger96.dtsi |  6 +-----
>   arch/arm/boot/dts/stm32mp15xx-dkx.dtsi        | 18 +----------------
>   13 files changed, 49 insertions(+), 49 deletions(-)
> 

Thanks for this series! No more W=1 Warnings and no more YAML issue 
regarding DSI/LTDC stuff. Thanks Marek for reviews and feedback.

Series applied on stm32-next.

Cheers
Alx
