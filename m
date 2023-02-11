Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A221E693077
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Feb 2023 12:43:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229898AbjBKLng (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Feb 2023 06:43:36 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230115AbjBKLnc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Feb 2023 06:43:32 -0500
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 95574311C9
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:43:30 -0800 (PST)
Received: by mail-wr1-x42c.google.com with SMTP id bk16so7637434wrb.11
        for <linux-kernel@vger.kernel.org>; Sat, 11 Feb 2023 03:43:30 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=ZbEkkR9nvAU97/4Y+LuXIp9nLp3oMVuz++HgxVysnT8=;
        b=XWPMKRudURMymzIF/gXm57vpMavb5AQQwD9lazHSDhOrNkuKEFD3Q1za4eXp6dzk8u
         1H6uU8ZUQuywwk6NeipUB4Q1BOM5RcgRPP3Iiv7fvzEYvclG8+K0nqS9VIse+XMpDqCg
         APwt16JoWa9YuG14tu2zQPXNni4lNmaKNo8ivxHaiXkZkgCBKT3mogAAG4HqnUyE84OA
         64TudziPfM2yrt6xsKsXQaoRLkV92XUgRsQdsXL6rYwp46BX4D6zEHd4DCZ+p2XEAEFG
         MlEBjVwGp13zXm5HVD7FMUNwr1X2XxDoFvSF/Nr0uD4xE+w6wd97c1bzALxOHC07CQFn
         CvaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=ZbEkkR9nvAU97/4Y+LuXIp9nLp3oMVuz++HgxVysnT8=;
        b=rfSGlKAux2J+Y+tzQ06MIt/6aBswpC1EvDDrZxAKcvOovgF34shvmBij+M3plrVweY
         zXsTI76xuO0Hp8xn+2peEb5DCiMoONggmF4NHONEmDh8D0XTwYH+6QwyLZoKxlHan+aM
         +1p1cQeSB/fiVo3owHpkN/LMaAJbPrUb8/iN4UxSAiUmBxEg8CTlZwNcf9WLA20QGJik
         Sblx64o3Ns6sbBypdgUYVWWZyWP/UrcXOuH4KzoL85nWYvyhzRconTOGisfmntowtWeG
         znaaWy8ij8+yLmqkI2deDuiEbr7k6M/pTFrsaqqt3Wwc2DzCesb1YTO/5AcAY6z0SAaR
         bQ6Q==
X-Gm-Message-State: AO0yUKU8ZXPEM7pb4PaaLoU9vAz/blMgWMMeKDwftCGB4uLbF/u13Prf
        Opu/uToxCJH5gd5sWjt395fEeQ==
X-Google-Smtp-Source: AK7set+AjZeAj5VRJRyZxpiwq2ZVhwNwNv5wzpMoz4GSz+5ElqCHNWci0n6sGer4zEtrfPcP41qJhA==
X-Received: by 2002:adf:e7ca:0:b0:2c5:4b22:bce9 with SMTP id e10-20020adfe7ca000000b002c54b22bce9mr3942693wrn.47.1676115809166;
        Sat, 11 Feb 2023 03:43:29 -0800 (PST)
Received: from [192.168.1.109] ([178.197.216.144])
        by smtp.gmail.com with ESMTPSA id n8-20020a5d4208000000b002b9b9445149sm5960625wrq.54.2023.02.11.03.43.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 11 Feb 2023 03:43:28 -0800 (PST)
Message-ID: <b2511c2e-a261-1af6-653d-6cde27c8327a@linaro.org>
Date:   Sat, 11 Feb 2023 12:43:26 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.7.1
Subject: Re: [PATCH 2/5] dt-bindings: arm64: dts: mediatek: Add rev4 of
 spherion
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Chen-Yu Tsai <wenst@chromium.org>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Allen-KH Cheng <allen-kh.cheng@mediatek.com>,
        Andrew Lunn <andrew@lunn.ch>,
        =?UTF-8?Q?Bernhard_Rosenkr=c3=a4nzer?= <bero@baylibre.com>,
        Frank Wunderlich <frank-w@public-files.de>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Sean Wang <sean.wang@mediatek.com>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230211002626.454844-1-nfraprado@collabora.com>
 <20230211002626.454844-3-nfraprado@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230211002626.454844-3-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/02/2023 01:26, Nícolas F. R. A. Prado wrote:
> Add binding for newer version of Google Spherion (Acer Chromebook 514):
> rev4.
> 
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> ---


Acked-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

