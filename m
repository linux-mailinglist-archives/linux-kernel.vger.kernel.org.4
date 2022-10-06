Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1DB925F6301
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 10:45:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231154AbiJFIpX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 04:45:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230061AbiJFIpR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 04:45:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 354DF691AA;
        Thu,  6 Oct 2022 01:45:14 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 23E9A66022F7;
        Thu,  6 Oct 2022 09:45:12 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665045912;
        bh=X4/9IulhjHFVhHll60QNhPFZXwjRhXzzVppJJbuC0Mw=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=H+2hXAwApRg3zxPc75Ezq4zsjll4PaFp0DmD8qPRFbmEiG/gALZkX9iJMVWra1f0E
         09XQ4GvzzO9gjTiVswhhN/tmNVmwdGaPGKDeDl8IcLgrdzABiRRdT2EvK0FxTrqLzH
         cNozNpttxZfM2s3kerR5TrZq9JTb7cADv0Nx/ywRiLpMI7Er6u9y7ilYu99u8HLTaB
         0GkfwWTWc/HA/68mUq6hlUljbBMLIpbDYKkr79/2ziM5fGiJ4F4hh6TVg+YYNdpNM8
         Z2xcskijPZrI9XQeunAP1m88gszPYaeXPfWPFKvkwY50Pe+fBYWenZ45Ciug19ULG1
         ef7nDyi7ImgRw==
Message-ID: <d9977d0a-95dc-fa66-f48d-cff2968d34d3@collabora.com>
Date:   Thu, 6 Oct 2022 10:45:09 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH 3/5] dt-bindings: watchdog: mediatek: Convert mtk-wdt to
 json-schema
Content-Language: en-US
To:     =?UTF-8?B?QWxsZW4tS0ggQ2hlbmcgKOeoi+WGoOWLsyk=?= 
        <Allen-KH.Cheng@mediatek.com>,
        "wim@linux-watchdog.org" <wim@linux-watchdog.org>,
        "krzysztof.kozlowski@linaro.org" <krzysztof.kozlowski@linaro.org>
Cc:     "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        "linux@roeck-us.net" <linux@roeck-us.net>,
        "linux-watchdog@vger.kernel.org" <linux-watchdog@vger.kernel.org>,
        =?UTF-8?B?U2VpeWEgV2FuZyAo546L6L+65ZCbKQ==?= 
        <seiya.wang@mediatek.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        =?UTF-8?B?VGluZ0hhbiBTaGVuICjmsojlu7fnv7Ap?= 
        <TingHan.Shen@mediatek.com>
References: <20221005113517.70628-1-angelogioacchino.delregno@collabora.com>
 <20221005113517.70628-4-angelogioacchino.delregno@collabora.com>
 <1f3ebf6f-117f-62a7-8e02-3e8a3bcf7e9f@linaro.org>
 <56aadffa-82be-f8ff-03d3-2a880b50ef49@collabora.com>
 <6b19843bf0fc6084552f8c71c9a16da21017f99d.camel@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <6b19843bf0fc6084552f8c71c9a16da21017f99d.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 06/10/22 10:43, Allen-KH Cheng (程冠勳) ha scritto:
> Hi Angelo,
> 
> I can send a new version with this series.
> 
> Thanks for help convert schema.
> 

That's perfect! I will wait for your new version then.

Thank you!
Angelo

