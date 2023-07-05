Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C70957480CE
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 11:28:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231422AbjGEJ20 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jul 2023 05:28:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49330 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231349AbjGEJ2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jul 2023 05:28:22 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE2C5134
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jul 2023 02:28:20 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <a.fatoum@pengutronix.de>)
        id 1qGynx-0007GO-JO; Wed, 05 Jul 2023 11:28:09 +0200
Message-ID: <61e9e380-dcb0-4dd4-562d-bffea2da5097@pengutronix.de>
Date:   Wed, 5 Jul 2023 11:28:07 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH 1/3] dt-bindings: arm: fsl: fix DEBIX binding
Content-Language: en-US
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Marco Felsch <m.felsch@pengutronix.de>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, conor+dt@kernel.org,
        shawnguo@kernel.org, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, marex@denx.de, frieder.schrempf@kontron.de
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
References: <20230704184109.991104-1-m.felsch@pengutronix.de>
 <6f7586ee-257b-35b5-f986-0d2b370e4035@linaro.org>
From:   Ahmad Fatoum <a.fatoum@pengutronix.de>
In-Reply-To: <6f7586ee-257b-35b5-f986-0d2b370e4035@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: a.fatoum@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.07.23 08:35, Krzysztof Kozlowski wrote:
> On 04/07/2023 20:41, Marco Felsch wrote:
>> The current imx8mp-debix-model-a.dts uses all three compatibles. Fix the
>> corresponding bindings by adding an own entry for it.
>>
>> Signed-off-by: Marco Felsch <m.felsch@pengutronix.de>
>> ---
>>  Documentation/devicetree/bindings/arm/fsl.yaml | 9 +++++++--
>>  1 file changed, 7 insertions(+), 2 deletions(-)
>>
>> diff --git a/Documentation/devicetree/bindings/arm/fsl.yaml b/Documentation/devicetree/bindings/arm/fsl.yaml
>> index 15d4110840654..d9e763ef932e5 100644
>> --- a/Documentation/devicetree/bindings/arm/fsl.yaml
>> +++ b/Documentation/devicetree/bindings/arm/fsl.yaml
>> @@ -1019,8 +1019,6 @@ properties:
>>                - dmo,imx8mp-data-modul-edm-sbc # i.MX8MP eDM SBC
>>                - fsl,imx8mp-evk            # i.MX8MP EVK Board
>>                - gateworks,imx8mp-gw74xx   # i.MX8MP Gateworks Board
>> -              - polyhex,imx8mp-debix      # Polyhex Debix boards
>> -              - polyhex,imx8mp-debix-model-a # Polyhex Debix Model A Board
>>                - toradex,verdin-imx8mp     # Verdin iMX8M Plus Modules
>>                - toradex,verdin-imx8mp-nonwifi  # Verdin iMX8M Plus Modules without Wi-Fi / BT
>>                - toradex,verdin-imx8mp-wifi  # Verdin iMX8M Plus Wi-Fi / BT Modules
>> @@ -1054,6 +1052,13 @@ properties:
>>            - const: phytec,imx8mp-phycore-som         # phyCORE-i.MX8MP SoM
>>            - const: fsl,imx8mp
>>  
>> +      - description: Polyhex DEBIX i.MX8MP based SBCs
>> +        items:
>> +          - enum:
>> +              - polyhex,imx8mp-debix-model-a        # Polyhex Debix Model A Board
>> +          - const: polyhex,imx8mp-debix             # Polyhex Debix boards
> 
> Same comments as for patch #2. I think this should be rather deprecated
> - not a good pattern.

The middle compatible was my suggestion, because there's also the Debix Model
B Standard and Model B SE, which is the same board, but different SoC variant:

 Model A:          Commercial Temperature Grade
 Model B Standard: Industrial Temperature Grade
 Model B SE:       Industrial Temperature Grate, but i.MX8MP Lite
                   (No Neural/Video/Image accelerators).

As everything outside the SoC is the same, I wanted a generic board
compatible that bootloaders can match against. The SoMs should probably
not reuse it, but I think it should be kept (perhaps renamed?) for the
SBCs that don't utilize the Debix SoM.

Cheers,
Ahmad

> 
> Best regards,
> Krzysztof
> 
> 
> 

-- 
Pengutronix e.K.                           |                             |
Steuerwalder Str. 21                       | http://www.pengutronix.de/  |
31137 Hildesheim, Germany                  | Phone: +49-5121-206917-0    |
Amtsgericht Hildesheim, HRA 2686           | Fax:   +49-5121-206917-5555 |

