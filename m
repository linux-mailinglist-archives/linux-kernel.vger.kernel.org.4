Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CEAD72BED6
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Jun 2023 12:23:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234899AbjFLKXo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Jun 2023 06:23:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232521AbjFLKXR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Jun 2023 06:23:17 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E1A012509
        for <linux-kernel@vger.kernel.org>; Mon, 12 Jun 2023 03:02:24 -0700 (PDT)
Received: from [IPV6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2] (unknown [IPv6:2001:b07:2ed:14ed:c5f8:7372:f042:90a2])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 706F46606E9A;
        Mon, 12 Jun 2023 11:00:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1686564032;
        bh=TffA+lZzUvRHyw4/b64DDwCayT/nYLAIu4AYWJn79rc=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=K1BD9LxHyMr7/oBqUSy00KPUs1YWa3yAOJCc5jC0bQzJeUsB3H8sLk+oLDBQkaVDM
         ObIlW7SU4KnZN520okXvI2L7JD2EcSthAUDM0J+k3+ThJrr3Hjm+cD2u+7chtr8JhQ
         eyjmdXc8Rz8QzechiNKixXmzfh+Cvny5IuqcPp7hAp/J5zhDbSm8hbXc52aPAjvVW0
         nZ/pJHBoE9tHMl+GXn+C92uQZpL1VW7xLtxyyZSGmaEmwj2sJVrYJR8r6r3q1Thdn8
         az7Hh/2SP+3XuplQpADXWDANzQezlaI0Is8eJDX8Q2cqBof4bBkjt25y9NP/r/e5LG
         bTaJeHK4BAB9w==
Message-ID: <5150557b-b070-d3df-6d6f-61bbabde9f95@collabora.com>
Date:   Mon, 12 Jun 2023 12:00:29 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v2 2/2] ASoC: mediatek: mt8173: Fix irq error path
Content-Language: en-US
To:     Ricardo Ribalda Delgado <ribalda@chromium.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Jaroslav Kysela <perex@perex.cz>,
        Takashi Iwai <tiwai@suse.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        Dan Carpenter <dan.carpenter@linaro.org>, stable@kernel.org
References: <20230612-mt8173-fixup-v2-0-432aa99ce24d@chromium.org>
 <20230612-mt8173-fixup-v2-2-432aa99ce24d@chromium.org>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20230612-mt8173-fixup-v2-2-432aa99ce24d@chromium.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 12/06/23 11:05, Ricardo Ribalda Delgado ha scritto:
> After reordering the irq probe, the error path was not properly done.
> Lets fix it.
> 
> Reported-by: Dan Carpenter <dan.carpenter@linaro.org>
> Cc: stable@kernel.org
> Fixes: 4cbb264d4e91 ("ASoC: mediatek: mt8173: Enable IRQ when pdata is ready")
> Signed-off-by: Ricardo Ribalda Delgado <ribalda@chromium.org>

Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>


