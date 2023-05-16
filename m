Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B800704D9E
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 14:18:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231996AbjEPMSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 08:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231549AbjEPMSi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 08:18:38 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B8EA49E4;
        Tue, 16 May 2023 05:18:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=iXg6k8lAqcLNkjmM+3EjJ6NUCTSstzc0OitScDh3o0Y=; b=Hh1LTdZpP+lxGRRpTjM2Yajuf5
        VaUDIdDYUn3NSEyIRl1DkNqo39Y8bAjZEC/npHZD9LoG4f7ZJA12gctKXgyIC3y0y6RZsryeFTN3c
        HV4P0KBKqbDL8fbtKpHq3lEbTtly0EmXbLfuRttcDwjwr/XyX1l4k3WZEugdb1+0+xH8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1pytdF-00D0uj-8p; Tue, 16 May 2023 14:18:21 +0200
Date:   Tue, 16 May 2023 14:18:21 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Marco Migliore <m.migliore@tiesse.com>
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Vladimir Oltean <olteanv@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Ashkan Boldaji <ashkan.boldaji@digi.com>,
        Pavana Sharma <pavana.sharma@digi.com>,
        Marek =?iso-8859-1?Q?Beh=FAn?= <kabel@kernel.org>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH net] net: dsa: mv88e6xxx: Fix mv88e6393x EPC write
 command offset
Message-ID: <7a51da03-30b9-41d0-ac14-ec29573afd61@lunn.ch>
References: <20230516073854.91742-1-m.migliore@tiesse.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230516073854.91742-1-m.migliore@tiesse.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 16, 2023 at 09:38:54AM +0200, Marco Migliore wrote:
> According to datasheet, the command opcode must be specified
> into bits [14:12] of the Extended Port Control register (EPC).
> 
> Fixes: de776d0d316f ("net: dsa: mv88e6xxx: add support for mv88e6393x family")
> Signed-off-by: Marco Migliore <m.migliore@tiesse.com>

Hi Marco

Thanks for the respin.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

For the next time you submit a patch, it is normal to put a version in the Subject line:

[PATCH net v2] net: dsa: mv88e6xxx: Fix mv88e6393x EPC write command offset

That helps us keep track of the versions, and makes it clear which is
the latest version.

    Andrew
