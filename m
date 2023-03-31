Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7225F6D21C8
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 15:53:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232311AbjCaNx3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 09:53:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229629AbjCaNxZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 09:53:25 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CE3826BF
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 06:53:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 10AFA6264F
        for <linux-kernel@vger.kernel.org>; Fri, 31 Mar 2023 13:53:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DDBC9C433D2;
        Fri, 31 Mar 2023 13:53:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680270804;
        bh=iobnNx/k4Sc2xMbYMQJiH+DrwwFFMu9MAZjj3G/BEow=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=a4SmCF/0mzYQdQsMPReJLAifywz8g/9ccxuuOc1zINTi9oWXgfjZXskwB+h6Q1+9U
         kRPzZtTwMFZ9VzXer4L2cmi5Q9JtH7bgugAkEbvxfphndLHu69CmyzZm+qpNQem4Tf
         x2ZwXLfgcKWeXkh9uIlQbedWp71McJMkSI07P1J/jcRMN0x42NV4eULjpXvJ4HBZ4C
         4gESQ3fKOPHhAYILMfymW9G7D5oAW6JG2AifhtQfSF7Xkr7m0Pe0q1MmmyKIKnL+M5
         P5pXXoxDc5uH7pEaFq4X9A74IlcMTvvJnWU9AIpGWOMTHUWzkkQN7nSCV+6hHbZYo2
         ypHyZgTPOOuRQ==
Date:   Fri, 31 Mar 2023 19:23:20 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     kishon@kernel.org, heiko@sntech.de, nathan@kernel.org,
        ndesaulniers@google.com, linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] phy: rockchip-pcie: remove unused phy_rd_cfg function
Message-ID: <ZCbl0Aa7gtvXZ/58@matsya>
References: <20230321122503.1783311-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230321122503.1783311-1-trix@redhat.com>
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,
        SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 21-03-23, 08:25, Tom Rix wrote:
> clang with W=1 reports
> drivers/phy/rockchip/phy-rockchip-pcie.c:122:19: error:
>   unused function 'phy_rd_cfg' [-Werror,-Wunused-function]
> static inline u32 phy_rd_cfg(struct rockchip_pcie_phy *rk_phy,
>                   ^
> This function is not used, so remove it.

Applied, thanks

-- 
~Vinod
