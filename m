Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99FD7738092
	for <lists+linux-kernel@lfdr.de>; Wed, 21 Jun 2023 13:10:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230365AbjFUJhI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 21 Jun 2023 05:37:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38736 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231750AbjFUJgj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 21 Jun 2023 05:36:39 -0400
Received: from mail-ej1-x62e.google.com (mail-ej1-x62e.google.com [IPv6:2a00:1450:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2BB78210D
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:35:12 -0700 (PDT)
Received: by mail-ej1-x62e.google.com with SMTP id a640c23a62f3a-9891c73e0fbso344121566b.1
        for <linux-kernel@vger.kernel.org>; Wed, 21 Jun 2023 02:35:12 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20221208.gappssmtp.com; s=20221208; t=1687340039; x=1689932039;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ljGl+r+k1qbaLYIuL6tG07702g7IZr1fWRM+mo+h1Rs=;
        b=qAziTwFRi+PN2EIJAqo6CLMG8v1BgjgVrGJ3TOyUJe9FvL5/UBiAizWtsUc/fOBflk
         x9N7PA0xXWDdHjTYI2OAk5bIgwMrZ12xZi4hBr/PA/Q52tforWKejbIa+Bl1JX5NuXac
         j29s4Sz9n73z2jxc1D40fW0Yv3om1I+ge0rzg5yOiML2c/wCkIYBMezED7e0r1jkJBKt
         i4x0ROrnHUnFyXhSCykcsUOYjX9XOoD/xKFAuJALwh/z6TfkCnlRxg3QXTZUzfN/z5ZO
         Wf3fh9ZxYEiiSQL+JK/uCjRRLw5NOXJutgoilHNnlUXqPSKHjxkpUbQG6jpzSy/2hEiy
         Kcwg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687340039; x=1689932039;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ljGl+r+k1qbaLYIuL6tG07702g7IZr1fWRM+mo+h1Rs=;
        b=RLg476BGWxRwXupLdcU+xJ8LSxp25Ynkm965FU3J/qAhGSIwIo6H8pmRyC6oU5Rdk/
         PHTOR7/HaxTRvdA3Qbli2YQ8wx4z75csE2ErwA/GgsyFNnLsCcPBEDLoSwnxVN6JRdVe
         K1RMeBXBXvnhyuSsJkVMNgRFX4KeXZFiL5gvg0qFvXPsqHbEgr4vzRuPKkNu1Jo9UR/p
         1mwS+qrXYC6eM+G3WZr6D6WYK3o8kqcVP6lZVYY1hPeE01cEQa8Zs0YomPz+fs8cUbZE
         VeU5qnjHLqHFvwoWRyrT/TV8ZQSTBDjuX+PGG546j1vfXnsm/l30kf2hPOax5oMKTsLT
         8VPg==
X-Gm-Message-State: AC+VfDzH3DjxhV/xTt7VS5FfGMfz2DuMmiwbuY4ca2ZkSDZsCG8W3FKP
        FZAyYicI5ytLbJ22HDgima8Bxw==
X-Google-Smtp-Source: ACHHUZ4JX2zU1zAxBi3DbRV4OCuh8CPKC1bJlK3xGSb5VZzjGA+4Pt30r2DDo2hInl2arzbiOPL/GQ==
X-Received: by 2002:a17:907:1ca3:b0:988:565f:bf46 with SMTP id nb35-20020a1709071ca300b00988565fbf46mr9062378ejc.32.1687340039335;
        Wed, 21 Jun 2023 02:33:59 -0700 (PDT)
Received: from [192.168.1.172] (158.22.5.93.rev.sfr.net. [93.5.22.158])
        by smtp.gmail.com with ESMTPSA id h6-20020a1709063b4600b009891da61b1asm2684086ejf.44.2023.06.21.02.33.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 21 Jun 2023 02:33:58 -0700 (PDT)
Message-ID: <e4fc7141-5351-479c-368d-3d469c053a81@baylibre.com>
Date:   Wed, 21 Jun 2023 11:33:52 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.0
Subject: Re: [PATCH 2/3] drm/mediatek: Use dev_err_probe() in probe functions
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, chunkuang.hu@kernel.org
Cc:     p.zabel@pengutronix.de, airlied@gmail.com, daniel@ffwll.ch,
        matthias.bgg@gmail.com, dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kernel@collabora.com
References: <20230608101209.126499-1-angelogioacchino.delregno@collabora.com>
 <20230608101209.126499-3-angelogioacchino.delregno@collabora.com>
From:   Alexandre Mergnat <amergnat@baylibre.com>
In-Reply-To: <20230608101209.126499-3-angelogioacchino.delregno@collabora.com>
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
> Convert all instances of dev_err() -> return to dev_err_probe() and
> where it makes sense to, change instances of `return ret` at the end
> of probe functions to `return 0`, as errors are returned earlier.

Reviewed-by: Alexandre Mergnat <amergnat@baylibre.com>

-- 
Regards,
Alexandre

