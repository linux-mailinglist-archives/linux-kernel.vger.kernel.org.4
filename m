Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 491646FF3C0
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:13:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238314AbjEKONn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:13:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238019AbjEKONf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:13:35 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41448E709;
        Thu, 11 May 2023 07:12:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=eReVV4zkcQenT5W13hhsmnpesROOGAzKAt/4OFBBRSA=; b=dOUCuEhUgbbsVzbJ5DwIxsc2Qc
        kO1wwunsUEcHUYT1jbGJWCtYSAgA9LlAq9aCuGmamOdY7Rk1lbhB+Q2UHUNV4jcuCsejfF28y/80H
        yhMt+coog8e88RobT+FiM8F5dmBP9vV5A9Vlh1spcUGl4vpKCXaBVehZEhc/sSSgw2q0=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1px71G-00CYxu-0s; Thu, 11 May 2023 16:11:46 +0200
Date:   Thu, 11 May 2023 16:11:46 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Harini Katakam <harini.katakam@amd.com>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
        vladimir.oltean@nxp.com, wsa+renesas@sang-engineering.com,
        simon.horman@corigine.com, mkl@pengutronix.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        harinikatakamlinux@gmail.com, michal.simek@amd.com,
        radhey.shyam.pandey@amd.com
Subject: Re: [PATCH net-next v3 3/3] phy: mscc: Add support for VSC8531_02
Message-ID: <ed6cd234-1d75-47f4-a808-6a152a63af0b@lunn.ch>
References: <20230511120808.28646-1-harini.katakam@amd.com>
 <20230511120808.28646-4-harini.katakam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511120808.28646-4-harini.katakam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 05:38:08PM +0530, Harini Katakam wrote:
> Add support for VSC8531_02 (Rev 2) device. Use exact PHY ID match.
> 
> Signed-off-by: Harini Katakam <harini.katakam@amd.com>
> ---
> v3 - Patch split
> 
>  drivers/net/phy/mscc/mscc.h      |  1 +
>  drivers/net/phy/mscc/mscc_main.c | 26 ++++++++++++++++++++++++--
>  2 files changed, 25 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/net/phy/mscc/mscc.h b/drivers/net/phy/mscc/mscc.h
> index ab6c0b7c2136..6a0521ff61d2 100644
> --- a/drivers/net/phy/mscc/mscc.h
> +++ b/drivers/net/phy/mscc/mscc.h
> @@ -281,6 +281,7 @@ enum rgmii_clock_delay {
>  #define PHY_ID_VSC8514			  0x00070670
>  #define PHY_ID_VSC8530			  0x00070560
>  #define PHY_ID_VSC8531			  0x00070570
> +#define PHY_ID_VSC8531_02		  0x00070572

Does PHY_ID_VSC8531_01 exist? The current code would support that,
where as now i don't think any entry will match.

      Andrew
