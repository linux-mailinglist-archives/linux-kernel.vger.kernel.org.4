Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E7FC474E63A
	for <lists+linux-kernel@lfdr.de>; Tue, 11 Jul 2023 07:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230358AbjGKFLW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 11 Jul 2023 01:11:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53770 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229921AbjGKFLT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Jul 2023 01:11:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6493CFE
        for <linux-kernel@vger.kernel.org>; Mon, 10 Jul 2023 22:11:18 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F1F546130D
        for <linux-kernel@vger.kernel.org>; Tue, 11 Jul 2023 05:11:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 4A00CC433C8;
        Tue, 11 Jul 2023 05:11:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1689052277;
        bh=zr5NqgpeFTGxMQvbPnoLre6zUBBryXW5GFgxi1iNHLs=;
        h=From:To:Cc:In-Reply-To:References:Subject:Date:From;
        b=tALJ9cd8qjcaZdvzzzW96TJuYoF5zjetIUf62yfbPjQhLaynR+1OQsai1B4bKsThj
         rYwpUJY1sm3qG7JcZwXk3QOrHJCbfRyc4MFB+K+HF/lBmQDcKx3WsCkZE5c6goyW6z
         KEIaFbnnWSmsFAgDxg+EnwjJcPE70rqWVPmA7FKdDm3eamNQOwrnNK7H/Kg1GkQEwe
         3KLo/ZwNBH9dj3ntHxl/hEycpsoLkrUkv4rEKaGv9Vggc7Es/L0CBGlw3EfDLdD8NQ
         3ItP/sA/Wbz8dfLhRnBpzSU2d6afd41ay8xqdHuN2OlxI3R0/Fc1AyTdyFGKuCfUJZ
         5qcw3jWVa27zQ==
From:   Vinod Koul <vkoul@kernel.org>
To:     kishon@kernel.org, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Swapnil Jakhade <sjakhade@cadence.com>
Cc:     mparab@cadence.com, rogerq@kernel.org, s-vadapalli@ti.com
In-Reply-To: <20230530143853.26571-1-sjakhade@cadence.com>
References: <20230530143853.26571-1-sjakhade@cadence.com>
Subject: Re: [PATCH 0/2] PHY: Add support for single link USXGMII in
 Cadence Torrent PHY driver
Message-Id: <168905227488.183385.1679105538313094810.b4-ty@kernel.org>
Date:   Tue, 11 Jul 2023 10:41:14 +0530
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


On Tue, 30 May 2023 16:38:51 +0200, Swapnil Jakhade wrote:
> This patch series extends Torrent PHY driver functionality to support
> single link USXGMII for 156.25MHz refclk.
> It also implements key:value pair table for all settings instead
> of a 3D matrix.
> 
> The changes have been validated on TI J721E and J7200 platforms.
> 
> [...]

Applied, thanks!

[1/2] phy: cadence-torrent: Add single link USXGMII configuration for 156.25MHz refclk
      commit: 81e4c826b35672838e2cb9ef693855998913fde4
[2/2] phy: cadence-torrent: Use key:value pair table for all settings
      commit: 01c69d7d76db623ed7bcaf60a652af64bfbe4a15

Best regards,
-- 
~Vinod


