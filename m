Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4A2AD7365CF
	for <lists+linux-kernel@lfdr.de>; Tue, 20 Jun 2023 10:11:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231782AbjFTILg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 20 Jun 2023 04:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34518 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231766AbjFTILT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 20 Jun 2023 04:11:19 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 679E81B0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:11:18 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id ffacd0b85a97d-311183ef595so4179155f8f.0
        for <linux-kernel@vger.kernel.org>; Tue, 20 Jun 2023 01:11:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1687248677; x=1689840677;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=XdyvTbKbtxFhVlxAUsNkcPNLTdItEsqylIYcTSmrmVw=;
        b=YKGzUefLgxKAL8ZEALam9+JDwZQfINLmjzcz4XsXQ9gevee+KgIbnSriINUMJ3XkN4
         t+Lx/HfIGMIKPiIi3r+82G8zlwxyuKx0CTa+/G58lalCDq4CMSuYmzU6wR6nX5EtPOAf
         n4csHx9o+NWks2zCzNdOKVtMmGuGOun+VniZf6l+8KIX9ne87GsSqDtP3ebv6BvTDvSW
         dm0AoCujSpRMDWo6zaHBgh9z4lVGTZs5mhyj7Dwd2080v/qUla4jMxiqQyUpsiZkMJCP
         jsKYdsNJ62bku+qh2FgI+r2/WzZSheLudch+ZXirXHahmTzzixijR0ec49KBMz5FnAEA
         Ajcw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1687248677; x=1689840677;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=XdyvTbKbtxFhVlxAUsNkcPNLTdItEsqylIYcTSmrmVw=;
        b=D7Sm8oO+FNvQ6+F0tGE0qOaaEEOA5vc3NM3SGqBp+leFEimcFWzxdaVB/eo1pSGD+m
         NqAF+2fFiFHmPXY6EgXpy4OfX6k2ebM00p8pb0N9AbadCymnvNWuSSAjezcZVrAe4uB9
         /KMHH4DlV1/tzoa16SN78nbpupMRGnoEVaU3/mvLDklt57Znk8UWeeOjUfC+yeIknTqG
         iB3YlVv4u7jTp/7v+qr6aCygpVpMr2SUwBhXnd0aHO/CGS/kSIUYMZlR4MsvvcomOAsp
         UNC41V9QuNxH5TLzE3ClOwJBH1CJ0PMwbPM2j1ZIAh+5xmvRsqTY3MEJJm6vHvjaoC+J
         LUbQ==
X-Gm-Message-State: AC+VfDwpikox1nJbvzplrdcjOlNHRqRH1XoYK/mLh4AuIT+4tOF15gmk
        Z9lxDJ+8Rcm04x5kbrB+dTFI5Q==
X-Google-Smtp-Source: ACHHUZ5cdhpOJNZAgxuoKeMYSqVchTg56R1O3JGrDeBzA2TRG8isJFpUv0+JvTtzb9gqVGSbosBGrQ==
X-Received: by 2002:a5d:44cf:0:b0:310:4fa3:5b0f with SMTP id z15-20020a5d44cf000000b003104fa35b0fmr8696296wrr.69.1687248676928;
        Tue, 20 Jun 2023 01:11:16 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id l14-20020adfe58e000000b0030fd03e3d25sm1383032wrm.75.2023.06.20.01.11.15
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 20 Jun 2023 01:11:16 -0700 (PDT)
Message-ID: <c6183e35-2e3b-624c-dd97-05a0cb1a7c3f@linaro.org>
Date:   Tue, 20 Jun 2023 10:11:14 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.12.0
Subject: Re: [PATCH v3 1/6] media: dt-bindings: mediatek,vcodec: Allow single
 clock for mt8183
Content-Language: en-US
To:     =?UTF-8?B?TsOtY29sYXMgRi4gUi4gQS4gUHJhZG8=?= 
        <nfraprado@collabora.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Hans Verkuil <hverkuil-cisco@xs4all.nl>
Cc:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>, kernel@collabora.com,
        Andrew-CT Chen <andrew-ct.chen@mediatek.com>,
        Conor Dooley <conor+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Tiffany Lin <tiffany.lin@mediatek.com>,
        Yunfei Dong <yunfei.dong@mediatek.com>,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-media@vger.kernel.org,
        linux-mediatek@lists.infradead.org
References: <20230620000349.2122191-1-nfraprado@collabora.com>
 <20230620000349.2122191-2-nfraprado@collabora.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <20230620000349.2122191-2-nfraprado@collabora.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/06/2023 02:03, Nícolas F. R. A. Prado wrote:
> MT8173 and MT8183 have different clocks, and consequently clock-names.
> Relax the number of clocks and set clock-names based on compatible.
> 
> Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
> Reviewed-by: Matthias Brugger <matthias.bgg@gmail.com>
> Signed-off-by: Nícolas F. R. A. Prado <nfraprado@collabora.com>
> 
> ---


Reviewed-by: Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>

Best regards,
Krzysztof

