Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 394DA60F19B
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 09:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234104AbiJ0Hy7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 03:54:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234571AbiJ0Hyw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 03:54:52 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12AF812614;
        Thu, 27 Oct 2022 00:54:46 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 0B55A66028B1;
        Thu, 27 Oct 2022 08:54:44 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666857284;
        bh=4AZv7w+df7t6LyazsEk8UMNZGm+qs6IZs8p8gcdUhEk=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=Rvjbc8//r3Uy8VL1XCP1GVXyedyen79kMryE4U+CnopVdJzEBRay0HBT1twx+i/FS
         UNf0mAqVvu8tn4xRZKmmPkeGSg9LX3wiT5pS2FYjXsMjPUeqbG8TJ7YO0o97igWkhu
         hegcdL9mL3BYwK/rJRFmnfYSbGtnibxnUeiObheM/JGjL4p31kNPYCKZkgxfooy9/l
         gjA2gtvgvp7b+TZylAi1QphUi9XIrxPfWNi9+7Ll2SzrErAQ3h5Ox9kNRYrAPiHc6Y
         KhZz6Yz2lFtNI8A1EfI3p9pvsZA1YE7t0+1P+UE0aFCBZ8KJNLezC9p1qWv2xi8rUU
         mz04j7QQPjfug==
Message-ID: <e889728c-13e9-37f8-4d1a-e31332a39498@collabora.com>
Date:   Thu, 27 Oct 2022 09:54:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [RESEND v3 1/3] dt-bindings: watchdog: Add compatible for
 MediaTek MT8188
Content-Language: en-US
To:     Guenter Roeck <linux@roeck-us.net>,
        Runyang Chen <Runyang.Chen@mediatek.com>
Cc:     Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        nfraprado@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        linux-watchdog@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        "allen-kh.cheng" <allen-kh.cheng@mediatek.com>
References: <20221026063327.20037-1-Runyang.Chen@mediatek.com>
 <20221026063327.20037-2-Runyang.Chen@mediatek.com>
 <20221026152645.GA2946818@roeck-us.net>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221026152645.GA2946818@roeck-us.net>
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

Il 26/10/22 17:26, Guenter Roeck ha scritto:
> On Wed, Oct 26, 2022 at 02:33:25PM +0800, Runyang Chen wrote:
>> From: Runyang Chen <runyang.chen@mediatek.com>
>>
>> Add dt-binding documentation of watchdog for MediaTek MT8188 Soc
>>
>> Signed-off-by: Runyang Chen <runyang.chen@mediatek.com>
>> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
>> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> 
> This conflicts with the ongoing yaml conversion of this file
> which is still not accepted.
> 
> https://patchwork.kernel.org/project/linux-watchdog/patch/20221005113517.70628-4-angelogioacchino.delregno@collabora.com/
> 
> Nevertheless, I'll apply this series to my watchdog-next branch
> and assume that it will be included in the next version of the
> yaml conversion patch.
> 
> For my and Wim's reference:
> 
> Reviewed-by: Guenter Roeck <linux@roeck-us.net>
> 
> Thanks,
> Guenter
> 
Adding Allen to the Cc's to make him aware of that, as he took over the
mtk-wdt yaml conversion.
