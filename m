Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D09A7326B6
	for <lists+linux-kernel@lfdr.de>; Fri, 16 Jun 2023 07:41:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230142AbjFPFlT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 16 Jun 2023 01:41:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229680AbjFPFlO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 16 Jun 2023 01:41:14 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 126F32D5E
        for <linux-kernel@vger.kernel.org>; Thu, 15 Jun 2023 22:41:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8B1EF61D26
        for <linux-kernel@vger.kernel.org>; Fri, 16 Jun 2023 05:41:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 733A3C433C8;
        Fri, 16 Jun 2023 05:41:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1686894065;
        bh=eYR/ym1NZSFPGTIefjm02LzIa+aRYuH8daOwAd9pBJI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=kQSUDUNsBQWXcpjGVDNgq7Y9x3FnYcyznzjUPNVExCXJ9ivLd5b2+IJEcXwS4uDEO
         Yoqx2WCPA+GB3YqPghPOmBy9uG6QjQXV4lYeQzPG8NbfIzY0qv6yFiLWsjzeZEmy13
         +t6b7Gpokz1RQAofBgFYu1qg2rLMcrh5GuVfmx8kCm1MF1YHkdsM4/2mVM7xRFAcE6
         KBDvLKs4MSRs/HaLcjOobxBAEkIW7xgsEQGYfl5Pwerm6Ad7d75iiO+4FrUpyV8ett
         HJM8nbzM45y6VnRQOHIZt49b4aoLcvV7AB6RnwEaGO1ZYBeF6SHpI5Xx6+nOyu6fcj
         erzEbm+x2sXyA==
Date:   Thu, 15 Jun 2023 22:41:04 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     Jianhui Zhao <zhaojh329@gmail.com>, andrew@lunn.ch,
        linux@armlinux.org.uk
Cc:     hkallweit1@gmail.com, davem@davemloft.net, edumazet@google.com,
        pabeni@redhat.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V3] net: phy: Add sysfs attribute for PHY c45
 identifiers.
Message-ID: <20230615224104.2b9f3adf@kernel.org>
In-Reply-To: <20230614134522.11169-1-zhaojh329@gmail.com>
References: <20230614134522.11169-1-zhaojh329@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 14 Jun 2023 21:45:22 +0800 Jianhui Zhao wrote:
> Reviewed-by: Andrew Lunn <andrew@lunn.ch>
> Reviewed-by: Russell King <linux@armlinux.org.uk>

Did Andrew and Russell give review tags on the list ?
I don't see any given to v2.
