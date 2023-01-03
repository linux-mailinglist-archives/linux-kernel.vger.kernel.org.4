Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A77B865BC14
	for <lists+linux-kernel@lfdr.de>; Tue,  3 Jan 2023 09:22:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236789AbjACIWQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 Jan 2023 03:22:16 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237139AbjACIWF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Jan 2023 03:22:05 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 240E81036
        for <linux-kernel@vger.kernel.org>; Tue,  3 Jan 2023 00:22:04 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id f34so44615979lfv.10
        for <linux-kernel@vger.kernel.org>; Tue, 03 Jan 2023 00:22:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=hnNplO8zsSj05CAnhZjssEtarwgdK7a3BUAmXeHqfTE=;
        b=IRDYFhgv7CWgApeZ9OhEzu4ziX6vYEoYanJOwxAVtNXXyq/6zS+qWU0v9JYWo+nTfr
         75SUTilDQ6Wappp/0y36aU6HUHsoldMMAZOoCVs0bccvE8mHrAOQHuKhfI2OI8VjT+09
         UU8jLYsLpZFuNwRey5xq1BPaD4oO9teX0QXKL95viaZ5J/EdMvJtY3X+lQMZB4tbEvGN
         /tRbizkhie2NJuQiN0F8URex/wWIwEaW+ujREEPAJu8xRf2wnNfu8nz62Yr7iXHXrzLL
         WwePuWhjeCaZvvfrBZH3flKA+v9TKZBDYwjyDQyhGYOqRV99y8Jyq0EJw3wNGjPhG68b
         WQaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=hnNplO8zsSj05CAnhZjssEtarwgdK7a3BUAmXeHqfTE=;
        b=xFPVFOry32A036aJfNm/G/NIMwomjSdpwREu2xzfVvhh9vA45yACN/VhyCoX5pU6am
         w4/7LKil8FUF0fH8Zf9TjJZRHfsbf9kdvgav0/3lTxa8k2/zwuYZ5G5M3C7dfYJCh+lc
         QRvWxzr/deUBF72+r0JiwSC5/tJ6o5FRTDM47N1Q1DMfLM3LmccpUaJuJCR+hdKHFBlW
         GlyvrTPvy0cOTt7S0Bp8YLkS58Clfy4P9v1iRmusyUZ6O09sRiC/+bBMuTB0YzP/+7zp
         C3atP/rBM+Wflz9F57Gdz3wmrVbPDSMkFY9UOnOnM0AXMs769vrF0So26/h1u5XNdIZG
         iw/A==
X-Gm-Message-State: AFqh2kophABUj/niTzlS610DVNG00hvoG1LMBJ/LRS2mOgIh70gwUPRl
        +Vr6uEnRCs+wLPd4C5/WJ3J+9Q==
X-Google-Smtp-Source: AMrXdXvbZP6isWmvcJTEe2l329jkWLKnwxKfmHzK41+F7rk8tb5+8boVcvSBIznNrbeyntQ/Q+zNzQ==
X-Received: by 2002:ac2:490f:0:b0:4b6:eca8:f6ca with SMTP id n15-20020ac2490f000000b004b6eca8f6camr10992900lfi.67.1672734122520;
        Tue, 03 Jan 2023 00:22:02 -0800 (PST)
Received: from [192.168.0.20] (088156142067.dynamic-2-waw-k-3-2-0.vectranet.pl. [88.156.142.67])
        by smtp.gmail.com with ESMTPSA id p23-20020a056512139700b004b577085688sm4757340lfa.82.2023.01.03.00.22.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Jan 2023 00:22:02 -0800 (PST)
Message-ID: <dccc7a0f-9eaf-24ca-e800-8ee1417e74f9@linaro.org>
Date:   Tue, 3 Jan 2023 09:22:00 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.6.1
Subject: Re: [RFC PATCH 2/4] dt-bindings: vendor-prefixes: Add lincolntech
Content-Language: en-US
To:     Aradhya Bhatia <a-bhatia1@ti.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Tomi Valkeinen <tomba@kernel.org>,
        Jyri Sarha <jyri.sarha@iki.fi>,
        David Airlie <airlied@gmail.com>,
        Daniel Vetter <daniel@ffwll.ch>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lad Prabhakar <prabhakar.mahadev-lad.rj@bp.renesas.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Guo Ren <guoren@kernel.org>
Cc:     DRI Development List <dri-devel@lists.freedesktop.org>,
        Devicetree List <devicetree@vger.kernel.org>,
        Linux Kernel List <linux-kernel@vger.kernel.org>,
        Linux RISC-V List <linux-riscv@lists.infradead.org>,
        Linux ARM Kernel List <linux-arm-kernel@lists.infradead.org>,
        Linux Mediatek List <linux-mediatek@lists.infradead.org>,
        Linux C-SKY Arch List <linux-csky@vger.kernel.org>,
        Nishanth Menon <nm@ti.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Rahul T R <r-ravikumar@ti.com>,
        Devarsh Thakkar <devarsht@ti.com>,
        Jai Luthra <j-luthra@ti.com>,
        Jayesh Choudhary <j-choudhary@ti.com>
References: <20230103064615.5311-1-a-bhatia1@ti.com>
 <20230103064615.5311-3-a-bhatia1@ti.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230103064615.5311-3-a-bhatia1@ti.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-5.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/01/2023 07:46, Aradhya Bhatia wrote:
> Add document vendor prefix for Lincoln Technology Solutions
> (lincolntech).
> 
> Signed-off-by: Aradhya Bhatia <a-bhatia1@ti.com>
> ---
>  Documentation/devicetree/bindings/vendor-prefixes.yaml | 2 ++


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

