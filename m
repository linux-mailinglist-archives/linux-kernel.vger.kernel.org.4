Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DD65EBFEB
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230366AbiI0Kjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229472AbiI0Kjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:39:45 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFB0C65657;
        Tue, 27 Sep 2022 03:39:43 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 36E09660225F;
        Tue, 27 Sep 2022 11:39:42 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664275182;
        bh=AMgtIGTha2E70GrYjihLiNaIG3QRYRtKKBHoiKsZNjc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L/0uEDggcWvhuV/c3BtHlYYGr0kpKy2WLah/QOfc1/HqQZlmdWM2W7x+Z9IPUOIEM
         AnZVGclmmYDXp7MNGGtEedys50vhtPUAkePCt3BDSLlKLigRE56vChVqHYaLxvz4/x
         6fEZB3yn9M3hWQ+JK2cAhXXuiA5B8+fbar8YYZiQODpkIPh+l2AWL8kEfXrelmqCxJ
         2gS8TS6h1w5uBYjNy+XzeuimPgHxzUr5w7GSfl0sUTJRkwNRvUgOH3BOpuQJVQFKOs
         ZkKgetUFPuZUR+bI8XMvxCC77jJHjU+EE0EyL7gxre/i+916dxmv/J0i9uubnLIGam
         GfSlTlrZfWN5Q==
Message-ID: <70c9375e-52f8-40a6-3fea-ba95fae16c99@collabora.com>
Date:   Tue, 27 Sep 2022 12:39:39 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 6/6] clk: mediatek: mt8192: Implement error handling in
 probe functions
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220926102523.2367530-1-wenst@chromium.org>
 <20220926102523.2367530-7-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220926102523.2367530-7-wenst@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 26/09/22 12:25, Chen-Yu Tsai ha scritto:
> This is similar to commit f3e690b00b86 ("clk: mediatek: mt8195:
> Implement error handling in probe functions").
> 
> Until now the mediatek clk driver library did not have any way to
> unregister clks, and so all drivers did not do proper cleanup in
> their error paths.
> 
> Now that the library does have APIs to unregister clks, use them
> in the error path of the probe functions for the mt8192 clk drivers
> to do proper cleanup.
> 
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

I can't give you my Reviewed-by on this patch only because of the comment
in patch [3/6] - anyway, LGTM.

Regards,
Angelo

