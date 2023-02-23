Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 04C616A05E9
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Feb 2023 11:21:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233652AbjBWKU7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Feb 2023 05:20:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234245AbjBWKUo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Feb 2023 05:20:44 -0500
Received: from mail-ed1-x531.google.com (mail-ed1-x531.google.com [IPv6:2a00:1450:4864:20::531])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03BEC515C6
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:20:41 -0800 (PST)
Received: by mail-ed1-x531.google.com with SMTP id cq23so39996741edb.1
        for <linux-kernel@vger.kernel.org>; Thu, 23 Feb 2023 02:20:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=5JZ+d4keOM3Q3zQN27hdiAOtmuIEuYd9JoJG8TNKmKg=;
        b=n7vK1uti/NJxOe2l5pgWT9fnzleJ4H03NITi75Q2bs5brLlwGt6RsM+ucCorwglL9U
         hX/eV5362EwCuFAcSZYB/qUT/5AuR+Ae2z/L32yPCdKtA8hzuYSJ94QQ6a+cMa8bDbrg
         LjjTw8FC8z3fmRp4qOCpQZmosXXb65XVuQgtjQpKH95GCYCbJ5pHKwWg24lQpWJfjxND
         pcqmEfmhueC7JrByWbZlaorKfQ+CAiQZ5r3CkxdFR7eGh6sQEvF7EwAecofYDqlSoY6e
         By3NtLox/iaZcp3cF4l/k9nLgPxZlXnIg/eBvvlJIjP0ZJo2n69bXrNwuSGMS7FZzjP+
         CniA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=5JZ+d4keOM3Q3zQN27hdiAOtmuIEuYd9JoJG8TNKmKg=;
        b=4oeTXbxspa2z62h2ojuXpQl56eoHk9wEGt8IJLs0j+Fkn+AoDAM1Z2GKZb7um8n4MH
         RKVfE/jWLUf6Mfa3ueqqtj/bgtxpKc5kY1Gxi1Hln/6LLIlXqi1hFbywCTzkXwn/mC3H
         9gGAfviduzTpc+UpsMUKymp81W4qwG/jtcoF2pfw2jBgX6XnPflvmOmFZZD4lqlz+qMm
         MVpTRmgFnEZIk9/MXmduaA8Oa/AOimyY69HIQ68thdZsDUyRPsTuA82kUN1r7fgNgEg4
         cpx0/8v0Klm58oCLZuILkKWT4vIxBoKGFSnvOSqQF29KuvP0WAK8DO7VUfA0eN13YhaH
         XDHA==
X-Gm-Message-State: AO0yUKVLiXy3wu1LJPG/wpZEmFNhEnbPkAm8BQo8OP367oiJX8+sSX+w
        82alJ8FcyWJkQg801qEpRc6U2w==
X-Google-Smtp-Source: AK7set93FtHW6w3W7U3tQiQ6L+JtvumwzgUUgSyJVkmq59feUx9y/URkmGf7hA4biCkBF+LMcfgelA==
X-Received: by 2002:a05:6402:b2f:b0:4ab:4be9:5dcf with SMTP id bo15-20020a0564020b2f00b004ab4be95dcfmr10929013edb.4.1677147639370;
        Thu, 23 Feb 2023 02:20:39 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id m21-20020a170906849500b008d269233bd4sm5010633ejx.204.2023.02.23.02.20.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 23 Feb 2023 02:20:38 -0800 (PST)
Message-ID: <ffa1d5ff-3046-95f5-062b-9833cc4f3127@linaro.org>
Date:   Thu, 23 Feb 2023 11:20:37 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.8.0
Subject: Re: [PATCH RFC 3/4] dt-bindings: clock: break out
 mediatek,filogic-apmixed
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, linux-clk@vger.kernel.org,
        linux-mediatek@lists.infradead.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Chen-Yu Tsai <wenst@chromium.org>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>,
        Miles Chen <miles.chen@mediatek.com>,
        Sam Shih <sam.shih@mediatek.com>
References: <cover.1677089171.git.daniel@makrotopia.org>
 <177707569882ff308d375aae3e2936a60ea483c7.1677089171.git.daniel@makrotopia.org>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <177707569882ff308d375aae3e2936a60ea483c7.1677089171.git.daniel@makrotopia.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/02/2023 19:09, Daniel Golle wrote:
> The apmixed clocks of MT7981 and MT7986 are identical. In order to
> de-duplicate both clock drivers, start with putting apmixed into a
> header files of its own, so it can be used by both SoCs.
> Propagate this change also to mt7986a.dtsi which is the only user.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---
>  arch/arm64/boot/dts/mediatek/mt7986a.dtsi     |  1 +
>  drivers/clk/mediatek/clk-mt7986-apmixed.c     |  2 +-
>  .../clock/mediatek,filogic-apmixed.h          | 21 +++++++++++++++++++
>  .../dt-bindings/clock/mediatek,mt7981-clk.h   | 10 ---------
>  .../dt-bindings/clock/mediatek,mt7986-clk.h   | 11 ----------
>  5 files changed, 23 insertions(+), 22 deletions(-)

Same comments as previous patch:
1. Too generic name.
2. Mixed code with bindings with DTS.

Best regards,
Krzysztof

