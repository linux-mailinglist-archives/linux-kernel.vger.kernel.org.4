Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 484896F7FEF
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:27:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231515AbjEEJ1B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:27:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229713AbjEEJ06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:26:58 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6975F19437
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 02:26:28 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 7009E63CAC
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 09:26:20 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 114A4C433EF;
        Fri,  5 May 2023 09:26:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683278779;
        bh=lSshFfSGlyCi4G0qcKJd031Akuz+SfzSDmjiM7FKFpw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=IOg+47p2FzSo6WXiYzWJqEGAZiRc5D6cLwe4n8/RYwwLqArfccLCr3x+fGPrUACbM
         3hpfrSknlmvxQ8TbCWGivTgknyEGVepFt3BoUTOMunwrf4qKgnDMf70V+QrS1sQ+H2
         SMu+YNYRppB5GdY27xveXRbuBlZ8qMJ5VMRWsZ5gTzptXjnNZtxvP1hJemO9HaitoD
         X1PMNzX5Aa/VHFFZ/lfZ4zSZSPRIkMf6jnR2TEPiknUoBimmHGg4gwTQVGQC2E3+49
         PbAtnCSUAr/eCbG3nyj12sLa/GqsolUKgeOtcBNkt4TrJGUkKFUsnoJOPTqSdYpoym
         zch1EdXtNONUg==
Date:   Fri, 5 May 2023 14:56:15 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Palmer Dabbelt <palmer@rivosinc.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        chunfeng.yun@mediatek.com, kishon@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux@rivosinc.com
Subject: Re: [PATCH] phy: mediatek: Remove unusued ret and check
Message-ID: <ZFTLt5JJVtbX8HQh@matsya>
References: <20230505001945.10179-1-palmer@rivosinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230505001945.10179-1-palmer@rivosinc.com>
X-Spam-Status: No, score=-4.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04-05-23, 17:19, Palmer Dabbelt wrote:
> From: Palmer Dabbelt <palmer@rivosinc.com>
> 
> This trips up a maybe-uninitialized warning, but it's actually just not
> used.

Thanks but this is already fixed by 714dd3c29a22 ("phy: mediatek: hdmi:
mt8195: fix uninitialized variable usage in pll_calc") in phy/next and
should be in Linus's tree shortly

-- 
~Vinod
