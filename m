Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 27A1060CB93
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 14:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231379AbiJYMNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 08:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231611AbiJYMNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 08:13:11 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3212310C4CC;
        Tue, 25 Oct 2022 05:13:11 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DADE46602319;
        Tue, 25 Oct 2022 13:13:08 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666699989;
        bh=V5vR6tFJk/ZT4RHAKfHFB8pFtjxpIqRPWBt7oLYvccI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=eZHwfh6PCcjVNZ6qg7zfvUWBXt3G7cyPp0wpOiiodk/Qi/s/jauEeXSNRGbt7f5FP
         Ccns2R2UAoh4wohieaIQEr+jk5Ew8dpwvq/svysJsGASD2ejzoqLY6qQRKduArhTlV
         D+dsoY59iYlYTzi8jZnmCoh73eqqqf6x4/xIP4FwqM1+4ahQJTvWPQH33VwcMLdPvy
         +VtY4mwfeqwnVlmCGWugIUcPpzBNgN2XxrMxj19FT3OBOPl7OUzcr3BH/fAh8hMCKs
         fL8HUQO+KJaX3n4HNEq9PnxZgO8uTZr+P+EadulFNirjG5jsbC/NNOrGiBR2nij/Qk
         DdRQoOkLDFurA==
Message-ID: <e5de6069-39f7-c938-d271-ccb4cb384333@collabora.com>
Date:   Tue, 25 Oct 2022 14:13:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v4 4/6] arm64: dts: mt8183: drop drv-type from mmc-node
Content-Language: en-US
To:     "Frank Wunderlich (linux)" <linux@fw-web.de>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Sam Shih <Sam.Shih@mediatek.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>
References: <20221025074238.18136-1-linux@fw-web.de>
 <20221025074238.18136-5-linux@fw-web.de>
 <3b366319-5257-a536-4dba-919cb5fdf477@collabora.com>
 <5ccd67c45c9f384296bfd1f19dd019a1@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <5ccd67c45c9f384296bfd1f19dd019a1@fw-web.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/10/22 13:33, Frank Wunderlich (linux) ha scritto:
> Am 2022-10-25 12:52, schrieb AngeloGioacchino Del Regno:
>> Il 25/10/22 09:42, Frank Wunderlich ha scritto:
>>> From: Frank Wunderlich <frank-w@public-files.de>
>>>
>>> This property is not defined in binding and driver.
>>>
>>> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>
>>
>> This commit needs a Fixes tag :-)
> 
> i hope it is ok adding it here instead of resend full series...
> 
> Fixes: cd894e274b74 ("arm64: dts: mt8183: Add krane-sku176 board")
> 
> regards Frank

Please send a v5 with the appropriate Fixes tags.

Regards,
Angelo
