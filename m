Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 422C76E0E6D
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Apr 2023 15:20:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229877AbjDMNUN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Apr 2023 09:20:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51008 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231190AbjDMNUK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Apr 2023 09:20:10 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0E84A24E;
        Thu, 13 Apr 2023 06:20:01 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id DBD726603218;
        Thu, 13 Apr 2023 14:19:59 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1681392000;
        bh=zyLNmnfNyceNKY5LBE9mhScILY9Dbz+FbeLmTMBp8cI=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cIUmClu7FHs9xjiZexEXmR0VU1d1P+tGwjVpRX4TWVwOZElm4SUn04vjhvZtr3nB2
         RKOAO9gIeSpqAciIquSuCiAZvOIOQ5i6jBFabD15GZzyxsNO/ln1NrWMYBj5ibtT8i
         A5zp7xgt/QP21zGOovUYf24THw2egu5cLb6sEE8+p08GGgG/ilL0PaY6in2022QgPr
         BgENQvB70mbOOkS4n8eaW+DpvpqAxkNcZnkYOJYgVvWnhKJng0Uh49Yrn194vnEBgc
         UFfkNGDGELPO2TI5fNikL3WgDAGJIzpcbhIRHt6UAtXYtOHITGyFHVvy0cqXhEj4mh
         PzRyRSAaBpHdA==
Message-ID: <23dea66b-27cd-dbeb-37f5-ad9566e50962@collabora.com>
Date:   Thu, 13 Apr 2023 15:19:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH 6/7] ASoC: mediatek: mt8188: add bus protection
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        robh+dt@kernel.org, krzysztof.kozlowski+dt@linaro.org,
        matthias.bgg@gmail.com
Cc:     alsa-devel@alsa-project.org, linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <20230413104713.7174-1-trevor.wu@mediatek.com>
 <20230413104713.7174-7-trevor.wu@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230413104713.7174-7-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 13/04/23 12:47, Trevor Wu ha scritto:
> Add bus protection for reset controller.
> 
> Signed-off-by: Trevor Wu <trevor.wu@mediatek.com>

Is MT8188 the only SoC that will ever use bus protection for reset, now and
in the future?

...otherwise, I think that the best solution here would be to implement that
into the reset controller itself.

Regards,
Angelo
