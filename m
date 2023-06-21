Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85A5C7379C0
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 05:31:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229544AbjFUDbw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 23:31:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38648 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbjFUDbu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 23:31:50 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AF62694;
        Tue, 20 Jun 2023 20:31:47 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 35FE36145C;
        Wed, 21 Jun 2023 03:31:47 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3D4C7C433C0;
        Wed, 21 Jun 2023 03:31:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1687318306;
        bh=w/WJ4ih3bWFbg0Sp+HP6bcoaz3TM0sRb50HscssW6MU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=bR88lo4oD30GmFt15WApTVHfKB8r8xfkjaRVADkJ2JAd3VOlMCk29G3bmmZI1xmv2
         lPQSSuXGnvOTADDXMuDxnR53GTYL03AK9Qi1IeGUvq6aDe5YsuJi0Gy0c3CzvEVfuf
         z3RHv6PHWulfVdTu6MMytJbovQ9IEoSZOLckkYLml073/3hpTgLNlLlfxbp6AMR6ET
         n1bAgai8idE+OCjr+6Vuh6aTiQvxLLSYgYSEyU8SfxQWqQ6GMOVU9Tx1D6LfBbyw2l
         as7BknO4rpEgboGtdj2wcKG82J2/JTFTRuoL2FiNLZm34m649hgx3ftz/oJMEvcKT9
         v9bDUARK4hfCA==
Date:   Tue, 20 Jun 2023 20:31:45 -0700
From:   Jakub Kicinski <kuba@kernel.org>
To:     "Radu Pirea (NXP OSS)" <radu-nicolae.pirea@oss.nxp.com>
Cc:     andrew@lunn.ch, hkallweit1@gmail.com, linux@armlinux.org.uk,
        davem@davemloft.net, edumazet@google.com, pabeni@redhat.com,
        richardcochran@gmail.com, netdev@vger.kernel.org,
        linux-kernel@vger.kernel.org, sebastian.tobuschat@nxp.com,
        stable@vger.kernel.org
Subject: Re: [PATCH net v3 1/1] net: phy: nxp-c45-tja11xx: fix the PTP
 interrupt enablig/disabling
Message-ID: <20230620203145.2da7c958@kernel.org>
In-Reply-To: <20230619132851.233976-1-radu-nicolae.pirea@oss.nxp.com>
References: <20230619132851.233976-1-radu-nicolae.pirea@oss.nxp.com>
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

On Mon, 19 Jun 2023 16:28:51 +0300 Radu Pirea (NXP OSS) wrote:
> Subject: [PATCH net v3 1/1] net: phy: nxp-c45-tja11xx: fix the PTP interrupt enablig/disabling

typo: enablig -> enabling

> .config_intr() handles only the link event interrupt and should
> disable/enable the PTP interrupt also.

I don't understand this sentence, TBH, could you rephrase?

> Fixes: 514def5dd339 ("phy: nxp-c45-tja11xx: add timestamping support")

For a fix we really need to commit message to say what the problem is,
in terms which will be understood by the user. User visible behavior.

> CC: stable@vger.kernel.org # 5.15+
> Signed-off-by: Radu Pirea (NXP OSS) <radu-nicolae.pirea@oss.nxp.com>
> ---
> 
> Where is V1?
> https://patchwork.kernel.org/project/netdevbpf/patch/20230410124856.287753-1-radu-nicolae.pirea@oss.nxp.com/
> 
> Where is V2?
> https://patchwork.kernel.org/project/netdevbpf/patch/20230616135323

This link looks cut off.

> +	/* 0x807A register is not present on SJA1110 PHYs. */

Meaning? It's safe because the operation will be ignored?
-- 
pw-bot: cr
