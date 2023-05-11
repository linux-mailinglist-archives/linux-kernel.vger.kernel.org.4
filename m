Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87EC66FF393
	for <lists+linux-kernel@lfdr.de>; Thu, 11 May 2023 16:06:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238279AbjEKOGH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 May 2023 10:06:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52084 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237480AbjEKOGE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 May 2023 10:06:04 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 082E010FF;
        Thu, 11 May 2023 07:05:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=MtnwjUGQMTg1yfTTLU9Z+2ghB5SIPLEsC/rY/cUh02I=; b=hly3rb5w639+90+1SucuCz1Ifm
        3WCHiSXMIRtwdCiXL5a5D0qYmHL5SsocwYX5WuffMZ0XFnbpLrH4IMYW+iVaZ21wW+UjgX2aebOax
        9YXZSz4Und/V0E+W8F80Y396RNt0EGZ0K27Caxf3HHdohA+CZWPru/AWHQzJxDFb0VzY=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1px6vN-00CYvh-P7; Thu, 11 May 2023 16:05:41 +0200
Date:   Thu, 11 May 2023 16:05:41 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Harini Katakam <harini.katakam@amd.com>
Cc:     hkallweit1@gmail.com, linux@armlinux.org.uk, davem@davemloft.net,
        kuba@kernel.org, edumazet@google.com, pabeni@redhat.com,
        vladimir.oltean@nxp.com, wsa+renesas@sang-engineering.com,
        simon.horman@corigine.com, mkl@pengutronix.de,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        harinikatakamlinux@gmail.com, michal.simek@amd.com,
        radhey.shyam.pandey@amd.com
Subject: Re: [PATCH net-next v3 1/3] phy: mscc: Use PHY_ID_MATCH_VENDOR to
 minimize PHY ID table
Message-ID: <428db3e5-fb22-45a3-8d75-85cfbf67fe56@lunn.ch>
References: <20230511120808.28646-1-harini.katakam@amd.com>
 <20230511120808.28646-2-harini.katakam@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230511120808.28646-2-harini.katakam@amd.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 11, 2023 at 05:38:06PM +0530, Harini Katakam wrote:
> All the PHY devices variants specified have the same mask and
> hence can be simplified to one vendor look up for 0x00070400.
> Any individual config can be identified by PHY_ID_MATCH_EXACT
> in the respective structure.
> 
> Signed-off-by: Harini Katakam <harini.katakam@amd.com>

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
