Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7BC4732FB2
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 13:20:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345598AbjFPLUZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 07:20:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344168AbjFPLUV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 07:20:21 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1654D137;
        Fri, 16 Jun 2023 04:20:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=vOWZCCk908bpIJfZNbY55iRa2RZU2NK+QwspWT3aWV4=; b=vKmyli4ytBy7o4k3OnjtlyguEB
        Ti4va/1elsIg/MkDb7awkDld8W3WAfepwIrfIFjnKVcQwlJtTHYquV1nAqJXJlvEv61ppUbqUKjaA
        LGK5NkvhVzz6frTyqdEm/dlO2pnNUQ3cm0zQhXBS7o/rLRXSburRftruDNB4h+/Nr5W45m7v+s18z
        TmkYViPQEm+JwqyVLG3rb7hFszUJGeRyW6fAZ6deNrSvqwkUfhZNeW03WVqutJClaBwjbkqrOxP6p
        06W+An/KYdvxFEraSqhFhBS8+375QdHn28AWNv6Mt96Q1GDZ9WlDtwmf2wJXhbzMxdBuM39p6zdjE
        odnF6RVA==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:59302)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1qA7V2-0004tj-CB; Fri, 16 Jun 2023 12:20:16 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1qA7Uz-0002Sn-UQ; Fri, 16 Jun 2023 12:20:13 +0100
Date:   Fri, 16 Jun 2023 12:20:13 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Josua Mayer <josua@solid-run.com>
Cc:     netdev@vger.kernel.org, linux-kernel@vger.kernel.org,
        Ioana Ciornei <ioana.ciornei@nxp.com>,
        "David S. Miller" <davem@davemloft.net>,
        Eric Dumazet <edumazet@google.com>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>
Subject: Re: [PATCH] net: dpaa2-mac: add 25gbase-r support
Message-ID: <ZIxFbeJyyUGdxzwy@shell.armlinux.org.uk>
References: <20230616111414.1578-1-josua@solid-run.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230616111414.1578-1-josua@solid-run.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 16, 2023 at 02:14:14PM +0300, Josua Mayer wrote:
> Layerscape MACs support 25Gbps network speed with dpmac "CAUI" mode.
> Add the mappings between DPMAC_ETH_IF_* and HY_INTERFACE_MODE_*, as well

Missing "P" for "PHY_".

> as the 25000 mac capability.
> 
> Tested on SolidRun LX2162a Clearfog, serdes 1 protocol 18.
> 
> Signed-off-by: Josua Mayer <josua@solid-run.com>

Otherwise,

Reviewed-by: Russell King (Oracle) <rmk+kernel@armlinux.org.uk>

Thanks!

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
