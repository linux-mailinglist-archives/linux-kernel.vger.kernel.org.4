Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9A2CB659A44
	for <lists+linux-kernel@lfdr.de>; Fri, 30 Dec 2022 17:00:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235342AbiL3QAO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 30 Dec 2022 11:00:14 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34002 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235316AbiL3QAM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 30 Dec 2022 11:00:12 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B1F31B9F9;
        Fri, 30 Dec 2022 08:00:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=TYJQQyWiHCgaeEo0TARUgqve7BqMF8sKjCBmTA8xSzQ=; b=WN
        LEH4kjKIcumTeN/K1lwKEHndKRlon+WKhe0XR0tvuoivXz4vQzc6EqIQSfrbruRWtZAvl0S1GO6g/
        6FNTwWIAUvwemFTKdoX6WHVTt0BumpcQYdWS76ZuAWUY+WhF9OnxpMsiFzO6+0d5mBLDR3TLnBAn8
        gkGR90Lh9pXaHRI=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pBHnd-000lbk-Dv; Fri, 30 Dec 2022 17:00:01 +0100
Date:   Fri, 30 Dec 2022 17:00:01 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     =?utf-8?Q?Micha=C5=82?= Grzelak <mig@semihalf.com>
Cc:     linux-kernel@vger.kernel.org, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        mw@semihalf.com, upstream@semihalf.com, mchl.grzlk@gmail.com
Subject: Re: [PATCH v3] ARM: dts: dove.dtsi: Move ethphy to fix schema error
Message-ID: <Y68LASVPztAWYVfX@lunn.ch>
References: <20221229180155.99303-1-mig@semihalf.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20221229180155.99303-1-mig@semihalf.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 29, 2022 at 07:01:55PM +0100, Michał Grzelak wrote:
> Running 'make dtbs_check' with schema in net/marvell,orion-mdio.yaml
> gives following warnings:
> mdio-bus@72004: Unevaluated properties are not allowed
> ('ethernet-phy' was unexpected)
> 	arch/arm/boot/dts/dove-cubox.dtb
> 	arch/arm/boot/dts/dove-cubox-es.dtb
> 	arch/arm/boot/dts/dove-d2plug.dtb
> 	arch/arm/boot/dts/dove-d2plug.dtb
> 	arch/arm/boot/dts/dove-dove-db.dtb
> 	arch/arm/boot/dts/dove-d3plug.dtb
> 	arch/arm/boot/dts/dove-sbc-a510.dtb
> As every subnode of mdio is expected to have an @X, ethernet-phy subnode
> in dove.dtsi doesn't have one. Fix these errors by moving ethernet-phy
> into relevant .dts files with correct @<reg address>.
> 
> Signed-off-by: Michał Grzelak <mig@semihalf.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
