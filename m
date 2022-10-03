Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E73535F2FBE
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 13:38:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229886AbiJCLip (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 07:38:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229851AbiJCLim (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 07:38:42 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3965F2314E
        for <linux-kernel@vger.kernel.org>; Mon,  3 Oct 2022 04:38:41 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id EAB886602045;
        Mon,  3 Oct 2022 12:38:38 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664797119;
        bh=NhrwS4Jkzt4C7LwfgGSyg0vs/QLGg8vmZrzAYAY6HjY=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=R0+mA/ZlPbkCIhzaYKUoP/AaiZpjjg9cAdBupiug68wkwIUeO1c8bcnyAnKXG1zj3
         zO9PjZc4C9NtL/V7Kv2lTdBGBRDsFCf8XoVi/gnndTrKN0dOPXMWysOifLePyTIrpz
         dKPOQRvRmJSYGGO+5dYzmHUNJfU/sKIuvXb/nGwrliV83gXB+9e5o+JclD/C8IDqHb
         XeUi3idrPBECw+EpoRrK/TfqSWbMg6NvHdgxUMgp8JmCmHiuBc4kPjmkOPIB/fCU2K
         bdh1Hxj3/MMKP65UoRKpA6RPnhOgVXUC6EmAoIZKJ5yvNGZlQxKr7HnqKM4J4RFd9H
         osLH+y9YRGYwg==
Message-ID: <27115639-bfe4-4e8a-f557-57a26ccd042f@collabora.com>
Date:   Mon, 3 Oct 2022 13:38:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 2/2] drm/bridge: it6505: Add pre_enable/post_disable
 callback
Content-Language: en-US
To:     Pin-yen Lin <treapking@chromium.org>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>
Cc:     linux-kernel@vger.kernel.org, Hermes Wu <hermes.wu@ite.com.tw>,
        Allen Chen <allen.chen@ite.com.tw>,
        Hsin-Yi Wang <hsinyi@chromium.org>,
        dri-devel@lists.freedesktop.org
References: <20221003050335.1007931-1-treapking@chromium.org>
 <20221003050335.1007931-3-treapking@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221003050335.1007931-3-treapking@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/10/22 07:03, Pin-yen Lin ha scritto:
> Add atomic_pre_enable and atomic_post_disable callback to make sure the
> bridge is not powered off until atomic_post_disable is called. This
> prevents a power leakage when it6505 is powered off, but the upstream
> DRM bridge is still sending display signals.
> 
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Pin-yen Lin <treapking@chromium.org>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


