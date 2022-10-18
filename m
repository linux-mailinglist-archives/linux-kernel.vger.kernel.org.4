Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058CA602E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Oct 2022 16:35:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231593AbiJROfa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Oct 2022 10:35:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231542AbiJROfL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Oct 2022 10:35:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 68EDFC7879;
        Tue, 18 Oct 2022 07:35:10 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7AC0A6602387;
        Tue, 18 Oct 2022 15:35:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666103708;
        bh=68YbTYqOl/0rz+JrgfLKPEGUzM7uWWXCeoy4uvrLjFI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=DUWJyGrxQhsjjL3lESvpZUGccoLTKWVvN8t3SGt8NnFgsYwWPvPzh4CQ6dctU3bAK
         HT33kX7pSkST1IHmHAUMiht6mwwPz8tAf9jwgKWhJU9ELHe61ZogxyyHttHYcm23t1
         TjMG6GhMawr1/M+SFrarQCI+DWiAskhV15eOVyZ/gIFU5aM1cTrPrFy28x7RLq8Grh
         6Lb1cQO3ypln/1q29RYcwPrOxJmr5ryC++K5kHyBsOPvf643ExXEtxiRQpN21PRGVa
         uzqq2CEs1VbFOuk06jLazomp4xVWYF1v1CP3H5Uh6oWMxJJCFyDkPEuBqUkVd6bC+R
         EjUGeHZrGa0PA==
Message-ID: <d6286188-c84e-83b0-0694-37999614b5ef@collabora.com>
Date:   Tue, 18 Oct 2022 16:35:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH 3/4] clk: Initialize max_rate in struct clk_rate_request
Content-Language: en-US
To:     Maxime Ripard <maxime@cerno.tech>, Stephen Boyd <sboyd@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>
Cc:     linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org
References: <20221018-clk-range-checks-fixes-v1-0-f3ef80518140@cerno.tech>
 <20221018-clk-range-checks-fixes-v1-3-f3ef80518140@cerno.tech>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221018-clk-range-checks-fixes-v1-3-f3ef80518140@cerno.tech>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 18/10/22 15:52, Maxime Ripard ha scritto:
> Since commit b46fd8dbe8ad ("clk: Zero the clk_rate_request structure"),
> the clk_core_init_rate_req() function clears the struct clk_rate_request
> passed as argument.
> 
> However, the default value for max_rate isn't 0 but ULONG_MAX, and we
> end up creating a clk_rate_request instance where the maximum rate is 0.
> 
> Let's initialize max_rate to ULONG_MAX properly.
> 
> Fixes: b46fd8dbe8ad ("clk: Zero the clk_rate_request structure")
> Signed-off-by: Maxime Ripard <maxime@cerno.tech>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


