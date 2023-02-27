Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2A3A76A3C1C
	for <lists+linux-kernel@lfdr.de>; Mon, 27 Feb 2023 09:15:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229719AbjB0IPB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Feb 2023 03:15:01 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229742AbjB0IO7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Feb 2023 03:14:59 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8FBA91B338
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:14:58 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id q16so5238253wrw.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Feb 2023 00:14:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=sPZA0XSKxRo4YB/M42Xch0cLpdtNvC/oUhrKIx5ckBU=;
        b=hym7BxZM8YUGCUNlxpVqf+3CxalXvS/VffvyAHsTZ6xmYzZM8Mpju237R+IJUnQrNv
         CWfR23+gY0hU7N/mgnQYCsvL5EVgoBNJaZbGIxRMmNRaBpTjhOOgs2EuV4pY4AyV5FxP
         SKcY/Z4Ywbz4+hbhLbFeqynZ786BVX3LLXy8oATwOKPqLbqUNCRmArdp1MbJnhguAIgv
         oOyi0atdhcvSLr3pqkpSzO+xDJcuNneVc6e/EDcOzcsAFqqZYdVnIQ840Xo2gYMKU5xs
         raYuAqD47BDiAo2G2hQxZT3Y+G4Xv0poNJyj9j+17FY4BB+DjnLVp4jzyoUepqXYZsP9
         he2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=sPZA0XSKxRo4YB/M42Xch0cLpdtNvC/oUhrKIx5ckBU=;
        b=jE3slJqPtp1cH5tu7xxNVQEpvSxOcBadkxL9vm9pg6WQynLerPDe2hW39GbQYmDfEK
         O/IDKQ+QOzkbcuT3TmrzMJG0fsMbi1PR1SofgTHOqnDiTifAp/iqjvIo9BTn62h9LJjB
         /gX9bK51vwyv8ucakhuLBumctzjKI3MTL/7sUgMfpPvLLiMCKMbOQuyITZ2qD9fIHZvH
         v14RcxWLO30qkn9l5oFo9TswkgYOtBCs6VoSf8WU8/dFoeWmZDfevxNmQlhLunXGFzm+
         zyLPyKUSK4A+fWwOzJHwU0phrOqrne9fqEONfJGh1iaPf3BEPMC9qDDy1La1AYvBe+xb
         7DEQ==
X-Gm-Message-State: AO0yUKVkrvHiQgA3pQwb4SttGMA4bBYRUiN6/JVoEwUvLzxy/eesVx/w
        Fp662AhqkGEVJw+2uPWHrr3ZkA==
X-Google-Smtp-Source: AK7set/s9+7NWpmDjGEUEEHrmychpJ81y9ZNfgqj5JXXi2ASfL2q/j8dhtlWWGIGiVsvQZF9J0c5AQ==
X-Received: by 2002:a5d:4642:0:b0:2c7:d7ca:4c89 with SMTP id j2-20020a5d4642000000b002c7d7ca4c89mr7103428wrs.58.1677485697110;
        Mon, 27 Feb 2023 00:14:57 -0800 (PST)
Received: from [192.168.1.20] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id h8-20020adff188000000b002c54241b4fesm6326357wro.80.2023.02.27.00.14.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Feb 2023 00:14:56 -0800 (PST)
Message-ID: <8757f3ae-9145-78a4-6a41-d6c66746a9bb@linaro.org>
Date:   Mon, 27 Feb 2023 09:14:55 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH 1/3] dt-bindings: power: Add bindings for MediaTek MT6735
Content-Language: en-US
To:     Yassine Oudjana <yassine.oudjana@gmail.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     Yassine Oudjana <y.oudjana@protonmail.com>,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
References: <20230225101629.264206-1-y.oudjana@protonmail.com>
 <20230225101629.264206-2-y.oudjana@protonmail.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230225101629.264206-2-y.oudjana@protonmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/02/2023 11:16, Yassine Oudjana wrote:
> From: Yassine Oudjana <y.oudjana@protonmail.com>
> 
> Add DT bindings for MediaTek MT6735 SCPSYS.
> 
> Signed-off-by: Yassine Oudjana <y.oudjana@protonmail.com>
> ---
>  include/dt-bindings/power/mediatek,mt6735-scpsys.h | 14 ++++++++++++++
>  1 file changed, 14 insertions(+)
>  create mode 100644 include/dt-bindings/power/mediatek,mt6735-scpsys.h
> 
> diff --git a/include/dt-bindings/power/mediatek,mt6735-scpsys.h b/include/dt-bindings/power/mediatek,mt6735-scpsys.h
> new file mode 100644
> index 000000000000..5124cdee9dc7
> --- /dev/null
> +++ b/include/dt-bindings/power/mediatek,mt6735-scpsys.h
> @@ -0,0 +1,14 @@
> +/* SPDX-License-Identifier: GPL-2.0-only */

Dual license, please. Same as bindings (checkpatch should warn).


Best regards,
Krzysztof

