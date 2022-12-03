Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 550EC64178F
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Dec 2022 16:39:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229795AbiLCPjJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Dec 2022 10:39:09 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229631AbiLCPjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Dec 2022 10:39:06 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E589F21E01
        for <linux-kernel@vger.kernel.org>; Sat,  3 Dec 2022 07:39:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=ejL1rXUuDNdJH+iLvnYHG3SjKkQ42huDov+rDB0RZoM=; b=bp
        Qq1n4vy6Z2Qb97g+S32Gw7EeAY857gCRhsLrf9XK6QoQQJF+2FTXncf1XS9ao8m/cSyjtkTt1R92y
        n8k+ovD8ulWh680JhXlsyVBy0WTbOOj9E7LSPnxhUTax8HhXrZ3Jr61fggIEM6e0aOy538dgNRJXf
        PRhQI5xirBV3VAc=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1p1UbE-004H6v-Cl; Sat, 03 Dec 2022 16:38:44 +0100
Date:   Sat, 3 Dec 2022 16:38:44 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chunfeng Yun =?utf-8?B?KOS6keaYpeWzsCk=?= 
        <Chunfeng.Yun@mediatek.com>
Cc:     "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        Eddie Hung =?utf-8?B?KOa0quato+mRqyk=?= 
        <Eddie.Hung@mediatek.com>,
        Tianping Fang =?utf-8?B?KOaWueWkqeW5syk=?= 
        <Tianping.Fang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "vkoul@kernel.org" <vkoul@kernel.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "trix@redhat.com" <trix@redhat.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v4 3/3] phy: mediatek: tphy: add debugfs files
Message-ID: <Y4tthBgulCK3ggBT@lunn.ch>
References: <20221110132716.12294-1-chunfeng.yun@mediatek.com>
 <20221110132716.12294-3-chunfeng.yun@mediatek.com>
 <Y3+uGjpMQcEWQrew@matsya>
 <70407a789b48a4fbd498e392450eb9db76e025bf.camel@mediatek.com>
 <Y4S/GhUcrxJ9W/gE@lunn.ch>
 <5c0cc00a37c4cfa03d91e834fb649d52d4ddb041.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <5c0cc00a37c4cfa03d91e834fb649d52d4ddb041.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 03, 2022 at 02:53:19PM +0000, Chunfeng Yun (云春峰) wrote:
> On Mon, 2022-11-28 at 15:00 +0100, Andrew Lunn wrote:
> > On Mon, Nov 28, 2022 at 07:26:02AM +0000, Chunfeng Yun (云春峰) wrote:
> > > On Thu, 2022-11-24 at 23:17 +0530, Vinod Koul wrote:
> > > > On 10-11-22, 21:27, Chunfeng Yun wrote:
> > > > > These debugfs files are mainly used to make eye diagram test
> > > > > easier,
> > > > > especially helpful to do HQA test for a new IC without efuse
> > > > > enabled.
> > 
> > Exporting data for eye diagrams seems like something many PHYs could
> > use. Please consider adding an official uniform API which any PHY
> > could use, so we don't end up with lots of incompatible formats in
> > debugfs.
> Good idea, but it seems difficult to do it due to the settings of phy
> controllers are not common.

Do you have clear documentation about the values are exporting? Do you
have a documented procedure for the tests?

We need to collect together documentation from multiple vendors and
see what is common. Maybe nothing is common, maybe a lot is in common.
We won't know until we actually compare them.

I implemented cable testing for Ethernet PHYs. They are all different,
but actual give very similar results, so can have one common
description. How many different ways is there to make eye diagram
tests?

	Andrew
