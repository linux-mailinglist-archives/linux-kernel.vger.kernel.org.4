Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 701C8610CF2
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Oct 2022 11:20:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229983AbiJ1JUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Oct 2022 05:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229880AbiJ1JTu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Oct 2022 05:19:50 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BFE1F9FE;
        Fri, 28 Oct 2022 02:19:49 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A223D6602910;
        Fri, 28 Oct 2022 10:19:47 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666948788;
        bh=MNKmc+jPfq367ieSBuTkIUX4qDSmKXIkbZ7pVJckaLc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=hpfvFUxs8oHgXMLuos6AueL6YEwUamSpZvCTZhO65voxuEp1IhWkbqU8ltdifQ60y
         ByI1axyzcoEVuHsR0fgYNlKNAw/kZ7e7ChQ7zEawUBt6WUhAdSlLeGSemJ90F1Ea/o
         jVhOZ0KkG3nRro9pKlVLvQHlUgLDZPw/kgIb3fpzzjulWwgzfF722xeYE6joK5I5am
         8kO64ZOpedUV2GrpyE5nQqT/7psdOVtuFMGypaYuojNO+BQZV/yIy+EyLFf9E0u0qw
         gWGbTD0HrYTnE4QLDVUW/EUMGNvnLJtMNT0dNsC0kOJsJHtMDmAXuBa4NSnwCQraqZ
         cmoqyFcj3qp6Q==
Message-ID: <020d4a24-9522-c2ab-dd82-f1343b6761be@collabora.com>
Date:   Fri, 28 Oct 2022 11:19:45 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [RFC v2 1/7] arm64: dts: mt7986: harmonize device node order
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     devicetree@vger.kernel.org, Sam Shih <sam.shih@mediatek.com>,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20221026093650.110290-1-linux@fw-web.de>
 <20221026093650.110290-2-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221026093650.110290-2-linux@fw-web.de>
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

Il 26/10/22 11:36, Frank Wunderlich ha scritto:
> From: Sam Shih <sam.shih@mediatek.com>
> 
> This arrange device tree nodes in alphabetical order.
> 
> Signed-off-by: Sam Shih <sam.shih@mediatek.com>
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


