Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CD0976CD931
	for <lists+linux-kernel@lfdr.de>; Wed, 29 Mar 2023 14:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229826AbjC2MOl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Mar 2023 08:14:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229781AbjC2MOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Mar 2023 08:14:39 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C89971A8;
        Wed, 29 Mar 2023 05:14:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Oeo+KEvsYm/f49phGT3gU523a4ToNAc4s2HOF/f1q4o=; b=dXTmJ0JN2K9XfNF4w7tqdopwOv
        FPD9DQkqPGU35fStWtRVSgRSIHqn8PsHWKjS5J5ZIQH2SijIv2uoeNNLRwm5ilnv1WUaAuupLsvgL
        d24ke+dzDTz3Gyr7Aw9Bc5+7erpRYhTXJsJK32VBvHeOLplWE0El3DvZvNOn/DKLdngI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1phUh4-008kk9-Bi; Wed, 29 Mar 2023 14:14:22 +0200
Date:   Wed, 29 Mar 2023 14:14:22 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Peng Fan <peng.fan@nxp.com>
Cc:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>,
        "linus.walleij@linaro.org" <linus.walleij@linaro.org>,
        "brgl@bgdev.pl" <brgl@bgdev.pl>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "festevam@gmail.com" <festevam@gmail.com>,
        dl-linux-imx <linux-imx@nxp.com>,
        "stefan@agner.ch" <stefan@agner.ch>,
        "linux-gpio@vger.kernel.org" <linux-gpio@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] dt-bindings: gpio: vf610: update gpio-ranges
Message-ID: <a7e36016-488f-48b2-98d6-107f6e332acf@lunn.ch>
References: <20230328052912.1957000-1-peng.fan@oss.nxp.com>
 <20230328052912.1957000-2-peng.fan@oss.nxp.com>
 <de82d0ff-3e2f-4822-8430-13e2b1633b3a@lunn.ch>
 <DU0PR04MB9417F31D78A9C998FE3E519888899@DU0PR04MB9417.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <DU0PR04MB9417F31D78A9C998FE3E519888899@DU0PR04MB9417.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> i.MX9 reuse the gpio-vf610 driver and yaml dtschema. There are some
> minor differences from hardware level. The gpio-ranges will also impact
> vybrid, but this may not matter.

So maybe use a constraint to limit it to 1 for everything other than
fsl,imx93-gpio?

	Andrew
