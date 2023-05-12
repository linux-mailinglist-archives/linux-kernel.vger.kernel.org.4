Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8997700CBA
	for <lists+linux-kernel@lfdr.de>; Fri, 12 May 2023 18:16:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238597AbjELQQJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 May 2023 12:16:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232578AbjELQQG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 May 2023 12:16:06 -0400
Received: from mx0b-001ae601.pphosted.com (mx0b-001ae601.pphosted.com [67.231.152.168])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A6F92683;
        Fri, 12 May 2023 09:16:02 -0700 (PDT)
Received: from pps.filterd (m0077474.ppops.net [127.0.0.1])
        by mx0b-001ae601.pphosted.com (8.17.1.19/8.17.1.19) with ESMTP id 34C6Nh0X025791;
        Fri, 12 May 2023 11:15:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=cirrus.com; h=date : from : to : cc
 : subject : message-id : references : mime-version : content-type :
 in-reply-to; s=PODMain02222019;
 bh=ectvF2yfB5aP03Mre+dyD2CVdNXHXzI/gwQc+s7VZHo=;
 b=M60DIvjb0O76RqJ4hF0r8dai/lOM1XbIryRUEux/gCZxD3/0/2Et/Q+S3Luuv8Sdm1i5
 iCcE7IHWR2gDMfQGVR0Ncu19x/YkLcC5wqn9Zsx1eDwaEOnnO1o8e4hs22I8JnosPa3Y
 RxLd0KkqI0c4H7WMtPN4IjgJRFDNsIBnM751ZTOJGMiRSaaeLp1tCOx66LwF4WWVZon1
 mcfqLvpl7V1x4e8DkJLOXYwRpzVDqbrm4X2VmATFRHITJ6aK78WIPFodRURDPcovLR5f
 MFbMXYiR/by8gkPHKGL0UA7crPz+kZoFLA24Z1I4ui9q41fTwYY/xbjnuCoz+RTUz83V EQ== 
Received: from ediex02.ad.cirrus.com ([84.19.233.68])
        by mx0b-001ae601.pphosted.com (PPS) with ESMTPS id 3qf7s46qef-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Fri, 12 May 2023 11:15:47 -0500
Received: from ediex01.ad.cirrus.com (198.61.84.80) by ediex02.ad.cirrus.com
 (198.61.84.81) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.1118.26; Fri, 12 May
 2023 11:15:45 -0500
Received: from ediswmail.ad.cirrus.com (198.61.86.93) by ediex01.ad.cirrus.com
 (198.61.84.80) with Microsoft SMTP Server id 15.2.1118.26 via Frontend
 Transport; Fri, 12 May 2023 11:15:45 -0500
Received: from ediswmail.ad.cirrus.com (ediswmail.ad.cirrus.com [198.61.86.93])
        by ediswmail.ad.cirrus.com (Postfix) with ESMTP id 537A045;
        Fri, 12 May 2023 16:15:45 +0000 (UTC)
Date:   Fri, 12 May 2023 16:15:45 +0000
From:   Charles Keepax <ckeepax@opensource.cirrus.com>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
CC:     <broonie@kernel.org>, <lee@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <conor+dt@kernel.org>,
        <tglx@linutronix.de>, <maz@kernel.org>, <linus.walleij@linaro.org>,
        <vkoul@kernel.org>, <lgirdwood@gmail.com>,
        <yung-chuan.liao@linux.intel.com>, <sanyog.r.kale@intel.com>,
        <pierre-louis.bossart@linux.intel.com>,
        <alsa-devel@alsa-project.org>, <patches@opensource.cirrus.com>,
        <devicetree@vger.kernel.org>, <linux-gpio@vger.kernel.org>,
        <linux-spi@vger.kernel.org>, <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 05/10] dt-bindings: mfd: cirrus,cs42l43: Add initial DT
 binding
Message-ID: <20230512161545.GL68926@ediswmail.ad.cirrus.com>
References: <20230512122838.243002-1-ckeepax@opensource.cirrus.com>
 <20230512122838.243002-6-ckeepax@opensource.cirrus.com>
 <25c92476-7bca-90c4-9130-cb765495a783@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <25c92476-7bca-90c4-9130-cb765495a783@linaro.org>
User-Agent: Mutt/1.5.21 (2010-09-15)
X-Proofpoint-ORIG-GUID: DeAJb7R437xO5rXNDxVczi3uqEnckv76
X-Proofpoint-GUID: DeAJb7R437xO5rXNDxVczi3uqEnckv76
X-Proofpoint-Spam-Reason: safe
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 12, 2023 at 05:23:22PM +0200, Krzysztof Kozlowski wrote:
> On 12/05/2023 14:28, Charles Keepax wrote:
> > +$id: http://devicetree.org/schemas/mfd/cirrus,cs42l43.yaml#
> > +$schema: http://devicetree.org/meta-schemas/core.yaml#
> > +
> > +title: Cirrus Logic CS42L43 Audio CODEC
> 
> That's audio codec, so it should be in sound, not MFD.
> 

Is this true even despite the device being implemented as an MFD?
I am happy to move it, and will do so unless I hear otherwise.

> > +  - VDD_P-supply
> > +  - VDD_A-supply
> > +  - VDD_D-supply
> > +  - VDD_IO-supply
> > +  - VDD_CP-supply
> 
> lowercase, no underscores in all property names.

I guess we can rename all the regulators to lower case.

> > +additionalProperties: false
> 
> This order is quite unexpected... please do not invent your own layout.
> Use example-schema as your starting point. I suspect there will be many
> things to fix, so limited review follows (not complete).
> 
> 
> Missing ref to dai-common

Apologies for that I was a little hesitant about this but this
order did make the binding document much more readable, the
intentation got really hard to follow in the traditional order. I
guess since I have things working now I can put it back, again I
will do so unless I hear otherwise.

> > +  pinctrl:
> > +    type: object
> 
> additionalProperties: false
> 

Can do.

> > +
> > +    allOf:
> > +      - $ref: "../pinctrl/pinctrl.yaml#"
> 
> No quotes, absolute path, so /schemas/pinctrl/....
> 

Can do.

> > +
> > +    properties:
> > +      pin-settings:
> 
> What's this node about? pinctrl/pinctrl/pins? One level too much.
> 

codec/pinctrl/pins

The device is a codec, so the main node should be called codec,
then it has a subnode called pinctrl to satisfy the pinctrl DT
binding.

> > +examples:
> > +  - |
> > +    i2c@e0004000 {
> > +        #address-cells = <1>;
> > +        #size-cells = <0>;
> > +        reg = <0xe0004000 0x1000>;
> 
> Drop, just i2c
> 

Can do.

> > +
> > +        cs42l43: codec@1a {
> > +            compatible = "cirrus,cs42l43";
> > +            reg = <0x1a>;
> > +
> > +            VDD_P-supply = <&vdd5v0>;
> > +            VDD_D-supply = <&vdd1v8>;
> > +            VDD_A-supply = <&vdd1v8>;
> > +            VDD_IO-supply = <&vdd1v8>;
> > +            VDD_CP-supply = <&vdd1v8>;
> > +            VDD_AMP-supply = <&vdd5v0>;
> > +
> > +            reset-gpios = <&gpio 0>;
> 
> Use proper defines for flags.

Can do.

Thanks,
Charles
