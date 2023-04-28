Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A65856F14FA
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Apr 2023 12:07:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345933AbjD1KHh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Apr 2023 06:07:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345690AbjD1KHd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Apr 2023 06:07:33 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5D54210B
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 03:07:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECE2064236
        for <linux-kernel@vger.kernel.org>; Fri, 28 Apr 2023 10:07:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43E03C433EF;
        Fri, 28 Apr 2023 10:07:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1682676451;
        bh=pSpnOK2WwLPFrNdF3IRXqg6wNU38GrnXcVqArewr2jw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=YUgOq2cBkICpTr7XIhZSk8+62S/TpOVcjduqdZ6feiuQG34gtGaywOYufqx3DGCel
         WmDzhyS2lKVBfUK7aHlzVda9Ffpkmfps21FQ5OJnXr3IW3J+mePqVDc3L2xSDImSZC
         QDa6daj4tpyeGqINlW273TkeMXPMrjklrESo0VPYv9M/+BRp/CMgFpDClyjdx6lTXF
         nEz3y3ApVh8a/sg1mbKJsQpwEBehBD3h+WnlpGbrdSteqNWHvusu9lGOdIeYJ35u8x
         oFOa558wp9/A3xsJh3VgZvVHrCiXmz4TXrLDRKi4BWsl573rLaS095OY1hGuXdzakT
         46ym8QXiZazfw==
Message-ID: <b844828c-3f42-679d-e0c9-1c7f641a2a0b@kernel.org>
Date:   Fri, 28 Apr 2023 12:07:25 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.10.0
Subject: Re: [PATCH v3 1/7] clk: sunxi-ng: a64: export PLL_MIPI
Content-Language: en-US
To:     Roman Beranek <me@crly.cz>, Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>, David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Samuel Holland <samuel@sholland.org>
Cc:     Frank Oltmanns <frank@oltmanns.dev>,
        Icenowy Zheng <icenowy@aosc.io>, Ondrej Jirman <megi@xff.cz>,
        dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-sunxi@lists.linux.dev,
        linux-kernel@vger.kernel.org
References: <20230427091611.99044-1-me@crly.cz>
 <20230427091611.99044-2-me@crly.cz>
From:   Krzysztof Kozlowski <krzk@kernel.org>
In-Reply-To: <20230427091611.99044-2-me@crly.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/04/2023 11:16, Roman Beranek wrote:
> PLL_MIPI will be referenced as assigned parent to TCON0
> 
> Signed-off-by: Roman Beranek <me@crly.cz>
> ---
>  drivers/clk/sunxi-ng/ccu-sun50i-a64.h      | 4 +++-
>  include/dt-bindings/clock/sun50i-a64-ccu.h | 1 +

No, bindings are always separate patches.


Please use scripts/get_maintainers.pl to get a list of necessary people
and lists to CC.  It might happen, that command when run on an older
kernel, gives you outdated entries.  Therefore please be sure you base
your patches on recent Linux kernel.

Best regards,
Krzysztof

