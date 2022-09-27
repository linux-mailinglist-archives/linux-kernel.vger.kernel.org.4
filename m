Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B8825EBFF3
	for <lists+linux-kernel@lfdr.de>; Tue, 27 Sep 2022 12:40:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiI0KkS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 27 Sep 2022 06:40:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231462AbiI0KkI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 27 Sep 2022 06:40:08 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1ECF3A6C3C;
        Tue, 27 Sep 2022 03:40:02 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 3C00C660225F;
        Tue, 27 Sep 2022 11:40:01 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664275201;
        bh=nZySNIOSSCHQniyQM0ZF2KCCHyUbR8adLdjAyM2pNus=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=N2gvBzgoKqiDwhjGkqJL/lQwjftXO4SMlBxA7tI7+nAxVphpicb9eYLAf9RtN0HGA
         kJQNHjTOcomqHrLboHsKAjt0qbZ6GsaaxtUo2PV6iZDEN1F4NPMQemjgBIXGbwM/D8
         goszDPQhWBRwKQxZml8shk21lAhyOJQ1ZlwF2SDnieYHqxvwz39U29fqfttFZNQaVG
         0O+GVJsVdxFFfmPiQuXObSFmDClleIxVHFMgZte7vBh4rU9jUFN0wdQt9imd3j/2Wj
         jCiW7PhiATybdkBadXx/he+7sV2Ci2RD7KZvNj44gww7gY7wi6QRMeXZQVALALlluS
         8S282qw5ufNlQ==
Message-ID: <48eac669-a407-e673-93fc-c7e6ef15110a@collabora.com>
Date:   Tue, 27 Sep 2022 12:39:59 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 1/6] clk: mediatek: fix unregister function in
 mtk_clk_register_dividers cleanup
Content-Language: en-US
To:     Chen-Yu Tsai <wenst@chromium.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     Matthias Brugger <matthias.bgg@gmail.com>,
        Miles Chen <miles.chen@mediatek.com>,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220926102523.2367530-1-wenst@chromium.org>
 <20220926102523.2367530-2-wenst@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220926102523.2367530-2-wenst@chromium.org>
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
> When the cleanup paths for the various clk register APIs in the MediaTek
> clk library were added, the one in the dividers type used the wrong type
> of unregister function. This would result in incorrect dereferencing of
> the clk pointer and freeing of invalid pointers.
> 
> Fix this by switching to the correct type of clk unregistration call.
> 
> Fixes: 3c3ba2ab0226 ("clk: mediatek: mtk: Implement error handling in register APIs")
> Signed-off-by: Chen-Yu Tsai <wenst@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


