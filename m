Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36ACC661066
	for <lists+linux-kernel@lfdr.de>; Sat,  7 Jan 2023 18:18:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232571AbjAGRSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 Jan 2023 12:18:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229621AbjAGRSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 Jan 2023 12:18:46 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D62E83AB2F;
        Sat,  7 Jan 2023 09:18:44 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=JdxsbNSrSwSy6r+8t69QHf+dw2XaCMXonA6jCySKyU0=; b=umuPSglU6p+WBgA+qTHfkZPbw5
        fiXwn1IxfI+BUoh2qz6Nk+JwB/oagweCFVI+BD5YCNlgcGXGk72DVGCedbxk7AlKz7iIcPeUwt8Ll
        +VDNON/OxynN5rnpIrhMPFGu7Qu+YQdYZ5REU07c1TfbJkSO3Ys8F4e8JEOGUfa+Xc7s=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pECq4-001R2o-GC; Sat, 07 Jan 2023 18:18:36 +0100
Date:   Sat, 7 Jan 2023 18:18:36 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Klaus Kudielka <klaus.kudielka@gmail.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Pali =?iso-8859-1?Q?Roh=E1r?= <pali@kernel.org>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thomas Petazzoni <thomas.petazzoni@free-electrons.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] Revert "ARM: dts: armada-39x: Fix compatible
 string for gpios"
Message-ID: <Y7mpbOUmRYWw+8Wj@lunn.ch>
References: <20230107144149.5743-1-klaus.kudielka@gmail.com>
 <20230107144149.5743-2-klaus.kudielka@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230107144149.5743-2-klaus.kudielka@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jan 07, 2023 at 03:41:49PM +0100, Klaus Kudielka wrote:
> This reverts commit d10886a4e6f85ee18d47a1066a52168461370ded.
> 
> If compatible = "marvell,armadaxp-gpio", the reg property requires a
> second (address, size) pair, which points to the per-CPU interrupt
> registers <0x18800 0x30> / <0x18840 0x30>.
> 
> Furthermore:
> Commit 5f79c651e81e explains very well, why the gpio-mvebu driver does not
> work reliably with per-CPU interrupts.
> Commit 988c8c0cd04d deprecates compatible = marvell,armadaxp-gpio for this
> reason.
> 
> Signed-off-by: Klaus Kudielka <klaus.kudielka@gmail.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
