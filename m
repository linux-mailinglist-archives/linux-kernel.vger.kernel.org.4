Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D566F83BE
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 15:19:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232431AbjEENS6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 09:18:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232426AbjEENSz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 09:18:55 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C5501E9BF;
        Fri,  5 May 2023 06:18:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=Y2Pl3joU3ArKu+3fIECnoIyOrPTGQkO/uS8PYdBCeGI=; b=FILjLS8qVmBxsL4CzOIaB+7NCr
        UPK30itFQC6woX+pzzT2Xmo6M+mBXjazlcra8sE8dGaoVZKA9XYjnL+m+3O7no2Hqc0dS53Ke7pof
        cCJDQkas880JB92podbSB5R2HMV2uHDNmJpgjUbmslVH8ayHPJ3/DK7Q0Nb8VXt5npJ8=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1puvKa-00C03Z-14; Fri, 05 May 2023 15:18:40 +0200
Date:   Fri, 5 May 2023 15:18:40 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Samin Guo <samin.guo@starfivetech.com>
Cc:     linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        netdev@vger.kernel.org, Peter Geis <pgwipeout@gmail.com>,
        Frank <Frank.Sae@motor-comm.com>,
        "David S . Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Heiner Kallweit <hkallweit1@gmail.com>,
        Russell King <linux@armlinux.org.uk>,
        Yanhong Wang <yanhong.wang@starfivetech.com>
Subject: Re: [PATCH v2 2/2] net: phy: motorcomm: Add pad drive strength cfg
 support
Message-ID: <fc516e65-cde2-4a65-a3c5-bd8c939e7eb1@lunn.ch>
References: <20230505090558.2355-1-samin.guo@starfivetech.com>
 <20230505090558.2355-3-samin.guo@starfivetech.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505090558.2355-3-samin.guo@starfivetech.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>  #define YTPHY_DTS_OUTPUT_CLK_DIS		0
> @@ -1495,6 +1504,7 @@ static int yt8531_config_init(struct phy_device *phydev)
>  {
>  	struct device_node *node = phydev->mdio.dev.of_node;
>  	int ret;
> +	u32 ds, val;

Reverse Christmas tree.  Sort these longest first, shortest last.

Otherwise this looks O.K.

The only open question is if real unit should be used, uA, not some
magic numbers. Lets see what the DT Maintainers say.

      Andrew
