Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6812A745FF4
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Jul 2023 17:38:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230471AbjGCPi3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Jul 2023 11:38:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33552 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229454AbjGCPi2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Jul 2023 11:38:28 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C7FCE49;
        Mon,  3 Jul 2023 08:38:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=wkqMLEVigBtW/F9ZQ5Js0pxTwVvpXSe9+nI17gSnD6U=; b=OB4Cj7jiwBQjss9EmPrZbH9RYS
        /h9Drdy2vDECtzQNkcUXAHLbIWEUieDHkJM7sU3e3J+xjOR3CyUn2MOwr5rVahZfMSVtw+sGzSABt
        sP/W2VT4rJNK0QiF4t0M80S9b1dK8V2XaqrhDS6xWh7O9QHXW9iOwDtD0uQiwRRBpCzU=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qGLd9-000UQQ-5y; Mon, 03 Jul 2023 17:38:23 +0200
Date:   Mon, 3 Jul 2023 17:38:23 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     "M. Haener" <michael.haener@siemens.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Alexander Sverdlin <alexander.sverdlin@siemens.com>
Subject: Re: [PATCH 0/3] net: dsa: SERDES support for mv88e632x family
Message-ID: <3664909e-a259-4bca-be53-5bab43e23dbc@lunn.ch>
References: <20230703152611.420381-1-michael.haener@siemens.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230703152611.420381-1-michael.haener@siemens.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 03, 2023 at 05:26:06PM +0200, M. Haener wrote:
> From: Michael Haener <michael.haener@siemens.com>
> 
> This patch series brings SERDES support for the mv88e632x family.

Please take a look at Russell Kings series:

https://www.spinics.net/lists/netdev/msg914908.html

It would be good if you could build on top of that, which we should be
merging soon.

   Andrew
