Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65EDF611EDB
	for <lists+linux-kernel@lfdr.de>; Sat, 29 Oct 2022 03:03:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229742AbiJ2BDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 21:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229515AbiJ2BD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 21:03:27 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 278061DCCF2;
        Fri, 28 Oct 2022 18:03:27 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 28E5062B38;
        Sat, 29 Oct 2022 01:03:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33A09C433D6;
        Sat, 29 Oct 2022 01:03:22 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1667005405;
        bh=alkGX2kyMn2e1xQop2hHrKF5BS2Bg+ruRBxBphpEM3g=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=aK3KC/RURHHxyAhavFYAE36pcbzlXimcAWyY4rre8Z6XMX4wmU1/wMwc7D46zlbVO
         jIQcSl+egAonImwVvdPk1/MAulpHE/rJJoF4yJDRkluej6FTk42qnPKUp74Xffsjka
         LRuxbn1KESEUKWX77BQEm0khRAeeiknOnng6P9zmQ8O9Xp/q8Pd3cQO237JZpoBf5e
         +mN1fae0YI03Sw1nKbZvsWOlK/qjp/FBj/ow/0HLtBNv7GtfON6DdIIGqcyL7j74Yd
         Szyw07MhiA4MTpWr4CP890b181T10cZGsn7LwBJq+Z6J4mlXInsXukthbINaV1r7Es
         +rM4ndS2liPcw==
Date:   Sat, 29 Oct 2022 09:03:18 +0800
From:   Shawn Guo <shawnguo@kernel.org>
To:     Philippe Schenker <dev@pschenker.ch>
Cc:     devicetree@vger.kernel.org,
        Philippe Schenker <philippe.schenker@toradex.com>,
        Fabio Estevam <festevam@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Rob Herring <robh+dt@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/4] arm: dts: colibri-imx6ull: keep peripherals disabled
Message-ID: <20221029010318.GE125525@dragon>
References: <20221005133929.1243443-1-dev@pschenker.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20221005133929.1243443-1-dev@pschenker.ch>
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Oct 05, 2022 at 03:39:26PM +0200, Philippe Schenker wrote:
> From: Philippe Schenker <philippe.schenker@toradex.com>
> 
> Toradex does provide device-tree overlays to enable certain evaluation
> hardware. Keep the buses disabled by default to be enabled again with
> overlays.
> 
> For customers including this device-tree this has also the advantage
> that the hardware we want by default running does not automatically
> enable signals on their end.
> 
> Signed-off-by: Philippe Schenker <philippe.schenker@toradex.com>

We idiomatically prefix i.MX arm DTS like 'ARM: dts: ...'  Please be
noted for the future patches.

Fixed prefix and applied the series.

Shawn
