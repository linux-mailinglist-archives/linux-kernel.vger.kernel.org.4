Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B403714BD9
	for <lists+linux-kernel@lfdr.de>; Mon, 29 May 2023 16:17:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229740AbjE2ORL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 May 2023 10:17:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229665AbjE2ORJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 May 2023 10:17:09 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F27E9A7;
        Mon, 29 May 2023 07:17:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=fjtqlZ6BcNvE5K9yG1kfOksu9W5NbF08T4RnRXpTfts=; b=Ld4jCMduL8tzspSupdXafdbXcG
        8/Th5F29HmxYK9jn2ZbRXUR4O2gYMrK0sQfx8aH4x/eii9zleyLR/7Vt51GphD+5aAz5HjZlare5J
        kGyITr+APTJbmEwgXvGO4P58vqlkvXFA7h0JwT/WMYgG4wvGTTwCbEHNPaRYviBoNvUk=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1q3dfu-00EEVj-SL; Mon, 29 May 2023 16:16:42 +0200
Date:   Mon, 29 May 2023 16:16:42 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Vladimir Oltean <olteanv@gmail.com>
Cc:     Lukasz Majewski <lukma@denx.de>,
        Russell King <linux@armlinux.org.uk>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 0/3] dsa: marvell: Add support for mv88e6071 and 6020
 switches
Message-ID: <7c4b900a-2252-4998-a28a-bd6b9b5aa944@lunn.ch>
References: <20230523142912.2086985-1-lukma@denx.de>
 <20230529110222.68887a31@wsk>
 <20230529105132.h673mnjddubl7und@skbuf>
 <20230529130314.0d4c474e@wsk>
 <20230529112334.bkulgoiloe26w37g@skbuf>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230529112334.bkulgoiloe26w37g@skbuf>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 29, 2023 at 02:23:34PM +0300, Vladimir Oltean wrote:
> On Mon, May 29, 2023 at 01:03:14PM +0200, Lukasz Majewski wrote:
> > This I've replied to Andrew in a private mail.
> 
> Aha.

Yes, the appropriate checks have been made, the reuse of the functions
to set the MTU should be correct.

       Andrew
