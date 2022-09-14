Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CAE315B829A
	for <lists+linux-kernel@lfdr.de>; Wed, 14 Sep 2022 10:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiINIEp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 14 Sep 2022 04:04:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46596 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230442AbiINIED (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 14 Sep 2022 04:04:03 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFBC872FF5;
        Wed, 14 Sep 2022 01:03:24 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 32B096601FF1;
        Wed, 14 Sep 2022 09:03:23 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1663142603;
        bh=TITOuthHNLGkMHxvtBcpAKptZhyxFjhWVWDdbx8f6zM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=VEJzKu+ubtFGsd5IhUiXO7bzvBSuGuepfJ4V0OMjc5+D9yiuNk6wNVa7IggUl3+oo
         gB2QLf+t4rk0uzjX+EsbOXQ4y+4LT6bgoHG9pD0B6U3cA/CZyTiT8msaXkEQX1MOhY
         GRDDlUahzVA8IjMyIfJ7A9bfsC3Is9ABewpB2H+N5YUb3wdrfhxErNGcMnOnYSkZAM
         JksNOSdBPHDJCBowo/wejdGYw4hUiUsQmoVhXVNNRzU2PKmO8JmwqEbFP9EMjv8kNB
         iKGr5iaGD0Xj21Xe7dSqmjkbmEBEOET4caFSxlAUwnwvetRWqL8fUd32Frf+JgCQh+
         Ox5rVlzYWCYXw==
Message-ID: <69b50512-4958-8233-cd6d-4850bd5c5fcf@collabora.com>
Date:   Wed, 14 Sep 2022 10:03:20 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3] Input: mtk-pmic-keys - Add support for MT6331 PMIC
 keys
Content-Language: en-US
To:     Dmitry Torokhov <dmitry.torokhov@gmail.com>
Cc:     matthias.bgg@gmail.com, mkorpershoek@baylibre.com,
        linux-input@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20220913123941.385349-1-angelogioacchino.delregno@collabora.com>
 <YyC1zRlf+AUSFKnv@google.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <YyC1zRlf+AUSFKnv@google.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/09/22 18:54, Dmitry Torokhov ha scritto:
> On Tue, Sep 13, 2022 at 02:39:41PM +0200, AngeloGioacchino Del Regno wrote:
>> Add support for PMIC Keys of the MT6331 PMIC.
>>
>> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
>> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>
> 
> Applied, thank you. But we also need to add the compatible to the list
> in Documentation/devicetree/bindings/input/mtk-pmic-keys.txt
> 
> Thanks.
> 

Right. Sending a commit for that asap.

Thank you!
Angelo
