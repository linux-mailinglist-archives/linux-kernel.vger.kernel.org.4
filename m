Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA8046C6A8F
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Mar 2023 15:17:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229847AbjCWORy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Mar 2023 10:17:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230482AbjCWORw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Mar 2023 10:17:52 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 93C9026C32;
        Thu, 23 Mar 2023 07:17:50 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id om3-20020a17090b3a8300b0023efab0e3bfso2060200pjb.3;
        Thu, 23 Mar 2023 07:17:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112; t=1679581070;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=KwWlt/KOKKTZV5IfSjGfyeDxmoG3w+1dWejJirL87Kc=;
        b=ShXIgySZUj17n8AichZ6BuKTikQIsXDd6ZVTquByVrE6Vbrd5xJvxmzFeGybkzJQw+
         2dvPVykT31PVMXZkQI4/V1PrLosJ8/G81+bLf7guHi0hoaBYJbF4P4oFsacqNyGOGzl0
         KWAIfcfULvOuAvq54WwijhDLokXsbuMfLjGNKadLpchF8Xh1u2lk9enjxA9BLLWIOWEu
         sNxTYRawdnA2VypiKSGiKAadBU691K9veJ+xX+PPKmFrf9bhOcFw5otLG9wahtG3Sl1x
         1QbMXbM+gOxUpC+3yWS7L272rcBPzaRxoZNn6I4m1UlenvHfLy+sDQLGpknXl3R0oztV
         pQ/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112; t=1679581070;
        h=content-transfer-encoding:in-reply-to:content-language:from
         :references:cc:to:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=KwWlt/KOKKTZV5IfSjGfyeDxmoG3w+1dWejJirL87Kc=;
        b=ajvT9cjLz2cZPN1wUz09h1OyHKs/xydjqcZOnnVSc0agF2qZFlMOiZbtXDkU3hef5e
         JHUHQEHrxKVurAqeonwz5RdMSHoTyoO9KsYCE4E1YAXiblS5u8KnMSAfBpPGVEN46VGL
         IKXbkiCCmgg4vqmA2NmON6T0CLENu00FOt+QRTEhImXsc30zLicJ+FDftuR0XWgP/7a1
         c5wTso9sGZoaU1fX66zFoNMLn1P9TAoFcmbbC/EVWyiiDzA+6gG3ITPqo8Pn8CKQZ52b
         R/r9ZSEpDnL8PcISxTvM4AVGW/NrIm5PQnZ46SZ4hjwRI/j/wmSGxKG3QHLigkQ1GPJf
         78Qw==
X-Gm-Message-State: AO0yUKWrhdrwNn5+XWmExQ7mtM6nBM1j62MT6n6eLXwEz0bCEAuv9CDa
        pkAnD4rYplzrd9SglKUJ0sA=
X-Google-Smtp-Source: AK7set8s8aOBz3BhSS+2TpYUEhRf2Zwajb86+z7vpmqctX+tEU+jGLlvaa7kumROlD7GK1yDG+Y7Ag==
X-Received: by 2002:a05:6a20:a914:b0:d7:6b87:94b8 with SMTP id cd20-20020a056a20a91400b000d76b8794b8mr2981901pzb.18.1679581069864;
        Thu, 23 Mar 2023 07:17:49 -0700 (PDT)
Received: from [172.30.1.36] ([14.32.163.5])
        by smtp.gmail.com with ESMTPSA id d18-20020aa78692000000b0062a515874b4sm1237790pfo.32.2023.03.23.07.17.44
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Mar 2023 07:17:49 -0700 (PDT)
Message-ID: <81425aaa-8c41-8d9d-ddc4-f951039bc516@gmail.com>
Date:   Thu, 23 Mar 2023 23:17:42 +0900
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH] dt-bindings: clock: Drop unneeded quotes
To:     Rob Herring <robh@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Chanwoo Choi <cw00.choi@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Orson Zhai <orsonzhai@gmail.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-renesas-soc@vger.kernel.org,
        linux-samsung-soc@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230322173549.3972106-1-robh@kernel.org>
From:   Chanwoo Choi <cwchoi00@gmail.com>
Content-Language: en-US
In-Reply-To: <20230322173549.3972106-1-robh@kernel.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=0.1 required=5.0 tests=DKIM_SIGNED,DKIM_VALID,
        DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,FREEMAIL_FROM,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23. 3. 23. 02:35, Rob Herring wrote:
> Cleanup bindings dropping unneeded quotes. Once all these are fixed,
> checking for this can be enabled in yamllint.
> 
> Signed-off-by: Rob Herring <robh@kernel.org>
> ---
>  Documentation/devicetree/bindings/clock/arm,syscon-icst.yaml  | 4 ++--
>  .../devicetree/bindings/clock/mediatek,apmixedsys.yaml        | 4 ++--
>  .../devicetree/bindings/clock/mediatek,topckgen.yaml          | 4 ++--
>  Documentation/devicetree/bindings/clock/renesas,cpg-mssr.yaml | 4 ++--
>  .../bindings/clock/renesas,rcar-usb2-clock-sel.yaml           | 4 ++--
>  .../devicetree/bindings/clock/renesas,rzg2l-cpg.yaml          | 4 ++--
>  .../devicetree/bindings/clock/samsung,exynos850-clock.yaml    | 2 +-
>  Documentation/devicetree/bindings/clock/sprd,sc9863a-clk.yaml | 4 ++--
>  Documentation/devicetree/bindings/clock/sprd,ums512-clk.yaml  | 4 ++--
>  .../devicetree/bindings/clock/xlnx,clocking-wizard.yaml       | 4 ++--
>  10 files changed, 19 insertions(+), 19 deletions(-)
Reviewed-by: Chanwoo Choi <cw00.choi@samsung.com>

-- 
Best Regards,
Samsung Electronics
Chanwoo Choi

