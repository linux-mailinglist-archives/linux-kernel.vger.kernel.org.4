Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1423270507C
	for <lists+linux-kernel@lfdr.de>; Tue, 16 May 2023 16:22:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233502AbjEPOWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 May 2023 10:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233391AbjEPOVy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 May 2023 10:21:54 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0328B7A85
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 07:21:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3271A62668
        for <linux-kernel@vger.kernel.org>; Tue, 16 May 2023 14:21:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 20626C433EF;
        Tue, 16 May 2023 14:21:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1684246898;
        bh=MwJW9qECEUezZaNFCk5dvGd5LQA0WLC9PlOo5V0Szu8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=O07aAXle6UZY59B29dlg7giCM9zC+nl0L2AfWg+B/oCeecFIUJ6ucQytbpbJxOtz7
         Eqg7pGh2LLmu16ltEMCbXXLLmHjynher+DYHr8jp09yJSeeKfg0NjmlZD2QFKaToEX
         UXjRQxzUHVIs65KQS200+OQra+3vCMo4GunjMCl1/WXj1zYAvUBCLdrD6r2o4ylqNH
         GCRhNXaseb1i0AKGNFQtAyxPIFYn1oHMhnkAGt7nJVNqhh1/xINTOaTCadf5WIa02o
         08kYCB3QKEb3fhvhJ/Dov+TD20amWGgUxOSlA8sdSSBh5BBfcSaxeziYsWRKlQzE/A
         GmWEUwGiy07GQ==
Date:   Tue, 16 May 2023 19:51:35 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Yang Li <yang.lee@linux.alibaba.com>
Cc:     shawnguo@kernel.org, s.hauer@pengutronix.de, kishon@kernel.org,
        kernel@pengutronix.de, festevam@gmail.com, linux-imx@nxp.com,
        linux-phy@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next] phy: freescale: imx8m-pcie: Use
 devm_platform_ioremap_resource()
Message-ID: <ZGORbzUJkNaI/U4l@matsya>
References: <20230428052758.38636-1-yang.lee@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230428052758.38636-1-yang.lee@linux.alibaba.com>
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28-04-23, 13:27, Yang Li wrote:
> Convert platform_get_resource(),devm_ioremap_resource() to a single
> call to devm_platform_ioremap_resource(), as this is exactly what this
> function does.

Applied, thanks

-- 
~Vinod
