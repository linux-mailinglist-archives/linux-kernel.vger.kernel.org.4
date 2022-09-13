Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43B375B6C94
	for <lists+linux-kernel@lfdr.de>; Tue, 13 Sep 2022 13:51:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231745AbiIMLvh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 13 Sep 2022 07:51:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231191AbiIMLvf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 13 Sep 2022 07:51:35 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C55C5AA18
        for <linux-kernel@vger.kernel.org>; Tue, 13 Sep 2022 04:51:34 -0700 (PDT)
Received: from ptx.hi.pengutronix.de ([2001:67c:670:100:1d::c0])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oY4Rn-00075X-J4; Tue, 13 Sep 2022 13:51:23 +0200
Received: from mfe by ptx.hi.pengutronix.de with local (Exim 4.92)
        (envelope-from <mfe@pengutronix.de>)
        id 1oY4Rn-00068G-3k; Tue, 13 Sep 2022 13:51:23 +0200
Date:   Tue, 13 Sep 2022 13:51:23 +0200
From:   Marco Felsch <m.felsch@pengutronix.de>
To:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
Cc:     krzysztof.kozlowski+dt@linaro.org, robh+dt@kernel.org,
        abelvesa@kernel.org, abel.vesa@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, shawnguo@kernel.org, s.hauer@pengutronix.de,
        kernel@pengutronix.de, festevam@gmail.com,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>,
        linux-imx@nxp.com, linux-arm-kernel@lists.infradead.org,
        linux-clk@vger.kernel.org
Subject: Re: [RFC PATCH 0/2] Propose critical clocks
Message-ID: <20220913115123.el3qnnh4l6gfa5jy@pengutronix.de>
References: <20220913102141.971148-1-m.felsch@pengutronix.de>
 <893c8446-5c4b-0e16-6979-632a20c8a201@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <893c8446-5c4b-0e16-6979-632a20c8a201@linaro.org>
User-Agent: NeoMutt/20180716
X-SA-Exim-Connect-IP: 2001:67c:670:100:1d::c0
X-SA-Exim-Mail-From: mfe@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22-09-13, Krzysztof Kozlowski wrote:
> On 13/09/2022 12:21, Marco Felsch wrote:
> > Hi,
> > 
> > this proposal is to mark clocks as critical. It is somehow inspired by
> > the regulator-always-on property. Since sometimes we can end in circular
> > dependcies if we wanna solve the dependcies for a specific clock
> > provider.
> > 
> > The property is generic so it can be used by every hw clock provider. So
> > it can be seen as generic implementation to [1].
> 
> Missing devicetree list (so no testing), missing bindings. Please follow
> Linux process, run checkpatch and CC necessary people an dlists pointed
> out by get_maintainers.pl.

I just pushd the _proposal_ as reaction of adding a NXP specific
binding. If the clk maintainer(s) would agree to this this proposal I
would update the patchset with bindings and _all_ mail-addresses.

Regards,
  Marco
