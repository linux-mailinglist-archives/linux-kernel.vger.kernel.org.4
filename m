Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 313A1662B27
	for <lists+linux-kernel@lfdr.de>; Mon,  9 Jan 2023 17:26:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233721AbjAIQ0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 Jan 2023 11:26:32 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230031AbjAIQ0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Jan 2023 11:26:30 -0500
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F40CDB3F;
        Mon,  9 Jan 2023 08:26:28 -0800 (PST)
Received: from pps.filterd (m0288072.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 309Cbxb4009933;
        Mon, 9 Jan 2023 17:26:04 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=xb3CcM66JaqFadPsfmjLS5Ft9J7JyheCnRY1YlLrfx8=;
 b=D2XzfgNt6IbXQBZFDY9f6cvP7pugcjLw8GI+p38ZgWQb9R3Jo5FY0+SeCm47xxf5P+eG
 aG//LdKozgJ//nkkdh+gggbdVhe7q5CdFt8F42HWVjWVKkB7OfhFs0JuT8vAdFXFoD9b
 4PlqrGtPZimTqQ0f3H88oL3soneA31hweaoMQt5H2l3aC5PNjzLNuQyFv+iYDQyqt/tb
 Xb1ECVbcCnzN8I76Ww6LCNm4EwJrnc6JxGDtEtVhgaQbLULCASVu63ojnP8/+Nunw10k
 MaRBSiXQaCXPWNapsAuiWyFFA5dSZrDOsqiPEtWiYyZV+D38w43gI7NzTLOL/tLy7M5n yg== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3mxy1qkrke-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 09 Jan 2023 17:26:04 +0100
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 019F810002A;
        Mon,  9 Jan 2023 17:26:03 +0100 (CET)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id E3FD5225921;
        Mon,  9 Jan 2023 17:26:03 +0100 (CET)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.13; Mon, 9 Jan
 2023 17:26:02 +0100
Message-ID: <d9593bd8-f264-a754-80c2-d694d383af88@foss.st.com>
Date:   Mon, 9 Jan 2023 17:26:02 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH 0/4] Fix qspi pinctrl phandle for stm3mp15 based boards
Content-Language: en-US
To:     <patrice.chotard@foss.st.com>, <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>
CC:     <mcoquelin.stm32@gmail.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <linux@armlinux.org.uk>, <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>,
        Marek Vasut <marex@denx.de>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Reinhold Mueller <reinhold.mueller@emtrion.com>,
        Oleksij Rempel <o.rempel@pengutronix.de>
References: <20221212085142.3944367-1-patrice.chotard@foss.st.com>
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <20221212085142.3944367-1-patrice.chotard@foss.st.com>
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

Hi Patrice

On 12/12/22 09:51, patrice.chotard@foss.st.com wrote:
> From: Patrice Chotard <patrice.chotard@foss.st.com>
> 
> qspi_bk1_pins_a and qspi_bk2_pins_a pinctrl phandle has been splitted in
> 2 parts. Only stm32mp157c-ev1.dts has been updated properly.
> 
> Fix qspi pinctrl phandle for other boards which are based on stm32mp15x SoC.
> 
> Patrice Chotard (4):
>    ARM: dts: stm32: Fix qspi pinctrl phandle for stm32mp15xx-dhcor-som
>    ARM: dts: stm32: Fix qspi pinctrl phandle for stm32mp15xx-dhcom-som
>    ARM: dts: stm32: Fix qspi pinctrl phandle for
>      stm32mp157c-emstamp-argon
>    ARM: dts: stm32: Fix qspi pinctrl phandle for stm32mp151a-prtt1l
> 
> Cc: Marek Vasut <marex@denx.de>
> Cc: Alexandre Torgue <alexandre.torgue@st.com>
> Cc: Reinhold Mueller <reinhold.mueller@emtrion.com>
> Cc: Oleksij Rempel <o.rempel@pengutronix.de>
> Cc: linux-stm32@st-md-mailman.stormreply.com
> To: linux-arm-kernel@lists.infradead.org
> 
>   arch/arm/boot/dts/stm32mp151a-prtt1l.dtsi        | 8 ++++++--
>   arch/arm/boot/dts/stm32mp157c-emstamp-argon.dtsi | 8 ++++++--
>   arch/arm/boot/dts/stm32mp15xx-dhcom-som.dtsi     | 8 ++++++--
>   arch/arm/boot/dts/stm32mp15xx-dhcor-som.dtsi     | 8 ++++++--
>   4 files changed, 24 insertions(+), 8 deletions(-)
> 

Series applied on stm32-fixes.

Regards
Alex
