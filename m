Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DFFF563BBA8
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Nov 2022 09:31:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231127AbiK2Ibi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Nov 2022 03:31:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230339AbiK2Iap (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Nov 2022 03:30:45 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 40C3F59844;
        Tue, 29 Nov 2022 00:30:02 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 973A766023A1;
        Tue, 29 Nov 2022 08:29:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669710600;
        bh=XnYqiFVLP4BtH3oXv8+Wi85TZoEBQEB4dmv9jhrnXLo=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=GnSd9BQuynt5Ll+SAJX0Wv2Wp5gdL5erByXb769tHIfyJ6b7loqfpKNyFpYU87J9y
         /1Kfpa1zrUYHneQ93OPXC+Gxi2VmChmkr5Hex92ruzEzJJxe0arVP96XSuJS8tHNGk
         uXsl44HT6vYEOIxQxSQ8hT83Zdxw94bYxMaib4VIvueYMldCnqGuWeWNaRCBSZXt0g
         O9OJ6Vlke/xa7JT45ic9W+QZNOT0YAyZDHGV+kgZ9AyX4q80TI+kLargPaa4if4xV1
         wpiszhZuihW+JxoPLtcFarfp87jtsU/164769C2xCn0JKq2vnm0I4kXUxw+NnITV2R
         AuRpb2dmD6/hA==
Message-ID: <e30a76e7-3bb7-5e19-2bc1-ab8a0c67d73e@collabora.com>
Date:   Tue, 29 Nov 2022 09:29:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v3 3/7] dt-bindings: pinctrl: mediatek,mt65xx: Deprecate
 pins-are-numbered
Content-Language: en-US
To:     =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        devicetree@vger.kernel.org
Cc:     linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        mcoquelin.stm32@gmail.com, alexandre.torgue@foss.st.com,
        krzysztof.kozlowski@linaro.org, matthias.bgg@gmail.com,
        khilman@baylibre.com, linux-gpio@vger.kernel.org,
        linus.walleij@linaro.org
References: <20221129023401.278780-1-bero@baylibre.com>
 <20221129023401.278780-4-bero@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221129023401.278780-4-bero@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 29/11/22 03:33, Bernhard Rosenkränzer ha scritto:
> Make pins-are-numbered optional and deprecate it
> 
> Signed-off-by: Bernhard Rosenkränzer <bero@baylibre.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


