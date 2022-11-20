Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B04BF631766
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 00:42:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229721AbiKTXmy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Nov 2022 18:42:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229498AbiKTXmw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Nov 2022 18:42:52 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09C2A13E35;
        Sun, 20 Nov 2022 15:42:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=3TiYJwh6WLGjngXJXq9QOuYOjjjU6e7ZQDDyVdCxrBc=; b=TaX2Qp5iJY8V4EU+rHut+AlB7T
        MVzcV4ldtP1TlXSubk9wVTIpULARgYL8V1zRrA+CqWAscYYVwjamNJduUKZUpgzmRuzZSM6vi6SNW
        hFWWV4EaqXSRmdRHEmjawx2/zRymExa8e+d+aHZatov+FCyGL2vdEiPhnDlUXjFZB3/w=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1owtx0-002xBP-NF; Mon, 21 Nov 2022 00:42:14 +0100
Date:   Mon, 21 Nov 2022 00:42:14 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Renze Nicolai <renze@rnplus.nl>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Andre Przywara <andre.przywara@arm.com>,
        Conley Lee <conleylee@foxmail.com>,
        krzysztof.kozlowski@linaro.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        devicetree@vger.kernel.org
Subject: Re: [PATCH 2/2] arm64: allwinner: a64: add device tree for SOPINE on
 Pine64 Clusterboard
Message-ID: <Y3q7VnjHD+pLdl+H@lunn.ch>
References: <3351526.aeNJFYEL58@werkpc>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <3351526.aeNJFYEL58@werkpc>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +&emac {
> +	allwinner,tx-delay-ps = <500>;
> +};

Is this direct MAC to MAC without a PHY in the middle? And RGMII?

500ps seems odd. It is normally 1000ps. And you need to specify a
delay for both Rx and Tx. I could understand

&emac {
	allwinner,tx-delay-ps = <500>;
	allwinner,rx-delay-ps = <500>;
};

then each end adds 1/2 the delay on both Rx and Tx.

     Andrew
