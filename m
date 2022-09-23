Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4FB75E7A7B
	for <lists+linux-kernel@lfdr.de>; Fri, 23 Sep 2022 14:22:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230508AbiIWMWY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 23 Sep 2022 08:22:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229657AbiIWMVJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 23 Sep 2022 08:21:09 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [185.16.172.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB815138F2C;
        Fri, 23 Sep 2022 05:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=EZzewaMVGiRd02VZeymub7raVNzBpkR8BQcX8OiR+3A=; b=lyTmEI9qBDy2YGViRRMgfYPDgZ
        /9ibpcMqFa0m4m18gbxLdUzSb7QzqolL/CcczGdW9A0tA5KK96Y7lXfencBga4RXhTpa1wV/asiIA
        y3k0ARYfQzy0f37nHv6UtG4ObuOVp9LfobiObYmOMc3Sr972jk40n0eDdHSG+FtQMosE=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1obhXc-0001E9-Ik; Fri, 23 Sep 2022 14:12:24 +0200
Date:   Fri, 23 Sep 2022 14:12:24 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     maukka@ext.kapsi.fi
Cc:     robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        arnd@arndb.de, olof@lixom.net, sebastian.hesselbarth@gmail.com,
        gregory.clement@bootlin.com, linux@armlinux.org.uk,
        pali@kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH v2 3/3] ARM: orion5x: Add D-Link DNS-323 based on Device
 Tree
Message-ID: <Yy2iqE8XgXe8qYd9@lunn.ch>
References: <20220427162123.110458-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-1-maukka@ext.kapsi.fi>
 <20220922202458.7592-4-maukka@ext.kapsi.fi>
 <YyzPVMrfcOkvngxl@lunn.ch>
 <6dc27862f8460f875c31ad2de56baa9f@ext.kapsi.fi>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <6dc27862f8460f875c31ad2de56baa9f@ext.kapsi.fi>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> > > +	if (of_machine_is_compatible("dlink,dns323a1")) {
> > > +		writel(0, MPP_DEV_CTRL);		/* DEV_D[31:16] */
> > 
> > I spotted this in dns323-setup.c as well. Do you have any idea what it
> > does?
> > 
> 
> No idea. I have tried to replicate what was in dns323-setup.c as exactly as
> possible.
> I can try to leave it out and see if anything changes.

It is best to keep what we don't understand. It will be there for a
reason.

	Andrew
