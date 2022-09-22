Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2E9E5E6D57
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Sep 2022 22:46:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230206AbiIVUqC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Sep 2022 16:46:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229578AbiIVUp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Sep 2022 16:45:58 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BCD96E723E;
        Thu, 22 Sep 2022 13:45:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=pjIeMy2ILl2IWXFA8vjy05mC3EmrrbOwyJhcZCpzvEQ=; b=tDYG18EYwsMor5FjCOnjavk4SC
        mP/R4LzyIEC3gGQro5/xCr0Ym3fqORqRZ38ZkHeXWHMFzM6fcrwAoVuuiT8qheKiREdjnqGumQ6HC
        JpdKGuyoGocDlIYi67Zll3HVzq+pPR6RoZIe7HbYscKvMyJlB3w1K4pf/IpSinOln398=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1obT4t-00HZRn-UJ; Thu, 22 Sep 2022 22:45:47 +0200
Date:   Thu, 22 Sep 2022 22:45:47 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Mauri Sandberg <maukka@ext.kapsi.fi>
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, linux@armlinux.org.uk,
        pali@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 2/3] ARM: dts: orion5x: Add D-Link DNS-323 Device Tree
Message-ID: <YyzJe9+S83vByosb@lunn.ch>
References: <20220427162123.110458-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-3-maukka@ext.kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220922202458.7592-3-maukka@ext.kapsi.fi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	chosen {
> +		stdout-path = "serial0:115200n8";
> +		bootargs = "console=ttyS0,115200n8 earlyprintk";

bootargs is generally not liked. Since you have stdout-path do you
need console=ttyS0,115200n8? earlyprintk should not be needed now you
have something which boots.

> +&mdio {
> +	status = "okay";
> +
> +	ethphy: ethernet-phy {
> +		reg = <8>;

Since you have a reg value, this should be ethernet-phy@9

      Andrew
