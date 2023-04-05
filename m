Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D38C6D7C3F
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 14:15:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237795AbjDEMPS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 08:15:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237007AbjDEMPR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 08:15:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 217293C22
        for <linux-kernel@vger.kernel.org>; Wed,  5 Apr 2023 05:15:16 -0700 (PDT)
Received: from ptz.office.stw.pengutronix.de ([2a0a:edc0:0:900:1d::77] helo=irc.pengutronix.de)
        by metis.ext.pengutronix.de with esmtp (Exim 4.92)
        (envelope-from <j.zink@pengutronix.de>)
        id 1pk22T-0003WC-Id; Wed, 05 Apr 2023 14:14:57 +0200
Message-ID: <3f7257ee36dc44f162a87281c8279fd5bad91dea.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] dt-bindings: phy: imx8mq-usb: add phy tuning
 properties
From:   Johannes Zink <j.zink@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        vkoul@kernel.org, kishon@kernel.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, jun.li@nxp.com,
        haibo.chen@nxp.com, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
Date:   Wed, 05 Apr 2023 14:14:30 +0200
In-Reply-To: <5398cbe0-c681-5dd7-0b3e-3a586cc4915f@linaro.org>
References: <20230405112118.1256151-1-j.zink@pengutronix.de>
         <20230405112118.1256151-2-j.zink@pengutronix.de>
         <5398cbe0-c681-5dd7-0b3e-3a586cc4915f@linaro.org>
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.38.3-1+deb11u1 
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 2a0a:edc0:0:900:1d::77
X-SA-Exim-Mail-From: j.zink@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-2.3 required=5.0 tests=RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Krysztof,

thanks for your review, please find my questions below.

On Wed, 2023-04-05 at 13:51 +0200, Krzysztof Kozlowski wrote:
> [snip]
> >        A phandle to the regulator for USB VBUS.
> >  
> > +  fsl,phy-tx-vref-tune:
> > +    description:
> > +      HS DC Voltage level adjustment
> 
> "Level" in what units?
> 

The datasheet just shows percent, ranging from -6 to +24%, in 2%
increments. What unit would you suggest?

> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15,
> > 16]
> > +
> > +  fsl,phy-tx-rise-tune:
> > +    description:
> > +      HS Transmitter Rise/Fall Time Adjustment
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2, 3]
> > +
> > +  fsl,phy-tx-preemp-amp-tune:
> > +    description:
> > +      HS Transmitter Pre-Emphasis Current Control
> 
> If this is current then use standard unit suffixes.

According to the datasheet this is in "unit amonts" of 600uA, basically
0x600uA, 1x600uA etc. Should I just suffix it with uA then?

> 
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2, 3]
> > +
> > +  fsl,phy-tx-vboost-level:
> > +    description:
> > +      TX Voltage Boost Level
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 2, 3]
> > +
> > +  fsl,phy-comp-dis-tune:
> > +    description:
> > +      Disconnect Threshold Adjustment
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +    enum: [0, 1, 2, 3, 4, 5, 6, 7]
> > +
> > +  fsl,phy-pcs-tx-deemph-3p5db:
> > +    description:
> > +      TX De-Emphasis at 3.5 dB
> > +    $ref: /schemas/types.yaml#/definitions/uint32
> > +
> > +  fsl,phy-pcs-tx-swing-full:
> > +    description:
> > +      TX Amplitude
> 
> I have feeling you just pasted here short titles from datasheet. They
> are not that helpful.

ack, I will add some more text from the register description, since I
have no other source of information on these.

Best regards
Johannes

> 
> 
> 
> Best regards,
> Krzysztof
> 
> 
> 

-- 
Pengutronix e.K.                | Johannes Zink                  |
Steuerwalder Str. 21            | https://www.pengutronix.de/    |
31137 Hildesheim, Germany       | Phone: +49-5121-206917-0       |
Amtsgericht Hildesheim, HRA 2686| Fax:   +49-5121-206917-5555    |

