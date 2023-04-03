Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 283396D446F
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Apr 2023 14:31:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232204AbjDCMbr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Apr 2023 08:31:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231285AbjDCMbl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Apr 2023 08:31:41 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35BF03AA9;
        Mon,  3 Apr 2023 05:31:41 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 670616601F5E;
        Mon,  3 Apr 2023 13:31:39 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680525100;
        bh=+/Opls/14IOqe9+pE7OeA+flxTCMKU/LEO/pt7JmB5Y=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=PmpMcp7RPLYRtEkGzTGqIG1IH2vDwMO4XyKF/Vz7rq/Jii7ROjEFDQOmRJGu+3oq/
         oCcZlmckUNSXq41yHZRxj9ZpwzsHqkt6lg6qs4XH0IPGPzqyYFVWU3kY/GFEQ7cS/J
         u0lofYK7Emar7fJ7jOIF4GwEFbNvLFgBirfb2zzRE3JuuFR5pJqrTluKgYMXvcG8UT
         6hPW5o0RXsyKpu3dyq5qOtczz0uHaMRQpYJkeL1HLm8ZSNTTN1xDcaUNAruvJCrGtX
         2yTYeYpXRJbjMq+EBhV/g4ulplm/Z/yeCTijQybLY3jUw0+GKL9s9yvrg8SQINhJgO
         sqeVn7bslBNDg==
Message-ID: <3fdc083c-4ed6-1394-d789-47d9a1acc6b4@collabora.com>
Date:   Mon, 3 Apr 2023 14:31:36 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 2/7] usb: mtu3: use boolean return value
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-usb@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Eddie Hung <eddie.hung@mediatek.com>,
        Tianping Fang <tianping.fang@mediatek.com>
References: <20230403025230.25035-1-chunfeng.yun@mediatek.com>
 <20230403025230.25035-2-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230403025230.25035-2-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.5 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/04/23 04:52, Chunfeng Yun ha scritto:
> Prefer to use boolean value due to gpd_ring_empty() return true or false.
> See "16) Function return values and names" in coding-style.rst
> 
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

