Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550F47209FF
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Jun 2023 21:43:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236083AbjFBTnm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Jun 2023 15:43:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235353AbjFBTnk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Jun 2023 15:43:40 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E21B19B;
        Fri,  2 Jun 2023 12:43:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=p2kx53FIkLSzM3l59PYme95Et3nogdbgkEjsVJ+GbYY=; b=mBN8lN82hw72k5hWdJGwf9dN7a
        nCTt8kw/sUpcFmsarHCKX/+XUQGB/bn/IGgc1kGZFdICq0TO6B6+hiQMPJottKXIxFa92Y0w+1inY
        pBzrIjkMP8jPOtmhlHlrz0t4WX8xHBYL3ZExa3hsvhgHp4iciYV8qeHDjfKcycH//mvA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q5AgG-00EhxJ-4o; Fri, 02 Jun 2023 21:43:24 +0200
Date:   Fri, 2 Jun 2023 21:43:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Detlev Casanova <detlev.casanova@collabora.com>
Cc:     linux-kernel@vger.kernel.org,
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
Subject: Re: [PATCH v2 2/3] dt-bindings: net: phy: Document support for
 external PHY clk
Message-ID: <b188ba63-5e9e-403b-9caa-a52085279e3d@lunn.ch>
References: <20230602182659.307876-1-detlev.casanova@collabora.com>
 <20230602182659.307876-3-detlev.casanova@collabora.com>
 <4255bc0a-491c-4fbb-88ea-ec1d864a1a24@lunn.ch>
 <2288019.ElGaqSPkdT@arisu>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <2288019.ElGaqSPkdT@arisu>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> What about "Ethernet PHYs can have an external clock that needs to be 
> activated before communicating with the PHY" ?

That good.

Thanks
	Andrew
