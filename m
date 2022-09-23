Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA005E75D7
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 10:31:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229942AbiIWIbR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 04:31:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229804AbiIWIbN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 04:31:13 -0400
Received: from relay4-d.mail.gandi.net (relay4-d.mail.gandi.net [IPv6:2001:4b98:dc4:8::224])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CC40E1728;
        Fri, 23 Sep 2022 01:31:11 -0700 (PDT)
Received: (Authenticated sender: miquel.raynal@bootlin.com)
        by mail.gandi.net (Postfix) with ESMTPSA id 15A1EE0011;
        Fri, 23 Sep 2022 08:31:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=bootlin.com; s=gm1;
        t=1663921870;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yCcH0TixQ9AUWLDzLnm1YNaw3iaLd6rBcDmfk2S9O1Q=;
        b=ccwuXM8qEnNRTU7tHhh2kONd9JpPaqplAY5/o3NPVgrkS/pK6/6ryrURcYkKmlpJ0YOxG0
        PoSg6/hDeR621Mx7cuZjZYpm2VtMac8e2daSHtamZ/lBAiUL9j+YsMgBVmDRsBUIQu/21B
        16CgxDBqWH4hkx+iMIu3GVCr1c+yccwG8EVtVdtPGoLYHF8eGL/lm2keWshBDJZZk3AkCd
        86zBp5MJJu9fWaRbqPjobBL45SYQVLaJt8pnHcO0Zj7vVWQ0yU4dJsJx8WDoeF1jyD2snT
        q3iP8BVeaDPBaA1KVuIh+fV8ezNL+d2MzInpp9JYXgvafngwwZPuM1v1lhVUiw==
Date:   Fri, 23 Sep 2022 10:31:05 +0200
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
Cc:     Michael Walle <michael@walle.cc>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>, Li Yang <leoyang.li@nxp.com>,
        =?UTF-8?B?UmFmYcWC?= =?UTF-8?B?IE1pxYJlY2tp?= <rafal@milecki.pl>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-mtd@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Thomas Petazzoni <thomas.petazzoni@bootlin.com>,
        Robert Marko <robert.marko@sartura.hr>
Subject: Re: [PATCH v2 00/20] nvmem: core: introduce NVMEM layouts
Message-ID: <20220923103105.0894845c@xps-13>
In-Reply-To: <1dca4a7f-f4d7-9fd7-69f0-5b0aec51bdef@linaro.org>
References: <20220901221857.2600340-1-michael@walle.cc>
        <20220921115813.208ff789@xps-13>
        <1dca4a7f-f4d7-9fd7-69f0-5b0aec51bdef@linaro.org>
Organization: Bootlin
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Srinivas,

Thanks for the quick feedback.

srinivas.kandagatla@linaro.org wrote on Thu, 22 Sep 2022 22:22:17 +0100:

> On 21/09/2022 10:58, Miquel Raynal wrote:
> >=20
> > Srinivas, can you give us an update on what you think about this
> > series (not a commitment, just how you feel it overall)?
> >  =20
> Overall this is going in right direction, there are few bindings related =
comments once those are sorted out it should be good to go.

Ok, let's tackle those.

>  From NVMEM side am happy with this feature, which has been a long pendin=
g one.
>=20
> We have few discussions on ONIE standard before, layouts would fit in nic=
ely.

I agree they would.

Thanks,
Miqu=C3=A8l
