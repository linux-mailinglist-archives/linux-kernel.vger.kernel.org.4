Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D0E6674E639
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:11:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229798AbjGKFLT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:11:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbjGKFLQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:11:16 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9917FFE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 22:11:15 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 346566130D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:11:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 2F33FC433C7;
        Tue, 11 Jul 2023 05:11:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689052274;
        bh=C7BVPmyrFODmMAGS/20ZJNoDYZRHTu1u1B35lxlQU3k=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=YvxOyhVS5710owDv9a0+tLXFJIL+QkMY26XYvj8fDbb6OqVuBGKV8eGf83vvDiEE/
         UaUIb3ueci1eiHf5ztHCnDK/BWheBDplNbBcO2wkx33F1TfaBQjRJiPtkk+FrpGdNU
         Cco1nkOQwMzxu9zASc+blqVLdAljReQDfS6MF3ATYPJ607R9VNQYfYICKtmoTi51aF
         iDy5OTL7XT+Zs6WwZMzTBWPJSDhtRASdVOZXkbXbiJqZ6vVpIIa0QauXLoxv+bu4L3
         Q8qOkNoIFHrcSPak31pYkWW6EN+bVZQNskpMZ4BfLZkgS+EH9I6Rwtg6JAc0KK2rHa
         mNCNcNYvwGtcg==
From:   Vinod Koul <vkoul@kernel.org>
To:     Kishon Vijay Abraham I <kishon@kernel.org>,
        Yangtao Li <frank.li@vivo.com>
Cc:     linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org
In-Reply-To: <20230705090126.26854-1-frank.li@vivo.com>
References: <20230705090126.26854-1-frank.li@vivo.com>
Subject: Re: (subset) [PATCH 1/4] phy: marvell: phy-mvebu-cp110-comphy: Use
 devm_platform_get_and_ioremap_resource()
Message-Id: <168905227278.183385.8197059606502401050.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 10:41:12 +0530
MIME-Version: 1.0
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Mailer: b4 0.12.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        RCVD_IN_DNSWL_BLOCKED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On Wed, 05 Jul 2023 17:01:23 +0800, Yangtao Li wrote:
> Convert platform_get_resource(), devm_ioremap_resource() to a single
> call to devm_platform_get_and_ioremap_resource(), as this is exactly
> what this function does.
> 
> 

Applied, thanks!

[1/4] phy: marvell: phy-mvebu-cp110-comphy: Use devm_platform_get_and_ioremap_resource()
      commit: babfcaf544d890fe96a54184ccabde9c2afa520f
[2/4] phy: rockchip: phy-rockchip-typec: Use devm_platform_get_and_ioremap_resource()
      commit: 161f7ca9455c27eb0d228def6516d73a9cb841bf
[3/4] phy: renesas: r8a779f0-ether-serdes: Convert to devm_platform_ioremap_resource()
      commit: f21829b8b928ca2aedbed839ab9dec5d079c42dd

Best regards,
-- 
~Vinod


