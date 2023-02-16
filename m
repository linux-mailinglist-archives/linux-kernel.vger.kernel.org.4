Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1047698B4A
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Feb 2023 04:59:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229609AbjBPD7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 22:59:19 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229460AbjBPD7R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 22:59:17 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E478D1706;
        Wed, 15 Feb 2023 19:59:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=aARG8CxAx6X7UqifXS1hpHGPgPY5FOKTybfy0dj1+g8=; b=bye7ML1ksmWhsoz2j9l9+as460
        y2Rjgf+uTMV1DL+zqmaAj8LyfcvIStf/4VG3pkYBnRSy5OO6J+7qTbk/CzIcOar5E7A0lGrW4ZU2t
        oX5CtqZy/DPuoFII71DECWXle+aPAVTRu0gwZyRK2pJW5pv2F1zSX2rU5b0WlxzyhdJ0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pSVQE-0058oD-Eh; Thu, 16 Feb 2023 04:59:02 +0100
Date:   Thu, 16 Feb 2023 04:59:02 +0100
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
Subject: Re: [PATCH] ARM: dts: mvebu: Add support for Thecus N2350 board
Message-ID: <Y+2qBm0P4ICrcLvg@lunn.ch>
References: <20230216011046.3306-1-mibodhi@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230216011046.3306-1-mibodhi@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +&mdio {
> +	phy0: ethernet-phy@0 {
> +		reg = <1>;

Since this is reg = <1>, it should be ethernet-phy1.

      Andrew
