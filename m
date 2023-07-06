Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2884C749954
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Jul 2023 12:24:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231967AbjGFKYB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Jul 2023 06:24:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbjGFKX7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Jul 2023 06:23:59 -0400
Received: from mail11.truemail.it (mail11.truemail.it [IPv6:2001:4b7e:0:8::81])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A075B1BC3;
        Thu,  6 Jul 2023 03:23:52 -0700 (PDT)
Received: from francesco-nb.int.toradex.com (93-49-2-63.ip317.fastwebnet.it [93.49.2.63])
        by mail11.truemail.it (Postfix) with ESMTPA id DD03F20757;
        Thu,  6 Jul 2023 12:23:47 +0200 (CEST)
Date:   Thu, 6 Jul 2023 12:23:43 +0200
From:   Francesco Dolcini <francesco@dolcini.it>
To:     Luca Ceresoli <luca.ceresoli@bootlin.com>
Cc:     Jun Li <jun.li@nxp.com>, Francesco Dolcini <francesco@dolcini.it>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "festevam@gmail.com" <festevam@gmail.com>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "kernel@pengutronix.de" <kernel@pengutronix.de>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        dl-linux-imx <linux-imx@nxp.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "s.hauer@pengutronix.de" <s.hauer@pengutronix.de>,
        "shawnguo@kernel.org" <shawnguo@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Francesco Dolcini <francesco.dolcini@toradex.com>,
        Xu Yang <xu.yang_2@nxp.com>
Subject: Re: [PATCH v2 2/3] usb: chipidea: imx: support disabling runtime-pm
Message-ID: <ZKaWL3+ClI7iNr/4@francesco-nb.int.toradex.com>
References: <20230504162312.1506763-1-luca.ceresoli@bootlin.com>
 <ZFPiRvoF5l8uGzzZ@francesco-nb.int.toradex.com>
 <PA4PR04MB96403377F5E37C12AD8C25B389729@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <20230505120618.2f4cf22c@booty>
 <ZFThyn/D/dDK9nk3@francesco-nb.int.toradex.com>
 <PA4PR04MB96405EE2468555EA900B340189739@PA4PR04MB9640.eurprd04.prod.outlook.com>
 <ZFjaNzY32x8o2XG7@francesco-nb.int.toradex.com>
 <20230508151756.785ec07e@booty>
 <20230529121825.71e9b6d6@booty>
 <PA4PR04MB96405138465D215C34285F02894B9@PA4PR04MB9640.eurprd04.prod.outlook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <PA4PR04MB96405138465D215C34285F02894B9@PA4PR04MB9640.eurprd04.prod.outlook.com>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Luca,

On Tue, May 30, 2023 at 11:22:51AM +0000, Jun Li wrote:
> Yes, your understanding is correct, talked with Xu(in CC), he will take this
> soon.

A series was posted
https://lore.kernel.org/all/20230627110353.1879477-1-xu.yang_2@nxp.com/,
I had no time to try or look at it yet.

Francesco

