Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C6E16D7870
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Apr 2023 11:33:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237730AbjDEJdg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Apr 2023 05:33:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55520 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237727AbjDEJdP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Apr 2023 05:33:15 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 133EE55BB;
        Wed,  5 Apr 2023 02:32:40 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5020066031AD;
        Wed,  5 Apr 2023 10:31:51 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1680687112;
        bh=1v+Dt06wXLxLkRrvZe75hH+NO5Dfwp4+k7N71NcKmR4=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=L2yMdEwEpr0yHWlEWI2mRKIzoq8oGMxnatgpO1bp2lTCfWlwH02Zx0ltFfzBhgVrP
         If+ZyiDsKfqjiNZPnlapF9XHexqIAt4Nc6EEztMHYTRlb3M4uUzdcka8Kl6QBnm1p1
         rvGPgAHuzFBT4vXLzFlt19vx+oigj9E+mwM1hpk2knIKtt4RC+9c3IAlNV7EGaQ/3D
         JEndJ8Jrw+TXpCnNzzxNL10U2I4OrpVNzkk3GH6FIavv2Upw7A7zSTXok0eBIqQlFJ
         5bPrd2FGN2nbqrzHmFlPeRHWbngoa4yXgttD4bp6FfVyHyzfPw8WPeMcJ0OoTnT05o
         dpnbWvSvOJpzw==
Message-ID: <ee893222-38b9-899a-58c2-71e16fbb963f@collabora.com>
Date:   Wed, 5 Apr 2023 11:31:49 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.9.1
Subject: Re: [PATCH v3 2/3] dt-bindings: pinctrl: mediatek: deprecate custom
 bias pull properties for mt8365
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>
Cc:     linux-gpio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <20230327-cleanup-pinctrl-binding-v3-0-6f56d5c7a8de@baylibre.com>
 <20230327-cleanup-pinctrl-binding-v3-2-6f56d5c7a8de@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230327-cleanup-pinctrl-binding-v3-2-6f56d5c7a8de@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.6 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 04/04/23 18:29, Alexandre Mergnat ha scritto:
> In order to be more generic, "mediatek,pull-up-adv" and
> "mediatek,pull-down-adv" should be deprecated. Use "bias-pull-up" and
> "bias-pull-down" instead.
> 
> Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


