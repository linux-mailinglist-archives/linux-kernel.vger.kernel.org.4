Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF3B570DFB7
	for <lists+linux-kernel@lfdr.de>; Tue, 23 May 2023 16:53:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237385AbjEWOxg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 May 2023 10:53:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236276AbjEWOxc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 May 2023 10:53:32 -0400
Received: from pandora.armlinux.org.uk (pandora.armlinux.org.uk [IPv6:2001:4d48:ad52:32c8:5054:ff:fe00:142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6F1CD126;
        Tue, 23 May 2023 07:53:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=armlinux.org.uk; s=pandora-2019; h=Sender:In-Reply-To:Content-Type:
        MIME-Version:References:Message-ID:Subject:Cc:To:From:Date:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=EY2vqKqopZc6iT8EvTesUwFthMjKSdx98jMESd4LXJQ=; b=V4GVATPw106mYkcnRgHxk4KW8M
        EpAypbAAK38ZsMYx8Gjffc8wyD4Sb8/LCJdyTOKWvuddm4oDeZcQq6B6RiXAn+pBZdTDmHSc2+8s7
        F3ukHXle+MAl63bPjpkoStNetZQWCxzzORyYOMf4ucGAQ+azDyv870LUqaW1Ps3X6nY5hvQNRS/R4
        ucy9qF7kvg+5IxmaOlwBZWvaupehbcuhpecPqE113N44le3RvMwTqy20+Mac6CTo3RA6apTbeiozl
        7hG0Pnbc4GC2yWH44Z5KaMNqnEevOq3vxSInd/4odek/7nwIeuRLihZZoIflABL28xwF0K+Odf7QG
        J4Bk96Vw==;
Received: from shell.armlinux.org.uk ([fd8f:7570:feb6:1:5054:ff:fe00:4ec]:52904)
        by pandora.armlinux.org.uk with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <linux@armlinux.org.uk>)
        id 1q1TEa-0000Zl-5o; Tue, 23 May 2023 15:43:32 +0100
Received: from linux by shell.armlinux.org.uk with local (Exim 4.94.2)
        (envelope-from <linux@shell.armlinux.org.uk>)
        id 1q1TEZ-0000fM-1I; Tue, 23 May 2023 15:43:31 +0100
Date:   Tue, 23 May 2023 15:43:31 +0100
From:   "Russell King (Oracle)" <linux@armlinux.org.uk>
To:     Lukasz Majewski <lukma@denx.de>
Cc:     Andrew Lunn <andrew@lunn.ch>, Vladimir Oltean <olteanv@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Florian Fainelli <f.fainelli@gmail.com>,
        "David S. Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Paolo Abeni <pabeni@redhat.com>,
        Alexander Duyck <alexander.duyck@gmail.com>,
        netdev@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7 1/3] dsa: marvell: Define .set_max_frame_size()
 function for mv88e6250 SoC family
Message-ID: <ZGzRE48DchoclbBl@shell.armlinux.org.uk>
References: <20230523142912.2086985-1-lukma@denx.de>
 <20230523142912.2086985-2-lukma@denx.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230523142912.2086985-2-lukma@denx.de>
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

Also, subject line should be "net: dsa: ..."

-- 
RMK's Patch system: https://www.armlinux.org.uk/developer/patches/
FTTP is here! 80Mbps down 10Mbps up. Decent connectivity at last!
