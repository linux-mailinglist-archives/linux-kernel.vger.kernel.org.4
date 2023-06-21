Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8389737E72
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 11:17:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231480AbjFUIvd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 04:51:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229452AbjFUIva (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 04:51:30 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8BCD1737
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:51:28 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-988c30a540aso384066266b.3
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 01:51:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687337487; x=1689929487;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=BRHVPNSU4tTJknHFfi1ELNcDLjA797fSO46AAYSa8NA=;
        b=zLOYR94ak5xNuZ9vkx8rHsN1IHzUV5POeqdCxnIsDiiVHzTlukQzfWFowBT2b763th
         lXQvt/kpXCqhYwgLAmycyBm8lk3kpJjLv/Hb0aiFYfeh1m66o2267yFtwKSjWRyLwuAd
         FlsljOxQ7W0w7+LiQ/XVI1rh2r39dB4lP7zQqzS3o40l4GJJ0p/yL++nLiK0jxzbL/yp
         wnGk5bfRYG9TmpMk0M9P5TJGhaArdImW0D/NPkY2DPkqZn5DO7XsuIYi2YXMv9vyTcZP
         twbTY/O44MImRRXBL3SjU3VtlXCnBsQiNG1qqEzh6AMbqRGNiQhqCFP5IiEgE57jrTA0
         7SMA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687337487; x=1689929487;
        h=content-transfer-encoding:in-reply-to:from:content-language
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=BRHVPNSU4tTJknHFfi1ELNcDLjA797fSO46AAYSa8NA=;
        b=CgEEfexrDvsKa0Pqc6lc4CCW6dCJDZ/XfSCwZbVWyK6StD/KV0DrzopwGMvBksDtBo
         6dVYNq9NzcMfPRv8RBWPBsxbYeFL1h3QbBr1vWTAGkYhmyZjrRgeNRu0jt/eUJVBeBGH
         Hl3RnmzW1njXmdLA6VsxaePpqULtAGZCJHQDfbtwFj1l1xrCqff01b6qe4cFUbkt59bL
         vbC9idGbMA0TK0eXxE0RVtt27alvOUq3ZN87pND18qs9UEbFa6vqyGQn7jxJyfnMZ6Oh
         mZmz+wZW/+YF+/XUs0f+An+A4aGmj8Hq31iU47IGQzdS81E0MSHkqrLy00LBokXBLe+k
         d3sg==
X-Gm-Message-State: AC+VfDwIeWGhyKTEt/sHp/mvHfYDFhjN7GYGp/pu9hbWVYXYPkZ/Bgz2
        RpaTqFbUdyg6f13Jke0TJPPcog==
X-Google-Smtp-Source: ACHHUZ7FqSCbAkzrs5As8CZOClg9+TI9Bl1lOHwdAwPH8D2STs07dFYCsBwi/Lit2QpJGi+hd1Y1iQ==
X-Received: by 2002:a17:907:3e0a:b0:982:45ca:ac06 with SMTP id hp10-20020a1709073e0a00b0098245caac06mr14025701ejc.60.1687337486873;
        Wed, 21 Jun 2023 01:51:26 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id x14-20020a170906134e00b009828e26e519sm2693980ejb.122.2023.06.21.01.51.25
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 01:51:26 -0700 (PDT)
Message-ID: <c254802f-91fd-a9b7-e792-5f450dae0569@baylibre.com>
Date:   Wed, 21 Jun 2023 10:51:24 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 1/3] drm/mediatek: Use
 devm_platform_get_and_ioremap_resource()
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20230608101209.126499-1-angelogioacchino.delregno@collabora.com>
 <20230608101209.126499-2-angelogioacchino.delregno@collabora.com>
Content-Language: en-US
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230608101209.126499-2-angelogioacchino.delregno@collabora.com>
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

On 08/06/2023 12:12, AngeloGioacchino Del Regno wrote:
> Instead of open coding calls to platform_get_resource() followed by
> devm_ioremap_resource(), perform a single call to the helper
> devm_platform_get_and_ioremap_resource().
> 
> This commit brings no functional changes.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

