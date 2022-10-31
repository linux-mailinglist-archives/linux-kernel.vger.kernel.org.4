Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB3A1613860
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Oct 2022 14:49:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230515AbiJaNtd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Oct 2022 09:49:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231153AbiJaNtb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Oct 2022 09:49:31 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECBEA7679;
        Mon, 31 Oct 2022 06:49:30 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id AC9BB6602253;
        Mon, 31 Oct 2022 13:49:28 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1667224169;
        bh=1CjDirYTveyInAKG0RQWqvIdW7a/AeUnGrEqY2Utiws=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=nA/Q+Sp2imNv4fxfZ/8CkIieGZNWmDpQT7s7l69lK6HIcn9v18xnHcI8h3ctbuHXv
         RqZC9bQJGr8LEnitwh1/CoQQL1jrxdPIWUnqaTMwG6UAk5FH2MzWPFu2Z2SmefTKvV
         Wc578sIxIrI9+D0oUJGo8fM+9CDWgrC8+gx7jy2Ctva1slyeikphBmMjUgrGTTHwGG
         HGLX/KnM7b2QQn/Y4yRiSw7M2hUUUB6/19hZKzn5Q+18knP0dzdr6yeNKc+ZGfovE+
         7gGSbGZCK+PcRY9DjYlFCnhvtUkF5AvStKLlp3Vq5u1mn+DaSGN5VXPKUEBuJpIFK7
         29qzcCexoVc3w==
Message-ID: <e0d37670-cb88-3a20-5230-9f14411edec1@collabora.com>
Date:   Mon, 31 Oct 2022 14:49:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 1/2] dt-bingings: gce: add gce header file for mt8188
Content-Language: en-US
To:     "Elvis.Wang" <Elvis.Wang@mediatek.com>,
        Jassi Brar <jassisinghbrar@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Houlong Wei <houlong.wei@mediatek.com>,
        "jason-jh . lin" <jason-jh.lin@mediatek.com>,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Bo-Chen Chen <rex-bc.chen@mediatek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20221029105017.20734-1-Elvis.Wang@mediatek.com>
 <20221029105017.20734-2-Elvis.Wang@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221029105017.20734-2-Elvis.Wang@mediatek.com>
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

Il 29/10/22 12:50, Elvis.Wang ha scritto:
> From: Elvis Wang <Elvis.Wang@mediatek.com>
> 
> add gce header file to define the gce thread priority, gce subsys id,
>   event and constant for mt8188.
> v2 - use vendor in filename, use Dual license.
> 
> Signed-off-by: Elvis Wang <Elvis.Wang@mediatek.com>
> Reviewed-by: Bo-Chen Chen <rex-bc.chen@mediatek.com>
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> 
> Thanks for the reviews, I have fixed them.

I can't see where/when Krzysztof gave you his R-b tag. Drop it.

Also, please fix the typo in the commit title. s/bingings/bindings/g.

Regards,
Angelo

