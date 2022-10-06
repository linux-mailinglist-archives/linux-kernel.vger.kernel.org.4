Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3632D5F6433
	for <lists+linux-kernel@lfdr.de>; Thu,  6 Oct 2022 12:12:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231236AbiJFKM2 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 6 Oct 2022 06:12:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38634 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231156AbiJFKMX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Oct 2022 06:12:23 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 062488E0CD;
        Thu,  6 Oct 2022 03:12:18 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 60D6466022FB;
        Thu,  6 Oct 2022 11:12:16 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1665051137;
        bh=F0Shbo3iDgIaWL5uTiEZ6K6dcKkSMlfWf6i5qnRR1tA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=lNlsHyM5QBgpLUqzxXk+VG5RIHBprJQzoGpgQbiLX2bCrG+XgfavKprutex5f0CPo
         n608KPAwd/sRbD8V4vanhD2ZeS7+DO+mTGWiK7DjAEB6lsbigpaaVkC2xH8JEgE+Gz
         ZyT86pDOZw/AXBgpq+HG68kUa2pKzrMW62soM/22eHYxMhSDtJ52O95Ma2mJiOBoJB
         x7PfYFF3OayXV4x10GqYEYxO7IJyTdQjYmTZYoMy+arfRAEJmVX51VVt0TXwHXJ/0F
         q54vrBhRnRjLy+f1519fmjQV78HbrKMsVjRT6oR5/n/0ZCVXCH9i5h9bcxkc+h7cqI
         zcb0f3RszXg2Q==
Message-ID: <5c38e7ba-a66d-4a93-653e-2739d6e92a76@collabora.com>
Date:   Thu, 6 Oct 2022 12:12:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v2 5/5] Input: mtk-pmic-keys: add MT6357 support
Content-Language: en-US
To:     Alexandre Mergnat <amergnat@baylibre.com>,
        Lee Jones <lee@kernel.org>, Mark Brown <broonie@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Dmitry Torokhov <dmitry.torokhov@gmail.com>,
        Chen Zhong <chen.zhong@mediatek.com>
Cc:     linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Rob Herring <robh@kernel.org>, linux-kernel@vger.kernel.org,
        linux-input@vger.kernel.org, Fabien Parent <fparent@baylibre.com>
References: <20221005-mt6357-support-v2-0-f17ba2d2d0a9@baylibre.com>
 <20221005-mt6357-support-v2-5-f17ba2d2d0a9@baylibre.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20221005-mt6357-support-v2-5-f17ba2d2d0a9@baylibre.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 05/10/22 16:57, Alexandre Mergnat ha scritto:
> From: Fabien Parent <fparent@baylibre.com>
> 
> Add PMIC Keys support on MT6357 SoC.
> 
> Signed-off-by: Fabien Parent <fparent@baylibre.com>
> Signed-off-by: Alexandre Mergnat <amergnat@baylibre.com>
> Reviewed-by: Mattijs Korpershoek <mkorpershoek@baylibre.com>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


