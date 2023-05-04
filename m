Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298366F65C3
	for <lists+linux-kernel@lfdr.de>; Thu,  4 May 2023 09:32:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230079AbjEDHch (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 May 2023 03:32:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49380 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229712AbjEDHc3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 May 2023 03:32:29 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB5E3593
        for <linux-kernel@vger.kernel.org>; Thu,  4 May 2023 00:32:26 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=[127.0.0.1])
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1puTRk-0001GQ-Mb; Thu, 04 May 2023 09:32:12 +0200
Message-ID: <0a5d631a-037e-5158-82dd-e53d478befea@pengutronix.de>
Date:   Thu, 4 May 2023 09:32:11 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH 1/2] dt-bindings: phy: imx8mq-usb: add phy tuning
 properties
Content-Language: en-US, de-DE
From:   Johannes Zink <j.zink@pengutronix.de>
To:     Rob Herring <robh@kernel.org>
Cc:     kishon@kernel.org, devicetree@vger.kernel.org,
        krzysztof.kozlowski+dt@linaro.org, festevam@gmail.com,
        s.hauer@pengutronix.de, vkoul@kernel.org, haibo.chen@nxp.com,
        linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-imx@nxp.com, kernel@pengutronix.de,
        linux-phy@lists.infradead.org, shawnguo@kernel.org,
        linux-arm-kernel@lists.infradead.org, jun.li@nxp.com,
        patchwork-jzi@pengutronix.de
References: <20230405112118.1256151-1-j.zink@pengutronix.de>
 <20230405112118.1256151-2-j.zink@pengutronix.de>
 <5398cbe0-c681-5dd7-0b3e-3a586cc4915f@linaro.org>
 <3f7257ee36dc44f162a87281c8279fd5bad91dea.camel@pengutronix.de>
 <95b4afd4-c93e-628b-fd22-6fcbc1d1234e@linaro.org>
 <b394b456540943b1022a7b093bf369924fca0566.camel@pengutronix.de>
 <20230412133921.GA2017891-robh@kernel.org>
 <6953b608-973f-c603-f852-edf7ba183e64@pengutronix.de>
 <67d283f3-d0db-5fc0-79e9-e7531d591aab@pengutronix.de>
In-Reply-To: <67d283f3-d0db-5fc0-79e9-e7531d591aab@pengutronix.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Rob, hi Krzysztof,

[snip]
 > gentle ping - any opinions on this? Shall I just send a V2 along the 
lines of the phy-stm32-usbphy.c?

This would be something like (example for the trim-hs-current, taken 
from pyh-stm32-usbphyc):

       st,trim-hs-current:
         description: |
           Controls HS driver current trimming for choke compensation
           - <0> = 18.87 mA target current / nominal + 0%
           - <1> = 19.165 mA target current / nominal + 1.56%
           - <2> = 19.46 mA target current / nominal + 3.12%
           - <3> = 19.755 mA target current / nominal + 4.68%
           - <4> = 20.05 mA target current / nominal + 6.24%
           - <5> = 20.345 mA target current / nominal + 7.8%
           - <6> = 20.64 mA target current / nominal + 9.36%
           - <7> = 20.935 mA target current / nominal + 10.92%
           - <8> = 21.23 mA target current / nominal + 12.48%
           - <9> = 21.525 mA target current / nominal + 14.04%
           - <10> = 21.82 mA target current / nominal + 15.6%
           - <11> = 22.115 mA target current / nominal + 17.16%
           - <12> = 22.458 mA target current / nominal + 19.01%
           - <13> = 22.755 mA target current / nominal + 20.58%
           - <14> = 23.052 mA target current / nominal + 22.16%
           - <15> = 23.348 mA target current / nominal + 23.73%
         $ref: /schemas/types.yaml#/definitions/uint32
         minimum: 0
         maximum: 15
         default: 0

If you think something along these lines is acceptable, I would like to 
prepare and send a V2.

Best regards
Johannes

[snip]
