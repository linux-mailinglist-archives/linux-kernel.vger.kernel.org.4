Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11B196F4EE8
	for <lists+linux-kernel@lfdr.de>; Wed,  3 May 2023 04:47:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229600AbjECCq7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 2 May 2023 22:46:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229455AbjECCq5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 May 2023 22:46:57 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8A76D30D8
        for <linux-kernel@vger.kernel.org>; Tue,  2 May 2023 19:46:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 23D50629F4
        for <linux-kernel@vger.kernel.org>; Wed,  3 May 2023 02:46:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 234CAC433D2;
        Wed,  3 May 2023 02:46:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683082015;
        bh=k4GsXcb5/LxuYCE43eHt0iFQuQ3l/Ck81cTTFkYzGcE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qrbMaogE3c/lfx9KwpxMKBl6Iysq8Cn1Gfe2eLI3xxQwEPvgPw0eTObgLCBu/oJVV
         oNpIVAk2oWH940w+709dZIkszRyFMn+UkiaoxLY8A3j0ID7ZrxU7okwLIipk+LfZVE
         3+9ne1doiBwzb3XW221++xy9Da7G7OV4nrQRGm7KLrUfG1ZEhGdvE377MH+nzAEGzs
         wPw2FRB3Ad1OlH/sIz/1e2/P5FN4GX3d9vvq2MiUvlF1WJ9wtIelZPrZ4BMQgvM6Qk
         Azxf/R0XnDrdba8mwOiT96DUKRPGSxf5spEEAKmd3xrwvmp/TXT1zt9lDMASwWvzDl
         s8ZSJvlPmsTiA==
Date:   Tue, 2 May 2023 19:46:54 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Devang Vyas <devangnayanbhai.vyas@amd.com>
Cc:     Andrew Lunn <andrew@lunn.ch>, hkallweit1@gmail.com,
        linux@armlinux.org.uk, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] net: phy: aquantia: Add 10mbps support
Message-ID: <20230502194654.093afb13@kernel.org>
In-Reply-To: <7ae81127-a2aa-4f02-8c07-b8f158e0ef83@lunn.ch>
References: <20230426081612.4123059-1-devangnayanbhai.vyas@amd.com>
        <7ae81127-a2aa-4f02-8c07-b8f158e0ef83@lunn.ch>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 26 Apr 2023 14:54:01 +0200 Andrew Lunn wrote:
> On Wed, Apr 26, 2023 at 01:46:12PM +0530, Devang Vyas wrote:
> > This adds support for 10mbps speed in PHY device's
> > "supported" field which helps in autonegotiating
> > 10mbps link from PHY side where PHY supports the speed
> > but not updated in PHY kernel framework.  
> 
> Are you saying it is not listed in BMSR that the PHY supports 10 Mbps?
> Bits BMSR_10HALF and BMSR_10FULL are not set?

I didn't see any reply to Andrew's question so dropping this 
from patchwork for now. It feels like -next material too, so
please hold off any reposting until Monday.
-- 
pw-bot: defer
