Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F6D5697C41
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Feb 2023 13:50:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233395AbjBOMua (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Feb 2023 07:50:30 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36976 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233491AbjBOMu3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Feb 2023 07:50:29 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70317360BD;
        Wed, 15 Feb 2023 04:50:28 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 4B4B66602181;
        Wed, 15 Feb 2023 12:50:26 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1676465427;
        bh=qT7FVzm6XK8tCKeDe2rLup/JS7HhXYm37IBT1713P7Q=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=n5Sa5yQbLAyZlLdbKM0nuUTpSpAlmcoVgYTN741oN6XhBYAJQCZx5nFBDYoWjlIgN
         +rke1O1rvOQmxISnqxiIBqZxXPc1sKiTZN7Nau3n2ZWvImrHwvzJwzppGFNRzgAGqb
         J55j1iKJ431A/YAxH73wHTY4hNJsKiSC1fdqt2fc6pv+3szJ+pwD2fDflU0jwKVdhs
         ifYqw0aRdbyhjNW9K5ATM7UmUaKWg1OdSlZSqnxgNumB+Z3pKDe8+rPcM8LE/iAUE6
         2ZU7LbXCGQDc8cV3iGIThLAk8QJHS/zWnKM+qNv1MrYgdEPrHcpliFpNp+yhZw4bH6
         cuUvGIQ9DXObg==
Message-ID: <80c60f09-56eb-cb84-43f0-7b055ea4b32c@collabora.com>
Date:   Wed, 15 Feb 2023 13:50:23 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.2
Subject: Re: [PATCH v14 6/6] arm64: dts: mediatek: mt8195: Add temperature
 mitigation threshold
Content-Language: en-US
To:     Balsam CHIHI <bchihi@baylibre.com>, daniel.lezcano@linaro.org,
        rafael@kernel.org, amitk@kernel.org, rui.zhang@intel.com,
        matthias.bgg@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, rdunlap@infradead.org,
        ye.xingchen@zte.com.cn, p.zabel@pengutronix.de
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        khilman@baylibre.com, james.lo@mediatek.com,
        rex-bc.chen@mediatek.com
References: <20230209105628.50294-1-bchihi@baylibre.com>
 <20230209105628.50294-7-bchihi@baylibre.com>
 <CAGuA+oqOgprdu0dVcmB=qJd5HJjada3d8ZazMpoG-SBPizzuPQ@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAGuA+oqOgprdu0dVcmB=qJd5HJjada3d8ZazMpoG-SBPizzuPQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/02/23 15:43, Balsam CHIHI ha scritto:
> Hi Matthias, Angelo,
> 
> Would you please confirm if this patch can be applied?
> and, if it is the case, to which tree it will be applied?
> 
> Best regards,
> Balsam

I think it's fine to apply 5/6 and 6/6, as you're adding pre-Tjunction
max temperature - this is not board specific, but rather SoC-specific.
In reality it's practically the same for most SoCs, even.

Each board will define extensions (that are thermal envelope dependant)
to these "please-dont-burn-my-device" initial thresholds, but that's a
story for another day, and for other people anyway (including me).

Matthias, over to you!
