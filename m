Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D578B5B57F1
	for <lists+linux-kernel@lfdr.de>; Mon, 12 Sep 2022 12:12:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229775AbiILKMh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 12 Sep 2022 06:12:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229463AbiILKMf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 12 Sep 2022 06:12:35 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103B21D0E2;
        Mon, 12 Sep 2022 03:12:33 -0700 (PDT)
Received: from [192.168.1.100] (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_128_GCM_SHA256 (128/128 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 5F2786601FD3;
        Mon, 12 Sep 2022 11:12:31 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1662977552;
        bh=8cFaxVFQUN8rcz0SgV1ILziN/080VIloT1ViIdRANRA=;
        h=Date:Subject:To:Cc:References:From:In-Reply-To:From;
        b=E0wZdAHv/k7SwZ5nem3qLmiY/quR2SBQTV1Y65LT7vmmNhNr5FvR99jhZMuHKbXZI
         cp2ikmumJSHaXQrksk45UMwbSmhPuE5H7uowNak/BbWlqZqmzowYUB7G94eYy9uxok
         9vNBmt0Sy5hdan/HBy0Ks9XctehwWZoyyrikllFlaj2GbPSveI0zbQUmnOpcaqOHGl
         BpeO7gI9v1fbWUfPiHCoGGdiliqUrqcuZFHdxu+awy3ZUxqTAw3zbzFPr0pmoZN/Kt
         xRsVoV1WNDkpu29qwDjlykp9UUYZitFMrUrtBrCVPWw5ggBnESGHIe/YjI5+HQe3gm
         +J6dzF6YZqG9w==
Message-ID: <90908764-b5aa-34a0-74c8-9f9215dcb89b@collabora.com>
Date:   Mon, 12 Sep 2022 12:12:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH v3 3/9] drm/mediatek: Adjust mtk_drm_gamma_set_common
 parameters
Content-Language: en-US
To:     "Jason-JH.Lin" <jason-jh.lin@mediatek.com>,
        Chun-Kuang Hu <chunkuang.hu@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     CK Hu <ck.hu@mediatek.com>, Rex-BC Chen <rex-bc.chen@mediatek.com>,
        Singo Chang <singo.chang@mediatek.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Project_Global_Chrome_Upstream_Group@mediatek.com
References: <20220911153734.24243-1-jason-jh.lin@mediatek.com>
 <20220911153734.24243-4-jason-jh.lin@mediatek.com>
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
In-Reply-To: <20220911153734.24243-4-jason-jh.lin@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.3 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Il 11/09/22 17:37, Jason-JH.Lin ha scritto:
> Adjust the parameters in mtk_drm_gamma_set_common()
>    - add (struct device *dev) to get lut_diff from gamma's driver data
>    - remove (bool lut_diff) and use false as default value in the function
> 
> Fixes: 051524cbe62d ("FROMGIT: drm/mediatek: Add lut diff flag for new gamma hardware support")

This Fixes tag contains a commit from a downstream kernel, which is useless
fo upstream. Please fix it.

Regards,
Angelo
