Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 31EE35B5879
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:31:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230249AbiILKbg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:31:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230272AbiILKbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:31:16 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9C86C3C8F9
        for <linux-kernel@vger.kernel.org>; Mon, 12 Sep 2022 03:30:51 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 266576601FD2;
        Mon, 12 Sep 2022 11:30:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662978623;
        bh=VxPiZ9dZ9acjfZPEAOYMYeBii8gbW8AfBShA+LhDdYg=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=AiDbBEUo0Aem90pzTbMOxyzSd1FzyRk4uKl2qd8lphZ8NVamc0TCZI+5+bCXU2yHz
         GYOmZtPgqTtiNkUT2zzAdIT442Ke+904r76ELYMLVusyAAa8Y+acEeMGaT6QKI165w
         YI1bo4a54Ljd/x8vDAoIQqiuYPiubDAeUm32sp1/j8dIP9LS88sfnS2slucMj3a4dq
         /FJENgOKhd7tWltLw74VWQPixXRX+TTTs9cykX+tkkjALtxfQm5hfUIIa6mxE8jTej
         kRisyfrmCToyMQ5muwNWodbxE9M82d0vD3KxYTP60HfQKFIiOsLF+OXE75jBQAxcix
         mYs46vwtbO8Qw==
Message-ID: <eb8173f6-74cb-3010-f1c2-5eac6939e1f7@collabora.com>
Date:   Mon, 12 Sep 2022 12:30:21 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] drm/bridge: it6505: use drm_debug_enabled() in
 it6505_debug_print()
Content-Language: en-US
To:     Hamza Mahfooz <someguy@effective-light.com>,
        linux-kernel@vger.kernel.org
Cc:     Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Hermes Wu <hermes.wu@ite.com.tw>,
        Allen Chen <allen.chen@ite.com.tw>,
        dri-devel@lists.freedesktop.org
References: <20220910224816.15058-1-someguy@effective-light.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220910224816.15058-1-someguy@effective-light.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/09/22 00:48, Hamza Mahfooz ha scritto:
> As made mention of in commit 9f0ac028410f ("drm/print: rename drm_debug
> to __drm_debug to discourage use"), we shouldn't explicitly refer to
> __drm_debug in this context. So, use drm_debug_enabled() instead.
> 
> Fixes: b5c84a9edcd4 ("drm/bridge: add it6505 driver")
> Signed-off-by: Hamza Mahfooz <someguy@effective-light.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


