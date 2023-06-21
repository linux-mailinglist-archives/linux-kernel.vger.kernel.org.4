Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00D3E739021
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 21:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229912AbjFUTd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 15:33:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229468AbjFUTd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 15:33:56 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4AE7D10F0;
        Wed, 21 Jun 2023 12:33:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=MmeNUeDqexXj/zOSt/KHSOvkf9Dhla7cCruNLFlF2GI=; b=lnrxkWszz/nOMdI1pPOwcPBgx6
        Fg5OA7w7olC1xiSSDrRPosCqwbmfBeQ3WQQu5q28LK3BDZQAogKcVdyxruhxUDidWyY6gIbxZDaCf
        6POna36SjGIb+bDhBs0ZoSKJeu4kazBR4yn9fogmggHLmxiOolKS7KdUaWgakaxKlYjo=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qC3aJ-00HBOH-SK; Wed, 21 Jun 2023 21:33:43 +0200
Date:   Wed, 21 Jun 2023 21:33:43 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Pawel Dembicki <paweldembicki@gmail.com>
Cc:     netdev@vger.kernel.org, linus.walleij@linaro.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net-next 2/6] net: dsa: vsc73xx: add port_stp_state_set
 function
Message-ID: <27e0f7c9-71a8-4882-ab65-6c42d969ea4f@lunn.ch>
References: <20230621191302.1405623-1-paweldembicki@gmail.com>
 <20230621191302.1405623-2-paweldembicki@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230621191302.1405623-2-paweldembicki@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> +	struct vsc73xx *vsc = ds->priv;
> +	/* FIXME: STP frames isn't forwarded at this moment. BPDU frames are
> +	 * forwarded only from to PI/SI interface. For more info see chapter
> +	 * 2.7.1 (CPU Forwarding) in datasheet.

Do you mean the CPU never gets to see the BPDU frames?

Does the hardware have any sort of packet matching to trap frames to
the CPU? Can you match on the destination MAC address
01:80:C2:00:00:00 ?

	Andrew
