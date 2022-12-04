Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DB45641DED
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Dec 2022 17:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229950AbiLDQdv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Dec 2022 11:33:51 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230050AbiLDQdt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Dec 2022 11:33:49 -0500
Received: from mail-wr1-x42b.google.com (mail-wr1-x42b.google.com [IPv6:2a00:1450:4864:20::42b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2DC7D10FEB
        for <linux-kernel@vger.kernel.org>; Sun,  4 Dec 2022 08:33:48 -0800 (PST)
Received: by mail-wr1-x42b.google.com with SMTP id m14so15287665wrh.7
        for <linux-kernel@vger.kernel.org>; Sun, 04 Dec 2022 08:33:48 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=s73rXHrAxMtPGwi99sqcpRgefCBmkZ6Y/H/iMaBpQ54=;
        b=VliLnHpQFPE4eTiC/g9R2V8fggkR7Urm96PGlq5uxnjmmudbCGbG+4VrsfGEr6DLJT
         mGztrPDB0LTXJDXEB/1ZQat9oijOqk9KZVtxhXvunbZsrCacO6IjQWCjPAwyf0LieES3
         v7K4z5yZry6jJ6GX8bj1EtM78z629aL7r4WdGrTu3EcD5MG7xpwFS7AmitiGkljykrL+
         rWSDc8sMYsxGrI66yL7ywBnffSPz7da0YKS+Ob7VoshG4MryemHfyu7C1yo/dYuH/+xg
         knXfyhBu06+PxM34s2nj4j2HLopB1HTGOIPnujpKhOtq1i8Wz8FkvqiduwkCEA72Q86p
         qw1w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=s73rXHrAxMtPGwi99sqcpRgefCBmkZ6Y/H/iMaBpQ54=;
        b=C0y7nOdlfmYOKcSFQW+PykJXFwFEpS+giyYlxrmb1E5E79FYhx6c7ATfCbMV/VCKdK
         A2BXgPoQBWvgYnpb/mUB6m2BhpT1MVUm92jxS3SnBWDChr9ngO7wItRw9LXY7dE94DWs
         JsPRZc9MW9VmzD+v9icJ/c3TFKa9sLxCujOe13JhzoSqb30VJZfchMe6+7RLiOrHHu+W
         OuGq8f/EVH4Pq19cMSVDmnm9W3VW7b7DoKD2Z0xPxSpDarTVv6vhxzy+vxs/+o/Tq2PQ
         m2SiADJy8m2Kl6qRlp3WQt8HxEAV9cIPfCB1LFn5R+ggK1lMBwVqbCIPLnMy251LXZCq
         66CA==
X-Gm-Message-State: ANoB5pn7vz8+oJjZfdsZZC1Fg6xRv22y4B71fT1U2hjv5DmUx2/v2pE4
        Ud8V2Lb/k5dfokRHiTY0MtzT35bwRAuPawQE
X-Google-Smtp-Source: AA0mqf5e3/VxCpvgJ7AtNfqqg/dDz6G+esrs6P1IJNGNclRmlGo8zfq6HOayTGeXqwkxJZAIM4EyBw==
X-Received: by 2002:a5d:5712:0:b0:242:4bac:a100 with SMTP id a18-20020a5d5712000000b002424baca100mr5182569wrv.117.1670171626706;
        Sun, 04 Dec 2022 08:33:46 -0800 (PST)
Received: from [192.168.10.46] (146725694.box.freepro.com. [130.180.211.218])
        by smtp.googlemail.com with ESMTPSA id h20-20020a05600c351400b003c6cd82596esm21828797wmq.43.2022.12.04.08.33.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 04 Dec 2022 08:33:46 -0800 (PST)
Message-ID: <b31c5497-2f14-8a5b-0980-72fb6a87e227@linaro.org>
Date:   Sun, 4 Dec 2022 17:33:44 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.4.2
Subject: Re: [PATCH v2 2/2] dt-bindings: thermal: mediatek: add compatible
 string for MT7986 and MT7981 SoC
Content-Language: en-US
To:     Daniel Golle <daniel@makrotopia.org>, linux-pm@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Amit Kucheria <amitk@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Zhang Rui <rui.zhang@intel.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Rob Herring <robh+dt@kernel.org>
Cc:     Steven Liu <steven.liu@mediatek.com>,
        Henry Yen <Henry.Yen@mediatek.com>
References: <Y4dYpoVBmKZSaX2q@makrotopia.org>
From:   Daniel Lezcano <daniel.lezcano@linaro.org>
In-Reply-To: <Y4dYpoVBmKZSaX2q@makrotopia.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=1.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_SBL_CSS,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/11/2022 14:20, Daniel Golle wrote:
> Document compatible string 'mediatek,mt7986-thermal' for V3 thermal
> unit found in MT7986 SoCs.
> 'mediatek,mt7981-thermal' is also added as it is identical with the
> thermal unit of MT7986.
> 
> Signed-off-by: Daniel Golle <daniel@makrotopia.org>
> ---

Applied, thanks

-- 
<http://www.linaro.org/> Linaro.org │ Open source software for ARM SoCs

Follow Linaro:  <http://www.facebook.com/pages/Linaro> Facebook |
<http://twitter.com/#!/linaroorg> Twitter |
<http://www.linaro.org/linaro-blog/> Blog

