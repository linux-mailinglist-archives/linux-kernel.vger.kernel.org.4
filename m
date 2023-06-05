Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9FE9172275F
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Jun 2023 15:28:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233810AbjFEN1y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Jun 2023 09:27:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233172AbjFEN1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Jun 2023 09:27:48 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D028F7
        for <linux-kernel@vger.kernel.org>; Mon,  5 Jun 2023 06:27:46 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id 5b1f17b1804b1-3f6da07ff00so49020325e9.3
        for <linux-kernel@vger.kernel.org>; Mon, 05 Jun 2023 06:27:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1685971665; x=1688563665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=yKsqJloU0YBMoV3i0X0WKgMs82pe/pvJwGVG1B5dvuQ=;
        b=QeU3q9/jsyk58gL5sa26StZVON3JbuBqt9Nb52eU+8RxPdI6qLMECpE1uKsvUn+FzE
         PSNLLarc31GkgZlUgl1U8ZDIjUjiO5ixz1IJIb5pJselR4t9UI2qCWbIz1bKmc772pJi
         3TlMufzV4+d6M2gOF1/2csgEhQnZeAbH+OqgEVaq9ySSiJ9P1woR9ikC5HkPb0V36HWD
         3tc+xdwssa0LKTyPA1s+2qKg2bFw3fhKJsbX8hQB+uhkVmXbOm9ccc8CFT9W6HPwc0Bq
         69E2MZKnDx152ko8OFpqYDuIS/zpyn5sbJZ0AaJvMTlE3tXLCv/LN61gP9urV6Ly+zJM
         v1hA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1685971665; x=1688563665;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=yKsqJloU0YBMoV3i0X0WKgMs82pe/pvJwGVG1B5dvuQ=;
        b=a7oQgoAmsRB8sANAq6HAWKsNM+CrieEa3zF/MiCsKapZDZ40f7lX5YWL00JAcwqDtK
         MW5S5PLfX55O4nYYp52/IYSJzWo7Dfy2yDiGopEFsqwgcIE2YiBxQVdvZaCpyS6Wpc4j
         b1sHx9A3md8pcrJ2bwTPI5xkX09YIlOERwbQsAngPxgRn+L2ZZ2l7y0dTCaOIs0FYoud
         1YT+BL1CA8ea52qwYFsGMOsvRm2JZXsOnhc9JBE/GX5OkA4zvbdvojdyjzQ7iOjhhq5n
         OH5buMg3Bfn29T6N7EbmvJaw9ejtveq6+CIf0gyTVE6LtMQrq7owoic8teKO+iKjcHnm
         YeRA==
X-Gm-Message-State: AC+VfDyXpildAEBSP5vSW4yroOvtlZdLI/UF5omf2XNUP5DVXflaBMmA
        s7I5YX6zAAs6kip52wHjWflBejb+XwSpTgUYZ3E=
X-Google-Smtp-Source: ACHHUZ5szxWU0mg13BybwFHk4fZIjbLh1tqAUhrF9z1CMgnFJZCaLz5CiJur6zNPASDwHNrYHI+/xQ==
X-Received: by 2002:adf:fb42:0:b0:306:2ef0:d223 with SMTP id c2-20020adffb42000000b003062ef0d223mr6185401wrs.62.1685971664845;
        Mon, 05 Jun 2023 06:27:44 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d4c48000000b00301a351a8d6sm9779056wrt.84.2023.06.05.06.27.43
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Jun 2023 06:27:44 -0700 (PDT)
Message-ID: <a66c9e7c-3a8b-f32a-7ac2-5717024599a4@baylibre.com>
Date:   Mon, 5 Jun 2023 15:27:43 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH v2 2/2] ASoC: mediatek: mt8195: fix use-after-free in
 driver remove path
Content-Language: en-US
To:     Trevor Wu <trevor.wu@mediatek.com>, broonie@kernel.org,
        lgirdwood@gmail.com, tiwai@suse.com, perex@perex.cz,
        matthias.bgg@gmail.com, angelogioacchino.delregno@collabora.com
Cc:     dianders@chromium.org, alsa-devel@alsa-project.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <20230601033318.10408-1-trevor.wu@mediatek.com>
 <20230601033318.10408-3-trevor.wu@mediatek.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230601033318.10408-3-trevor.wu@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 01/06/2023 05:33, Trevor Wu wrote:
> During mt8195_afe_init_clock(), mt8195_audsys_clk_register() was called
> followed by several other devm functions. At mt8195_afe_deinit_clock()
> located at mt8195_afe_pcm_dev_remove(), mt8195_audsys_clk_unregister()
> was called.
> 
> However, there was an issue with the order in which these functions were
> called. Specifically, the remove callback of platform_driver was called
> before devres released the resource, resulting in a use-after-free issue
> during remove time.
> 
> At probe time, the order of calls was:
> 1. mt8195_audsys_clk_register
> 2. afe_priv->clk = devm_kcalloc
> 3. afe_priv->clk[i] = devm_clk_get
> 
> At remove time, the order of calls was:
> 1. mt8195_audsys_clk_unregister
> 3. free afe_priv->clk[i]
> 2. free afe_priv->clk
> 
> To resolve the problem, we can utilize devm_add_action_or_reset() in
> mt8195_audsys_clk_register() so that the remove order can be changed to
> 3->2->1.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

