Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DCC7D5F7813
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Oct 2022 14:40:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229634AbiJGMkz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Oct 2022 08:40:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229461AbiJGMkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Oct 2022 08:40:53 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE4A334705;
        Fri,  7 Oct 2022 05:40:52 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id y8so4755714pfp.13;
        Fri, 07 Oct 2022 05:40:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:from:to:cc:subject:date:message-id:reply-to;
        bh=8Uu7yWAZWxiLWzHY9BD/Lt9mN4Tpbw2dRelGMiZO+a8=;
        b=nd2GABOL0IEul3UCIUjexdyczC1KPfjdDotG90uXkACruF1WMEZXe+UQAaGTlU1JGO
         qyhk6UaS7Z/EG1tJSF66z6/3MDnU/SkM+AuZa8MQNbZq7Jt1qfOWO2En3NSp7DOWqy+r
         +f4bfaKpVLzO2SCRURh+SCMSMx30wR8mJcgZeGD4AGLsoyFtOWfcxjmMF7E0sy5EwBlW
         35g8LjZYJ3EabahgbDlTnSiQFosKH1jO4yWc5FuFy/I8X+KwSkzSsE2TF/waZjCaeKIe
         zfw0/JKQIMmHMsYdsJ+NyIBaDcZ3ZkhGN0dZ6Q/A4KykisljXMktyivJn5ATG6t87o+8
         jhlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :sender:x-gm-message-state:from:to:cc:subject:date:message-id
         :reply-to;
        bh=8Uu7yWAZWxiLWzHY9BD/Lt9mN4Tpbw2dRelGMiZO+a8=;
        b=vyVeMiIuhAqozZrRcU0w1z/2Dckj3NZ+QqVxP9NYlLukuHdyNqOF2PvR1AtI3LzL41
         h07LUO/9xnk0IaFQxb+R/NbfjRjQiFyJGG/zepGsD+k39Zz+FIoa8QgUKDq9n8ZbwViR
         8VaPCQjkHKzvlN/XFJVefVe2budU6/dHwHiN+Hc+bw7gOibSMDXa2jyLSFyFdMjnGwc9
         1HSZEcCyMafolsAZ39eylzjVdMzkD3wyqUejNRjZLhdWNsHGWMPoRnccTDPp6IuLByOy
         PRT6rpmocC5bLw6btKKIxEUy0ccTn/uwFtxRFK6hWeWj8dnNtwy/O5dayp8gwh3ldiu+
         dvDA==
X-Gm-Message-State: ACrzQf2DR4pvPSXoHltFWUelXh+JXOrK+GZBBifRykJTsijVY35DIJW3
        B3x/YtPAp50IV+C814rBleY=
X-Google-Smtp-Source: AMsMyM5TKYHynqu8eOT8lXI2y+qMphUjeEqhVyZmCVj6KdAw7sPOYbEv75v9BVvOLepwwMy2nOJtiA==
X-Received: by 2002:a05:6a00:181f:b0:562:8e02:ec29 with SMTP id y31-20020a056a00181f00b005628e02ec29mr5215784pfa.3.1665146452356;
        Fri, 07 Oct 2022 05:40:52 -0700 (PDT)
Received: from ?IPV6:2600:1700:e321:62f0:329c:23ff:fee3:9d7c? ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id e10-20020a170902784a00b0017dd839f2a5sm1444995pln.38.2022.10.07.05.40.49
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 07 Oct 2022 05:40:50 -0700 (PDT)
Sender: Guenter Roeck <groeck7@gmail.com>
Message-ID: <8e801854-c272-1649-c9bb-0511b7b09b82@roeck-us.net>
Date:   Fri, 7 Oct 2022 05:40:48 -0700
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Subject: Re: [PATCH v2 8/8] dt-bindings: watchdog: mediatek,mtk-wdt: Add
 compatible for MT8173
Content-Language: en-US
To:     Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>, nfraprado@collabora.com
Cc:     angelogioacchino.delregno@collabora.com,
        Project_Global_Chrome_Upstream_Group@mediatek.com,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mediatek@lists.infradead.org
References: <20221007093437.12228-1-allen-kh.cheng@mediatek.com>
 <20221007093437.12228-9-allen-kh.cheng@mediatek.com>
From:   Guenter Roeck <linux@roeck-us.net>
In-Reply-To: <20221007093437.12228-9-allen-kh.cheng@mediatek.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/7/22 02:34, Allen-KH Cheng wrote:
> Add the mediatek,mt8173-wdt compatible using mediatek,mt6589-wdt as
> fallback.
> 
> Signed-off-by: Allen-KH Cheng <allen-kh.cheng@mediatek.com>
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Acked-by: Rob Herring <robh@kernel.org>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>

> ---
>   Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml | 1 +
>   1 file changed, 1 insertion(+)
> 
> diff --git a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> index 855cebc87fb0..c1633878e869 100644
> --- a/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> +++ b/Documentation/devicetree/bindings/watchdog/mediatek,mtk-wdt.yaml
> @@ -36,6 +36,7 @@ properties:
>                 - mediatek,mt7622-wdt
>                 - mediatek,mt7623-wdt
>                 - mediatek,mt7629-wdt
> +              - mediatek,mt8173-wdt
>                 - mediatek,mt8516-wdt
>             - const: mediatek,mt6589-wdt
>   

