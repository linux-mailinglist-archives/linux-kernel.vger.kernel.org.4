Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C47560C9B0
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Oct 2022 12:15:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232077AbiJYKO7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Oct 2022 06:14:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231286AbiJYKOW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Oct 2022 06:14:22 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96BE918A528;
        Tue, 25 Oct 2022 03:07:02 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id D1C586600363;
        Tue, 25 Oct 2022 11:07:00 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1666692421;
        bh=UtlfTotMD2ki+X2wC6TKcrkIjBB6Q4W+mMUDKD795dM=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=b9KTrGEQpLIHDjuvIOvXFZJbHa0JO9S7ZX+EkKE7rbk3JBhjAg/65WD65Oat73Zip
         3yXfm7TZRmyQVDlCK0o8iQHjAepjQV/jok+m3F89uxQK4hsKBKWuF3ANcc/pf+COMu
         /yT2xQ2cHezIyeA56dwvvb1JJHkYYedEQGMOZtHMheUd62uv5kRAosSeewDJghC/1H
         SsVxZEDJdRh1UVINt+wndS/Z4bm5XmbAn6B9EfN0v1dnMvcGo7W2DEWP3jlpupGZG8
         D7fZ5NhzBqnxT8LRdNvY+2rKIke6f0QbEzla0vYUTBPS7lNUlgu4iqn80ark+UhUj7
         zB/cYc9jq43XQ==
Message-ID: <b1863393-0b73-ca44-12ae-567982b07f68@collabora.com>
Date:   Tue, 25 Oct 2022 12:06:58 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.3.3
Subject: Re: [PATCH v2 1/4] ASoC: dt-bindings: realtek,rt5682s: Add
 #sound-dai-cells
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>, Mark Brown <broonie@kernel.org>
Cc:     kernel@collabora.com, Derek Fang <derek.fang@realtek.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, alsa-devel@alsa-project.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20221024220015.1759428-1-nfraprado@collabora.com>
 <20221024220015.1759428-2-nfraprado@collabora.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221024220015.1759428-2-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 25/10/22 00:00, Nícolas F. R. A. Prado ha scritto:
> The rt5682s codec is a DAI provider with two interfaces - AIF1 and AIF2
> - and therefore should have a #sound-dai-cells property that is equal to
> 1. Add it.
> 
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


