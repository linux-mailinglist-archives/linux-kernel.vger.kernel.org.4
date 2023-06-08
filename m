Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8E0C72794E
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Jun 2023 09:56:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233790AbjFHH4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Jun 2023 03:56:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46924 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233798AbjFHH4e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Jun 2023 03:56:34 -0400
Received: from mail-ed1-x52e.google.com (mail-ed1-x52e.google.com [IPv6:2a00:1450:4864:20::52e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E81832120
        for <linux-kernel@vger.kernel.org>; Thu,  8 Jun 2023 00:56:32 -0700 (PDT)
Received: by mail-ed1-x52e.google.com with SMTP id 4fb4d7f45d1cf-5149c76f4dbso518150a12.1
        for <linux-kernel@vger.kernel.org>; Thu, 08 Jun 2023 00:56:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google; t=1686210991; x=1688802991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc:subject:date:message-id:reply-to;
        bh=qbB0xd6Ry0dq/EUwrtpVYTX/9vI3J3IlZ8nKsAKcFys=;
        b=g/wq6BrlRS1cNZYAuGFoeGlt12YYhRA1phpG6vyWII5Cmb7tl+Dv9TrhWYedJMCeOL
         IYBx+Vfy/CzizH2j4g3ttNvnyz2uJpMYsFrvhfy9y5ffmroM+kfVvGEbCvPJimmNkCyy
         835jAz47QNG7whyEwF118Q1fMOldwVXs4M/LhdDu72Ncy+p7GS3JV1bsu8CarpCn122Q
         USLMU1Ml1mrEOlciZWBDk5BgAtvXYwnUGYFdYXzKHQfkWZsPPl6+A0bi00DQdbk4Xr/o
         E0z0o4My3CnkrC5vzF0nnuusMDfsr08o1iGgM4/OI9Zc+qhyoetuIOugxvg3Aux4Ql2D
         P9oA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20221208; t=1686210991; x=1688802991;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc:subject:date:message-id:reply-to;
        bh=qbB0xd6Ry0dq/EUwrtpVYTX/9vI3J3IlZ8nKsAKcFys=;
        b=AQ3cWzjiU37O+gGar12xBa++gO0BRJrPkNi4ddC+XoaITJNScSNivCnzLZhm4Pwqf3
         P6EuWSKfYlXhHSp6xBj3zLEoa4MPa1Hbb4SXswC80ZGbbNoL5EC/hgvNnp/vbdYj24PD
         9Pmb2NYMvHkLSXTfVFYrvenr3xducrlKpflmQfHfEW4/SXfkCnyg+WiDe9bVfDuY2D7h
         RgbjmhT5X6OJmMxJMMUSeOk24lcD0YJDkOljYYkbnlkObY9cIkrH19ILouurdkPmxMMU
         s9SRc14+QbP+fdl3iKRcyRdkVEP5kk5Q65EX0Rm6kFxEKLhmw0aRDRp/vP2ofO5NLGIk
         tutA==
X-Gm-Message-State: AC+VfDy44w2ZTXmhx0G7OjD9hdeFlnUwdgxwn/PBHZKn14EoRrXT1q/T
        W0TZDFwBuEKfERpf14ooszxzZQ==
X-Google-Smtp-Source: ACHHUZ77/ckL41yrT5rLCVmYFC0CptMhtYaSudwn5rglft7nJjnm4nUfaMEkIqEbduj4o8OyC6hKkA==
X-Received: by 2002:a17:907:961c:b0:96f:f046:9a92 with SMTP id gb28-20020a170907961c00b0096ff0469a92mr8989606ejc.37.1686210991390;
        Thu, 08 Jun 2023 00:56:31 -0700 (PDT)
Received: from [192.168.1.20] ([178.197.219.26])
        by smtp.gmail.com with ESMTPSA id e10-20020a1709062c0a00b0094f23480619sm345792ejh.172.2023.06.08.00.56.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 08 Jun 2023 00:56:31 -0700 (PDT)
Message-ID: <751e5a36-5313-7d5b-7c2d-55322f2850f4@linaro.org>
Date:   Thu, 8 Jun 2023 09:56:28 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.11.2
Subject: Re: [PATCH v1 2/6] dt-bindings: reset: mt8188: Add reset control bits
 for VDOSYS1
Content-Language: en-US
To:     =?UTF-8?B?U2hhd24gU3VuZyAo5a6L5a2d6KyZKQ==?= 
        <Shawn.Sung@mediatek.com>,
        "p.zabel@pengutronix.de" <p.zabel@pengutronix.de>,
        "matthias.bgg@gmail.com" <matthias.bgg@gmail.com>,
        "angelogioacchino.delregno@collabora.com" 
        <angelogioacchino.delregno@collabora.com>,
        "robh+dt@kernel.org" <robh+dt@kernel.org>,
        "krzysztof.kozlowski+dt@linaro.org" 
        <krzysztof.kozlowski+dt@linaro.org>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        =?UTF-8?B?U2luZ28gQ2hhbmcgKOW8teiIiOWciyk=?= 
        <Singo.Chang@mediatek.com>,
        "chunkuang.hu@kernel.org" <chunkuang.hu@kernel.org>,
        "devicetree@vger.kernel.org" <devicetree@vger.kernel.org>,
        =?UTF-8?B?SmFzb24tSkggTGluICjmnpfnnb/npaUp?= 
        <Jason-JH.Lin@mediatek.com>,
        =?UTF-8?B?TmFuY3kgTGluICjmnpfmrKPonqIp?= <Nancy.Lin@mediatek.com>,
        Project_Global_Chrome_Upstream_Group 
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        "fshao@google.com" <fshao@google.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
References: <20230607061121.6732-1-shawn.sung@mediatek.com>
 <20230607061121.6732-3-shawn.sung@mediatek.com>
 <72b71e37-f9e7-b182-824c-163d920723b8@collabora.com>
 <a769105743d480c0da846a4c50de43811382626e.camel@mediatek.com>
From:   Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>
In-Reply-To: <a769105743d480c0da846a4c50de43811382626e.camel@mediatek.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08/06/2023 05:01, Shawn Sung (宋孝謙) wrote:
> Hi AngeloGioacchino,
> 
> Should I use enum instead of #define if reset ID must starts from 0?

Open existing bindings (there are many, many files) which will give you
the answer. It will be faster than asking us and you will learn something.

Best regards,
Krzysztof

