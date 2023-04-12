Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F72C6DF51C
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Apr 2023 14:25:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229648AbjDLMZI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Apr 2023 08:25:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229948AbjDLMZG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Apr 2023 08:25:06 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7DE1AE6B;
        Wed, 12 Apr 2023 05:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=FpWgKUoiz0J1sZzx8HhIfaR+XN7FLVmHacJvZAr33Jo=; b=N5R6rI5YrQZVpNCySf3ccF+sYI
        JxuS4/J4ZSEW/8avo6msR+jW90J8qYZueL0LUDRVE0zn+499ARxTzTVZukGvUFDNqPyBvFTCPrwcG
        KXs222nLaxtAVuPEXFwYDOfHQeZV8vdGubPRqygDUdapCJFrTgitYvcL/pjMCBbdiEPg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pmZWf-00A5Mu-Vn; Wed, 12 Apr 2023 14:24:37 +0200
Date:   Wed, 12 Apr 2023 14:24:37 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Tony Dinh <mibodhi@gmail.com>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Arnd Bergmann <arnd@arndb.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Olof Johansson <olof@lixom.net>,
        Rob Herring <robh+dt@kernel.org>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        linux-kernel@vger.kernel.org, soc@kernel.org
Subject: Re: [PATCH v2 2/2] ARM: dts: mvebu: add Thecus N2350 board DTS
Message-ID: <eddb141e-6a8a-4473-b5e4-2e043d6f5197@lunn.ch>
References: <20230412025737.20280-1-mibodhi@gmail.com>
 <20230412025737.20280-3-mibodhi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230412025737.20280-3-mibodhi@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +
> +/ {
> +	model = "Thecus N2350";
> +	compatible = "marvell,armada385";

If you look at all the other armarda-385 .dts files, they all have a
board compatible. It might not be needed now, but it could be useful
in the future and allow backwards compatibility.

> +&mdio {
> +	phy0: ethernet-phy@0 {
> +		reg = <1>;
> +	};
> +};

Since you have ref = <1>, this should be ethernet-phy@1.

