Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19BC771F1E3
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Jun 2023 20:28:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232584AbjFAS1Q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Jun 2023 14:27:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59866 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232758AbjFAS0r (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Jun 2023 14:26:47 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 88959E63;
        Thu,  1 Jun 2023 11:26:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=4cGZHwIt1iwTUwTIbfKQS2u9UpzO5hpUq+z3kuxb5bs=; b=3Cg2wXfCbTZZ2RUQsM0oHZHr9V
        I6WZtxTpyozbxf8Yet71SywZNJ4v6i8uxoU0uMETzerkCOE+d+gJ38piau+N9WRiEhvz6+4EL8rq/
        VtC4h1LBlM86/Q6cLAFIViua0zuqF4p1IjECKMESTlEXlaA8XwLTTYc64nM6qGCF2gFQ=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q4n04-00Eb54-5l; Thu, 01 Jun 2023 20:26:16 +0200
Date:   Thu, 1 Jun 2023 20:26:16 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Detlev Casanova <detlev.casanova@collabora.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        linux-kernel@vger.kernel.org,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Conor Dooley <conor+dt@kernel.org>,
        Florian Fainelli <f.fainelli@gmail.com>,
        netdev@vger.kernel.org, devicetree@vger.kernel.org
Subject: Re: [PATCH 1/2] dt-bindings: net: phy: Support external PHY xtal
Message-ID: <b6bfb704-a0f3-468c-84cd-73274e4d157d@lunn.ch>
References: <20230531150340.522994-1-detlev.casanova@collabora.com>
 <6646604.lOV4Wx5bFT@arisu>
 <5f5f6412-f466-9a3f-3ec7-aa45ab0049c6@linaro.org>
 <2686795.mvXUDI8C0e@arisu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2686795.mvXUDI8C0e@arisu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> So I can just use devm_clk_get_optional_enabled(dev, NULL) and I'll get the 
> first clock defines in the device tree ?

Yes:

bcm7xxx.c:	clk = devm_clk_get_optional_enabled(&phydev->mdio.dev, NULL);
micrel.c:	clk = devm_clk_get(&phydev->mdio.dev, "rmii-ref");
smsc.c:		refclk = devm_clk_get_optional_enabled(dev, NULL);

	Andrew
