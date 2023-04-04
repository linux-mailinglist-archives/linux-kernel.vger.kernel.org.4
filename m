Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 73FFC6D59C4
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Apr 2023 09:37:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233918AbjDDHhR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Apr 2023 03:37:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43478 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233701AbjDDHhQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Apr 2023 03:37:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDD04137;
        Tue,  4 Apr 2023 00:37:14 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 2BA50660314D;
        Tue,  4 Apr 2023 08:37:13 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680593833;
        bh=eFFQ1F/PY1fFTly4Z30damGqY2/c0LvuokJuel8ErXM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ZQkk6T+WkrVE75EnaD8+8Hd1pr0dv4q4srVJOPLq+EJNEt2Hv2Pz7LEDJpkNF91XY
         Ou73pV/ugQzcUQkpXKaZFhuQa7kJvfD6LHMZacZlw2G5XWdpp5jwgC7bcLeX5Ru1k0
         oFev8ptbj95nIPI+Ykuql9jhKuIavMSkXqmDSRryys1AOvKu25+gVLbh/+wSxlDnhe
         BlvfFpq4RPZq5A6a/CqfYlXq/WRHJ6a2ZVM8C6dAHjx3/yRkabnViM7bF1yyCJiPr2
         fQdfoqc0mLshvoo+cWeCm0plsSMHvEkntnbdGR1/nfE5LfWAhX0QfWKNpH/dmqrkQs
         tBxh2uYOdBZUQ==
Message-ID: <3fc61433-4264-b021-62ce-46c697df68ab@collabora.com>
Date:   Tue, 4 Apr 2023 09:37:10 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v2] clk: mediatek: Use right match table, include
 mod_devicetable
To:     Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        patches@lists.linux.dev,
        "Garmin . Chang" <Garmin.Chang@mediatek.com>,
        Chen-Yu Tsai <wenst@chromium.org>,
        kernel test robot <lkp@intel.com>
References: <20230404045636.1114141-1-sboyd@kernel.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230404045636.1114141-1-sboyd@kernel.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/04/23 06:56, Stephen Boyd ha scritto:
> This is copy/pasta that breaks modular builds. Fix the match table to
> use the right pointer, or the right device table type. And while we're
> including the header, fix the order to be linux, dt-bindings, and
> finally local.
> 
> Cc: Garmin.Chang <Garmin.Chang@mediatek.com>
> Cc: Chen-Yu Tsai <wenst@chromium.org>
> Cc: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Fixes: f42b9e9a43e3 ("clk: mediatek: Add MT8188 wpesys clock support")
> Fixes: 0d2f2cefba64 ("clk: mediatek: Add MT8188 adsp clock support")
> Fixes: e4aaa60eae16 ("clk: mediatek: Add MT8188 vdosys0 clock support")
> Fixes: cfa4609f9bbe ("clk: mediatek: Add MT8188 vdosys1 clock support")
> Fixes: bb87c1109ce2 ("clk: mediatek: Add MT8188 vencsys clock support")
> Fixes: f42b9e9a43e3 ("clk: mediatek: Add MT8188 wpesys clock support")
> Reported-by: kernel test robot <lkp@intel.com>
> Link: https://lore.kernel.org/oe-kbuild-all/202304011039.UBDX1UOT-lkp@intel.com/
> Link: https://lore.kernel.org/oe-kbuild-all/202304020649.QO2HlpD5-lkp@intel.com/
> Link: https://lore.kernel.org/oe-kbuild-all/202304021055.WDhQPcoS-lkp@intel.com/
> Signed-off-by: Stephen Boyd <sboyd@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

