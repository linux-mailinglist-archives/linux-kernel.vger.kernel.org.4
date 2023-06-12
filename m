Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9334072C975
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 17:11:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238471AbjFLPLQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 11:11:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41994 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237481AbjFLPLJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 11:11:09 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CB38E51;
        Mon, 12 Jun 2023 08:10:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=2uMMNFJJF4olltfr7iLvbGkW7AOBL0zwm41SdvTlXZg=; b=w4fZFWQ5FYvSae2k0j24foRueM
        7VriXTeScn0AOWm/RyPTwjulLiEHTTkImCHW+EM/0Rirc9c7gniaDWSoQY/Clpan7Lwk0JhgR/4aF
        SrkkEDqTOhX/bsJsol1IO9sgjNy2B/v+6wyeNfL3o/beAcAskGYdIX+FXGFPPl8pi9XHAM7D+g54m
        x0t3RDWJBnWgkTo/wPdSXLUXp42nMqhPrhAXDI+seai5N3/WWFSaAwyvDu/1Bzvz3IfQd+cVmljMg
        ndhwTeSUm9RNASB9UU3tRBZ7pmUV7Ews75eEQVL9cUJYwHnjblhx7Hop2dQ1GfQWr6rO6Y6GRqCIB
        oyt447YQ==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:41860)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q8jC1-0005vl-QO; Mon, 12 Jun 2023 16:10:53 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q8jC1-000554-6q; Mon, 12 Jun 2023 16:10:53 +0100
Date:   Mon, 12 Jun 2023 16:10:53 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Jianhui Zhao <zhaojh329@gmail.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, davem@davemloft.net,
        edumazet@google.com, kuba@kernel.org, pabeni@redhat.com,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: Assign the c45 id to phy_id property when
 matched.
Message-ID: <ZIc1fZOavCB//fd6@shell.armlinux.org.uk>
References: <20230612143320.2077-1-zhaojh329@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230612143320.2077-1-zhaojh329@gmail.com>
Sender: Russell King (Oracle) <linux@armlinux.org.uk>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 12, 2023 at 10:33:20PM +0800, Jianhui Zhao wrote:
> If a phydevice use c45, its phy_id property is always 0 previously.
> This change make the phy_id property has a valid value assigned from
> c45 id.
> 
> Signed-off-by: Jianhui Zhao <zhaojh329@gmail.com>

Please see my replies to your proposal. I don't think this is a good
solution.

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
