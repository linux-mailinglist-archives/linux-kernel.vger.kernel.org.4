Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B391869EC5A
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Feb 2023 02:30:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230115AbjBVBaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Feb 2023 20:30:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229591AbjBVBaX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Feb 2023 20:30:23 -0500
Received: from codeconstruct.com.au (pi.codeconstruct.com.au [203.29.241.158])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9E21A2E806
        for <linux-kernel@vger.kernel.org>; Tue, 21 Feb 2023 17:30:22 -0800 (PST)
Received: from pecola.lan (unknown [159.196.93.152])
        by mail.codeconstruct.com.au (Postfix) with ESMTPSA id 56D4620037;
        Wed, 22 Feb 2023 09:30:15 +0800 (AWST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=codeconstruct.com.au; s=2022a; t=1677029417;
        bh=dKZoLqo3DWoAawVA6U++xyewr4VS6v9UTkeXqOdFT80=;
        h=Subject:From:To:Date:In-Reply-To:References;
        b=LaMXyIwenqXd2NJpLNx0MJWu44XaaWS+XoUVQz1QhWfj6xROwysPYi4xLGrQNIf/8
         3vMdoH/XGf9BY2b37v5F1QSMq0cOaM/bRejMzgxCBWb+EpSqp3qrsUAIBSoOz2ekzq
         afvd5hPg4g2SVmF5w8+dnhmkD1NRVTkFb8LARY9UlHW/Bld2O+r5NReLqZ3jcQyKV6
         HvUuqLCN+/WPxMcvoEsirCy6QG5UmLNor+K4ZgH0IpmSaJTWCl+6aqq8qpL7mnlgXK
         vW7ZmjerwzWwIFBVlswQLy7YN6BqYtRYWa/FXjmk15FM/qCRtgbwGHVEx++XRWMHyZ
         hweZA1/lDrgsQ==
Message-ID: <d5d0bbdbfdce06a6e2ad34f2fa8f27d4eaf36207.camel@codeconstruct.com.au>
Subject: Re: [PATCH v5 1/2] dt-bindings: i2c: Add support for ASPEED i2Cv2
From:   Jeremy Kerr <jk@codeconstruct.com.au>
To:     Ryan Chen <ryan_chen@aspeedtech.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Joel Stanley <joel@jms.id.au>,
        Andrew Jeffery <andrew@aj.id.au>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        "openbmc@lists.ozlabs.org" <openbmc@lists.ozlabs.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-aspeed@lists.ozlabs.org" <linux-aspeed@lists.ozlabs.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Date:   Wed, 22 Feb 2023 09:30:14 +0800
In-Reply-To: <TYZPR06MB527469EBE6A18B897D2C1F6CF2A59@TYZPR06MB5274.apcprd06.prod.outlook.com>
References: <20230220061745.1973981-1-ryan_chen@aspeedtech.com>
         <20230220061745.1973981-2-ryan_chen@aspeedtech.com>
         <2141e513acc750bf26775f5b435f4dccd41244aa.camel@codeconstruct.com.au>
         <TYZPR06MB5274714E58C319B4FE3B6E1BF2A49@TYZPR06MB5274.apcprd06.prod.outlook.com>
         <dfc2c2c442af55f64e147c920585cb7e6a74939f.camel@codeconstruct.com.au>
         <TYZPR06MB527469EBE6A18B897D2C1F6CF2A59@TYZPR06MB5274.apcprd06.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.3-1 
MIME-Version: 1.0
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ryan,

> > On the other hand, if it's just because of OS behaviour, then this
> > doesn't belong
> > in the DT.
> >=20
> > Maybe to help us understand: why would you ever *not* want DMA
> > mode?
> > Isn't that always preferable?
> In AST SOC i2c design is 16 i2c bus share one dma engine.=20

Does this mean that only one i2c controller in the system can be
configured to use DMA? Or is it able to be shared between multiple
controllers?

> It can be switch setting by dts setting. Otherwise driver by default
> probe is DMA mode.

You've explained what the modes do, and how they're switched, and what
the default is. However this doesn't explain *why* someone would want
to choose a particular mode when creating a controller node.

Still with the question above: assuming there are no restrictions on
DMA usage, why wouldn't a driver implementation just enable it always?

Cheers,


Jeremy
