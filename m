Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B36CE5EBFF4
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:40:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231607AbiI0KkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231701AbiI0KkJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:40:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8606A4B91;
        Tue, 27 Sep 2022 03:40:06 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 74A576602265;
        Tue, 27 Sep 2022 11:40:04 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664275205;
        bh=ZVTrgfVA6sTZU9HqQ1ocNSZIePUdEQRqC2ZzuBqpb8Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nLjPXmnIv71cfIlYfmfSSqFkItZT03l4nW9NWFiRq66WZqzwzH//oFLt14mBVa3KJ
         oqyyYYhRn32kd+Rhypu/4iRQHXV+UWdVwMSRcEKZZkI2YGroulJlnWlln4xBUhzLnP
         SemlxvUSvj4jXZy9fa26lSr5S/TNtwSc6FoK6wC+S7aSgAT0t+e8lK68YMaogYDaYF
         fyTDZgrPCR3nYNCwl3z7gWEG2ZRtYjcEAHX4rZP3Ed8h1gYbzKFgqzkSQcFzb7M21E
         GrgqCsmOWWDWqAC4sIKd+zcoOkQXbQcXHIvY3CopCSlkGWAMW8Ciq2QgIgqfHQZk4a
         yRFSIbPfy9KIA==
Message-ID: <7806b7f1-a216-9a83-f598-b6a92e9f7a9b@collabora.com>
Date:   Tue, 27 Sep 2022 12:40:01 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 2/6] clk: mediatek: Migrate remaining clk_unregister_*()
 to clk_hw_unregister_*()
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220926102523.2367530-1-wenst@chromium.org>
 <20220926102523.2367530-3-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220926102523.2367530-3-wenst@chromium.org>
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
> During the previous |struct clk| to |struct clk_hw| clk provider API
> migration in commit 6f691a586296 ("clk: mediatek: Switch to clk_hw
> provider APIs"), a few clk_unregister_*() calls were missed.
> 
> Migrate the remaining ones to the |struct clk_hw| provider API, i.e.
> change clk_unregister_*() to clk_hw_unregister_*().
> 
> Fixes: 6f691a586296 ("clk: mediatek: Switch to clk_hw provider APIs")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


