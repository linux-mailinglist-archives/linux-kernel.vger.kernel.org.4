Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 28EC2656CD0
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Dec 2022 17:20:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230281AbiL0QUe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Dec 2022 11:20:34 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229588AbiL0QUb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Dec 2022 11:20:31 -0500
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B3AF1A6;
        Tue, 27 Dec 2022 08:20:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=qmv9qJfBtcw5jcK3wWiJ1+zfAYgavU3BfZcZHM2JKLM=; b=P1rEhehbRarbBagJWTp7m71NhN
        Fq5DHFjdxctaBx1bZ7UrnFoPAzDRGpZ3qABcrc3Ts4FnY5KDPG8GM0QAIPpMyvEZoKRiX6xCE9hYo
        iIuc5CcYHBr1GA3PkDLAtFTNMvKnJ6vPS/mnS3KNj2qRcQn9xqFR0BMWo/mRLarCy6IU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pACge-000a1a-RI; Tue, 27 Dec 2022 17:20:20 +0100
Date:   Tue, 27 Dec 2022 17:20:20 +0100
From:   Andrew Lunn <andrew@lunn.ch>
To:     Biao Huang =?utf-8?B?KOm7hOW9qik=?= <Biao.Huang@mediatek.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "peppe.cavallaro@st.com" <peppe.cavallaro@st.com>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "joabreu@synopsys.com" <joabreu@synopsys.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "alexandre.torgue@foss.st.com" <alexandre.torgue@foss.st.com>,
        "mcoquelin.stm32@gmail.com" <mcoquelin.stm32@gmail.com>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "richardcochran@gmail.com" <richardcochran@gmail.com>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        Macpaul Lin =?utf-8?B?KOael+aZuuaWjCk=?= 
        <Macpaul.Lin@mediatek.com>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>
Subject: Re: [PATCH v5 1/2] stmmac: dwmac-mediatek: enable 2ns delay only for
 special cases
Message-ID: <Y6sbRPbDDzeGbkM+@lunn.ch>
References: <20221223015029.24978-1-biao.huang@mediatek.com>
 <20221223015029.24978-2-biao.huang@mediatek.com>
 <Y6W4vwJHG+6PI8fd@lunn.ch>
 <4a82aa5437e496e2b65b77ef08d7897a4b23f7e5.camel@mediatek.com>
 <Y6m7eNdWVL3IKFj2@lunn.ch>
 <5baa7c88716042421b0dd1d579c6aa70d253a546.camel@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <5baa7c88716042421b0dd1d579c6aa70d253a546.camel@mediatek.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> OK, as to this series, Is the following modification enough?
>     1. phy-mode = rgmii-id;  in dts.
>     2. remove the fix_mac_speed() in driver.

Yep, that is good.

     Andrew
