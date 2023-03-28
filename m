Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B85966CC2DD
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Mar 2023 16:49:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbjC1OtT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Mar 2023 10:49:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233372AbjC1OtA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Mar 2023 10:49:00 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 546D47D9F;
        Tue, 28 Mar 2023 07:48:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=4d4yX3P+sK7pVHI2KIF+zVXOLbrpp9LpccGL3UDr6pw=; b=43eM5VH37+sjsRL3AMf9wGo3No
        ZsKnYGfKm88TsN9TKwEiyvKcEJwLcrHBbd9uYdkgE/gi452Mcji+RdmneuPQ+rPncbuAtHr66M9Qd
        zCPk+paZmXS8UrzyB0nUquawu+EvwnyRkdjdWyh4QYzY3H1QsePLp+96gXnYTwhmGSzg=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1phAcE-008elT-8a; Tue, 28 Mar 2023 16:48:02 +0200
Date:   Tue, 28 Mar 2023 16:48:02 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>
Cc:     linus.walleij@linaro.org, brgl@bgdev.pl, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, shawnguo@kernel.org,
        s.hauer@pengutronix.de, kernel@pengutronix.de, festevam@gmail.com,
        linux-imx@nxp.com, stefan@agner.ch, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Peng Fan <peng.fan@nxp.com>
Subject: Re: [PATCH 2/2] dt-bindings: gpio: vf610: update gpio-ranges
Message-ID: <de82d0ff-3e2f-4822-8430-13e2b1633b3a@lunn.ch>
References: <20230328052912.1957000-1-peng.fan@oss.nxp.com>
 <20230328052912.1957000-2-peng.fan@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230328052912.1957000-2-peng.fan@oss.nxp.com>
X-Spam-Status: No, score=-0.2 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 28, 2023 at 01:29:12PM +0800, Peng Fan (OSS) wrote:
> From: Peng Fan <peng.fan@nxp.com>
> 
> 1 is not enough for i.MX9, enlarge it.
> 
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  Documentation/devicetree/bindings/gpio/gpio-vf610.yaml | 3 ++-

I'm not that knowledgeable about i.MX9, but i thought vf610 was
Vybrid, which is not an i.MX9. Does i.MX9 reuse the Vybrid GPIO
controller? Is this change also valid for the Vybrid?

	Andrew
