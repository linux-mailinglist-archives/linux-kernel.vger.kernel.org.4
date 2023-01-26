Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C258B67D045
	for <lists+linux-kernel@lfdr.de>; Thu, 26 Jan 2023 16:32:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232387AbjAZPc5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 Jan 2023 10:32:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232342AbjAZPc4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Jan 2023 10:32:56 -0500
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C632393F0
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:32:54 -0800 (PST)
Received: by mail-wm1-x331.google.com with SMTP id f25-20020a1c6a19000000b003da221fbf48so1382269wmc.1
        for <linux-kernel@vger.kernel.org>; Thu, 26 Jan 2023 07:32:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=x2DtWIPpTLIQ8C+gywhpHGRhGc3/mNomrJy1W49Sq1A=;
        b=KgzgTfZpE6hK1mWgepzyISXPkXP8x/G8JXTtkwpXboYIOqB6GJR5yYyOPl9/pJ22NC
         29PKCe2JmwPqgLqidpMMsKfD9A+f14TMlhFhIiEJvOGOAX7bdtVEhw1jMK6qWIqaekhg
         0dOApjm2qtgcAxc4QlESmFe4R+xZorXgDW0Hy+Vr8RoVkz4LT6SvXLoV0QFkbqXaqgu8
         qGRsqceUZrc6cIUfgQ20stb24YXIAYPGRCpg0nPc9AgjB3vfBc9OqDiKm1UAncjEubyP
         KG9Nq6FxTEiApyb9hQAL06wbrdIyCvbZX9PACAQWDctL3ZJs4bdzlYWA0hfONJmgpFE0
         85fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=x2DtWIPpTLIQ8C+gywhpHGRhGc3/mNomrJy1W49Sq1A=;
        b=uQhDjRXoW98STVU9wE6BzCV8xdUwnQR3GzZinW3f7Ax8pBKojJ9vC2kLry1au1Zpd6
         AirG49ia2N0bKRUMXHav8ATuHgWPROuadh60WFeCf3VntSKwz6kFsjCan2Ncka87Kehm
         ITnRhITL1jbBnFfjCKhMrDdt/fY4J369KOWXzHp/KN+E0YeFOSBrWMaGj7Y0SsGYVuR5
         pB1sNweWgvDPVqdSkiafX426MQOgua0DwbITlQ0Htv4klN7dCFnjff7RM/NsavGNLT13
         sZ0pz5MxS6r4pQmKSP39sQN7hyXorUY58eDWwXi1cMb9iZERGVb2rizxuz8e+MXg+sgc
         MAZA==
X-Gm-Message-State: AFqh2kqnYOPkXJQFWrGmA6NrRmq6IgaTOaTojGNlrMBZZLAOB0ba2seU
        hqed1EUVjsgUreSSzHkdE/BQ6Q==
X-Google-Smtp-Source: AMrXdXsqi25krBPlSUs5ENxJjNmAgCxXPeRBz6P/pTN/p+l4BDGKLDq95pWNDOquzcNuENVjQFJKcg==
X-Received: by 2002:a05:600c:4e8d:b0:3dc:b0e:1e44 with SMTP id f13-20020a05600c4e8d00b003dc0b0e1e44mr12505410wmq.4.1674747173394;
        Thu, 26 Jan 2023 07:32:53 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id x26-20020a1c7c1a000000b003db01178b62sm4947527wmc.40.2023.01.26.07.32.51
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Jan 2023 07:32:53 -0800 (PST)
Message-ID: <4bcf8191-fe6a-7229-9ebe-a79cebdce87e@linaro.org>
Date:   Thu, 26 Jan 2023 16:32:51 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.0
Subject: Re: [PATCH v2 2/6] dt-bindings: clock: mediatek,mt8186-fhctl: Support
 MT6795, MT8173/92/95
Content-Language: en-US
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, sboyd@kernel.org
Cc:     mturquette@baylibre.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        edward-jw.yang@mediatek.com, johnson.wang@mediatek.com,
        wenst@chromium.org, miles.chen@mediatek.com,
        chun-jie.chen@mediatek.com, rex-bc.chen@mediatek.com,
        jose.exposito89@gmail.com, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        kernel@collabora.com
References: <20230126085321.87267-1-angelogioacchino.delregno@collabora.com>
 <20230126085321.87267-3-angelogioacchino.delregno@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230126085321.87267-3-angelogioacchino.delregno@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26/01/2023 09:53, AngeloGioacchino Del Regno wrote:
> MT6795, MT8173, MT8192 and MT8195 support Frequency Hopping: add the
> compatibles for them.
> 
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> ---

... but you already had here an ack.

Best regards,
Krzysztof

