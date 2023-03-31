Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F7F66D1CA6
	for <lists+linux-kernel@lfdr.de>; Fri, 31 Mar 2023 11:39:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231350AbjCaJjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 31 Mar 2023 05:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52958 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232282AbjCaJiw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Mar 2023 05:38:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 347B24C39;
        Fri, 31 Mar 2023 02:38:46 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C991EB82DCD;
        Fri, 31 Mar 2023 09:38:44 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B8F11C4339B;
        Fri, 31 Mar 2023 09:38:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1680255523;
        bh=7KUp7Ii7UolpTbxPnQfkQEoaGhYSWLfitDHJhVWIiHI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=g9+/G9yPuGAHET4A+SaouSqLdhpcDUXJ+Hv9Ln4iWbO/jl632XwLTTJM8iGxDBIRU
         YfQq2oDefpka4gZ57/cRM+ikBWpILzrxG0bNISIEdLcIrOi4VcdRPBe/1LgBrk/44j
         kZPQsxqTma/3McKQf12KrUvEho+z9A/ySWFEdNXwSU7vMXvtILwZcXPBWbJ84eSE5T
         ZhM4RzB8y/IkXl7CoB86MfFyWDiaS2gHibF2wLCv7odv4uwb8iEN6J1lNtuN1R0SiQ
         fYe1CdShdVbWdOCyq+DiaifItxZk6szblMAGU4EZpSfa48EYgdEnnRwvmb7Yy3uIPD
         y6EyxQ4+RyLMw==
Message-ID: <1aaf91c6-7bfb-c615-69ef-e7e538f2cc7f@kernel.org>
Date:   Fri, 31 Mar 2023 11:38:37 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.0
Subject: Re: [PATCH 2/3] clk: imx: imx8mp: Add LDB root clock
Content-Language: en-US
To:     "Peng Fan (OSS)" <peng.fan@oss.nxp.com>, abelvesa@kernel.org,
        abel.vesa@linaro.org, mturquette@baylibre.com, sboyd@kernel.org,
        shawnguo@kernel.org, s.hauer@pengutronix.de, kernel@pengutronix.de,
        festevam@gmail.com
Cc:     linux-imx@nxp.com, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Liu Ying <victor.liu@nxp.com>, Sandor Yu <Sandor.yu@nxp.com>,
        Dong Aisheng <aisheng.dong@nxp.com>,
        Peng Fan <peng.fan@nxp.com>
References: <20230331071801.2483686-1-peng.fan@oss.nxp.com>
 <20230331071801.2483686-2-peng.fan@oss.nxp.com>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230331071801.2483686-2-peng.fan@oss.nxp.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 31/03/2023 09:18, Peng Fan (OSS) wrote:
> From: Liu Ying <victor.liu@nxp.com>

Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

> 
> This patch adds "media_ldb_root_clk" clock for
> the LDB in the MEDIAMIX subsystem.
> 
> Reviewed-by: Sandor Yu <Sandor.yu@nxp.com>
> Signed-off-by: Liu Ying <victor.liu@nxp.com>
> Signed-off-by: Dong Aisheng <aisheng.dong@nxp.com>
> Signed-off-by: Peng Fan <peng.fan@nxp.com>
> ---
>  drivers/clk/imx/clk-imx8mp.c             | 1 +
>  include/dt-bindings/clock/imx8mp-clock.h | 4 ++--

NAK, bindings are always separate patches.



Best regards,
Krzysztof

