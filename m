Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C2FE73A8D9
	for <lists+linux-kernel@lfdr.de>; Thu, 22 Jun 2023 21:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231501AbjFVTPE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 22 Jun 2023 15:15:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48474 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231463AbjFVTPC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 22 Jun 2023 15:15:02 -0400
Received: from vps0.lunn.ch (vps0.lunn.ch [156.67.10.101])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2725F1A3;
        Thu, 22 Jun 2023 12:15:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=lunn.ch;
        s=20171124; h=In-Reply-To:Content-Disposition:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:From:Sender:Reply-To:Subject:
        Date:Message-ID:To:Cc:MIME-Version:Content-Type:Content-Transfer-Encoding:
        Content-ID:Content-Description:Content-Disposition:In-Reply-To:References;
        bh=rVSwZmo6YEMkdlAPeqhXmjbT6Y0ePJFEJuTxqSTX/cQ=; b=PkGkRIXAnmqLYLAYpkHI2sw6ch
        9nynT/LGXi3r3B+1GAXY/1xXvzmG02v7rm3tPKVl0LTY6PGWLyF6mQp4p24WIcdXeHPAIvWj8HwfO
        RD1mJ6tdXCi89In/4wh/n/Bt/MfhZZME0A52SrXelToIvYRw6+AOrXgQ1e1zJsM5hQFA=;
Received: from andrew by vps0.lunn.ch with local (Exim 4.94.2)
        (envelope-from <andrew@lunn.ch>)
        id 1qCPlU-00HIIH-OI; Thu, 22 Jun 2023 21:14:44 +0200
Date:   Thu, 22 Jun 2023 21:14:44 +0200
From:   Andrew Lunn <andrew@lunn.ch>
To:     Florian Fainelli <florian.fainelli@broadcom.com>
Cc:     netdev@vger.kernel.org, hkallweit1@gmail.com, ansuelsmth@gmail.com,
        rmk+kernel@armlinux.org.uk, Doug Berger <opendmb@gmail.com>,
        Broadcom internal kernel review list 
        <bcm-kernel-feedback-list@broadcom.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH net] net: bcmgenet: Ensure MDIO unregistration has clocks
 enabled
Message-ID: <6ecd7203-30a7-4806-94be-eb77b3ba68b1@lunn.ch>
References: <20230622103107.1760280-1-florian.fainelli@broadcom.com>
 <533872e1-b323-4bca-aacc-4d3cfbed53bd@lunn.ch>
 <463a64a4-d629-27bc-2269-3fcdbf8b7e50@broadcom.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <463a64a4-d629-27bc-2269-3fcdbf8b7e50@broadcom.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> Since this is a fix, I went with the more targeted approach here.

Yes, this is fine for stable.

Reviewed-by: Andrew Lunn <andrew@lunn.ch>

    Andrew
