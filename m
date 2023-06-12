Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C436272BAB3
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 10:31:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232757AbjFLIb0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 04:31:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232540AbjFLIan (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 04:30:43 -0400
Received: from mx07-00178001.pphosted.com (mx07-00178001.pphosted.com [185.132.182.106])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95B573589;
        Mon, 12 Jun 2023 01:30:09 -0700 (PDT)
Received: from pps.filterd (m0241204.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 35C1Ksgi010128;
        Mon, 12 Jun 2023 09:35:48 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=foss.st.com; h=message-id : date :
 mime-version : subject : to : cc : references : from : in-reply-to :
 content-type : content-transfer-encoding; s=selector1;
 bh=opv3kX/ph4BOOfru46Fxfd30UvHEy9/IFAiCrxHELPs=;
 b=xeCAtb+HSOplkuvGUk2p1b2verNsEL46d+xjVg+BPe4glBbyCPue57Skz4XQd9wr9NDM
 DT/ljCLasrv8aOw/Ufd+DcuJ/eI8r0/as61jAtyTdOcV8rBKfP+dVPS+lboGZkMfEHt9
 5NhesBE7HWJbacAM16Pb4Kby+zerJxbCST7N2wE3biIVaVE4Kei4X4P9R0Pw5r0RxjDX
 pzJmptNNH5G5j5Mn112VXde725iW0m1AvsGDkwuEbGEmRKYacJlzhp8hIhdcAQT6yiLy
 C15ZP2fzWbua5yNrWtUYO2br64U5I1NlM3RIqan8Ks/59vJpGcXSEwjk/dq8U0B+5tde kw== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com (PPS) with ESMTPS id 3r5smd1ps3-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Mon, 12 Jun 2023 09:35:48 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 2957810002A;
        Mon, 12 Jun 2023 09:35:47 +0200 (CEST)
Received: from Webmail-eu.st.com (shfdag1node1.st.com [10.75.129.69])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 1B557216835;
        Mon, 12 Jun 2023 09:35:47 +0200 (CEST)
Received: from [10.201.21.93] (10.201.21.93) by SHFDAG1NODE1.st.com
 (10.75.129.69) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2507.21; Mon, 12 Jun
 2023 09:35:46 +0200
Message-ID: <3580b822-1d6e-91af-3f5b-f076a8aaddf1@foss.st.com>
Date:   Mon, 12 Jun 2023 09:35:46 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [RESEND PATCH v2 2/6] ARM: dts: stm32: add pin map for LTDC on
 stm32f7
To:     Dario Binacchi <dario.binacchi@amarulasolutions.com>
CC:     <linux-kernel@vger.kernel.org>,
        Raphael Gallais-Pou <raphael.gallais-pou@foss.st.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <dri-devel@lists.freedesktop.org>,
        Philippe Cornu <philippe.cornu@foss.st.com>,
        Amarula patchwork <linux-amarula@amarulasolutions.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        <michael@amarulasolutions.com>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, <devicetree@vger.kernel.org>
References: <20230607063139.621351-1-dario.binacchi@amarulasolutions.com>
 <20230607063139.621351-3-dario.binacchi@amarulasolutions.com>
 <7139fb21-6a1d-a26f-fef3-d3154d234ca2@foss.st.com>
 <CABGWkvoRZqQsEmpNRhhrRUrf+WHebErPO9Jt2L9bsNL_EKeoHg@mail.gmail.com>
Content-Language: en-US
From:   Alexandre TORGUE <alexandre.torgue@foss.st.com>
In-Reply-To: <CABGWkvoRZqQsEmpNRhhrRUrf+WHebErPO9Jt2L9bsNL_EKeoHg@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.201.21.93]
X-ClientProxiedBy: EQNCAS1NODE3.st.com (10.75.129.80) To SHFDAG1NODE1.st.com
 (10.75.129.69)
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.957,Hydra:6.0.573,FMLib:17.11.176.26
 definitions=2023-06-12_04,2023-06-09_01,2023-05-22_02
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,NICE_REPLY_A,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hi Dario

On 6/9/23 08:21, Dario Binacchi wrote:
> Hi Alexandre,
> 
> On Thu, Jun 8, 2023 at 2:42 PM Alexandre TORGUE
> <alexandre.torgue@foss.st.com> wrote:
>>
>> Hi Dario
>>
>> On 6/7/23 08:31, Dario Binacchi wrote:
>>> Add pin configurations for using LTDC (LCD-tft Display Controller) on
>>> stm32f746-disco board.
>>>
>>> Signed-off-by: Dario Binacchi <dario.binacchi@amarulasolutions.com>
>>> ---
>>>
>>> (no changes since v1)
>>>
>>>    arch/arm/boot/dts/stm32f7-pinctrl.dtsi | 35 ++++++++++++++++++++++++++
>>>    1 file changed, 35 insertions(+)
>>>
>>> diff --git a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
>>> index 9f65403295ca..f3f90b9bcd61 100644
>>> --- a/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
>>> +++ b/arch/arm/boot/dts/stm32f7-pinctrl.dtsi
>>> @@ -365,6 +365,41 @@ pins2 {
>>>                                        bias-pull-up;
>>>                                };
>>>                        };
>>> +
>>> +
>>> +                     ltdc_pins_a: ltdc-pins-a-0 {
>>
>>    ltdc-pins-a-0 -->  ltdc-pins-0 is a bit cleaner. I know that I have to
>> fix sdio pins nodes in this file to keep the same spirit for all group
>> names.
> 
> I have looked at the file arch/arm/boot/dts/stm32f7-pinctrl.dtsi, and
> based on the following nodes:
> usart1_pins_a: usart1-0
> i2c1_pins_b: i2c1-0
> can1_pins_a: can1-0
> 
> I have decided to rename ltdc-pins-a-0 to ltdc-0.
> 
> I hope you agree.

Yes! perfect.

Alex

> 
> Thanks and regards,
> 
> Dario
> 
>>
>> If there is no V3 I wil do it directly when I'll apply DT patches if you
>> agree.
>>
>> Alex
>>
>>
>>> +                             pins {
>>> +                                     pinmux = <STM32_PINMUX('E', 4, AF14)>, /* LCD_B0 */
>>> +                                              <STM32_PINMUX('G',12, AF9)>,  /* LCD_B4 */
>>> +                                              <STM32_PINMUX('I', 9, AF14)>, /* LCD_VSYNC */
>>> +                                              <STM32_PINMUX('I',10, AF14)>, /* LCD_HSYNC */
>>> +                                              <STM32_PINMUX('I',14, AF14)>, /* LCD_CLK */
>>> +                                              <STM32_PINMUX('I',15, AF14)>, /* LCD_R0 */
>>> +                                              <STM32_PINMUX('J', 0, AF14)>, /* LCD_R1 */
>>> +                                              <STM32_PINMUX('J', 1, AF14)>, /* LCD_R2 */
>>> +                                              <STM32_PINMUX('J', 2, AF14)>, /* LCD_R3 */
>>> +                                              <STM32_PINMUX('J', 3, AF14)>, /* LCD_R4 */
>>> +                                              <STM32_PINMUX('J', 4, AF14)>, /* LCD_R5 */
>>> +                                              <STM32_PINMUX('J', 5, AF14)>, /* LCD_R6 */
>>> +                                              <STM32_PINMUX('J', 6, AF14)>, /* LCD_R7 */
>>> +                                              <STM32_PINMUX('J', 7, AF14)>, /* LCD_G0 */
>>> +                                              <STM32_PINMUX('J', 8, AF14)>, /* LCD_G1 */
>>> +                                              <STM32_PINMUX('J', 9, AF14)>, /* LCD_G2 */
>>> +                                              <STM32_PINMUX('J',10, AF14)>, /* LCD_G3 */
>>> +                                              <STM32_PINMUX('J',11, AF14)>, /* LCD_G4 */
>>> +                                              <STM32_PINMUX('J',13, AF14)>, /* LCD_B1 */
>>> +                                              <STM32_PINMUX('J',14, AF14)>, /* LCD_B2 */
>>> +                                              <STM32_PINMUX('J',15, AF14)>, /* LCD_B3 */
>>> +                                              <STM32_PINMUX('K', 0, AF14)>, /* LCD_G5 */
>>> +                                              <STM32_PINMUX('K', 1, AF14)>, /* LCD_G6 */
>>> +                                              <STM32_PINMUX('K', 2, AF14)>, /* LCD_G7 */
>>> +                                              <STM32_PINMUX('K', 4, AF14)>, /* LCD_B5 */
>>> +                                              <STM32_PINMUX('K', 5, AF14)>, /* LCD_B6 */
>>> +                                              <STM32_PINMUX('K', 6, AF14)>, /* LCD_B7 */
>>> +                                              <STM32_PINMUX('K', 7, AF14)>; /* LCD_DE */
>>> +                                     slew-rate = <2>;
>>> +                             };
>>> +                     };
>>>                };
>>>        };
>>>    };
>>
> 
> 

