Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E1146F7FFA
	for <lists+linux-kernel@lfdr.de>; Fri,  5 May 2023 11:29:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbjEEJ26 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 May 2023 05:28:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231742AbjEEJ2j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 May 2023 05:28:39 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 380611A10B
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 02:28:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id AD43063CB3
        for <linux-kernel@vger.kernel.org>; Fri,  5 May 2023 09:28:34 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 37E38C433D2;
        Fri,  5 May 2023 09:28:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1683278914;
        bh=1RAXc0NiBF7f+OxPfJ6Q3iIY0ISS03O5QOmWMYZ+Rxk=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lp9dhKV7U+yAXz8XoM5uYwnqkHMpOJNX4AafF2rX6XK9yCWv+doTi4UXb7tvPuA10
         KNpEYJcc5CUUlgK03TE5D+xnA6DFAISKGJiyGMQ1fIpHDx0WtWbMiILEi9dCKltMfE
         56Za1I3RJr7hcZUswM+W3tU6MFowUECKSjxGFMjKiu79cHbLzMhQu5pfyeCN2+3JP9
         e1kWLDtSmwvSBYQ1amkgCeE+wBlNORJn4wpB/ZX/9DneqFgbaNLwEn5mmAucnMZ1cr
         lDtHvKC5USXt8j2jaM4vXqNiPYskuLsmL2dzeUEZQbIx4sswbzPYNHvVjz8f6Y2FF7
         Z2swNdODgi6JA==
Date:   Fri, 5 May 2023 14:58:29 +0530
From:   Vinod Koul <vkoul@kernel.org>
To:     Tom Rix <trix@redhat.com>
Cc:     chunkuang.hu@kernel.org, p.zabel@pengutronix.de,
        chunfeng.yun@mediatek.com, kishon@kernel.org,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com,
        nathan@kernel.org, ndesaulniers@google.com, granquet@baylibre.com,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org,
        linux-phy@lists.infradead.org, linux-kernel@vger.kernel.org,
        llvm@lists.linux.dev
Subject: Re: [PATCH] phy: mediatek: fix returning garbage
Message-ID: <ZFTMPWp8LhwA9uHz@matsya>
References: <20230414122253.3171524-1-trix@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20230414122253.3171524-1-trix@redhat.com>
X-Spam-Status: No, score=-7.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14-04-23, 08:22, Tom Rix wrote:
> clang reports
> drivers/phy/mediatek/phy-mtk-hdmi-mt8195.c:298:6: error: variable
>   'ret' is uninitialized when used here [-Werror,-Wuninitialized]
>         if (ret)
>             ^~~
> ret should have been set by the preceding call to mtk_hdmi_pll_set_hw.

I have applied "phy: mediatek: hdmi: mt8195: fix uninitialized variable
usage in pll_calc"
-- 
~Vinod
