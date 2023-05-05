Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 50C146F7FF2
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:27:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231735AbjEEJ1S (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:27:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231384AbjEEJ1J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:27:09 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3461D2D66
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 02:26:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CCF8063CB4
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 09:26:49 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6DD03C433EF;
        Fri,  5 May 2023 09:26:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683278809;
        bh=cbv7KqFW3EZCwbXiqh1UsSQZA6Dm577W9BTUAcRYjjs=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=YR3ygV1n/WztmQPmypSDHPmCE21+CNyWvFvgd7VAxyi6F+rg2w9GATY0uAdZgQVtQ
         4DPVLjOoqN7CfvpJbD/WKRzabu5rhGp9Ppyle//dCD6ZUck8fN4WD5pnVHIojEd4M1
         RPonfvoC1x1T+xazjxm6SoE1dCKqLnakzXLmrRFOmOf26GwBTBQpPVLaElgsJL/ZSi
         pHIMDgKZTCqpYQVw4qNT9bd4UUuXeZTlP0WCglUiZa8inC1NcroG6UffZRwk2ttqP8
         WkF1rPZuz9M7bs8RcKyQ0YcSif40FX9PoP9WEPwGNBcIIt57hNTMxlug7WQ/Jiriuo
         E7sWXyesn59lA==
Date:   Fri, 5 May 2023 14:56:44 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Guillaume Ranquet <granquet@baylibre.com>
Cc:     Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Kishon Vijay Abraham I <kishon@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH 0/2] Fix mtk-hdmi-mt8195 unitialized variable usage and
 clock rate calculation
Message-ID: <ZFTL1BRE+qke209f@matsya>
References: <20230413-fixes-for-mt8195-hdmi-phy-v1-0-b8482458df0d@baylibre.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230413-fixes-for-mt8195-hdmi-phy-v1-0-b8482458df0d@baylibre.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13-04-23, 14:46, Guillaume Ranquet wrote:
> I've received a report from kernel test report [1] that a variable was used
> unitialized in the mtk8195 hdmi phy code.
> 
> I've upon fixing that issue found out that the clock rate calculation
> was erroneous since the calculus was moved to div_u64.

Applied both, thanks

-- 
~Vinod
