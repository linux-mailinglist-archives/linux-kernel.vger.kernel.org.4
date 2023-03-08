Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A50276B0BD9
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Mar 2023 15:51:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231411AbjCHOvY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Mar 2023 09:51:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231250AbjCHOu5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Mar 2023 09:50:57 -0500
Received: from smtp-190e.mail.infomaniak.ch (smtp-190e.mail.infomaniak.ch [185.125.25.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 264412CFF9
        for <linux-kernel@vger.kernel.org>; Wed,  8 Mar 2023 06:50:07 -0800 (PST)
Received: from smtp-3-0000.mail.infomaniak.ch (unknown [10.4.36.107])
        by smtp-3-3000.mail.infomaniak.ch (Postfix) with ESMTPS id 4PWwG55Yx3zMq40q;
        Wed,  8 Mar 2023 15:50:05 +0100 (CET)
Received: from unknown by smtp-3-0000.mail.infomaniak.ch (Postfix) with ESMTPA id 4PWwG520w1z27K4;
        Wed,  8 Mar 2023 15:50:05 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=pschenker.ch;
        s=20220412; t=1678287005;
        bh=YhDejNIAOWA2ocTNivyb1veTdzyn6P8nvP8lg5eW2YY=;
        h=Subject:From:Reply-To:To:Cc:Date:In-Reply-To:References:From;
        b=hdNHd40PY4zOReDL1q7gbVE7q3MzfsWeo6BGF32ub7HnboqIoF/oFd8NIoZo4igGE
         IowvS3Ee3E9Upt1x8k9hZDtfriCOOVBeYrtcP7oQJKzpVXlJQa4dbN49Ov8HQRSc40
         G9jEMYvl0jfhQPGpHBe06lFyXF8sapQSdfZxw6AY=
Message-ID: <93b5c8bb6ec2010792c117bc7ffad9692fdf063c.camel@pschenker.ch>
Subject: Re: [PATCH v1 03/25] arm64: dts: colibri-imx8x: Sort properties
From:   Philippe Schenker <dev@pschenker.ch>
Reply-To: dev@pschenker.ch
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        devicetree@vger.kernel.org, Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>
Cc:     NXP Linux Team <linux-imx@nxp.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Frank Rowand <frowand.list@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        Fabio Estevam <festevam@gmail.com>,
        linux-kernel@vger.kernel.org
Date:   Wed, 08 Mar 2023 15:50:05 +0100
In-Reply-To: <48d0217d-283f-354b-fcb5-12801895376a@linaro.org>
References: <20230308125300.58244-1-dev@pschenker.ch>
         <20230308125300.58244-4-dev@pschenker.ch>
         <9d213504-d457-21a6-d467-41d8783d53d3@linaro.org>
         <309ec2042a73b943485671f926ec0f25c5d8f80a.camel@pschenker.ch>
         <48d0217d-283f-354b-fcb5-12801895376a@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
User-Agent: Evolution 3.46.4 
MIME-Version: 1.0
X-Infomaniak-Routing: alpha
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 2023-03-08 at 15:32 +0100, Krzysztof Kozlowski wrote:
> On 08/03/2023 14:29, Philippe Schenker wrote:
> > On Wed, 2023-03-08 at 13:57 +0100, Krzysztof Kozlowski wrote:
> > > Is this approved coding style for IMX DTS?
> >=20
> > How the ordering should be done is nowhere specifically documented
> > (at
> > least this is my current understanding).
> > The ordering how I noted it is what we gathered from multiple
> > feedback
> > on mailinglist discussions.
> >=20
> > With that ordering I hope everyone is happy.
> >=20
> > Philippe
>=20
> Yeah, but what if next developer next month re-orders all your nodes
> again because he will use different coding style?

Someone from Toradex will complain that we want to have it the way I
sent now, since this is the way we agreed on internally.

>=20
> Best regards,
> Krzysztof
>=20

