Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D16D69C946
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Feb 2023 12:08:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231499AbjBTLIi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Feb 2023 06:08:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231481AbjBTLIN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Feb 2023 06:08:13 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DA3D9774;
        Mon, 20 Feb 2023 03:08:12 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 071296602135;
        Mon, 20 Feb 2023 11:08:10 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676891291;
        bh=3r7QiCwl4pq0MK/urg3yHiYgTcMD2IeavuKvvenUpcA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bM0XFAXxn9n9WA1u3UQW1epuxIWhI9BdumCBcEyGOrfj5Ix1V7Ec3ucH9HjXn1fcE
         SFlISHrs9BBBShNK8zLJt0iL7Tmqlp0DyPnE0nkcqi02tXMQOthDHm5TMuP0Rj5RWC
         N51S//d2gZnpm1Vra3ecmUbRAhX3/7UyD76IUWoPaUUHvFfb9MfApxn/x6ZBZAJdN6
         6cwqOcsT8sMrV7jFd+aJHS9eEuv6JWMu8MKb7zkbnROrHPemUsjccsCuIyfpO7ru/S
         L/4U0vhSg0QFqRgEHy0ht110iPQTRz9IWO+/oQjkFbNGZWE2m2twydCsa8AP1JasS2
         yhO3KwJV6r1tw==
Message-ID: <e77fe423-e40f-65bb-3fe4-43d692779259@collabora.com>
Date:   Mon, 20 Feb 2023 12:08:08 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH] arm64: dts: mediatek: mt8183: kukui: Add scp
 firmware-name
To:     Hsin-Yi Wang <hsinyi@chromium.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230220093343.3447381-1-hsinyi@chromium.org>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230220093343.3447381-1-hsinyi@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 20/02/23 10:33, Hsin-Yi Wang ha scritto:
> The upstream SCP firmware path is /lib/firmware/mediatek/mt8183/scp.img
> 
> Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


