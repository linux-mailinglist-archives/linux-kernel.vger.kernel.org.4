Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BD0F360C92A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 11:59:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230327AbiJYJ7x (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 05:59:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231744AbiJYJ6f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 05:58:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E916318B4B6;
        Tue, 25 Oct 2022 02:53:26 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id B92A5660239C;
        Tue, 25 Oct 2022 10:53:24 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666691605;
        bh=7sqWmlrQ0eJozSQq6glqhBf0BoFUn4lafxzq4xWkqCM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=BvwZaP3mClff5CQ8gv7AHVuMSW738U7Wv1esLQ5GFtk5hijaoBWAxbLdGKYxSlxLe
         9Yqk7F56MckdgQVReydedmjjdbm61FP93GyqhzgBm915wP87IOeegeEkcHeKYuRbF0
         OZz3fr9LBOvFhrrFy0N83w9/2UayfTTT7kHCO0n9bG/1i6NqmDb5/uNwz4YiPkX1na
         BEDIHHYdA9EFC+ha03d4Dqgvy8r7AonurlLpc0s8YGlta3jISPVATO6KVTQ0SyesBZ
         QJJ/KQooeXKA3lTSnQ4TzKmqP7ikkRWem/aE5lRrcG/YuRNdTjy/Jsu32L9CWzBXRW
         jGOk6nHInqKuQ==
Message-ID: <8e7c2a65-0be2-fdb9-6824-87d8e83e8a5d@collabora.com>
Date:   Tue, 25 Oct 2022 11:53:22 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 2/3] soc: mediatek: pwrap: add support for sys & tmr
 clocks
To:     Fadwa CHIBY <fchiby@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        "Zhiyong . Tao" <zhiyong.tao@mediatek.com>
Cc:     Fabien Parent <fparent@baylibre.com>,
        Sen Chu <sen.chu@mediatek.com>, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20221024131544.31219-1-fchiby@baylibre.com>
 <20221024131544.31219-3-fchiby@baylibre.com>
Content-Language: en-US
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221024131544.31219-3-fchiby@baylibre.com>
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

Il 24/10/22 15:15, Fadwa CHIBY ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> MT8365 requires an extra 2 clocks to be enabled to behave correctly.
> Add support these 2 clocks, they are made optional since they seem to
> be present only on MT8365.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Fadwa CHIBY <fchiby@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


