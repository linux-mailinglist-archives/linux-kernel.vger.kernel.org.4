Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8DA475BD828
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Sep 2022 01:20:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230171AbiISXUO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 19 Sep 2022 19:20:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229658AbiISXUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 19 Sep 2022 19:20:01 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60F122FFD6;
        Mon, 19 Sep 2022 16:19:49 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7160361F5B;
        Mon, 19 Sep 2022 23:19:48 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A552EC433D6;
        Mon, 19 Sep 2022 23:19:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1663629587;
        bh=CtUBuu/Umy2olZpL4pXDlTOg0LYoEUfDZxH5fn/WxDc=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=P/vL51iDKs3OZhRJ6BmLOq6I90vgV+JTPtV1YO/5kehBej5jad8rR68d7NlNe4Hwl
         kNAJymRjvM9Miw4xShk/6MIjzyLHIqaWIgpouRIlNDjvzbAYraorl0ZhZBkoZIqheO
         wpzV03GnWqF4ZOu0DRXsIjKOu5+YiKZmdipgB5xE9P6ZP0ievWzWUpgw3qJXW+QtSu
         gAFeHvNwMPYFkwms7Rli6eJrpBT+U4WfRHmeW2ojix8epM7g8ZwGeb/UCgvKLhm/pM
         CDC216TygjszKnBWE619zkj3f2MATa4pERigRHq72Z/0VHm4GHiwy5eKIUYH6i//1x
         t+CvjnyW0+mFQ==
Received: by pali.im (Postfix)
        id 9BB797DA; Tue, 20 Sep 2022 01:19:44 +0200 (CEST)
Date:   Tue, 20 Sep 2022 01:19:44 +0200
From:   Pali =?utf-8?B?Um9ow6Fy?= <pali@kernel.org>
To:     Andrew Lunn <andrew@lunn.ch>
Cc:     Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64: dts: marvell: Fix compatible strings for Armada
 3720 boards
Message-ID: <20220919231944.oge6zctr5uxme6ej@pali>
References: <20220713125644.3117-1-pali@kernel.org>
 <20220808202456.lpwvhq22edb56ptf@pali>
 <YvFzGhBRPTXgdCd8@lunn.ch>
 <20220902223110.ob2uepbjzubdf4d3@pali>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220902223110.ob2uepbjzubdf4d3@pali>
User-Agent: NeoMutt/20180716
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Saturday 03 September 2022 00:31:10 Pali Rohár wrote:
> On Monday 08 August 2022 22:33:30 Andrew Lunn wrote:
> > On Mon, Aug 08, 2022 at 10:24:56PM +0200, Pali Rohár wrote:
> > > PING?
> > 
> > It is too late for the merge window.
> 
> So, now for the next?

PING?

> > > > diff --git a/arch/arm64/boot/dts/marvell/armada-372x.dtsi b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> > > > index 5ce55bdbb995..02ae1e153288 100644
> > > > --- a/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> > > > +++ b/arch/arm64/boot/dts/marvell/armada-372x.dtsi
> > > > @@ -13,7 +13,7 @@
> > > >  
> > > >  / {
> > > >  	model = "Marvell Armada 3720 SoC";
> > > > -	compatible = "marvell,armada3720", "marvell,armada3710";
> > > > +	compatible = "marvell,armada3720", "marvell,armada3700";
> > 
> > Does it make sense to have a compatible here? The board .dts should
> > provide it. And if the board does not provide it, we probably want the
> > board to not boot because it does not have a compatible.
> > 
> >    Andrew
