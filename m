Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15CF6632415
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Nov 2022 14:42:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231220AbiKUNmX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Nov 2022 08:42:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229903AbiKUNl5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Nov 2022 08:41:57 -0500
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 233F32D1DE;
        Mon, 21 Nov 2022 05:41:54 -0800 (PST)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 1862E6600368;
        Mon, 21 Nov 2022 13:41:52 +0000 (GMT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1669038112;
        bh=LEKyP7Lh1CGJUl09TE0Fs4DL19+CS3JViR/Mmqqgwrs=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=cSpESSFnz3CedZ2akD3CYVMgONzrJw4c6KypoOO4AiFgKjce6U8DtFf5C/iftIiRj
         iC2XUupLKdaWDA2M8B6Bwlzy1tN8+s31SRO39vEwA3RVQzpwgbTGjUUZMWrizMjsab
         WpiJSvJvudOO9HW7TxXmjiss9ddm+DRt9G/r7RlQGtGEcjvowgraMk8g4yosyyGRuT
         d+0dAQUAnymgfIpGTdA8uEI2VDatrig6KfcSVnsvraOJ8oskUL8QLW00ab37sdYi0V
         gmySM/oUrY7iQFcjDm6PPzAOFYwkrtBXv4+C0VFP8vssN0JFYzVTbQIBPwQ//VYXD1
         nySEVAS7dOwuw==
Message-ID: <fce278a4-b983-ffd2-52bd-0cbfed6e5294@collabora.com>
Date:   Mon, 21 Nov 2022 14:41:49 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.5.0
Subject: Re: [PATCH v5 5/7] dt-bindings: pinctrl: mediatek,mt6779-pinctrl:
 Document MT6765 pin controller
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Sean Wang <sean.wang@kernel.org>,
        Andy Teng <andy.teng@mediatek.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        linux-mediatek@lists.infradead.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, Rob Herring <robh@kernel.org>
References: <20221118113028.145348-1-y.oudjana@protonmail.com>
 <20221118113028.145348-6-y.oudjana@protonmail.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221118113028.145348-6-y.oudjana@protonmail.com>
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

Il 18/11/22 12:30, Yassine Oudjana ha scritto:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> The MT6765 pin controller has had a driver for a while, but DT
> bindings were never documented for it.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> Reviewed-by: Rob Herring <robh@kernel.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


