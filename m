Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A76FD5B8240
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 09:51:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230009AbiINHvB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 03:51:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229957AbiINHu6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 03:50:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EBBF42AEC;
        Wed, 14 Sep 2022 00:50:56 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 7A0526601F99;
        Wed, 14 Sep 2022 08:50:53 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663141854;
        bh=Hym1WPnQu+rJ0jePjiNMfQK8daaeMyb7rYGk5n5O/g0=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=ggQVBOHgbv+NxebDh3BTpsvKZhJcZ7O0tLF0ERDgZTt8gV4LjNmXR8MU2r0Fgsr3e
         s9vOhlqStzlzBTxG0/dnXTVyLu/royUM9Rz3v25wsvBULrSPNrflOnvJ2Lv8dZaiUg
         PQrnm1ZP/fhNValzboM6nXEanDAKBp93u/kOIkvQ4J56CXsW+uBToQGAZPuQ7lcayP
         oVsHLdSkPjS57zfcnAA4vhjh/hggt8WMQPkHrmTQkbWaVO9Rjokx6oXmOY7TwSKu+Q
         MV/65EYZlDCMF0OPDM6BSjQM0NqiZcuOAZRVtrHJ8d8OKIC+otG14JD3Ip//gLnKGm
         ygKuL+XyjonLg==
Message-ID: <739426eb-7381-d9e2-62e5-bdaf41d13821@collabora.com>
Date:   Wed, 14 Sep 2022 09:50:50 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 7/7] phy: phy-mtk-tphy: fix the phy type setting issue
Content-Language: en-US
To:     Chunfeng Yun <chunfeng.yun@mediatek.com>,
        Vinod Koul <vkoul@kernel.org>
Cc:     Kishon Vijay Abraham I <kishon@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-phy@lists.infradead.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Eddie Hung <eddie.hung@mediatek.com>
References: <20220914060746.10004-1-chunfeng.yun@mediatek.com>
 <20220914060746.10004-7-chunfeng.yun@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220914060746.10004-7-chunfeng.yun@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 14/09/22 08:07, Chunfeng Yun ha scritto:
> The PHY type is not set if the index is non zero, prepare type
> value according to the index, like as mask value.
> 
> Fixes: 39099a443358 ("phy: phy-mtk-tphy: support type switch by pericfg")
> Signed-off-by: Chunfeng Yun <chunfeng.yun@mediatek.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


