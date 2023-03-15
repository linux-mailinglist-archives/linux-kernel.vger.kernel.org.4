Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C80676BAE14
	for <lists+linux-kernel@lfdr.de>; Wed, 15 Mar 2023 11:47:27 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231360AbjCOKrZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Mar 2023 06:47:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232360AbjCOKqq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Mar 2023 06:46:46 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C091E7E7B8;
        Wed, 15 Mar 2023 03:46:06 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 41C8D66015F1;
        Wed, 15 Mar 2023 10:45:59 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1678877160;
        bh=2lu6PO85yn+bXYwQVx0BtD+c64sEAEGM7jdKQhcGME8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=XiamhNz3BoS2Am/A916XWJivnLGJ5CbmEZpenv49PmVgRCy5qL1V/oXw16h6Mnotl
         Z94E0gppdt/i81ppf7yISjD6rvxasFgEInXQPNXHDlX3uS8J6ayjDYaAhNHcywlCeg
         1iuk1I6lqn39B6HRHiUSBqH7GDRIuKL3uoU2u3Oj4ob/DGjeeI4+qpmj0ErBLFkKgw
         uwPEGsOULUOvOZwmlK6orcLbZr2fcPnaWkQdEonEXQFnJdynrI+8iw0r/TbinPVYnI
         o6qiJhlEpNs7qK7S0eYk2ECctMGxZveWgc9Pt2T6+RwJ2tAlPC2ZFdl4yKFtU+tYZ/
         Y1W0EDhUVPbtA==
Message-ID: <e55bc87c-c174-6acb-d48e-9a05b9551754@collabora.com>
Date:   Wed, 15 Mar 2023 11:45:56 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH v2 03/18] dt-bindings: pinctrl: mediatek,mt8365-pinctrl:
 add drive strength property
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>
Cc:     Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Zhiyong Tao <zhiyong.tao@mediatek.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chaotian Jing <chaotian.jing@mediatek.com>,
        Rob Herring <robh+dt@kernel.org>,
        Wenbin Mei <wenbin.mei@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        linux-mmc@vger.kernel.org, Alexandre Bailon <abailon@baylibre.com>,
        devicetree@vger.kernel.org,
        Amjad Ouled-Ameur <aouledameur@baylibre.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-gpio@vger.kernel.org, linux-watchdog@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        Fabien Parent <fparent@baylibre.com>
References: <20230203-evk-board-support-v2-0-6ec7cdb10ccf@baylibre.com>
 <20230203-evk-board-support-v2-3-6ec7cdb10ccf@baylibre.com>
 <3b7c6f28-57bd-33de-5531-8c4eae8cf6eb@linaro.org>
 <6e08d78f-ef4c-b228-f7d2-d63767ea87b8@collabora.com>
 <62ed2988-2347-9fd9-82f9-6dcc9ae75808@collabora.com>
 <CAFGrd9rZxwtxx5f8Gp35-5152EPGiyEdZjps1Mhn5bL6QfufnA@mail.gmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <CAFGrd9rZxwtxx5f8Gp35-5152EPGiyEdZjps1Mhn5bL6QfufnA@mail.gmail.com>
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

Il 15/03/23 09:11, Alexandre Mergnat ha scritto:
> Le ven. 10 mars 2023 à 10:49, AngeloGioacchino Del Regno
> <angelogioacchino.delregno@collabora.com> a écrit :
>>
>> Il 10/03/23 10:46, AngeloGioacchino Del Regno ha scritto:
>>>
>>> Anyway, Alexandre: can you please perform a cleanup to the MT8365 pinctrl binding?
> 
> Yes I can ! :D
> Should I do it directly in this patch series or (I prefer) in a new one ?
> 

Doing that in a new one is fine... it's a cleanup that is not strictly related to
what you're introducing in this series.

>>> The cleanup means you're setting mediatek,drive-strength-adv as deprecated and
>>> adding the right properties (...and possibly changing the devicetrees to use it).
>>>
>>> For more information, you can look at commit history for the (unfortunately, named
>>> incorrectly) MT8195 pinctrl documentation: bindings/pinctrl/pinctrl-mt8195.yaml
>>> where we performed the same cleanup that I'm asking you to do, except we didn't
>>> have to set any property as deprecated because there was *no devicetree upstream*
>>> that was actually using that property (hence not an ABI breakage).
> 
> Thanks for the information, that helps.

You're welcome!

Regards,
Angelo

