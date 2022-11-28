Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8BF463AA4C
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Nov 2022 15:01:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232235AbiK1OBN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Nov 2022 09:01:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57398 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232159AbiK1OBE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Nov 2022 09:01:04 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 661AE63E7
        for <linux-kernel@vger.kernel.org>; Mon, 28 Nov 2022 06:01:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=/RsElrJ4fTpZwQGc5X/fuTrHyuS75pyOL1EdjY8Plxg=; b=xY
        R6f5DBIUtCPgDzvdOMVTFzCvO0KVS6tiBc4qDT6PwCyrku33r2WcWfkTQEggH0ZX9v3eH0/8REaSp
        leaw7ev/I/etiU1oFPJGr6nl0ydANI7EKEN//tmCTSWidBJTf4iqh3MXZWcXyjSikAKq9S9tDHAHi
        fh8OnGlFTox4hyA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1ozegs-003evG-3k; Mon, 28 Nov 2022 15:00:58 +0100
Date:   Mon, 28 Nov 2022 15:00:58 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Chunfeng Yun =?utf-8?B?KOS6keaYpeWzsCk=?= 
        <Chunfeng.Yun@mediatek.com>
Cc:     "vkoul@kernel.org" <vkoul@kernel.org>,
        "llvm@lists.linux.dev" <llvm@lists.linux.dev>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "nathan@kernel.org" <nathan@kernel.org>,
        "kishon@ti.com" <kishon@ti.com>,
        Eddie Hung =?utf-8?B?KOa0quato+mRqyk=?= 
        <Eddie.Hung@mediatek.com>,
        Tianping Fang =?utf-8?B?KOaWueWkqeW5syk=?= 
        <Tianping.Fang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "linux-phy@lists.infradead.org" <linux-phy@lists.infradead.org>,
        "trix@redhat.com" <trix@redhat.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "ndesaulniers@google.com" <ndesaulniers@google.com>
Subject: Re: [PATCH v4 3/3] phy: mediatek: tphy: add debugfs files
Message-ID: <Y4S/GhUcrxJ9W/gE@lunn.ch>
References: <20221110132716.12294-1-chunfeng.yun@mediatek.com>
 <20221110132716.12294-3-chunfeng.yun@mediatek.com>
 <Y3+uGjpMQcEWQrew@matsya>
 <70407a789b48a4fbd498e392450eb9db76e025bf.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <70407a789b48a4fbd498e392450eb9db76e025bf.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Nov 28, 2022 at 07:26:02AM +0000, Chunfeng Yun (云春峰) wrote:
> On Thu, 2022-11-24 at 23:17 +0530, Vinod Koul wrote:
> > On 10-11-22, 21:27, Chunfeng Yun wrote:
> > > These debugfs files are mainly used to make eye diagram test
> > > easier,
> > > especially helpful to do HQA test for a new IC without efuse
> > > enabled.

Exporting data for eye diagrams seems like something many PHYs could
use. Please consider adding an official uniform API which any PHY
could use, so we don't end up with lots of incompatible formats in
debugfs.

	Andrew
