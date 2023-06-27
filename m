Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 185A2740003
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Jun 2023 17:47:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231476AbjF0Prm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Jun 2023 11:47:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230161AbjF0Prk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Jun 2023 11:47:40 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 26501FC
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 08:47:39 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id B07E8611AE
        for <linux-kernel@vger.kernel.org>; Tue, 27 Jun 2023 15:47:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C6D65C433C0;
        Tue, 27 Jun 2023 15:47:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687880858;
        bh=iOmrAkhjLX9xnz6JUTR1rf5gnuLt/p1tz+zTtU5dmN4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=WylWbNrM13jPdjcWK0ovzaRxib9u4AFi3hhaFYlu/eoz1xlZnSGUR7TnUTC93WFjG
         HHDCYkiNSC++Vb9xnfZXZBMO2sRi/TW/cQr9kCPrVnkitzmQWGSYa26DulFJz1R6Ba
         r+2ljkfg+SFnsnrKwh6rD2CRNtLGAw5Ofiau2rYq74oZPrd9Gcu0HitFjI3lLUmvsK
         rkRrXdzBfmUsBFH+STKaKkuvFHsWNMbWW9B4Dx+nYA3i00YufHop0Sz+yWiV2hcasb
         rCdQIcaM4p7e96/ZPohV20ARDrIZ4MYiJ6286RPi/aNBiNhg5PJIzzzWyH4Pvik02L
         nmLmXHPz2ZYaA==
Date:   Tue, 27 Jun 2023 08:47:36 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sebastian.tobuschat@nxp.com
Subject: Re: [PATCH net-next v3 00/12] Add TJA1120 support
Message-ID: <20230627084736.592b5f34@kernel.org>
In-Reply-To: <20230627071853.106215-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230627071853.106215-1-radu-nicolae.pirea@oss.nxp.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 27 Jun 2023 10:18:41 +0300 Radu Pirea (NXP OSS) wrote:
> Hello everyone,
> 
> This patch series got bigger than I expected. It cleans up the
> next-c45-tja11xx driver and adds support for the TJA1120(1000BaseT1
> automotive phy).
> 
> Master/slave custom implementation was replaced with the generic
> implementation (genphy_c45_config_aneg/genphy_c45_read_status).
> 
> The TJA1120 and TJA1103 are a bit different when it comes to the PTP
> interface. The timestamp read procedure was changed, some addresses were
> changed and some bits were moved from one register to another. Adding
> TJA1120 support was tricky, and I tried not to duplicate the code. If
> something looks too hacky to you, I am open to suggestions.

## Form letter - net-next-closed

The merge window for v6.5 has begun and therefore net-next is closed
for new drivers, features, code refactoring and optimizations.
We are currently accepting bug fixes only.

Please repost when net-next reopens after July 10th.

RFC patches sent for review only are obviously welcome at any time.

See: https://www.kernel.org/doc/html/next/process/maintainer-netdev.html#development-cycle
-- 
pw-bot: defer

