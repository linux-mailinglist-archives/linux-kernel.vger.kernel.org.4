Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F151C679DA1
	for <lists+linux-kernel@lfdr.de>; Tue, 24 Jan 2023 16:37:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235244AbjAXPhC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 Jan 2023 10:37:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234850AbjAXPhB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Jan 2023 10:37:01 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38BA111E85;
        Tue, 24 Jan 2023 07:37:00 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AA527660086F;
        Tue, 24 Jan 2023 15:36:57 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1674574618;
        bh=DAN03XI3Z/7ojtABDu3TB1hWNZMR5YeSDQHCvDRNq80=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GiRx+1YdjIFZg5iyrkKgmtpRWNskZerRRgS9g/OrR+aMjCZCBgkmelY1QWkkKwftu
         tcharaRfMwvIY4Vx8q6REpt2ByZZQFkMgL6yNsXiJmQcmiWQhzzLuAEe2D2jXkTBQx
         De8lViH0eDkWE4G8ftFwzLsnfo5m1yruOIhrtXzTizzrWHsxWj1hGzMbwBS33DWkey
         DgwS7nUyUPLwEZ910/CUf50qVURaphvsnptVZCHaoaqE6nuIwlv6hzgP7Du8RJT4ME
         lMVkYl6Y4WXgti5pJdTri8n3xb4Tc4qXKUcLxCsMyE3jliI6swhxiRkxl5V6AlNJQz
         mMtD4+swARNCA==
Message-ID: <948d2c55-872d-ae28-bd94-af56d800e6f7@collabora.com>
Date:   Tue, 24 Jan 2023 16:36:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.0
Subject: Re: [PATCH v11 6/6] arm64/dts/mt8195: Add temperature mitigation
 threshold
Content-Language: en-US
To:     bchihi@baylibre.com, daniel.lezcano@linaro.org, rafael@kernel.org,
        amitk@kernel.org, rui.zhang@intel.com, matthias.bgg@gmail.com,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        rdunlap@infradead.org, ye.xingchen@zte.com.cn,
        p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230124131717.128660-1-bchihi@baylibre.com>
 <20230124131717.128660-7-bchihi@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230124131717.128660-7-bchihi@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 24/01/23 14:17, bchihi@baylibre.com ha scritto:
> From: Balsam CHIHI <bchihi@baylibre.com>
> 
> The mt8195 SoC has several hotspots around the CPUs. Specify the
> targeted temperature threshold when to apply the mitigation and define
> the associated cooling devices.
> 
> Signed-off-by: Balsam CHIHI <bchihi@baylibre.com>

Commit title prefix
- arm64: dts: mt8195:
or
- arm64: dts: mediatek: mt8195:

otherwise,

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

