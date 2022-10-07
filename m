Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DA805F75AD
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 10:56:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229587AbiJGI4q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 04:56:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229581AbiJGI4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 04:56:39 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97298FE76C;
        Fri,  7 Oct 2022 01:56:29 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 9CBA5660232B;
        Fri,  7 Oct 2022 09:56:05 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665132966;
        bh=rFxYZyUtvj4MLdJeshUQuH4lajevpz3SyEUSdmgqLIU=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=akWRnw9U+y68ThkuOQxMMw4GtD5nOi+fTgi0Ngd0w4BLy5sLx8oJmZAIgbDek2lpH
         SVUjv95Cmn9Wt8NiEDz/VWMX4tXHG9kRBQEk02dmw/ayz4fmS9TSoXPXy9OxCiOxUG
         0Wp/movsiX5hb863I6Xni1rgfrID4CC2aIoL8bCGd32aTCITZqPis8q2nhmHUlL03X
         AKDp9YaHUIt85eoN4ngvwkw0+zD/80KcLO8900pKoSbQOXFcz4L/bnvDc7VjbHLopv
         KdIZgTtrbsC+iG8mAvV+othEY0PFoFNCodVLNfUCQnGpLCY2eIaLCUR18ZJu49CXF3
         lPDVbs9tq6/Uw==
Message-ID: <76dadecb-b396-a7bd-1dea-eb6cabc9647f@collabora.com>
Date:   Fri, 7 Oct 2022 10:56:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 1/5] arm64: dts: mediatek: asurada: Add display
 regulators
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     kernel@collabora.com, Chen-Yu Tsai <wenst@chromium.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20221006212528.103790-1-nfraprado@collabora.com>
 <20221006212528.103790-2-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221006212528.103790-2-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/10/22 23:25, Nícolas F. R. A. Prado ha scritto:
> Add the regulators present on the Asurada platform that are used to
> power the internal and external displays.
> 
> Tested-by: Chen-Yu Tsai <wenst@chromium.org>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

> ---
> 
> Changes in v2:
> - Added missing vin-supply to regulators
> - Removed min/max-microvolt from regulators that are simple switches
> 

