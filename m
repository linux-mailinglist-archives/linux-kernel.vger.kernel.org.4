Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18EFD5F3221
	for <lists+linux-kernel@lfdr.de>; Mon,  3 Oct 2022 16:46:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiJCOqT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 3 Oct 2022 10:46:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229945AbiJCOqJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Oct 2022 10:46:09 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e5ab])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1BAA02C64B;
        Mon,  3 Oct 2022 07:46:08 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 294EF6601B15;
        Mon,  3 Oct 2022 15:46:06 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1664808367;
        bh=/FVS6/5ZqbbGMxW7m+yjSMkIk/Rq9l4aAT/jU6ZOLi8=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=bDkm/xCNVzSoHPEJRFO6q0zI5aXmON0x0NiIPKzlxTQWF4MoIUWzskOaJ3hFEaFk9
         ODY7fHFNegpei8JwOC40L/cjUjItWdY0qaYiWy3md+w4eriBBAM572M4SAD+0prbsF
         sN9PNTD8AG8jLtXSDlUeTxP0zIb2pKAg3+XD0dzeETTqf0Y2dRu0P3vQplZ0gwhC04
         9a+1BHe4r746PKNIXXMSmlwRzO0Hx/CiJ1OCpADCBxyg0XWwDAOIP5YYtVdBhdcsbg
         H0aXa+sQTJgabIPLEhO7sjGLmHo1NuJ6DbVXhplWQ46fXumAZgbXfyWxRD5pR2yFh8
         oMlmi7fzQ+Qvw==
Message-ID: <e3f751e4-4cca-e869-5b7b-45205f0f12c1@collabora.com>
Date:   Mon, 3 Oct 2022 16:46:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2] dt-bindings: mfd: mt6370: fix the interrupt order of
 the charger in the example
Content-Language: en-US
To:     ChiaEn Wu <peterwu.pub@gmail.com>, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, lee@kernel.org,
        matthias.bgg@gmail.com, sre@kernel.org
Cc:     chiaen_wu@richtek.com, cy_huang@richtek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
References: <9dda705a8d67826306f6c6129722d3ad8edc96fc.1664816175.git.chiaen_wu@richtek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <9dda705a8d67826306f6c6129722d3ad8edc96fc.1664816175.git.chiaen_wu@richtek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 03/10/22 11:04, ChiaEn Wu ha scritto:
> From: ChiaEn Wu <chiaen_wu@richtek.com>
> 
> Fix the interrupt order of the charger in the binding example.
> 
> Fixes: 76f52f815f1a ("dt-bindings: mfd: Add MediaTek MT6370")
> Signed-off-by: ChiaEn Wu <chiaen_wu@richtek.com>
> Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


