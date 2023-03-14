Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8A396B9B3C
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Mar 2023 17:23:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229868AbjCNQXT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 14 Mar 2023 12:23:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231320AbjCNQXL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Mar 2023 12:23:11 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BB2B0494;
        Tue, 14 Mar 2023 09:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Transfer-Encoding:Content-Disposition:
        Content-Type:MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:From:
        Sender:Reply-To:Subject:Date:Message-ID:To:Cc:MIME-Version:Content-Type:
        Content-Transfer-Encoding:Content-ID:Content-Description:Content-Disposition:
        In-Reply-To:References; bh=99c/H4RS3sl2GEdCD1SE+7ArTysBbPS45jyna0jwNNY=; b=ge
        x6fJ9HKvhAiACb7W9YQQDylzGSI27gBjBPsU2viPagfFqiviWzyrSp7ZIgfjdqcavzBqVaMPnrCff
        26FXqCDw5t+JFlfGNfMgAF9W+In5YrE3CkWR84n40IADpBeJMsScHSHl3WfdAZEpAK+INmMhHXRBm
        4vntcMOsyrf+vH4=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pc7PS-007JAC-GY; Tue, 14 Mar 2023 17:21:58 +0100
Date:   Tue, 14 Mar 2023 17:21:58 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Rob Herring <robh@kernel.org>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: armada-ap810: Fix GICv3 ITS node
 name
Message-ID: <c02f83c4-3796-40ad-8087-d297ba84e5da@lunn.ch>
References: <20230207234735.201812-1-robh@kernel.org>
 <CAL_JsqLitc8rX4aXomgXKSPcW8ejEYe1wB_ecyAg7pgJgR=zyA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <CAL_JsqLitc8rX4aXomgXKSPcW8ejEYe1wB_ecyAg7pgJgR=zyA@mail.gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 14, 2023 at 10:22:40AM -0500, Rob Herring wrote:
> On Tue, Feb 7, 2023 at 5:47 PM Rob Herring <robh@kernel.org> wrote:
> >
> > The GICv3 ITS is an MSI controller, therefore its node name should be
> > 'msi-controller'.
> >
> > Signed-off-by: Rob Herring <robh@kernel.org>
> > ---
> >  arch/arm64/boot/dts/marvell/armada-ap810-ap0.dtsi | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> Ping!
> 
> If not maintained, should I send a patch removing this platform instead?

Gregory usually picks these up around -rc6.

	Andrew
