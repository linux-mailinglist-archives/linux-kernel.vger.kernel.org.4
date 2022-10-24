Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 58A1260AD74
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Oct 2022 16:25:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236935AbiJXOXv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Oct 2022 10:23:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235773AbiJXOWD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Oct 2022 10:22:03 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09DBAD03B8
        for <linux-kernel@vger.kernel.org>; Mon, 24 Oct 2022 05:58:23 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1omx0I-0008QJ-LT; Mon, 24 Oct 2022 14:56:30 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1omx0I-0004tc-4L; Mon, 24 Oct 2022 14:56:30 +0200
Date:   Mon, 24 Oct 2022 14:56:30 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Heiko Thiery <heiko.thiery@gmail.com>
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Subject: Re: [PATCH v3] arm64: dts: imx8mq-kontron-pitx-imx8m: remove
 off-on-delay-us for regulator-usdhc2-vmmc
Message-ID: <20221024125630.frrbq4hy2bfxhjtq@pengutronix.de>
References: <20221024115429.1343257-1-heiko.thiery@gmail.com>
 <20221024122659.2krt2hh2sdvxuurn@pengutronix.de>
 <CAEyMn7Y9uxeFLM7-6jR=bonusdwjX=ukRotZm=7x_3QyxVW-DQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAEyMn7Y9uxeFLM7-6jR=bonusdwjX=ukRotZm=7x_3QyxVW-DQ@mail.gmail.com>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-10-24, Heiko Thiery wrote:
> Hi Marco,
> 
> Am Mo., 24. Okt. 2022 um 14:34 Uhr schrieb Marco Felsch
> <m.felsch@pengutronix.de>:
> >
> > Hi Heiko,
> >
> > On 22-10-24, Heiko Thiery wrote:
> > > With that delay U-Boot is not able to store the environment variables in
> > > the SD card. Since the delay is not required it can be remove.
> >
> > Now I'm curious, since this doesn't tell us the why, it just tell us
> > about the end result. I'm asking because the NXP EVKs have an issue with
> > the sd-card power line capacity and we need this delay to reach a level
> > which is marked as low within the sd-spec.
> 
> I must admit that I do not know at all why this entry was made. I have
> now looked at the dtbs of the imx8 EVKs and except for imx8dxl-evk.dts
> I see no delay here.

Please see <20221024031351.4135651-10-peng.fan@oss.nxp.com>, they will
be added.

Regards,
  Marco
