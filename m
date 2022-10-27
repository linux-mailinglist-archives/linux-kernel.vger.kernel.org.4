Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D130460F1C8
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:05:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234677AbiJ0IFN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:05:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233785AbiJ0IFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:05:06 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD7152FFE7;
        Thu, 27 Oct 2022 01:05:02 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id E5E8C66028BE;
        Thu, 27 Oct 2022 09:05:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666857901;
        bh=+smk67yhakV3hxipjrUTxVzYtY9GIM7JZQJ3ATTLcC4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=fZyAlKQ9ZfkMh7FjaFL7A0bmOftuz1Hsmk/Hsx363FPFZHFRcuuylkKfKH1uRhy4U
         M9c0lJm/xckvYQ/UdNlwWx1+FHx0mPKmXLdJkR9NJLy7B+4bCs5+doTLjUgbqfCrMq
         VM9dThe+A38pfRr2zAr7rdr93yZCqFFo0Vsg/pnDifwROdlvaPESbFtQ+n105OfNAs
         FIwJaVxvPuBP0ffeMs8Suz2uIGxSab1CPa8buiY7Uy6/I2yh8eaLPg7V2zWkbc96+v
         YQO72qEr1VOU8voxRXja4sPz2zjg0x47pcf6b4bm1z9NMVCI4odbrH7nA9X5uHztFi
         TzyMjTOfHDGHQ==
Message-ID: <bc89b373-8ece-8d58-6ab4-3e474d3265d8@collabora.com>
Date:   Thu, 27 Oct 2022 10:04:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH] arm64: dts: mt7986: fix trng node name
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-arm-kernel@lists.infradead.org
References: <20221026085144.107430-1-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221026085144.107430-1-linux@fw-web.de>
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

Il 26/10/22 10:51, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> Binding requires node name to be rng not trng:
> 
> trng@1020f000: $nodename:0: 'trng@1020f000' does not match '^rng@[0-9a-f]+$'
> 
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Please add:

Fixes: 50137c150f5f ("arm64: dts: mediatek: add basic mt7986 support")

After which,
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>

