Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 70DAD60F1BF
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Oct 2022 10:02:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233850AbiJ0ICS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Oct 2022 04:02:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234755AbiJ0IB6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Oct 2022 04:01:58 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E313E070B;
        Thu, 27 Oct 2022 01:01:56 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id A561E66028BD;
        Thu, 27 Oct 2022 09:01:54 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666857715;
        bh=60an4lyuQrcFiwvQr7KjO4WvCnKliT3qbSJMBKCJ2hs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=WUhuwEY0sPYrVwvg5lheWsZAJQlO3d1syGPDWoZl9dogyrx6TBoM0WXDBnOlCrxtG
         0gv1eYbJeiIU5fX+Z5xcOB2EsxW6H1FamY0fg2k4UMpE7F4+Ra5INRwRCphYxz8eGc
         0HlOmZ5o9CpO+WCcfk8901ofU16LohU5N5NzBuMIzlJl+/u3F46E0jYunu5uDYSghx
         X0osKSjK2jYMgcUaWjgQZYzc3bt2ke2YHuZLm+gfDuYWYXJUKZFiybf4WqHqCD1ldG
         wCM0X2iIvYNyZQTRW6ZDzR8j0ac7WXCUFgPYw1WbEr045MvooFbMzvhLnTL8qMyie0
         vXJRm5zOaJjHA==
Message-ID: <e64ad829-be27-e1ff-e667-77a90596fb29@collabora.com>
Date:   Thu, 27 Oct 2022 10:01:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v5 5/6] arm64: dts: mt7622: drop r_smpl property from mmc
 node
Content-Language: en-US
To:     Frank Wunderlich <linux@fw-web.de>,
        linux-mediatek@lists.infradead.org
Cc:     devicetree@vger.kernel.org, Ulf Hansson <ulf.hansson@linaro.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Sam Shih <Sam.Shih@mediatek.com>, linux-mmc@vger.kernel.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Chaotian Jing <chaotian.jing@mediatek.com>
References: <20221025132953.81286-1-linux@fw-web.de>
 <20221025132953.81286-6-linux@fw-web.de>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221025132953.81286-6-linux@fw-web.de>
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

Il 25/10/22 15:29, Frank Wunderlich ha scritto:
> From: Frank Wunderlich <frank-w@public-files.de>
> 
> This property is not defined in binding and driver.
> 
> Fixes: 2c002a3049f7 ("arm64: dts: mt7622: add mmc related device nodes")
> Fixes: 0b6286dd96c0 ("arm64: dts: mt7622: add bananapi BPI-R64 board")
> Signed-off-by: Frank Wunderlich <frank-w@public-files.de>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


