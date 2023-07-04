Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C1FDF747A64
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jul 2023 01:31:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231147AbjGDXbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jul 2023 19:31:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50088 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229610AbjGDXbo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jul 2023 19:31:44 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB8E7E7A;
        Tue,  4 Jul 2023 16:31:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=7mMsYxvkkKYYvUhJdwRPYmSFrf/Dw472bTS58sB/4h4=; b=w5Jtul0V75qS34BbaqPtsToprG
        Eu01UCKEokVrIRr648OMpUrygMHSxNo0zClZIoiKoafIrC/+rWDp0OKikTghCvBGMI+PiJgrvFXA+
        2Jfpd9aaexsYwJ6WCZ7N9NtxRLc2fBeHWA2gAdX9g/N40bGjQL9FCIAytbIStU9XA2tY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qGpUi-000akM-C8; Wed, 05 Jul 2023 01:31:40 +0200
Date:   Wed, 5 Jul 2023 01:31:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "Haener, Michael" <michael.haener@siemens.com>
Cc:     "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "olteanv@gmail.com" <olteanv@gmail.com>,
        "davem@davemloft.net" <davem@davemloft.net>,
        "linux@armlinux.org.uk" <linux@armlinux.org.uk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "pabeni@redhat.com" <pabeni@redhat.com>,
        "kuba@kernel.org" <kuba@kernel.org>,
        "edumazet@google.com" <edumazet@google.com>,
        "f.fainelli@gmail.com" <f.fainelli@gmail.com>,
        "Sverdlin, Alexander" <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH v2 0/3] net: dsa: SERDES support for mv88e632x family
Message-ID: <67189741-efd5-4f54-8438-66a6e2a693f5@lunn.ch>
References: <20230704065916.132486-1-michael.haener@siemens.com>
 <20a135919ac7d54699d1eca5486fd640d667ad05.camel@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20a135919ac7d54699d1eca5486fd640d667ad05.camel@siemens.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 04, 2023 at 07:17:55AM +0000, Haener, Michael wrote:
> On Tue, 2023-07-04 at 08:59 +0200, M. Haener wrote:
> > From: Michael Haener <michael.haener@siemens.com>
> > 
> > This patch series brings SERDES support for the mv88e632x family.
> 
> Changelog:
> v2: rebased onto Russell Kings series dsa/88e6xxx/phylink

Russell King will be interested in a Tested-by: for his patchset.
That will also help get that patchset merged so yours can then
follow. So please keep an eye on the netdev list, and repost your
patches once Russells have been merged.

	Andrew
